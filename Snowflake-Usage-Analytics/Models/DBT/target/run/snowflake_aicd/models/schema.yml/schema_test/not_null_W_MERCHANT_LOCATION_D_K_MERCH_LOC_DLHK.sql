select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from DEVELOPER_SANDBOX.DBT_SQUARE.W_MERCHANT_LOCATION_D
where K_MERCH_LOC_DLHK is null



      
    ) dbt_internal_test