

WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SHOPIFY."ORDER_LINE_ITEM_TAX_LINE" AS A
),
rename AS 
(
SELECT
  CONCAT(COALESCE(ORDER_ID,'0000000000'),'-',COALESCE(ORDER_LINE_ID,'0000000000')) AS K_ORDER_LINE_ITEM_TAX_DLHK
  ,ORDER_ID AS K_ORDER_BK
  ,ORDER_LINE_ID AS K_ORDER_LINE_ITEM_BK
  ,TITLE AS A_TITLE
  ,CHANNEL_LIABLE AS B_CHANNEL_LIABLE
  ,RATE AS M_RATE
  ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TAX
  ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TAX_PRIMARY
   --METADATA (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'cc5603df-43e1-42fa-bf2e-6c12e9f40242' AS MD_INTGR_ID
FROM source O  
)

SELECT * FROM rename