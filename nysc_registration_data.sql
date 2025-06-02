select id, fullname from nysc_registration
where age = 25 
;
select fullname, graduating_honors 
from nysc_registration
where graduating_honors = 'First Class'
;
select distinct preferred_state
from nysc_registration
