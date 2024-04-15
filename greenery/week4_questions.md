Part 1. dbt Snapshots
Let's update our products snapshot one last time to see how our data is changing:
Run the products snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 
Which products had their inventory change from week 3 to week 4? 

ZZ Plant
Bamboo
Philodendron
Pothos
Monstera
String of pearls

Now that we have 3 weeks of snapshot data, can you use the inventory changes to determine which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks? 

String of pearls	58
```
SELECT 
    name,
    max(inventory)-min(inventory) as inventory_diff
FROM DEV_DB.DBT_FANCHENGLOBALPCOM.INVENTORY_SNAPSHOT
group by 1
order by 2 desc
```
out of stock
Pothos
String of pearls
```
SELECT *
FROM DEV_DB.DBT_FANCHENGLOBALPCOM.INVENTORY_SNAPSHOT
WHERE inventory = 0
```

Part 2. Modeling challenge
Let’s say that the Director of Product at greenery comes to us (the head Analytics Engineer) and asks some questions:
How are our users moving through the product funnel?

TOTAL_SESSION_RATE	ADD_TO_CARTS_RATE	CHECKOUTS_RATE
1.000000	0.807958	0.624567

```
select
    count(distinct case when page_views >=1 then session_id else null end) as total_session,
    count(distinct case when add_to_carts>= 1 then session_id else null end) as total_add_to_cart,
     count(distinct case when checkouts>= 1 then session_id else null end) as total_checkouts,
     total_session / total_session as total_session_rate,
     total_add_to_cart / total_session as add_to_carts_rate,
     total_checkouts / total_session as checkouts_rate,
     
from DEV_DB.DBT_FANCHENGLOBALPCOM.FACT_PAGE_VIEWS
```

Which steps in the funnel have largest drop off points?

add to cart
```
```
3A. dbt next steps for you 
Reflecting on your learning in this class...
if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?

Easy to use and manage -- docs and logs

if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

Use snapshots to track changes

if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

DBT, data modeling

3B. Setting up for production / scheduled dbt run of your project And finally, before you fly free into the dbt night, we will take a step back and reflect: after learning about the various options for dbt deployment and seeing your final dbt project, how would you go about setting up a production/scheduled dbt run of your project in an ideal state? You don’t have to actually set anything up - just jot down what you would do and why and post in a README file.

use dbt cloud to run stage at 3 am, prod at 4

Hints: what steps would you have? Which orchestration tool(s) would you be interested in using? What schedule would you run your project on? Which metadata would you be interested in using? How/why would you use the specific metadata? , etc.