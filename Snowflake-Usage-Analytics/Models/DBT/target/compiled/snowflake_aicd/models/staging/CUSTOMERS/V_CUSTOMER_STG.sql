

WITH source AS (
  SELECT 
  * 
  FROM  	
    DEVELOPER_SANDBOX.DEMO_SHOPIFY."CUSTOMER"
),
rename AS 
(   
SELECT 
    --KEYS
    MD5(ID) AS K_CUSTOMER_DLHK    
    --BUSINESS KEYS
    ,ID AS K_CUSTOMER_BK
    ,LAST_ORDER_ID AS K_LAST_ORDER_BK
    ,MULTIPASS_IDENTIFIER AS K_MULTIPASS_BKENTIFIER
    --ATTRIBUTES
    ,ACCEPTS_MARKETING_UPDATED_AT AS A_ACCEPTS_MARKETING_UPDATED_AT_DTS
    ,CREATED_AT AS A_CREATED_AT_DTS
    ,CURRENCY AS A_CURRENCY
    ,EMAIL AS A_EMAIL
    ,
    (COALESCE(FIRST_NAME,'') || ' ' || COALESCE(LAST_NAME,''))
 AS A_FULL_NAME
    ,FIRST_NAME AS A_FIRST_NAME
    ,LAST_NAME AS A_LAST_NAME
    ,LAST_ORDER_NAME AS A_LAST_ORDER_NAME
    ,MARKETING_OPT_IN_LEVEL AS A_MARKETING_OPT_IN_LEVEL
    ,NOTE AS A_NOTE
    ,PHONE AS A_PHONE
    ,SMS_MARKETING_CONSENT AS A_SMS_MARKETING_CONSENT
    ,STATE AS A_STATE
    ,TAGS AS A_TAGS
    ,TAX_EXEMPTIONS AS A_TAX_EXEMPTIONS
    ,TOTAL_SPENT AS A_TOTAL_SPENT
    ,UPDATED_AT AS A_UPDATED_AT
    --BOOLEAN
    ,ACCEPTS_MARKETING AS B_ACCEPTS_MARKETING
    ,TAX_EXEMPT AS B_TAX_EXEMPT
    ,VERIFIED_EMAIL AS B_VERIFIED_EMAIL
    --METRICS
    ,ORDERS_COUNT AS M_ORDERS_COUNT
    --//metadata (MD)
    ,CURRENT_TIMESTAMP as MD_LOAD_DTS
    ,'9a6254a5-a7b6-4785-afcf-f956626fae6f' AS MD_INTGR_ID
  FROM
      source    
)


SELECT * FROM rename