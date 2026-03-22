-- =========================================================
-- Bellabeat Smart Device Usage Analysis
-- SQL Analysis Queries
-- Author: Vinuthna Modugu
-- =========================================================

-- This file contains SQL queries used for:
-- 1. Data exploration
-- 2. User behavior analysis
-- 3. Activity segmentation
-- 4. Weekly trend analysis


-- =========================================================
-- DATABASE SETUP
-- =========================================================

-- Create and use database
CREATE DATABASE bellabeat_analysis;
USE bellabeat_analysis;

-- =========================================================
-- DATA OVERVIEW
-- =========================================================

-- Total number of records in dataset
SELECT COUNT(*) 
FROM daily_activity;

-- List available tables
SHOW TABLES;

-- Preview dataset
SELECT * 
FROM daily_activity;

-- Count unique users
SELECT COUNT(DISTINCT Id) AS unique_users
FROM daily_activity;


-- =========================================================
-- USER ACTIVITY ANALYSIS
-- =========================================================

-- Number of recorded days per user
SELECT 
    Id,
    COUNT(*) AS recorded_days
FROM daily_activity
GROUP BY Id
ORDER BY recorded_days DESC;

-- Average steps per user
SELECT 
    Id,
    AVG(TotalSteps) AS avg_steps
FROM daily_activity
GROUP BY Id
ORDER BY avg_steps DESC;


-- =========================================================
-- USER SEGMENTATION BASED ON ACTIVITY
-- =========================================================

-- Categorize users based on average steps
SELECT 
    Id,
    AVG(TotalSteps) AS avg_steps,
    
    CASE
        WHEN AVG(TotalSteps) < 5000 THEN 'Sedentary User'
        WHEN AVG(TotalSteps) < 10000 THEN 'Moderately Active User'
        ELSE 'Highly Active User'
    END AS user_segment
    
FROM daily_activity
GROUP BY Id
ORDER BY avg_steps DESC;


-- Count users in each segment
SELECT 
    user_segment,
    COUNT(*) AS user_count
FROM
(
    SELECT 
        Id,
        CASE
            WHEN AVG(TotalSteps) < 5000 THEN 'Sedentary User'
            WHEN AVG(TotalSteps) < 10000 THEN 'Moderately Active User'
            ELSE 'Highly Active User'
        END AS user_segment
    FROM daily_activity
    GROUP BY Id
) AS segment_table
GROUP BY user_segment;


-- =========================================================
-- CALORIES ANALYSIS BY USER SEGMENT
-- =========================================================

-- Average calories burned by each user segment
SELECT 
    user_segment,
    AVG(avg_calories) AS avg_calories
FROM
(
    SELECT 
        Id,
        AVG(Calories) AS avg_calories,
        CASE
            WHEN AVG(TotalSteps) < 5000 THEN 'Sedentary User'
            WHEN AVG(TotalSteps) < 10000 THEN 'Moderately Active User'
            ELSE 'Highly Active User'
        END AS user_segment
    FROM daily_activity
    GROUP BY Id
) AS user_summary
GROUP BY user_segment;


-- =========================================================
-- WEEKLY ACTIVITY ANALYSIS
-- =========================================================

-- Average steps by day of week
SELECT 
    DayOfWeek,
    AVG(TotalSteps) AS avg_steps
FROM daily_activity
GROUP BY DayOfWeek
ORDER BY avg_steps DESC;


-- =========================================================
-- ACTIVITY INTENSITY ANALYSIS
-- =========================================================

-- Relationship between activity intensity and calories burned
SELECT 
    AVG(VeryActiveMinutes) AS avg_very_active_minutes,
    AVG(Calories) AS avg_calories
FROM daily_activity;


-- =========================================================
-- FINAL DATASET FOR TABLEAU DASHBOARD
-- =========================================================

-- Combined weekly summary (used for visualization)
SELECT 
    DayOfWeek,
    AVG(TotalSteps) AS avg_steps,
    AVG(Calories) AS avg_calories,
    AVG(VeryActiveMinutes) AS avg_very_active_minutes
FROM daily_activity
GROUP BY DayOfWeek
ORDER BY avg_steps DESC;

SELECT 
    DayOfWeek,
    AVG(TotalSteps) AS avg_steps,
    AVG(Calories) AS avg_calories,
    AVG(VeryActiveMinutes) AS avg_very_active_minutes
FROM daily_activity
GROUP BY DayOfWeek
ORDER BY avg_steps DESC;



