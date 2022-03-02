
    
    

select
    K_CONTRACT_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CONTRACTS_D
where K_CONTRACT_DLHK is not null
group by K_CONTRACT_DLHK
having count(*) > 1


