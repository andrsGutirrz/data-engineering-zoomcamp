{{
    config(
        materialized='view',
        schema='stg_fhv_trips',
    )
}}

with trip_data as 
(
  select 
    dispatching_base_num as dispatching_base_num,
    pickup_datetime as pickup_datetime,
    dropOff_datetime as drop_off_datetime,
    PUlocationID as pu_location_id,
    DOlocationID as do_location_id,
    SR_Flag as sr_flag,
    Affiliated_base_number as affiliated_base_number
  from {{ source('staging','fhv_tripdata_partitoned') }}
)

select 
    dispatching_base_num,
    pickup_datetime,
    drop_off_datetime,
    pu_location_id,
    do_location_id,
    sr_flag,
    affiliated_base_number
from trip_data
where EXTRACT(YEAR FROM pickup_datetime) = 2019
