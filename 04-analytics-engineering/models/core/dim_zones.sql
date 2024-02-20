{{ 
    config(
        materialized='table',
        schema='dim_zones',
    )
}}


select 
    locationid, 
    borough, 
    zone, 
    replace(service_zone,'Boro','Green') as service_zone 
from {{ ref('taxi_zone_lookup') }}