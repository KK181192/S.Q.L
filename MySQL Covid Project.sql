-- SQL DATA EXPLORATION PROJECT(COVID-19 DATA PORTFOLIO PROJECT)

 select * from covid_deaths;

-- 1. Likelihood of dying if you contracted covid in your country(in this case Ghana)

select distinct location, max(population) as population, 
sum(new_deaths) as total_deaths, 
max(total_cases) as total_cases, 
(sum(new_deaths)*100/max(total_cases)) as death_rate_percentage 
from covid_deaths 
where location = 'ghana';

-- 2. Highest Infection Rate for all countries

select location, max(total_cases) as no_of_cases, 
max(population) as total_population, 
(max(total_cases)*100/max(population)) as HighestInfectionRate 
from covid_deaths
where location not in ('asia','africa','europe','North america','european union','international','south america')
group by location;

-- 3. Highest Death Rate for all countries

select location, max(total_deaths) as highest_no_of_deaths, 
max(population) as total_population, 
(max(total_deaths)*100/max(population)) as HighestDeathRate 
from covid_deaths
where location not in ('asia','africa','europe','North america','european union','international','south america')
group by location;

-- 4. Finding death rate per continental population

select continent, sum(new_deaths) as no_of_deaths, 
sum(distinct(population)) as total_population, 
sum(new_deaths)*100/sum(distinct(population)) as continental_death_rate 
from covid_deaths 
where location not in ('asia','africa','europe','North america','european union','international','south america')
group by continent;

-- 5. Finding infection rate per continental population

select row_number () over (order by continent desc) as  row_num, 
continent, sum(new_cases) as no_of_cases, 
sum(distinct(population)) as total_population, 
(sum(new_cases)/sum(distinct(population))*100) as continental_infections_rate 
from covid_deaths 
where location not in ('asia','africa','europe','North america','european union','international','south america')
group by continent;

-- 6. Finding the death per infection rate per continent;

select row_number () over (order by (sum(new_deaths)*100/sum(new_cases))desc) as row_num, continent, 
sum(new_deaths) as total_deaths, sum(new_cases) as total_cases, 
(sum(new_deaths)/sum(new_cases)*100) as death_rate_of_infection from covid_deaths 
where location not in ('asia','africa','europe','North america','european union','international','south america')
group by continent;

-- 7. Finding the death per infection rate in the world;

select row_number () over (order by(sum(new_deaths)*100/sum(new_cases)) desc) as row_num, date, 
sum(new_deaths) as total_deaths, sum(new_cases) as total_cases, 
(sum(new_deaths)*100/sum(new_cases)) as World_Death_Rate from covid_deaths where location not in 
('asia','africa','europe','North america','european union','international','south america') group by date;

select * from covid_deaths as cd inner join covid_vacs as cv
using (location,date) 
where cd.location not in ('asia','africa','europe','North america','european union','international','south america'); 


-- 8. Going to look at the total population, total vaccination and the percentage of those vaccinated per country

select cd.location, cd.population, sum(cv.new_vaccinations) as total_vaccinations, 
concat(sum(cv.new_vaccinations)*100/cd.population," ", "%") as percentage_vaccinated
from covid_deaths as cd inner join covid_vacs as cv
using (location,date)
where cd.location not in ('asia','africa','europe','North america','european union','international','south america')
group by cd.location;

-- In the above query, the percentages in some of the countries exceed one hundred percent(100%) because it was
-- very common for an individual to be vaccinated more than once but each vaccination administered, no matter how
-- many times on an individual still counted as one more vaccination 
