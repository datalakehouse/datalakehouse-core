{{ config (
  materialized= 'view',
  schema= 'XERO',
  tags= ["staging","daily"]
)
}}

WITH source AS (
  SELECT 
  * 
  FROM  	
    {{source('DEMO_XERO','BRANDING_THEME')}}
),
rename AS 
(   
SELECT 
    --MD5
    MD5( TRIM(COALESCE(A.BRANDING_THEME_ID,'00000000000000000000000000000000')) ) AS K_BRANDING_THEME_DLHK    
    --BUSINESS KEYS
    ,A.BRANDING_THEME_ID AS K_BRANDING_THEME_BK    
    --ATTRIBUTES
    ,A.NAME AS A_BRANDING_THEME_NAME
    ,A.SORT_ORDER AS A_SORT_ORDER
    ,A.CREATED_DATE_UTC AS A_CREATED_AT_DTS    
    --METADATA
    ,CURRENT_TIMESTAMP as MD_LOAD_DTS
    ,'{{invocation_id}}' AS MD_INTGR_ID
  FROM
    source  A    
)


SELECT * FROM rename