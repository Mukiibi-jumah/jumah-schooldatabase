-- Core Student Tables Module
CREATE TABLE IF NOT EXISTS terms (
    term_id INT AUTO_INCREMENT PRIMARY KEY,
    term_name VARCHAR(50) NOT NULL,
    academic_year INT NOT NULL,
    start_date DATE,
    end_date DATE,
    active_status BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    stream VARCHAR(50),
    level VARCHAR(20) NOT NULL, -- Primary, Secondary, or A-Level
    capacity INT
);

CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(50) UNIQUE NOT NULL,
    names VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    class_id INT,
    enrollment_date DATE,
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS student_contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    guardian_names VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    relationship VARCHAR(50),
    is_emergency_contact BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- Staff & Assignments Module
CREATE TABLE IF NOT EXISTS staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_number VARCHAR(50) UNIQUE NOT NULL,
    names VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL, -- Teacher, Bursar, Admin, Head Teacher
    phone VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE
);

CREATE TABLE IF NOT EXISTS class_teacher (
    class_teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT,
    class_id INT,
    term_id INT,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (term_id) REFERENCES terms(term_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    subject_code VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS subject_teacher (
    subject_teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT,
    subject_id INT,
    class_id INT,
    term_id INT,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (term_id) REFERENCES terms(term_id) ON DELETE CASCADE
);

-- Fees & Payments Module
CREATE TABLE IF NOT EXISTS fee_types (
    fee_type_id INT AUTO_INCREMENT PRIMARY KEY,
    fee_type_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS fee_structure (
    fee_structure_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    fee_type_id INT,
    term_id INT,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (fee_type_id) REFERENCES fee_types(fee_type_id) ON DELETE CASCADE,
    FOREIGN KEY (term_id) REFERENCES terms(term_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_code VARCHAR(50) UNIQUE NOT NULL,
    student_id INT,
    amount_paid DECIMAL(10,2) NOT NULL,
    date DATE NOT NULL,
    method VARCHAR(30), -- Cash, Mobile Money, Bank, Cheque
    reference_number VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS payment_receipts (
    receipt_id INT AUTO_INCREMENT PRIMARY KEY,
    receipt_number VARCHAR(50) UNIQUE NOT NULL,
    payment_id INT UNIQUE,
    issued_by INT,
    FOREIGN KEY (payment_id) REFERENCES payments(payment_id) ON DELETE CASCADE,
    FOREIGN KEY (issued_by) REFERENCES staff(staff_id) ON DELETE SET NULL
);

-- Attendance Module
CREATE TABLE IF NOT EXISTS attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    date DATE NOT NULL,
    status VARCHAR(20) NOT NULL, -- Present, Absent, Late, Excused
    recorded_by INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (recorded_by) REFERENCES staff(staff_id) ON DELETE SET NULL
);

-- Exams & Results Module
CREATE TABLE IF NOT EXISTS exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL, -- End of Term, Continuous Assessment, Mock, UNEB
    term_id INT,
    FOREIGN KEY (term_id) REFERENCES terms(term_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exam_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    exam_id INT,
    marks_obtained DECIMAL(5,2) NOT NULL,
    total_marks DECIMAL(5,2) NOT NULL,
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id) ON DELETE CASCADE
);

-- Library & Communication Module
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    subject VARCHAR(50),
    copies_available INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS book_loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    student_borrower_id INT NULL,
    staff_borrower_id INT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (student_borrower_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_borrower_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS notices (
    notice_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    content TEXT NOT NULL,
    audience VARCHAR(50) NOT NULL, -- Students, Parents, Staff, All
    posted_date DATE NOT NULL,
    expiry_date DATE
);
