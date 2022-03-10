{{ config(
    transient=false,
    materialized= 'view',
    schema= 'SNOWFLAKE_USAGE',
    tags= ["staging", "daily"]
    ) 
}}
 

WITH source AS (
  SELECT * FROM  {{source('ACCOUNT_USAGE','QUERY_HISTORY')}}
),
rename as (
   SELECT DISTINCT 
  MD5(S.WAREHOUSE_ID) AS K_WAREHOUSE_DLHK 
  ,S.WAREHOUSE_ID AS K_WAREHOUSE_BK
  ,S.WAREHOUSE_NAME
  ,S.WAREHOUSE_SIZE
  ,S.WAREHOUSE_TYPE  
FROM source S
     
)

SELECT * FROM rename