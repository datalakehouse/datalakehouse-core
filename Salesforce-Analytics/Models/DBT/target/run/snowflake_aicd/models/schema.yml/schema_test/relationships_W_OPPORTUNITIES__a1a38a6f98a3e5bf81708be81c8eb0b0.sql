select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select K_ACCOUNT_DLHK as from_field
    from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_OPPORTUNITIES_F
    where K_ACCOUNT_DLHK is not null
),

parent as (
    select K_ACCOUNT_DLHK as to_field
    from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_ACCOUNTS_D
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test