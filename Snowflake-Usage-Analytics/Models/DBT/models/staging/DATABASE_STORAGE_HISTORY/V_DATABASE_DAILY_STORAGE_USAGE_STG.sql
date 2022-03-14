{{ config(
    transient=false,
    materialized= 'view',
    schema= 'SNOWFLAKE_USAGE',
    tags= ["staging", "daily"]
    ) 
}}
 

WITH source AS (
  SELECT * FROM  {{source('ACCOUNT_USAGE','DATABASE_STORAGE_USAGE_HISTORY')}}
),

rename as (
   SELECT 
    MD5(S.USAGE_DATE::STRING) AS K_DATABASE_STORAGE_USAGE_DLHK
    ,S.USAGE_DATE AS A_USAGE_DATE
    ,MD5(DATABASE_ID) AS K_DATABASE_DLHK
    ,DATABASE_ID AS K_DATABASE_BK
    ,S.AVERAGE_DATABASE_BYTES AS M_AVERAGE_DATABASE_BYTES
    ,S.AVERAGE_FAILSAFE_BYTES AS M_AVERAGE_FAILSAFE_BYTES    

    ,(AVERAGE_DATABASE_BYTES / power(1024, 4))::NUMERIC(15,6)  AS M_AVERAGE_DATABASE_TERABYTES
    ,(AVERAGE_FAILSAFE_BYTES / power(1024, 4))::NUMERIC(15,6) AS M_AVERAGE_FAILSAFE_TERABYTES    

    ,((AVERAGE_DATABASE_BYTES + AVERAGE_FAILSAFE_BYTES) / power(1024, 4))::NUMERIC(15,6) as M_BILLABLE_TB    
    ,DELETED AS MD_VALID_TO_DTS
    ,DELETED IS NOT NULL AS MD_IS_DELETED
    , CURRENT_TIMESTAMP AS MD_ELT_UPDATED_DTS        
    , '{{invocation_id}}' AS MD_INTGR_ID
FROM source S
)

SELECT * FROM rename