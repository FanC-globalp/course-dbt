{{
  config(
    materialized='view'
  )
}}

select
    PRODUCT_ID, NAME, PRICE, INVENTORY
from {{source('postgres','products')}}