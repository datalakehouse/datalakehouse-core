 {{ config(
    materialized='view',    
    schema='DOORDASH'
) }}

SELECT    
    COUNTRY AS A_COUNTRY_NAME,
    ALPHA2_CODE AS A_ALPHA2_COUNTRY_CODE,
    ALPHA3_CODE AS A_ALPHA3_COUNTRY_CODE        
FROM
    {{source('TEST_SCHEMA_EXT_DEV','COUNTRY_CODES')}}