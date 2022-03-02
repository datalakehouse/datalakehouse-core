
    
    

select
    K_CASE_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CASES_F
where K_CASE_DLHK is not null
group by K_CASE_DLHK
having count(*) > 1


