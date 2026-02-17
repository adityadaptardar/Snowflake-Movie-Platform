{{ config(materialized='table',schema='mart') }}

SELECT
    user_id,
    gender,
    age,
    occupation,
    country,
    primary_device,
    signup_date
FROM {{ ref('users') }}