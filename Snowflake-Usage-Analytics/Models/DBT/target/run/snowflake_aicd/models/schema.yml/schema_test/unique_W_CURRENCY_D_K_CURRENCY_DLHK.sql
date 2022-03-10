select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    K_CURRENCY_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SQUARE.W_CURRENCY_D
where K_CURRENCY_DLHK is not null
group by K_CURRENCY_DLHK
having count(*) > 1



      
    ) dbt_internal_test