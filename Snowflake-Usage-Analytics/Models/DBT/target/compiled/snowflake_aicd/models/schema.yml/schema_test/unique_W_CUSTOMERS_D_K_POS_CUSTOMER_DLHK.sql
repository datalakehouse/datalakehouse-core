
    
    

select
    K_POS_CUSTOMER_DLHK,
    count(*) as n_records

from DEVELOPER_SANDBOX.DBT_MCLEOD_SQUARE.W_CUSTOMERS_D
where K_POS_CUSTOMER_DLHK is not null
group by K_POS_CUSTOMER_DLHK
having count(*) > 1


