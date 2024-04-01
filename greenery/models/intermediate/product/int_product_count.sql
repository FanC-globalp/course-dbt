{{
  config(
    materialized='table'
  )
}}
WITH product_sell_count AS (
    SELECT 
        product_id,
        SUM(quantity) AS sell_count
    FROM {{ref('stg_postgres_order_items')}}
    GROUP BY 1
),
product_user_count AS (
    SELECT
        product_id,
        COUNT(DISTINCT user_id) AS user_count
    FROM {{ref('stg_postgres_orders')}} o
    LEFT JOIN {{ref('stg_postgres_order_items')}} oi
        ON o.order_id = oi.order_id
    GROUP BY 1
),
product AS (
    SELECT * FROM {{ref('stg_postgres_products')}}
)
SELECT 
    p.product_id,
    p.name,
    p.price,
    p.inventory,
    uc.user_count,
    sc.sell_count
FROM product p
LEFT JOIN product_user_count uc
    ON uc.product_id = p.product_id
LEFT JOIN product_sell_count sc
    ON sc.product_id = p.product_id
