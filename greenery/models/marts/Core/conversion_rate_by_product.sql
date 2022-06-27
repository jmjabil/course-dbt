with 
events as (
    SELECT * FROM {{ ref('stg_events') }}
),
checkouts as (
    SELECT * FROM {{ ref('stg_events') }}
    WHERE event_type = 'checkout'
),
int as (
SELECT 
COUNT(DISTINCT b.session_id) AS numer,
COUNT(DISTINCT a.session_id) AS denom
--AS conversion_rate
FROM events a 
JOIN checkouts b 
on a.product_id = b.product_id
)

SELECT 
ROUND(numer*100.0/denom, 1) AS PERCENT
FROM int