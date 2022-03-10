{{ config (
  materialized= 'table',
  schema= 'SNOWFLAKE_USAGE',
  tags= ["staging", "daily"],
  transient=false
)
}}


SELECT
  C.*
  ,CASE WHEN CLOUD.M_EFFECTIVE_RATE IS NULL THEN NULL ELSE C.M_CREDITS_USED_CLOUD_SERVICES * CLOUD.M_EFFECTIVE_RATE END AS M_AMOUNT_SPENT_CLOUD_SERVICES
  ,CASE WHEN COMPUTE.M_EFFECTIVE_RATE IS NULL THEN NULL ELSE C.M_CREDITS_USED_COMPUTE * COMPUTE.M_EFFECTIVE_RATE END AS M_AMOUNT_SPENT_COMPUTE
  ,M_AMOUNT_SPENT_CLOUD_SERVICES + M_AMOUNT_SPENT_COMPUTE AS M_AMOUNT_SPENT
  ,CLOUD.M_EFFECTIVE_RATE AS M_CLOUD_SERVICES_RATE_PER_CREDIT
  ,COMPUTE.M_EFFECTIVE_RATE AS M_COMPUTE_RATE_PER_CREDIT
  ,CLOUD.A_CURRENCY AS A_CLOUD_SERVICES_RATE_CURRENCY
  ,COMPUTE.A_CURRENCY AS A_COMPUTE_RATE_CURRENCY
FROM
  {{ref('V_WAREHOUSE_USAGE_STG')}} C
  LEFT JOIN {{ref('V_DAILY_RATE_SHEET_STG')}} CLOUD ON CLOUD.A_DATE = DATE(C.A_START_TIME) AND CLOUD.A_USAGE_TYPE = 'cloud services'
  LEFT JOIN {{ref('V_DAILY_RATE_SHEET_STG')}} COMPUTE ON COMPUTE.A_DATE = DATE(C.A_START_TIME) AND COMPUTE.A_USAGE_TYPE = 'compute'