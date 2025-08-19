use world_layoffs;
SELECT 
    *
FROM
    layoffs_new;

-- maximum and min total laid off
SELECT 
    MAX(total_laid_off), MIN(total_laid_off)
FROM
    layoffs_new;

-- max and min percentage laid off
SELECT 
    MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM
    layoffs_new;
    
SELECT 
    *
FROM
    layoffs_new
WHERE
    percentage_laid_off = 1;

-- total layoff by countries
SELECT 
    country, SUM(total_laid_off)
FROM
    layoffs_new
GROUP BY country
ORDER BY 2 DESC;

-- total layoff by industry
SELECT 
    industry, SUM(total_laid_off)
FROM
    layoffs_new
GROUP BY industry
ORDER BY 2 DESC;

-- total layoff by company
SELECT 
    company, YEAR(`date`), SUM(total_laid_off)
FROM
    layoffs_new
GROUP BY company , YEAR(`date`)
ORDER BY 1 ASC;

-- total layoff by stage
SELECT 
    stage, SUM(total_laid_off)
FROM
    layoffs_new
WHERE stage is not null
GROUP BY stage
ORDER BY 2 DESC;


-- total layoff per year
SELECT 
    YEAR(`date`), SUM(total_laid_off)
FROM
    layoffs_new
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;


-- total layoff per month
SELECT 
    SUBSTRING(`date`, 1, 7) AS `month`,
    SUM(total_laid_off) AS total_laidoff
FROM
    layoffs_new
WHERE
    SUBSTRING(`date`, 2, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 2 DESC;


-- rolling over total layoff per month
with rolling_total as (
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_laidoff
from layoffs_new where substring(`date`,2,7) is not null
group by `month`
order by 1 asc)
	select `month`, total_laidoff, 
    sum(total_laidoff) over(order by `month`) as roll_total
	from rolling_total;


-- total layoff by companies in each year
SELECT 
    company, YEAR(`date`) as `year`, SUM(total_laid_off) as tot_off
FROM
    layoffs_new
GROUP BY company , `year`
ORDER BY 1 ASC;


-- ranking most layoff companies
with rank_layoffs as (
	SELECT 
		company, YEAR(`date`) as `year`, SUM(total_laid_off) as tot_off
	FROM
		layoffs_new
	GROUP BY company , `year`
	ORDER BY 3 DESC
), company_year_rank as
(
	SELECT
		company, year, tot_off,
		dense_rank() over(PARTITION BY `year` ORDER BY tot_off DESC) as rankings
	FROM
		rank_layoffs
	WHERE tot_off IS NOT NULL
	AND `year` IS NOT NULL
)
SELECT
	*
FROM
	company_year_rank
WHERE rankings <= 5
;


























