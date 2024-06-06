/*
Subqueries and CTEs
Subqueries and Common Table Expressions (CTEs): Used for organizing and simplifying complex queries
    + Helps break down the query into smaller, more manageable parts
    + When to use one over the other?
         - Subqueries are for simpler queries
         - CTEs are for more compler queries  
*/

-- Subqueries (Temporary Table) (Example below)
SELECT *
FROM ( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here

/*
Subqueries
    * Notes:
        - Subquery - query within another query
        - It can be used in several places in the main query
            + Such as the SELECT, FROM, WHERE, or HAVING CLASUES
        - It's executed first, and the results are passed to the outer query
            + It is used when you want to perform a calculation before the main query can complete its calculation
*/
SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY company_id
)

/* Common Table Expressions (CTEs): define a temporary result set that you can reference
    - Notes:
        + Can reference within a SELECT, INSERT, UPDATE, or DELETE statement
        + Exists only during the execution of a query
        + It's a defined query that can be referenced in the main query or other CTEs
        + Defiend with WITH - used to define CTE at the beginning of a query
*/

-- EX1:
WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) -- CTE definition ends here
SELECT *
FROM january_jobs;

-- Ex2:
WITH company_job_count AS (
    SELECT
            company_id,
            COUNT(*) AS total_jobs
    FROM
            job_postings_fact
    GROUP BY
            company_id
)

SELECT 
        company_dim.company_id,
        company_dim.name AS company_name,
        total_jobs
FROM company_dim
LEFT JOIN company_job_count
    ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC;




