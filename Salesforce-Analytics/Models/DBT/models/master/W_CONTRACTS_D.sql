{{ config (
  materialized= 'table',
  schema= 'SALESFORCE',
  tags= ["staging", "daily"],
  transient=false
)
}}

SELECT
  *
FROM
  {{ref('V_CONTRACTS_STG')}} AS C