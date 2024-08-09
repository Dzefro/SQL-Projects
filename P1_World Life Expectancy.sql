select * FROM world_life_expectancy;

select Country, Year, CONCAT (country,Year), COUNT(CONCAT(country,year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT (country,Year)
HAVING COUNT(CONCAT(country,year)) > 1;

SELECT *
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
;

SET SQL_SAFE_UPDATES = 0;
-- Perform your UPDATE or DELETE operations here
SET SQL_SAFE_UPDATES = 1;

    DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
);

select * FROM world_life_expectancy
WHERE status = '';

select  DISTINCT (status)
FROM world_life_expectancy
WHERE status <> '';

select  DISTINCT (country), status
FROM world_life_expectancy
WHERE status = 'developing';

UPDATE world_life_expectancy
SET STATUS = 'Developing' 
WHERE country IN (select  DISTINCT (country)
FROM world_life_expectancy
WHERE status = 'Developing');

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing' 
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed' 
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed';


select  *
FROM world_life_expectancy
WHERE `Life expectancy` = '';


select  t1.country, t1.year, t1.`Life expectancy`,  t2.country, t2.year, t2.`Life expectancy`, t3.country, t3.year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.year = t2.year-1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.year = t3.year+1
WHERE t1.`Life expectancy` = '';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.year = t2.year-1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.year = t3.year+1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = '';


SELECT *
FROM world_life_expectancy;

SELECT Country, MIN(`Life expectancy`), MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)- MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP by Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER by Life_Increase_15_Years DESC;

SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP by year
Order by year;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP by Country
HAVING life_exp > 0
AND GDP > 0
ORDER by GDP DESC;

SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) as High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) as High_GDP_Life_expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) as Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) as Low_GDP_Life_expectancy
FROM world_life_expectancy;

SELECT Status, ROUND(AVG(`Life expectancy`),1), COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP by status;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP by Country
HAVING life_exp > 0
AND BMI > 0
ORDER by BMI ASC;

SELECT Country, Year, `Life expectancy`, `Adult Mortality`, SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY year) as Rolling_Total
FROM world_life_expectancy
WHERE country LIKE '%United%';



