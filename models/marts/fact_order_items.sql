{{ config(materialized='table') }}

with order_items as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        price,
        freight_value
    from {{ ref('stg_order_items') }}
),

final as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        price,
        freight_value,
        -- simple derived metrics
        price + freight_value as item_total_value
    from order_items
)

select
    *
from final
