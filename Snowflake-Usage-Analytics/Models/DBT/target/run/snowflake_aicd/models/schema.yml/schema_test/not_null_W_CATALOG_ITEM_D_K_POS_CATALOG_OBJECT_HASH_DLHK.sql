select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from DEVELOPER_SANDBOX.DBT_SQUARE.W_CATALOG_ITEM_D
where K_POS_CATALOG_OBJECT_HASH_DLHK is null



      
    ) dbt_internal_test