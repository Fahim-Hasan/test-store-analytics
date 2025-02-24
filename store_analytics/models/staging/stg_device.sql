with device_raw as (
    select * from {{ source('transaction_information', 'device') }}
),

formatted as (
    select
        cast(id as string) as device_id,
        cast(type as string) as device_type,
        cast(store_id as string) as store_id,
    from device_raw
)

select *
from formatted
