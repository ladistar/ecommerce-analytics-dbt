
{{ config(materialized='table') }}

with customer_orders as (
    select
        c.customer_id,
        c.email,
        c.first_name,
        c.last_name,
        c.signup_date,
        c.customer_segment,
        c.acquisition_channel,
        c.country,
        c.is_active,
        count(o.order_id) as total_orders,
        coalesce(sum(case when o.order_status = 'completed' then 1 else 0 end), 0) as completed_orders,
        coalesce(sum(case when o.order_status = 'completed' then o.total_amount else 0 end), 0) as total_revenue,
        coalesce(avg(case when o.order_status = 'completed' then o.total_amount end), 0) as avg_order_value,
        min(o.order_date) as first_order_date,
        max(o.order_date) as last_order_date
    from {{ ref('stg_customers') }} c
    left join {{ ref('stg_orders') }} o on c.customer_id = o.customer_id
    group by 1,2,3,4,5,6,7,8,9
),

customer_segments as (
    select
        *,
        case 
            when total_orders = 0 then 'No Orders'
            when total_orders = 1 then 'One-Time'
            when total_orders between 2 and 5 then 'Regular'
            when total_orders > 5 then 'Loyal'
        end as order_frequency_segment,
        case
            when total_revenue = 0 then 'No Revenue'
            when total_revenue < 100 then 'Low Value'
            when total_revenue between 100 and 500 then 'Medium Value'
            when total_revenue > 500 then 'High Value'
        end as revenue_segment,
        date_diff(current_date(), last_order_date, day) as days_since_last_order
    from customer_orders
)

select * from customer_segments
