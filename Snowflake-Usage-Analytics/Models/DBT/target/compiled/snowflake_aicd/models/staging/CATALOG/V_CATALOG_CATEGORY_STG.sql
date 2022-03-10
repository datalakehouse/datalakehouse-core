
 

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
        , '332077f0-b704-49c0-95db-12a9be86df04' AS MD_INTGR_ID
FROM
    source
)

SELECT * FROM rename