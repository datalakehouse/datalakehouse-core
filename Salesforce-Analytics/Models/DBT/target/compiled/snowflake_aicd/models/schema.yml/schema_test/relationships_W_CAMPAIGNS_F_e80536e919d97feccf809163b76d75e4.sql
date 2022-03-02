
    
    

with child as (
    select K_CREATED_BY_USER_DLHK as from_field
    from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CAMPAIGNS_F
    where K_CREATED_BY_USER_DLHK is not null
),

parent as (
    select K_USER_DLHK as to_field
    from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_USERS_D
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


