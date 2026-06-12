-- SchoolPay Database - School Management System
-- File: 02_sample_data.sql — DML (sample data)

USE schoolpay;

INSERT INTO fee_types (fee_name, description) VALUES
('Tuition', 'Core academic fees'),
('Development Fee', 'Infrastructure development'),
('PTA', 'Parent-Teacher Association levy'),
('Sports', 'Sports activities'),
('Computer Lab', 'Computer lab usage'),
('Lunch', 'School lunch program'),
('Transport', 'School bus service'),
('Uniform', 'School uniform');

INSERT INTO classes (class_name, stream, level, capacity) VALUES
('Senior 1', 'A', 'Secondary', 45),
('Senior 1', 'B', 'Secondary', 40),
('Senior 2', 'A', 'Secondary', 42);

INSERT INTO subjects (subject_name, subject_code) VALUES
('Mathematics', 'MATH'),
('English', 'ENG'),
('Biology', 'BIO'),
('Chemistry', 'CHEM'),
('Physics', 'PHY'),
('History', 'HIST'),
('Geography', 'GEOG'),
('ICT', 'ICT');

INSERT INTO terms (term_name, academic_year, start_date, end_date, is_active) VALUES
('Term 1', 2025, '2025-01-27', '2025-04-04', TRUE),
('Term 2', 2025, '2025-05-05', '2025-08-08', FALSE);

INSERT INTO staff VALUES
('STF001', 'Robert Mutebi', 'Teacher', '0700111222', 'rmutebi@schoolpay.ug', '2024-01-15'),
('STF002', 'Jane Nakibuule', 'Bursar', '0700222333', 'jnakibuule@schoolpay.ug', '2023-06-01'),
('STF003', 'Paul Ssempijja', 'Admin', '0700333444', 'pssempijja@schoolpay.ug', '2022-09-10'),
('STF004', 'Alice Kemigisa', 'Head Teacher', '0700444555', 'akemigisa@schoolpay.ug', '2020-01-01'),
('STF005', 'Joseph Wasswa', 'Teacher', '0700555666', 'jwasswa@schoolpay.ug', '2024-02-20');

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

INSERT INTO class_teacher (class_id, staff_number, term_id) VALUES
(1, 'STF001', 1),
(2, 'STF005', 1),
(3, 'STF001', 1);

INSERT INTO subject_teacher (staff_number, subject_id, class_id, term_id) VALUES
('STF001', 1, 1, 1),
('STF001', 1, 2, 1),
('STF005', 3, 1, 1),
('STF005', 3, 2, 1);

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
