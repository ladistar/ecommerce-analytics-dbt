
{{ config(materialized='table') }}

with category_metrics as (
    select
        category,
        count(*) as products_in_category,
        avg(total_revenue) as avg_category_revenue,
        sum(total_revenue) as category_total_revenue
    from {{ ref('int_product_performance') }}
    group by category
),

brand_metrics as (
    select
        brand,
        count(*) as products_in_brand,
        avg(total_revenue) as avg_brand_revenue,
        sum(total_revenue) as brand_total_revenue
    from {{ ref('int_product_performance') }}
    group by brand
),

final as (
    select
        pp.*,
        cm.products_in_category,
        cm.avg_category_revenue,
        cm.category_total_revenue,
        bm.products_in_brand,
        bm.avg_brand_revenue,
        bm.brand_total_revenue,
        case
            when pp.total_revenue > cm.avg_category_revenue then 'Above Category Average'
            else 'Below Category Average'
        end as category_performance,
        case
            when pp.total_revenue > bm.avg_brand_revenue then 'Above Brand Average'
            else 'Below Brand Average'
        end as brand_performance
    from {{ ref('int_product_performance') }} pp
    left join category_metrics cm on pp.category = cm.category
    left join brand_metrics bm on pp.brand = bm.brand
)

select * from final
