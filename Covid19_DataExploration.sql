-- ----------------------------------------------------------------------------
-- Capstone Project for Google Data Analytics Professional Certification Course
-- ----------------------------------------------------------------------------

-- Select the default database to be used in this project.
use capstone_project;

SELECT *
FROM covid_deaths
ORDER BY 3, 4;

-- SELECT *
-- FROM covid_vaccinations
-- ORDER BY 3, 4;

-- Select data to be used and ordering by location and date. 
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM covid_deaths
ORDER BY 1, 2;

-- Looking at Total Cases vs. Total Deaths
-- Shows the liklihood of dying if you contract Covid in United States
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM covid_deaths
WHERE location like "%states%"
ORDER BY 1, 2;

-- Looking at Total Cases vs. Population
-- Shows what percentage of population got infected with Covid
SELECT Location, date, population, total_cases, (total_cases/population)*100 as InfectionPercentage
FROM covid_deaths
WHERE location like '%states%'
ORDER BY 1, 2;

-- Looking at countries with highest infection rate compared to population
SELECT Location, population, MAX(total_cases) as HighestInfectionCount 
, MAX((total_cases/population))*100 as InfectionPercentage
FROM covid_deaths
GROUP BY location, population
ORDER BY InfectionPercentage desc;

-- Showing countries  with highest death count per population
-- Converting (or casting) total_deaths column to integer data type (aka SIGNED).
SELECT location, MAX(CAST(total_deaths AS SIGNED)) as TotalDeathCount
FROM covid_deaths
-- Filtering out locations that have continent listed as NULL so we can filter out continent
WHERE continent is NOT NULL
GROUP BY location
ORDER BY TotalDeathCount desc;

-- Looking at total death count by continent
SELECT continent, MAX(CAST(total_deaths AS SIGNED)) as TotalDeathCount
FROM covid_deaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount desc;

-- Global Numbers
-- New cases and deaths globally each date, global death percentage
SELECT date, SUM(new_cases) as SumNewCases, SUM(CAST(new_deaths as SIGNED)) as SumNewDeaths
, (SUM(CAST(new_deaths as SIGNED))/SUM(new_cases)*100) as DeathPercentage
FROM covid_deaths
WHERE continent is NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- Total cases and deaths globally, global death percentage
SELECT SUM(new_cases) as SumNewCases, SUM(CAST(new_deaths as SIGNED)) as SumNewDeaths
, (SUM(CAST(new_deaths as SIGNED))/SUM(new_cases)*100) as DeathPercentage
FROM covid_deaths
WHERE continent is NOT NULL
ORDER BY 1, 2;

-- Exploring vaccination data

SELECT *
FROM covid_vaccinations
LIMIT 10;

-- Total population vs vaccination
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL
ORDER BY 2, 3;

-- Total population vs vaccination with running total of vaccinations in each country
-- Creating a Common Table Expression (CTE)
WITH PopvsVac 
(continent, location, date, population, new_vaccinations, Running_Total_Vaccinations)
as (
SELECT d.continent, d.location, str_to_date(d.date, "%m/%d/%Y") as date, d.population, v.new_vaccinations
, SUM(CONVERT(v.new_vaccinations, SIGNED)) OVER (partition by d.location ORDER BY d.location
, str_to_date(d.date, "%m/%d/%Y")) as Running_Total_Vaccinations
-- , (SUM(CONVERT(v.new_vaccinations, SIGNED)) OVER (partition by d.location ORDER BY d.location
-- , str_to_date(d.date, "%m/%d/%Y"))/d.population)*100 as VaccinationPercentage
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL
GROUP BY d.date
-- ORDER BY 2,3,
)
SELECT *, (Running_Total_Vaccinations/population)*100 as VaxPercentage
FROM PopvsVac;

-- TEMP TABLE

DROP Table if exists PercentPopulationVaccinated;
Create Temporary Table PercentPopulationVaccinated (
Continent varchar(255),
Location varchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into PercentPopulationVaccinated(
d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CAST(v.new_vaccinations as SIGNED)) OVER (Partition by d.Location Order by d.location, d.Date) as RollingPeopleVaccinated
)
From Covid_Deaths d
Join Covid_Vaccinations v
	On d.location = v.location
	and d.date = v.date;

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated;


SELECT d.continent, d.location, str_to_date(d.date, "%m/%d/%Y") as date, d.population, v.new_vaccinations
, SUM(CONVERT(v.new_vaccinations, SIGNED)) OVER (partition by d.location ORDER BY d.location
, str_to_date(d.date, "%m/%d/%Y")) as Running_Total_Vaccinations
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL
GROUP BY d.date
ORDER BY 2,3;

-- Creating a view for future visualization

Create View PercentPopulationVaccinated as
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CAST(v.new_vaccinations as SIGNED)) OVER (Partition by d.Location Order by d.location, d.Date) as RollingPeopleVaccinated
From covid_deaths d
Join covid_vaccinations v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 


