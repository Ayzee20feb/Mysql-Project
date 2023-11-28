              --- Analyze the tourism effect on economic growth
      --- 2019-2023 (Monthly depart. intertaional & domestic)           
 Select * from  worldtourism.`int-tourist-monthly-emissions-international-and-domestic-flights`
 where Year like '%%2021' ;
 
	--- Changing a column name By Alter table
Alter table worldtourism.`int-tourist-monthly-emissions-international-and-domestic-flights`
Change  Day Year text;

    --- Filter only 2021 data By sum up  the monthly departure to find yearly departure numbers
select Entity,Sum(`Monthly departure-domestic aviation`)as`Monthly departure-domestic aviation`,
Sum(`Monthly departure-international aviation`)as `Monthly departure-international aviation` 
from worldtourism.`int-tourist-monthly-emissions-international-and-domestic-flights`
where Year like '%%2021'
group by entity;

    --- Data Cleaning
Delete From worldtourism.`int-tourist-monthly-emissions-international-and-domestic-flights`
where Entity in("Africa","Asia","Europe","Oceania","world");




    --- 2019-2021  (Regional Tourism details)
select * from worldtourism.`international-tourist-arrivals-by-region-of-origin`
where Year like '%%2021';

   
   
   --- 2015-2021
Select *  from worldtourism.`intl-tourist-individuals-employed-in-tourism-`
where Year like '%%2021';

      --- Joining Tables based on Tourism effect on employment 
select
T.Entity,
Sum(T.`Monthly departure-domestic aviation`)as`departure-domestic aviation`,
Sum(T.`Monthly departure-international aviation`)as `departure-international aviation`,
E.`Employment (total) per 1000 people` as Employment_BasedOn_Tourism
 from worldtourism.`intl-tourist-individuals-employed-in-tourism-`as E
 Join  worldtourism.`int-tourist-monthly-emissions-international-and-domestic-flights`as T
on E.Entity=T.Entity
where E.Year like '%%2021'
Group by T.Entity, Employment_BasedOn_Tourism;


--- Rounding the average of employment with 2 decimal places
select
T.Entity,
Sum(T.`Monthly departure-domestic aviation`)as`departure-domestic aviation`,
Sum(T.`Monthly departure-international aviation`)as `departure-international aviation`,
round(`Employment (total) per 1000 people`,2)as Employment
 from worldtourism.`intl-tourist-individuals-employed-in-tourism-`as E
 Join  worldtourism.`int-tourist-monthly-emissions-international-and-domestic-flights`as T
on E.Entity=T.Entity
where E.Year like '%%2021'
Group by T.Entity,Employment;

  --- till 2021 
select * from worldtourism.`annual-gdp-growth2`
where Year like '%%2021';

       --- join table to analyze the effect of tourism on GDP
select 
T.Entity,
Sum(T.`Monthly departure-domestic aviation`)as`departure-domestic aviation`,
Sum(T.`Monthly departure-international aviation`)as `departure-international aviation`,
GDP.`Annual GDP growth (%)`
from worldtourism.`int-tourist-monthly-emissions-international-and-domestic-flights`as T
Join worldtourism.`annual-gdp-growth2`as GDP
on T.Entity=GDP.Entity
where GDP.Year like '%%2021'
Group by T.Entity,
GDP.`Annual GDP growth (%)`;


--- 1995-2021   Giving Join Below
select * from worldtourism.`international-tourist-departures-per-1000`
where Year like '%%2021';
 --- 1995-2021
select * from worldtourism.`international-tourist-trips`
where Year like '%%2021';

Select 
O.Entity,
O.Code,
O.Year,
O.`Outbound departures (tourists) per 1000 people` as `Outbound departures`,
Avg(I.`Inbound arrivals (tourists)`)as `Inbound arrivals`
from worldtourism.`international-tourist-departures-per-1000` as O
Join worldtourism.`international-tourist-trips` as I
on O.Entity=I.Entity
and  O.Year=I.Year
where O.Year like '%%2021'
and I.Year like '%%2021'
Group by O.Entity,
O.Code,
O.Year,
 `Outbound departures`;
 
 
 
--- CREATING A VIEW BY JOINING
 
 Create view  Arrival_Departure_2021
as (Select 
O.Entity,
O.Code,
O.Year,
O.`Outbound departures (tourists) per 1000 people` as `Outbound departures`,
Avg(I.`Inbound arrivals (tourists)`)as `Inbound arrivals`
from worldtourism.`international-tourist-departures-per-1000` as O
Join worldtourism.`international-tourist-trips` as I
on O.Entity=I.Entity
and  O.Year=I.Year
where O.Year like '%%2021'
and I.Year like '%%2021'
Group by O.Entity,
O.Code,
O.Year,
 `Outbound departures`);
 
 Select * from  worldtourism.`arrival_departure_2021`;
 
 
              --- Statistical analysis
 Select Entity, max(`Outbound departures`)as "MAX Departures"
 from   worldtourism.`arrival_departure_2021`
 group by entity;
 
 Select count(`Outbound departures`) as M from  worldtourism.`arrival_departure_2021`
 having max(`Outbound departures`) ;

Select Entity,Year, max(`Inbound arrivals`)as "MAX Arrivals" 
 from   worldtourism.`arrival_departure_2021`
 Group by Entity,Year;

 Select count(`Inbound arrivals`) as M from  worldtourism.`arrival_departure_2021`
 having max(`Inbound arrivals`) ;
 
  Select Entity,Year, min(`Outbound departures`)as "MAX Departures"
 from   worldtourism.`arrival_departure_2021`
 Group by Entity,Year;

Select count(`Outbound departures`) as M from  worldtourism.`arrival_departure_2021`
 having min(`Outbound departures`) ;
 
 
  Select SUM( `Outbound departures`+`Inbound arrivals`) as TOTAL_TRAVELLING from  worldtourism.`arrival_departure_2021`;
 
 
 
 
