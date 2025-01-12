CREATE DATABASE my_project;

USE my_project;

select * from `human resources`;


-- DATA CLEANING

-- Changing the id column from ï»¿id to emp_id only
ALTER TABLE  `human resources`
CHANGE COLUMN ï»¿id emp_id VARCHAR(30) NULL;

-- Checking the data types

-- Converting the text values into date 
-- for birthdate
UPDATE `human resources`
SET birthdate = CASE
   WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
   WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
   ELSE NULL
END;

ALTER TABLE `human resources`
MODIFY COLUMN birthdate DATE;


-- Converting the text values into date 
-- for hire_date
UPDATE `human resources`
SET hire_date = 
    CASE
        WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN 
            CASE
                WHEN LENGTH(hire_date) = 8 THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%d-%m-%y'), '%Y-%m-%d')
                ELSE DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%y'), '%Y-%m-%d')
            END
        ELSE NULL
    END;
    
    
ALTER TABLE `human resources`
MODIFY COLUMN hire_date DATE;

-- Converting the text values into date 
-- for termdate
UPDATE `human resources`
SET termdate = 
    CASE 
        WHEN termdate = '' THEN '0000-00-00'
        ELSE DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
    END
WHERE termdate IS NOT NULL;
set sql_mode = '';
ALTER TABLE `human resources`
MODIFY COLUMN termdate DATE;


-- Adding age column to the dataset
ALTER TABLE `human resources`
ADD COLUMN age INT;

-- Updating the age column using the birhdate
-- There were errors in the birthdate as some dates were entered as future dates
UPDATE `human resources`
SET birthdate = date_sub(birthdate, INTERVAL 100 YEAR)  -- Subtracts 100 years from the birthdate
WHERE birthdate >= '2060-01-01' AND birthdate < '2070-01-01';  -- Filters for birthdates between 2060 and 2069

UPDATE `human resources`
SET age = timestampdiff(YEAR, birthdate, CURDATE());







