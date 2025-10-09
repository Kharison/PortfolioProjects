USE healthcare;
SELECT * FROM ortho;

ALTER TABLE ortho
RENAME COLUMN 锘縟ate TO visit_date;

ALTER TABLE ortho
ADD COLUMN visit_month TEXT AFTER visit_date;

ALTER TABLE ortho
ADD COLUMN visit_day TEXT AFTER visit_month;

ALTER TABLE ortho
ADD COLUMN pat_age_group TEXT AFTER pat_age;
    
SELECT
visit_d, DAYNAME(visit_d)
FROM ortho;

SELECT 
    visit_date,
    SUBSTRING_INDEX(visit_date, ' ', 1) AS newDate,
    CONCAT(
		CASE
			WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) = 0 THEN 12
            WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) > 12 THEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) - 12
            ELSE SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1)
		END,
        ':00 ',
        CASE WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) < 12 THEN 'AM' ELSE 'PM' END
    ) AS newTime
FROM
    ortho;
    
UPDATE ortho
SET visit_d = STR_TO_DATE(SUBSTRING_INDEX(visit_date, ' ', 1), '%m/%d/%Y');

UPDATE ortho
SET visit_month = MONTHNAME(visit_d);

UPDATE ortho
SET visit_day = DAYNAME(visit_d);

UPDATE ortho
SET timeframe = CONCAT(
		CASE
			WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) = 0 THEN 12
            WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) > 12 THEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) - 12
            ELSE SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1)
		END,
        ':00 ',
        CASE WHEN SUBSTRING_INDEX(SUBSTRING_INDEX(visit_date, ' ', -1), ':', 1) < 12 THEN 'AM' ELSE 'PM' END
    );
    
UPDATE ortho
SET pat_age_group = CASE
	WHEN pat_age >= 1 AND pat_age <= 10 THEN '1-10'
    WHEN pat_age >= 11 AND pat_age <= 20 THEN '11-20'
    WHEN pat_age >= 21 AND pat_age <= 30 THEN '21-30'
    WHEN pat_age >= 31 AND pat_age <= 40 THEN '31-40'
    WHEN pat_age >= 41 AND pat_age <= 50 THEN '41-50'
    WHEN pat_age >= 51 AND pat_age <= 60 THEN '51-60'
    WHEN pat_age >= 61 AND pat_age <= 70 THEN '61-70'
    ELSE '70+'
END;
    
-- Qn: Total number of patients
SELECT COUNT(pat_id)
FROM ortho;

-- Qn: The Average PSAT Score
SELECT ROUND(AVG(pat_sat_score)) AS avgPSAT FROM ortho
WHERE pat_sat_score <> '';

-- Qn: The Average Wait Time
SELECT ROUND(AVG(pat_waittime))
FROM ortho;

-- Qn: How many patients were in each Age Bracket?
SELECT pat_age_group, COUNT(pat_id) AS c_patients
FROM ortho
GROUP BY pat_age_group
ORDER BY pat_age_group;

-- Qn: How did the amount of patients contribute to Wait Time?
SELECT 
    timeframe,
    COUNT(pat_id) AS total_patients,
    ROUND(AVG(pat_waittime)) AS avg_waiting_time
FROM
    ortho
GROUP BY timeframe
ORDER BY avg_waiting_time;



