# Covid-19 Data Exploration

This case study explores global Covid-19 data, focusing on percentage of infection, death and vaccinations per population, worldwide. This portion of the project is completed in MySQL.   

## Sources

### Statistics and Research: Coronavirus (COVID-19) Deaths Dataset

Research and data: Hannah Ritchie, Edouard Mathieu, Lucas Rodés-Guirao, Cameron Appel, Charlie Giattino, Esteban Ortiz-Ospina, Joe Hasell, Bobbie MacDonald, Diana Beltekian, Saloni Dattani and Max Roser

Web development: Lars Yencken, Daniel Bachler, Ernst van Woerden, Daniel Gavrilov, Marcel Gerber, Matthieu Bergel, and Jason Crawford

https://ourworldindata.org/covid-deaths

## Project Details

This dataset looks at the number of confirmed deaths due to Covid-19 worldwide. 
### Total Deaths vs. Total Cases
Using MySQL Workbench 8.0, I pulled the total cases of Covid-19 and the total deaths, then calculated the percentage of deaths from Covid-19. 

![SQL Query - Deaths vs. Cases](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/1.total_cases_vs_total_deaths_query_and_result_snippet.PNG)


### Likelihood of Dying of Covid in the U.S.

Once I pulled the info on cases and percentage of deaths, I wanted to isolate the percentage of deaths in the U.S.

![SQL Query - Death Percentage in the U.S.](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/2.Liklihood_of_dying_if_Covid_is_contracted_in_US.PNG)


### Highest Death Counts by Location

To pull the total death count for each location and display the highest death counts, I had to convert "total_deaths" into an integer data type

![SQL Query - Death Count](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/3.most_deaths_by_location_per_population.PNG)


### Highest Death Count by Country

The previous query included continents with countries, so I filtered out rows that included death counts per continent. 

![SQL Query - Death Count](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/4.most_infected_country_by_population.PNG)

### Global Daily Death Percentage

I pulled the daily new cases and deaths, and calculated the death percentage per day worldwide. 

![SQL Query - Global Daily Death Percentage](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/5.total_new_cases_and_new_deaths_worldwide_each_day_and_global_daily_death_percentage.PNG)

### Global Total Death Percentage

I pulled the total sum of cases and deaths worldwide, and calculated the total global death percentage.

![SQL Query - Global Total Death Percentage](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/6.total_worldwide_cases_and_deaths_and_percentage_of_deaths.PNG)

### Running Total of Cases and Deaths per Country

I pulled a running sum total of cases and deaths per country, and calculated the running total national death percentage.

![SQL Query - Running Total of Cases and Deaths per Country](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/7.running_total_vaccinations_by_country.PNG)

### A New Method - Running Total of Cases and Deaths per Country

I pulled the running sum total of cases, deaths, and death percentage per country using a different method called a Common Table Expression (CTE).

![SQL Query - Running Total of Cases and Deaths per Country](https://github.com/bwayvs/Covid19_DataExploration/blob/main/images/8.another_way_to_create_CTE_to_show_running_total_vax_with_vax_percentage.PNG)



## Authors

- Veronica Broadway (https://bwayvs.github.io/Professional_Portfolio/)


Certainly! Here's a concise "About Me" paragraph for Veronica Broadway based on her resume:

## 🚀 About Me
I'm Veronica, a results-driven Data Analyst with expertise in SAP and process improvement. With a background in translating complex requirements into actionable insights, I leverage SQL, data visualization tools, and Agile methodologies to optimize supply chains and drive business decisions. My passion lies in turning data into meaningful business strategies, ensuring organizational alignment, and fostering cross-functional collaboration.

## 🔗 LinkedIn Profile
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/veronicabroadway/)



