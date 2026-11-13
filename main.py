
from pathlib import Path
from pyswip import Prolog


class AcademicAdvisor:

    def __init__(self):
        self.prolog = Prolog()

        knowledge_file = Path(__file__).resolve().with_name("knowledge_base.pl")

        if not knowledge_file.exists():
            raise FileNotFoundError("knowledge_base.pl not found")

        self.prolog.consult(str(knowledge_file))
        print("Prolog knowledge base loaded successfully.")

    @staticmethod
    def _text(value):
        if isinstance(value, bytes):
            return value.decode("utf-8")
        return str(value)

    def get_options(self, option_type):
        rows = list(self.prolog.query(
            f"option({option_type}, Atom, Label)"
        ))
        return [
            (self._text(row["Atom"]), self._text(row["Label"]))
            for row in rows
        ]

    def get_abilities(self):
        rows = list(self.prolog.query(
            "ability_option(Atom, Label)"
        ))
        return [
            (self._text(row["Atom"]), self._text(row["Label"]))
            for row in rows
        ]

    def _option_map(self, option_type):
        return {
            label: atom
            for atom, label in self.get_options(option_type)
        }

    def update_student_profile(self, profile):
        list(self.prolog.query("clear_student_profile"))

        mappings = [
            ("subjects", "subject", "student_subject"),
            ("career_interests", "career", "student_career_interest"),
            ("work_preferences", "work", "student_work_preference"),
            ("work_environment", "environment", "student_environment"),
            ("career_goals", "goal", "student_goal")
        ]

        for profile_key, option_type, predicate in mappings:
            label_to_atom = self._option_map(option_type)

            for label in profile[profile_key]:
                if label not in label_to_atom:
                    raise ValueError(f"Unknown option: {label}")

                atom = label_to_atom[label]
                list(self.prolog.query(
                    f"assertz({predicate}({atom}))"
                ))

        ability_map = {
            label: atom
            for atom, label in self.get_abilities()
        }

        for label, rating in profile["abilities"].items():
            if label not in ability_map:
                raise ValueError(f"Unknown ability: {label}")

            atom = ability_map[label]
            list(self.prolog.query(
                f"assertz(student_ability({atom}, {int(rating)}))"
            ))

        learning_map = self._option_map("learning_style")
        learning_atom = learning_map[profile["learning_style"]]

        list(self.prolog.query(
            f"assertz(student_learning_style({learning_atom}))"
        ))

    def get_recommendations(self):
        results = list(self.prolog.query("field_score(Field, Score)"))
        recommendations = []

        for row in results:
            field_atom = self._text(row["Field"])
            score = int(row["Score"])

            details = list(self.prolog.query(
                f"field({field_atom}, Description)"
            ))

            labels = list(self.prolog.query(
                f"field_label({field_atom}, Label)"
            ))

            if not details or not labels:
                continue

            evidence_rows = list(self.prolog.query(
                f"field_evidence({field_atom}, Type, Value, Points)"
            ))

            evidence = [
                (
                    self._text(item["Type"]),
                    self._text(item["Value"]),
                    int(item["Points"])
                )
                for item in evidence_rows
            ]

            subjects = [
                self._text(item["Subject"])
                for item in self.prolog.query(
                    f"related_subject({field_atom}, Subject)"
                )
            ]

            careers = [
                self._text(item["Career"])
                for item in self.prolog.query(
                    f"leads_to_career({field_atom}, Career)"
                )
            ]

            recommendations.append({
                "atom": field_atom,
                "name": self._text(labels[0]["Label"]),
                "description": self._text(details[0]["Description"]),
                "score": score,
                "evidence": evidence,
                "subjects": subjects,
                "careers": careers
            })

        recommendations.sort(
            key=lambda item: item["score"],
            reverse=True
        )

        return recommendations


def display_header(title):
    print("\n" + "=" * 76)
    print(f"{title:^76}")
    print("=" * 76)


def get_rating(title):
    print(f"\n{title}")
    print("1 = Very Weak | 2 = Weak | 3 = Average")
    print("4 = Strong    | 5 = Excellent")

    while True:
        try:
            value = int(input("Rating (1-5): "))

            if 1 <= value <= 5:
                return value

            print("Enter a rating between 1 and 5.")

        except ValueError:
            print("Enter a valid number.")


def select_multiple(title, options, minimum=1, maximum=None):
    print(f"\n{title}")
    print("-" * 76)

    for index, option in enumerate(options, 1):
        print(f"{index:2}. {option}")

    print(f"Select at least {minimum} options.")

    if maximum is not None:
        print(f"Select no more than {maximum} options.")

    print("Enter numbers separated by commas.")

    while True:
        try:
            answer = input("Your choices: ").strip()
            numbers = [int(item.strip()) for item in answer.split(",")]

            if len(numbers) != len(set(numbers)):
                print("Duplicate selections are not allowed.")
                continue

            if any(number < 1 or number > len(options) for number in numbers):
                print("Invalid option number.")
                continue

            if len(numbers) < minimum:
                print(f"Select at least {minimum} options.")
                continue

            if maximum is not None and len(numbers) > maximum:
                print(f"Select maximum {maximum} options.")
                continue

            return [options[number - 1] for number in numbers]

        except ValueError:
            print("Example: 1, 3, 5")


def select_one(title, options):
    print(f"\n{title}")

    for index, option in enumerate(options, 1):
        print(f"{index:2}. {option}")

    while True:
        try:
            choice = int(input("Choose one option: "))

            if 1 <= choice <= len(options):
                return options[choice - 1]

            print("Invalid selection.")

        except ValueError:
            print("Enter a valid number.")


def collect_profile(advisor):
    display_header("INTELLIGENT ACADEMIC ADVISOR")

    print("Discover academic pathways based on your abilities,")
    print("interests, preferences and future goals.")

    display_header("1. ABILITY ASSESSMENT")

    abilities = {}

    for atom, label in advisor.get_abilities():
        abilities[label] = get_rating(label)

    display_header("2. ACADEMIC INTERESTS")

    subjects = select_multiple(
        "Which subjects do you enjoy most?",
        [label for atom, label in advisor.get_options("subject")],
        2,
        5
    )

    display_header("3. CAREER INTERESTS")

    careers = select_multiple(
        "Which career areas interest you?",
        [label for atom, label in advisor.get_options("career")],
        2,
        5
    )

    display_header("4. WORK PREFERENCES")

    work = select_multiple(
        "Which types of work appeal to you?",
        [label for atom, label in advisor.get_options("work")],
        3,
        6
    )

    display_header("5. LEARNING STYLE")

    learning_style = select_one(
        "Which learning approach do you prefer?",
        [label for atom, label in advisor.get_options("learning_style")]
    )

    display_header("6. WORK ENVIRONMENT")

    environments = select_multiple(
        "Which environments appeal to you?",
        [label for atom, label in advisor.get_options("environment")],
        2,
        4
    )

    display_header("7. CAREER GOALS")

    goals = select_multiple(
        "What are your most important career goals?",
        [label for atom, label in advisor.get_options("goal")],
        2,
        5
    )

    return {
        "abilities": abilities,
        "subjects": subjects,
        "career_interests": careers,
        "work_preferences": work,
        "learning_style": learning_style,
        "work_environment": environments,
        "career_goals": goals
    }


def display_report(profile, recommendations):
    if not recommendations:
        print("No recommendations returned by Prolog.")
        return

    top_five = recommendations[:5]
    maximum_score = top_five[0]["score"]

    def percentage(score):
        if maximum_score <= 0:
            return 0
        return round(score / maximum_score * 100)

    first_score = top_five[0]["score"]
    second_score = top_five[1]["score"] if len(top_five) > 1 else 0
    difference = first_score - second_score

    if difference >= 20:
        confidence = "Very High score separation"
    elif difference >= 12:
        confidence = "High score separation"
    elif difference >= 6:
        confidence = "Moderate score separation"
    else:
        confidence = "Exploratory - several pathways may fit"

    display_header("PERSONALIZED ACADEMIC ADVISORY REPORT")

    print(f"\nRecommendation score separation: {confidence}")
    print("Scores are rule-based matching scores, not probabilities.")

    reason_text = {
        "subject": "Academic subject interest matches.",
        "career": "Career interest matches.",
        "work": "Preferred work activity matches.",
        "environment": "Preferred work environment matches.",
        "goal": "Career goal matches.",
        "ability": "Ability rating contributes to this pathway."
    }

    display_header("TOP FIVE ACADEMIC PATHWAYS")

    for position, item in enumerate(top_five, 1):
        print(f"\n{position}. {item['name']}")
        print(f"   Prolog score: {item['score']}")
        print(f"   Relative match score: {percentage(item['score'])}%")
        print(f"   {item['description']}")

        if item["evidence"]:
            print("   Why it matches:")

            for kind, value, points in item["evidence"]:
                readable_value = value.replace("_", " ").title()

                if kind == "ability":
                    print(f"   - {readable_value}: {points} points.")
                else:
                    print(
                        f"   - {readable_value}: "
                        f"{reason_text.get(kind, 'Matching evidence found')}"
                    )

    best = top_five[0]

    display_header("PRIMARY RECOMMENDATION")

    print(f"\nRecommended pathway: {best['name']}")
    print(best["description"])
    print(f"\nProlog score: {best['score']}")
    print(f"Relative match score: {percentage(best['score'])}%")

    print("\nRelated academic subjects:")

    for subject in best["subjects"]:
        print(f"  - {subject.replace('_', ' ').title()}")

    print("\nPotential career pathways:")

    for career in best["careers"]:
        print(f"  - {career.replace('_', ' ').title()}")

    print("\nPreferred learning style:")
    print(f"  - {profile['learning_style']}")

    display_header("ALTERNATIVE PATHWAYS")

    for position, item in enumerate(top_five[1:], 2):
        print(
            f"{position}. {item['name']} "
            f"({percentage(item['score'])}% relative match)"
        )

    display_header("PERSONALIZED NEXT STEPS")

    print(f"\nExplore: {best['name']}")

    for subject in best["subjects"][:3]:
        print(
            f"  - Explore {subject.replace('_', ' ').title()} "
            "through introductory material."
        )

    print("  - Review the listed careers and their entry requirements.")
    print("  - Try a small practical activity in the recommended field.")
    print("  - Compare alternative pathways before deciding.")

    display_header("END OF REPORT")


def main():
    try:
        advisor = AcademicAdvisor()
        profile = collect_profile(advisor)

        advisor.update_student_profile(profile)

        recommendations = advisor.get_recommendations()

        display_report(profile, recommendations)

    except Exception as error:
        print("\nCould not run the Academic Advisor.")
        print(f"Error: {error}")
        print("Check SWI-Prolog, PySwip and knowledge_base.pl.")


if __name__ == "__main__":
    main()
