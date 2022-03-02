{{ config (
  materialized= 'view',
  schema= 'DOORDASH',
  tags= ["staging","daily"]
)
}}

WITH source AS (
  SELECT * FROM  {{source('TEST_SCHEMA_EXT_DEV','DOORDASH_RAW')}}
),
rename AS 
(
SELECT DISTINCT 
  BUDGET_ID AS K_BUDGET_BK
  ,BUDGET_NAME AS A_BUDGET_NAME
  , CURRENT_TIMESTAMP() MD_ELT_UPDATED_DTS
FROM 
  source
)

SELECT * FROM rename