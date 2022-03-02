{{ config (
  materialized= 'table',
  schema= 'QUICKBOOKS',
  tags= ["staging", "daily"],
  transient=false
)
}}


SELECT
  *
FROM
  {{ref('V_CURRENCY_STG')}} AS C