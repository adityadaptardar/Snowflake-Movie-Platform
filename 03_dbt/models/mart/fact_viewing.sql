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

    SELECT COALESCE(MAX(ingestion_ts),'1900-01-01') AS max_ts
    FROM {{ this }}

)

SELECT s.*
FROM source_data s

{% if is_incremental() %}

JOIN max_loaded m
  ON s.ingestion_ts > m.max_ts

{% endif %}