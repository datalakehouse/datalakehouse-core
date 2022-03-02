select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    K_LEAD_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_LEADS_F
where K_LEAD_DLHK is not null
group by K_LEAD_DLHK
having count(*) > 1



      
    ) dbt_internal_test