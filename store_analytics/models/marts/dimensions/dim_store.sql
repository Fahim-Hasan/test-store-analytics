with transaction_all as (
    select *
    from {{ ref('base_transaction')}}
),

formatted as (
    select distinct
        store_id,
        store_name,
        store_address,
        city,
        country,
        typology

    from transaction_all
)

select *
from formatted