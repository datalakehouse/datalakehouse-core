
  create or replace  view DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ABANDONED_CHECKOUT_STG  as (
    

WITH source AS (
  SELECT 
  * 
  FROM  	
    DEVELOPER_SANDBOX.DEMO_SHOPIFY."ABANDONED_CHECKOUT"
),
customer AS (
  SELECT 
  * 
  FROM  	
    DEVELOPER_SANDBOX.DBT_SHOPIFY.W_CUSTOMERS_D
),
locations AS (
  SELECT 
  * 
  FROM  	
    DEVELOPER_SANDBOX.DBT_SHOPIFY.W_LOCATION_D
),
rename AS 
(   
  SELECT 

  MD5(S.ID) AS K_ABANDONED_CHECKOUT_DLHK
  ,C.K_CUSTOMER_DLHK
  ,L.K_LOCATION_DLHK
  ,MD5(S.USER_ID) AS K_USER_DLHK
  ,
    MD5(CONCAT(coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'address1')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'address2')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'city')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'country')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'country_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'first_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'last_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'province')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'province_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.SHIPPING_ADDRESS), 'zip')),'00')))
 AS K_SHIPPING_ADDRESS_DLHK
  ,
    MD5(CONCAT(coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'address1')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'address2')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'city')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'country')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'country_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'first_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'last_name')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'province')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'province_code')),'00'),
              coalesce(to_varchar(get_path(parse_json(S.BILLING_ADDRESS), 'zip')),'00')))
 AS K_BILLING_ADDRESS_DLHK  
  ,S.ID AS K_ABANDONED_CHECKOUT_BK
  ,S.CUSTOMER_ID AS K_CUSTOMER_BK
  ,S.DEVICE_ID AS K_DEVICE_BK
  ,S.LOCATION_ID AS K_LOCATION_BK
  ,S.SOURCE_IDENTIFIER AS K_SOURCE_BKENTIFIER
  ,S.USER_ID AS K_USER_BK
  ,S.ABANDONED_CHECKOUT_URL AS A_ABANDONED_CHECKOUT_URL  
  ,S.CART_TOKEN AS A_CART_TOKEN
  ,S.CLOSED_AT AS A_CLOSED_AT
  ,S.COMPLETED_AT AS A_COMPLETED_AT
  ,S.CREATED_AT AS A_CREATED_AT
  ,S.CURRENCY AS A_CURRENCY
  ,S.CUSTOMER_LOCALE AS A_CUSTOMER_LOCALE
  ,S.EMAIL AS A_EMAIL
  ,S.GATEWAY AS A_GATEWAY
  ,S.LANDING_SITE_BASE_URL AS A_LANDING_SITE_BASE_URL
  ,S.NAME AS A_NAME
  ,S.NOTE AS A_NOTE
  ,S.NOTE_ATTRIBUTES AS A_NOTE_ATTRIBUTES
  ,S.PHONE AS A_PHONE
  ,S.PRESENTMENT_CURRENCY AS A_PRESENTMENT_CURRENCY
  ,S.REFERRING_SITE AS A_REFERRING_SITE    
  ,S.SOURCE AS A_SOURCE
  ,S.SOURCE_NAME AS A_SOURCE_NAME
  ,S.SOURCE_URL AS A_SOURCE_URL
  ,S.TOKEN AS A_TOKEN
  ,S.UPDATED_AT AS A_UPDATED_AT  
  --BOOLEAN
  ,S.BUYER_ACCEPTS_MARKETING AS B_BUYER_ACCEPTS_MARKETING
  ,S.TAXES_INCLUDED AS B_TAXES_INCLUDED
  --METRIC
  ,S.SUBTOTAL_PRICE::decimal(15,2) AS M_SUBTOTAL_PRICE
  ,S.TOTAL_DISCOUNTS::decimal(15,2) AS M_TOTAL_DISCOUNTS
  ,S.TOTAL_DUTIES::decimal(15,2) AS M_TOTAL_DUTIES
  ,S.TOTAL_LINE_ITEMS_PRICE::decimal(15,2) AS M_TOTAL_LINE_ITEMS_PRICE
  ,S.TOTAL_PRICE::decimal(15,2) AS M_TOTAL_PRICE
  ,S.TOTAL_TAX::decimal(15,2) AS M_TOTAL_TAX
  ,S.TOTAL_WEIGHT::decimal(15,2) AS M_TOTAL_WEIGHT
  --//metadata (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'9a6254a5-a7b6-4785-afcf-f956626fae6f' AS MD_INTGR_ID
  FROM
      source S
      left join customer C ON C.K_CUSTOMER_BK = S.CUSTOMER_ID
      left join locations L ON L.K_LOCATION_BK = S.LOCATION_ID
)


SELECT * FROM rename
  );
