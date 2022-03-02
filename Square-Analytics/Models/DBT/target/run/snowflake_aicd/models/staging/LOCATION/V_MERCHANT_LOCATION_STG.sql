
  create or replace  view DEVELOPER_SANDBOX.DBT_SQUARE.V_MERCHANT_LOCATION_STG  as (
    


with rename as (

  SELECT 
    --MD5 KEYS
    MD5( TRIM(CAST(ID AS VARCHAR)) ) AS K_MERCH_LOC_DLHK
    ,MD5( TRIM(CAST(MERCHANT_ID AS VARCHAR)) ) AS A_MERCHANT_ID_DLHK
    --BUSINES KEYS
    ,ID AS A_MERCH_LOC_ID_BK
    ,MERCHANT_ID AS A_MERCHANT_ID_BK
    --ATTRIBUTE
    ,NAME AS A_MERCH_LOC_NAME   
  
    ,ADDRESS_ADDRESS_LINE_1 || ';' 
    || COALESCE(ADDRESS_ADDRESS_LINE_2, '') || ';' 
    || COALESCE(ADDRESS_ADDRESS_LINE_3, '') 
    || ADDRESS_LOCALITY || ',' || ADDRESS_ADMINISTRATIVE_DISTRICT_LEVEL_1 || ' '
    || ADDRESS_POSTAL_CODE || ' ' || ADDRESS_COUNTRY
    AS A_MERCH_LOC_ADDR_FULL
    
    ,ADDRESS_LOCALITY AS A_MERCH_LOC_LOCALITY
    ,COUNTRY AS A_MERCH_LOC_COUNTRY
    ,ADDRESS_POSTAL_CODE AS A_MERCH_LOC_POSTAL_CODE
    ,BUSINESS_NAME AS A_MERCH_LOC_BIZ_NAME
    ,TYPE AS A_MERCH_LOC_TYPE
    ,STATUS AS A_MERCH_LOC_STATUS
    ,CREATED_AT AS A_MERCH_LOC_CREATED_DTS

        --//metadata (MD)
    ,CURRENT_TIMESTAMP as MD_LOAD_DTS
    ,'f023f503-a01b-4501-91a5-424921ffc4ca' AS MD_INTGR_ID

  FROM 
    DEVELOPER_SANDBOX.DEMO_SQUARE_ALT13."LOCATION" A    

)

SELECT * FROM rename


UNION

SELECT 
  MD5('00000000000000000000000000000000'), MD5('00000000000000000000000000000000')
  , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
  , NULL, 'f023f503-a01b-4501-91a5-424921ffc4ca'
--, TRUE, 1, NULL, NULL
-- , NULL, NULL, MSRC.K_MERCHANT_SOURCE_DLHK
-- FROM
--     merchant_source MSRC WHERE MSRC._id = 1
  );
