What is our overall conversion rate?
 62%
 ```
 select 
    count(distinct session_id) as views,
    count(distinct case when checkouts > 0 then session_id end) as checkout,
    checkout/views
from DEV_DB.DBT_FANCHENGLOBALPCOM.FACT_PAGE_VIEWS
```
What is our conversion rate by product?

PRODCUT_ID	NAME	VIEWS	CHECKOUT	CHECKOUT/VIEWS
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls	64	39	0.609375
74aeb414-e3dd-4e8a-beef-0fa45225214d	Arrow Head	63	35	0.555556
5b50b820-1d0a-4231-9422-75e7f6b0cecf	Pilea Peperomioides	59	28	0.474576
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron	62	30	0.483871
c7050c3b-a898-424d-8d98-ab0aaad7bef4	Orchid	75	34	0.453333
c17e63f7-0d28-4a95-8248-b01ea354840e	Cactus	55	30	0.545455
d3e228db-8ca5-42ad-bb0a-2148e876cc59	Money Tree	56	26	0.464286
e5ee99b6-519f-4218-8b41-62f48f59f700	Peace Lily	66	27	0.409091
5ceddd13-cf00-481f-9285-8340ab95d06d	Majesty Palm	67	33	0.492537
a88a23ef-679c-4743-b151-dc7722040d8c	Jade Plant	46	22	0.478261
b86ae24b-6f59-47e8-8adc-b17d88cbd367	Calathea Makoyana	53	27	0.509434
e18f33a6-b89a-4fbc-82ad-ccba5bb261cc	Ponytail Palm	70	28	0.4
e706ab70-b396-4d30-a6b2-a1ccf3625b52	Fiddle Leaf Fig	56	28	0.5
e2e78dfc-f25c-4fec-a002-8e280d61a2f2	Boston Fern	63	26	0.412698
bb19d194-e1bd-4358-819e-cd1f1b401c0c	Birds Nest Fern	78	33	0.423077
37e0062f-bd15-4c3e-b272-558a86d90598	Dragon Tree	62	29	0.467742
689fb64e-a4a2-45c5-b9f2-480c2155624d	Bamboo	67	36	0.537313
64d39754-03e4-4fa0-b1ea-5f4293315f67	Spider Plant	59	28	0.474576
be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera	49	25	0.510204
843b6553-dc6a-4fc4-bceb-02cd39af0168	Ficus	68	29	0.426471
35550082-a52d-4301-8f06-05b30f6f3616	Devil's Ivy	45	22	0.488889
80eda933-749d-4fc6-91d5-613d29eb126f	Pink Anthurium	74	31	0.418919
e8b6528e-a830-4d03-a027-473b411c7f02	Snake Plant	73	29	0.39726
58b575f2-2192-4a53-9d21-df9a0c14fc25	Angel Wings Begonia	61	24	0.393443
05df0866-1a66-41d8-9ed7-e2bbcddd6a3d	Bird of Paradise	60	27	0.45
6f3a3072-a24d-4d11-9cef-25b0b5f8a4af	Alocasia Polly	51	21	0.411765
579f4cd0-1f45-49d2-af55-9ab2b72c3b35	Rubber Plant	54	28	0.518519
4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos	61	21	0.344262
b66a7143-c18a-43bb-b5dc-06bb5d1d3160	ZZ Plant	63	34	0.539683
615695d3-8ffd-4850-bcf7-944cf6d3685b	Aloe Vera	65	32	0.492308
```
select 
    PV.prodcut_id,
    P.name,
    count(distinct session_id) as views,
    count(distinct case when checkouts > 0 then session_id end) as checkout,
    checkout/views
from DEV_DB.DBT_FANCHENGLOBALPCOM.FACT_PAGE_VIEWS PV
left join DEV_DB.DBT_FANCHENGLOBALPCOM.FACT_PRODUCTS P
    on P.PRODUCT_ID = PV.PRODCUT_ID
group by 1,2
```