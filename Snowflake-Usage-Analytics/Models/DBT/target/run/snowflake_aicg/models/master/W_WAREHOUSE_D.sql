

      create or replace  table DEVELOPER_SANDBOX.DBT_SNOWFLAKE_USAGE.W_WAREHOUSE_D  as
      (


SELECT
  *
FROM
  DEVELOPER_SANDBOX.DBT_SNOWFLAKE_USAGE.V_WAREHOUSE_STG AS C
      );
    