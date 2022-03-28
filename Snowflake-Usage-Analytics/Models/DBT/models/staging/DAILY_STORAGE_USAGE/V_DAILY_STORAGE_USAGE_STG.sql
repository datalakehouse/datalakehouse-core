{{ config(
    transient=false,
    materialized= 'view',
    schema= 'SNOWFLAKE_USAGE',
    tags= ["staging", "daily"]
    ) 
}}
 

WITH source AS (
  SELECT * FROM  {{source(var('account_usage_schema'),'STORAGE_USAGE')}}
),

rename as (
   SELECT 
    MD5(S.USAGE_DATE::STRING) AS K_STORAGE_USAGE_DLHK
    ,S.USAGE_DATE AS A_USAGE_DATE
    ,S.STORAGE_BYTES AS M_STORAGE_BYTES
    ,S.STAGE_BYTES AS M_STAGE_BYTES
    ,S.FAILSAFE_BYTES AS M_FAILSAFE_BYTES

    ,STORAGE_BYTES / power(1024, 4)  AS M_STORAGE_TERABYTES
    ,STAGE_BYTES / power(1024, 4)  AS M_STAGE_TERABYTES
    ,FAILSAFE_BYTES / power(1024, 4)   AS M_FAILSAFE_TERABYTES

    ,(STORAGE_BYTES + STAGE_BYTES + FAILSAFE_BYTES) / power(1024, 4) as M_BILLABLE_TB
    
    , CURRENT_TIMESTAMP AS MD_ELT_UPDATED_DTS        
    , '{{invocation_id}}' AS MD_INTGR_ID
FROM source S
)

SELECT * FROM rename