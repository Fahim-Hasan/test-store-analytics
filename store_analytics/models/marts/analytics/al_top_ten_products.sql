with transaction as
(
    select
        product_id,
        transaction_amount
    from ANALYTICS_DEV.DBT_FHASAN_CENTRAL.FCT_TRANSACTIONS
    where transaction_status = 'ACCEPTED'
),

product as (
    select
    product_id,
    product_name
    from ANALYTICS_DEV.DBT_FHASAN_CENTRAL.DIM_PRODUCT
)

select
    product_name,
    sum(transaction_amount) as total
from transaction left join product
on transaction.product_id = product.product_id
group by product_name
order by total desc
limit 10