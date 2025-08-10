
{{ config(materialized='view') }}

select
    customer_id,
    email,
    first_name,
    last_name,
    cast(signup_date as date) as signup_date,
    customer_segment,
    acquisition_channel,
    country,
    is_active,
    current_timestamp() as _loaded_at
from {{ ref('customers') }}
