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
  {{ref('V_ACCOUNTS_STG')}} AS C