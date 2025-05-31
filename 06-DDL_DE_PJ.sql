DROP DATABASE IF EXISTS HealthCareDB;

CREATE DATABASE HealthCareDB;

USE HealthCareDB;


CREATE TABLE dim_demographics (
  demographics_key   INT            PRIMARY KEY,
  sex                CHAR(20)       NOT NULL,
  age_group          VARCHAR(50),
  education_level    VARCHAR(50),
  annual_income      VARCHAR(50),
  race_ethnicity     VARCHAR(100)
);


CREATE TABLE dim_behaviors (
  behaviors_key                  INT    PRIMARY KEY,
  smoked_100_lifetime            TINYINT,
  smoking_frequency              VARCHAR(50),
  reported_exercise              TINYINT,
  alcohol_use_frequency          VARCHAR(50)
);


CREATE TABLE dim_general_health (
  general_health_key             INT    PRIMARY KEY,
  health_rating                  VARCHAR(10),
  days_physical_health_not_good  INT,
  days_mental_health_not_good    INT
);


CREATE TABLE dim_checkup_engagement (
  checkup_engagement_key INT    PRIMARY KEY,
  time_since_cholcheck   VARCHAR(50),
  time_since_gencheck    VARCHAR(50)
);


CREATE TABLE dim_BMI (
  bmi_key           INT     PRIMARY KEY,
  bmi_value         DECIMAL(5,2),
  bmi_category      VARCHAR(20),
  overweight_obese  BOOLEAN
);

CREATE TABLE dim_state (
  state_key     INT	    			PRIMARY KEY,
  state_name    VARCHAR(50) NOT NULL,
  population    INT
);

CREATE TABLE dim_state_env (
  state_key                    INT			 PRIMARY KEY,
  pm25_level                   DECIMAL(10,2),
  water_violation_rate         DECIMAL(10,2),
  food_env_index               DECIMAL(10,2),
  exercise_access              DECIMAL(10,2),
  limited_healthyfood_access   DECIMAL(10,2),
  FOREIGN KEY (state_key) REFERENCES dim_state(state_key)
);

CREATE TABLE dim_state_eco (
  state_key          INT				PRIMARY KEY,
  gdp                    DECIMAL(15,2),
  insurance_cost         DECIMAL(10,2),
  FOREIGN KEY (state_key) REFERENCES dim_state(state_key)
);

CREATE TABLE fact_heart_health (
  respondent_id             INT           PRIMARY KEY,
  high_blood_pressure_diagnosis    VARCHAR(100),
  heart_disease_diagnosis    VARCHAR(100),
  heart_attack_diagnosis    VARCHAR(100),
  diabetes_diagnosis      VARCHAR(100),
  stroke_diagnosis          VARCHAR(100),
  demographics_key          INT           NOT NULL,
  behaviors_key             INT           NOT NULL,
  general_health_key        INT           NOT NULL,
  checkup_engagement_key    INT           NOT NULL,
  bmi_key                   INT           NOT NULL,
  state_key                 INT           NOT NULL,
  FOREIGN KEY (demographics_key)       REFERENCES dim_demographics(demographics_key),
  FOREIGN KEY (behaviors_key)          REFERENCES dim_behaviors(behaviors_key),
  FOREIGN KEY (general_health_key)     REFERENCES dim_general_health(general_health_key),
  FOREIGN KEY (checkup_engagement_key) REFERENCES dim_checkup_engagement(checkup_engagement_key),
  FOREIGN KEY (bmi_key)                REFERENCES dim_BMI(bmi_key),
  FOREIGN KEY (state_key)              REFERENCES dim_state(state_key)
);






