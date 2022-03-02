
    
    

select
    K_ACCOUNT_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_ACCOUNTS_D
where K_ACCOUNT_DLHK is not null
group by K_ACCOUNT_DLHK
having count(*) > 1


