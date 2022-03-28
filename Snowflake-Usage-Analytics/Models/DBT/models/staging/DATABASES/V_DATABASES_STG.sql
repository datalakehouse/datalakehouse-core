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
    {{source(var('account_usage_schema'),'DATABASES')}}
),
rename AS 
(   
  SELECT 
  --DLHK
  MD5(S.DATABASE_ID) AS K_DATABASE_DLHK  
  --BUSINESS KEYS  
  ,DATABASE_ID AS K_DATABASE_BK
  --ATTRIBUTES
  ,DATABASE_NAME AS A_DATABASE_NAME
  ,DATABASE_OWNER AS A_DATABASE_OWNER
  ,COMMENT AS A_COMMENT
  ,LAST_ALTERED AS A_LAST_ALTERED_AT_DTS
  ,S.CREATED AS A_CREATED_AT_DTS
  ,S.DELETED AS A_DELETED_AT_DTS
  --BOOLEAN
  ,NOT(IS_TRANSIENT='NO') AS B_IS_TRANSIENT
  --METRICS
  ,RETENTION_TIME AS M_RETENTION_TIME  
  --//metadata (MD)
  ,S.DELETED IS NOT NULL AS MD_IS_DELETED
  ,CURRENT_TIMESTAMP as MD_ELT_UPDATED_DTS
  ,'{{invocation_id}}' AS MD_INTGR_ID

  FROM
    source S
)


SELECT * FROM rename