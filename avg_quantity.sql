select round(avg(quantity),0) from
(select orders.order_date as day, sum(quantity) as quantity from orders
join orders_details
on orders.order_id = orders_details.order_id
group by day) as order_quantity;