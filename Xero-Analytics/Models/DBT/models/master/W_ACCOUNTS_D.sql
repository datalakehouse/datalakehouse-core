{{ config (
  materialized= 'table',
  schema= 'XERO',
  tags= ["staging", "daily"],
  transient=false
)
}}


SELECT
  *
FROM
  {{ref('V_ACCOUNTS_STG')}} AS C