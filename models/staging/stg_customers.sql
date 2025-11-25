{{ config(materialized='table') }}

with source as (
    select
        CUSTOMER_ID,
        CUSTOMER_UNIQUE_ID,
        CUSTOMER_ZIP_CODE_PREFIX,
        CUSTOMER_CITY,
        CUSTOMER_STATE
    from {{ source('sales_raw', 'CUSTOMERS_RAW_TABLE') }}
),

renamed as (
    select
        CUSTOMER_ID::string as customer_id,
        CUSTOMER_UNIQUE_ID::string as customer_unique_id,
        lpad(regexp_replace(CUSTOMER_ZIP_CODE_PREFIX::string, '[^0-9]', ''), 5, '0') as customer_zip_code_prefix,
        CUSTOMER_CITY::string as customer_city,
        CUSTOMER_STATE::string as customer_state
    from source
)

select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
from renamed
