with transaction_all as (
    select *
    from {{ ref('base_transaction')}}
),

formatted as (
    select distinct
        customer_id
-- We can add more information of customer here, based on availability
    from transaction_all
)

select *
from formatted