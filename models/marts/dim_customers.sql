with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
)

select 
    c.customer_unique_id,
    max(c.customer_zip_code) as customer_zip_code,
    max(c.customer_city) as customer_city,
    max(c.customer_state) as customer_state,
    count(o.order_id) as lifetime_orders
from customers c
left join orders o 
    on c.customer_id = o.customer_id
group by 
    c.customer_unique_id