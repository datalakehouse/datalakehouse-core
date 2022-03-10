
  create or replace  view DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ABANDONED_CHECKOUT_F_STG  as (
    

WITH source AS (
  SELECT 
  * 
  FROM  	
    DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ABANDONED_CHECKOUT_STG
),
abandoned_checkout_item AS (
  SELECT 
  * 
  FROM  	
    DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ABANDONED_CHECKOUT_LINE_ITEM_STG
),
rename AS 
(   
  SELECT 
  I.K_ABANDONED_CHECKOUT_ITEM_DLHK
  ,S.K_ABANDONED_CHECKOUT_DLHK
  ,I.K_PRODUCT_VARIATION_DLHK
  ,I.K_DESTINATION_LOCATION_BK AS K_ITEM_DESTINATION_LOCATION_BK
  ,I.K_ORIGIN_LOCATION_BK AS K_ITEM_ORIGIN_LOCATION_BK
  ,S.K_CUSTOMER_DLHK
  ,S.K_LOCATION_DLHK
  ,S.K_USER_DLHK
  ,S.K_SHIPPING_ADDRESS_DLHK
  ,S.K_BILLING_ADDRESS_DLHK  
  ,S.K_ABANDONED_CHECKOUT_BK
  ,S.K_CUSTOMER_BK
  ,S.K_DEVICE_BK
  ,S.K_LOCATION_BK
  ,S.K_SOURCE_BKENTIFIER
  ,S.K_USER_BK
  ,S.A_ABANDONED_CHECKOUT_URL  
  ,S.A_CART_TOKEN
  ,S.A_CLOSED_AT
  ,S.A_COMPLETED_AT
  ,S.A_CREATED_AT
  ,S.A_CURRENCY
  ,S.A_CUSTOMER_LOCALE
  ,S.A_EMAIL
  ,S.A_GATEWAY
  ,S.A_LANDING_SITE_BASE_URL
  ,S.A_NAME
  ,S.A_NOTE
  ,S.A_NOTE_ATTRIBUTES
  ,S.A_PHONE
  ,S.A_PRESENTMENT_CURRENCY
  ,S.A_REFERRING_SITE    
  ,S.A_SOURCE
  ,S.A_SOURCE_NAME
  ,S.A_SOURCE_URL
  ,S.A_TOKEN
  ,S.A_UPDATED_AT    
  ,S.B_BUYER_ACCEPTS_MARKETING
  ,S.B_TAXES_INCLUDED  
  ,I.B_GIFT_CARD
  ,I.B_REQUIRES_SHIPPING
  ,I.B_TAXABLE
  --,S.M_SUBTOTAL_PRICE
  ,S.M_TOTAL_DISCOUNTS
  --,S.M_TOTAL_DUTIES
  --,S.M_TOTAL_LINE_ITEMS_PRICE
  --,S.M_TOTAL_PRICE
  --,S.M_TOTAL_TAX
  
  ,ROUND(DIV0((S.M_TOTAL_DUTIES * I.M_PRICE),S.M_TOTAL_LINE_ITEMS_PRICE),4)::decimal(15,4) as M_ALLOCATED_DUTIES
  ,ROUND(DIV0((S.M_TOTAL_TAX * I.M_PRICE),S.M_TOTAL_LINE_ITEMS_PRICE),4)::decimal(15,4) as M_ALLOCATED_TAXES
  ,ROUND(DIV0((S.M_TOTAL_DISCOUNTS * I.M_PRICE),S.M_TOTAL_LINE_ITEMS_PRICE),4)::decimal(15,4) as M_ALLOCATED_DISCOUNTS
  
  ,I.M_COMPARE_AT_PRICE
  ,I.M_GRAMS
  ,I.M_LINE_PRICE
  ,I.M_PRICE
  ,I.M_QUANTITY
  ,I.M_VARIANT_PRICE
  ,(I.M_PRICE + M_ALLOCATED_DUTIES - M_ALLOCATED_TAXES - M_ALLOCATED_DISCOUNTS)::decimal(15,4) AS M_TOTAL_PRICE
  
  --//metadata (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'9a6254a5-a7b6-4785-afcf-f956626fae6f' AS MD_INTGR_ID
  FROM
      source S
      left join abandoned_checkout_item I ON I.K_ABANDONED_CHECKOUT_BK = S.K_ABANDONED_CHECKOUT_BK
)


SELECT * FROM rename
  );
