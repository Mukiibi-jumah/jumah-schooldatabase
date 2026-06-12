-- SchoolPay Database - School Management System
-- Intern: OPIYO OSCAR
-- Student No: 2300701330
-- Reg Number: 23/U/1330
-- Track: Web Development.
-- File: 01_database_setup.sql — DDL (tables, indexes)

CREATE DATABASE IF NOT EXISTS schoolpay;
USE schoolpay;

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

CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late', 'Excused') NOT NULL,
    recorded_by VARCHAR(100),
    FOREIGN KEY (student_number) REFERENCES students(student_number)
);

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

CREATE TABLE notices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    audience ENUM('Students', 'Parents', 'Staff', 'All') NOT NULL,
    posted_date DATE NOT NULL,
    expiry_date DATE
);

CREATE INDEX idx_payment_date ON payments(payment_date);
CREATE INDEX idx_student_status ON students(status);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);
