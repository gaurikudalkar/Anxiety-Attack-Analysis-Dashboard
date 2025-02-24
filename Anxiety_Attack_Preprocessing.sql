CREATE DATABASE AnxietyAnalysis;
use AnxietyAnalysis;

-- Checking available tables:   
show tables;

--  View table schema:
desc anxiety_attack_dataset;

-- View sample data:
SELECT * FROM anxiety_attack_dataset;

-- Check the number of rows: 
SELECT COUNT(*) FROM anxiety_attack_dataset;

-- List of columns from table:
SHOW COLUMNS FROM anxiety_attack_dataset; 

-- Check missing values for each column

SELECT SUM(CASE WHEN ID IS NULL THEN 1 ELSE 0 END) AS ID_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN Occupation IS NULL THEN 1 ELSE 0 END) AS Occupation_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Sleep Hours` IS NULL THEN 1 ELSE 0 END) AS Sleep_Hours_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Physical Activity (hrs/week)` IS NULL THEN 1 ELSE 0 END) AS Physical_Activity_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Caffeine Intake (mg/day)` IS NULL THEN 1 ELSE 0 END) AS Caffeine_Intake_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Alcohol Consumption (drinks/week)` IS NULL THEN 1 ELSE 0 END) AS Alcohol_Consumption_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN Smoking IS NULL THEN 1 ELSE 0 END) AS Smoking_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Family History of Anxiety` IS NULL THEN 1 ELSE 0 END) AS Family_History_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Stress Level (1-10)` IS NULL THEN 1 ELSE 0 END) AS Stress_Level_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Heart Rate (bpm during attack)` IS NULL THEN 1 ELSE 0 END) AS Heart_Rate_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Breathing Rate (breaths/min)` IS NULL THEN 1 ELSE 0 END) AS Breathing_Rate_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Sweating Level (1-5)` IS NULL THEN 1 ELSE 0 END) AS Sweating_Level_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN Dizziness IS NULL THEN 1 ELSE 0 END) AS Dizziness_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN Medication IS NULL THEN 1 ELSE 0 END) AS Medication_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Therapy Sessions (per month)` IS NULL THEN 1 ELSE 0 END) AS Therapy_Sessions_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Recent Major Life Event` IS NULL THEN 1 ELSE 0 END) AS Life_Event_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Diet Quality (1-10)` IS NULL THEN 1 ELSE 0 END) AS Diet_Quality_Missing FROM anxiety_attack_dataset;

SELECT SUM(CASE WHEN `Severity of Anxiety Attack (1-10)` IS NULL THEN 1 ELSE 0 END) AS Severity_Missing FROM anxiety_attack_dataset;

 -- Summary Statistics
-- 1. Minimum, Maximum, and Average Sleep Hours
SELECT 
    MIN(`Sleep Hours`) AS Min_Sleep_Hours,
    MAX(`Sleep Hours`) AS Max_Sleep_Hours,
    AVG(`Sleep Hours`) AS Avg_Sleep_Hours
FROM anxiety_attack_dataset;


-- 2. Distribution of Stress Levels
-- How many records fall into each stress level?
SELECT `Stress Level (1-10)`, COUNT(*) AS Count
FROM anxiety_attack_dataset
GROUP BY `Stress Level (1-10)`
ORDER BY Count;

-- Average Anxiety Severity by Stress Level (1-10)
SELECT `Stress Level (1-10)`, 
       AVG(`Severity of Anxiety Attack (1-10)`) AS Avg_Anxiety_Severity
FROM anxiety_attack_dataset
GROUP BY `Stress Level (1-10)`
ORDER BY `Stress Level (1-10)`;

-- Finding Most Common Stress Level (1-10): 
SELECT `Stress Level (1-10)`, COUNT(*) AS Count
FROM anxiety_attack_dataset
GROUP BY `Stress Level (1-10)`
ORDER BY Count DESC
LIMIT 1;


-- 3. Most common occupations among patients
SELECT Occupation, COUNT(*) AS Count
FROM anxiety_attack_dataset
GROUP BY Occupation
ORDER BY Count DESC
LIMIT 5;

-- This query will give you insight into which occupations tend to have higher or lower stress levels.
SELECT Occupation, 
       AVG(`Stress Level (1-10)`) AS Avg_Stress_Level
FROM anxiety_attack_dataset
GROUP BY Occupation
ORDER BY Avg_Stress_Level DESC;


-- occupation with the highest average stress level in the dataset.
SELECT Occupation, 
       AVG(`Stress Level (1-10)`) AS Avg_Stress_Level
FROM anxiety_attack_dataset
GROUP BY Occupation
ORDER BY Avg_Stress_Level DESC
limit 1;


-- 4. Average Heart Rate and Breathing Rate During Anxiety Attack

-- calculates the average heart rate and average breathing rate during anxiety attacks 
SELECT 
    AVG(`Heart Rate (bpm during attack)`) AS Avg_Heart_Rate
FROM anxiety_attack_dataset;

SELECT 
    AVG(`Breathing Rate (breaths/min)`) AS Avg_Breathing_Rate
FROM anxiety_attack_dataset;


-- 5. Average Sweating Level by Stress Level: 
SELECT `Stress Level (1-10)`,
       AVG(`Sweating Level (1-5)`) AS Avg_Sweating_Level
FROM anxiety_attack_dataset
GROUP BY `Stress Level (1-10)`
ORDER BY `Stress Level (1-10)`;


-- 6. Count of Dizziness Incidents by Stress Level:
SELECT `Stress Level (1-10)`,
       COUNT(CASE WHEN Dizziness = 'Yes' THEN 1 END) AS Dizziness_Count
FROM anxiety_attack_dataset
GROUP BY `Stress Level (1-10)`
ORDER BY `Stress Level (1-10)`;


-- Advanced Analysis

-- Top 5 Age Groups with Highest Stress Levels:

SELECT Age, AVG(`Stress Level (1-10)`) AS Avg_Stress
FROM anxiety_attack_dataset
GROUP BY Age
ORDER BY Avg_Stress DESC
LIMIT 5;


-- Relationship between Sleep Hours and Stress Levels:


SELECT `Sleep Hours`, AVG(`Stress Level (1-10)`) AS Avg_Stress
FROM anxiety_attack_dataset
GROUP BY `Sleep Hours`
ORDER BY `Sleep Hours`;


-- Does Smoking Affect Anxiety Severity?:
-- This query analyzes if smoking affects the average severity of anxiety attacks.

SELECT Smoking, AVG(`Severity of Anxiety Attack (1-10)`) AS Avg_Severity
FROM anxiety_attack_dataset
GROUP BY Smoking;


-- Impact of Therapy Sessions on Anxiety Severity:
-- This query examines the impact of the number of therapy sessions on the average severity of anxiety attacks.

SELECT 
    `Therapy Sessions (per month)`,
    AVG(`Severity of Anxiety Attack (1-10)`) AS Avg_Severity
FROM anxiety_attack_dataset
GROUP BY `Therapy Sessions (per month)`
ORDER BY `Therapy Sessions (per month)`;


-- Average Diet Quality and Its Effect on Anxiety Severity:
-- This query analyzes the effect of average diet quality on the severity of anxiety attacks.
SELECT 
    `Diet Quality (1-10)`,
    AVG(`Severity of Anxiety Attack (1-10)`) AS Avg_Severity
FROM anxiety_attack_dataset
GROUP BY `Diet Quality (1-10)`
ORDER BY `Diet Quality (1-10)` DESC;

-- Trend Analysis
-- How Does Alcohol Consumption Affect Anxiety Severity?:

SELECT 
    `Alcohol Consumption (drinks/week)`,
    AVG(`Severity of Anxiety Attack (1-10)`) AS Avg_Severity
FROM anxiety_attack_dataset
GROUP BY `Alcohol Consumption (drinks/week)`
ORDER BY `Alcohol Consumption (drinks/week)`;


-- Correlation Between Caffeine Intake and Stress Levels:
-- This query analyzes the correlation between caffeine intake and average stress levels.
SELECT 
    `Caffeine Intake (mg/day)`,
    AVG(`Stress Level (1-10)`) AS Avg_Stress
FROM anxiety_attack_dataset
GROUP BY `Caffeine Intake (mg/day)`
ORDER BY `Caffeine Intake (mg/day)`;


-- Impact of Physical Activity on Anxiety:
-- This query examines the impact of physical activity on the average severity of anxiety attacks.
SELECT 
    `Physical Activity (hrs/week)`,
    AVG(`Severity of Anxiety Attack (1-10)`) AS Avg_Severity
FROM anxiety_attack_dataset
GROUP BY `Physical Activity (hrs/week)`
ORDER BY `Physical Activity (hrs/week)` DESC;


-- Percentage of People Using Medication:
-- This query calculates the percentage of people using medication.
SELECT 
    (SUM(CASE WHEN Medication = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Medication_Percentage
FROM anxiety_attack_dataset;


-- key statistics (average, minimum, maximum, and standard deviation) for stress levels in the dataset.
SELECT 
    AVG(`Stress Level (1-10)`) AS Avg_Stress_Level,
    MIN(`Stress Level (1-10)`) AS Min_Stress_Level,
    MAX(`Stress Level (1-10)`) AS Max_Stress_Level,
    STDDEV(`Stress Level (1-10)`) AS Stddev_Stress_Level
FROM anxiety_attack_dataset;

