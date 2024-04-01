{{
  config(
    materialized='table'
  )
}}

with

events as (
  select  * from {{ref('stg_postgres_events')}}
),

Order_items as(
  select * from {{ref('stg_postgres_order_items')}}
),

sesstion_timing_agg as (
  select * from {{ref('int_session_timing')}}
)

select 
  e.session_id,
  e.user_id,
  coalesce(e.PRODUCT_ID, oi.PRODUCT_ID) as prodcut_id,
  s.session_start_time,
  s.session_end_time,
  sum((e.event_type = 'page_view') ::int) as page_views,
  sum((e.event_type = 'add_to_cart') ::int) as add_to_carts,
  sum((e.event_type = 'checkout') ::int) as checkouts,
  sum((e.event_type = 'packages_shipped') ::int) as packages_shipped,
  datediff('minute',session_start_time,session_end_time) as session_duration_minutes
from events e
left join Order_items oi
  on oi.order_id = e.order_id
left join sesstion_timing_agg s
  on s.session_id = e.session_id
group by 1,2,3,4,5