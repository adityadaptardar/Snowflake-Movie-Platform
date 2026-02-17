{{ config(materialized='table') }}

SELECT DISTINCT
    user_id,
    gender,
    TRY_TO_NUMBER(age) AS age,
    occupation,
    country,
    primary_device,
    signup_date,
    CURRENT_TIMESTAMP() AS updated_ts
FROM {{ source('raw','raw_users') }}