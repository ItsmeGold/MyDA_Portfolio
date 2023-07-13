/*
Covid 19 Data Exploration (https://ourworldindata.org/covid-deaths)

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

By: Kevin Capon Goldszmidt

*/

-- Summary of the tables

SELECT *
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
ORDER BY 3,4;

SELECT *
FROM `daproject2.PortfolioProjectCovid.CovidVaccins`
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- Selecting the data for this project 

SELECT location, date, total_cases,new_cases, total_deaths, population
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Use this query to find the total cases vs the toal deaths by Country
-- It shows the likelyhood of dying if someone contracts COVID by Country

SELECT location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- VIEW: Total Cases vs Total deaths by Country
CREATE VIEW `daproject2.PortfolioProjectCovid.totalcasesVStotaldeaths` AS 
SELECT location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Use this query to find the total cases vs the toal deaths by Country
-- It shows the likelyhood of dying if someone contracts COVID by Country

SELECT continent, date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
-- GROUP BY continent 
ORDER BY DeathPercentage;

-- VIEW: Total Cases vs Total deaths by Contient

CREATE VIEW `daproject2.PortfolioProjectCovid.totalcasesVStotaldeathsContinent` AS 
SELECT continent, date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Use this query to find the total COVID cases vs the population per country
-- Find the percentage of the population that got covid per country

SELECT location, date, population, total_cases, (total_cases/population)*100 AS PrecentPopulationInfected
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE location = 'United States' AND continent IS NOT NULL
ORDER BY 1,2;

-- VIEW: Percentage of people that got COVID per Country

CREATE VIEW `daproject2.PortfolioProjectCovid.popwithcovidCountry` AS 
SELECT location, date, population, total_cases, (total_cases/population)*100 AS PrecentPopulationInfected
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE location = 'United States' AND continent IS NOT NULL
ORDER BY 1,2;


-- Use this query to find the total COVID cases vs the population per Continent
-- Find the percentage of the population that got covid per Continent

SELECT continent, total_cases, (total_cases/population)*100 AS PrecentPopulationInfected
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
--GROUP BY continent, total_cases, population
ORDER BY 1,2;

-- Use this query to find the countries with the highest infection rates compared to the population
-- What percentage of the pouplation has gotten COVID by Country?

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PrecentPopulationInfected
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PrecentPopulationInfected DESC;

-- VIEW: Percentage of the population that got COVID PER COUNTRY

CREATE VIEW `daproject2.PortfolioProjectCovid.percpopcovidCountry` AS 
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PrecentPopulationInfected
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PrecentPopulationInfected DESC;


-- Use this query to find the Continents with the highest infection rates compared to the population
-- What percentage of the pouplation has gotten COVID by Contient?


SELECT continent, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PrecentPopulationInfected
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY continent, population
ORDER BY PrecentPopulationInfected DESC;

-- VIEW: Percentage of the population that got COVID per CONTINENT

CREATE VIEW `daproject2.PortfolioProjectCovid.percpopcovidContinent` AS 
SELECT continent, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PrecentPopulationInfected
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY continent, population
ORDER BY PrecentPopulationInfected DESC;

-- Use this query to find the countries with the highest death count per population by country
-- Showing the countries with the highest death count per population

SELECT location, MAX(total_deaths) AS Totaldeathcount
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
--WHERE location = 'United States'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Totaldeathcount DESC;

-- VIEW: countries with highest death count per population by country
CREATE VIEW `daproject2.PortfolioProjectCovid.deathcountperpopulation` AS 
SELECT location, MAX(total_deaths) AS Totaldeathcount
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
--WHERE location = 'United States'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Totaldeathcount DESC;

-- Use this query to find the countries with the highest death count per population by Continent
-- Showing the continents with the highest death count per population

SELECT location, MAX(total_deaths) AS Totaldeathcount
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
--WHERE location = 'United States'
WHERE continent IS NULL
GROUP BY location
ORDER BY Totaldeathcount DESC;

-- VIEW: CONTINENTS with highest death count per population

CREATE VIEW `daproject2.PortfolioProjectCovid.deathcountperpopulationContinent` AS 
SELECT location, MAX(total_deaths) AS Totaldeathcount
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
--WHERE location = 'United States'
WHERE continent IS NULL
GROUP BY location
ORDER BY Totaldeathcount DESC;

-- Use this query to find some interesting global numbers

SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SAFE_DIVIDE(SUM(CAST(new_deaths AS FLOAT64)), SUM(CAST(new_cases AS FLOAT64))) * 100 AS death_to_case_ratio
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- VIEW: GLOBAL NUMBERS

CREATE VIEW `daproject2.PortfolioProjectCovid.globalnumbers` AS 
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SAFE_DIVIDE(SUM(CAST(new_deaths AS FLOAT64)), SUM(CAST(new_cases AS FLOAT64))) * 100 AS death_to_case_ratio
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- Summary Global Numbers (One Row)

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SAFE_DIVIDE(SUM(CAST(new_deaths AS FLOAT64)), SUM(CAST(new_cases AS FLOAT64))) * 100 AS death_to_case_ratio
FROM `daproject2.PortfolioProjectCovid.CovidDeaths`
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2;

-- Use this query to find the total population vs vaccinations by country

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM `daproject2.PortfolioProjectCovid.CovidDeaths` AS dea
JOIN `daproject2.PortfolioProjectCovid.CovidVaccins` AS vac ON
dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- Use this query to find the total population vs vaccinations by country with a sequential count

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT64)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM `daproject2.PortfolioProjectCovid.CovidDeaths` AS dea
JOIN `daproject2.PortfolioProjectCovid.CovidVaccins` AS vac ON
dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- Use this query for a CTE

WITH PopvsVac AS (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT64)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM `daproject2.PortfolioProjectCovid.CovidDeaths` AS dea
JOIN `daproject2.PortfolioProjectCovid.CovidVaccins` AS vac ON 
dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopvsVac;

-- Use this query to create a Temp Table

DROP TABLE IF EXISTS `daproject2.PortfolioProjectCovid.PERCENTPOPULATIONVACCINATED`;
WITH PERCENTPOPULATIONVACCINATED AS (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT64)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM `daproject2.PortfolioProjectCovid.CovidDeaths` AS dea
JOIN `daproject2.PortfolioProjectCovid.CovidVaccins` AS vac ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *,(RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM PERCENTPOPULATIONVACCINATED;

-- VIEW: percent of the population vaccinated

CREATE VIEW `daproject2.PortfolioProjectCovid.PERCENTPOPULATIONVACCINATED` AS 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT64)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM `daproject2.PortfolioProjectCovid.CovidDeaths` AS dea
JOIN `daproject2.PortfolioProjectCovid.CovidVaccins` AS vac ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;


-- Use this query to see the table
SELECT *
FROM PortfolioProjectCovid.PERCENTPOPULATIONVACCINATED;




