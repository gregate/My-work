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

-- Youngest corps member with their full name and age --
select fullname, age 
from nysc_registration 
where age = (select min (age) from nysc_registration)
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

-- Youngest corps member with their full name and age --
select fullname, age
from nysc_registration
where age = ( select min(age) from nysc_registration)
;

-- oldest corps member with their full name and age from the university of Lagos --
select fullname, age, institution
from nysc_registration 
where age = ( select max(age) from nysc_registration) 
and institution = 'university of lagos'
;

-- total corps member from each institution state in descending order --
select institution_state, count(*) as total_corps_members
from nysc_registration
group by institution_state
order by total_corps_members desc
;

-- List all unique institution names --
select distinct institution
from nysc_registration;

-- Total number of corps members in each prefered state, display only states with more than 200 corps members --
Select preferred_state, count(*) as total_number
from nysc_registration
group by preferred_state
having count(*) > 200
order by total_number desc ;

-- Top 5 youngest corps members --
select fullname,age
from nysc_registration
where age = (select min(age) from nysc_registration)
limit 5
;
-- show all unique courses of study--
select distinct course_study
from nysc_registration;

-- Day #9 of 30 days challenge with Funmi --
-- Find all corps members whose email address contains gmail --
select * from nysc_registration
where gmail like '%gmail%';

select  *
from nysc_registration
where origin_state in ('Lagos', 'Enugu', 'Kano');

-- List corps members between the ages of 23 and 26 --
select id, fullname, age 
from nysc_registration
where age between 23 and 26;

-- Find corps members whose full name begin with A'--
select id, fullname 
from nysc_registration
where fullname like 'A%';

-- Show corps members whose preferred state is either Abuja, Rivers, Delta, or Edo--
Select fullname, preferred_state
from nysc_registration
where preferred_state in ('Abuja', 'Rivers', 'Delta','Edo');
 
 -- Day 10 of 30 days challenge--
 -- Corps members whose age is outside the normal youth range --
 select id, fullname, age
 from nysc_registration
 where age <18 or age > 35;
 
 -- corps members whose preferred state is different from their origin state--
 select id, fullname, origin_state, preferred_state
 from nysc_registration
 where origin_state != preferred_state;
 
 -- Corps members whose graduating honors is either first class or pass and are below the age of 25 --
 select id, fullname, age, graduating_honors
 from nysc_registration
 where graduating_honors = 'firstclass' or graduating_honors = 'pass'
 and age < 25;
 
 -- corps members whose gmail or phone number is missing --
 select id, fullname, gmail, telephone
from nysc_registration
where gmail is null or telephone is null 