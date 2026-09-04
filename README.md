# Data Analyst Job Market Analysis (SQL)

## Introduction
This project explores the data analyst job market using SQL, focusing on remote Data Analyst roles. It answers practical career questions: which jobs pay the most, which skills those top-paying jobs require, which skills are most in demand, and which skills offer the best combination of demand and salary.

SQL queries used in this project: [/project_sql](/project_sql/)

## Background
Job seekers benefit from knowing not just *what* skills are in demand, but *which* skills are worth prioritising — i.e. skills that are both frequently requested and associated with higher salaries. This project uses real job posting data to answer that question with SQL rather than guesswork.

### Questions answered:
1. What are the top-paying Data Analyst jobs?
2. What skills are required for these top-paying jobs?
3. What are the most in-demand skills for Data Analysts?
4. Which skills are associated with the highest average salaries?
5. What are the most optimal skills to learn (high demand **and** high salary)?

## Tools I Used
- **PostgreSQL** — database management and query execution
- **SQL** — CTEs, JOINs, aggregate functions (COUNT, AVG), GROUP BY/HAVING, subqueries
- **Git & GitHub** — version control

## The Analysis

**1. Top-paying Data Analyst jobs** — filtered remote roles with a specified salary, ranked by `salary_year_avg` to find the top 10.

**2. Skills for top-paying jobs** — joined the top 10 roles above against `skills_job_dim`/`skills_dim` to see which skills those specific high-paying jobs required.

**3. Most in-demand skills** — grouped all Data Analyst postings by skill and counted frequency to find the top 5 most requested skills.

```sql
WITH top_demanded_skills AS (
    SELECT skills, COUNT(skills) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
    WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
    GROUP BY skills
    ORDER BY demand_count DESC
    LIMIT 5
)
SELECT * FROM top_demanded_skills
```

**4. Top-paying skills** — grouped by skill and calculated `AVG(salary_year_avg)` to find which individual skills command the highest average salary.

**5. Optimal skills** — combined demand count and average salary in two CTEs, joined them, and filtered to skills with `demand_count > 10` to surface skills that are both in demand and well-paid — avoiding skills that look high-paying only because of a small sample size.

## What I Learned
- Writing and combining **CTEs** to break complex questions into readable steps
- Using **INNER/LEFT JOIN** across fact and dimension tables to enrich job posting data with company and skill information
- Aggregating with **GROUP BY / HAVING** and filtering aggregated results (e.g. `demand_count > 10`) to avoid misleading small-sample results
- Rewriting a query for conciseness — comparing a two-CTE version against a single, more compact GROUP BY query for the same result

## Conclusions
Remote Data Analyst roles show a wide salary range at the top end, and the skills tied to the highest-paying postings are not always the same as the most *frequently requested* skills. Cross-referencing demand with average salary (query 5) is the most useful lens for deciding which skill to prioritise learning next — a skill that is both common **and** well-paid offers the best return on learning time.
