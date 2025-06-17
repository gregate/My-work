-- Day 11 of SQL challenge with Funmi
-- all products sold via POS and total quantity sold 
select product_name, total,quantity,payment_amount, payment_mode
from full_sales_payment
where payment_mode = 'pos';

-- Customers who bought items worth more than 20,000
select
customer_id,name, email, city, 
total as transaction_total,
sale_id, sale_date
from full_sales_payment
where total > 20000
order by transaction_total desc;

-- Number of sales made by each staff--
select user_id, username,
count(*) as number_of_sales
from full_sales_payment
group by user_id, username
order by number_of_sales
desc
;

-- Day 12 challenge of sql with Funmi --
-- Customers from Lagos who made purchase above 15000 --
select customer_id, name, city, payment_amount
from full_sales_payment
where payment_amount > 15000 and city = 'Lagos'
;

-- Customers who have used more than one payment method --
select name, customer_id, email,
count(distinct payment_mode) as Payment_methods_used
from full_sales_payment
group by name, customer_id, email
having count(distinct payment_mode) > 1
order by Payment_methods_used desc;

-- top 5 customers who have spent the most overall--
select customer_id, name, email, payment_amount,quantity, 
sum(payment_amount) as Total_amount_spent
from full_sales_payment
group by customer_id, name, email, payment_amount, quantity
order by Total_amount_spent desc
limit 5;

-- Day 13 of SQL challenge with Funmi --
-- Top 10 best selling products based on total quantity sold --

select product_id, product_name,
sum(quantity) as total_quantity_sold
from full_sales_payment
group by product_id, product_name
order by total_quantity_sold desc
limit 10;

-- products that have never been sold using the transfer mode of payment --
select product_id, product_name, payment_mode
from full_sales_payment
where payment_mode not in ('transfer');

-- products with an average sales amount above 5,000 per transaction --
select product_id, product_name, avg(payment_amount) as Average_sales
from full_sales_payment
group by product_id, product_name
having Average_sales > 5000
order by Average_sales desc;

-- Day 14 of Sql challenge with Funmi: understanding customers purchasing pattern --
#1 The most used payment method 
select payment_mode,
count(payment_mode) as most_used_payment_method
from full_sales_payment
group by payment_mode
order by most_used_payment_method desc
limit 1;

#2 All transactions made on the weekends
select sale_id,
sale_date,
product_name,
quantity,
payment_mode
from full_sales_payment 
where dayofweek(sale_date)
in (1, 7)
order by sale_date;

#3 Average amount spent per payment mode
select
    payment_mode,
    avg(payment_amount) as average_amount_spent
from
	full_sales_payment
group by 
	payment_mode 
order by
    average_amount_spent desc ; 
    
    -- Day 15 of SQL challenge with Funmi --
    #1 show *the total sales amount per month*
    select
        year(sale_date) as Sales_year,
		monthname(sale_date) as Sales_month,
        sum(payment_amount) as Total_amount
    from 
        full_sales_payment
    group by 
        Sales_year, Sales_month
    order by 
		Sales_year, Sales_month desc;

#2 Find the day of the week with the highest sales
 select 
   dayname(sale_date) as Day_of_the_week,
   sum(total) as Total_sales
 from full_sales_payment
 where sale_date is not null
group by
    dayname(sale_date)
order by
	Total_sales desc;
    
#3 Find the *peak sales day*
 select dayname(sale_date) as day_of_week,
 sum(total) peak_sales
 from full_sales_payment
 group  by sale_date
 order by day_of_week desc
 limit 1;
 
 -- Day #16 of SQL challenge with Funmi --
 #1 Total number of sales made by each staff member
 select user_id,username,
 count(*) as Total_sales
 from full_sales_payment
 group by user_id, username
 order by Total_sales desc;
 
 #2. Top 3 staff members by total sales values
 select user_id, username,
 count(*) as TOTAL_SALES
 from full_sales_payment
 group by user_id, username
 order by TOTAL_SALES desc
 limit 3;
 
 #3. Staff members who have *handled transactions across all 4 payment modes*
select user_id, username,
count(distinct payment_mode) as payment_method
from full_sales_payment
group by user_id, username
having count(distinct payment_mode) = 4; 