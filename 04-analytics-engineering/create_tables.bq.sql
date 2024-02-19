-- #####################################################################################################################################
-- CREATE EXTERNAL TABLES USING GCS
-- #####################################################################################################################################
-- Yellow
CREATE OR REPLACE EXTERNAL TABLE `spikes-268805.taxi_rides_ny.external_yellow_tripdata`
OPTIONS (
  format = 'CSV',
  compression = 'GZIP',  -- Specify the compression type
  uris = [
    'gs://mage-zoom-andres/yellow/yellow_tripdata_2019-*.csv.gz',
    'gs://mage-zoom-andres/yellow/yellow_tripdata_2020-*.csv.gz'
  ]
);
-- green
CREATE OR REPLACE EXTERNAL TABLE `spikes-268805.taxi_rides_ny.external_green_tripdata`
OPTIONS (
  format = 'CSV',
  compression = 'GZIP',  -- Specify the compression type
  uris = [
    'gs://mage-zoom-andres/green/green_tripdata_2019-*.csv.gz',
    'gs://mage-zoom-andres/green/green_tripdata_2020-*.csv.gz'
  ]
);
-- fhv
CREATE OR REPLACE EXTERNAL TABLE `spikes-268805.taxi_rides_ny.external_fhv_tripdata`
OPTIONS (
  format = 'CSV',
  compression = 'GZIP',  -- Specify the compression type
  uris = [
    'gs://mage-zoom-andres/fhv/fhv_tripdata_2019-*.csv.gz',
    'gs://mage-zoom-andres/fhv/fhv_tripdata_2020-*.csv.gz'
  ]
);

-- #####################################################################################################################################
-- Check Data
-- #####################################################################################################################################
-- Check yellow trip data
SELECT * FROM spikes-268805.taxi_rides_ny.external_yellow_tripdata limit 10;
-- Check green trip data
SELECT * FROM spikes-268805.taxi_rides_ny.external_green_tripdata limit 10;
-- Check fhv trip data
SELECT * FROM spikes-268805.taxi_rides_ny.external_fhv_tripdata limit 10;

-- #####################################################################################################################################
-- Create partition tables
-- #####################################################################################################################################
-- Create a partitioned Yellow table from external table
CREATE OR REPLACE TABLE spikes-268805.taxi_rides_ny.yellow_tripdata_partitoned
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * FROM spikes-268805.taxi_rides_ny.external_yellow_tripdata;

-- Create a partitioned Green table from external table
CREATE OR REPLACE TABLE spikes-268805.taxi_rides_ny.green_tripdata_partitoned
PARTITION BY
  DATE(lpep_pickup_datetime) AS
SELECT * FROM spikes-268805.taxi_rides_ny.external_green_tripdata;

-- Create a partitioned FHV table from external table
CREATE OR REPLACE TABLE spikes-268805.taxi_rides_ny.fhv_tripdata_partitoned
PARTITION BY
  DATE(pickup_datetime) AS
SELECT * FROM spikes-268805.taxi_rides_ny.external_fhv_tripdata;


-- Creating a partition and cluster table
CREATE OR REPLACE TABLE spikes-268805.taxi_rides_ny.yellow_tripdata_partitoned_clustered
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * FROM spikes-268805.taxi_rides_ny.external_yellow_tripdata;
