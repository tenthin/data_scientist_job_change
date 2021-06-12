SELECT * FROM aug_train

-- dropping columns that are not neccessary

ALTER TABLE aug_train DROP COLUMN target
ALTER TABLE aug_train DROP COLUMN company_type, city, city_development_index
ALTER TABLE aug_train DROP COLUMN enrolled_university
ALTER TABLE aug_train DROP COLUMN company_size

-- Here I am counting how many different categories are there in each columns

SELECT relevent_experience, COUNT(relevent_experience) FROM aug_train GROUP BY relevent_experience
SELECT education_level, COUNT(education_level) FROM aug_train GROUP BY education_level --ND = Not Defined
SELECT major_discipline, COUNT(major_discipline) FROM aug_train GROUP BY major_discipline
SELECT gender, COUNT(gender) FROM aug_train GROUP BY gender
SELECT training_hours, COUNT(training_hours) FROM aug_train GROUP BY training_hours
SELECT last_new_job, COUNT(last_new_job) FROM aug_train GROUP BY last_new_job
SELECT experience, COUNT(experience) FROM aug_train GROUP BY experience

--Over here I am removing or filling the cells that are blank or NULL

UPDATE aug_train 
SET education_level = 'ND' 
WHERE education_level = ''

UPDATE aug_train 
SET major_discipline = 'No Major' 
WHERE education_level = 'High School' OR education_level = 'ND' OR education_level = 'Primary School'

UPDATE aug_train 
SET major_discipline = 'No Major'
WHERE major_discipline = 'No Majore'

UPDATE aug_train --those who have experience more than 20 years
SET experience = '21'
WHERE experience = '>20'

UPDATE aug_train
SET experience = '0'
WHERE experience ='<1'

UPDATE aug_train
SET last_new_job = 'never'
WHERE experience = '' OR  experience = '0'

UPDATE aug_train
SET experience = '0'
WHERE experience = 'never' OR experience = ''

UPDATE aug_train
SET last_new_job = '5'  --I will use 5 for last job experience greater than 4
WHERE last_new_job = '>4'

UPDATE aug_train
SET last_new_job = '0'
WHERE last_new_job = 'ND'

SELECT * FROM (SELECT experience, COUNT(experience) AS total_applicant FROM aug_train GROUP BY experience) AS experience1
ORDER BY total_applicant DESC

SELECT * FROM(SELECT last_new_job, COUNT(last_new_job) AS total_applicant FROM aug_train GROUP BY last_new_job) AS last_new_job_exp
ORDER BY total_applicant DESC

SELECT * FROM(SELECT training_hours, COUNT(training_hours) AS total_applicant FROM aug_train GROUP BY training_hours) AS training_time
ORDER BY training_hours

