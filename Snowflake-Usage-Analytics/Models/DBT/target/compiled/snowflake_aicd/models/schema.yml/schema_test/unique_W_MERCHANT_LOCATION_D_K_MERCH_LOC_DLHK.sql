
    
    

select
    K_MERCH_LOC_DLHK,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_MCLEOD_SQUARE.W_MERCHANT_LOCATION_D
where K_MERCH_LOC_DLHK is not null
group by K_MERCH_LOC_DLHK
having count(*) > 1


