
  create or replace  view DEVELOPER_SANDBOX.DBT_SHOPIFY.V_TRANSACTIONS_STG  as (
    

WITH source AS (
  SELECT 
  * 
  FROM  	
    DEVELOPER_SANDBOX.DEMO_SHOPIFY."TRANSACTION"
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
  --DLHK
  MD5(S.ID) AS K_TRANSACTION_DLHK
  ,L.K_LOCATION_DLHK  
  ,MD5(S.USER_ID) AS K_USER_DLHK
  --BUSINESS KEYS
  ,S.ID AS K_TRANSACTION_BK
  ,S.DEVICE_ID AS K_DEVICE_BK  
  ,S.LOCATION_ID AS K_LOCATION_BK
  ,S.ORDER_ID AS K_ORDER_BK
  ,S.PARENT_ID AS K_PARENT_BK
  ,S.REFUND_ID AS K_REFUND_BK
  ,S.USER_ID AS K_USER_BK  
  --ATTRIBUTES
  ,S.AUTHORIZATION AS A_AUTHORIZATION
  ,S.CREATED_AT AS A_CREATED_AT
  ,S.CURRENCY AS A_CURRENCY
  ,S.CURRENCY_EXCHANGE_ADJUSTMENT AS A_CURRENCY_EXCHANGE_ADJUSTMENT
  ,S.ERROR_CODE AS A_ERROR_CODE
  ,S.GATEWAY AS A_GATEWAY
  ,S.KIND AS A_KIND
  ,S.MESSAGE AS A_MESSAGE
  ,S.PAYMENT_DETAILS AS A_PAYMENT_DETAILS
  ,S.PROCESSED_AT AS A_PROCESSED_AT
  ,S.SOURCE_NAME AS A_SOURCE_NAME
  ,S.STATUS AS A_STATUS
  --boolean
  ,S.TEST AS B_TEST
  --METRICS
  ,S.AMOUNT::decimal(15,2) AS M_AMOUNT   
  --//metadata (MD)
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'cc5603df-43e1-42fa-bf2e-6c12e9f40242' AS MD_INTGR_ID
  FROM
    source S  
  left join locations L ON L.K_LOCATION_BK = S.LOCATION_ID
)


SELECT * FROM rename
  );
