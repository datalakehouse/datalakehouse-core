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
  {{ref('V_MERCHANTS_STG')}} AS C