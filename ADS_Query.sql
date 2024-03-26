-- Using Hosptial table as primary base table joining all the other tables to create the final ADS

SELECT COUNT(*), COUNT(DISTINCT A.CASE_NUMBER), COUNT(DISTINCT B.CASE_NUMBER), COUNT(DISTINCT C.CASE_NUMBER)
FROM (SELECT DISTINCT * FROM dev.customschema.hospital) A

LEFT JOIN 
(SELECT DISTINCT * FROM dev.customschema.personal) B 
ON A.CASE_NUMBER = B.CASE_NUMBER

LEFT JOIN 
(SELECT DISTINCT * FROM dev.customschema.accident) C 
ON A.CASE_NUMBER = C.CASE_NUMBER;

-- Duplicates from accident table resulted in duplicate rows in the resultant query
----=================================================================================================================================================

-- Accident table
Select * from dev.customschema.accident limit 100;

SELECT DISTINCT PLACE_OF_INCIDENT
FROM dev.customschema.accident;

SELECT DISTINCT PLACE_OF_INCIDENT
FROM dev.customschema.accident
WHERE PLACE_OF_INCIDENT !~ '^[0-9]+$';

Select case_number, count(*)
from dev.customschema.accident
WHERE PLACE_OF_INCIDENT !~ '^[0-9]+$'
group by 1
having count(*)=1;

SELECT * FROM dev.customschema.accident WHERE PLACE_OF_INCIDENT !~ '^[0-9]+$' AND CASE_NUMBER = 'XX42159XXXX';

----=================================================================================================================================================

-- Using Hosptial table as primary base table joining all the other tables to create the final ADS

SELECT * --COUNT(*), COUNT(DISTINCT A.CASE_NUMBER), COUNT(DISTINCT B.CASE_NUMBER), COUNT(DISTINCT C.CASE_NUMBER)
FROM (SELECT DISTINCT * FROM dev.customschema.hospital) A

LEFT JOIN 
(SELECT DISTINCT * FROM dev.customschema.personal) B 
ON A.CASE_NUMBER = B.CASE_NUMBER

LEFT JOIN 
(SELECT DISTINCT * FROM dev.customschema.accident WHERE PLACE_OF_INCIDENT !~ '^[0-9]+$') C 
ON A.CASE_NUMBER = C.CASE_NUMBER;

-- After applying the filter on accident table resolves the duplicates issue and the final data is ready for our EDA and Model Building

--- Creating the final table

CREATE TABLE FINAL_ADS_DATA AS 
  SELECT A.CASE_NUMBER, DATE, AGE_YEARS, AGE_MONTHS,
  		 SEX, INSURANCE_GRP, NO_FAM_MEMBER, COUNTRY_OF_ORIGIN,
         TOTAL_VISIT_COUNT, PLACE_OF_DEATH, DIAGNOSIS_CODE_1,
         DIAGNOSIS_CODE_2, DIAGNOSIS_CODE_3, P1, P2, P3, ALCOHOL, DRUG,
         PLACE_OF_INCIDENT, FIRE, REPORTED_REASON_OF_DEATH
  FROM (SELECT DISTINCT * FROM dev.customschema.hospital) A

  LEFT JOIN 
  (SELECT DISTINCT * FROM dev.customschema.personal) B 
  ON A.CASE_NUMBER = B.CASE_NUMBER

  LEFT JOIN 
  (SELECT DISTINCT * FROM dev.customschema.accident WHERE PLACE_OF_INCIDENT !~ '^[0-9]+$') C 
  ON A.CASE_NUMBER = C.CASE_NUMBER;
  

SELECT * FROM FINAL_ADS_DATA LIMIT 100;