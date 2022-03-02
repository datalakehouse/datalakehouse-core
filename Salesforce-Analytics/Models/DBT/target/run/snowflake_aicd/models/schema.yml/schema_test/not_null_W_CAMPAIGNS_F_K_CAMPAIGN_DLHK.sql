select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CAMPAIGNS_F
where K_CAMPAIGN_DLHK is null



      
    ) dbt_internal_test