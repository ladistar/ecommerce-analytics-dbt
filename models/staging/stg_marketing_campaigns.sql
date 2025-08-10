
{{ config(materialized='view') }}

select
    campaign_id,
    campaign_name,
    campaign_type,
    cast(start_date as date) as start_date,
    cast(end_date as date) as end_date,
    budget,
    status,
    date_diff(cast(end_date as date), cast(start_date as date), day) as campaign_duration_days,
    current_timestamp() as _loaded_at
from {{ ref('marketing_campaigns') }}
