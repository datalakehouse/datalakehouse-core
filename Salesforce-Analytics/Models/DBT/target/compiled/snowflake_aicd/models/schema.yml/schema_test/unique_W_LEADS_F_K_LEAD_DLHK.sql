
    
    

select
    K_LEAD_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_LEADS_F
where K_LEAD_DLHK is not null
group by K_LEAD_DLHK
having count(*) > 1


