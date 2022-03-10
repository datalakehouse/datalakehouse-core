
  create or replace  view DEVELOPER_SANDBOX.DBT_SQUARE.V_CATALOG_ITEM_VARIATION2_STG  as (
    
 
 SELECT  DISTINCT
 --MD5 KEYS        
        K_POS_CATALOG_OBJECT_DLHK AS K_POS_CATALOG_OBJECT_VARIATION_DLHK    
            
        ,K_POS_CATALOG_OBJECT_ITEM_DLHK AS K_POS_CATALOG_OBJECT_DLHK      
        --BUSINESS KEYS
        ,K_POS_CATALOG_OBJECT_BK AS K_POS_CATALOG_OBJECT_VARIATION_BK   
        ,COALESCE(K_POS_LOCATION_BK,'N/A') AS K_POS_LOCATION_BK
        ,K_POS_CATALOG_OBJECT_ITEM_BK AS K_POS_CATALOG_OBJECT_BK
        --DESCRIPTION
        ,A_POS_PRODUCT_NAME AS A_POS_PRODUCT_NAME
        ,COALESCE(A_POS_ORDER_LINE_VARIATION_NAME, 'N/A') AS A_POS_PRODUCT_SUB_NAME
        ,A_POS_CATEGORY_NAME AS A_POS_CATEGORY_NAME
        , 'ORDER LINE ITEM VARIATION' AS A_POS_USAGE
        ,A_POS_VARIATION_PRICE_MONEY_CURRENCY AS A_POS_VARIATION_PRICE_MONEY_CURRENCY
        --METRIC
        ,M_POS_ITEM_VARIATION_PRICE_MONEY_AMOUNT AS M_POS_PRICE_MONEY_AMOUNT
        --metadata (MD)
        , CURRENT_TIMESTAMP AS MD_LOAD_DTS        
        , '4fe1054d-4eb3-433b-8726-3f10a5e744eb' AS MD_INTGR_ID
FROM DEVELOPER_SANDBOX.DBT_SQUARE.V_ORDER_LINE_ITEM_STG
  );