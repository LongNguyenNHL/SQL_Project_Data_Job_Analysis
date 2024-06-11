/*
Question: What skills are required for the top-paying data analyst jobs
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
=> helping job seekers understand which skills to develop the align with top salaries.*/
WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name 
    FROM
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id

    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim AS skills_to_job ON top_paying_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
ORDER BY
    salary_year_avg DESC