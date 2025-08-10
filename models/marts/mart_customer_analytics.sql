
{{ config(materialized='table') }}

with customer_cohorts as (
    select
        customer_id,
        date_trunc(signup_date, month) as signup_cohort,
        date_trunc(first_order_date, month) as first_order_cohort
    from {{ ref('int_customer_metrics') }}
),

final as (
    select
        cm.*,
        cc.signup_cohort,
        cc.first_order_cohort,
        case 
            when cm.days_since_last_order is null then 'Never Ordered'
            when cm.days_since_last_order <= 30 then 'Active'
            when cm.days_since_last_order <= 90 then 'At Risk'
            when cm.days_since_last_order <= 180 then 'Dormant'
            else 'Lost'
        end as customer_lifecycle_stage,
        case
            when cm.total_revenue > 1000 and cm.total_orders > 5 then 'VIP'
            when cm.total_revenue > 500 or cm.total_orders > 3 then 'Valuable'
            when cm.total_revenue > 100 or cm.total_orders > 1 then 'Standard'
            else 'New'
        end as customer_value_tier
    from {{ ref('int_customer_metrics') }} cm
    left join customer_cohorts cc on cm.customer_id = cc.customer_id
)

select * from final
