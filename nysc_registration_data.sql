select id, fullname from nysc_registration
where age = 25 
;
select fullname, graduating_honors 
from nysc_registration
where graduating_honors = 'First Class'
;
select distinct preferred_state
from nysc_registration
;

select fullname
from nysc_registration
where fullname like 'A%' ; 

select gmail 
from nysc_registration
where gmail like '%tran%' ;

select telephone
from nysc_registration
where telephone like '080%' 
;

-- Total number of corps members from Kaduna State--
select count(*)
from nysc_registration
where origin_state = 'kaduna';

-- Total number of corps members in each state--
select (origin_state), count(*) as corps_count
from nysc_registration 
group by origin_state
order by count(*) desc;

-- Average age of the total number of corps members--
select avg(age)
from nysc_registration; 

-- Number of corps members by their course of study--
select (course_study), count(*) as Total_course_study
from nysc_registration
group by course_study
order by count(*) desc 
;

-- preferred state of corps members--
select (preferred_state), count(*) as corps_count 
from nysc_registration;

-- preferred state-- 
select * from nyscregistration 
group by preferred_state
order by count(*) desc; 

-- Corps members older than 25 with second class upper--
select * from nysc_registration 
where (age) > '25' 
and graduating_honors = 'second class lower';

-- Corps members from Enugu and prefer Lagos as their service state--
select * from nysc_registration
where (origin_state) = 'Enugu' 
and preferred_state = 'Lagos';

-- corp members between the ages of 22 and 27--
select * from nysc_registration 
where age between 22 and 27; 

-- corps members from Oyo state whose graduating honors is either third class or pass--
select fullname, graduating_honors, origin_state
from nysc_registration 
where origin_state = 'oyo' 
and (graduating_honors = 'third class' or graduating_honors = 'pass')
;

-- corps members whose course of study is either medicine or pharmacy, who are not more than 25 years old--
select fullname, age, course_study
from nysc_registration
where (age = 25 or age < 25)
and ( course_study = 'medicine' or course_study = 'pharmacy')
;

-- corps members from Kaduna state with second class lower and prefer to serve in south-south region--
select fullname, origin_state, preferred_state, graduating_honors
from nysc_registration
where (origin_state = 'kaduna')
and preferred_state in ('Akwa Ibom', 'Bayelsa', 'Cross River', 'Delta', 'Edo', 'Rivers')
and (graduating_honors = 'second class lower')
;



