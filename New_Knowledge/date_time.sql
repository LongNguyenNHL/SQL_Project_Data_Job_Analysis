/*
::DATE
    - Format:
        SELECT
            timestamp_column :: DATE AS date_column
        FROM
            table_name;
    - Notes: 
        + :: - used for casting, which means converting a value from one data type to another
        => You can use it to convert a host of different data types
            SELECT '2023-02-19' :: DATE, '123' :: INTEGER, 'true' :: BOOLEAN, '3.14' :: REAL;         
*/
-- DATE and Time Stamp are similar.
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date :: DATE AS date
FROM 
    job_postings_fact
LIMIT 5;

SELECT 
    '2023-02-19' :: DATE, 
    '123' :: INTEGER, 
    'true' :: BOOLEAN, 
    '3.14' :: REAL;

/*
* AT TIME ZONE 
    - Timestaps with timezone:
     + Stored as UTC, displayed per query's or system's time zone
     + AT TIME ZONE converts UTC to the specified time zone correctly
     + Format: 
        SELECT
            column_name AT TIME ZONE 'EST'
        FROM
            table_name;
*/
SELECT
    job_posted_date AT TIME ZONE 'EST' AS date_time 
FROM job_postings_fact
LIMIT 5;

/*
* AT TIME ZONE 
    - Timestaps without timezone (our situation):
     + Treated as local time in PostgreSQL
     + Using AT TIME ZONE assumes the machine's time zone for conversion; specify it, or the default is UTC
     + Format: 
        SELECT
            column_name AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
        FROM
            table_name;
*/

SELECT
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time 
FROM job_postings_fact
LIMIT 5;

/*
EXTRACT
    - Notes: EXTRACT gets field (e.g., year, month, day) from a date/time value
    - Format:
        SELECT
            EXTRACT (MONTH FROM column_name) AS column_month
        FROM 
            table_name
*/

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
    EXTRACT (MONTH FROM job_posted_date) AS date_month,
    EXTRACT (YEAR FROM job_posted_date) AS date_year,
    EXTRACT (DAY FROM job_posted_date) AS date
FROM 
    job_postings_fact
LIMIT 5;