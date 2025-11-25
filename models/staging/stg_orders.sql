{{ config(materialized='table') }}

with source as (
    select
        ORDER_ID,
        CUSTOMER_ID,
        ORDER_STATUS,
        ORDER_PURCHASE_TIMESTAMP,
        ORDER_APPROVED_AT,
        ORDER_DELIVERED_CARRIER_DATE,
        ORDER_DELIVERED_CUSTOMER_DATE,
        ORDER_ESTIMATED_DELIVERY_DATE
    from {{ source('sales_raw', 'ORDERS_RAW_TABLE') }}
),

renamed as (
    select
        ORDER_ID::string                        as order_id,
        CUSTOMER_ID::string                     as customer_id,
        ORDER_STATUS::string                    as order_status,
        ORDER_PURCHASE_TIMESTAMP::timestamp_ntz as order_purchase_ts,
        ORDER_APPROVED_AT::timestamp_ntz        as order_approved_ts,
        ORDER_DELIVERED_CARRIER_DATE::timestamp_ntz   as order_delivered_carrier_ts,
        ORDER_DELIVERED_CUSTOMER_DATE::timestamp_ntz  as order_delivered_customer_ts,
        ORDER_ESTIMATED_DELIVERY_DATE::date           as order_estimated_delivery_date
    from source
)

select
    order_id,
    customer_id,
    order_status,
    order_purchase_ts,
    order_approved_ts,
    order_delivered_carrier_ts,
    order_delivered_customer_ts,
    order_estimated_delivery_date
from renamed
