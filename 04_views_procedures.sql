-- SchoolPay Database - School Management System
-- File: 04_views_procedures.sql — Views, stored procedures, and triggers

USE schoolpay;

CREATE OR REPLACE VIEW ActiveStudentContacts AS
SELECT s.student_number, s.full_name, s.class, s.gender,
       c.guardian_name, c.phone_number, c.relationship
FROM students s
JOIN student_contacts c ON s.student_number = c.student_number
WHERE s.status = 'Active';

CREATE OR REPLACE VIEW FeeBalanceSummary AS
SELECT s.student_number, s.full_name, s.class,
       COALESCE(SUM(p.amount_paid), 0) AS total_paid,
       500000 - COALESCE(SUM(p.amount_paid), 0) AS balance_due
FROM students s
LEFT JOIN payments p ON s.student_number = p.student_number
GROUP BY s.student_number;

SELECT * FROM ActiveStudentContacts;

SELECT * FROM FeeBalanceSummary WHERE balance_due > 0;

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

CALL GetStudentBalance('STU001');

DELIMITER $$
CREATE TRIGGER auto_generate_receipt
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    INSERT INTO payment_receipts (receipt_number, payment_code, issued_by)
    VALUES (CONCAT('RCP', NEW.payment_code), NEW.payment_code, 'System Auto');
END$$
DELIMITER ;
