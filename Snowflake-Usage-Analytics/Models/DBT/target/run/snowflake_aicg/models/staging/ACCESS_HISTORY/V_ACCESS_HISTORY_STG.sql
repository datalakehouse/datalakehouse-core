
  create or replace  view DEVELOPER_SANDBOX.DBT_SNOWFLAKE_USAGE.V_ACCESS_HISTORY_STG  as (
    
 

WITH source AS (
  SELECT * FROM  SNOWFLAKE.ACCOUNT_USAGE."ACCESS_HISTORY"
),
tables AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DBT_SNOWFLAKE_USAGE.W_TABLES_D
),

rename as (
   SELECT 
      S.query_id AS K_QUERY_BK
     ,MD5(S.user_name) AS K_USER_DLHK
     ,tables.K_UNIQUE_TABLE_DLHK
     ,tables.K_TABLE_DLHK
     ,base.value:objectId::string AS K_TABLE_BK
     ,S.user_name A_USERNAME
     ,S.query_start_time AS A_START_TIME_DTS
     ,split(base.value:objectName, '.')[0]::string AS A_DATABASE_NAME
     ,split(base.value:objectName, '.')[1]::string AS A_SCHEMA_NAME
     ,split(base.value:objectName, '.')[2]::string AS A_TABLE_NAME   
FROM source S
     ,lateral flatten (base_objects_accessed) base
     ,tables 
WHERE tables.K_TABLE_BK = base.value:objectId::string 
)

SELECT * FROM rename
  );
