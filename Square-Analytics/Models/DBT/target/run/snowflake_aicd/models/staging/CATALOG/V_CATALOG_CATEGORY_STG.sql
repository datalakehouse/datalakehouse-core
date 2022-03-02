
  create or replace  view DEVELOPER_SANDBOX.DBT_SQUARE.V_CATALOG_CATEGORY_STG  as (
    
 

WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SQUARE_ALT13."CATALOG_CATEGORY"
),

rename as (


SELECT
       --MD5 KEYS
        MD5( ID ) AS K_POS_CATALOG_CATEGORY_DLHK        
        --BUSINESS KEYS
        ,ID AS K_POS_CATALOG_CATEGORY_BK        
        --DESCRIPTION
        ,NAME AS A_POS_PRODUCT_CATEGORY        
        --metadata (MD)
        , CURRENT_TIMESTAMP AS MD_LOAD_DTS        
        , 'f023f503-a01b-4501-91a5-424921ffc4ca' AS MD_INTGR_ID
FROM
    source
)

SELECT * FROM rename
  );
