
    
    

select
    K_ASSET_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_ASSETS_D
where K_ASSET_DLHK is not null
group by K_ASSET_DLHK
having count(*) > 1


