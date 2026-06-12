-- SchoolPay Database - School Management System
-- File: 03_queries_reports.sql — Queries and reports

USE schoolpay;

-- BASIC SELECT QUERIES

SELECT * FROM students;

SELECT * FROM fee_types;

SELECT DISTINCT payment_method FROM payments;

-- WHERE / FILTERING QUERIES

SELECT full_name, student_number, class
FROM students
WHERE gender = 'Female';

SELECT full_name, student_number, enrollment_date
FROM students
WHERE class = 'Senior 1A';

SELECT payment_code, full_name, amount_paid, payment_date
FROM payments p
JOIN students s ON p.student_number = s.student_number
WHERE amount_paid > 250000;

SELECT full_name, student_number, date_of_birth
FROM students
WHERE date_of_birth > '2010-01-01';

-- GROUP BY / AGGREGATE QUERIES

SELECT class, COUNT(*) AS total_students
FROM students
GROUP BY class;

SELECT t.term_name, t.academic_year, SUM(p.amount_paid) AS total_collected
FROM payments p
JOIN students s ON p.student_number = s.student_number
JOIN terms t ON YEAR(p.payment_date) = t.academic_year
GROUP BY t.term_name, t.academic_year;

SELECT payment_method, ROUND(AVG(amount_paid), 2) AS average_payment
FROM payments
GROUP BY payment_method;

SELECT s.full_name, s.student_number, SUM(p.amount_paid) AS total_paid
FROM students s
JOIN payments p ON s.student_number = p.student_number
GROUP BY s.student_number
ORDER BY total_paid DESC;

-- JOIN QUERIES (3+ TABLES)

SELECT p.payment_code, s.full_name, s.class, p.amount_paid,
       p.payment_date, p.payment_method, r.receipt_number
FROM payments p
JOIN students s ON p.student_number = s.student_number
JOIN payment_receipts r ON p.payment_code = r.payment_code;

SELECT s.full_name, sub.subject_name, er.marks_obtained,
       er.total_marks, er.grade, e.exam_name
FROM exam_results er
JOIN students s ON er.student_number = s.student_number
JOIN subjects sub ON er.subject_id = sub.id
JOIN exams e ON er.exam_id = e.id
ORDER BY s.full_name, sub.subject_name;

SELECT c.class_name, c.stream, stf.full_name AS teacher_name,
       t.term_name, t.academic_year
FROM class_teacher ct
JOIN classes c ON ct.class_id = c.id
JOIN staff stf ON ct.staff_number = stf.staff_number
JOIN terms t ON ct.term_id = t.id;

SELECT s.full_name, s.class, a.attendance_date, a.status, a.recorded_by
FROM attendance a
JOIN students s ON a.student_number = s.student_number
JOIN classes c ON s.class LIKE CONCAT(c.class_name, c.stream)
ORDER BY a.attendance_date;

-- REPORTS

SELECT s.full_name, s.student_number, s.class,
       COALESCE(SUM(p.amount_paid), 0) AS total_paid,
       500000 - COALESCE(SUM(p.amount_paid), 0) AS outstanding_balance,
       CASE
           WHEN 500000 - COALESCE(SUM(p.amount_paid), 0) <= 0 THEN 'Fully Paid'
           WHEN 500000 - COALESCE(SUM(p.amount_paid), 0) <= 100000 THEN 'Partially Paid'
           ELSE 'Outstanding'
       END AS payment_status
FROM students s
LEFT JOIN payments p ON s.student_number = p.student_number
GROUP BY s.student_number
ORDER BY outstanding_balance DESC;

SELECT s.full_name, s.class,
       COUNT(a.id) AS total_days,
       SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS days_present,
       SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS days_absent,
       SUM(CASE WHEN a.status = 'Late' THEN 1 ELSE 0 END) AS days_late,
       SUM(CASE WHEN a.status = 'Excused' THEN 1 ELSE 0 END) AS days_excused,
       ROUND(SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) / COUNT(a.id) * 100, 1) AS attendance_percentage
FROM students s
LEFT JOIN attendance a ON s.student_number = a.student_number
GROUP BY s.student_number
ORDER BY attendance_percentage DESC;
