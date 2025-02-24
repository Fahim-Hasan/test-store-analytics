with transaction as (
    select
        store_id,
        transaction_amount
    from {{ref('fct_transactions')}}
    where transaction_status = 'ACCEPTED'
),

top_ten_store as (
    select
        store_id,
        sum(transaction_amount) as total
    from transaction
    group by store_id
    order by total desc
    limit 10
)

select *
from top_ten_store

