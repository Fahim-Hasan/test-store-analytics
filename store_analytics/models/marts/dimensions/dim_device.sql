with transaction_all as (
    select *
    from {{ ref('base_transaction')}}
),

formatted as (
    select distinct
        device_id,
        device_type

    from transaction_all
)

select *
from formatted