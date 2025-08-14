-- DATA CLEANING
select * from layoffs;
-- TODO LIST
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null values or blank values and check for populating
-- 4. Remove any columns

#1. Remove Duplicates
-- creating a backup dataset
create table layoffs_staging select * from layoffs;
select * from layoffs_staging;

-- checking for duplicates
with duplicates_cte as (
	select *,
	row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
	from layoffs_staging)
select * from duplicates_cte where row_num > 1;

-- Verifying for duplicates
select * from layoffs_staging where company = 'Yahoo';

-- deleting duplicates
with duplicates_cte as (
	select *,
	row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
	from layoffs_staging)
delete from duplicates_cte where row_num > 1;
-- (error in deleting due to row_num)

-- create new table to include row_num to delete
CREATE TABLE `layoffs_new` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- insert values from previous table including row_num
insert into layoffs_new
with duplicates_cte as (
	select *,
	row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
	from layoffs_staging)
select * from duplicates_cte;

-- confirm the total dataset
select count(*) from layoffs_new;

-- now we can delete duplicates
delete from layoffs_new where row_num > 1;
select * from layoffs_new;


#2. Standardize the Data
select distinct company from layoffs_new order by 1;

-- trim for white spaces in columns
select company, trim(company) from layoffs_new;
update layoffs_new set company = trim(company); 

-- repetition in industry column
select * from layoffs_new where industry like 'Crypto%';
update layoffs_new set industry = 'Crypto' where industry like 'Crypto%';

select distinct location from layoffs_new;

-- filter for unwanted characters
SELECT location
FROM layoffs_new
WHERE location REGEXP '[\\x{4E00}-\\x{9FFF}]';

-- searching for unwanted characters like 'Ual谩'
SELECT *
FROM layoffs_new
WHERE company REGEXP '[^\\x00-\\x7F]'
   OR location REGEXP '[^\\x00-\\x7F]'
   OR industry REGEXP '[^\\x00-\\x7F]'
   OR stage REGEXP '[^\\x00-\\x7F]'
   OR country REGEXP '[^\\x00-\\x7F]';
   
select * from layoffs_new where country = 'Argentina';


update layoffs_new set location = 'Florianopolis' where location = 'Florian贸polis';
update layoffs_new set location = 'Malmo' where location = 'Malm枚';
update layoffs_new set location = 'Dusseldorf' where location = 'D眉sseldorf';
update layoffs_new set company = 'Uala' where company = 'Ual谩';

select distinct country from layoffs_new order by 1;
select * from layoffs_new where country like 'United States%';
update layoffs_new set country = 'United States' where country like 'United States%';

-- changing the date column datatype from text to date
select `date` from layoffs_new;
update layoffs_new set `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_new modify column `date` date;
select * from layoffs_new;


#3. Null values or blank values and check for populating
select * from layoffs_new where country = '';
update layoffs_new set industry = null where industry = '';

select * from layoffs_new where industry is null;
select * from layoffs_new where company ='Airbnb';

-- populating null row if necessary
select t1.company, t1.location, t1.industry,
t2.company, t2.location, t2.industry 
from layoffs_new t1 join layoffs_new t2
on t1.company = t2.company
where t1.industry is not null and t2.industry is null;

update layoffs_new t1 join layoffs_new t2
on t1.company = t2.company set t2.industry = t1.industry
where t1.industry is not null and t2.industry is null;

select * from layoffs_new where industry is null;

select * from layoffs_new 
where total_laid_off is null and percentage_laid_off is null;

delete from layoffs_new 
where total_laid_off is null and percentage_laid_off is null;

#4. Remove any columns
select * from layoffs_new;

-- drop column row_num
alter table layoffs_new drop column row_num;













































