
{{ config(materialized='view') }}

select
    product_id,
    product_name,
    category,
    brand,
    price,
    cost,
    cast(created_at as date) as created_at,
    is_active,
    round(price - cost, 2) as gross_margin,
    round(safe_divide(price - cost, price) * 100, 2) as margin_percentage,
    current_timestamp() as _loaded_at
from {{ ref('products') }}
