{{ config (
  materialized= 'table',
  schema= 'SNOWFLAKE_USAGE',
  tags= ["staging", "daily"],
  transient=false
)
}}


SELECT
  *
FROM
  {{ref('V_TABLES_STG')}} AS C