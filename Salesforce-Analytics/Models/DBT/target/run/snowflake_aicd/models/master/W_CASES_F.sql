

      create or replace  table DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CASES_F  as
      (

SELECT
  *
FROM
  DEVELOPER_SANDBOX.DBT_SALESFORCE.V_CASES_STG AS C
      );
    