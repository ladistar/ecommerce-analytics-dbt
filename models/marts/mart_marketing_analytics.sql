
{{ config(materialized='table') }}

with campaign_events as (
    select
        mc.campaign_id,
        mc.campaign_name,
        mc.campaign_type,
        mc.start_date,
        mc.end_date,
        mc.budget,
        mc.status,
        mc.campaign_duration_days,
        count(we.event_id) as total_events,
        count(distinct we.user_id) as unique_users,
        sum(case when we.event_type = 'page_view' then 1 else 0 end) as page_views,
        sum(case when we.event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts,
        sum(case when we.event_type = 'purchase' then 1 else 0 end) as purchases,
        sum(case when we.event_type = 'signup' then 1 else 0 end) as signups,
        sum(case when we.event_type = 'email_click' then 1 else 0 end) as email_clicks
    from {{ ref('stg_marketing_campaigns') }} mc
    left join {{ ref('stg_web_events') }} we on mc.campaign_id = we.campaign_id
    group by 1,2,3,4,5,6,7,8
),

campaign_metrics as (
    select
        *,
        safe_divide(add_to_carts, page_views) * 100 as cart_conversion_rate,
        safe_divide(purchases, page_views) * 100 as purchase_conversion_rate,
        safe_divide(signups, page_views) * 100 as signup_conversion_rate,
        safe_divide(budget, nullif(campaign_duration_days, 0)) as daily_budget,
        safe_divide(total_events, nullif(campaign_duration_days, 0)) as events_per_day
    from campaign_events
)

select * from campaign_metrics
