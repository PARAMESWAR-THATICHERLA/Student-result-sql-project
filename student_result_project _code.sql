-- STUDENT RESULT MANAGEMENT SYSTEM (SQL-ONLY PROJECT)
-- 1. CREATE TABLES

CREATE TABLE Students (
student_id INT PRIMARY KEY, name VARCHAR(100), department VARCHAR(50) 
);

CREATE TABLE Subjects ( 
subject_id INT PRIMARY KEY, name VARCHAR(100)
);

CREATE TABLE Marks (
student_id INT, subject_id INT, marks INT, 
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id) 
);

-- 2. INSERT SAMPLE DATA

INSERT INTO Students VALUES (1, 'Alice', 'ECE'), 
(2, 'Bob', 'CSE'), (3, 'Charlie', 'ECE'), 
(4, 'David', 'EEE'), 
(5, 'Eva', 'CSE');

INSERT INTO Subjects VALUES (101, 'Mathematics'),
(102, 'Physics'), 
(103, 'Computer Networks');

INSERT INTO Marks VALUES (1, 101, 85), (1, 102, 78), (1, 103, 92), 
(2, 101, 90), (2, 102, 88), (2, 103, 95), (3, 101, 55), (3, 102, 60),
(3, 103, 58), (4, 101, 40), (4, 102, 35), (4, 103, 45), (5, 101, 95),
(5, 102, 97), (5, 103, 91);

-- 3. ANALYTICAL QUERIES

-- Q1: Show average marks per student 
SELECT s.name, ROUND(AVG(m.marks), 2) AS average_marks 
FROM Students s JOIN Marks m 
ON s.student_id = m.student_id GROUP BY s.name;

-- Q2: Topper in each subject 
SELECT sub.name AS subject, s.name AS student, m.marks 
FROM Marks m JOIN Students s 
ON m.student_id = s.student_id 
JOIN Subjects sub 
ON m.subject_id = sub.subject_id 
WHERE (m.subject_id, m.marks) IN ( SELECT subject_id, MAX(marks) FROM Marks GROUP BY subject_id );

-- Q3: Count of passed students per subject (pass mark >= 40) 
SELECT sub.name AS subject, COUNT(*) AS pass_count
FROM Marks m JOIN Subjects sub
ON m.subject_id = sub.subject_id 
WHERE m.marks >= 40 GROUP BY sub.name;

-- Q4: Department-wise average marks 
SELECT s.department, ROUND(AVG(m.marks), 2) AS avg_marks 
FROM Students s JOIN Marks m 
ON s.student_id = m.student_id GROUP BY s.department;

-- Q5: Students who passed all subjects
SELECT s.name 
FROM Students s JOIN Marks m
ON s.student_id = m.student_id 
GROUP BY s.student_id, s.name 
HAVING MIN(m.marks) >= 40;

-- Q6: Rank students by total marks 
SELECT s.name, SUM(m.marks) AS total_marks, RANK() OVER (ORDER BY SUM(m.marks) DESC) AS rank_position
FROM Students s JOIN Marks m 
ON s.student_id = m.student_id 
GROUP BY s.name;

-- Q7: Subject-wise highest and lowest marks 
SELECT sub.name AS subject, MAX(m.marks) AS highest, MIN(m.marks) AS lowest
FROM Marks m JOIN Subjects sub
ON m.subject_id = sub.subject_id GROUP BY sub.name;

-- Q8: List all students with their subject-wise marks
SELECT s.name AS student, sub.name AS subject, m.marks 
FROM Marks m JOIN Students s
ON m.student_id = s.student_id JOIN Subjects sub 
ON m.subject_id = sub.subject_id ORDER BY s.name, sub.name;

-- Project complete ✅
