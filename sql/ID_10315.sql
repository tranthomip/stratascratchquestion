/* Write a query that identifies cities with higher than average home prices when compared to the national average. Output the city names.
Table: zillow_transactions

|id             |    int    |
|state          |   varchar |
|city           |   varchar |
|street_address |  varchar  |
|mkt_price      |  int      |
*/
# solution
with tbl1 as
(select id, state, avg(mkt_price) as avg_state
from zillow_transactions
group by state), tbl2 as
(select id, city, avg(mkt_price) as avg_city
from zillow_transactions
group by city)
select b.city
from tbl1 a, tbl2 b
where a.avg_state < b.avg_city
group by b.city