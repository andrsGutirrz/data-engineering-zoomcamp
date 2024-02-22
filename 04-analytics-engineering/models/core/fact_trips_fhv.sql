{{ 
    config(
        materialized='table',
        schema='fact_trips_fhv',
    )
}}

with stg_fact_fhv_trips as (
    select
        dispatching_base_num,
        pickup_datetime,
        drop_off_datetime,
        pu_location_id,
        do_location_id,
        sr_flag,
        affiliated_base_number
    from {{ ref('stg_fhv_trips') }}
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    -- stg_fact_fhv_trips
    stg_fact_fhv_trips.dispatching_base_num,
    stg_fact_fhv_trips.sr_flag,
    stg_fact_fhv_trips.affiliated_base_number,
    -- Zone
    pickup_zone.borough as pickup_borough,
    pickup_zone.zone as pickup_zone,
    dropoff_zone.borough as dropoff_borough,
    dropoff_zone.zone as dropoff_zone,
from stg_fact_fhv_trips
inner join dim_zones as pickup_zone
on stg_fact_fhv_trips.pu_location_id = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on stg_fact_fhv_trips.do_location_id = dropoff_zone.locationid