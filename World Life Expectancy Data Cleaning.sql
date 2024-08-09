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


