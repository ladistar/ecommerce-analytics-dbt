
{{ config(materialized='view') }}

select
    event_id,
    user_id,
    event_type,
    cast(event_timestamp as timestamp) as event_timestamp,
    page_url,
    campaign_id,
    extract(date from cast(event_timestamp as timestamp)) as event_date,
    extract(hour from cast(event_timestamp as timestamp)) as event_hour,
    current_timestamp() as _loaded_at
from {{ ref('web_events') }}
