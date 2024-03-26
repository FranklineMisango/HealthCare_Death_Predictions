-- Accident table
Select * from dev.customschema.accident limit 100;

Select count(*) as cnt, count(distinct case_number) as uq_cases from dev.customschema.accident; -- cnt=142236 | uq_cases=47424

Select case_number, count(*)
from dev.customschema.accident
group by 1
having count(*)>1;

SELECT * FROM dev.customschema.accident WHERE CASE_NUMBER = 'XX42159XXXX'; -- multiple place_of_incident

SELECT PLACE_OF_INCIDENT, COUNT(*) AS CNT, COUNT(DISTINCT CASE_NUMBER) AS UQ_CASES
FROM dev.customschema.accident
GROUP BY 1; -- lot of mistakes in the place_of_incident column and because of that a single case_number have multiple entries in the dataset

SELECT FIRE, COUNT(*) AS CNT, COUNT(DISTINCT CASE_NUMBER) AS UQ_CASES
FROM dev.customschema.accident
GROUP BY 1; -- 47406 uq_cases have 0 as value

--- Columns of interest ==> PLACE_OF_INCIDENT, FIRE

---==========================================================================================================================================================================

-- Hospital table 
Select * from dev.customschema.hospital limit 100;

Select count(*) as cnt, count(distinct case_number) as uq_cases from dev.customschema.hospital; -- cnt=47406 | uq_cases=47406

-- This table has the target variable. So use this as a base table and get the detials of the case_number from other tables such as accident and personal.

---==========================================================================================================================================================================

-- Personal table
Select * from dev.customschema.personal limit 100;

Select count(*) as cnt, count(distinct case_number) as uq_cases from dev.customschema.personal; -- cnt=47406 | uq_cases=47406

--- This table has all the personal details such as age, sex, no_of_family_members, etc.

---==========================================================================================================================================================================