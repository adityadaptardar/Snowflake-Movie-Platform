{{ config(
    materialized='incremental',
    unique_key='event_id'
) }}

SELECT
    s.event_id,
    s.user_id,
    s.movie_id,
    s.watch_start_time,
    s.watch_duration_minutes,
    s.device_type,
    s.rating,
    s.ingestion_ts
FROM {{ source('raw','v_view_events_parsed') }} s

{% if is_incremental() %}

WHERE s.ingestion_ts > (
    SELECT COALESCE(MAX(ingestion_ts), '1900-01-01')
    FROM {{ this }}
)

{% endif %}