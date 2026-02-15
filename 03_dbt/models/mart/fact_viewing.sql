{{ config(
    materialized='incremental',
    unique_key='event_id',
    schema='mart'
) }}

WITH source_data AS (

    SELECT
        event_id,
        user_id,
        movie_id,
        watch_start_time,
        watch_duration_minutes,
        device_type,
        rating,
        ingestion_ts
    FROM {{ ref('view_events') }}

),

max_loaded AS (

    {% if is_incremental() %}

        SELECT COALESCE(MAX(ingestion_ts),'1900-01-01') AS max_ts
        FROM {{ this }}

    {% else %}

        SELECT '1900-01-01'::TIMESTAMP AS max_ts

    {% endif %}

)

SELECT
    s.event_id,
    s.user_id,
    s.movie_id,
    s.watch_start_time,
    s.watch_duration_minutes,
    s.device_type,
    s.rating,
    s.ingestion_ts
FROM source_data s
JOIN max_loaded m
  ON s.ingestion_ts > m.max_ts