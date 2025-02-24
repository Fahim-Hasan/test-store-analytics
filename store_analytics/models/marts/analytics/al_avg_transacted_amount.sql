with transaction as
(
    select
        store_id,
        transaction_amount
    from {{ref('fct_transactions')}}
    where transaction_status = 'ACCEPTED'
),
store_info as (
    select
        store_id,
        typology,
        country
        from {{ref('dim_store')}}

)

select
    store_info.typology,
    store_info.country,
    round(avg(transaction_amount),2) as average_transaction_amount
from transaction left join store_info
on transaction.store_id = store_info.store_id
group by 1,2
