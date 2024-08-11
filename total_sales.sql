select round(sum(orders_details.quantity * pizzas.price),2) as total_sales
from orders_details
inner join pizzas
on orders_details.pizza_id = pizzas.pizza_id;