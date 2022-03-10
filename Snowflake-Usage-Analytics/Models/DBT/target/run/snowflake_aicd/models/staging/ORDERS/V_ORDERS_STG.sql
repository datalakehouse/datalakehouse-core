
  create or replace  view DEVELOPER_SANDBOX.DBT_SQUARE.V_ORDERS_STG  as (
    

WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.OLD_SQUARE."ORDER" AS A
),
rename AS 
(
SELECT 
--PKs
  ID AS ORDER_ID,
--FOREIGN KEYS
  LOCATION_ID,
  CUSTOMER_ID,
  REFERENCE_ID,
--DATE FIELDS
  CREATED_AT,
  UPDATED_AT,
  CLOSED_AT
--OTHER FIELDS  
FROM source
)

SELECT * FROM rename
  );