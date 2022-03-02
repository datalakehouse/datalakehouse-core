{{ config (
  materialized= 'view',
  schema= 'QUICKBOOKS',
  tags= ["staging", "daily"]
)
}}

WITH source AS (
  SELECT 
  * 
  FROM  	
    {{source('DEMO_QUICKBOOKS','EMPLOYEE')}}
),
rename AS 
(   
SELECT 
    --MD5
    MD5( TRIM(COALESCE(ID, '00000000000000000000000000000000')) ) AS K_EMPLOYEE_DLHK
    --BUSINESS KEYS
    ,ID AS K_EMPLOYEE_BK    
    ,ADDRESS_ID AS K_ADDRESS_BK
    --ATTRIBUTES
    ,{{full_name('GIVEN_NAME','MIDDLE_NAME', 'FAMILY_NAME')}} AS A_FULL_NAME
    ,GIVEN_NAME AS A_GIVEN_NAME
    ,MIDDLE_NAME AS A_MIDDLE_NAME
    ,FAMILY_NAME AS A_FAMILY_NAME
    ,DISPLAY_NAME AS A_DISPLAY_NAME
    ,EMPLOYEE_NUMBER AS A_EMPLOYEE_NUMBER
    ,ACTIVE AS A_ACTIVE      
    ,PRINT_ON_CHECK_NAME AS A_PRINT_ON_CHECK_NAME
    ,EMAIL AS A_EMAIL    
    ,PHONE_NUMBER AS A_PHONE_NUMBER    
    ,MOBILE_PHONE AS A_MOBILE_NUMBER
    ,RELEASED_DATE::DATE AS A_RELEASED_DATE
    ,HIRED_DATE::DATE AS A_HIRED_DATE
    ,BIRTH_DATE::DATE AS A_BIRTH_DATE
    ,SOCIAL_SECURITY_NUMBER AS A_SOCIAL_SECURITY_NUMBER    
    ,SYNC_TOKEN AS A_SYNC_TOKEN
    --TIMESTAMP
    ,CREATED_AT AS A_CREATED_AT_DTS
    ,UPDATED_AT AS A_UPDATED_AT_DTS        
    --METADATA
    ,CURRENT_TIMESTAMP as MD_LOAD_DTS
    ,'{{invocation_id}}' AS MD_INTGR_ID
  FROM
      source    
)


SELECT * FROM rename