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
  {{ref('V_CONTACTS_STG')}} AS C