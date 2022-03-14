{{ config(
    transient=false,
    materialized= 'view',
    schema= 'SNOWFLAKE_USAGE',
    tags= ["staging", "daily"]
    ) 
}}
 

WITH source AS (
  SELECT * FROM  {{source(var('account_usage_schema'),'WAREHOUSE_METERING_HISTORY')}}
),
rename as (
   SELECT 
  MD5(WAREHOUSE_ID) AS K_WAREHOUSE_DLHK
  ,WAREHOUSE_ID AS K_WAREHOUSE_BK
  ,START_TIME AS A_START_TIME
  ,END_TIME AS A_END_TIME
  ,WAREHOUSE_NAME AS A_WAREHOUSE_NAME  
  ,CREDITS_USED AS M_CREDITS_USED
  ,CREDITS_USED_CLOUD_SERVICES AS M_CREDITS_USED_CLOUD_SERVICES
  ,CREDITS_USED_COMPUTE AS M_CREDITS_USED_COMPUTE  
FROM source S    
)

SELECT * FROM rename