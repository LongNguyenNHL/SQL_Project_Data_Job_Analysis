/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/


-- Chưa đúng vì không show được Skill_id
SELECT 
        skills AS skills_name,
        COUNT(job_work_from_home) AS skill_count
FROM 
        skills_dim AS skills
LEFT JOIN skills_job_dim AS skills_to_job
    ON skills.skill_id = skills_to_job.skill_id
INNER JOIN job_postings_fact AS job_postings
    ON skills_to_job.job_id = job_postings.job_id
WHERE 
        job_postings.job_work_from_home = TRUE
GROUP BY 
        skills_name
ORDER BY
        skill_count DESC
LIMIT 5;


-- Exact answer => Dùng CTE để show được nhiều cột tại bảng cuối, thay vì GROUP BY như đáp án bên trên k show được cột.
WITH job_remote AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings
        ON skills_to_job.job_id = job_postings.job_id
    WHERE
        job_postings.job_work_from_home = True AND 
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM
    job_remote
INNER JOIN skills_dim AS skills
    ON job_remote.skill_id = skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5