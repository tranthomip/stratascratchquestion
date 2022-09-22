/* 
Find the most expensive products on Amazon for each product category.
Output category, product name and the price (as a number)

Table: innerwear_amazon_com

product_name:			varchar
mrp:					varchar
price:					varchar
pdp_url:				varchar
brand_name:				varchar
product_category:		varchar
retailer:				varchar
description:			varchar
rating:					float
review_count:			int
style_attributes:		varchar
total_sizes:			varchar
available_size:			varchar
color:					varchar
*/
-- solution
with tbl as 
(select product_category,
        product_name,
        price,
        row_number() over(partition by product_category order by price desc) as rank_price
from innerwear_amazon_com
)
select product_category,
        product_name,
        price
from tbl
where rank_price = 1