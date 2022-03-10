
  create or replace  view DEVELOPER_SANDBOX.DBT_SHOPIFY.V_REFUND_STG  as (
    


WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SHOPIFY."REFUND" AS A
),
refund_line as (
    SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SHOPIFY."REFUND_LINE_ITEM" AS A
),
rename AS 
(
SELECT
  MD5(RL.ID) AS K_REFUND_LINE_DLHK
  ,MD5(R.ID) AS K_REFUND_DLHK
  ,R.ID AS K_REFUND_BK
  ,RL.ID AS K_REFUND_LINE_BK
  ,R.ORDER_ID AS K_ORDER_BK
  ,R.USER_ID AS K_USER_BK
  ,RL.LOCATION_ID AS K_LOCATION_BK
  ,RL.LINE_ITEM_ID AS K_ORDER_LINE_ITEM_BK
  ,R.NOTE AS A_NOTE
  ,R.RESTOCK AS B_RESTOCK
  ,RL.QUANTITY AS M_QUANTITY
  ,RL.RESTOCK_TYPE AS A_RESTOCK_TYPE
   
  ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(to_numeric(get_path(parse_json(RL.SUBTOTAL_SET), 'presentment_money.amount')),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(to_numeric(get_path(parse_json(RL.SUBTOTAL_SET), 'shop_money.amount')),'0')::decimal(15,2)
END

 AS M_SUBTOTAL_PRIMARY
  ,

CASE WHEN  'original' = 'original' THEN
    coalesce(to_numeric(get_path(parse_json(RL.SUBTOTAL_SET), 'presentment_money.amount')),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(to_numeric(get_path(parse_json(RL.SUBTOTAL_SET), 'shop_money.amount')),'0')::decimal(15,2)
END

 AS M_SUBTOTAL


  ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(to_numeric(get_path(parse_json(RL.TOTAL_TAX_SET), 'presentment_money.amount')),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(to_numeric(get_path(parse_json(RL.TOTAL_TAX_SET), 'shop_money.amount')),'0')::decimal(15,2)
END

 AS M_TOTAL_TAX_PRIMARY
  ,

CASE WHEN  'original' = 'original' THEN
    coalesce(to_numeric(get_path(parse_json(RL.TOTAL_TAX_SET), 'presentment_money.amount')),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(to_numeric(get_path(parse_json(RL.TOTAL_TAX_SET), 'shop_money.amount')),'0')::decimal(15,2)
END

 AS M_TOTAL_TAX
   --METADATA (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'63c6371d-d8f5-48e9-bc77-407b0abcfb61' AS MD_INTGR_ID
FROM source R
LEFT JOIN refund_line RL ON RL.REFUND_ID = R.ID
)

SELECT * FROM rename
  );
