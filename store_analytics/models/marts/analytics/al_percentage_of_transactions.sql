with transaction as
(
    select device_id, transaction_amount
    from from {{ref('fct_transactions')}}
    where transaction_status = 'ACCEPTED'
),
device_info as (
    select
        device_id,
        device_type
        from from {{ref('dim_device')}}
)

select
    device_type,
    round(100* (ratio_to_report(sum(transaction_amount)) over()),2) as percentage
from transaction left join device_info
on transaction.device_id = device_info.device_id
group by 1
