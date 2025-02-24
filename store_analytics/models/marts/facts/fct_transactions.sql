{{
    config(
            cluster_by=["transaction_date","store_id"],
            materialized='incremental',
            event_time = created_at,
            begin = '2021-01-01',
            batch_size = 'day'
    )
}}

with transaction_all as (
    select *
    from {{ ref('base_transaction')}}
),

formatted as (
    select
        transaction_id,
        device_id,
        customer_id,
        store_id,
        product_id,
        card_number,

        transaction_amount,
        transaction_status,

        transaction_time,
        transaction_date,
        created_at

    from transaction_all
)

select *
from formatted