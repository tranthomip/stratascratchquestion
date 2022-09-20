/* Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output customer's first name, total cost of their items, and the date.
For simplicity, you can assume that every first name in the dataset is unique.

table 1: Customers
id:             int
first_name:     varchar
last_name:      varchar
city:           varchar
address:        varchar
phone_number:   varchar

table 2: orders
id:               int
cust_id:          int
order_date:       datetime
order_details:    varchar
total_order_cost: int
*/
-- Solution

select a.first_name,
        b.order_date,
        sum(total_order_cost) as total_cost
from customers a
join orders b
on a.id = b.cust_id
group by 1,2
having b.order_date between "2019-02-01" and "2019-05-01"
order by sum(total_order_cost) desc
limit 1;