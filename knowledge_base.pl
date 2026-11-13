
:- use_module(library(lists)).

:- dynamic student_subject/1.
:- dynamic student_career_interest/1.
:- dynamic student_work_preference/1.
:- dynamic student_environment/1.
:- dynamic student_goal/1.
:- dynamic student_ability/2.
:- dynamic student_learning_style/1.

ability_option(mathematics, 'Mathematics').
ability_option(science, 'Science').
ability_option(language, 'Language').
ability_option(communication, 'Communication').
ability_option(analytical, 'Analytical Thinking').
ability_option(creativity, 'Creativity').
ability_option(leadership, 'Leadership').
ability_option(empathy, 'Empathy').
ability_option(organization, 'Organization').

option(subject, mathematics, 'Mathematics').
option(subject, biology, 'Biology').
option(subject, chemistry, 'Chemistry').
option(subject, physics, 'Physics').
option(subject, computer_science, 'Computer Science').
option(subject, programming, 'Programming').
option(subject, statistics, 'Statistics').
option(subject, business, 'Business Studies').
option(subject, economics, 'Economics').
option(subject, psychology, 'Psychology').
option(subject, literature, 'Literature').
option(subject, arts, 'Arts').
option(subject, law, 'Law').
option(subject, social_science, 'Social Science').

option(career, technology, 'Technology').
option(career, healthcare, 'Healthcare').
option(career, engineering, 'Engineering').
option(career, business, 'Business').
option(career, research, 'Research').
option(career, education, 'Education').
option(career, law, 'Law').
option(career, creative_industry, 'Creative Industry').
option(career, government, 'Government Services').

option(work, problem_solving, 'Problem Solving').
option(work, working_with_numbers, 'Working With Numbers').
option(work, working_with_technology, 'Working With Technology').
option(work, helping_people, 'Helping People').
option(work, working_with_people, 'Working With People').
option(work, working_in_laboratories, 'Working in Laboratories').
option(work, building_or_designing_things, 'Building or Designing Things').
option(work, research_and_analysis, 'Research and Analysis').
option(work, teaching, 'Teaching').
option(work, creative_work, 'Creative Work').
option(work, managing_teams, 'Managing Teams').

option(learning_style, visual, 'Visual Learning').
option(learning_style, practical, 'Practical Learning').
option(learning_style, reading, 'Reading and Writing').
option(learning_style, auditory, 'Auditory Learning').
option(learning_style, collaborative, 'Collaborative Learning').

option(environment, office, 'Office').
option(environment, laboratory, 'Laboratory').
option(environment, hospital, 'Hospital').
option(environment, flexible_remote, 'Flexible or Remote').
option(environment, outdoor, 'Outdoor').
option(environment, classroom, 'Classroom').
option(environment, technology_software_environment, 'Technology and Software Environment').
option(environment, business_environment, 'Business Environment').
option(environment, courtroom, 'Courtroom').

option(goal, high_income, 'High Income').
option(goal, job_stability, 'Job Stability').
option(goal, intellectual_challenge, 'Intellectual Challenge').
option(goal, helping_society, 'Helping Society').
option(goal, international_opportunities, 'International Opportunities').
option(goal, entrepreneurship, 'Entrepreneurship').
option(goal, work_life_balance, 'Work-Life Balance').
option(goal, professional_growth, 'Professional Growth').

clear_student_profile :-
    retractall(student_subject(_)),
    retractall(student_career_interest(_)),
    retractall(student_work_preference(_)),
    retractall(student_environment(_)),
    retractall(student_goal(_)),
    retractall(student_ability(_, _)),
    retractall(student_learning_style(_)).

field(medicine_and_healthcare, 'Focuses on human health, disease prevention, diagnosis and patient care.').
field_label(medicine_and_healthcare, 'Medicine and Healthcare').

related_subject(medicine_and_healthcare, biology).
related_subject(medicine_and_healthcare, chemistry).
related_subject(medicine_and_healthcare, anatomy).
related_subject(medicine_and_healthcare, physiology).
related_subject(medicine_and_healthcare, medical_science).

leads_to_career(medicine_and_healthcare, doctor).
leads_to_career(medicine_and_healthcare, dentist).
leads_to_career(medicine_and_healthcare, medical_researcher).
leads_to_career(medicine_and_healthcare, healthcare_professional).

subject_match(medicine_and_healthcare, biology).
subject_match(medicine_and_healthcare, chemistry).
career_match(medicine_and_healthcare, healthcare).
work_match(medicine_and_healthcare, helping_people).
work_match(medicine_and_healthcare, working_with_people).
work_match(medicine_and_healthcare, working_in_laboratories).
environment_match(medicine_and_healthcare, hospital).
environment_match(medicine_and_healthcare, laboratory).
goal_match(medicine_and_healthcare, helping_society).
goal_match(medicine_and_healthcare, intellectual_challenge).
goal_match(medicine_and_healthcare, job_stability).

ability_weight(medicine_and_healthcare, science, 3).
ability_weight(medicine_and_healthcare, empathy, 3).
ability_weight(medicine_and_healthcare, communication, 2).

field(engineering, 'Applies mathematics and science to design, build and improve systems.').
field_label(engineering, 'Engineering').

related_subject(engineering, mathematics).
related_subject(engineering, physics).
related_subject(engineering, programming).
related_subject(engineering, design).
related_subject(engineering, engineering).

leads_to_career(engineering, mechanical_engineer).
leads_to_career(engineering, civil_engineer).
leads_to_career(engineering, electrical_engineer).
leads_to_career(engineering, engineering_researcher).

subject_match(engineering, mathematics).
subject_match(engineering, physics).
subject_match(engineering, computer_science).
career_match(engineering, engineering).
career_match(engineering, technology).
work_match(engineering, working_with_numbers).
work_match(engineering, building_or_designing_things).
work_match(engineering, problem_solving).
environment_match(engineering, office).
environment_match(engineering, laboratory).
environment_match(engineering, technology_software_environment).
goal_match(engineering, intellectual_challenge).
goal_match(engineering, high_income).
goal_match(engineering, international_opportunities).

ability_weight(engineering, mathematics, 3).
ability_weight(engineering, science, 3).
ability_weight(engineering, analytical, 2).
ability_weight(engineering, creativity, 1).

field(computer_science_and_ai, 'Focuses on computing, software development, artificial intelligence and digital technologies.').
field_label(computer_science_and_ai, 'Computer Science and AI').

related_subject(computer_science_and_ai, computer_science).
related_subject(computer_science_and_ai, mathematics).
related_subject(computer_science_and_ai, programming).
related_subject(computer_science_and_ai, artificial_intelligence).
related_subject(computer_science_and_ai, data_science).

leads_to_career(computer_science_and_ai, software_engineer).
leads_to_career(computer_science_and_ai, ai_engineer).
leads_to_career(computer_science_and_ai, data_scientist).
leads_to_career(computer_science_and_ai, technology_researcher).

subject_match(computer_science_and_ai, computer_science).
subject_match(computer_science_and_ai, mathematics).
subject_match(computer_science_and_ai, programming).
subject_match(computer_science_and_ai, statistics).
career_match(computer_science_and_ai, technology).
career_match(computer_science_and_ai, research).
work_match(computer_science_and_ai, working_with_technology).
work_match(computer_science_and_ai, working_with_numbers).
work_match(computer_science_and_ai, problem_solving).
work_match(computer_science_and_ai, research_and_analysis).
environment_match(computer_science_and_ai, technology_software_environment).
environment_match(computer_science_and_ai, office).
environment_match(computer_science_and_ai, flexible_remote).
goal_match(computer_science_and_ai, high_income).
goal_match(computer_science_and_ai, intellectual_challenge).
goal_match(computer_science_and_ai, international_opportunities).
goal_match(computer_science_and_ai, professional_growth).

ability_weight(computer_science_and_ai, mathematics, 3).
ability_weight(computer_science_and_ai, analytical, 3).
ability_weight(computer_science_and_ai, creativity, 2).

field(data_science_and_statistics, 'Uses mathematics, statistics and data to identify patterns and support decisions.').
field_label(data_science_and_statistics, 'Data Science and Statistics').

related_subject(data_science_and_statistics, mathematics).
related_subject(data_science_and_statistics, statistics).
related_subject(data_science_and_statistics, computer_science).
related_subject(data_science_and_statistics, economics).
related_subject(data_science_and_statistics, data_analysis).

leads_to_career(data_science_and_statistics, data_scientist).
leads_to_career(data_science_and_statistics, data_analyst).
leads_to_career(data_science_and_statistics, statistician).
leads_to_career(data_science_and_statistics, machine_learning_engineer).

subject_match(data_science_and_statistics, mathematics).
subject_match(data_science_and_statistics, statistics).
subject_match(data_science_and_statistics, computer_science).
subject_match(data_science_and_statistics, economics).
career_match(data_science_and_statistics, technology).
career_match(data_science_and_statistics, research).
career_match(data_science_and_statistics, business).
work_match(data_science_and_statistics, working_with_numbers).
work_match(data_science_and_statistics, problem_solving).
work_match(data_science_and_statistics, research_and_analysis).
environment_match(data_science_and_statistics, office).
environment_match(data_science_and_statistics, technology_software_environment).
environment_match(data_science_and_statistics, flexible_remote).
goal_match(data_science_and_statistics, high_income).
goal_match(data_science_and_statistics, intellectual_challenge).
goal_match(data_science_and_statistics, professional_growth).

ability_weight(data_science_and_statistics, mathematics, 3).
ability_weight(data_science_and_statistics, analytical, 3).
ability_weight(data_science_and_statistics, science, 1).

field(business_and_management, 'Focuses on business operations, management, finance, entrepreneurship and organizational decision-making.').
field_label(business_and_management, 'Business and Management').

related_subject(business_and_management, business).
related_subject(business_and_management, economics).
related_subject(business_and_management, mathematics).
related_subject(business_and_management, finance).

leads_to_career(business_and_management, business_manager).
leads_to_career(business_and_management, entrepreneur).
leads_to_career(business_and_management, financial_analyst).
leads_to_career(business_and_management, marketing_manager).

subject_match(business_and_management, business).
subject_match(business_and_management, economics).
subject_match(business_and_management, mathematics).
career_match(business_and_management, business).
career_match(business_and_management, government).
work_match(business_and_management, managing_teams).
work_match(business_and_management, working_with_numbers).
work_match(business_and_management, working_with_people).
work_match(business_and_management, problem_solving).
environment_match(business_and_management, office).
environment_match(business_and_management, business_environment).
goal_match(business_and_management, high_income).
goal_match(business_and_management, entrepreneurship).
goal_match(business_and_management, job_stability).
goal_match(business_and_management, professional_growth).

ability_weight(business_and_management, mathematics, 2).
ability_weight(business_and_management, leadership, 3).
ability_weight(business_and_management, communication, 2).
ability_weight(business_and_management, organization, 2).

field(law_and_public_service, 'Involves legal systems, public policy, justice and protecting individual and social rights.').
field_label(law_and_public_service, 'Law and Public Service').

related_subject(law_and_public_service, law).
related_subject(law_and_public_service, social_science).
related_subject(law_and_public_service, literature).
related_subject(law_and_public_service, psychology).

leads_to_career(law_and_public_service, lawyer).
leads_to_career(law_and_public_service, legal_advisor).
leads_to_career(law_and_public_service, civil_servant).
leads_to_career(law_and_public_service, policy_analyst).

subject_match(law_and_public_service, law).
subject_match(law_and_public_service, social_science).
subject_match(law_and_public_service, literature).
career_match(law_and_public_service, law).
career_match(law_and_public_service, government).
career_match(law_and_public_service, education).
work_match(law_and_public_service, helping_people).
work_match(law_and_public_service, working_with_people).
work_match(law_and_public_service, research_and_analysis).
work_match(law_and_public_service, managing_teams).
environment_match(law_and_public_service, courtroom).
environment_match(law_and_public_service, office).
goal_match(law_and_public_service, helping_society).
goal_match(law_and_public_service, job_stability).
goal_match(law_and_public_service, intellectual_challenge).

ability_weight(law_and_public_service, language, 3).
ability_weight(law_and_public_service, communication, 3).
ability_weight(law_and_public_service, analytical, 2).
ability_weight(law_and_public_service, leadership, 1).

field(education_and_teaching, 'Focuses on learning, teaching, educational development and sharing knowledge.').
field_label(education_and_teaching, 'Education and Teaching').

related_subject(education_and_teaching, literature).
related_subject(education_and_teaching, psychology).
related_subject(education_and_teaching, mathematics).
related_subject(education_and_teaching, social_science).

leads_to_career(education_and_teaching, teacher).
leads_to_career(education_and_teaching, professor).
leads_to_career(education_and_teaching, educational_researcher).
leads_to_career(education_and_teaching, academic_counsellor).

subject_match(education_and_teaching, literature).
subject_match(education_and_teaching, psychology).
subject_match(education_and_teaching, social_science).
subject_match(education_and_teaching, mathematics).
career_match(education_and_teaching, education).
career_match(education_and_teaching, research).
work_match(education_and_teaching, teaching).
work_match(education_and_teaching, helping_people).
work_match(education_and_teaching, working_with_people).
work_match(education_and_teaching, creative_work).
environment_match(education_and_teaching, classroom).
environment_match(education_and_teaching, office).
goal_match(education_and_teaching, helping_society).
goal_match(education_and_teaching, job_stability).
goal_match(education_and_teaching, work_life_balance).

ability_weight(education_and_teaching, communication, 3).
ability_weight(education_and_teaching, language, 2).
ability_weight(education_and_teaching, empathy, 2).
ability_weight(education_and_teaching, organization, 1).

field(psychology_and_social_sciences, 'Studies human behaviour, mental processes, society and social relationships.').
field_label(psychology_and_social_sciences, 'Psychology and Social Sciences').

related_subject(psychology_and_social_sciences, psychology).
related_subject(psychology_and_social_sciences, biology).
related_subject(psychology_and_social_sciences, social_science).
related_subject(psychology_and_social_sciences, literature).

leads_to_career(psychology_and_social_sciences, psychologist).
leads_to_career(psychology_and_social_sciences, counsellor).
leads_to_career(psychology_and_social_sciences, social_researcher).
leads_to_career(psychology_and_social_sciences, human_resource_professional).

subject_match(psychology_and_social_sciences, psychology).
subject_match(psychology_and_social_sciences, biology).
subject_match(psychology_and_social_sciences, social_science).
career_match(psychology_and_social_sciences, healthcare).
career_match(psychology_and_social_sciences, research).
career_match(psychology_and_social_sciences, education).
work_match(psychology_and_social_sciences, helping_people).
work_match(psychology_and_social_sciences, working_with_people).
work_match(psychology_and_social_sciences, research_and_analysis).
environment_match(psychology_and_social_sciences, office).
environment_match(psychology_and_social_sciences, hospital).
environment_match(psychology_and_social_sciences, classroom).
goal_match(psychology_and_social_sciences, helping_society).
goal_match(psychology_and_social_sciences, intellectual_challenge).
goal_match(psychology_and_social_sciences, work_life_balance).

ability_weight(psychology_and_social_sciences, empathy, 3).
ability_weight(psychology_and_social_sciences, communication, 2).
ability_weight(psychology_and_social_sciences, analytical, 2).

field(creative_arts_and_design, 'Combines creativity, visual communication, design and artistic expression.').
field_label(creative_arts_and_design, 'Creative Arts and Design').

related_subject(creative_arts_and_design, arts).
related_subject(creative_arts_and_design, literature).
related_subject(creative_arts_and_design, computer_science).
related_subject(creative_arts_and_design, design).

leads_to_career(creative_arts_and_design, graphic_designer).
leads_to_career(creative_arts_and_design, animator).
leads_to_career(creative_arts_and_design, artist).
leads_to_career(creative_arts_and_design, ux_designer).

subject_match(creative_arts_and_design, arts).
subject_match(creative_arts_and_design, literature).
subject_match(creative_arts_and_design, computer_science).
career_match(creative_arts_and_design, creative_industry).
career_match(creative_arts_and_design, technology).
work_match(creative_arts_and_design, creative_work).
work_match(creative_arts_and_design, building_or_designing_things).
work_match(creative_arts_and_design, working_with_technology).
environment_match(creative_arts_and_design, office).
environment_match(creative_arts_and_design, flexible_remote).
environment_match(creative_arts_and_design, technology_software_environment).
goal_match(creative_arts_and_design, entrepreneurship).
goal_match(creative_arts_and_design, international_opportunities).
goal_match(creative_arts_and_design, professional_growth).
goal_match(creative_arts_and_design, work_life_balance).

ability_weight(creative_arts_and_design, creativity, 3).
ability_weight(creative_arts_and_design, analytical, 1).
ability_weight(creative_arts_and_design, communication, 1).

% ------------------------------------------------------------
% 6. MATCHING RULES
% ------------------------------------------------------------

field_evidence(Field, subject, Subject, 5) :-
    subject_match(Field, Subject),
    student_subject(Subject).

field_evidence(Field, career, Career, 5) :-
    career_match(Field, Career),
    student_career_interest(Career).

field_evidence(Field, work, Work, 4) :-
    work_match(Field, Work),
    student_work_preference(Work).

field_evidence(Field, environment, Environment, 3) :-
    environment_match(Field, Environment),
    student_environment(Environment).

field_evidence(Field, goal, Goal, 4) :-
    goal_match(Field, Goal),
    student_goal(Goal).

field_evidence(Field, ability, Ability, Points) :-
    ability_weight(Field, Ability, Weight),
    student_ability(Ability, Rating),
    Points is Weight * Rating.

field_score(Field, Score) :-
    field(Field, _),
    findall(
        Points,
        field_evidence(Field, _, _, Points),
        PointList
    ),
    sum_list(PointList, Score).
