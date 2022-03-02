
  create or replace  view DEVELOPER_SANDBOX.DBT_SQUARE.V_CURRENCY_STG  as (
    

with rename as (

SELECT
    'USD' as K_CURRENCY_BK
    , MD5('USD') AS K_CURRENCY_DLHK
    , 'USD' AS K_CURRENCY_CODE
    , 'USD' AS A_CURRENCY_NAME
    , 'United States Dollars' as A_CURRENCY_NAME_FULL
    ,'' AS MD_HASH_COL
    , 'f023f503-a01b-4501-91a5-424921ffc4ca' AS MD_INTGR_ID

UNION

SELECT
    'EUR' as K_CURRENCY_BK
    , MD5('EUR') AS K_CURRENCY_DLHK
    , 'EUR' AS K_CURRENCY_CODE
    , 'EUR' AS A_CURRENCY_NAME
    , 'Euros' as A_CURRENCY_NAME_FULL
    ,'' AS MD_HASH_COL
    , 'f023f503-a01b-4501-91a5-424921ffc4ca' AS MD_INTGR_ID

)

select * from rename
  );
