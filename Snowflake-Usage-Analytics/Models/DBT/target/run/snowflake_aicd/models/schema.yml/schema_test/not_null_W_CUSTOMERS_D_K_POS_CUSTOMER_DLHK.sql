select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from DEVELOPER_SANDBOX.DBT_SQUARE.W_CUSTOMERS_D
where K_POS_CUSTOMER_DLHK is null



      
    ) dbt_internal_test