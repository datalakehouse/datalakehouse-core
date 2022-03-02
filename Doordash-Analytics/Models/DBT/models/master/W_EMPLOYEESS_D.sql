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
  {{ref('V_EMPLOYEES_STG')}} AS C