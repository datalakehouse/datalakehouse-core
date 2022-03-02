select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_LEADS_F
where K_LEAD_DLHK is null



      
    ) dbt_internal_test