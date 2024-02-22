-- ############################################################################################################
-- Question 3
select 
count(*)
from spikes-268805.dbt_agutierrez_fact_trips_fhv.fact_trips_fhv
-- Retreives 22998722

-- ############################################################################################################

-- Question 4
-- Get data from green and yellow taxis
select 
service_type, 
count(service_type)
from spikes-268805.dbt_agutierrez_fact_trips.fact_trips ft
WHERE 
EXTRACT(YEAR FROM pickup_datetime) = 2019 
AND EXTRACT(MONTH FROM ft.pickup_datetime) = 7
group by ft.service_type;
-- Retrieves
--service_type, count
--  Green, 397605
--  Yellow, 3247091

-- get data from FHV
select 
count(*)
from spikes-268805.dbt_agutierrez_fact_trips_fhv.fact_trips_fhv
WHERE 
EXTRACT(YEAR FROM pickup_datetime) = 2019 
AND EXTRACT(MONTH FROM pickup_datetime) = 7
;
-- Retrieves: 290680
-- THEN, Yellow have more trips
3247091 > 290680 > 397605

-- ############################################################################################################