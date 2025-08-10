
{{ config(materialized='view') }}

select
    order_id,
    customer_id,
    cast(order_date as date) as order_date,
    order_status,
    shipping_cost,
    tax_amount,
    total_amount,
    round(total_amount - shipping_cost - tax_amount, 2) as subtotal,
    current_timestamp() as _loaded_at
from {{ ref('orders') }}
