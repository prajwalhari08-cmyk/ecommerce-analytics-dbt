{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce_raw', 'raw_orders') }}
)

select
    order_id,
    customer_id,
    order_status,
    cast(order_purchase_timestamp as timestamp) as order_placed_at,
    cast(order_delivered_customer_date as timestamp) as order_delivered_at
from source