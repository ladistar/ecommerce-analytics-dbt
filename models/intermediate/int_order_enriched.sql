
{{ config(materialized='table') }}

with order_details as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.order_status,
        o.shipping_cost,
        o.tax_amount,
        o.total_amount,
        o.subtotal,
        c.customer_segment,
        c.acquisition_channel,
        c.country,
        count(oi.order_item_id) as item_count,
        sum(oi.quantity) as total_quantity,
        extract(year from o.order_date) as order_year,
        extract(month from o.order_date) as order_month,
        extract(dayofweek from o.order_date) as order_day_of_week,
        case extract(dayofweek from o.order_date)
            when 1 then 'Sunday'
            when 2 then 'Monday'
            when 3 then 'Tuesday'
            when 4 then 'Wednesday'
            when 5 then 'Thursday'
            when 6 then 'Friday'
            when 7 then 'Saturday'
        end as order_day_name
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_customers') }} c on o.customer_id = c.customer_id
    left join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    group by 1,2,3,4,5,6,7,8,9,10,11,14,15,16,17
)

select * from order_details
