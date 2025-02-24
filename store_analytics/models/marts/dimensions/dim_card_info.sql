with transaction_all as (
    select *
    from {{ ref('base_transaction')}}
),

formatted as (
    select distinct
        card_number,
        cvv
-- We can add more information of card here, based on availability
    from transaction_all
)

select *
from formatted