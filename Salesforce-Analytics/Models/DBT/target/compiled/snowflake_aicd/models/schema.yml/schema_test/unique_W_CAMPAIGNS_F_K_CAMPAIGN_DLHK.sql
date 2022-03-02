
    
    

select
    K_CAMPAIGN_DLHK as unique_field,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_SALESFORCE.W_CAMPAIGNS_F
where K_CAMPAIGN_DLHK is not null
group by K_CAMPAIGN_DLHK
having count(*) > 1


