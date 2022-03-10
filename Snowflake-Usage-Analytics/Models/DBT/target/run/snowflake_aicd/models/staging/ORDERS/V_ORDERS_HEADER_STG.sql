
  create or replace  view DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ORDERS_HEADER_STG  as (
    

WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SHOPIFY."ORDERS" AS A
),
rename AS 
(
SELECT
    MD5(O.ID) AS K_ORDER_DLHK    
    ,MD5(O.CUSTOMER_ID) AS K_CUSTOMER_DLHK
    ,MD5(O.LOCATION_ID) AS K_LOCATION_DLHK    
    ,
    MD5(CONCAT(coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'address1')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'address2')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'city')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'country')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'country_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'first_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'last_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'province')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'province_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.BILLING_ADDRESS), 'zip')),'00')))
 AS K_BILLING_ADDRESS_DLHK
    ,
    MD5(CONCAT(coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'address1')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'address2')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'city')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'country')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'country_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'first_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'last_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'province')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'province_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(O.SHIPPING_ADDRESS), 'zip')),'00')))
 AS K_SHIPPING_ADDRESS_DLHK
    --BUSINESS_KEYS
    ,O.APP_ID AS K_APP_BK
    ,O.ID AS K_ORDER_BK
    ,O.CUSTOMER_ID AS K_CUSTOMER_BK
    ,O.DEVICE_ID AS K_DEVICE_BK  
    ,O.LOCATION_ID AS K_LOCATION_BK
    ,O.SOURCE_IDENTIFIER AS K_SOURCE_ENTIFIER_BK
    --ATTRIBUTES
    ,O.BROWSER_IP AS A_BROWSER_IP
    ,O.CANCELLED_AT AS A_CANCELLED_AT_DTS
    ,O.CANCEL_REASON AS A_CANCEL_REASON
    ,O.CART_TOKEN AS A_CART_TOKEN
    ,O.CHECKOUT_TOKEN AS A_CHECKOUT_TOKEN
    ,O.CLIENT_DETAILS AS A_CLIENT_DETAILS
    ,O.CLOSED_AT AS A_CLOSED_AT_DTS
    ,O.CREATED_AT AS A_CREATED_AT_DTS
    ,O.CURRENCY AS A_CURRENCY
    ,O.PRESENTMENT_CURRENCY AS A_PRESENTMENT_CURRENCY
    ,O.CUSTOMER_LOCALE AS A_CUSTOMER_LOCALE
    ,O.EMAIL AS A_EMAIL
    ,O.FINANCIAL_STATUS AS A_FINANCIAL_STATUS
    ,O.FULFILLMENT_STATUS AS A_FULFILLMENT_STATUS
    ,O.LANDING_SITE_BASE_URL AS A_LANDING_SITE_BASE_URL
    ,O.LANDING_SITE_REF AS A_LANDING_SITE_REF
    ,O.NAME AS A_NAME
    ,O.NOTE AS A_NOTE
    ,O.NOTE_ATTRIBUTES AS A_NOTE_ATTRIBUTES    
    ,O.PAYMENT_GATEWAY_NAMES AS A_PAYMENT_GATEWAY_NAMES    
    ,O.PROCESSED_AT AS A_PROCESSED_AT_DTS
    ,O.PROCESSING_METHOD AS A_PROCESSING_METHOD
    ,O.REFERENCE AS A_REFERENCE
    ,O.REFERRING_SITE AS A_REFERRING_SITE    
    ,O.SOURCE_NAME AS A_SOURCE_NAME
    ,O.SOURCE_URL AS A_SOURCE_URL    
    ,O.ORDER_NUMBER AS A_ORDER_NUMBER
    ,O.POSION_NUMBER AS A_POSION_NUMBER  
    ,O.UPDATED_AT AS A_UPDATED_AT_DTS
    --BOOLEAN
    ,O.BUYER_ACCEPTS_MARKETING AS B_BUYER_ACCEPTS_MARKETING
    ,O.CONFIRMED AS B_CONFIRMED
    ,O.TAXES_INCLUDED AS B_TAXES_INCLUDED
    --METRICS
    ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.SUBTOTAL_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.SUBTOTAL_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_SUBTOTAL_PRICE
    ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.SUBTOTAL_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.SUBTOTAL_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_SUBTOTAL_PRICE_PRIMARY
    ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNTS_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNTS_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_DISCOUNTS
    ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNTS_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_DISCOUNTS_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_DISCOUNTS_PRIMARY
    ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_LINE_ITEMS_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_LINE_ITEMS_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_LINE_ITENS_PRICE
    ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_LINE_ITEMS_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_LINE_ITEMS_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_LINE_ITENS_PRICE_PRIMARY
    ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_PRICE
    ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_PRICE_PRIMARY
    ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_TAX_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_TAX_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_TAX
    ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_TAX_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_TAX_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_TAX_PRIMARY
    ,

CASE WHEN  'original' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_SHIPPING_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'original' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_SHIPPING_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_SHIPPING_PRICE
    ,

CASE WHEN  'primary' = 'original' THEN
    coalesce(get_path(parse_json(O.TOTAL_SHIPPING_PRICE_SET), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN 'primary' = 'primary' THEN
    coalesce(get_path(parse_json(O.TOTAL_SHIPPING_PRICE_SET), 'shop_money.amount'),'0')::decimal(15,2)
END

 AS M_TOTAL_SHIPPING_PRICE_PRIMARY 
    ,O.TOTAL_TIP_RECEIVED::DECIMAL(15,2) AS M_TOTAL_TIP_RECEIVED   
    ,O.TOTAL_WEIGHT::DECIMAL(15,2) AS M_TOTAL_WEIGHT
   --METADATA (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'cc5603df-43e1-42fa-bf2e-6c12e9f40242' AS MD_INTGR_ID
FROM source O
)

SELECT * FROM rename
  );
