{{ config (
  materialized= 'view',
  schema= 'DOORDASH',
  tags= ["staging","daily"]
)
}}

WITH budget_orders AS (
  SELECT * FROM  {{ref('V_BUDGET_STG')}}
),
budget_hist AS (
    SELECT * FROM  {{source('TEST_SCHEMA_EXT_DEV','BUDGET_HIST')}}
),
rename AS 
(
SELECT DISTINCT 
  MD5(CONCAT(O.K_BUDGET_BK,START_DATE)) AS K_BUDGET_DLHK
  ,O.K_BUDGET_BK
  ,O.A_BUDGET_NAME
  ,H.AMOUNT AS M_AMOUNT
  ,H.START_DATE
  ,H.END_DATE
  , '{{invocation_id}}' as MD_INTGR_ID
  , CURRENT_TIMESTAMP() MD_ELT_UPDATED_DTS
FROM 
  budget_orders O
  INNER JOIN budget_hist H ON H.BUDGET_ID = O.K_BUDGET_BK
)

SELECT * FROM rename