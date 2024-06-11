/*
Answer: What are the most optimal skills to learn (aka it;s in high demand and a high-paaing skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/
WITH skills_demand AS (
    SELECT 
        skills,
        COUNT(skills) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
    WHERE job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
    GROUP BY
        skills
), average_salary AS (
    SELECT 
        skills,
        -- Dùng ROUND để muốn kết quả trả lại bao nhiếu phần thập phân sau dấu phẩy
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills
)

SELECT 
    skills_demand.skills,
    demand_count,
    average_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skills = average_salary.skills
WHERE
    demand_count > 10
ORDER BY
    -- demand_count DESC,
    average_salary DESC
LIMIT 25

-- Rewriting this same query more concisely
SELECT
    skills.skills,
    COUNT(skills) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND 
    job_work_from_home = TRUE
GROUP BY
    skills.skills
HAVING 
    COUNT(skills) > 10
ORDER BY
    -- demand_count DESC,
    average_salary DESC
LIMIT 25


    
