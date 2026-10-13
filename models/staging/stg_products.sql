with source as (
    select * from {{ source('ecommerce_raw', 'raw_products') }}
)

select
    product_id,
    product_category_name as category_name,
    product_weight_g as weight_grams,
    product_length_cm as length_cm,
    product_height_cm as height_cm,
    product_width_cm as width_cm
from source