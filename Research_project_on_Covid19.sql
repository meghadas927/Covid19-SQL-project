create database Covid19;  -- create new database Covid19
use Covid19;              -- /*makes this database default*/

-- Using table data import wizard We have to import the following tables from CSV files:
-- Right click on the tables and select "Table Data Import Wizard" under the Covid19 database name in schemas 
-- list on the left hand side of the screen).

-- covid_19_india
-- covid_19_World

select * from covid_19_india;
select * from covid_19_World;

-- add new column New_date in tables
-- update New_date with translated date from Date using string to date function

alter table covid_19_india
add column New_date date;
set sql_safe_updates =0    -- To disabled the safe update mode

Update covid_19_india
set New_date = str_to_date(Date,"%d-%m-%Y");

alter table covid_19_World
add column New_date date;
set sql_safe_updates =0

Update covid_19_World
set New_date = str_to_date(Date,"%d-%m-%Y");


 -- Total confirmed,cured and deaths cases of 2020 in india
 
 select sum(confirmed) as confirmed,sum(cured) as cured, sum(deaths) as deaths
 from covid_19_india
 where New_date = "2020-12-31";
 
  -- Total confirmed,cured and deaths cases of 2021 in india
 
 select sum(confirmed) as confirmed,sum(cured) as cured, sum(deaths) as deaths
 from covid_19_india
 where New_date = "2021-08-11";
    

-- Total Confirmed cases in India in 2020
 
 Select Sum(confirmed) into @Total_confirmed_case2020
 from covid_19_india
 where New_date = "2020-08-11";
 
 select @Total_confirmed_case2020;
 
 -- Total Confirmed cases in India in 2021
 
 Select Sum(confirmed) into @Total_confirmed_case2021
 from covid_19_india
 where New_date = "2021-08-11";
 
 select @Total_confirmed_case2021;
 
 -- Total confirmed cases in 2020 and 2021
 
 select round((@Total_confirmed_case2021+@Total_confirmed_case2020),0) as Total_confirmed_case
 
 -- Difference Between 2020 and 2021
 
 select round((@Total_confirmed_case2021-@Total_confirmed_case2020),0) as Difference_between_2020and2021,
 if (@Total_confirmed_case2021>@Total_confirmed_case2020, "2021 had more confirmed cases","2020 had more confirmed cases")
 as status 
 from covid_19_india
 limit 1;
 
 -- which state had more confirmed cases in India in 2020

 select State_UnionTerritory,confirmed
 from covid_19_india
 where New_date = "2020-12-31"
 order by 2 desc
 limit 1;
 
 
 -- which state had less confirmed cases in India in 2020
 
 select State_UnionTerritory,confirmed
 from covid_19_india
 where New_date = "2020-12-31"
 order by 2 asc
 limit 1;
 
  -- which month of 2021 More no of people died in India

select Monthname(New_date) as Month,sum(deaths) as deaths
from covid_19_india
where extract(year from new_date) = "2021"
group by Monthname(New_date)
order by 2 desc
limit 1;

 -- confirmed,recovered,active and deaths cases in 2020 of the world 
 
 select sum(confirmed) as Confirmed,sum(recovered) as Recovered,sum(active) as Active, sum(deaths) as Deaths
 from covid_19_world
 where new_date = "2020-06-18";
 
 -- Cured percentage rate of india in 2020 June

select round(sum(cured)/sum(confirmed)*100,0) as Percentage_Ofcured_rate_in_India
from covid_19_india
where New_date = "2020-06-18";

-- Cured percentage rate of world in 2020 June

select round(sum(Recovered)/sum(confirmed)*100,0) as Percentage_Ofcured_rate_in_world
from covid_19_world
where New_date = "2020-06-18" and country_region <> "india";

-- which country had affected more in covid19 in 2020

select Country_Region,sum(confirmed) as Confirmed_cases
from covid_19_world
where new_date = "2020-06-18"
group by Country_Region
order by 2 desc
limit 1;