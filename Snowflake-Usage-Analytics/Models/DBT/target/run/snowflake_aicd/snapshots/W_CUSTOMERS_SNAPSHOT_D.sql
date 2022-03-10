
      

      create or replace transient table DEVELOPER_SANDBOX.DBT_SQUARE.w_customers_snapshot_d  as
      (

    select *,
        md5(coalesce(cast(K_POS_CUSTOMER_CUSTOMER_DLHK as varchar ), '')
         || '|' || coalesce(cast(A_POS_CUSTOMER_UPDATED_AT_DTS as varchar ), '')
        ) as dbt_scd_id,
        A_POS_CUSTOMER_UPDATED_AT_DTS as dbt_updated_at,
        A_POS_CUSTOMER_UPDATED_AT_DTS as dbt_valid_from,
        nullif(A_POS_CUSTOMER_UPDATED_AT_DTS, A_POS_CUSTOMER_UPDATED_AT_DTS) as dbt_valid_to
    from (
        



select * from DEVELOPER_SANDBOX.DBT_SQUARE.W_CUSTOMERS_D

    ) sbq


      );
    
  