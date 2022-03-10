
  create or replace  view DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ORDERS_ADJUSTMENT_STG  as (
    

WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SHOPIFY."ORDER_ADJUSTMENT" AS A
),
rename AS 
(
SELECT
  --dlhk 
  MD5(ID) AS K_ORDER_ADJUSTMENT_DLHK
  --BK
  ,ID AS K_ORDER_ADJUSTMENT_BK
  ,ORDER_ID AS K_ORDER_BK
  ,REFUND_ID AS K_REFUND_BK
  --ATTRIBUTE
  ,KIND AS A_KIND
  ,REASON AS A_REASON
  --METRIC
  ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.TAX_AMOUNT_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.TAX_AMOUNT_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TAX_AMOUNT
  ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.AMOUNT_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.AMOUNT_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_AMOUNT
  ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.TAX_AMOUNT_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.TAX_AMOUNT_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TAX_AMOUNT_PRIMARY
  ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.AMOUNT_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.AMOUNT_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_AMOUNT_PRIMARY
   --METADATA (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'cc5603df-43e1-42fa-bf2e-6c12e9f40242' AS MD_INTGR_ID
FROM source O  
)

SELECT * FROM rename
  );
