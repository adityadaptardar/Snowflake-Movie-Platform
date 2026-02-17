{{ config(materialized='table',schema='mart') }}

SELECT
    subscription_id,
    user_id,
    plan_type,
    status,
    start_date,
    end_date
FROM {{ ref('subscriptions') }}