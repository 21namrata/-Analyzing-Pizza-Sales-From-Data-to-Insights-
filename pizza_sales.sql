select * from pizza_sales;

#Problem Statement 
#KPI's Requirements
# 1- Total revenue, Average order value, Total Pizzas sold,total Orders, Average pizzas per order


#Total Revenue
select sum(total_price) as 'Total Revenue' from pizza_sales;

#Average order value
select sum(total_price)/count(distinct order_id) as 'AOV'
from pizza_sales;

#Total pizza sold 
select sum(quantity) as'Total pizzas sold' from pizza_sales;

#Total Orders
select count(distinct order_id) as ' Total Orders' from pizza_sales;

#Average Pizzas per order
select sum(quantity)/count(distinct order_id) as 'Average Pizza Per Order'
from pizza_sales;


# More questions 
#Daily trend of orders
select str_to_date(order_date,'%d-%m-%Y') as 'formatted_date',
dayname(str_to_date(order_date,'%d-%m-%Y')) as 'day_name' ,
count(distinct order_id) as 'count' 
from pizza_sales
group by formatted_date,day_name;

#Daily trend for total orders
select dayname(str_to_date(order_date,'%d-%m-%Y')) as 'day_name' ,
count(distinct order_id) as 'count' 
from pizza_sales
group by day_name;

#Hourly trend 
select hour(order_time),count(distinct order_id) from pizza_sales
group by hour(order_time)
order by  hour(order_time);

#Percentage of sales by pizza Category;
select pizza_category,sum(total_price) as 'Total_sales',
(sum(total_price)/(select sum(total_price) from pizza_sales))*100 as 'percentage_sales'
from pizza_sales
group by pizza_category;

#Percentage of sales by pizza Category for jan month
select pizza_category,sum(total_price) as 'Total_sales',
(sum(total_price)/(select sum(total_price) from pizza_sales where month(str_to_date(order_date,'%d-%m-%Y'))= 1))*100 as 'percentage_sales'
from pizza_sales
where month(str_to_date(order_date,'%d-%m-%Y'))= 1
group by pizza_category;

#Percentage of sales by pizza Size;
select pizza_size,sum(total_price) as 'Total_sales',
round((sum(total_price)/(select sum(total_price) from pizza_sales))*100,2) as 'percentage_sales'
from pizza_sales
group by pizza_size;



#Percentage of sales by pizza Size for first quarter;
select pizza_size,round(sum(total_price),2) as 'Total_sales',
round((sum(total_price)/(select sum(total_price) from pizza_sales where quarter(str_to_date(order_date,'%d-%m-%Y'))= 1))*100 ,2) as 'percentage_sales'
from pizza_sales
where  quarter(str_to_date(order_date,'%d-%m-%Y'))= 1
group by pizza_size
order by percentage_sales desc;

#Total Pizzas sold by pizza category
select pizza_category,sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_category;

#Top 5 best seller by total pizzas sold
select  pizza_name, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc limit 5;


#Bottom 5 best seller by total pizzas sold
select  pizza_name, sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc limit 5;

#Bottom 5 best seller by total pizzas sold for jan month
select  pizza_name, sum(quantity) as Total_pizzas_sold
from pizza_sales
where  month(str_to_date(order_date,'%d-%m-%Y'))= 1
group by pizza_name
order by sum(quantity) asc limit 5;