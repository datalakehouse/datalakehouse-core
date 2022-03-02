
    
    

select
    K_OPPORTUNITY_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_OPPORTUNITIES_F
where K_OPPORTUNITY_DLHK is not null
group by K_OPPORTUNITY_DLHK
having count(*) > 1


