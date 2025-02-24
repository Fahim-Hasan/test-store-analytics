with transaction as
(
    select
        store_id,
        transaction_time,
        row_number() over (partition by store_id order by transaction_time) as ranking
    from {{ref('fct_transactions')}}
    where transaction_status = 'ACCEPTED'
    and store_id = '90'
),
time_calculation as (
    select *,
    lag(transaction_time) over (partition by store_id order by transaction_time) as last_transaction_time,
    ifnull(timediff('day',last_transaction_time,transaction_time),0) as day_difference
    from transaction
    where ranking <= 5
)

select
    store_id,
    round(avg(day_difference)) as avg_days
from time_calculation
group by 1

