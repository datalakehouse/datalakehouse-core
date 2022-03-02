select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select *
from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CONTRACTS_D
where K_CONTRACT_DLHK is null



      
    ) dbt_internal_test