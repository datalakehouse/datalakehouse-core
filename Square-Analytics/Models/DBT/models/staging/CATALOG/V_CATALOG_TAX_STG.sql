{{ config(
    transient=false,
    materialized= 'view',
    schema= 'SQUARE',
    tags= ["staging", "daily"]
    ) 
}}
 

WITH source AS (
  SELECT * FROM  {{source('DEMO_SQUARE_ALT13','CATALOG_TAX')}}
),

rename as (


SELECT DISTINCT
    --MD5 KEYS    
    MD5( TRIM(ID) ) AS K_POS_CATALOG_OBJECT_DLHK
    --BUSINESS KEYS
    ,ID AS K_POS_CATALOG_OBJECT_BK
    --ATTRIBUTES
    ,NAME AS A_POS_PRODUCT_NAME
    ,COALESCE(NAME, 'N/A') AS A_POS_PRODUCT_SUB_NAME
    ,INCLUSION_TYPE AS A_POS_TAX_INCLUSION_TYPE
    ,PERCENTAGE AS A_POS_TAX_PERCENTAGE
    ,'TAX' AS A_POS_CATEGORY_NAME
    ,'CATALOG TAX' AS A_POS_USAGE
    ,0.00::decimal(15,2) AS M_POS_ITEM_BASE_COST_AMT
    ,0.00::decimal(15,2) AS M_POS_ITEM_BASE_PRICE_AMT
    ,0.00::decimal(15,2) AS M_POS_PRICE_AMT
    ,'USD' AS POS_PRICE_CCY
    --BOOLEAN
    ,ENABLED AS B_IS_ENABLED
    --METADATA (MD)
    ,CURRENT_TIMESTAMP AS MD_LOAD_DTS        
    ,'{{invocation_id}}' AS MD_INTGR_ID
FROM
    source
)

SELECT * FROM rename