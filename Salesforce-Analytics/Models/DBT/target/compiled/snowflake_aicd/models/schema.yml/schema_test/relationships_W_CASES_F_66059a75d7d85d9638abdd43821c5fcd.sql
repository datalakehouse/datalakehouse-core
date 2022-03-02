
    
    

with child as (
    select K_CONTACT_DLHK as from_field
    from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CASES_F
    where K_CONTACT_DLHK is not null
),

parent as (
    select K_CONTACT_DLHK as to_field
    from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CONTACTS_D
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


