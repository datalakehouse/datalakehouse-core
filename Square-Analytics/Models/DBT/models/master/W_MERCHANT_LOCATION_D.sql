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
  {{ref('V_MERCHANT_LOCATION_STG')}} AS M