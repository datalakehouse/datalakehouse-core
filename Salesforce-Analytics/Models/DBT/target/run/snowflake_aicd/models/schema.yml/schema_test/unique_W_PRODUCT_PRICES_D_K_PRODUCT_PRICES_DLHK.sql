select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    K_PRODUCT_PRICES_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_PRODUCT_PRICES_D
where K_PRODUCT_PRICES_DLHK is not null
group by K_PRODUCT_PRICES_DLHK
having count(*) > 1



      
    ) dbt_internal_test