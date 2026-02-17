{{ config(materialized='table') }}

SELECT DISTINCT
    movie_id,
    title,
    genres,
    CURRENT_TIMESTAMP() AS updated_ts
FROM {{ source('raw','raw_movies') }}