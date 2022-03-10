

SELECT
  O.K_ORDER_DLHK AS K_ORDER_DLHK
  ,OLI.K_ORDER_LINE_ITEM_DLHK AS K_ORDER_LINE_ITEM_DLHK
  ,O.K_CUSTOMER_DLHK AS K_CUSTOMER_DLHK
  ,O.K_LOCATION_DLHK AS K_LOCATION_DLHK
  ,O.K_BILLING_ADDRESS_DLHK AS K_BILLING_ADDRESS_DLHK
  ,O.K_SHIPPING_ADDRESS_DLHK AS K_SHIPPING_ADDRESS_DLHK
  ,OLI.K_PRODUCT_VARIATION_DLHK AS K_ITEM_PRODUCT_VARIATION_DLHK
  ,OLI.K_PRODUCT_BK AS K_ITEM_PRODUCT_BK
  ,OLI.K_VARIANT_BK AS K_ITEM_VARIANT_BK
  ,OLI.K_ORDER_BK AS K_ITEM_ORDER_BK
  ,O.K_ORDER_BK AS K_ORDER_BK
  ,OLI.K_ORDER_LINE_ITEM_BK AS K_ITEM_ORDER_LINE_ITEM_BK
  ,O.K_APP_BK AS K_HEADER_APP_BK
  
  ,O.K_CUSTOMER_BK AS K_CUSTOMER_BK
  ,O.K_DEVICE_BK AS K_DEVICE_BK
  ,O.K_LOCATION_BK AS K_LOCATION_BK
  ,O.K_SOURCE_ENTIFIER_BK AS K_SOURCE_ENTIFIER_BK
  ,O.A_BROWSER_IP AS A_HEADER_BROWSER_IP
  ,O.A_CANCELLED_AT_DTS AS A_HEADER_CANCELLED_AT_DTS
  ,O.A_CANCEL_REASON AS A_HEADER_CANCEL_REASON
  ,O.A_CART_TOKEN AS A_HEADER_CART_TOKEN
  ,O.A_CHECKOUT_TOKEN AS A_HEADER_CHECKOUT_TOKEN
  ,O.A_CLIENT_DETAILS AS A_HEADER_CLIENT_DETAILS
  ,O.A_CLOSED_AT_DTS AS A_HEADER_CLOSED_AT_DTS
  ,O.A_CREATED_AT_DTS AS A_HEADER_CREATED_AT_DTS
  ,O.A_CURRENCY AS A_HEADER_CURRENCY
  ,O.A_PRESENTMENT_CURRENCY AS A_HEADER_PRESENTMENT_CURRENCY
  ,O.A_CUSTOMER_LOCALE AS A_HEADER_CUSTOMER_LOCALE
  ,O.A_EMAIL AS A_HEADER_EMAIL
  ,O.A_FINANCIAL_STATUS AS A_HEADER_FINANCIAL_STATUS
  ,O.A_FULFILLMENT_STATUS AS A_HEADER_FULFILLMENT_STATUS
  ,O.A_LANDING_SITE_BASE_URL AS A_HEADER_LANDING_SITE_BASE_URL
  ,O.A_LANDING_SITE_REF AS A_HEADER_LANDING_SITE_REF
  ,O.A_NAME AS A_HEADER_NAME
  ,O.A_NOTE AS A_HEADER_NOTE
  ,O.A_NOTE_ATTRIBUTES AS A_HEADER_NOTE_ATTRIBUTES
  ,O.A_PAYMENT_GATEWAY_NAMES AS A_HEADER_PAYMENT_GATEWAY_NAMES
  ,O.A_PROCESSED_AT_DTS AS A_HEADER_PROCESSED_AT_DTS
  ,O.A_PROCESSING_METHOD AS A_HEADER_PROCESSING_METHOD
  ,O.A_REFERENCE AS A_HEADER_REFERENCE
  ,O.A_REFERRING_SITE AS A_HEADER_REFERRING_SITE
  ,O.A_SOURCE_NAME AS A_HEADER_SOURCE_NAME
  ,O.A_SOURCE_URL AS A_HEADER_SOURCE_URL
  ,O.A_ORDER_NUMBER AS A_HEADER_ORDER_NUMBER
  ,O.A_POSION_NUMBER AS A_HEADER_POSION_NUMBER
  ,O.A_UPDATED_AT_DTS AS A_HEADER_UPDATED_AT_DTS
  ,O.B_BUYER_ACCEPTS_MARKETING AS B_HEADER_BUYER_ACCEPTS_MARKETING
  ,O.B_CONFIRMED AS B_HEADER_CONFIRMED
  ,O.B_TAXES_INCLUDED  AS B_HEADER_TAXES_INCLUDED   
  ,OLI.A_FULFILLMENT_SERVICE AS A_ITEM_FULFILLMENT_SERVICE
  ,OLI.A_FULFILLMENT_STATUS AS A_ITEM_FULFILLMENT_STATUS    
  ,OLI.A_VARIANT_INVENTORY_MANAGEMENT AS A_ITEM_VARIANT_INVENTORY_MANAGEMENT  
  
  ,OLI.B_GIFT_CARD AS B_ITEM_GIFT_CARD
  ,OLI.B_PRODUCT_EXISTS AS B_ITEM_PRODUCT_EXISTS
  ,OLI.B_REQUIRES_SHIPPING AS B_ITEM_REQUIRES_SHIPPING
  ,OLI.B_TAXABLE AS B_ITEM_TAXABLE
  ,OLI.M_FULFILLABLE_QUANTITY AS M_ITEM_FULFILLABLE_QUANTITY
  ,OLI.M_GRAMS AS M_ITEM_GRAMS
  ,OLI.M_QUANTITY AS M_ITEM_QUANTITY
  ,OLI.M_UNIT_PRICE AS M_ITEM_UNIT_PRICE
  ,OLI.M_UNIT_PRICE_PRIMARY AS M_ITEM_UNIT_PRICE_PRIMARY
  ,OLI.M_TOTAL_PRICE AS M_ITEM_TOTAL_PRICE
  ,OLI.M_TOTAL_PRICE_PRIMARY AS M_ITEM_TOTAL_PRICE_PRIMARY
  ,OLI.M_TOTAL_DISCOUNT AS M_ITEM_TOTAL_DISCOUNT
  ,OLI.M_TOTAL_DISCOUNT_PRIMARY AS M_ITEM_TOTAL_DISCOUNT_PRIMARY
  ,OLI.M_TAX_AMOUNT AS M_TAX_AMOUNT
  ,OLI.M_TAX_AMOUNT_PRIMARY AS M_TAX_AMOUNT_PRIMARY
  ,ROUND(DIV0((O.M_TOTAL_TIP_RECEIVED * OLI.M_TOTAL_PRICE_PRIMARY),O.M_TOTAL_LINE_ITENS_PRICE_PRIMARY),4)::decimal(15,4) as M_ALLOCATED_TIP_AMOUNT_PRIMARY  
  --,ROUND(DIV0((O.M_TOTAL_DISCOUNTS_PRIMARY * OLI.M_TOTAL_PRICE_PRIMARY),O.M_TOTAL_LINE_ITENS_PRICE_PRIMARY),4)::decimal(15,4) as M_ALLOCATED_HEADER_DISCOUNT
  ,ROUND(DIV0((O.M_TOTAL_SHIPPING_PRICE_PRIMARY * OLI.M_TOTAL_PRICE_PRIMARY),O.M_TOTAL_LINE_ITENS_PRICE_PRIMARY),4)::decimal(15,4) as M_ALLOCATED_SHIPPING_PRICE_PRIMARY
  ,ROUND(DIV0((O.M_TOTAL_SHIPPING_PRICE * OLI.M_TOTAL_PRICE),O.M_TOTAL_LINE_ITENS_PRICE_PRIMARY),4)::decimal(15,4) as M_ALLOCATED_SHIPPING_PRICE



   --METADATA (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'cc5603df-43e1-42fa-bf2e-6c12e9f40242' AS MD_INTGR_ID
FROM
  DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ORDERS_HEADER_STG AS O 
  INNER JOIN DEVELOPER_SANDBOX.DBT_SHOPIFY.V_ORDERS_LINE_ITEM_STG OLI ON OLI.K_ORDER_DLHK = O.K_ORDER_DLHK