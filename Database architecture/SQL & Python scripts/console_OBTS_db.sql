-- offender dictionaries --
CREATE TABLE sex (
    sex_id SERIAL PRIMARY KEY,
    sex_label VARCHAR(100));

CREATE TABLE race (
    race_id SERIAL PRIMARY KEY,
    race_label VARCHAR(100));

CREATE TABLE ethnic_origin (
    ethnic_origin_id SERIAL PRIMARY KEY,
    ethnic_origin_label VARCHAR(100));

CREATE TABLE encrypted_offenders (
    encrypted_id SERIAL PRIMARY KEY,
    encrypted_id_label VARCHAR(100));

-- offenders table --
CREATE TABLE offenders (
    offenders_id SERIAL PRIMARY KEY,
    encrypted_id SERIAL REFERENCES encrypted_offenders(encrypted_id_label),
    sex SERIAL REFERENCES sex(sex_id) NULL,
    race SERIAL REFERENCES race(race_id) NULL,
    ethnic_origin SERIAL REFERENCES ethnic_origin(ethnic_origin_id) NULL;


-- arresting dictionaries --
CREATE TABLE states (states_id SERIAL PRIMARY KEY,
    states_label VARCHAR(100));

CREATE TABLE counties (counties_id SERIAL PRIMARY KEY,
    counties_label VARCHAR(100));

CREATE TABLE sequence_number_of_arrest_charges (sequence_number_of_arrest_charges_id SERIAL PRIMARY KEY,
    sequence_number_of_arrest_charges_label VARCHAR(100));

CREATE TABLE offense_code (offense_code_id SERIAL PRIMARY KEY,
    offense_code_label VARCHAR(100));

CREATE TABLE level_of_offenses (level_of_offenses_id SERIAL PRIMARY KEY,
    level_of_offenses_label VARCHAR(100));

CREATE TABLE police_disposition (police_disposition_id SERIAL PRIMARY KEY,
    police_disposition_label VARCHAR(100));

CREATE TABLE general_offense_code (general_offense_code_id SERIAL PRIMARY KEY,
    general_offense_code_label VARCHAR(100));

CREATE TABLE pre_trial_status (pre_trial_status_id SERIAL PRIMARY KEY,
    pre_trial_status_label VARCHAR(100));

-- arresting table --
CREATE TABLE arresting_case (arresting_case_id SERIAL PRIMARY KEY,
    offenders_id SERIAL REFERENCES offenders(offenders_id),
    state SERIAL REFERENCES states(states_id) NULL,
    county SERIAL REFERENCES counties(counties_id) NULL,
    date_of_arrest DATE NULL,
    offender_age_at_arrest DECIMAL NULL,
    level_of_arrest_charges SERIAL REFERENCES level_of_offenses(level_of_offenses_id) NULL,
    number_of_arrest_charges DECIMAL NULL,
    sequence_number_of_arrest_charges SERIAL REFERENCES sequence_number_of_arrest_charges(sequence_number_of_arrest_charges_id) NULL,
    arrest_chg_offense_code SERIAL REFERENCES offense_code(offense_code_id) NULL,
    police_disposition SERIAL REFERENCES police_disposition(police_disposition_id) NULL,
    date_of_police_disposition DATE NULL,
    elapsed_time_between_arrest_and_police_disposition DECIMAL NULL,
    general_offense_code SERIAL REFERENCES general_offense_code(general_offense_code_id) NULL,
    pre_trial_status SERIAL REFERENCES pre_trial_status(pre_trial_status_id) NULL);


-- prosecutor/grand jury dictionaries --
CREATE TABLE prosecutor_grand_jury_disposition (
    prosecutor_grand_jury_disposition_id SERIAL PRIMARY KEY,
    prosecutor_grand_jury_disposition_label VARCHAR(100));

-- prosecutor/grand jury table --
CREATE TABLE prosecutor_grand_jury_case (
    prosecutor_grand_jury_case_id SERIAL PRIMARY KEY,
    case_id SERIAL REFERENCES arresting_case(arresting_case_id),
    offenders_id SERIAL REFERENCES offenders(offenders_id),
    charged_offense_code SERIAL REFERENCES offense_code(offense_code_id) NULL,
    level_of_charged_offense SERIAL REFERENCES level_of_offenses(level_of_offenses_id) NULL,
    number_of_charged_offense DECIMAL NULL,
    prosec_grand_jury_disposition SERIAL REFERENCES prosecutor_grand_jury_disposition(prosecutor_grand_jury_disposition_id) NULL,
    date_of_prosec_grand_jury_disposition DATE NULL,
    elapsed_time_between_arrest_and_prosec_grand_jury_disposition DECIMAL NULL,
    general_offense_code SERIAL REFERENCES general_offense_code(general_offense_code_id) NULL,
    pre_trial_status SERIAL REFERENCES pre_trial_status(pre_trial_status_id) NULL);


-- court disposition dictionaries --
CREATE TABLE court_disposition (
    court_disposition_id SERIAL PRIMARY KEY,
    court_disposition_label VARCHAR(100));

CREATE TABLE court_type (court_type_id SERIAL PRIMARY KEY,
    court_type_label VARCHAR(100));

CREATE TABLE trial_type (trial_type_id SERIAL PRIMARY KEY,
    trial_type_label VARCHAR(100));

CREATE TABLE counselling_type (counselling_type_id  SERIAL PRIMARY KEY,
    counselling_type_label VARCHAR(100));

CREATE TABLE final_pleading (final_pleading_id SERIAL PRIMARY KEY,
    final_pleading_label VARCHAR(100));

-- court disposition table --
CREATE TABLE court_disposition_case (
    court_disposition_case_id SERIAL PRIMARY KEY,
    case_id SERIAL REFERENCES arresting_case(arresting_case_id),
    offenders_id SERIAL REFERENCES offenders(offenders_id),
    court_disposition_offense_code SERIAL REFERENCES offense_code(offense_code_id) NULL,
    level_of_court_disposition_offense SERIAL REFERENCES level_of_offenses(level_of_offenses_id) NULL,
    number_of_court_disposition_offense DECIMAL NULL,
    court_disposition SERIAL REFERENCES court_disposition(court_disposition_id) NULL,
    number_of_conviction_offense DECIMAL NULL,
    date_of_court_disposition DATE NULL,
    elapsed_time_between_arrest_and_court_disposition DECIMAL NULL,
    court_type SERIAL REFERENCES court_type(court_type_id) NULL,
    trial_type SERIAL REFERENCES trial_type(trial_type_id) NULL,
    counselling_type SERIAL REFERENCES counselling_type(counselling_type_id) NULL,
    final_pleading SERIAL REFERENCES final_pleading(final_pleading_id) NULL,
    general_offense_code SERIAL REFERENCES general_offense_code(general_offense_code_id) NULL,
    pre_trial_status SERIAL REFERENCES pre_trial_status(pre_trial_status_id) NULL);


-- sentencing dictionaries --
CREATE TABLE sentence_type (sentence_type_id SERIAL PRIMARY KEY,
    sentence_type_id_label VARCHAR(100));

CREATE TABLE multiple_incarceration_sentence (multiple_incarceration_sentence_id SERIAL PRIMARY KEY,
    multiple_incarceration_sentence_label VARCHAR(100));

-- sentencing table --
CREATE TABLE sentencing_case (
    sentencing_case_id SERIAL PRIMARY KEY,
    case_id SERIAL REFERENCES arresting_case(arresting_case_id),
    offenders_id SERIAL REFERENCES offenders(offenders_id),
    date_of_final_sentencing DATE NULL,
    elapsed_time_between_arrest_and_sentencing DECIMAL NULL,
    sentence_type SERIAL REFERENCES sentence_type(sentence_type_id) NULL,
    sentence_min TEXT NULL,
    sentence_max TEXT NULL,
    multiple_incarceration_sentence SERIAL REFERENCES multiple_incarceration_sentence(multiple_incarceration_sentence_id) NULL,
    year_disposition_determined DATE NULL);
