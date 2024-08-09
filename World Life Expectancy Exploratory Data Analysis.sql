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
