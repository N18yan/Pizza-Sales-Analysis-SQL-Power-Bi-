use power_sql_project;
select * from pizza_salespizza_sales;


-- 1. Total Revenue :- The sum of the total price of all pizza orders.;
select round(sum(total_price),2) as Total_revenue from pizza_sales;

-- 2. Average order value:- The average amount spent per order, calculated by dividing the total revenue by the total number of orders.;
select round(sum(total_price)/count(distinct order_id),2) as Average_value from pizza_sales;

-- 3. Total pizzas Sold:- The sum of the quantities of all pizzas sold.
select sum(quantity) as Total_Pizza_Sold from pizza_sales;

-- 4. Total Orders: The total number of orders placed;
select count(distinct order_id) as Total_Orders from pizza_sales;

-- 5. Average Pizzas Per Orders: The average number of pizzas sold per order, calculated by dividing the total number of pizzas by the total number of orders;
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_pizzas_per_order from pizza_sales;

select round(sum(quantity) / count(distinct order_id),2) as Avg_pizzas_Per_Orders from pizza_sales;


-- CHART REQUIREMENT ...........................
-- 1. Daily Trends for total orders;
select dayname(order_date) as order_day, count(distinct order_id) as Total_orders from pizza_sales
group by dayname(order_date);


-- 2. Monthly Trend for Total Orders:
select monthname(order_date) as Month_name, count(distinct order_id) as Total_orders from pizza_sales
group by monthname(order_date)
order by Total_orders desc;

-- 3. Percentage of Sales by pizza Category:
select pizza_category,round(sum(total_price),1) as total_sales, round(sum(total_price) * 100 / (select sum(total_price) from pizza_sales /*where MONTH(order_date) = 1*/),2) as per_Total_sales 
from pizza_sales
-- where MONTH(order_date) = 1
group by  pizza_category;

-- 4. percentage of sales by pizza size:
select pizza_size, round(sum(total_price),2) as total_sales, round(sum(total_price) * 100 / (select sum(total_price) from pizza_sales ),2) as per_Total_sales  
from pizza_sales
group by  pizza_size
order by per_Total_sales desc; 


-- 5. Total Pizzas sold by pizza Category:
select pizza_category, sum(quantity) as total_pizza_sold , round(sum(total_price),2) as Total_revenue from pizza_sales
group by pizza_category;

-- 6. Top 5 Best Sellers by Total Pizzas Sold:
select  pizza_name, sum(total_price) as Total_revenue  from pizza_sales
group by pizza_name 
order by Total_revenue desc limit 5;


-- 7. Bottom 5 Worst Seller by total Pizzas sold:
select  pizza_name, sum(quantity) as Total_quantity  from pizza_sales
group by pizza_name 
order by Total_quantity limit 5;


-- 8. Top 5 Pizzas by Quantity
select pizza_name, SUM(quantity) as Total_Pizza_Sold
from pizza_sales
group by  pizza_name
order by Total_Pizza_Sold asc limit 5;


-- 9. Top 5 Pizzas by Total Orders
select  pizza_name, count(distinct order_id) AS Total_Orders
from pizza_sales
group by  pizza_name
order by  Total_Orders DESC limit 5;

-- 10. Bottom 5 Pizzas by Total Orders
select  pizza_name, count(distinct order_id) AS Total_Orders
from pizza_sales
group by  pizza_name
order by  Total_Orders limit 5;