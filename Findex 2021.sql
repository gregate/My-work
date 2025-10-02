select economy, account_mob, regionwb, age, female, inc_q, educ
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
and age >18
and account_mob = 1
group by economy, account_mob, regionwb, age, female, inc_q, educ;

-- Total number of adults per country with mobile money 

SELECT economy, COUNT(*) AS adults_with_mobile_account
FROM staging_micro_world
WHERE regionwb LIKE 'Sub-Saharan Africa%'
  AND age > 18
  AND account_mob = 1
GROUP BY economy
ORDER BY adults_with_mobile_account DESC;

-- Total number of adults per country without mobile money 
SELECT economy, COUNT(*) AS adults_with_mobile_account
FROM staging_micro_world
WHERE regionwb LIKE 'Sub-Saharan Africa%'
  AND age > 18
  AND account_mob = 0
GROUP BY economy
ORDER BY adults_with_mobile_account DESC;

-- Percentage of adults with mobile money per country
SELECT economy AS Country,
       round(100 * AVG(account_mob), 2 )AS Percent_with_Mobile_Account
FROM staging_micro_world
WHERE regionwb LIKE 'Sub-Saharan Africa%'
  AND age >= 18
GROUP BY economy
ORDER BY Percent_with_Mobile_Account DESC;

-- Gender gap in mobile money adoption

select female as Gender, -- 1=male, 2=female
	economy as Country,
round(100 *  avg(account_mob), 2) as Percent_with_mobile_account
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
and age > 18
group by female, economy
order by Gender, Country;

-- Mobile money adoption by education level
select economy as Country,
	educ as Level_of_education, -- 1=primary or less,2=secondary, 3=tertiary
	round( 100* avg(account_mob), 2) as percentage_with_mobile_account
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
and age > 18
group by economy, educ
order by Country, Level_of_education desc;

-- Mobile money adoption by income quintile
select economy as Country,
	inc_q as Income_quintile,
round( 100*avg(account_mob),2) as Percentage_with_mobile_account
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
and age > 18
group by economy, inc_q
order by Country, Income_quintile;

-- Urban vs rural mobile money adoption
select economy as Country,
	urbanicity_f2f as Urban_city,
round(100*avg(account_mob), 2) as percentage_mobile_account
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
and age >18
group by economy, urbanicity_f2f
order by Country, Urban_city
;
-- Percentage of people who get their wages via mobile money
select economy as Country,
count(*) as adults_with_accounts_receiving_wages,
round(avg(receive_wages)*100, 2) as Percentage_receiving_wages
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
and age > 18
and account_mob = 1
group by economy
order by Percentage_receiving_wages desc;

-- Full breakdown between Country vs gender vs urbanicity
select economy as Country,
	female as Gender, -- where 2=male and 1=female
	urbanicity_f2f as Area_Type, -- where 2=urban and 1=rural
    ROUND(
        100 * SUM(anydigpayment = 1 AND account_mob = 1) 
        / NULLIF(SUM(account_mob = 1), 0), 
    2) AS Usage_rate_percent
from staging_micro_world
where regionwb like 'Sub_Saharan Africa%'
and account_mob = 1
and age >=18
group by economy, female, urbanicity_f2f
order by Country, Gender, Area_Type desc;

select merchantpay_dig, anydigpayment,year
from staging_micro_world;

select * from (select economy, --  economy is Country,
	female , -- male = 1 and female = 2,
    urbanicity_f2f, -- 1 = urban and 2 = rural
    count(*) as num_users,
rank() over(partition by female, urbanicity_f2f order by count(*) desc) as usage_rank
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
and age >= 18
and account_mob = 1
and anydigpayment = 1
group by economy, female, urbanicity_f2f) as ranked
where usage_rank <= 5
order by female, urbanicity_f2f, usage_rank;

-- Mobile money adoption by education level and income quintile
SELECT * FROM (SELECT 
    economy AS Country,
    CASE educ
        WHEN 1 THEN 'Primary or less'
        WHEN 2 THEN 'Secondary'
        WHEN 3 THEN 'Tertiary'
        WHEN 4 THEN 'Other/Unknown'
    END AS Level_of_education,
    CASE inc_q
        WHEN 1 THEN 'Poorest'
        WHEN 2 THEN 'Second'
        WHEN 3 THEN 'Middle'
        WHEN 4 THEN 'Fourth'
        WHEN 5 THEN 'Richest'
    END AS Income_quintile,
    ROUND(100 * AVG(account_mob), 2) AS Percentage_with_mobile_account,
RANK() OVER (
            PARTITION BY educ, inc_q
            ORDER BY AVG(account_mob) DESC
        ) AS adoption_rank
FROM staging_micro_world
WHERE regionwb LIKE 'Sub-Saharan Africa%'
  AND age > 18
GROUP BY economy, educ, inc_q) Ranked
ORDER BY Country, Level_of_education, Income_quintile;

SELECT 
    economy AS Country,
    ROUND(100 * AVG(account_mob), 2) AS pct_own_account,
    ROUND(100 * AVG(anydigpayment), 2) AS pct_use_account,
	    ROUND(
        100 * SUM(anydigpayment = 1 AND account_mob = 1) / NULLIF(SUM(account_mob = 1),0)
    ,2) AS usage_vs_ownership
FROM staging_micro_world
WHERE regionwb LIKE 'Sub-Saharan Africa%'
  AND age >= 18
GROUP BY economy
ORDER BY usage_vs_ownership DESC;

select account_mob, count(*)
from staging_micro_world
where regionwb like 'Sub-Saharan Africa%'
group by account_mob;

SHOW databases;