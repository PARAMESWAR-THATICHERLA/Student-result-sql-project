# Student-result-sql-project
SQL - only Student Result Management System with queries for analytics and reporting.
# 🎓 Student Result Management System (SQL Only Project)

This is a mini project built entirely using SQL. It manages student marks across subjects, performs academic analysis, and demonstrates advanced SQL techniques.

## 🗂 Tables

- Students: Contains student ID, name, and department
- Subjects: List of subjects offered
- Marks: Marks scored by each student in each subject

## 📊 Features

- Calculate student-wise average marks
- Identify subject toppers
- Department-wise analytics
- Pass/fail analysis
- Student ranking using SQL window functions

## 💻 Tech Used

- SQL (compatible with MySQL, PostgreSQL, SQLite)
- SQL features: JOIN, GROUP BY, CASE, RANK(), subqueries

## 📌 Sample Query Output

```sql
-- Topper in each subject
SELECT sub.name AS subject, s.name AS student, m.marks
FROM ...
