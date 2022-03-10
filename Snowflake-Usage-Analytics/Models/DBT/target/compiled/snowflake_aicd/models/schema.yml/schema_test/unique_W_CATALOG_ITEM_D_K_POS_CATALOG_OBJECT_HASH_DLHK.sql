
    
    

select
    K_POS_CATALOG_OBJECT_HASH_DLHK,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_MCLEOD_SQUARE.W_CATALOG_ITEM_D
where K_POS_CATALOG_OBJECT_HASH_DLHK is not null
group by K_POS_CATALOG_OBJECT_HASH_DLHK
having count(*) > 1


