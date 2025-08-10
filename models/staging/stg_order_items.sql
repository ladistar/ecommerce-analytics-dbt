
{{ config(materialized='view') }}

select
    cast(order_item_id as int64) as order_item_id,
    cast(order_id as int64) as order_id,
    cast(product_id as int64) as product_id,
    cast(quantity as int64) as quantity,
    unit_price,
    line_total,
    current_timestamp() as _loaded_at
from {{ ref('order_items') }}
