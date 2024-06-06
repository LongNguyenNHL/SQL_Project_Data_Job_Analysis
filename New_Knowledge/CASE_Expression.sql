/*
CASE Expression
    - Notes: A CASE expression in SQL is a way to apply conditional logic within your SQL queries.
        + CASE: begins the expression
        + WHEN: specifies the condition(s) to look at
        + THEN: what to do when the condition TRUE
        + ELSE: (optional) - provides output if none of the WHEN conditions are met
        + END: concludes the CASE expression
    - Format: 
        SELECT
            CASE
                WHEN column_name = 'Value1' THEN 'Description for Value1'
                WHEN column_name = 'Value2' THEN 'Description for Value2'
                ELSE 'Other'
            END AS column_description
        FROM
            table_name;
*/
SELECT
    COUNT(job_id) AS number_posted_job,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;
