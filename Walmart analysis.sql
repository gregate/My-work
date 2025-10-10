select * from customers
limit 30;
Alter table sales add column department_id int;
alter table products add column department_id int;


-- total sales volume and revenue by day, week, and month 
select s.sale_date,
sum(s.quantity) as total_volume,
sum(s.quantity*p.price) as total_revenue
from sales s
join products p 
on s.product_id = p.product_id 
group by sale_date
order by sale_date;

-- Total revenue
select 
	sum(s.quantity*p.price) as Total_revenue
from sales s
join products p on s.product_id = p.product_id;


-- Product with highest revenue
select p.product_name,
p.product_id,
sum(s.quantity*p.price) as total_revenue
from products p
join sales s on p.product_id = s.product_id
group by p.product_name, p.product_id
order by total_revenue desc
limit 1;

-- highest quantity sold
select p.product_name,
	p.product_id,
    sum(s.quantity) as total_quantity
from products p
join sales s on p.product_id = s.product_id
group by p.product_name, p.product_id
order by total_quantity desc
limit 5 ;

-- Full performance insight
select
	p.product_name,
    p.product_id,
sum(s.quantity*p.price) as total_revenue,
sum(s.quantity) as total_quantity
from products p 
join sales s on p.product_id = s.product_id
group by p.product_name, p.product_id
order by total_revenue desc
limit 10;

-- best performing department by revenue
select d.department_name,
	sum(s.quantity * p.price) as total_revenue
	from departments d
join
	 products p on d.department_id = p.department_id
join sales s
	on p.product_id = s.product_id
group by 
	d.department_name
order by total_revenue desc;

select * from departments d
left join sales s on d.department_id = s.department_id;

select 
	year(sale_date) as year,
	month(sale_date) as month,
count(distinct customer_id) as active_customers
from sales
where sale_date <= current_date()
group by year(sale_date), month(sale_date)
order by year,month;

/* I noticed future dates in the sale_date column and I will have to remove them because I am doing
this analysis on th 08-10-2025 so I'll be removing the extra 2 months on the table */
select * from sales
where sale_date > current_date;

select method_of_payment,
count(*) as total_transactions
from sales
group by method_of_payment
order by total_transactions desc;

select 
	state,
count(quantity) as total_sales
from
	sales
group by state
order by total_sales desc;

select 
	town,
count(quantity) as total_sales
from
	sales
group by town
order by total_sales desc;

select e.name,
count(s.quantity) as total_sales_contribution
from employees e
join sales s on e.employee_id = s.employee_id
group by e.name
order by total_sales_contribution desc;

select e.name, d.department_name,
count(s.quantity) as total_sales_contribution
from employees e
join sales s on e.employee_id = s.employee_id
join departments d on e.department_id = d.department_id
group by d.department_name
order by total_sales_contribution desc;

select d.department_name,
sum(s.quantity) as total_quantity,
round(sum(p.price), 0) as average_price
from sales s 
join products p on s.product_id = p.product_id
join departments d on p.department_id = d.department_id
group by department_name
order by total_quantity desc;

select p. product_name,
sum(s.quantity) as Total_quantity,
round(avg(p. price), 2) as Average_price,
round(sum(s.quantity * p.price),0) as Total_revenue
from sales s
join products p on s.product_id = p.product_id
group by p.product_name
order by Total_quantity desc;

/* I also chose to use conditional formatting here to sort them from high to low */
with products_stats as 
(
select p.product_id,
p.product_name,
sum(s.quantity) as total_quantity_sold,
avg(p.price) as average_price,
sum(s.quantity* p.price) as total_revenue
from sales s
join products p on s.product_id = p.product_id
group by p.product_id, p.product_name),
global as (
select avg(total_quantity_sold) as avg_quantity,
	avg(average_price)  as avg_price
from products_stats
)
select 
	ps.*,
case
	when ps.total_quantity_sold > g.avg_quantity
		and ps.average_price < g.avg_price then 'Fast moving'
	when ps.total_quantity_sold < g.avg_quantity
		and ps.average_price > g.avg_price then 'High value'
	else 'Other'
end as Product_type
from products_stats ps
cross join global g
order by ps.total_quantity_sold desc;