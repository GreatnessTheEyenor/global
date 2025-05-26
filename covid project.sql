
-----

SELECT*
FROM covid..vac$

select *
from covid..['new death$']

SELECT location, date, total_cases, total_deaths, new_cases,population
FROM covid..['new death$']
ORDER BY 1,2

--Looking at the Toatl Deaths rate at Afaghanstian & Nigeria

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Percentage_Death
FROM covid..['new death$']
WHERE location like 'Afghanistan'
ORDER BY Percentage_Death DESC


SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Percentage_Death
FROM covid..['new death$']
WHERE location like 'Nigeria'
ORDER BY Percentage_Death DESC


--Looking at the Maximum Deaths & Cases at Afghanistan & Nigeria


SELECT location, date, MAX(total_cases)as HIGHEST_CASES, MAX(cast(total_deaths as int)) as HIGHEST_DEATH
FROM covid..['new death$']
WHERE location like 'Afghanistan'
GROUP BY location,date
ORDER BY HIGHEST_DEATH DESC


SELECT location, date, MAX(cast(total_cases as int))as HIGHEST_CASES, MAX(cast(total_deaths as int)) as HIGHEST_DEATH
FROM covid..['new death$']
WHERE location like 'Afghanistan'
GROUP BY location,date
ORDER BY HIGHEST_CASES DESC




SELECT location, date, MAX(total_cases)as HIGHEST_CASES, MAX(cast(total_deaths as int)) as HIGHEST_DEATH
FROM covid..['new death$']
WHERE location like 'Nigeria'
GROUP BY location,date
ORDER BY 3 DESC


SELECT location, date, MAX(total_cases)as HIGHEST_CASES, MAX(cast(total_deaths as int)) as HIGHEST_DEATH
FROM covid..['new death$']
WHERE location like 'Nigeria'
GROUP BY location,date
ORDER BY 4 DESC


------- Total cases vs Population for AFG & NIGERIA
---What the percentage of people afffected with covid

SELECT location, date, total_cases, population, (total_cases/population)*100 as INFECTED
FROM covid..['new death$']
WHERE location like 'Afghanistan'
ORDER BY INFECTED DESC

SELECT location, date, total_cases, population, (total_cases/population)*100 as INFECTED
FROM covid..['new death$']
WHERE location like 'Nigeria'
ORDER BY INFECTED DESC




SELECT location, date, total_cases, total_deaths, new_cases,population
FROM covid..['new death$']
WHERE location like '%states%'

------ NEXT ANALYSIS 
--looking at countries with Highest Infection Rate compared to Population


SELECT location, population, MAX(total_cases) as Most_Infectedcount, MAX(total_cases/population)*100  as Pecertange_Affected
FROM covid..['new death$']
GROUP BY location, population
ORDER BY Pecertange_Affected DESC

--looking at contintent  with Highest Infection Rate compared to Population


SELECT continent, population, MAX(total_cases) as Most_Infectedcount, MAX(total_cases/population)*100  as Pecertange_Affected
FROM covid..['new death$']
WHERE continent is not null
GROUP BY continent, population
ORDER BY Pecertange_Affected DESC


------ Higest Death Count Per Country


SELECT location,  cast(total_deaths as int)  as Most_Death
FROM covid..['new death$']
Where continent is not null
ORDER BY  Most_Death DESC

------- COUNTRIES 
SELECT location, MAX( cast(total_deaths as int)) as Most_Death
FROM covid..['new death$']
Where continent is not null
GROUP BY location
ORDER BY  Most_Death DESC


---Looking at continebt most infected


SELECT location, MAX( cast(total_deaths as int)) as Most_Death
FROM covid..['new death$']
Where continent is  null
GROUP BY location
ORDER BY  Most_Death DESC

--- GLOBAL NUMBER OF TOTAL CASES PER DAY

SELECT date, SUM(new_cases) as global_cases
FROM covid..['new death$']
WHERE continent is not null
GROUP BY date
ORDER BY 2


--- GLOBAL NUMBER OF TOTAL  DEATH  PER DAY

SELECT date, SUM(cast(new_deaths as int)) as global_death
FROM covid..['new death$']
WHERE continent is not null
GROUP BY date
ORDER BY 2

----GLOBAL DEATH PERCENTAGE
SELECT date, SUM(cast(new_deaths as int)) as global_death, SUM(new_cases) as global_cases, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Global_percantagedeath
FROM covid..['new death$']
WHERE continent is not null
GROUP BY date
ORDER BY 2

--- total_deaths,total_cases and global_death percentage 
SELECT SUM(cast(new_deaths as int)) as global_death, SUM(new_cases) as global_cases, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Global_percantagedeath
FROM covid..['new death$']
WHERE continent is not null
--GROUP BY date
--ORDER BY 2
