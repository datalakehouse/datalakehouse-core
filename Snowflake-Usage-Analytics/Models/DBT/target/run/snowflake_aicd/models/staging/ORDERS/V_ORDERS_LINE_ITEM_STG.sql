
  create or replace  view DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ORDERS_LINE_ITEM_STG  as (
    

WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SHOPIFY."ORDER_LINE_ITEM" AS A
),
products AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DBT_SHOPIFY.W_PRODUCTS_D AS A
),
taxes AS (
  SELECT 
      K_ORDER_LINE_ITEM_BK,
      AVG(M_RATE) AS M_RATE,
      SUM(M_TAX) AS M_TAX,
      SUM(M_TAX_PRIMARY) AS M_TAX_PRIMARY
    FROM 
      DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ORDER_LINE_ITEM_TAX_LINE_STG AS A
    GROUP BY K_ORDER_LINE_ITEM_BK
),
rename AS 
(
SELECT
  --dlhk 
  MD5(ID) AS K_ORDER_LINE_ITEM_DLHK  
  ,MD5(ORDER_ID) AS K_ORDER_DLHK
  ,P.K_PRODUCT_VARIATION_DLHK
 --business keys
  ,O.PRODUCT_ID AS K_PRODUCT_BK
  ,O.VARIANT_ID AS K_VARIANT_BK
  
  ,O.ORDER_ID AS K_ORDER_BK
  ,O.ID AS K_ORDER_LINE_ITEM_BK
  --attribubtes
  ,O.FULFILLMENT_SERVICE AS A_FULFILLMENT_SERVICE
  ,O.FULFILLMENT_STATUS AS A_FULFILLMENT_STATUS
  ,O.NAME AS A_NAME  
  ,O.PROPERTIES AS A_PROPERTIES
  ,O.SKU AS A_SKU
  ,O.TITLE AS A_TITLE  
  ,O.VARIANT_INVENTORY_MANAGEMENT AS A_VARIANT_INVENTORY_MANAGEMENT
  ,O.VARIANT_TITLE AS A_VARIANT_TITLE
  ,O.VENDOR AS A_VENDOR
  --boolean
  ,O.GIFT_CARD AS B_GIFT_CARD
  ,O.PRODUCT_EXISTS AS B_PRODUCT_EXISTS
  ,O.REQUIRES_SHIPPING AS B_REQUIRES_SHIPPING
  ,O.TAXABLE AS B_TAXABLE
  --metrics
  ,O.FULFILLABLE_QUANTITY AS M_FULFILLABLE_QUANTITY
  ,O.GRAMS::DECIMAL(15,2) AS M_GRAMS
  ,O.QUANTITY::DECIMAL(15,2) AS M_QUANTITY
  ,M_RATE AS M_TAX_RATE
  ,COALESCE(T.M_TAX_PRIMARY,0)::DECIMAL(15,2) AS M_TAX_AMOUNT
  ,COALESCE(T.M_TAX,0)::DECIMAL(15,2) AS M_TAX_AMOUNT_PRIMARY

  ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_UNIT_PRICE
  ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_UNIT_PRICE_PRIMARY 
  ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNT_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNT_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_DISCOUNT
  ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNT_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNT_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_DISCOUNT_PRIMARY 
  ,(O.QUANTITY * M_UNIT_PRICE)::DECIMAL(15,2) AS M_TOTAL_PRICE  
  ,(O.QUANTITY * M_UNIT_PRICE_PRIMARY)::DECIMAL(15,2) AS M_TOTAL_PRICE_PRIMARY
   --METADATA (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'cc5603df-43e1-42fa-bf2e-6c12e9f40242' AS MD_INTGR_ID
FROM source O
  left join products P ON P.K_PRODUCT_BK = O.PRODUCT_ID AND CASE WHEN O.VARIANT_ID IS NOT NULL THEN O.VARIANT_ID = P.K_PRODUCT_VARIANT_BK ELSE 1=1 END
  left join taxes T ON T.K_ORDER_LINE_ITEM_BK = O.ID
)

SELECT * FROM rename
  );
