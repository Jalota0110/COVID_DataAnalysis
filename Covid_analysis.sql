-- CREATE DATABASE IF NOT EXISTS covid;

USE covid;

ALTER TABLE `coviddeathsnew` 
RENAME TO  `coviddeaths` ;

ALTER TABLE `covid_vac - coviddeaths` 
RENAME TO  `covidvac` ;

SELECT * from covidvac
ORDER BY 3,4;

SELECT * from coviddeaths
ORDER BY 3,4;

SELECT location, date, total_cases, new_cases,total_deaths,population
FROM coviddeaths
ORDER BY 1,2;


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM coviddeaths
ORDER BY 1,2;

-- India
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM coviddeaths
WHERE location ='India'
ORDER BY 1,2;

-- USA
SELECT location, date, total_cases, total_deaths, (total_deaths*100/total_cases) as death_percentage
FROM coviddeaths
WHERE location like '%states%'
ORDER BY 1,2;


-- Looking at Total Cases vs population

SELECT location, date, total_cases, population, (total_cases/population)*100 as affected_percentage
FROM coviddeaths
ORDER BY 1,2;

SELECT location, date, total_cases, population, (total_cases/population)*100 as affected_percentage
FROM coviddeaths
WHERE location = 'India'
ORDER BY 1,2;

SELECT location, date, total_cases, population, (total_cases/population)*100 as affected_percentage
FROM coviddeaths
WHERE location like '%states%'
ORDER BY 1,2;


-- Looking at countries with Highest Infection Rate compared to population 

SELECT location, max(total_cases)as highest_infection_count, population, max((total_cases/population))*100 as affected_percentage
FROM coviddeaths
GROUP BY location, population
ORDER BY affected_percentage desc;

-- Showing the countries with highest death count per population
SELECT location, MAX(CONVERT(total_deaths, UNSIGNED)) as highest_deaths_count
FROM coviddeaths
WHERE total_deaths IS NOT NULL
GROUP BY location
ORDER BY highest_deaths_count desc;

-- We can see that the Continents are also grouped inside location
-- To rectify this we can use " Where continent is not null" based on the observation made looking at the dataset

SELECT location, MAX(CONVERT(total_deaths, UNSIGNED)) as highest_deaths_count
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY highest_deaths_count desc;


-- Breaking things down by continents

SELECT continent, MAX(CONVERT(total_deaths, UNSIGNED)) as highest_deaths_count
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highest_deaths_count desc;
#The above query is not involving the data where it is null for continents eg. inculding numbers only for UNITED STATED for Noth America and not canada
# Hence lets look into it

SELECT location, MAX(CONVERT(total_deaths, UNSIGNED)) as highest_deaths_count
FROM coviddeaths
WHERE continent IS NULL # looking for all the data where ther is no value for continent
GROUP BY location
ORDER BY highest_deaths_count desc;

SELECT DISTINCT location FROM coviddeaths;
-- TO DO:  try to replace the null values for continents using python script also check if the continents name are in same format 


-- Showing continents with highest death count per population 
SELECT continent, MAX(CONVERT(total_deaths, UNSIGNED)) as highest_deaths_count
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highest_deaths_count desc;


-- GLOBAL NUMBERS
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE location = 'India'
AND continent IS NOT NULL
order by location, date;

SELECT date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE continent IS NOT NULL
order by location, date; # we can use attributes in order by even if they are not in the SELECT query

SELECT date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date; 

SELECT date, SUM(total_cases) -- , total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

SELECT date, SUM(new_cases) -- using the "new_cases" attribute will give us the the total across the world date wise
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS death_percentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date; -- now here we can not order by location since its not in the group by clause


-- Finding total_cases, total_death and death_percentage in total
SELECT  SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS death_percentage
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY date; 






