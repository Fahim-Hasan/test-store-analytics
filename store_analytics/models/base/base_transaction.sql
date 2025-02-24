{{
    config(
            cluster_by=["transaction_date","store_id"],
            materialized='incremental',
            event_time = created_at,
            begin = '2021-01-01',
            batch_size = 'day'
    )
}}

with transaction as (
    select
        transaction_id,
        device_id,
        regexp_replace(upper(product_name), '[.,:]', '') as product_name,
        product_sku,
        regexp_replace(upper(category_name), '[.,:]', '') as category_name,
        transaction_amount,
        upper(transaction_status) as transaction_status,
        card_number,
        cvv,
        created_at,
        transaction_time,
        date(transaction_time) as transaction_date

    from {{ref('stg_transaction')}}
),
store as (
    select
        store_id,
        customer_id,
        regexp_replace(upper(store_name), '[.,:]', '') as store_name,
        regexp_replace(upper(store_address), '[.,:]', '') as store_address,
        regexp_replace(upper(city), '[.,:]', '') as city,
        regexp_replace(upper(country), '[.,:]', '') as country,
        regexp_replace(upper(typology), '[.,:]', '') as typology
    from {{ref('stg_store')}}
),
device as (
    select * from {{ref('stg_device')}}
),

store_with_device as (
    select
        store.*,
        device.device_id,
        device.device_type
    from store left join device
    on store.store_id = device.store_id
),

transaction_with_store as (
    select
        transaction.*,
        cast(abs(hash(product_sku, product_name)) as string) as product_id,
        store_with_device.* exclude (device_id)
    from transaction left join store_with_device
    on transaction.device_id = store_with_device.device_id
),

formatted as (
    select
        transaction_id,
        device_id,
        customer_id,
        store_id,
        product_id,
        product_sku,
        card_number,
        cvv,

        product_name,
        category_name as product_category_name,
        store_name,
        store_address,
        city,
        country,
        typology,

        device_type,
        transaction_amount,
        transaction_status,

        created_at,
        transaction_time,
        transaction_date

    from transaction_with_store
)

select *
from formatted

