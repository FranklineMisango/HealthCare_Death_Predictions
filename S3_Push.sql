-- Query to save the final data to s3 bucket as a csv file
SELECT * FROM FINAL_ADS_DATA;

UNLOAD ('SELECT * FROM FINAL_ADS_DATA')
to 's3://accidentbucket/final_data'
IAM_ROLE 'arn:aws:iam::143176219551:role/redshift-role'
PARALLEL OFF
CSV
HEADER
ALLOWOVERWRITE;


----======================================================

