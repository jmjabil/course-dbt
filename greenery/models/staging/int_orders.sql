{{config(materialized='table')}}

SELECT
{{ dbt_utils.star(from=ref('stg_orders'), relation_alias="o") }},
{{ dbt_utils.star(from=ref('stg_order_items'), except=["order_id"], relation_alias="ot") }}
FROM {{ ref('stg_orders') }} o 
JOIN {{ ref('stg_order_items') }} ot 
ON o.order_id = ot.order_id
