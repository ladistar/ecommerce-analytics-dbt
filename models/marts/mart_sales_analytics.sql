
{{ config(materialized='table') }}

select
    oe.order_id,
    oe.customer_id,
    oe.order_date,
    oe.order_status,
    oe.total_amount,
    oe.subtotal,
    oe.shipping_cost,
    oe.tax_amount,
    oe.item_count,
    oe.total_quantity,
    oe.customer_segment,
    oe.acquisition_channel,
    oe.country,
    oe.order_year,
    oe.order_month,
    oe.order_day_name,
    ca.customer_lifecycle_stage,
    ca.customer_value_tier,
    ca.order_frequency_segment,
    ca.revenue_segment,
    -- Calculate running totals and metrics
    sum(case when oe.order_status = 'completed' then oe.total_amount else 0 end) 
        over (partition by oe.customer_id order by oe.order_date rows unbounded preceding) as customer_running_total,
    row_number() over (partition by oe.customer_id order by oe.order_date) as customer_order_sequence
from {{ ref('int_order_enriched') }} oe
left join {{ ref('mart_customer_analytics') }} ca on oe.customer_id = ca.customer_id
