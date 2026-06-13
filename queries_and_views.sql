

-- SELECT Query 
SELECT student_number, names, status FROM students;

--  Filtered WHERE Query 
SELECT student_number, names, gender FROM students WHERE gender = 'Female' AND class_id = 1;

--   GROUP BY Query 
SELECT method, COUNT(*) as transaction_count, SUM(amount_paid) as total_collected 
FROM payments 
GROUP BY method;

--  JOIN Query 
SELECT p.payment_code, s.names AS student_name, c.class_name, p.amount_paid, r.receipt_number
FROM payments p
JOIN students s ON p.student_id = s.student_id
JOIN classes c ON s.class_id = c.class_id
JOIN payment_receipts r ON p.payment_id = r.payment_id;

--  Automated Financial Balance Statement View
CREATE OR REPLACE VIEW view_fee_balances AS
SELECT 
    s.student_id, s.student_number, s.names AS student_name, c.class_name,
    IFNULL(total_fees.assigned_amount, 0) AS total_assigned_fees,
    IFNULL(SUM(p.amount_paid), 0) AS total_fees_paid,
    (IFNULL(total_fees.assigned_amount, 0) - IFNULL(SUM(p.amount_paid), 0)) AS balance_owed
FROM students s
JOIN classes c ON s.class_id = c.class_id
LEFT JOIN (
    SELECT class_id, SUM(amount) AS assigned_amount FROM fee_structure GROUP BY class_id
) total_fees ON c.class_id = total_fees.class_id
LEFT JOIN payments p ON s.student_id = p.student_id
GROUP BY s.student_id, total_fees.assigned_amount;

--  Automated Attendance Tracking Analytics View
CREATE OR REPLACE VIEW view_attendance_summary AS
SELECT 
    s.student_number, s.names AS student_name, COUNT(a.attendance_id) AS total_days_tracked,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS days_present,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS days_absent,
    SUM(CASE WHEN a.status = 'Late' THEN 1 ELSE 0 END) AS days_late
FROM students s
LEFT JOIN attendance a ON s.student_id = a.student_id
GROUP BY s.student_id;

--  Exam Performance Analysis 
-- Calculates the average marks obtained by each student across exams
SELECT 
    s.student_number,
    s.names AS student_name,
    c.class_name,
    COUNT(er.result_id) AS exams_taken,
    ROUND(AVG(er.marks_obtained), 1) AS average_score
FROM students s
JOIN classes c ON s.class_id = c.class_id
LEFT JOIN exam_results er ON s.student_id = er.student_id
GROUP BY s.student_id
ORDER BY average_score DESC;
