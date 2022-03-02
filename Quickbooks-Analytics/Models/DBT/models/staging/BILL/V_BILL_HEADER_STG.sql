{{ config (
  materialized= 'view',
  schema= 'QUICKBOOKS',
  tags= ["staging", "daily"]
)
}}

WITH source AS(
    SELECT * FROM  {{source('DEMO_QUICKBOOKS','BILL')}}
),
term AS (
  SELECT  *  FROM  {{ref('W_TERM_D')}}
),
vendors AS (
    SELECT * FROM {{ref('W_VENDORS_D')}}
),
accounts AS (
    SELECT * FROM {{ref('W_ACCOUNTS_D')}}
),
currency AS (
    SELECT * FROM {{ref('W_CURRENCY_D')}}
),
bills_linked AS (
    SELECT * FROM {{source('DEMO_QUICKBOOKS','BILL_LINKED_TXN')}}
),
bill_payment AS (
    SELECT * FROM {{source('DEMO_QUICKBOOKS','BILL_PAYMENT')}}
),
bill_payment_lines as (
    select *
    from {{source('DEMO_QUICKBOOKS','BILL_PAYMENT_LINE')}}
    where bill_id is not null
),
bills_pay as
(
    SELECT
    b.ID as BILL_ID
    ,MIN(bp.TRANSACTION_DATE) AS INITIAL_PAYMENT_DATE
    ,MAX(bp.TRANSACTION_DATE) AS FINAL_PAYMENT_DATE
    ,SUM(COALESCE(bp.TOTAL_AMOUNT,0))::decimal(15,2) AS PAYMENT_AMOUNT
    ,SUM(COALESCE(bpl.AMOUNT,0))::decimal(15,2) AS PAYMENT_LINE_AMOUNT
    FROM
    bills_linked bl
    INNER JOIN source as b on b.ID = bl.BILL_ID
    INNER JOIN bill_payment as bp on bp.ID = bl.BILL_PAYMENT_ID
    LEFT JOIN bill_payment_lines bpl ON bpl.BILL_PAYMENT_ID = bp.ID AND bpl.BILL_ID = B.ID
GROUP BY 1
),
rename AS (
SELECT
    --DLHK  
    MD5( TRIM(COALESCE(b.ID,'00000000000000000000000000000000')) ) AS K_BILL_DLHK
    ,t.K_TERM_DLHK AS K_SALES_TERM_DLHK
    ,v.K_VENDOR_DLHK
    ,a.K_ACCOUNT_DLHK AS K_PAYABLE_ACCOUNT_DLHK
    ,c.K_CURRENCY_DLHK
    --BK
    ,b.ID AS K_BILL_BK
    ,t.K_TERM_BK AS K_SALES_TERM_BK
    ,v.K_VENDOR_BK
    ,a.K_ACCOUNT_BK AS K_PAYABLE_ACCOUNT_BK
    ,c.K_CURRENCY_BK
    --ATTRIBUTES
    ,b.SYNC_TOKEN AS A_SYNC_TOKEN
    ,b.PRIVATE_NOTE AS A_PRIVATE_NOTE
    ,b.DOC_NUMBER AS A_DOC_NUMBER
    ,b.GLOBAL_TAX_CALCULATION AS A_GLOBAL_TAX_CALCULATION
    ,b.CREATED_AT AS A_CREATED_AT_DTS
    ,b.UPDATED_AT AS A_UPDATED_AT_DTS
    ,b.DUE_DATE AS A_DUE_DATE
    ,b.TRANSACTION_DATE AS A_TRANSACTION_DATE
    ,bp.INITIAL_PAYMENT_DATE AS A_INITIAL_PAYMENT_DATE
    ,bp.FINAL_PAYMENT_DATE AS A_FINAL_PAYMENT_DATE
    
    --METRICS
    ,b.TOTAL_AMOUNT::decimal(15,2) AS M_TOTAL_AMOUNT
    ,bp.PAYMENT_AMOUNT AS M_PAYMENT_AMOUNT
    ,bp.PAYMENT_LINE_AMOUNT AS M_PAYMENT_LINE_AMOUNT
    ,b.HOME_BALANCE::decimal(15,2) AS M_HOME_BALANCE
    ,b.EXCHANGE_RATE::decimal(15,2) AS M_EXCHANGE_RATE
    ,b.BALANCE::decimal(15,2) AS M_BALANCE

     --METADATA
    ,CURRENT_TIMESTAMP as MD_LOAD_DTS
    ,'{{invocation_id}}' AS MD_INTGR_ID
FROM
source as b
LEFT JOIN term as t on t.K_TERM_BK = b.SALES_TERM_ID
LEFT JOIN vendors as v on v.K_VENDOR_BK = b.VENDOR_ID
LEFT JOIN accounts AS a on a.K_ACCOUNT_BK = b.PAYABLE_ACCOUNT_ID
LEFT JOIN currency AS c on c.K_CURRENCY_BK = b.CURRENCY_ID
LEFT JOIN bills_pay as bp on bp.BILL_ID = b.ID
)

SELECT * FROM rename