

      create or replace  table DEVELOPER_SANDBOX.DBT_SQUARE.W_MERCHANT_LOCATION_D  as
      (


SELECT
  *
FROM
  DEVELOPER_SANDBOX.DBT_SQUARE.V_MERCHANT_LOCATION_STG AS M
      );
    