
{{ config(materialized='table') }}

with product_sales as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.brand,
        p.price,
        p.cost,
        p.gross_margin,
        p.margin_percentage,
        p.is_active,
        coalesce(sum(oi.quantity), 0) as total_quantity_sold,
        coalesce(sum(oi.line_total), 0) as total_revenue,
        coalesce(count(distinct oi.order_id), 0) as total_orders,
        coalesce(avg(oi.unit_price), 0) as avg_selling_price
    from {{ ref('stg_products') }} p
    left join {{ ref('stg_order_items') }} oi on p.product_id = oi.product_id
    left join {{ ref('stg_orders') }} o on oi.order_id = o.order_id 
        and o.order_status = 'completed'
    group by 1,2,3,4,5,6,7,8,9
),

product_rankings as (
    select
        *,
        row_number() over (order by total_revenue desc) as revenue_rank,
        row_number() over (order by total_quantity_sold desc) as quantity_rank,
        case
            when total_revenue = 0 then 'No Sales'
            when revenue_rank <= 50 then 'Top Seller'
            when revenue_rank <= 200 then 'Good Seller'
            else 'Low Seller'
        end as performance_tier
    from product_sales
)

select * from product_rankings
