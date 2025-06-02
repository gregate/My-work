-- group by

select *
from employee_demographics;


select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;


select occupation, salary
from employee_salary
group by occupation, salary;


-- order by 
select  *
from employee_demographics
order by first_name;

select  *
from employee_demographics
order by gender, age;