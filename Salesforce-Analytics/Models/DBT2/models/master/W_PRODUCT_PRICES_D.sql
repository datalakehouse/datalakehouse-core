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
  {{ref('V_PRICEBOOK_ENTRY_STG')}} AS C