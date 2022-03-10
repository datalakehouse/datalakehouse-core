select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    K_POS_CATALOG_OBJECT_HASH_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SQUARE.W_CATALOG_ITEM_D
where K_POS_CATALOG_OBJECT_HASH_DLHK is not null
group by K_POS_CATALOG_OBJECT_HASH_DLHK
having count(*) > 1



      
    ) dbt_internal_test