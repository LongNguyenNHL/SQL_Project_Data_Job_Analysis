/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job postings tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/
WITH job_over_salary AS (
    SELECT 
        *
    FROM january_jobs
    WHERE salary_year_avg > 70000

    UNION

    SELECT 
        *
    FROM february_jobs
    WHERE salary_year_avg > 70000

    UNION

    SELECT 
        *
    FROM march_jobs
    WHERE salary_year_avg > 70000
)

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date:: DATE,
    salary_year_avg
FROM job_over_salary
WHERE job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC

