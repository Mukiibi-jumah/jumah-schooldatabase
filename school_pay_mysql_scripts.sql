-- SchoolPay Database - School Management System
-- Intern: OPIYO OSCAR
-- Student No: 2300701330
-- Reg Number: 23/U/1330
-- Track: Web Development.

-- Create and use database
CREATE DATABASE IF NOT EXISTS schoolpay;
USE schoolpay;

-- =====================================================
-- 1. CORE STUDENT TABLES
-- =====================================================

CREATE TABLE students (
    student_number VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    class VARCHAR(20) NOT NULL,
    enrollment_date DATE NOT NULL,
    status ENUM('Active', 'Graduated', 'Transferred', 'Suspended') DEFAULT 'Active'
);

CREATE TABLE student_contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL,
    guardian_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    relationship VARCHAR(50),
    emergency_contact BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_number) REFERENCES students(student_number) ON DELETE CASCADE
);

-- =====================================================
-- 2. ACADEMIC STRUCTURE
-- =====================================================

CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    stream VARCHAR(10),
    level ENUM('Primary', 'Secondary', 'A-Level') NOT NULL,
    capacity INT DEFAULT 40
);

CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    subject_code VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE terms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    term_name VARCHAR(20) NOT NULL,
    academic_year YEAR NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT FALSE
);

-- =====================================================
-- 3. STAFF
-- =====================================================

CREATE TABLE staff (
    staff_number VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('Teacher', 'Bursar', 'Admin', 'Head Teacher') NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE NOT NULL
);

CREATE TABLE class_teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    staff_number VARCHAR(20) NOT NULL,
    term_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(id),
    FOREIGN KEY (staff_number) REFERENCES staff(staff_number),
    FOREIGN KEY (term_id) REFERENCES terms(id)
);

CREATE TABLE subject_teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_number VARCHAR(20) NOT NULL,
    subject_id INT NOT NULL,
    class_id INT NOT NULL,
    term_id INT NOT NULL,
    FOREIGN KEY (staff_number) REFERENCES staff(staff_number),
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (class_id) REFERENCES classes(id),
    FOREIGN KEY (term_id) REFERENCES terms(id)
);

-- =====================================================
-- 4. FEES & PAYMENTS
-- =====================================================

CREATE TABLE fee_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fee_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE fee_structure (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    fee_type_id INT NOT NULL,
    term_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(id),
    FOREIGN KEY (fee_type_id) REFERENCES fee_types(id),
    FOREIGN KEY (term_id) REFERENCES terms(id)
);

CREATE TABLE payments (
    payment_code VARCHAR(30) PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('Cash', 'Mobile Money', 'Bank', 'Cheque') NOT NULL,
    reference_number VARCHAR(50),
    FOREIGN KEY (student_number) REFERENCES students(student_number)
);

CREATE TABLE payment_receipts (
    receipt_number VARCHAR(30) PRIMARY KEY,
    payment_code VARCHAR(30) NOT NULL,
    issued_by VARCHAR(100) NOT NULL,
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (payment_code) REFERENCES payments(payment_code)
);

-- =====================================================
-- 5. ATTENDANCE
-- =====================================================

CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late', 'Excused') NOT NULL,
    recorded_by VARCHAR(100),
    FOREIGN KEY (student_number) REFERENCES students(student_number)
);

-- =====================================================
-- 6. EXAMS & RESULTS
-- =====================================================

CREATE TABLE exams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_name VARCHAR(100) NOT NULL,
    exam_type ENUM('End of Term', 'Continuous Assessment', 'Mock', 'UNEB') NOT NULL,
    term_id INT NOT NULL,
    FOREIGN KEY (term_id) REFERENCES terms(id)
);

CREATE TABLE exam_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL,
    subject_id INT NOT NULL,
    exam_id INT NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    total_marks DECIMAL(5,2) NOT NULL,
    grade VARCHAR(2),
    FOREIGN KEY (student_number) REFERENCES students(student_number),
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (exam_id) REFERENCES exams(id)
);

-- =====================================================
-- 7. LIBRARY (OPTIONAL)
-- =====================================================

CREATE TABLE books (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    subject_id INT,
    copies_available INT DEFAULT 1,
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

CREATE TABLE book_loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL,
    student_number VARCHAR(20) NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (student_number) REFERENCES students(student_number)
);

-- =====================================================
-- 8. COMMUNICATION
-- =====================================================

CREATE TABLE notices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    audience ENUM('Students', 'Parents', 'Staff', 'All') NOT NULL,
    posted_date DATE NOT NULL,
    expiry_date DATE
);

-- =====================================================
-- 9. INDEXES
-- =====================================================

CREATE INDEX idx_payment_date ON payments(payment_date);
CREATE INDEX idx_student_status ON students(status);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);

-- =====================================================
-- 10. SAMPLE DATA
-- =====================================================

-- Insert fee types
INSERT INTO fee_types (fee_name, description) VALUES
('Tuition', 'Core academic fees'),
('Development Fee', 'Infrastructure development'),
('PTA', 'Parent-Teacher Association levy'),
('Sports', 'Sports activities'),
('Computer Lab', 'Computer lab usage'),
('Lunch', 'School lunch program'),
('Transport', 'School bus service'),
('Uniform', 'School uniform');

-- Insert classes
INSERT INTO classes (class_name, stream, level, capacity) VALUES
('Senior 1', 'A', 'Secondary', 45),
('Senior 1', 'B', 'Secondary', 40),
('Senior 2', 'A', 'Secondary', 42);

-- Insert subjects
INSERT INTO subjects (subject_name, subject_code) VALUES
('Mathematics', 'MATH'),
('English', 'ENG'),
('Biology', 'BIO'),
('Chemistry', 'CHEM'),
('Physics', 'PHY'),
('History', 'HIST'),
('Geography', 'GEOG'),
('ICT', 'ICT');

-- Insert terms
INSERT INTO terms (term_name, academic_year, start_date, end_date, is_active) VALUES
('Term 1', 2025, '2025-01-27', '2025-04-04', TRUE),
('Term 2', 2025, '2025-05-05', '2025-08-08', FALSE);

-- Insert staff
INSERT INTO staff VALUES
('STF001', 'Robert Mutebi', 'Teacher', '0700111222', 'rmutebi@schoolpay.ug', '2024-01-15'),
('STF002', 'Jane Nakibuule', 'Bursar', '0700222333', 'jnakibuule@schoolpay.ug', '2023-06-01'),
('STF003', 'Paul Ssempijja', 'Admin', '0700333444', 'pssempijja@schoolpay.ug', '2022-09-10'),
('STF004', 'Alice Kemigisa', 'Head Teacher', '0700444555', 'akemigisa@schoolpay.ug', '2020-01-01'),
('STF005', 'Joseph Wasswa', 'Teacher', '0700555666', 'jwasswa@schoolpay.ug', '2024-02-20');

-- Insert 10 students
INSERT INTO students VALUES
('STU001', 'John Muwanguzi', 'Male', '2010-03-15', 'Senior 1A', '2025-01-27', 'Active'),
('STU002', 'Sarah Nabatanzi', 'Female', '2011-06-22', 'Senior 1A', '2025-01-27', 'Active'),
('STU003', 'Peter Okello', 'Male', '2010-09-10', 'Senior 1B', '2025-01-27', 'Active'),
('STU004', 'Grace Achieng', 'Female', '2009-12-01', 'Senior 2A', '2025-01-27', 'Active'),
('STU005', 'David Ssempijja', 'Male', '2011-02-18', 'Senior 1A', '2025-01-28', 'Active'),
('STU006', 'Esther Nakato', 'Female', '2010-07-30', 'Senior 1B', '2025-01-27', 'Active'),
('STU007', 'Isaac Mugisha', 'Male', '2009-05-14', 'Senior 2A', '2025-01-27', 'Active'),
('STU008', 'Faith Nambi', 'Female', '2011-11-05', 'Senior 1A', '2025-01-29', 'Active'),
('STU009', 'Samuel Ochieng', 'Male', '2010-04-20', 'Senior 1B', '2025-01-27', 'Active'),
('STU010', 'Mercy Akinyi', 'Female', '2009-08-25', 'Senior 2A', '2025-01-27', 'Active');

-- Insert student contacts
INSERT INTO student_contacts (student_number, guardian_name, phone_number, relationship, emergency_contact) VALUES
('STU001', 'Joseph Muwanguzi', '0705111222', 'Father', TRUE),
('STU002', 'Grace Nabatanzi', '0706222333', 'Mother', TRUE),
('STU003', 'Michael Okello', '0707333444', 'Father', TRUE),
('STU004', 'Susan Achieng', '0708444555', 'Mother', TRUE),
('STU005', 'Henry Ssempijja', '0709555666', 'Father', TRUE),
('STU006', 'Ruth Nakato', '0710111777', 'Mother', TRUE),
('STU007', 'Peter Mugisha', '0711222888', 'Father', TRUE),
('STU008', 'Martha Nambi', '0712333999', 'Mother', TRUE),
('STU009', 'Tom Ochieng', '0713444111', 'Father', TRUE),
('STU010', 'Diana Akinyi', '0714555222', 'Mother', TRUE);

-- Insert fee structure
INSERT INTO fee_structure (class_id, fee_type_id, term_id, amount) VALUES
(1, 1, 1, 300000.00),
(1, 2, 1, 50000.00),
(1, 3, 1, 20000.00),
(1, 4, 1, 30000.00),
(1, 5, 1, 40000.00),
(1, 6, 1, 60000.00),
(2, 1, 1, 300000.00),
(2, 2, 1, 50000.00),
(2, 4, 1, 30000.00),
(2, 6, 1, 60000.00),
(3, 1, 1, 350000.00),
(3, 2, 1, 60000.00),
(3, 4, 1, 35000.00),
(3, 6, 1, 65000.00);

-- Insert class teachers
INSERT INTO class_teacher (class_id, staff_number, term_id) VALUES
(1, 'STF001', 1),
(2, 'STF005', 1),
(3, 'STF001', 1);

-- Insert subject teachers
INSERT INTO subject_teacher (staff_number, subject_id, class_id, term_id) VALUES
('STF001', 1, 1, 1),
('STF001', 1, 2, 1),
('STF005', 3, 1, 1),
('STF005', 3, 2, 1);

-- Insert 10 payments
INSERT INTO payments VALUES
('PAY001', 'STU001', 250000.00, '2025-02-10', 'Mobile Money', 'REF123456'),
('PAY002', 'STU002', 300000.00, '2025-02-12', 'Bank', 'BANK789'),
('PAY003', 'STU003', 200000.00, '2025-02-15', 'Cash', 'CASH001'),
('PAY004', 'STU004', 350000.00, '2025-02-18', 'Mobile Money', 'REF234567'),
('PAY005', 'STU005', 150000.00, '2025-02-20', 'Bank', 'BANK890'),
('PAY006', 'STU006', 280000.00, '2025-02-22', 'Cash', 'CASH002'),
('PAY007', 'STU007', 200000.00, '2025-02-25', 'Mobile Money', 'REF345678'),
('PAY008', 'STU008', 300000.00, '2025-03-01', 'Bank', 'BANK901'),
('PAY009', 'STU009', 180000.00, '2025-03-05', 'Cheque', 'CHQ001'),
('PAY010', 'STU010', 350000.00, '2025-03-10', 'Mobile Money', 'REF456789');

-- Insert receipts for all 10 payments
INSERT INTO payment_receipts (receipt_number, payment_code, issued_by) VALUES
('RCP001', 'PAY001', 'Admin Officer'),
('RCP002', 'PAY002', 'Admin Officer'),
('RCP003', 'PAY003', 'Admin Officer'),
('RCP004', 'PAY004', 'Admin Officer'),
('RCP005', 'PAY005', 'Admin Officer'),
('RCP006', 'PAY006', 'Admin Officer'),
('RCP007', 'PAY007', 'Admin Officer'),
('RCP008', 'PAY008', 'Admin Officer'),
('RCP009', 'PAY009', 'Admin Officer'),
('RCP010', 'PAY010', 'Admin Officer');

-- Insert attendance records
INSERT INTO attendance (student_number, attendance_date, status, recorded_by) VALUES
('STU001', '2025-02-03', 'Present', 'Robert Mutebi'),
('STU001', '2025-02-04', 'Present', 'Robert Mutebi'),
('STU001', '2025-02-05', 'Absent', 'Robert Mutebi'),
('STU002', '2025-02-03', 'Present', 'Robert Mutebi'),
('STU002', '2025-02-04', 'Present', 'Robert Mutebi'),
('STU002', '2025-02-05', 'Present', 'Robert Mutebi'),
('STU003', '2025-02-03', 'Present', 'Joseph Wasswa'),
('STU003', '2025-02-04', 'Late', 'Joseph Wasswa'),
('STU003', '2025-02-05', 'Present', 'Joseph Wasswa'),
('STU004', '2025-02-03', 'Present', 'Robert Mutebi'),
('STU004', '2025-02-04', 'Absent', 'Robert Mutebi'),
('STU004', '2025-02-05', 'Excused', 'Robert Mutebi'),
('STU005', '2025-02-03', 'Present', 'Robert Mutebi'),
('STU005', '2025-02-04', 'Present', 'Robert Mutebi'),
('STU005', '2025-02-05', 'Late', 'Robert Mutebi'),
('STU006', '2025-02-03', 'Absent', 'Joseph Wasswa'),
('STU006', '2025-02-04', 'Present', 'Joseph Wasswa'),
('STU006', '2025-02-05', 'Present', 'Joseph Wasswa'),
('STU007', '2025-02-03', 'Present', 'Robert Mutebi'),
('STU007', '2025-02-04', 'Present', 'Robert Mutebi'),
('STU007', '2025-02-05', 'Present', 'Robert Mutebi'),
('STU008', '2025-02-03', 'Late', 'Robert Mutebi'),
('STU008', '2025-02-04', 'Present', 'Robert Mutebi'),
('STU008', '2025-02-05', 'Present', 'Robert Mutebi'),
('STU009', '2025-02-03', 'Present', 'Joseph Wasswa'),
('STU009', '2025-02-04', 'Absent', 'Joseph Wasswa'),
('STU009', '2025-02-05', 'Present', 'Joseph Wasswa'),
('STU010', '2025-02-03', 'Present', 'Robert Mutebi'),
('STU010', '2025-02-04', 'Present', 'Robert Mutebi'),
('STU010', '2025-02-05', 'Present', 'Robert Mutebi');

-- Insert exam data
INSERT INTO exams (exam_name, exam_type, term_id) VALUES
('Term 1 Mathematics Exam', 'End of Term', 1),
('Term 1 English Exam', 'End of Term', 1),
('Term 1 Biology Exam', 'End of Term', 1);

INSERT INTO exam_results (student_number, subject_id, exam_id, marks_obtained, total_marks, grade) VALUES
('STU001', 1, 1, 85.00, 100.00, 'A'),
('STU001', 2, 2, 72.00, 100.00, 'B'),
('STU001', 3, 3, 68.00, 100.00, 'B'),
('STU002', 1, 1, 91.00, 100.00, 'A'),
('STU002', 2, 2, 88.00, 100.00, 'A'),
('STU002', 3, 3, 75.00, 100.00, 'B'),
('STU003', 1, 1, 55.00, 100.00, 'C'),
('STU003', 2, 2, 60.00, 100.00, 'C'),
('STU003', 3, 3, 70.00, 100.00, 'B'),
('STU004', 1, 1, 78.00, 100.00, 'B'),
('STU004', 2, 2, 82.00, 100.00, 'A'),
('STU004', 3, 3, 90.00, 100.00, 'A');

-- =====================================================
-- 11. BASIC SELECT QUERIES
-- =====================================================

-- 11a. List all students
SELECT * FROM students;

-- 11b. List all fee types
SELECT * FROM fee_types;

-- 11c. List all payment methods available
SELECT DISTINCT payment_method FROM payments;

-- =====================================================
-- 12. WHERE / FILTERING QUERIES
-- =====================================================

-- 12a. Find all female students
SELECT full_name, student_number, class
FROM students
WHERE gender = 'Female';

-- 12b. Find students enrolled in Senior 1A
SELECT full_name, student_number, enrollment_date
FROM students
WHERE class = 'Senior 1A';

-- 12c. Find payments above 250,000
SELECT payment_code, full_name, amount_paid, payment_date
FROM payments p
JOIN students s ON p.student_number = s.student_number
WHERE amount_paid > 250000;

-- 12d. Find students born after 2010
SELECT full_name, student_number, date_of_birth
FROM students
WHERE date_of_birth > '2010-01-01';

-- =====================================================
-- 13. GROUP BY / AGGREGATE QUERIES
-- =====================================================

-- 13a. Count students per class
SELECT class, COUNT(*) AS total_students
FROM students
GROUP BY class;

-- 13b. Calculate total fees collected per term
SELECT t.term_name, t.academic_year, SUM(p.amount_paid) AS total_collected
FROM payments p
JOIN students s ON p.student_number = s.student_number
JOIN terms t ON YEAR(p.payment_date) = t.academic_year
GROUP BY t.term_name, t.academic_year;

-- 13c. Average payment amount by payment method
SELECT payment_method, ROUND(AVG(amount_paid), 2) AS average_payment
FROM payments
GROUP BY payment_method;

-- 13d. Students with highest total payments
SELECT s.full_name, s.student_number, SUM(p.amount_paid) AS total_paid
FROM students s
JOIN payments p ON s.student_number = p.student_number
GROUP BY s.student_number
ORDER BY total_paid DESC;

-- =====================================================
-- 14. JOIN QUERIES (3+ TABLES)
-- =====================================================

-- 14a. Payment details with student and receipt info
SELECT p.payment_code, s.full_name, s.class, p.amount_paid,
       p.payment_date, p.payment_method, r.receipt_number
FROM payments p
JOIN students s ON p.student_number = s.student_number
JOIN payment_receipts r ON p.payment_code = r.payment_code;

-- 14b. Student exam performance with subject names
SELECT s.full_name, sub.subject_name, er.marks_obtained,
       er.total_marks, er.grade, e.exam_name
FROM exam_results er
JOIN students s ON er.student_number = s.student_number
JOIN subjects sub ON er.subject_id = sub.id
JOIN exams e ON er.exam_id = e.id
ORDER BY s.full_name, sub.subject_name;

-- 14c. Class teacher assignment with teacher and class details
SELECT c.class_name, c.stream, stf.full_name AS teacher_name,
       t.term_name, t.academic_year
FROM class_teacher ct
JOIN classes c ON ct.class_id = c.id
JOIN staff stf ON ct.staff_number = stf.staff_number
JOIN terms t ON ct.term_id = t.id;

-- 14d. Attendance records with student and class info (3 tables)
SELECT s.full_name, s.class, a.attendance_date, a.status, a.recorded_by
FROM attendance a
JOIN students s ON a.student_number = s.student_number
JOIN classes c ON s.class LIKE CONCAT(c.class_name, c.stream)
ORDER BY a.attendance_date;

-- =====================================================
-- 15. REPORTS & VIEWS
-- =====================================================

-- 15a. Fee balance report
-- Assumes total fee per term is 500,000 for simplicity
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

-- 15b. Attendance summary per student
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

-- 15c. View 1: Active students with contact information
CREATE OR REPLACE VIEW ActiveStudentContacts AS
SELECT s.student_number, s.full_name, s.class, s.gender,
       c.guardian_name, c.phone_number, c.relationship
FROM students s
JOIN student_contacts c ON s.student_number = c.student_number
WHERE s.status = 'Active';

-- 15d. View 2: Fee balance summary for all students
CREATE OR REPLACE VIEW FeeBalanceSummary AS
SELECT s.student_number, s.full_name, s.class,
       COALESCE(SUM(p.amount_paid), 0) AS total_paid,
       500000 - COALESCE(SUM(p.amount_paid), 0) AS balance_due
FROM students s
LEFT JOIN payments p ON s.student_number = p.student_number
GROUP BY s.student_number;

-- 15e. Query views
SELECT * FROM ActiveStudentContacts;
SELECT * FROM FeeBalanceSummary WHERE balance_due > 0;

-- =====================================================
-- 16. STORED PROCEDURE & TRIGGER
-- =====================================================

-- 16a. Stored Procedure: Get student fee balance
DELIMITER $$
CREATE PROCEDURE GetStudentBalance(IN student_id VARCHAR(20))
BEGIN
    SELECT s.full_name,
           COALESCE(SUM(p.amount_paid), 0) AS total_paid,
           500000 - COALESCE(SUM(p.amount_paid), 0) AS outstanding_balance
    FROM students s
    LEFT JOIN payments p ON s.student_number = p.student_number
    WHERE s.student_number = student_id;
END$$
DELIMITER ;

-- Call the procedure
CALL GetStudentBalance('STU001');

-- 16b. Trigger: Auto-generate receipt on new payment
DELIMITER $$
CREATE TRIGGER auto_generate_receipt
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    INSERT INTO payment_receipts (receipt_number, payment_code, issued_by)
    VALUES (CONCAT('RCP', NEW.payment_code), NEW.payment_code, 'System Auto');
END$$
DELIMITER ;
