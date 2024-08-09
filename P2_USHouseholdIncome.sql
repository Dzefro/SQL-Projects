SELECT * FROM us_house_project.us_household_income;
SELECT * FROM us_house_project.us_household_income_statistics;

ALTER TABLE us_house_project.us_household_income_statistics RENAME column `ï»¿id` TO `id`;

SELECT count(id) FROM us_house_project.us_household_income;
SELECT count(id) FROM us_house_project.us_household_income_statistics;

select id, COUNT(id)
FROM us_house_project.us_household_income
group by id
HAVING COUNT(id) > 1;

DELETE FROM us_house_project.us_household_income
WHERE row_id IN (
SELECT row_id FROM(
SELECT row_id,id, row_number() OVER(PARTITION BY id ORDER BY id) as row_num
FROM us_house_project.us_household_income) AS dupilcates
WHERE row_num > 1);

select State_Name, COUNT(State_Name)
FROM us_house_project.us_household_income
group by State_Name;

UPDATE us_house_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_house_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

UPDATE us_house_project.us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

SELECT Type, COUNT(Type)
FROM us_household_income
group by Type
ORDER by 1;

UPDATE us_house_project.us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

SELECT Aland,AWater
FROM us_household_income
WHERE AWater = 0 OR AWater = '' or Awater is NULL;

SELECT Aland,AWater
FROM us_household_income
WHERE AWater = 0 OR AWater = '' or Awater is NULL;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP by State_Name
ORDER by 2 DESC LIMIT 10;

SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_house_project.us_household_income u
inner join us_household_income_statistics us
	on u.id = us.id
WHERE Mean <> 0;

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND (AVG(Median),1)
FROM us_house_project.us_household_income u
inner join us_household_income_statistics us
	on u.id = us.id
WHERE Mean <> 0
group by u.state_name
order by 2 DESC LIMIT 10;

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND (AVG(Median),1)
FROM us_house_project.us_household_income u
inner join us_household_income_statistics us
	on u.id = us.id
WHERE Mean <> 0
group by type
order by 3 DESC LIMIT 20;

SELECT * 
FROM us_household_income
where type = 'Community';

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND (AVG(Median),1)
FROM us_house_project.us_household_income u
inner join us_household_income_statistics us
	on u.id = us.id
WHERE Mean <> 0
group by type
HAVING COUNT(type) > 100
order by 3 DESC LIMIT 20;

SELECT u.State_Name, City, ROUND (AVG(Mean),1), ROUND (AVG(Median),1)
FROM us_house_project.us_household_income u
join us_household_income_statistics us
	on u.id = us.id
group by u.State_Name, City
order by ROUND (AVG(Mean),1) desc;