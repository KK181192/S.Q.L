SELECT * FROM accidents;
SELECT * FROM vehicles;

-- QUES 1. HOW MANY ACCIDENTS HAVE OCCURED IN URBAN AREAS VS RURAL AREAS?
select area, count(accidentindex) as 'No of Accidents' from accidents group by area;

-- QUES 2. WHICH DAY OF THE WEEK HAS THE HIGHEST NUMBER OF ACCIDENTS??
select day, count(accidentindex) as 'No of Accidents' from accidents group by day
order by count(accidentindex) desc;

-- QUES 3. WHAT IS THE AVERAGE AGE OF VEHICLES INVOLVED IN ACCIDENTS BASED ON THEIR TYPE??
select vehicletype as "Vehicle Type", round(avg(agevehicle),1) as "Vehicle Average Age" from vehicles where AgeVehicle is not null
group by VehicleType order by avg(AgeVehicle) desc;

-- QUES 4. CAN WE IDENTIFY TRENDS IN ACCIDENTS BASED ON THE AGE OF VEHICLES INVOLVED??
select agevehicle, case 
when agevehicle between 0 and 5 then "New"
when agevehicle between 5 and 10 then "Regular"
else "Old" end as "Age Category", count(VehicleID) as "Vehicle Type" from vehicles
where agevehicle is not null;

select agevehicle, count(VehicleID) as "No of Vehicles" from vehicles where agevehicle is not null
group by AgeVehicle order by AgeVehicle desc;

-- QUES 5. ARE THERE ANY SPECIFIC WEATHER CONDITIONS THAT CONTRIBUTES TO SEVERE ACCIDENTS?
select weatherconditions, count(severity) as "serious/fatal" from accidents where severity <> "Slight"
group by weatherconditions order by count(severity) desc limit 5;

-- QUES 6. DO ACCIDENTS OFTEN INVOLVE IMPACTS ON THE LEFT HAND SIDE OF VEHICLES?

select lefthand, count(vehicleid) as "No of Vehicles" from vehicles group by lefthand;

-- QUES 7. ARE THERE ANY RELATIONSHIPS BETWEEN JOURNEY PURPOSES AND THE SEVERITY OF ACCIDENTS?