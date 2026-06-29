-- -- use sysadmin role.
-- use role sysadmin;

-- create warehouse if not exists new_wh
--      comment = 'This is the adhoc-wh'
--      warehouse_size = 'x-small' 
--      auto_resume = true 
--      auto_suspend = 60 
--      enable_query_acceleration = false 
--      warehouse_type = 'standard' 
--      min_cluster_count = 1 
--      max_cluster_count = 1 
--      scaling_policy = 'standard'
--      initially_suspended = true;

-- create development sandbox database/schema if does not exist
create database if not exists Appolo_hc;
use database Appolo_hc;

-- create all 4 schema objects.
create schema if not exists dev_stage_sch;
create schema if not exists dev_trusted_sch;
create schema if not exists dev_provision_sch;
create schema if not exists control_sch;

-- change the schema context
use schema control_sch;

 -- create file format to process the CSV file
 
CREATE OR REPLACE FILE FORMAT APPOLO_HC.CONTROL_SCH.CSV_FILE_FORMAT
  TYPE = 'CSV'
  COMPRESSION = 'AUTO'
  FIELD_DELIMITER = ','
  RECORD_DELIMITER = '\n'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '\042'  -- Double quotes (ASCII 42)
  NULL_IF = ('\\N')
  DATE_FORMAT = 'YYYY-MM-DD'  -- Change to match YYYY-MM-DD format
  TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS' -- Change to match YYYY-MM-DD HH24:MI:SS format
  ENCODING = 'ISO8859_1';  -- or 'UTF-16', if applicable;  

CREATE OR REPLACE FILE FORMAT APPOLO_HC.CONTROL_SCH.PARQUET_FILE_FORMAT
TYPE = 'PARQUET'
COMPRESSION = 'SNAPPY';


-- -- create snowflake internal stage
-- create stage dev_stage_sch.csv_stg
--     directory = ( enable = true )
--     comment = 'this is the snowflake internal stage';

show stages;

-- drop stage EXTERNAL_AWS_STAGE;

CREATE OR REPLACE STORAGE INTEGRATION S3_INT
  TYPE = EXTERNAL_STAGE  
  STORAGE_PROVIDER = S3  
  ENABLED = TRUE  
  STORAGE_AWS_ROLE_ARN = '  '  
  STORAGE_ALLOWED_LOCATIONS = (' ');  
  -- Restricts Snowflake's access to only this S3 bucket

 show integrations;
 
Desc integration S3_INT;

SELECT metadata$filename, metadata$file_row_number
FROM @ext_stage_storage_int (FILE_FORMAT => 'APPOLO_HC.CONTROL_SCH.CSV_FILE_FORMAT');


CREATE OR REPLACE STAGE ext_stage_storage_int
  STORAGE_INTEGRATION = S3_INT  -- Links to the storage integration
  URL = 's3://snowbucketkrishna1/Sftp/'; -- Specifies the S3 bucket location

List @ext_stage_storage_int;

-- executed till above



