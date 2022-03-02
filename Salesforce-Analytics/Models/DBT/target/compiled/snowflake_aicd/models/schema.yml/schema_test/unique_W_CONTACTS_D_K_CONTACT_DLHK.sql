
    
    

select
    K_CONTACT_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CONTACTS_D
where K_CONTACT_DLHK is not null
group by K_CONTACT_DLHK
having count(*) > 1


