
SELECT*
FROM studentperformancefactors;


ALTER TABLE studentperformancefactors
CHANGE COLUMN `ï»¿Hours_Studied` Hours_Studied INT;

-- Average Score by Hours Studied

SELECT 
	hours_studied,
    COUNT(*) AS students,
    ROUND(AVG(Exam_Score)) avg_exam_score
FROM studentperformancefactors
GROUP BY Hours_Studied
ORDER BY Hours_Studied;

-- Attendence Impact

SELECT
	CASE
		WHEN Attendance >= 90 THEN '90-100%'
		WHEN Attendance >= 75 THEN '75-89%'
		WHEN Attendance >= 60 THEN '60-74%'
        ELSE 'Below 60%'
	END AS attendance_band,
    COUNT(*) AS students,
    ROUND(AVG(Exam_score),2) AS avg_score
    FROM studentperformancefactors
    GROUP BY attendance_band
    ORDER BY avg_score DESC;

-- Score Improvement

SELECT 
	ROUND(AVG(Change_in_Score),2) AS avg_improvement,
    SUM(CASE WHEN Change_in_score > 1 THEN 1 ELSE 0 END) AS students_improved,
    COUNT(*) AS total_students,
    ROUND(100 * SUM(CASE WHEN Change_in_Score > 1 THEN 1 ELSE 0 END) / COUNT(*),2) AS pct_improved    
FROM studentperformancefactors;

-- Does Tutoring Help?

SELECT
	Tutoring_Sessions,
    COUNT(*) as students,
    ROUND(AVG(Exam_score),2) as avg_exam_score,
    ROUND(AVG(Change_in_Score),2) as avg_improvement
FROM studentperformancefactors
GROUP BY Tutoring_Sessions
ORDER BY Tutoring_Sessions ASC;

-- Motivation vs Performance
SELECT
	Motivation_Level,
    COUNT(*) as students,
	ROUND(AVG(Exam_Score),2) AS avg_score,
	ROUND(AVG(Change_in_score),2) AS avg_improvement
FROM studentperformancefactors
GROUP BY Motivation_Level;

-- Student Efficiency

SELECT
	Hours_Studied,
    Exam_Score,
    ROUND(Exam_score/hours_studied,2) AS score_per_hour_of_study
    FROM studentperformancefactors
    WHERE Hours_Studied > 0
    ORDER BY score_per_hour_of_study DESC
    LIMIT 20;
    
    -- At Risk Students
    
    SELECT 
    hours_studied,
    attendance,
    exam_Score
    FROM studentperformancefactors
    WHERE Exam_Score <60
    ORDER BY Exam_Score;
