-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 19, 2026 at 07:19 AM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agrolink_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `id` int DEFAULT NULL,
  `student_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_age` int DEFAULT NULL,
  `student_gender` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_order` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_class` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_stream` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry_year` int DEFAULT NULL,
  `student_adm_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_code` bigint DEFAULT NULL,
  `color` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_alt_contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_alt_contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_alt_contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `residential_area` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `road` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `health_problem` text COLLATE utf8mb4_unicode_ci,
  `emergency_person` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `other_information` text COLLATE utf8mb4_unicode_ci,
  `date_of_birth` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registration_date` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_name`, `student_age`, `student_gender`, `nationality`, `religion`, `student_order`, `student_class`, `student_stream`, `entry_year`, `student_adm_number`, `student_code`, `color`, `father_name`, `father_occupation`, `father_contact`, `father_alt_contact`, `mother_name`, `mother_occupation`, `mother_contact`, `mother_alt_contact`, `guardian_name`, `guardian_occupation`, `guardian_contact`, `guardian_alt_contact`, `residential_area`, `zone`, `road`, `health_problem`, `emergency_person`, `other_information`, `date_of_birth`, `image`, `registration_date`, `created_by`) VALUES
(NULL, 'Demo Student', 16, 'female', 'UGANDAN', 'ISLAM', 'boarding', 'S4', NULL, 2017, NULL, 1004237000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'BBOSA HAMUZA', 17, 'male', 'UGANDAN', 'ISLAM', 'day', 'S4', NULL, 2017, NULL, 1004237001, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'KABUGO RATIFAH', 17, 'female', 'UGANDAN', 'ISLAM', 'day', 'S4', NULL, 2017, NULL, 1004237002, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'BBOSA UMAR', 17, 'male', 'UGANDAN', 'ISLAM', 'day', 'S4', NULL, 2017, NULL, 1004237003, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'SAKA DAGLUS', 17, 'male', 'UGANDAN', 'BORN AGAIN', 'day', 'S4', NULL, 2017, NULL, 1004237004, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'NASANGA MEBRA', 17, 'female', 'UGANDAN', 'BORN AGAIN', 'boarding', 'S4', NULL, 2017, NULL, 1004237005, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'NAMBAZIIRA VANESSA', 17, 'female', 'UGANDAN', 'BORN AGAIN', 'day', 'S4', NULL, 2017, NULL, 1004237006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'WAMALA ANDREW', 17, 'male', 'UGANDAN', 'BORN AGAIN', 'day', 'S4', NULL, 2017, NULL, 1004237007, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'NAKALEMA SHARON', 17, 'female', 'UGANDAN', 'BORN AGAIN', 'boarding', 'S4', NULL, 2017, NULL, 1004237008, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004),
(NULL, 'UWERA DIVINE MARY', 17, 'female', 'UGANDAN', 'CATHOLIC', 'day', 'S4', NULL, 2017, NULL, 1004237009, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1004);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
