{{ config (
  materialized= 'view',
  schema= 'SNOWFLAKE_USAGE',
  tags= ["staging", "daily"]
)
}}

WITH source AS (
  SELECT 
  * 
  FROM  	
    {{source(var('organization_usage_schema'),'RATE_SHEET_DAILY')}}
),
rename AS 
(   
  SELECT 
  DATE AS A_DATE  
  ,MD5(ACCOUNT_LOCATOR) AS K_ACCOUNT_DLHK  
  ,ACCOUNT_LOCATOR AS K_ACCOUNT_BK
  ,ACCOUNT_NAME AS A_ACCONT_NAME
  ,CURRENCY AS A_CURRENCY  
  ,ORGANIZATION_NAME AS A_ORGANIZATION_NAME
  ,REGION AS A_REGION
  ,SERVICE_LEVEL AS A_SERVICE_LEVEL
  ,SERVICE_TYPE AS A_SERVICE_TYPE
  ,USAGE_TYPE AS A_USAGE_TYPE
  ,CONTRACT_NUMBER AS M_CONTRACT_NUMBER
  ,EFFECTIVE_RATE AS M_EFFECTIVE_RATE
  --//metadata (MD)  
  ,CURRENT_TIMESTAMP as MD_ELT_UPDATED_DTS
  ,'{{invocation_id}}' AS MD_INTGR_ID

  FROM
    source S
)


SELECT * FROM rename