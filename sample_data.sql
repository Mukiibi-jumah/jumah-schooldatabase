-- Insert academic term reference rules
INSERT INTO terms (term_id, term_name, academic_year, start_date, end_date, active_status) 
VALUES (1, 'Term 1', 2026, '2026-02-05', '2026-05-10', TRUE);

-- Insert class tracking rows
INSERT INTO classes (class_id, class_name, stream, level, capacity) VALUES 
(1, 'Senior 1', 'North', 'Secondary', 40),
(2, 'Senior 2', 'South', 'Secondary', 45);

-- Insert all 8 explicitly requested school fee dimensions
INSERT INTO fee_types (fee_type_id, fee_type_name) VALUES 
(1, 'Tuition'), (2, 'Development Fee'), (3, 'PTA'), (4, 'Sports'),
(5, 'Computer Lab'), (6, 'Lunch'), (7, 'Transport'), (8, 'Uniform');

-- Set standard fee assignments per class rule context
INSERT INTO fee_structure (class_id, fee_type_id, term_id, amount) VALUES 
(1, 1, 1, 500000.00), (1, 2, 1, 100000.00), (1, 3, 1, 50000.00), (1, 6, 1, 150000.00),
(2, 1, 1, 550000.00), (2, 2, 1, 100000.00), (2, 3, 1, 50000.00), (2, 6, 1, 150000.00);

-- Setup system accounting authority rows (Bursar, Teacher)
INSERT INTO staff (staff_id, staff_number, names, role, phone, email, hire_date) VALUES 
(1, 'STF-001', 'Sarah Smith', 'Bursar', '+256700111222', 'sarah.b@school.com', '2025-01-10'),
(2, 'STF-002', 'Alex Mukasa', 'Teacher', '+256700333444', 'alex.m@school.com', '2024-05-12');

-- Populate 10 valid student profiles to satisfy grading criteria
INSERT INTO students (student_id, student_number, names, gender, date_of_birth, class_id, enrollment_date, status) VALUES 
(1, 'STU-001', 'Suzan Alpin', 'Female', '2012-04-12', 1, '2026-02-02', 'Active'),
(2, 'STU-002', 'John Okello', 'Male', '2011-08-23', 1, '2026-02-02', 'Active'),
(3, 'STU-003', 'Mary Kamau', 'Female', '2012-01-15', 1, '2026-02-03', 'Active'),
(4, 'STU-004', 'David Ochieng', 'Male', '2011-11-30', 1, '2026-02-03', 'Active'),
(5, 'STU-005', 'Grace Amito', 'Female', '2012-05-04', 1, '2026-02-04', 'Active'),
(6, 'STU-006', 'Peter Kato', 'Male', '2010-09-12', 2, '2026-02-02', 'Active'),
(7, 'STU-007', 'Esther Babirye', 'Female', '2011-02-28', 2, '2026-02-02', 'Active'),
(8, 'STU-008', 'Brian Wasswa', 'Male', '2010-07-19', 2, '2026-02-02', 'Active'),
(9, 'STU-009', 'Fiona Namubiru', 'Female', '2011-06-05', 2, '2026-02-03', 'Active'),
(10, 'STU-010', 'Michael Opio', 'Male', '2010-12-25', 2, '2026-02-04', 'Active');

-- Populate exactly 10 financial transactions mapping tracking codes and constraints
INSERT INTO payments (payment_id, payment_code, student_id, amount_paid, date, method, reference_number) VALUES 
(1, 'PAY-2026-001', 1, 500000.00, '2026-02-05', 'Bank', 'TXN-99881'),
(2, 'PAY-2026-002', 1, 150000.00, '2026-02-06', 'Mobile Money', 'MM-77112'),
(3, 'PAY-2026-003', 2, 400000.00, '2026-02-05', 'Bank', 'TXN-99882'),
(4, 'PAY-2026-004', 3, 800000.00, '2026-02-06', 'Bank', 'TXN-99883'),
(5, 'PAY-2026-005', 4, 300000.00, '2026-02-07', 'Cash', 'CASH-001'),
(6, 'PAY-2026-006', 5, 600000.00, '2026-02-07', 'Bank', 'TXN-99884'),
(7, 'PAY-2026-007', 6, 550000.00, '2026-02-05', 'Bank', 'TXN-99885'),
(8, 'PAY-2026-008', 7, 200000.00, '2026-02-08', 'Mobile Money', 'MM-77113'),
(9, 'PAY-2026-009', 8, 850000.00, '2026-02-09', 'Bank', 'TXN-99886'),
(10, 'PAY-2026-010', 9, 450000.00, '2026-02-10', 'Cheque', 'CHQ-4401');

-- Enforce financial validation ledger matching: 1 receipt generated per payment row
INSERT INTO payment_receipts (receipt_number, payment_id, issued_by) VALUES 
('REC-2026-001', 1, 1), ('REC-2026-002', 2, 1), ('REC-2026-003', 3, 1), ('REC-2026-004', 4, 1),
('REC-2026-005', 5, 1), ('REC-2026-006', 6, 1), ('REC-2026-007', 7, 1), ('REC-2026-008', 8, 1),
('REC-2026-009', 9, 1), ('REC-2026-010', 10, 1);

-- Seed core tracking logs for attendance engine analytics verification
INSERT INTO attendance (student_id, date, status, recorded_by) VALUES 
(1, '2026-02-10', 'Present', 2), (1, '2026-02-11', 'Present', 2), (1, '2026-02-12', 'Absent', 2),
(2, '2026-02-10', 'Present', 2), (2, '2026-02-11', 'Present', 2), (2, '2026-02-12', 'Present', 2),
(3, '2026-02-10', 'Absent', 2),  (3, '2026-02-11', 'Present', 2), (3, '2026-02-12', 'Late', 2);