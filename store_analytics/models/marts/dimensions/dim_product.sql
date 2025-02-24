with transaction_all as (
    select *
    from {{ ref('base_transaction')}}
),

formatted as (
    select distinct
        product_id,
        product_sku,
        product_name,
        product_category_name

    from transaction_all
)

select *
from formatted