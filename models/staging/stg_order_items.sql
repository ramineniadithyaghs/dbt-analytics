{{ config(materialized='table') }}

with source as (
    select
        ORDER_ID,
        ORDER_ITEM_ID,
        PRODUCT_ID,
        SELLER_ID,
        SHIPPING_LIMIT_DATE,
        PRICE,
        FREIGHT_VALUE
    from {{ source('sales_raw', 'ORDER_ITEMS_RAW_TABLE') }}
),

renamed as (
    select
        ORDER_ID::string                as order_id,
        ORDER_ITEM_ID::number           as order_item_id,
        PRODUCT_ID::string              as product_id,
        SELLER_ID::string               as seller_id,
        SHIPPING_LIMIT_DATE::timestamp_ntz as shipping_limit_ts,
        PRICE::number(10,2)             as price,
        FREIGHT_VALUE::number(10,2)     as freight_value
    from source
)

select *
from renamed
