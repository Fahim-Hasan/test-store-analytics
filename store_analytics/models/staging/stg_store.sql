with store_raw as (
    select * from {{ source('transaction_information', 'store') }}
),

formatted as (
    select
        cast(id as string) as store_id,
        cast(name as string) as store_name,
        cast(address as string) as store_address,
        cast(city as string) as city,
        cast(country as string) as country,
        cast(typology as string) as typology,
        cast(customer_id as string) as customer_id,
        cast(created_at as timestamp) as created_at,
    from store_raw
)

select *
from formatted
