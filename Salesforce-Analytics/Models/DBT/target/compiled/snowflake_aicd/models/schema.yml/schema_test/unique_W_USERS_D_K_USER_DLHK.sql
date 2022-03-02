
    
    

select
    K_USER_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_USERS_D
where K_USER_DLHK is not null
group by K_USER_DLHK
having count(*) > 1


