{{ config (
  materialized= 'table',
  schema= 'SQUARE',
  tags= ["staging", "daily"],
  transient=false
)
}}


SELECT
  *
FROM
  {{ref('V_CUSTOMER_STG')}} AS C