{{ config(
    materialized='incremental',
    unique_key='event_id'
) }}

SELECT
    event_id,
    user_id,
    movie_id,
    watch_start_time,
    watch_duration_minutes,
    device_type,
    rating,
    ingestion_ts
FROM {{ source('raw','v_view_events_parsed') }}

{% if is_incremental() %}

-- Only process new events
WHERE ingestion_ts > (
    SELECT COALESCE(MAX(ingestion_ts), '1900-01-01')
    FROM {{ this }}
)

{% endif %}