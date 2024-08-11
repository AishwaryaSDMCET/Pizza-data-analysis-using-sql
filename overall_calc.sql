-- Identify the highest priced pizza

select
	pizza_types.name,pizzas.price from pizzas
join
	pizza_types
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by price desc
limit 1;

-- Most common pizza size ordered ?

select
	pizzas.size, sum(orders_details.quantity) as total_quantity from pizzas
join
	orders_details
on
	orders_details.pizza_id = pizzas.pizza_id
group by
	pizzas.size
order by
	total_quantity desc
limit 1;

-- most ordered pizza with quantity ?

select pizza_types.name, sum(orders_details.quantity) as Ordered from pizzas
join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by Ordered desc
limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category, sum(orders_details.quantity) as total_ordered from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by category
order by total_ordered desc;

-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hour,count(order_id) as total_order from orders
group by hour
order by total_order desc;

-- Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) as count from pizza_types
group by category

-- Group the orders by date and calculate the average number of pizzas ordered per day.



-- Determine the top 3 most ordered pizza types based on revenue

select pizza_types.category, round(sum(quantity * price),2) as total_revenue
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by category
order by total_revenue desc;

-- Calculate the percentage contribution of each pizza type to total revenue.

select round(sum(orders_details.quantity * pizzas.price),2) as total_sales
from orders_details
inner join pizzas as total_revenue
on orders_details.pizza_id = pizzas.pizza_id 




-- Analyze the cumulative revenue generated over time.

select order_date, sum(sold) over(order by order_date) from
(select orders.order_date, sum(pizzas.price * orders_details.quantity) as sold
from orders
join orders_details
on orders_details.order_id = orders.order_id
join pizzas
on pizzas.pizza_id = orders_details.pizza_id
group by orders.order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
-- want name and category

select category, name, revenue, ranking from
(select category, name, revenue, rank() over(partition by category order by revenue desc) as ranking from
(select pizza_types.category, pizza_types.name, sum(pizzas.price*orders_details.quantity) as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as pizza) as pizza1
where ranking <=3;