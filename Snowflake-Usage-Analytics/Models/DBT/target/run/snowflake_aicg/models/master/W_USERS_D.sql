

      create or replace  table DEVELOPER_SANDBOX.DBT_SNOWFLAKE_USAGE.W_USERS_D  as
      (


SELECT
  *
FROM
  DEVELOPER_SANDBOX.DBT_SNOWFLAKE_USAGE.V_USERS_STG AS C
      );
    