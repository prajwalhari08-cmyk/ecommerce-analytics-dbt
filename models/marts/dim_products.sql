with products as (
    select * from {{ ref('stg_products') }}
)

select 
    product_id,
    coalesce(category_name, 'Unknown') as product_category,
    weight_grams,
    round((length_cm * height_cm * width_cm) / 1000.0, 2) as product_volume_liters
from products