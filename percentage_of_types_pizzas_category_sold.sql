select
pizza_types.category,
((sum(quantity * pizzas.price) / (select round(sum(quantity * pizzas.price),2)
from orders_details
inner join pizzas
on orders_details.pizza_id = pizzas.pizza_id))*100) as sold from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by category;