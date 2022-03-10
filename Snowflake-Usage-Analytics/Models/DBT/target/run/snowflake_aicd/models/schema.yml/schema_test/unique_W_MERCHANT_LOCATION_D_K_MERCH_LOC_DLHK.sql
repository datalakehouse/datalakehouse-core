select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    K_MERCH_LOC_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SQUARE.W_MERCHANT_LOCATION_D
where K_MERCH_LOC_DLHK is not null
group by K_MERCH_LOC_DLHK
having count(*) > 1



      
    ) dbt_internal_test