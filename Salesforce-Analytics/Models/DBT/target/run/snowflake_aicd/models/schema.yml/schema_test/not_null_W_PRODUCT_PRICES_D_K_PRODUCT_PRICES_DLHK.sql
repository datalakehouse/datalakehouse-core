select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_PRODUCT_PRICES_D
where K_PRODUCT_PRICES_DLHK is null



      
    ) dbt_internal_test