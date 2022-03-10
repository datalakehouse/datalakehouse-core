
    
    

select
    K_CURRENCY_DLHK,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_MCLEOD_SQUARE.W_CURRENCY_D
where K_CURRENCY_DLHK is not null
group by K_CURRENCY_DLHK
having count(*) > 1


