How many users do we have?
130

```
select
    count(user_id),
    count(distinct user_id) as countd,
from DEV_DB.DBT_FANCHENGLOBALPCOM.STG_POSTGRES_USERS
```


On average, how many orders do we receive per hour?
15
```
select
   count(order_id)/count(distinct hour(created_at))
from DEV_DB.DBT_FANCHENGLOBALPCOM.STG_POSTGRES_ORDERS
```

On average, how long does an order take from being placed to being delivered?
3.9 days
```
SELECT
    avg(TIMESTAMPDIFF('day',created_at,delivered_at))
from DEV_DB.DBT_FANCHENGLOBALPCOM.STG_POSTGRES_ORDERS
```

How many users have only made one purchase? Two purchases? Three+ purchases?
1	25
2	28
3	34
4	20
5	10
6	2
7	4
8	1

```
WITH UserPurchaseCounts AS (
    SELECT USER_ID, COUNT(DISTINCT ORDER_ID) AS purchase_count
    FROM DEV_DB.DBT_FANCHENGLOBALPCOM.STG_POSTGRES_ORDERS
    GROUP BY USER_ID
)
SELECT 
    purchase_count,
    COUNT(*) AS user_count
FROM 
    UserPurchaseCounts
GROUP BY 
    purchase_count
ORDER BY 
    purchase_count;
````

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour?

10

```
SELECT 
    COUNT(DISTINCT SESSION_ID) / DATEDIFF(hour, MIN(CREATED_AT), MAX(CREATED_AT)) AS avg_sessions_per_hour
FROM

   DEV_DB.DBT_FANCHENGLOBALPCOM.STG_POSTGRES_EVENTS;
```