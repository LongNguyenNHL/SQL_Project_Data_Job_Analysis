/*
UNION Operators: Combine result sets of two or more SELECT statements into a single result set.
    - UNION: Remove duplicate rows => All rows are unique
    - UNION ALL: Includes all duplicate rows
    !!! Notes: Each SELECT statement within the UNION must have the same number of columns in the results sets with similar data types 
    
    - Formats:
        SELECT column_name
        FROM table_one

        UNION -- combine the two tables

        SELECT column_name
        FROM table_two;
*/
-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION 

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION -- combine another table

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs
