with transaction_raw as (
    select * from {{ source('transaction_information', 'transaction') }}
),

formatted as (
    select
        cast(id as string) as transaction_id,
        cast(device_id as string) as device_id,
        cast(product_name as string) as product_name,
        cast(product_sku as string) as product_sku,
        cast(category_name as string) as category_name,
        cast(amount as float) as transaction_amount,
        cast(status as string) as transaction_status,
        cast(card_number as string) as card_number,
        cast(cvv as int) as cvv,
        cast(created_at as timestamp) as created_at,
        cast(happened_at as timestamp) as transaction_time
    from transaction_raw
)

select *
from formatted
