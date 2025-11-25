{{ config(materialized='table') }}

with source as (
    select
        PRODUCT_ID,
        PRODUCT_CATEGORY_NAME,
        PRODUCT_NAME_LENGHT,
        PRODUCT_DESCRIPTION_LENGHT,
        PRODUCT_PHOTOS_QTY,
        PRODUCT_WEIGHT_G,
        PRODUCT_LENGTH_CM,
        PRODUCT_HEIGHT_CM,
        PRODUCT_WIDTH_CM
    from {{ source('sales_raw', 'PRODUCTS_RAW_TABLE') }}
),

renamed as (
    select
        PRODUCT_ID::string                  as product_id,
        PRODUCT_CATEGORY_NAME::string       as product_category_name,
        PRODUCT_NAME_LENGHT::number         as product_name_length,
        PRODUCT_DESCRIPTION_LENGHT::number  as product_description_length,
        PRODUCT_PHOTOS_QTY::number          as product_photos_qty,
        PRODUCT_WEIGHT_G::number            as product_weight_g,
        PRODUCT_LENGTH_CM::number           as product_length_cm,
        PRODUCT_HEIGHT_CM::number           as product_height_cm,
        PRODUCT_WIDTH_CM::number            as product_width_cm
    from source
)

select
    *
from renamed
