{{ config(materialized='table',schema='mart') }}

SELECT
    movie_id,
    title,
    genres
FROM {{ ref('movies') }}