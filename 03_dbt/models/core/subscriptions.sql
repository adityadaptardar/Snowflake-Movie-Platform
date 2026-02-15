{{ config(materialized='table') }}

SELECT DISTINCT
    subscription_id,
    user_id,
    plan_type,
    start_date,
    end_date,
    status,
    CURRENT_TIMESTAMP() AS updated_ts
FROM {{ source('raw','raw_subscriptions') }}