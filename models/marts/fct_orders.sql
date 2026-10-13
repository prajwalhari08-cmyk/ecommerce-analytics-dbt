with orders as (
    select * from {{ ref('stg_orders') }}
),
customers as (
    select * from {{ ref('stg_customers') }}
)

select 
    o.order_id,
    c.customer_unique_id,
    o.order_status,
    o.order_placed_at,
    o.order_delivered_at,
    datediff('day', o.order_placed_at, o.order_delivered_at) as delivery_days,
    case 
        when datediff('day', o.order_placed_at, o.order_delivered_at) <= 3 then 'Fast (0-3 Days)'
        when datediff('day', o.order_placed_at, o.order_delivered_at) between 4 and 7 then 'Standard (4-7 Days)'
        when datediff('day', o.order_placed_at, o.order_delivered_at) > 7 then 'Delayed (>7 Days)'
        else 'Undelivered / Unknown'
    end as delivery_speed_category
from orders o
left join customers c 
    on o.customer_id = c.customer_id