{{ config (
  materialized= 'table',
  schema= 'DOORDASH',
  tags= ["staging", "daily"],
  transient=false
)
}}

SELECT
  *
FROM
  {{ref('V_CURRENCIES_STG')}} AS C