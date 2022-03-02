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
  {{ref('V_CONTACTS_STG')}} AS C