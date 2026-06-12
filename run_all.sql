-- SchoolPay Database - Master Script
-- Run this file to execute all scripts in order
-- Usage: mysql -u root -p < run_all.sql

SOURCE 01_database_setup.sql;
SOURCE 02_sample_data.sql;
SOURCE 03_queries_reports.sql;
SOURCE 04_views_procedures.sql;
