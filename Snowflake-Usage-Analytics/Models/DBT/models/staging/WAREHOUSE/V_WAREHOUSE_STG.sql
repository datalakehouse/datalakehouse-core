{{ config(
    transient=false,
    materialized= 'view',
    schema= 'SNOWFLAKE_USAGE',
    tags= ["staging", "daily"]
    ) 
}}
 

WITH source AS (
  SELECT * FROM  {{source(var('account_usage_schema'),'QUERY_HISTORY')}}
),
rename as (
  SELECT DISTINCT 
  MD5(S.WAREHOUSE_ID) AS K_WAREHOUSE_DLHK 
  ,S.WAREHOUSE_ID AS K_WAREHOUSE_BK  
  ,S.WAREHOUSE_NAME AS A_WAREHOUSE_NAME  
FROM 
  source S
WHERE 
  S.WAREHOUSE_ID IS NOT NULL
     
)

SELECT * FROM rename