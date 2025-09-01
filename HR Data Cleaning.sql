CREATE DATABASE projects;
USE projects;

-- view dataset
SELECT * FROM hr;

-- check for columns
DESCRIBE hr;

ALTER TABLE hr
CHANGE COLUMN 锘縤d emp_id VARCHAR(20) NULL;

SELECT 
    birthdate,
    CASE
		WHEN birthdate LIKE ('%/%') THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%d-%m-%Y')
        WHEN birthdate LIKE ('%-%') THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%d-%m-%Y'), '%d-%m-%Y')
	END AS new_birthdate
FROM
    hr;

UPDATE hr
SET birthdate = 
	CASE
		WHEN birthdate LIKE ('%/%') THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN birthdate LIKE ('%-%') THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%d-%m-%Y'), '%Y-%m-%d')
        ELSE NULL
	END;
    
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = 
	CASE
		WHEN hire_date LIKE ('%/%') THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN hire_date LIKE ('%-%') THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%d-%m-%Y'), '%Y-%m-%d')
        ELSE NULL
	END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

UPDATE hr
SET termdate = IF(termdate != '', DATE(STR_TO_DATE(termdate, '%Y-%m-%d')), '0000-00-00')
WHERE true;

SELECT 
    termdate
FROM
    hr;
    
SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT 
    *
FROM
    hr;

ALTER TABLE hr
ADD COLUMN age INT AFTER birthdate;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT
	MIN(age),
    MAX(age)
FROM hr;

SELECT birthdate,age
FROM hr WHERE age < 0;































































