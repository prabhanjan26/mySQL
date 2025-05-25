select * from layoffs_staging2;

select max(total_laid_off),max(percentage_laid_off)
 from layoffs_staging2;
 

select * from layoffs_staging2
where percentage_laid_off = 1;

select * from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;


select company, sum(total_laid_off) 
from layoffs_staging2
group by country
order by 2 desc;

select country, sum(total_laid_off) 
from layoffs_staging2
group by country
order by 2 desc;

select `date`, sum(total_laid_off) 
from layoffs_staging2
group by `date`
order by 1 desc;

select year(`date`), sum(total_laid_off) 
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select stage, sum(total_laid_off) 
from layoffs_staging2
group by stage
order by 2 desc;

-- ROlling Total 
with rolling_total as (
select substring(`date`,1,7) as `Month`,
sum(total_laid_off) as total_laidOff
from layoffs_staging2
where substring(`date`,1,7) is not null 
group by `Month`)
select `Month`,
total_laidOff,
sum(total_laidOff) over (order by `Month`) as rollingTotal ## rolling total
from rolling_total
;

/*Top 5 company ranked each year based on the no. of total layoffs*/
select company ,
year(`date`) Years,
sum(total_laid_off) totalLaidOff
from layoffs_staging2
group by company , Years
order by totalLaidOff
;
with company_years as 
	(
    select company ,
year(`date`) Years,
sum(total_laid_off) totalLaidOff
from layoffs_staging2
group by company , Years
-- order by Years desc
    ),
company_rank as 
(
select *,dense_rank() over(partition by Years order by totalLaidOff desc) as Ranking
from company_years
where Years is not null
)
select * from company_rank
where Ranking <=5
;
select * from layoffs_staging2;
select count(company),count(location)
from layoffs_staging2
where (company = null or company = '')
-- and (location = null or location = '')
;
select 
 COUNT(*) AS total_rows,
    COUNT(company) AS non_null_company,
    (COUNT(*) - COUNT(company)) AS null_company, -- Or SUM(CASE WHEN company IS NULL THEN 1 ELSE 0 END) AS null_company
    COUNT(location) AS non_null_location,
    (COUNT(*) - COUNT(location)) AS null_location,
    COUNT(industry) AS non_null_industry,
    (COUNT(*) - COUNT(industry)) AS null_industry,
    COUNT(total_laid_off) AS non_null_total_laid_off,
    (COUNT(*) - COUNT(total_laid_off)) AS null_total_laid_off,
    COUNT(percentage_laid_off) AS non_null_percentage_laid_off,
    (COUNT(*) - COUNT(percentage_laid_off)) AS null_percentage_laid_off,
    COUNT(date) AS non_null_date,
    (COUNT(*) - COUNT(date)) AS null_date,
    COUNT(stage) AS non_null_stage,
    (COUNT(*) - COUNT(stage)) AS null_stage,
    COUNT(country) AS non_null_country,
    (COUNT(*) - COUNT(country)) AS null_country,
    COUNT(funds_raised_millions) AS non_null_funds_raised_millions,
    (COUNT(*) - COUNT(funds_raised_millions)) AS null_funds_raised_millions
FROM
    layoffs_staging2;
    
    /*Basic Summary Statistics: Calculate the mean, median, minimum, and maximum for funds_raised_millions.
    Also, find the earliest and latest date in the dataset.*/
select sum(funds_raised_millions)/count(funds_raised_millions) as mean,
avg(funds_raised_millions) as mean1 ,## this is mean lol
-- median(funds_raised_millions)
min(funds_raised_millions) min_funds,
max(funds_raised_millions) max_funds,
max(`date`) least_date,
min(`date`) earliest_date
from layoffs_staging2
;

/*Frequency Counts:
How many unique industry categories are there? List them.
How many companies are listed for each country?
*/

with unique_industry as (
select distinct industry
from layoffs_staging2
where industry is not null
)
select industry,
row_number() over(order by industry) as sl
from unique_industry
;

select country, count(company) as total_company
from layoffs_staging2
group by country
;

/*Simple Sorting:
List the top 5 companies by funds_raised_millions in descending order.
List the companies with the highest percentage_laid_off (ignoring NULLs for now). 
this is irrelevent as most values as 1 which is 100 percent!!
*/

select company 
from layoffs_staging2
order by funds_raised_millions desc
limit 5;

select company,
sum(funds_raised_millions) as funds
from layoffs_staging2
group by company
order by 2 desc;

select company, sum(total_laid_off) 
from layoffs_staging2
group by company
order by 2 desc;

/*Layoffs Over Time:
Group the data by month and year from the date column and calculate
 the total number of employees laid off (total_laid_off) each month.
*/
select substring(`date`,1,7) as Months,
sum(total_laid_off) as Total_laidOff
from layoffs_staging2
where substring(`date`,1,7) is not null
group by Months
order by Months asc
;

/*Funding Stage vs. Layoffs:
For each stage, calculate the average funds_raised_millions and the average percentage_laid_off.
Is there an observable trend (e.g., do later-stage companies lay off a higher percentage)?
*/
select stage,
avg(funds_raised_millions) as avg_funds,-- 
avg(percentage_laid_off) as avg_laidoff
from layoffs_staging2
group by stage
order by avg_laidoff desc
;













































