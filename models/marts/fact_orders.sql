{{ config(materialized='table') }}

with orders as (
    select
        order_id,
        customer_id,
        order_status,
        order_purchase_ts,
        order_approved_ts,
        order_delivered_carrier_ts,
        order_delivered_customer_ts,
        order_estimated_delivery_date
    from {{ ref('stg_orders') }}
),

customers as (
    select
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    from {{ ref('stg_customers') }}
),

order_items_agg as (
    select
        order_id,
        count(*)                         as items_count,
        sum(price)                       as items_revenue,
        sum(freight_value)               as freight_revenue,
        sum(price + freight_value)       as total_order_value
    from {{ ref('stg_order_items') }}
    group by order_id
),

joined as (
    select
        o.order_id,
        o.customer_id,
        c.customer_unique_id,
        c.customer_zip_code_prefix,
        c.customer_city,
        c.customer_state,
        o.order_status,
        o.order_purchase_ts,
        o.order_approved_ts,
        o.order_delivered_carrier_ts,
        o.order_delivered_customer_ts,
        o.order_estimated_delivery_date,
        oi.items_count,
        oi.items_revenue,
        oi.freight_revenue,
        oi.total_order_value
    from orders o
    left join customers c
        on o.customer_id = c.customer_id
    left join order_items_agg oi
        on o.order_id = oi.order_id
)

select
    *
from joined
