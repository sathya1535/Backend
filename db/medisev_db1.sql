-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 23, 2026 at 07:23 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medisev_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `advanced_assessments`
--

CREATE TABLE `advanced_assessments` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `wbc` float DEFAULT NULL,
  `platelets` float DEFAULT NULL,
  `hemoglobin` float DEFAULT NULL,
  `crp` float DEFAULT NULL,
  `esr` float DEFAULT NULL,
  `creatinine` float DEFAULT NULL,
  `urea` float DEFAULT NULL,
  `bilirubin` float DEFAULT NULL,
  `ast` float DEFAULT NULL,
  `alt` float DEFAULT NULL,
  `inr` float DEFAULT NULL,
  `sodium` float DEFAULT NULL,
  `potassium` float DEFAULT NULL,
  `map` float DEFAULT NULL,
  `troponin_positive` tinyint(1) DEFAULT NULL,
  `pao2_fio2` float DEFAULT NULL,
  `gcs` int(11) DEFAULT NULL,
  `urine_output` float DEFAULT NULL,
  `risk_factors` text DEFAULT NULL,
  `severity_score` int(11) DEFAULT NULL,
  `severity_level` varchar(20) DEFAULT NULL,
  `recorded_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `advanced_assessments`
--

INSERT INTO `advanced_assessments` (`id`, `patient_id`, `wbc`, `platelets`, `hemoglobin`, `crp`, `esr`, `creatinine`, `urea`, `bilirubin`, `ast`, `alt`, `inr`, `sodium`, `potassium`, `map`, `troponin_positive`, `pao2_fio2`, `gcs`, `urine_output`, `risk_factors`, `severity_score`, `severity_level`, `recorded_at`) VALUES
(1, 2, 18000, 80000, 7, 120, 70, 2.5, 110, 4, 200, 180, 2, 120, 6.5, 55, 0, 16, 12, 0.3, 'Age > 60,Diabetes', 46, 'SEVERE', '2026-02-25 17:25:43'),
(2, 6, 12000, 1.6, 12, 20, 25, 1.1, 35, 1, 45, 50, 1.1, 138, 4.275, 75, 0, 1, 15, 1, '', 12, 'MODERATE', '2026-02-25 17:39:46'),
(3, 7, 18000, 80000, 7, 120, 70, 2.5, 110, 4, 200, 180, 2, 120, 6.5, 55, 0, 6, 10, 0.3, 'Age > 60,Diabetes,Heart Disease', 51, 'SEVERE', '2026-02-25 18:17:24'),
(4, 8, 18000, 80000, 7, 120, 70, 2.5, 110, 4, 200, 180, 2, 120, 6.8, 55, 0, 5.5, 10, 0.3, 'Asthma,Kidney Disease', 50, 'SEVERE', '2026-02-25 18:32:32'),
(5, 12, 24, 25, 35, 32, 65, 35, 35, 35, 67, 65, 75, 35, 68, 31, 1, 16, 56, 85, 'Age > 60,Heart Disease', 40, 'SEVERE', '2026-02-28 09:18:28'),
(6, 12, 25, 36, 36, 36, 69, 69, 65, 65, 58, 59, 95, 59, 56, 65, 1, 65, 80, 95, 'Hypertension,Asthma', 36, 'SEVERE', '2026-02-28 09:26:33'),
(7, 13, 0, 0, 11, 25, 22, 1.8, 50, 2.2, 58, 58, 1.7, 132, 3.2, 65, 1, 235, 13, 0.7, 'Asthma', 39, 'SEVERE', '2026-02-28 09:40:28'),
(8, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 25, 'SEVERE', '2026-02-28 09:45:58'),
(9, 14, 25815, 7584, 9154, 16, 945, 166, 64, 64, 13, 611, 95, 9494, 645, 465, 1, 654, 1548, 184, 'Hypertension,Asthma,Kidney Disease,Smoker', 36, 'SEVERE', '2026-02-28 12:18:40'),
(10, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 25, 'SEVERE', '2026-02-28 12:19:13'),
(11, 15, 7965, 248274, 13.9, 0, 12, 0.79, 36, 1.06, 35, 30, 1.05, 137, 3.8, 93, 1, 405, 15, 1.45, 'Smoker,Alcohol Use', 6, 'SEVERE', '2026-03-02 08:30:56'),
(12, 16, 7965, 248275, 13.9, 0, 12, 0.79, 36, 1.06, 35, 30, 1.05, 137, 3.8, 93, 0, 405, 15, 1.45, '', 1, 'MILD', '2026-03-02 08:34:16'),
(13, 17, 13052, 134206, 10.2, 27, 30, 1.61, 49, 2.63, 98, 91, 1.21, 126, 5.9, 73, 1, 293, 13, 0.79, '', 35, 'SEVERE', '2026-03-02 08:38:42'),
(14, 17, 13052, 134206, 10.2, 27, 30, 1.61, 49, 2.63, 98, 91, 1.21, 126, 5.9, 73, 1, 293, 13, 0.79, '', 35, 'SEVERE', '2026-03-02 08:38:45'),
(15, 18, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 1, 450, 15, 1, 'Hypertension', 5, 'SEVERE', '2026-03-05 09:32:05'),
(16, 19, 6800, 220055, 12.5, 1.3, 8, 0.6, 18, 0.4, 22, 28, 1, 120, 3.8, 87, 0, 340, 13, 0.8, 'Smoker,Alcohol Use', 6, 'MILD', '2026-03-07 10:54:24'),
(17, 20, 7.5, 250, 13.5, 2, 10, 0.9, 25, 0.8, 22, 24, 1, 138, 4.2, 90, 1, 420, 15, 1.2, 'Age > 60,Hypertension,Asthma', 13, 'CRITICAL', '2026-03-08 13:04:36'),
(18, 21, 13000, 120000, 10.5, 35, 40, 1.6, 35, 1.8, 75, 75, 1.5, 132, 5.4, 68, 1, 300, 13, 100, 'Age > 60,Asthma', 32, 'CRITICAL', '2026-03-08 13:32:10'),
(19, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 0, 'MILD', '2026-03-09 18:42:24'),
(20, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 0, 'MILD', '2026-03-09 18:46:55'),
(21, 22, 12000, 180000, 12.5, 12, 30, 1.4, 45, 1.3, 55, 60, 1.3, 134, 5.1, 95, 0, 280, 15, 60, '', 25, 'MODERATE', '2026-03-09 18:50:43'),
(22, 22, 12000, 180000, 12.5, 12, 30, 1.4, 45, 1.3, 55, 60, 1.3, 134, 5.1, 95, 0, 280, 15, 60, '', 25, 'MODERATE', '2026-03-09 18:50:45'),
(23, 22, 12000, 180000, 12.5, 12, 30, 1.4, 45, 1.3, 55, 60, 1.3, 134, 5.1, 95, 0, 280, 15, 60, '', 25, 'MODERATE', '2026-03-09 18:50:51'),
(24, 23, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 0, 450, 15, 1, 'Smoker', 1, 'MILD', '2026-03-10 08:44:15'),
(25, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Alcohol Use', 1, 'MILD', '2026-03-10 09:07:26'),
(26, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Alcohol Use', 1, 'MILD', '2026-03-10 09:07:34'),
(27, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 0, 'MILD', '2026-03-10 09:07:39'),
(28, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 0, 'MILD', '2026-03-10 09:07:44'),
(29, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Kidney Disease', 1, 'MILD', '2026-03-10 09:07:47'),
(30, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Kidney Disease', 1, 'MILD', '2026-03-10 09:07:48'),
(31, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Kidney Disease', 1, 'MILD', '2026-03-10 09:07:58'),
(32, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Kidney Disease', 1, 'MILD', '2026-03-10 09:23:02'),
(33, 24, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 1.1, 135, 4.5, 75, 0, 320, 15, 0.7, 'Hypertension,Diabetes', 20, 'MODERATE', '2026-03-10 09:36:28'),
(34, 24, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 1.1, 135, 4.5, 75, 0, 320, 15, 0.7, 'Hypertension,Diabetes', 20, 'MODERATE', '2026-03-10 09:36:45'),
(35, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 0, 'MILD', '2026-03-10 09:46:48'),
(36, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 0, 'MILD', '2026-03-10 10:16:13'),
(37, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Age > 60,Hypertension,Diabetes,Heart Disease', 4, 'MILD', '2026-03-10 10:16:43'),
(38, 26, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 2.2, 128, 6.2, 55, 1, 150, 10, 0.3, 'Age > 60,Hypertension,Diabetes,Heart Disease', 65, 'CRITICAL', '2026-03-10 10:18:48'),
(39, 26, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 2.2, 128, 6.2, 55, 1, 150, 10, 0.3, 'Age > 60,Hypertension,Diabetes,Heart Disease', 65, 'CRITICAL', '2026-03-10 10:19:12'),
(40, 26, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 2.2, 128, 6.2, 55, 1, 150, 10, 0.3, '', 61, 'CRITICAL', '2026-03-10 10:21:09'),
(41, 26, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 2.2, 128, 6.2, 55, 1, 150, 10, 0.3, 'Age > 60,Diabetes,Heart Disease', 64, 'CRITICAL', '2026-03-10 10:21:36'),
(42, 26, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 2.2, 128, 6.2, 55, 1, 150, 10, 0.3, 'Age > 60,Diabetes,Heart Disease', 64, 'CRITICAL', '2026-03-10 10:23:06'),
(43, 26, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 2.2, 128, 6.2, 55, 1, 150, 10, 0.3, 'Age > 60,Diabetes,Heart Disease', 64, 'CRITICAL', '2026-03-10 10:41:21'),
(44, 26, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 2.2, 128, 6.2, 55, 1, 150, 10, 0.3, 'Age > 60,Diabetes,Heart Disease', 64, 'CRITICAL', '2026-03-10 13:46:26'),
(45, 27, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 1, 450, 15, 1, 'Age > 60,Heart Disease', 6, 'CRITICAL', '2026-03-10 16:00:30'),
(46, 27, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 1, 450, 15, 1, 'Age > 60,Heart Disease', 6, 'CRITICAL', '2026-03-10 16:15:21'),
(47, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Diabetes,Pregnancy', 5, 'MILD', '2026-03-10 16:16:40'),
(48, 29, 1200, 180000, 12, 12, 30, 1.4, 45, 1.3, 55, 60, 1.3, 134, 5.1, 95, 0, 280, 14, 600, 'Kidney Disease,Pregnancy', 28, 'CRITICAL', '2026-03-10 16:19:42'),
(49, 30, 12000, 200000, 13.5, 25, 20, 1.4, 40, 0.8, 55, 55, 1, 138, 4.2, 80, 0, 400, 15, 1, 'Pregnancy,Heart Disease', 18, 'MODERATE', '2026-03-10 16:25:05'),
(50, 32, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 1, 450, 15, 1, 'Age > 60,Diabetes', 6, 'CRITICAL', '2026-03-13 21:04:55'),
(51, 32, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 1, 450, 15, 1, 'Age > 60,Diabetes', 6, 'CRITICAL', '2026-03-13 21:08:59'),
(52, 30, 12000, 200000, 13.5, 25, 20, 1.4, 40, 0.8, 55, 55, 1, 138, 4.2, 80, 0, 400, 15, 1, 'Pregnancy,Heart Disease', 18, 'MODERATE', '2026-03-13 21:18:08'),
(53, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Diabetes,Pregnancy', 5, 'MILD', '2026-03-13 21:18:34'),
(54, 22, 12000, 180000, 12.5, 12, 30, 1.4, 45, 1.3, 55, 60, 1.3, 134, 5.1, 95, 0, 280, 15, 60, '', 25, 'MODERATE', '2026-03-13 21:18:45'),
(55, 36, 7500, 2500000, 14.5, 1.5, 10, 0.9, 15, 0.6, 22, 30, 1, 145, 4.5, 85, 1, 458, 15, 1, 'Kidney Disease,Smoker', 6, 'CRITICAL', '2026-03-14 10:39:19'),
(56, 37, 100005, 100055, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 1, 350, 13, 0.4, 'Diabetes,Kidney Disease,Alcohol Use', 37, 'CRITICAL', '2026-03-15 12:38:11'),
(57, 38, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 42, 85, 0, 450, 15, 1, 'Smoker', 4, 'MILD', '2026-03-15 12:40:16'),
(58, 37, 100005, 100055, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Kidney Disease,Alcohol Use', 33, 'CRITICAL', '2026-03-15 12:41:23'),
(59, 37, 100005, 100055, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use', 32, 'CRITICAL', '2026-03-15 12:42:20'),
(60, 37, 100005, 100005, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use', 32, 'CRITICAL', '2026-03-15 12:42:46'),
(61, 37, 10000, 10000, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use', 30, 'CRITICAL', '2026-03-15 12:43:02'),
(62, 37, 100000, 100000, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use', 32, 'CRITICAL', '2026-03-15 12:46:46'),
(63, 37, 100000, 100000, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use', 32, 'CRITICAL', '2026-03-15 12:48:11'),
(64, 37, 12000, 120000, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use', 31, 'CRITICAL', '2026-03-15 12:49:03'),
(65, 37, 12000, 120000, 10.5, 11, 25, 1.5, 25, 2, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use,Heart Disease', 32, 'CRITICAL', '2026-03-15 12:50:36'),
(66, 37, 12000, 120000, 10.5, 11, 25, 1.5, 25, 1, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use,Heart Disease', 30, 'CRITICAL', '2026-03-15 12:52:34'),
(67, 37, 12000, 120000, 10.5, 11, 25, 1.5, 25, 1.5, 50, 57, 1.3, 132, 5.2, 65, 0, 350, 13, 0.4, 'Diabetes,Alcohol Use,Heart Disease', 32, 'CRITICAL', '2026-03-15 12:53:27'),
(68, 33, 7000, 250000, 14, 5, 10, 0.9, 15, 0.8, 25, 25, 0.8, 140, 4.2, 85, 0, 450, 15, 1500, 'Heart Disease', 1, 'MILD', '2026-03-15 17:33:15'),
(69, 34, 13000, 120000, 10, 30, 35, 1.6, 35, 1.8, 70, 70, 1.5, 132, 5.5, 65, 1, 300, 13, 999, 'Asthma', 31, 'CRITICAL', '2026-03-15 17:35:42'),
(70, 35, 25000, 50000, 7, 150, 80, 4.5, 90, 5, 500, 500, 3, 120, 6.5, 45, 0, 120, 7, 150, 'Smoker', 64, 'CRITICAL', '2026-03-15 17:39:32'),
(71, 34, 25000, 50000, 7, 150, 80, 4.5, 90, 5, 500, 500, 3, 120, 6.5, 45, 1, 120, 7, 150, 'Asthma', 68, 'CRITICAL', '2026-03-15 17:42:26'),
(72, 40, 7000, 250000, 14, 3, 12, 0.9, 18, 0.8, 25, 30, 1, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-15 20:23:55'),
(73, 40, 12000, 130000, 11, 15, 30, 1.6, 30, 1.8, 60, 70, 1.4, 132, 5.1, 65, 0, 350, 14, 0.4, 'Diabetes', 30, 'CRITICAL', '2026-03-15 20:26:14'),
(74, 40, 12000, 130000, 11, 15, 30, 1.6, 30, 1.8, 60, 70, 1.4, 132, 5.1, 65, 0, 350, 14, 0.4, 'Diabetes', 30, 'CRITICAL', '2026-03-15 20:26:34'),
(75, 40, 18000, 80000, 9, 60, 50, 2.5, 50, 3, 150, 170, 2, 128, 6, 55, 1, 250, 10, 0.2, 'Diabetes,Heart Disease', 66, 'CRITICAL', '2026-03-15 20:29:06'),
(76, 40, 18000, 80000, 9, 60, 50, 2.5, 50, 3, 150, 170, 2, 128, 6, 55, 1, 250, 10, 0.2, 'Heart Disease', 65, 'CRITICAL', '2026-03-15 20:29:28'),
(77, 41, 7000, 250000, 14, 3, 12, 0.9, 18, 0.8, 25, 30, 1, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-15 20:53:01'),
(78, 41, 12000, 130000, 11, 15, 30, 1.6, 30, 1.8, 60, 70, 1.4, 132, 5.1, 65, 0, 350, 14, 0.4, 'Diabetes', 30, 'CRITICAL', '2026-03-15 20:54:28'),
(79, 41, 18000, 80000, 9, 60, 50, 2.5, 50, 3, 150, 170, 2, 128, 6, 55, 1, 250, 10, 0.2, 'Asthma', 65, 'CRITICAL', '2026-03-15 20:56:07'),
(80, 42, 18000, 80000, 9, 60, 50, 2.5, 50, 3, 150, 170, 2, 128, 6, 55, 1, 250, 10, 0.2, 'Hypertension', 65, 'CRITICAL', '2026-03-15 21:01:37'),
(81, 45, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 0, 128, 6.2, 55, 1, 150, 10, 0.3, NULL, 58, 'CRITICAL', '2026-03-16 20:12:10'),
(82, 45, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 0, 135, 4.5, 75, 0, 320, 15, 0.7, NULL, 16, 'MODERATE', '2026-03-17 08:45:45'),
(83, 43, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 1.2, 135, 4.5, 75, 0, 320, 15, 0.7, 'Hypertension,Diabetes', 20, 'MODERATE', '2026-03-17 11:45:43'),
(84, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, '', 7, 'MILD', '2026-03-17 12:23:50'),
(85, 47, 9000, 100000, 25, 2.5, 12, 1, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Hypertension,Smoker', 11, 'MILD', '2026-03-17 12:25:10'),
(86, 47, 9000, 100000, 25, 2.5, 12, 1, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 'Hypertension,Smoker', 14, 'MODERATE', '2026-03-17 12:25:46'),
(87, 47, 180000, 85000, 9, 1.2, 5.5, 2.5, 60, 3.5, 180, 200, 6.2, 0, 0, 55, 1, 150, 10, 0.3, 'Smoker,Diabetes', 58, 'CRITICAL', '2026-03-17 12:29:42'),
(88, 47, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 1, 450, 15, 1, '', 4, 'CRITICAL', '2026-03-17 14:51:40'),
(89, 47, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 1, 450, 15, 1, 'Hypertension', 5, 'CRITICAL', '2026-03-17 14:51:52'),
(90, 45, 18000, 850, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, NULL, 23, 'MILD', '2026-03-18 08:20:17'),
(91, 45, 11000, 220, 13.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, NULL, 13, 'MILD', '2026-03-18 08:20:51'),
(92, 45, 18000, 850, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, NULL, 23, 'MILD', '2026-03-18 08:22:15'),
(93, 45, 18000, 850, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, NULL, 23, 'MILD', '2026-03-18 08:23:46'),
(94, 45, 180000, 85000, 9, 1.2, 5, 2.5, 60, 3.5, 0, 180, 0, 128, 6.2, 55, 1, 0, 15, 0, NULL, 48, 'CRITICAL', '2026-03-18 08:51:29'),
(95, 45, 180000, 85000, 9, 1.2, 5, 2.5, 60, 3.5, 0, 180, 0, 128, 6.2, 55, 1, 0, 15, 0, NULL, 48, 'CRITICAL', '2026-03-18 08:57:05'),
(96, 45, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 0, 40, 0, 135, 4.5, 75, 0, 0, 15, 0, NULL, 16, 'MODERATE', '2026-03-18 08:57:22'),
(97, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, NULL, 0, 'MILD', '2026-03-18 08:57:45'),
(98, 45, 180000, 85000, 9, 1.2, 5, 2.5, 60, 3.5, 180, 200, 0, 128, 6.2, 55, 0, 0, 10, 0.3, NULL, 51, 'CRITICAL', '2026-03-18 10:06:51'),
(99, 44, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 0, 135, 4.5, 75, 0, 0, 15, 0.7, NULL, 16, 'MODERATE', '2026-03-18 10:07:13'),
(100, 26, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 0, 135, 4.5, 75, 0, 0, 15, 0.7, NULL, 16, 'MODERATE', '2026-03-18 10:07:50'),
(101, 45, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 0, 135, 4.5, 75, 0, 320, 15, 0.7, NULL, 16, 'MODERATE', '2026-03-18 10:16:46'),
(102, 45, 180000, 85000, 9, 1.2, 5, 2.5, 60, 3.5, 180, 200, 0, 128, 6.2, 55, 0, 150, 10, 0.3, NULL, 54, 'CRITICAL', '2026-03-19 11:53:01'),
(103, 45, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 0, 135, 4.5, 75, 0, 320, 15, 0.7, NULL, 16, 'MODERATE', '2026-03-19 11:53:47'),
(104, 43, 11000, 220000, 13.5, 5.2, 25, 1.3, 30, 1.2, 40, 45, 0, 135, 4.5, 75, 0, 320, 15, 0.7, NULL, 16, 'MODERATE', '2026-03-19 11:54:11'),
(105, 48, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 0, 450, 15, 1, 'Smoker', 1, 'MILD', '2026-03-19 13:10:38'),
(106, 48, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 0, 450, 15, 1, 'Smoker', 1, 'MILD', '2026-03-19 13:10:58'),
(107, 48, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 1.5, 130, 5.5, 70, 0, 250, 12, 0.6, 'Hypertension,Diabetes', 27, 'CRITICAL', '2026-03-19 13:15:24'),
(108, 48, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 2.5, 125, 6.5, 55, 1, 150, 8, 0.2, 'Diabetes,Heart Disease', 67, 'CRITICAL', '2026-03-19 13:17:48'),
(109, 49, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 0, 125, 6.5, 55, 0, 150, 8, 0.2, '', 58, 'CRITICAL', '2026-03-19 13:26:11'),
(110, 49, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 13:26:41'),
(111, 49, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 13:27:08'),
(112, 49, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-19 13:27:21'),
(113, 41, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 13:28:06'),
(114, 31, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 13:29:45'),
(115, 50, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 1.4, 130, 5.5, 70, 0, 250, 12, 0.6, 'Hypertension,Diabetes', 19, 'MODERATE', '2026-03-19 14:17:06'),
(116, 50, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 1.4, 130, 5.5, 70, 0, 250, 12, 0.6, 'Hypertension,Diabetes', 19, 'MODERATE', '2026-03-19 14:17:13'),
(117, 51, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 14:20:25'),
(118, 51, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 0, 125, 6.5, 55, 0, 150, 8, 0.2, '', 58, 'CRITICAL', '2026-03-19 14:22:17'),
(119, 51, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 14:22:44'),
(120, 51, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 0, 125, 6.5, 55, 0, 150, 8, 0.2, '', 58, 'CRITICAL', '2026-03-19 14:23:36'),
(121, 51, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 14:23:48'),
(122, 51, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 0, 125, 6.5, 55, 0, 150, 8, 0.2, '', 58, 'CRITICAL', '2026-03-19 14:25:01'),
(123, 51, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-19 14:25:44'),
(124, 51, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 0, 125, 6.5, 55, 0, 150, 8, 0.2, '', 58, 'CRITICAL', '2026-03-19 14:38:39'),
(125, 51, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-19 14:39:14'),
(126, 51, 15000, 1000000, 10, 5, 25, 1.8, 40, 2, 80, 90, 0, 130, 5.5, 70, 0, 250, 12, 0.6, '', 25, 'MODERATE', '2026-03-19 14:44:15'),
(127, 52, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 1, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-19 14:55:37'),
(128, 52, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-20 08:12:53'),
(129, 51, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-20 10:33:48'),
(130, 52, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 0, 125, 6.5, 55, 0, 0, 15, 0.2, '', 46, 'CRITICAL', '2026-03-20 14:27:28'),
(131, 52, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-20 14:58:10'),
(132, 52, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-23 07:38:21'),
(133, 52, 25000, 80000, 8, 20, 50, 3.5, 80, 3.5, 200, 220, 0, 125, 6.5, 55, 0, 150, 8, 0.2, '', 58, 'CRITICAL', '2026-03-23 07:48:45'),
(134, 52, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-23 07:49:06'),
(135, 52, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-23 07:58:09'),
(136, 53, 7500, 250000, 14.5, 1.5, 10, 0.9, 15, 0.6, 25, 30, 0, 140, 4.2, 85, 0, 450, 15, 1, '', 0, 'MILD', '2026-03-23 08:18:10');

-- --------------------------------------------------------

--
-- Table structure for table `analysis_results`
--

CREATE TABLE `analysis_results` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `severity_result` varchar(50) DEFAULT NULL,
  `vitals_id` int(11) DEFAULT NULL,
  `severity_score` float DEFAULT NULL,
  `severity_level` varchar(20) DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `analyzed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `analysis_results`
--

INSERT INTO `analysis_results` (`id`, `patient_id`, `doctor_id`, `severity_result`, `vitals_id`, `severity_score`, `severity_level`, `recommendations`, `analyzed_at`) VALUES
(1, 24, 20, 'MILD', NULL, 1, 'MILD', NULL, '2026-03-10 03:53:02'),
(2, 24, 20, 'MODERATE', NULL, 20, 'MODERATE', NULL, '2026-03-10 04:06:29'),
(3, 24, 20, 'MODERATE', NULL, 20, 'MODERATE', NULL, '2026-03-10 04:06:45'),
(4, 25, 20, 'MILD', NULL, 0, 'MILD', NULL, '2026-03-10 04:16:48'),
(5, 26, 20, 'MILD', NULL, 0, 'MILD', NULL, '2026-03-10 04:46:13'),
(6, 26, 20, 'MILD', NULL, 4, 'MILD', NULL, '2026-03-10 04:46:43'),
(7, 26, 20, 'CRITICAL', NULL, 65, 'CRITICAL', NULL, '2026-03-10 04:48:48'),
(8, 26, 20, 'CRITICAL', NULL, 65, 'CRITICAL', NULL, '2026-03-10 04:49:13'),
(9, 26, 20, 'CRITICAL', NULL, 61, 'CRITICAL', NULL, '2026-03-10 04:51:09'),
(10, 26, 20, 'CRITICAL', NULL, 64, 'CRITICAL', NULL, '2026-03-10 04:51:36'),
(11, 26, 20, 'CRITICAL', NULL, 64, 'CRITICAL', NULL, '2026-03-10 04:53:06'),
(12, 26, 20, 'CRITICAL', NULL, 64, 'CRITICAL', NULL, '2026-03-10 05:11:21'),
(13, 26, 20, 'CRITICAL', NULL, 64, 'CRITICAL', NULL, '2026-03-10 08:16:26'),
(14, 27, 2, 'CRITICAL', NULL, 6, 'CRITICAL', NULL, '2026-03-10 10:30:31'),
(15, 27, 2, 'CRITICAL', NULL, 6, 'CRITICAL', NULL, '2026-03-10 10:45:21'),
(16, 28, 2, 'MILD', NULL, 5, 'MILD', NULL, '2026-03-10 10:46:40'),
(17, 29, 2, 'CRITICAL', NULL, 28, 'CRITICAL', NULL, '2026-03-10 10:49:42'),
(18, 30, 2, 'MODERATE', NULL, 18, 'MODERATE', NULL, '2026-03-10 10:55:06'),
(19, 31, 20, 'CRITICAL', 68, 54, 'CRITICAL', NULL, '2026-03-12 07:17:40'),
(21, 32, 2, 'CRITICAL', NULL, 6, 'CRITICAL', NULL, '2026-03-13 15:38:59'),
(22, 30, 2, 'MODERATE', NULL, 18, 'MODERATE', NULL, '2026-03-13 15:48:08'),
(23, 28, 2, 'MILD', NULL, 5, 'MILD', NULL, '2026-03-13 15:48:34'),
(24, 22, 2, 'MODERATE', NULL, 25, 'MODERATE', NULL, '2026-03-13 15:48:45'),
(25, 36, 28, 'CRITICAL', NULL, 6, 'CRITICAL', NULL, '2026-03-14 05:09:19'),
(26, 37, 29, 'CRITICAL', NULL, 37, 'CRITICAL', NULL, '2026-03-15 07:08:11'),
(27, 38, 29, 'MILD', NULL, 4, 'MILD', NULL, '2026-03-15 07:10:16'),
(28, 37, 29, 'CRITICAL', NULL, 33, 'CRITICAL', NULL, '2026-03-15 07:11:23'),
(29, 37, 29, 'CRITICAL', NULL, 32, 'CRITICAL', NULL, '2026-03-15 07:12:20'),
(30, 37, 29, 'CRITICAL', NULL, 32, 'CRITICAL', NULL, '2026-03-15 07:12:46'),
(31, 37, 29, 'CRITICAL', NULL, 30, 'CRITICAL', NULL, '2026-03-15 07:13:02'),
(32, 37, 29, 'CRITICAL', NULL, 32, 'CRITICAL', NULL, '2026-03-15 07:16:46'),
(33, 37, 29, 'CRITICAL', NULL, 32, 'CRITICAL', NULL, '2026-03-15 07:18:11'),
(34, 37, 29, 'CRITICAL', NULL, 31, 'CRITICAL', NULL, '2026-03-15 07:19:03'),
(35, 37, 29, 'CRITICAL', NULL, 32, 'CRITICAL', NULL, '2026-03-15 07:20:36'),
(36, 37, 29, 'CRITICAL', NULL, 30, 'CRITICAL', NULL, '2026-03-15 07:22:35'),
(37, 37, 29, 'CRITICAL', NULL, 32, 'CRITICAL', NULL, '2026-03-15 07:23:28'),
(38, 33, 2, 'MILD', NULL, 1, 'MILD', NULL, '2026-03-15 12:03:15'),
(39, 34, 2, 'MODERATE', NULL, 31, 'MODERATE', NULL, '2026-03-15 12:05:42'),
(40, 35, 2, 'CRITICAL', NULL, 64, 'CRITICAL', NULL, '2026-03-15 12:09:32'),
(41, 34, 2, 'CRITICAL', NULL, 68, 'CRITICAL', NULL, '2026-03-15 12:12:26'),
(42, 40, 20, 'MILD', NULL, 0, 'MILD', NULL, '2026-03-15 14:53:56'),
(43, 40, 20, 'MODERATE', NULL, 30, 'MODERATE', NULL, '2026-03-15 14:56:14'),
(44, 40, 20, 'MODERATE', NULL, 30, 'MODERATE', NULL, '2026-03-15 14:56:34'),
(45, 40, 20, 'CRITICAL', NULL, 66, 'CRITICAL', NULL, '2026-03-15 14:59:07'),
(46, 40, 20, 'CRITICAL', NULL, 65, 'CRITICAL', NULL, '2026-03-15 14:59:28'),
(47, 41, 20, 'MILD', NULL, 0, 'MILD', NULL, '2026-03-15 15:23:01'),
(48, 41, 20, 'MODERATE', NULL, 30, 'MODERATE', NULL, '2026-03-15 15:24:29'),
(49, 41, 20, 'CRITICAL', NULL, 65, 'CRITICAL', NULL, '2026-03-15 15:26:07'),
(50, 42, 30, 'CRITICAL', NULL, 65, 'CRITICAL', NULL, '2026-03-15 15:31:37'),
(51, 45, 20, 'MILD', NULL, 4, 'MILD', NULL, '2026-03-16 07:47:40'),
(52, 46, 31, 'CRITICAL', NULL, 58, 'CRITICAL', NULL, '2026-03-16 13:46:39'),
(53, 45, 20, 'CRITICAL', 106, 58, 'CRITICAL', NULL, '2026-03-16 14:42:10'),
(54, 46, 31, 'CRITICAL', NULL, 58, 'CRITICAL', NULL, '2026-03-17 02:51:56'),
(55, 45, 20, 'MODERATE', 107, 16, 'MODERATE', NULL, '2026-03-17 03:15:45'),
(56, 43, 20, 'MODERATE', NULL, 18, 'MODERATE', NULL, '2026-03-17 06:15:43'),
(57, 47, 32, 'MILD', NULL, 7, 'MILD', NULL, '2026-03-17 06:53:50'),
(58, 47, 32, 'MILD', NULL, 11, 'MILD', NULL, '2026-03-17 06:55:11'),
(59, 47, 32, 'MILD', NULL, 14, 'MILD', NULL, '2026-03-17 06:55:46'),
(60, 47, 32, 'CRITICAL', NULL, 58, 'CRITICAL', NULL, '2026-03-17 06:59:42'),
(61, 47, 32, 'MILD', NULL, 4, 'MILD', NULL, '2026-03-17 09:21:40'),
(62, 47, 32, 'MILD', NULL, 5, 'MILD', NULL, '2026-03-17 09:21:52'),
(63, 45, 20, 'MILD', 115, 23, 'MILD', NULL, '2026-03-18 02:50:17'),
(64, 45, 20, 'MILD', 116, 13, 'MILD', NULL, '2026-03-18 02:50:51'),
(65, 45, 20, 'MILD', 117, 23, 'MILD', NULL, '2026-03-18 02:52:15'),
(66, 45, 20, 'MILD', 118, 23, 'MILD', NULL, '2026-03-18 02:53:46'),
(67, 45, 20, 'CRITICAL', 119, 48, 'CRITICAL', NULL, '2026-03-18 03:21:29'),
(68, 45, 20, 'CRITICAL', 120, 48, 'CRITICAL', NULL, '2026-03-18 03:27:05'),
(69, 45, 20, 'MODERATE', 121, 16, 'MODERATE', NULL, '2026-03-18 03:27:22'),
(70, 45, 20, 'MILD', 122, 0, 'MILD', NULL, '2026-03-18 03:27:45'),
(71, 45, 20, 'CRITICAL', 123, 51, 'CRITICAL', NULL, '2026-03-18 04:36:51'),
(72, 44, 20, 'MODERATE', 124, 16, 'MODERATE', NULL, '2026-03-18 04:37:13'),
(73, 26, 20, 'MODERATE', 125, 16, 'MODERATE', NULL, '2026-03-18 04:37:50'),
(74, 45, 20, 'MODERATE', 126, 16, 'MODERATE', NULL, '2026-03-18 04:46:46'),
(75, 45, 20, 'CRITICAL', 127, 54, 'CRITICAL', NULL, '2026-03-19 06:23:01'),
(76, 45, 20, 'MODERATE', 128, 16, 'MODERATE', NULL, '2026-03-19 06:23:47'),
(77, 43, 20, 'MODERATE', 129, 16, 'MODERATE', NULL, '2026-03-19 06:24:11'),
(78, 48, 20, 'MILD', NULL, 1, 'MILD', NULL, '2026-03-19 07:40:38'),
(79, 48, 20, 'MILD', NULL, 1, 'MILD', NULL, '2026-03-19 07:40:58'),
(80, 48, 20, 'MODERATE', NULL, 27, 'MODERATE', NULL, '2026-03-19 07:45:24'),
(81, 48, 20, 'CRITICAL', NULL, 67, 'CRITICAL', NULL, '2026-03-19 07:47:48'),
(82, 49, 32, 'CRITICAL', 139, 58, 'CRITICAL', NULL, '2026-03-19 07:56:11'),
(83, 49, 32, 'MODERATE', 140, 25, 'MODERATE', NULL, '2026-03-19 07:56:41'),
(84, 49, 32, 'MODERATE', 141, 25, 'MODERATE', NULL, '2026-03-19 07:57:08'),
(85, 49, 32, 'MILD', 142, 0, 'MILD', NULL, '2026-03-19 07:57:21'),
(86, 41, 20, 'MODERATE', 143, 25, 'MODERATE', NULL, '2026-03-19 07:58:06'),
(87, 31, 20, 'MODERATE', 144, 25, 'MODERATE', NULL, '2026-03-19 07:59:45'),
(89, 50, 20, 'MODERATE', NULL, 27, 'MODERATE', NULL, '2026-03-19 08:47:05'),
(91, 50, 20, 'MODERATE', NULL, 27, 'MODERATE', NULL, '2026-03-19 08:47:13'),
(92, 51, 20, 'MILD', NULL, 0, 'MILD', NULL, '2026-03-19 08:48:39'),
(93, 51, 20, 'MODERATE', 150, 25, 'MODERATE', NULL, '2026-03-19 08:50:25'),
(94, 51, 20, 'CRITICAL', 151, 58, 'CRITICAL', NULL, '2026-03-19 08:52:17'),
(95, 51, 20, 'MODERATE', 152, 25, 'MODERATE', NULL, '2026-03-19 08:52:44'),
(96, 51, 20, 'CRITICAL', 153, 58, 'CRITICAL', NULL, '2026-03-19 08:53:36'),
(97, 51, 20, 'MODERATE', 154, 25, 'MODERATE', NULL, '2026-03-19 08:53:48'),
(98, 51, 20, 'CRITICAL', 155, 58, 'CRITICAL', NULL, '2026-03-19 08:55:01'),
(99, 51, 20, 'MILD', 156, 0, 'MILD', NULL, '2026-03-19 08:55:44'),
(100, 51, 20, 'CRITICAL', 157, 58, 'CRITICAL', NULL, '2026-03-19 09:08:39'),
(101, 51, 20, 'MILD', 158, 0, 'MILD', NULL, '2026-03-19 09:09:14'),
(102, 51, 20, 'MODERATE', 159, 25, 'MODERATE', NULL, '2026-03-19 09:14:15'),
(103, 51, 20, 'CRITICAL', NULL, 57, 'CRITICAL', NULL, '2026-03-19 09:20:21'),
(104, 52, 20, 'MILD', NULL, 0, 'MILD', NULL, '2026-03-19 09:25:37'),
(105, 52, 20, 'MILD', 161, 0, 'MILD', NULL, '2026-03-20 02:42:53'),
(106, 51, 20, 'MILD', 162, 0, 'MILD', NULL, '2026-03-20 05:03:48'),
(107, 52, 20, 'CRITICAL', NULL, 57, 'CRITICAL', NULL, '2026-03-20 06:40:06'),
(108, 52, 20, 'CRITICAL', 163, 46, 'CRITICAL', NULL, '2026-03-20 08:57:28'),
(109, 52, 20, 'MILD', 164, 0, 'MILD', NULL, '2026-03-20 09:28:10'),
(110, 52, 20, 'MILD', 165, 0, 'MILD', NULL, '2026-03-23 02:08:21'),
(111, 52, 20, 'CRITICAL', 166, 58, 'CRITICAL', NULL, '2026-03-23 02:18:45'),
(112, 52, 20, 'MILD', 167, 0, 'MILD', NULL, '2026-03-23 02:19:06'),
(113, 52, 20, 'MILD', 168, 0, 'MILD', NULL, '2026-03-23 02:28:09'),
(114, 53, 20, 'MILD', 169, 0, 'MILD', NULL, '2026-03-23 02:48:10');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `profile_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `fullname`, `email`, `phone`, `specialization`, `password`, `is_active`, `profile_image`) VALUES
(1, 'Test Doctor', 'test@gmail.com', '9876543210', 'Cardiology', '123456', 0, 'https://ui-avatars.com/api/?name=Doctor+Sample&background=random'),
(2, 'naga babitha', 'b@gmail.com', '9154669923', 'mbbs', 'Babitha@123', 1, 'https://ui-avatars.com/api/?name=Doctor+Sample&background=random'),
(3, 'sathya', 'jayasatya.madhav@gmail.com', '9879876656', 'cardiology ', 'sathya@124', 0, 'https://ui-avatars.com/api/?name=Doctor+Sample&background=random'),
(4, 'Govinda', 'sathyapesala56@gmail.com', '9849846656', 'cardiology', 'Govinda@123', 0, 'https://ui-avatars.com/api/?name=Doctor+Sample&background=random'),
(19, 'Venkatesa', 'a@gmail.com', '9849846656', 'Neurology ', 'Sathya@123', 0, 'https://ui-avatars.com/api/?name=Doctor+Sample&background=random'),
(20, 'Mohan', 'kaanagalamohan@gmail.com', '9059139367', 'Cardiology', 'Mohan@123', 1, NULL),
(21, 'Admin User', 'medisevadmin@gmail.com', '9999999999', 'System Admin', 'adminmedisev', 1, NULL),
(22, 'suresh ', 'suresh@gmail.com', '123456789015668', 'cardialogy', '123456A@', 1, NULL),
(27, 'Sathya', 'dnagababitha@gmail.com', '9849846656', 'Physiotherapy \n', 'Jayasukumar@123', 1, NULL),
(28, 'Madhav', 'sathyamadhav56@gmail.com', '6300610531', 'Internal Medicine', 'Madhav@123', 1, NULL),
(29, 'manojsai', 'manojsai8555@gmail.com', '1234567890', 'Critical Care Medicine', 'A123aaa@', 1, NULL),
(30, 'Venkata', 'venkata@gmail.com', '7412589636', 'Critical Care Medicine', 'Jaya@123', 1, NULL),
(31, 'anil', 'anil12@gmail.com', '8989898978', 'Neurologist', 'Anil@1234', 1, NULL),
(32, 'harsha', 'harsha168656@gmail.com', '6326321079', 'Critical Care Medicine', 'Harsha@123', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `login_history`
--

CREATE TABLE `login_history` (
  `id` int(11) NOT NULL,
  `doctor_name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT '',
  `role` varchar(50) DEFAULT 'User',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_history`
--

INSERT INTO `login_history` (`id`, `doctor_name`, `email`, `role`, `timestamp`) VALUES
(1, 'Mohan', '', 'User', '2026-03-03 17:09:18'),
(2, 'Mohan', '', 'User', '2026-03-05 02:50:42'),
(3, 'naga babitha', '', 'User', '2026-03-07 08:09:36'),
(4, 'naga babitha', '', 'User', '2026-03-07 08:54:26'),
(5, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-09 04:41:29'),
(6, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-09 04:46:59'),
(7, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-09 04:48:10'),
(8, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-09 06:44:11'),
(9, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-09 06:48:04'),
(10, 'naga babitha', 'b@gmail.com', 'User', '2026-03-09 13:08:36'),
(11, 'naga babitha', 'b@gmail.com', 'User', '2026-03-09 13:10:07'),
(12, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 03:10:30'),
(13, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-10 05:01:20'),
(14, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 05:04:25'),
(15, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 05:04:49'),
(16, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-10 05:05:07'),
(17, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 05:10:53'),
(18, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-10 06:46:21'),
(19, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 06:58:28'),
(20, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-10 07:10:04'),
(21, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 07:44:26'),
(22, 'naga babitha', 'b@gmail.com', 'User', '2026-03-10 10:28:11'),
(23, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 15:17:36'),
(24, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-10 15:23:25'),
(25, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-10 15:25:10'),
(26, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-11 03:01:51'),
(27, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-11 03:37:14'),
(28, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-11 05:04:44'),
(29, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-11 05:05:08'),
(30, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-11 05:06:54'),
(31, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-11 07:25:55'),
(32, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-11 07:26:07'),
(33, 'naga babitha', 'b@gmail.com', 'User', '2026-03-11 13:39:48'),
(34, 'Admin User', 'medisevadmin@gmail.com', 'Admin', '2026-03-11 13:56:57'),
(35, 'naga babitha', 'b@gmail.com', 'User', '2026-03-11 13:58:40'),
(36, 'Admin User', 'medisevadmin@gmail.com', 'Admin', '2026-03-11 13:59:43'),
(37, 'Admin User', 'medisevadmin@gmail.com', 'Admin', '2026-03-11 15:05:09'),
(38, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 03:00:41'),
(39, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-12 03:00:59'),
(40, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 03:02:18'),
(41, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-12 03:23:03'),
(42, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 04:50:07'),
(43, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-12 04:50:57'),
(44, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 04:51:39'),
(45, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-12 04:52:08'),
(46, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 04:53:32'),
(47, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 07:16:47'),
(48, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 07:34:08'),
(49, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 08:40:58'),
(50, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 08:50:45'),
(51, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 09:18:39'),
(52, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 15:29:29'),
(53, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-12 15:41:45'),
(54, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-12 15:43:11'),
(55, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-13 04:53:26'),
(56, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-13 05:17:56'),
(57, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-13 07:02:10'),
(58, 'naga babitha', 'b@gmail.com', 'User', '2026-03-13 15:31:58'),
(59, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-14 03:03:30'),
(60, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-14 03:25:33'),
(61, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-14 04:58:21'),
(62, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-14 05:02:53'),
(63, 'Madhav', 'sathyamadhav56@gmail.com', 'User', '2026-03-14 05:07:15'),
(64, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-14 05:10:06'),
(65, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-15 06:52:26'),
(66, 'manojsai', 'manojsai8555@gmail.com', 'User', '2026-03-15 06:56:42'),
(67, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-15 07:30:31'),
(68, 'manojsai', 'manojsai8555@gmail.com', 'User', '2026-03-15 07:31:42'),
(69, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-15 07:40:52'),
(70, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-15 14:40:37'),
(71, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-15 15:14:47'),
(72, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-15 15:18:06'),
(73, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-15 15:18:24'),
(74, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-15 15:19:02'),
(75, 'Venkata', 'venkata@gmail.com', 'User', '2026-03-15 15:29:02'),
(76, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-15 15:32:40'),
(77, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-16 04:51:49'),
(78, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-16 07:44:25'),
(79, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-16 07:55:23'),
(80, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-16 08:12:11'),
(81, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-16 09:12:21'),
(82, 'anil', 'anil12@gmail.com', 'User', '2026-03-16 09:14:05'),
(83, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-16 12:44:45'),
(84, 'anil', 'anil12@gmail.com', 'User', '2026-03-16 13:30:09'),
(85, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-16 13:34:39'),
(86, 'Admin User', 'medisevadmin@gmail.com', 'User', '2026-03-16 14:02:21'),
(87, 'Admin User', 'medisevadmin@gmail.com', 'User', '2026-03-16 14:09:54'),
(88, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-16 14:48:12'),
(89, 'anil', 'anil12@gmail.com', 'User', '2026-03-17 02:51:17'),
(90, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-17 03:07:50'),
(91, 'anil', 'anil12@gmail.com', 'User', '2026-03-17 03:20:09'),
(92, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-17 03:24:59'),
(93, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-17 06:26:26'),
(94, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-17 06:43:48'),
(95, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-17 06:44:05'),
(96, 'harsha', 'harsha168656@gmail.com', 'User', '2026-03-17 06:50:47'),
(97, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-17 07:07:13'),
(98, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-18 02:49:52'),
(99, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-19 06:22:33'),
(100, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-19 06:48:07'),
(101, 'harsha', 'harsha168656@gmail.com', 'User', '2026-03-19 07:49:38'),
(102, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-19 07:52:19'),
(103, 'harsha', 'harsha168656@gmail.com', 'User', '2026-03-19 07:56:02'),
(104, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-19 07:57:40'),
(105, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-19 09:19:54'),
(106, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-20 05:06:56'),
(107, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-20 06:38:38'),
(108, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-20 06:38:54'),
(109, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-20 08:07:39'),
(110, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-20 08:09:50'),
(111, 'Admin', 'medisevadmin@gmail.com', 'Admin', '2026-03-20 09:28:47'),
(112, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-23 02:07:40'),
(113, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-23 02:30:12'),
(114, 'Mohan', 'kaanagalamohan@gmail.com', 'User', '2026-03-23 02:38:31');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT 'Alert',
  `message` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `target_role` varchar(20) DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `doctor_id`, `title`, `message`, `is_read`, `created_at`, `target_role`) VALUES
(111, 29, 'Account Update', 'Your password has been successfully updated by the administrator. Please use your new password when logging in.', 0, '2026-03-15 07:31:29', 'doctor'),
(124, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-16 04:51:49', 'admin'),
(125, NULL, 'Inventory', 'New patient added: Ram', 0, '2026-03-16 04:53:10', 'admin'),
(126, NULL, 'Inventory', 'New patient added: sai', 0, '2026-03-16 05:02:08', 'admin'),
(127, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-16 07:44:25', 'admin'),
(128, NULL, 'Inventory', 'New patient added: anil', 0, '2026-03-16 07:45:09', 'admin'),
(129, NULL, 'Password Reset', 'Admin reset password for Dr. Mohan (kaanagalamohan@gmail.com)', 0, '2026-03-16 08:12:34', 'admin'),
(131, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-16 09:12:21', 'admin'),
(132, NULL, 'New User', 'New doctor registration: anil (Neurologist)', 0, '2026-03-16 09:13:54', 'admin'),
(133, NULL, 'Security Alert', 'Dr. anil logged in', 0, '2026-03-16 09:14:05', 'admin'),
(134, NULL, 'Inventory', 'New patient added: saisravan', 0, '2026-03-16 09:16:39', 'admin'),
(135, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-16 12:44:45', 'admin'),
(136, NULL, 'Security Alert', 'Dr. anil logged in', 0, '2026-03-16 13:30:09', 'admin'),
(137, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-16 13:34:39', 'admin'),
(138, NULL, 'Security Alert', 'Dr. Admin User logged in', 0, '2026-03-16 14:02:21', 'admin'),
(139, NULL, 'Security Alert', 'Dr. Admin User logged in', 0, '2026-03-16 14:09:54', 'admin'),
(141, NULL, 'Security Alert', 'Dr. anil logged in', 0, '2026-03-17 02:51:17', 'admin'),
(142, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-17 03:07:50', 'admin'),
(143, NULL, 'Security Alert', 'Dr. anil logged in', 0, '2026-03-17 03:20:09', 'admin'),
(144, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-17 03:24:59', 'admin'),
(145, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-17 06:26:26', 'admin'),
(146, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-17 06:43:48', 'admin'),
(147, NULL, 'New User', 'New doctor registration: harsha (Critical Care Medicine)', 0, '2026-03-17 06:50:08', 'admin'),
(148, NULL, 'Security Alert', 'Dr. harsha logged in', 0, '2026-03-17 06:50:47', 'admin'),
(149, NULL, 'Inventory', 'New patient added: test', 0, '2026-03-17 06:53:07', 'admin'),
(150, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-17 07:07:13', 'admin'),
(151, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-18 02:49:52', 'admin'),
(155, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-19 06:22:33', 'admin'),
(157, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-19 06:48:07', 'admin'),
(158, NULL, 'Inventory', 'New patient added: Kohli', 0, '2026-03-19 07:37:29', 'admin'),
(159, NULL, 'Security Alert', 'Dr. harsha logged in', 0, '2026-03-19 07:49:38', 'admin'),
(160, NULL, 'Inventory', 'New patient added: Rahul', 0, '2026-03-19 07:50:36', 'admin'),
(161, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-19 07:52:19', 'admin'),
(162, NULL, 'Security Alert', 'Dr. harsha logged in', 0, '2026-03-19 07:56:02', 'admin'),
(163, 32, 'Severity Alert', 'CRITICAL ALERT: Patient Rahul reached CRITICAL status', 0, '2026-03-19 07:56:11', 'doctor'),
(164, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-19 07:57:40', 'admin'),
(165, NULL, 'Inventory', 'New patient added: ramu', 0, '2026-03-19 08:44:39', 'admin'),
(166, NULL, 'Inventory', 'New patient added: Rajesh ', 0, '2026-03-19 08:47:54', 'admin'),
(171, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-19 09:19:54', 'admin'),
(172, NULL, 'Inventory', 'New patient added: ramba', 0, '2026-03-19 09:24:48', 'admin'),
(173, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-20 05:06:56', 'admin'),
(174, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-20 06:38:38', 'admin'),
(175, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-20 06:38:54', 'admin'),
(176, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-20 08:07:39', 'admin'),
(177, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-20 08:09:50', 'admin'),
(178, 20, 'Severity Alert', 'CRITICAL ALERT: Patient ramba reached CRITICAL status', 0, '2026-03-20 08:57:28', 'doctor'),
(179, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-23 02:07:40', 'admin'),
(180, 20, 'Severity Alert', 'CRITICAL ALERT: Patient ramba reached CRITICAL status', 0, '2026-03-23 02:18:45', 'doctor'),
(181, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-23 02:30:12', 'admin'),
(182, NULL, 'Security Alert', 'Dr. Mohan logged in', 0, '2026-03-23 02:38:31', 'admin'),
(183, NULL, 'Inventory', 'New patient added: sathya ', 0, '2026-03-23 02:47:15', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `assigned_doctor_id` int(11) DEFAULT NULL,
  `severity_score` float DEFAULT 0,
  `severity_level` varchar(20) DEFAULT 'Mild',
  `last_vitals_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `name`, `age`, `gender`, `phone`, `email`, `address`, `assigned_doctor_id`, `severity_score`, `severity_level`, `last_vitals_date`, `created_at`, `profile_image`) VALUES
(1, 'Ravi Kumar', 45, 'Male', '9876543210', 'ravi@gmail.com', 'Chennai', 1, 2.5, 'Mild', '2026-02-21 09:48:03', '2026-02-21 09:48:03', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(2, 'test1', 21, 'Female', ' 9154669923', 'n@gmail.com', 'chennai \n', 2, 46, 'SEVERE', '2026-02-25 11:55:43', '2026-02-21 16:40:02', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(3, 'test 2 ', 45, 'Male', '9876543210', 'test2@gmail.com', 'Chennai \n', 2, 1, 'Mild', '2026-02-24 16:46:50', '2026-02-22 02:01:14', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(4, 'Rahul', 21, 'Other', '9849846656', 'p@1', 'Hyderabad \n', 3, 4, 'Moderate', '2026-02-24 06:57:46', '2026-02-24 06:57:07', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(5, 'test 3', 20, 'Male', '9876543210', 'test3@gmail.com', 'Chittoor \n\n', 2, 3, 'Moderate', '2026-02-24 16:07:18', '2026-02-24 16:01:04', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(6, 'test 4', 26, 'Male', '9154669923', 'test4@gmail.com', 'banglore \n', 2, 12, 'MODERATE', '2026-02-25 12:09:46', '2026-02-25 11:34:43', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(7, 'test 5', 61, 'Female', '9154669264', 'test@gmail.com', 'Jackie Chan \n', 2, 51, 'SEVERE', '2026-02-25 12:47:24', '2026-02-25 12:44:53', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(8, 'test 6', 78, 'Male', '1234567890', 'test5@gmail.com', 'japan\n', 2, 50, 'SEVERE', '2026-02-25 13:02:32', '2026-02-25 12:59:58', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(9, 'test 7', 45, 'Male', '1234567890', 'test7@gmail.com', 'banglore \n', 2, 0, 'Mild', NULL, '2026-02-27 17:50:17', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(10, 'test 8', 78, 'Female', '123456789', 'test@gmail.com', 'jail\n', 2, 0, 'Mild', NULL, '2026-02-27 18:05:25', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(11, 'test 9', 65, 'Male', '1234567890', 'test@gmail.com', 'India\n', 2, 0, 'Mild', NULL, '2026-02-27 18:39:10', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(12, 'Sathya', 21, 'Male', '9849846656', 'jayasatya.madhav@gmail.com', 'Tirumula \n', 4, 36, 'SEVERE', '2026-02-28 03:56:33', '2026-02-28 03:46:55', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(13, 'ravan ', 12, 'Male', '1334455589', 'h@gmail.com', 'chennai\n', 4, 25, 'SEVERE', '2026-02-28 04:15:58', '2026-02-28 04:01:54', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(14, 'Sathya', 21, 'Male', '96396396', 'b@gmail.com', 'chennai\n\n', 19, 25, 'SEVERE', '2026-02-28 06:49:13', '2026-02-28 06:47:38', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(15, 'Mohan', 21, 'Other', '9876567890', 'kanna@124', 'coorg\n', 20, 6, 'SEVERE', '2026-03-02 03:00:56', '2026-03-02 02:57:50', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(16, 'Harsha', 21, 'Male', '9878900909', 'rimbola@gmail.com', 'venkatagiri \n', 20, 1, 'MILD', '2026-03-02 03:04:16', '2026-03-02 03:01:53', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(17, 'ringa', 22, 'Female', '6789067890', 'ringa@gmail.com', 'london \n', 20, 35, 'SEVERE', '2026-03-02 03:08:45', '2026-03-02 03:05:15', 'https://ui-avatars.com/api/?name=Patient+Sample&background=random'),
(18, 'shinchan', 21, 'Male', '9879876656', 'hii008369@gmail.com', 'Bangalore \n', 20, 5, 'SEVERE', '2026-03-05 04:02:05', '2026-03-05 02:51:47', NULL),
(19, 'Shero', 56, 'Male', '9865985696', 'saisravan1808@gmail.com', 'Chennai\n', 20, 6, 'MILD', '2026-03-07 05:24:24', '2026-03-07 05:22:50', NULL),
(20, 'test 8', 56, 'Female', ' 123456789', 'test@gmail.com', 'Bangalore \n', 2, 13, 'CRITICAL', '2026-03-08 07:34:36', '2026-03-08 07:28:38', NULL),
(21, 'naga', 58, 'Female', '1234567890', 'babi@gmail.com', 'chennai ', 2, 32, 'CRITICAL', '2026-03-08 08:02:10', '2026-03-08 08:00:04', NULL),
(22, 'shin chan', 5, 'Male', '9876521405', 'chan@gmail.com', 'japan', 2, 25, 'MODERATE', '2026-03-13 15:48:45', '2026-03-09 13:10:53', NULL),
(23, 'kanagalla', 20, 'Male', '6396639636', 'stharun414@gmail.com', 'Amalapuram \nAndhra Pradesh India \n', 20, 1, 'MILD', '2026-03-10 03:14:15', '2026-03-10 03:11:22', NULL),
(24, 'rahul', 21, 'Male', '9052266684', 'rahul.mn3233@gmail.com', 'Chittoor \n', 20, 20, 'MODERATE', '2026-03-10 04:06:45', '2026-03-10 03:35:19', NULL),
(25, 'suneel', 22, 'Male', '8309147317', 'kannasuneel004@gmail.com', 'Gudur\n', 20, 0, 'MILD', '2026-03-10 04:16:48', '2026-03-10 04:09:49', NULL),
(26, 'Sravan', 22, 'Male', '8745125478', 'saisravan1808@gmail.com', 'Chettipedu \n', 20, 16, 'MODERATE', '2026-03-18 04:37:50', '2026-03-10 04:43:25', NULL),
(27, 'doremon ', 34, 'Male', '987645312', 'dora@gmail.com', 'tokyo ', 2, 6, 'CRITICAL', '2026-03-10 10:45:21', '2026-03-10 10:29:07', NULL),
(28, 'dog', 6, 'Female', '5454897', 'shs@gmail.com', 'hdhd\n', 2, 5, 'MILD', '2026-03-13 15:48:34', '2026-03-10 10:45:57', NULL),
(29, 'cat ', 6, 'Female', '53563728282', 'g@gmail.com', 'hdhd\n', 2, 28, 'CRITICAL', '2026-03-10 10:49:42', '2026-03-10 10:47:46', NULL),
(30, 'avengers ', 56, 'Male', '1234567890', 'ava@gmail.com', 'brooke\n', 2, 18, 'MODERATE', '2026-03-13 15:48:07', '2026-03-10 10:53:18', NULL),
(31, 'Nikhil ', 20, 'Male', '8121522541', 'itsmenikhil80706@gmail.com', 'saveetha \n', 20, 25, 'MODERATE', '2026-03-19 07:59:45', '2026-03-10 15:18:44', NULL),
(32, 'hulk', 45, 'Male', '9154669923', 'hulk@gmail.com', 'cheaper ', 2, 6, 'CRITICAL', '2026-03-13 15:38:59', '2026-03-13 15:33:26', NULL),
(33, 'mild', 5, 'Male', '64746744993', '', 'hdhd', 2, 1, 'MILD', '2026-03-15 12:03:15', '2026-03-13 15:39:46', NULL),
(34, 'moderate ', 64, 'Other', '6364647483', '', 'gdhd', 2, 68, 'CRITICAL', '2026-03-15 12:12:26', '2026-03-13 15:40:05', NULL),
(35, 'critical ', 53, 'Other', '6363', '', 'hd', 2, 64, 'CRITICAL', '2026-03-15 12:09:32', '2026-03-13 15:40:48', NULL),
(36, 'Harsha ', 21, 'Male', '9639632323', 'madhav@gmail.com', 'chennai\n\n', 28, 6, 'CRITICAL', '2026-03-14 05:09:19', '2026-03-14 05:08:20', NULL),
(37, 'manojsai', 22, 'Male', '1234567890', 'manojsai8555@gmail.com', 'tirupathi ', 29, 32, 'CRITICAL', '2026-03-15 07:23:27', '2026-03-15 06:57:36', NULL),
(38, 'sathya', 21, 'Male', '2580852580', 'sathya@gmail.com', 'venkatagiri \n', 29, 4, 'MILD', '2026-03-15 07:10:16', '2026-03-15 07:09:13', NULL),
(39, 'devesh', 52, 'Male', '1234567809', 'devesh@gmail.com', 'Tirumula \n\n', 29, 0, 'Mild', NULL, '2026-03-15 07:27:43', NULL),
(40, 'Babu ', 34, 'Male', '7412369852', 'babu@gail.com', 'chennai\n', 20, 65, 'CRITICAL', '2026-03-15 14:59:28', '2026-03-15 14:48:42', NULL),
(41, 'Madhavan', 21, 'Male', '3698521471', 'madhavan@gmil.com', 'Chittoor \n\n', 20, 25, 'MODERATE', '2026-03-19 07:58:06', '2026-03-15 15:21:19', NULL),
(42, 'Doraemon ', 45, 'Male', '9632587412', 'dora@gmail.com', 'Tokyo \n\n', 30, 65, 'CRITICAL', '2026-03-15 15:31:37', '2026-03-15 15:30:16', NULL),
(43, 'Ram', 56, 'Male', '9839632588', 'g@gma.cim', 'chennai\n\n', 20, 16, 'MODERATE', '2026-03-19 06:24:11', '2026-03-16 04:53:10', NULL),
(44, 'sai', 21, 'Female', '9632587416', 'sa@gm.com', 'Hyderabad \n', 20, 16, 'MODERATE', '2026-03-18 04:37:13', '2026-03-16 05:02:08', NULL),
(45, 'anil', 45, 'Male', '9090901234', 'anil@gmail.com', 'chettiped', 20, 16, 'MODERATE', '2026-03-19 06:23:47', '2026-03-16 07:45:09', NULL),
(46, 'saisravan', 23, 'Male', '7878676767', 'saisravan@gmail.com', 'chennai', 31, 58, 'CRITICAL', '2026-03-17 02:51:55', '2026-03-16 09:16:39', NULL),
(47, 'test', 50, 'Male', '9876543210', 'test@saveetha.com', 'test', 32, 5, 'MILD', '2026-03-17 09:21:52', '2026-03-17 06:53:07', NULL),
(48, 'Kohli', 54, 'Male', '8989895623', 'virat@gmail.com', 'delhi\n', 20, 67, 'CRITICAL', '2026-03-19 07:47:48', '2026-03-19 07:37:29', NULL),
(49, 'Rahul', 65, 'Male', '7452368545', 'rahul@gmail.com', 'chettipedu \n\n', 32, 0, 'MILD', '2026-03-19 07:57:21', '2026-03-19 07:50:36', NULL),
(50, 'ramu', 51, 'Male', '8258852585', 'ramu@gmail.com', 'Rameswaram \n', 20, 19, 'MODERATE', '2026-03-19 08:47:13', '2026-03-19 08:44:39', NULL),
(51, 'Rajesh ', 31, 'Male', '9789789880', 'raju@gmail.com', 'khammam\n', 20, 0, 'MILD', '2026-03-20 05:03:48', '2026-03-19 08:47:54', NULL),
(52, 'ramba', 21, 'Female', '9878987807', 'ram@gmail.com', 'Chittoor\n\n', 20, 0, 'MILD', '2026-03-23 02:28:09', '2026-03-19 09:24:48', NULL),
(53, 'sathya ', 21, 'Male', '9638527512', 'j@gmail.com', 'chennai\n\n', 20, 0, 'MILD', '2026-03-23 02:48:10', '2026-03-23 02:47:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `report_name` varchar(255) NOT NULL,
  `file_url` varchar(255) NOT NULL,
  `report_type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `symptoms`
--

CREATE TABLE `symptoms` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `symptom_name` varchar(100) NOT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `symptoms`
--

INSERT INTO `symptoms` (`id`, `patient_id`, `symptom_name`, `recorded_at`) VALUES
(1, 2, 'Shortness of breath', '2026-02-22 04:24:08'),
(2, 2, 'Chest pain', '2026-02-22 04:24:08'),
(3, 2, 'Cough', '2026-02-22 04:24:08'),
(4, 2, 'Fever', '2026-02-22 12:03:43'),
(5, 2, 'Headache', '2026-02-22 12:03:43'),
(6, 3, 'Fever', '2026-02-22 12:05:26'),
(7, 4, 'Dizziness', '2026-02-24 06:57:36'),
(8, 4, 'Chest pain', '2026-02-24 06:57:36'),
(9, 4, 'Shortness of breath', '2026-02-24 06:57:36'),
(10, 4, 'Fatigue', '2026-02-24 06:57:36'),
(11, 4, 'Dizziness', '2026-02-24 06:57:46'),
(12, 4, 'Chest pain', '2026-02-24 06:57:46'),
(13, 4, 'Shortness of breath', '2026-02-24 06:57:46'),
(14, 4, 'Fatigue', '2026-02-24 06:57:46'),
(15, 3, 'Confusion', '2026-02-24 15:29:59'),
(16, 3, 'Sore throat', '2026-02-24 15:29:59'),
(17, 5, 'Fever', '2026-02-24 16:07:18'),
(18, 5, 'Headache', '2026-02-24 16:07:18'),
(19, 2, 'Chest pain', '2026-02-24 16:42:20'),
(20, 2, 'Shortness of breath', '2026-02-24 16:42:20'),
(21, 2, 'Dizziness', '2026-02-24 16:44:30'),
(22, 2, 'Chest pain', '2026-02-24 16:44:30'),
(23, 3, 'Confusion', '2026-02-24 16:44:50'),
(24, 3, 'Fever', '2026-02-24 16:46:50'),
(25, 3, 'Headache', '2026-02-24 16:46:50'),
(26, 12, 'Fever', '2026-02-28 03:49:26'),
(27, 12, 'Dizziness', '2026-02-28 03:49:26'),
(28, 12, 'Shortness of breath', '2026-02-28 03:49:26'),
(29, 22, 'fever ', '2026-03-09 13:12:15'),
(30, 22, 'corona ', '2026-03-09 13:12:20'),
(31, 22, 'cold', '2026-03-09 13:16:49'),
(32, 23, 'fever', '2026-03-10 03:12:55'),
(33, 23, 'headache ', '2026-03-10 03:13:02'),
(34, 24, 'chest pain', '2026-03-10 03:37:21'),
(35, 24, 'chestpain', '2026-03-10 03:52:55'),
(36, 25, 'headache ,fatigue', '2026-03-10 04:15:48'),
(38, 26, 'Chestpain', '2026-03-10 04:45:43'),
(39, 26, 'Shortness of Breath ', '2026-03-10 04:45:54'),
(40, 26, 'Dizziness', '2026-03-10 04:46:05'),
(41, 27, 'cold', '2026-03-10 10:30:25'),
(42, 28, 'gof', '2026-03-10 10:46:38'),
(43, 29, 'fever ', '2026-03-10 10:49:35'),
(44, 29, 'cold', '2026-03-10 10:49:39'),
(45, 30, 'cold ', '2026-03-10 10:54:59'),
(46, 30, 'fever', '2026-03-10 10:55:03'),
(50, 32, 'cold', '2026-03-13 15:34:53'),
(51, 36, 'fever', '2026-03-14 05:09:17'),
(53, 38, 'headache,fever', '2026-03-15 07:10:12'),
(54, 37, 'vomiting ', '2026-03-15 07:20:18'),
(55, 33, 'cold', '2026-03-15 12:03:13'),
(56, 34, 'cold', '2026-03-15 12:05:40'),
(57, 35, 'cold', '2026-03-15 12:09:31'),
(59, 40, 'chest pain', '2026-03-15 14:59:03'),
(62, 42, 'Shortness of Breath ', '2026-03-15 15:31:36'),
(68, 43, 'chestpain', '2026-03-17 06:15:41'),
(81, 44, 'Chest Pain', '2026-03-18 04:37:13'),
(82, 26, 'Chest Pain', '2026-03-18 04:37:50'),
(87, 43, 'Chest Pain', '2026-03-19 06:24:11'),
(88, 48, 'Fever ', '2026-03-19 07:45:16'),
(89, 48, 'Shortness of breath ', '2026-03-19 07:45:22'),
(90, 48, 'chest pain', '2026-03-19 07:47:41'),
(94, 49, 'Shortness of Breath', '2026-03-19 07:57:08'),
(95, 41, 'Shortness of Breath', '2026-03-19 07:58:06'),
(96, 31, 'Shortness of Breath', '2026-03-19 07:59:45'),
(97, 50, 'fever ', '2026-03-19 08:46:52'),
(98, 50, 'Short ness of breath ', '2026-03-19 08:47:01'),
(110, 51, 'Shortness of Breath', '2026-03-19 09:14:15'),
(111, 52, 'Shortness of Breath', '2026-03-23 02:18:45'),
(112, 52, 'Chest Pain', '2026-03-23 02:18:45');

-- --------------------------------------------------------

--
-- Table structure for table `vitals`
--

CREATE TABLE `vitals` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `blood_pressure` varchar(20) DEFAULT NULL,
  `heart_rate` int(11) DEFAULT NULL,
  `spo2` int(11) DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `respiratory_rate` int(11) DEFAULT NULL,
  `blood_glucose` float DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vitals`
--

INSERT INTO `vitals` (`id`, `patient_id`, `blood_pressure`, `heart_rate`, `spo2`, `temperature`, `respiratory_rate`, `blood_glucose`, `recorded_at`) VALUES
(1, 2, '85/60', 130, 88, 39.5, 28, NULL, '2026-02-22 04:24:08'),
(2, 2, '130/20', 72, 98, 36.5, 16, NULL, '2026-02-22 12:03:43'),
(3, 3, '100/70', 125, 94, 38.5, 22, NULL, '2026-02-22 12:05:26'),
(4, 4, '120/80', 73, 98, 36.8, 16, NULL, '2026-02-24 06:57:36'),
(5, 4, '120/80', 73, 98, 36.8, 16, NULL, '2026-02-24 06:57:46'),
(6, 3, '150', 43, 101, 55, 9, NULL, '2026-02-24 15:29:49'),
(7, 5, '120/80', 72, 100, 30, 50, NULL, '2026-02-24 16:07:18'),
(8, 2, '85/60', 130, 88, 39.5, 28, NULL, '2026-02-24 16:42:09'),
(9, 2, '85/60', 132, 86, 39.8, 30, NULL, '2026-02-24 16:44:14'),
(10, 3, '150/60', 120, 92, 36.8, 20, NULL, '2026-02-24 16:46:50'),
(11, 6, '80/50', 135, 85, 39.5, 34, 300, '2026-02-25 11:44:43'),
(12, 2, '80/50', 135, 85, 39.5, 34, 300, '2026-02-25 11:53:13'),
(13, 6, '110/75', 105, 96, 37.8, 22, 130, '2026-02-25 12:07:49'),
(14, 7, '80/50', 135, 85, 39.5, 34, 300, '2026-02-25 12:45:59'),
(15, 8, '80/50', 135, 90, 40.5, 260, 310, '2026-02-25 13:01:23'),
(16, 9, '120/80', 85, 98, 37.5, 18, 110, '2026-02-27 17:51:46'),
(17, 9, '95/120', 140, 92, 38.6, 25, 180, '2026-02-27 17:58:39'),
(18, 10, '120/80', 110, 92, 38.6, 25, 180, '2026-02-27 18:06:21'),
(19, 10, '120/80', 72, 98, 36.8, 16, 110, '2026-02-27 18:12:18'),
(20, 10, '220/90', 58, 36, 29.8, 14, 200, '2026-02-27 18:21:11'),
(21, 10, '120/80', 85, 98, 37.5, 18, 110, '2026-02-27 18:34:36'),
(22, 11, '80/50', 140, 85, 39.8, 35, 300, '2026-02-27 18:40:12'),
(23, 12, '150', 72, 98, 36.8, 16, 110, '2026-02-28 03:48:28'),
(24, 12, '120', 72, 98, 36, 16, 110, '2026-02-28 03:56:33'),
(25, 13, '130', 101, 90, 37.6, 29, 115, '2026-02-28 04:10:28'),
(26, 13, '', 0, 0, 0, 0, 0, '2026-02-28 04:15:58'),
(27, 14, '120', 72, 98, 36.8, 16, 110, '2026-02-28 06:48:40'),
(28, 14, '', 0, 0, 0, 0, 0, '2026-02-28 06:49:12'),
(29, 15, '129', 82, 100, 36.8, 19, 116, '2026-03-02 03:00:56'),
(30, 16, '129', 82, 100, 37.9, 19, 116, '2026-03-02 03:04:16'),
(31, 17, '90', 108, 94, 38.3, 25, 198, '2026-03-02 03:08:42'),
(32, 17, '90', 108, 94, 38.3, 25, 198, '2026-03-02 03:08:45'),
(33, 18, '120', 72, 98, 36.8, 16, 110, '2026-03-05 04:02:05'),
(34, 19, '158', 92, 98, 38, 14, 112, '2026-03-07 05:24:24'),
(35, 20, '110', 75, 98, 36.8, 16, 90, '2026-03-08 07:34:36'),
(36, 21, '150', 105, 93, 38.2, 22, 170, '2026-03-08 08:02:10'),
(37, 22, '', 0, 0, 0, 0, 0, '2026-03-09 13:12:24'),
(38, 22, '', 0, 0, 0, 0, 0, '2026-03-09 13:16:55'),
(39, 22, '135', 95, 94, 100.2, 22, 150, '2026-03-09 13:20:42'),
(40, 22, '135', 95, 94, 100.2, 22, 150, '2026-03-09 13:20:45'),
(41, 22, '135', 95, 94, 100.2, 22, 150, '2026-03-09 13:20:51'),
(42, 23, '128', 72, 98, 36.8, 16, 110, '2026-03-10 03:14:15'),
(43, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:37:26'),
(44, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:37:34'),
(45, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:37:39'),
(46, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:37:44'),
(47, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:37:47'),
(48, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:37:48'),
(49, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:37:57'),
(50, 24, '', 0, 0, 0, 0, 0, '2026-03-10 03:53:02'),
(51, 24, '145', 105, 94, 38.2, 22, 160, '2026-03-10 04:06:28'),
(52, 24, '145', 105, 94, 38.2, 22, 160, '2026-03-10 04:06:45'),
(53, 25, '', 0, 0, 0, 0, 0, '2026-03-10 04:16:48'),
(54, 26, '', 0, 0, 0, 0, 0, '2026-03-10 04:46:13'),
(55, 26, '', 0, 0, 0, 0, 0, '2026-03-10 04:46:43'),
(56, 26, '175', 135, 88, 39.5, 30, 280, '2026-03-10 04:48:48'),
(57, 26, '175', 135, 88, 39.5, 30, 280, '2026-03-10 04:49:12'),
(58, 26, '175', 135, 88, 39.5, 30, 280, '2026-03-10 04:51:09'),
(59, 26, '175', 135, 88, 39.5, 30, 280, '2026-03-10 04:51:36'),
(60, 26, '175', 135, 88, 39.5, 30, 280, '2026-03-10 04:53:06'),
(61, 26, '175', 135, 88, 39.5, 30, 280, '2026-03-10 05:11:21'),
(62, 26, '175', 135, 88, 39.5, 30, 280, '2026-03-10 08:16:26'),
(63, 27, '120', 72, 98, 36.5, 16, 110, '2026-03-10 10:30:30'),
(64, 27, '120', 72, 98, 36.5, 16, 110, '2026-03-10 10:45:21'),
(65, 28, '0', 0, 0, 8, 0, 0, '2026-03-10 10:46:40'),
(66, 29, '135', 95, 94, 100.2, 22, 150, '2026-03-10 10:49:42'),
(67, 30, '110', 105, 93, 37.9, 22, 140, '2026-03-10 10:55:05'),
(68, 31, '175', 135, 88, 39.5, 30, NULL, '2026-03-12 07:17:40'),
(71, 32, '120', 72, 98, 36.8, 16, 110, '2026-03-13 15:34:55'),
(72, 32, '120', 72, 98, 36.8, 16, 110, '2026-03-13 15:38:59'),
(73, 30, '110', 105, 93, 37.9, 22, 140, '2026-03-13 15:48:07'),
(74, 28, '0', 0, 0, 8, 0, 0, '2026-03-13 15:48:34'),
(75, 22, '135', 95, 94, 100.2, 22, 150, '2026-03-13 15:48:45'),
(76, 36, '128', 72, 95, 36.8, 16, 110, '2026-03-14 05:09:19'),
(77, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:08:11'),
(78, 38, '120', 72, 98, 36.8, 16, 110, '2026-03-15 07:10:16'),
(79, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:11:23'),
(80, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:12:20'),
(81, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:12:46'),
(82, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:13:02'),
(83, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:16:46'),
(84, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:18:11'),
(85, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:19:03'),
(86, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:20:36'),
(87, 37, '90', 100, 90, 38, 25, 155, '2026-03-15 07:22:34'),
(88, 37, '90', 100, 92, 38, 25, 155, '2026-03-15 07:23:27'),
(90, 33, '120', 75, 98, 37, 16, 90, '2026-03-15 12:03:15'),
(91, 34, '150', 105, 93, 38.1, 22, 170, '2026-03-15 12:05:42'),
(92, 35, '190', 140, 82, 40, 35, 350, '2026-03-15 12:09:32'),
(93, 34, '190', 140, 82, 40, 35, 350, '2026-03-15 12:12:26'),
(94, 40, '120', 75, 98, 36.8, 16, 100, '2026-03-15 14:53:55'),
(95, 40, '95', 105, 92, 38, 24, 160, '2026-03-15 14:56:14'),
(96, 40, '95', 105, 92, 38, 24, 160, '2026-03-15 14:56:34'),
(97, 40, '80', 130, 85, 39.5, 35, 250, '2026-03-15 14:59:06'),
(98, 40, '80', 130, 85, 39.5, 35, 250, '2026-03-15 14:59:28'),
(99, 41, '120', 75, 98, 36.8, 16, 100, '2026-03-15 15:23:01'),
(100, 41, '95', 105, 92, 38, 24, 160, '2026-03-15 15:24:28'),
(101, 41, '80', 130, 85, 39.5, 35, 250, '2026-03-15 15:26:07'),
(102, 42, '80', 130, 85, 39.5, 35, 250, '2026-03-15 15:31:37'),
(106, 45, '175', 135, 88, 39.5, 30, 280, '2026-03-16 14:42:10'),
(107, 45, '145', 105, 94, 38.2, 22, 160, '2026-03-17 03:15:45'),
(108, 43, '145', 105, 94, 38.2, 22, 160, '2026-03-17 06:15:43'),
(109, 47, '150', 68, 100, 45, 30, 120, '2026-03-17 06:53:50'),
(110, 47, '150', 68, 100, 45, 30, 120, '2026-03-17 06:55:10'),
(111, 47, '200', 68, 100, 45, 30, 300, '2026-03-17 06:55:46'),
(112, 47, '175', 135, 88, 39.5, 30, 280, '2026-03-17 06:59:42'),
(113, 47, '120', 72, 98, 36.8, 16, 110, '2026-03-17 09:21:40'),
(114, 47, '120', 72, 98, 36.8, 16, 110, '2026-03-17 09:21:52'),
(115, 45, '10/15', 135, 88, 39.5, 30, 0, '2026-03-18 02:50:17'),
(116, 45, '15/15', 105, 94, 38.2, 22, 0, '2026-03-18 02:50:51'),
(117, 45, '10/15', 135, 88, 39.5, 30, 0, '2026-03-18 02:52:15'),
(118, 45, '10/15', 135, 88, 39.5, 30, 0, '2026-03-18 02:53:46'),
(119, 45, '10/15', 135, 88, 39.5, 30, 280, '2026-03-18 03:21:29'),
(120, 45, '10/15', 135, 88, 39.5, 30, 280, '2026-03-18 03:27:05'),
(121, 45, '15/15', 105, 94, 38.2, 22, 160, '2026-03-18 03:27:22'),
(122, 45, '0/0', 0, 0, 0, 0, 0, '2026-03-18 03:27:45'),
(123, 45, '175', 135, 88, 39.5, 30, 280, '2026-03-18 04:36:51'),
(124, 44, '145', 105, 94, 38.2, 22, 160, '2026-03-18 04:37:13'),
(125, 26, '145', 105, 94, 38.2, 22, 160, '2026-03-18 04:37:50'),
(126, 45, '145', 105, 94, 38.2, 22, 160, '2026-03-18 04:46:46'),
(127, 45, '175', 135, 88, 39.5, 30, 280, '2026-03-19 06:23:01'),
(128, 45, '145', 105, 94, 38.2, 22, 160, '2026-03-19 06:23:47'),
(129, 43, '145', 105, 94, 38.2, 22, 160, '2026-03-19 06:24:11'),
(130, 48, '120', 72, 98, 36.8, 16, 110, '2026-03-19 07:40:38'),
(131, 48, '120', 72, 98, 36.8, 16, 110, '2026-03-19 07:40:58'),
(132, 48, '160', 110, 92, 38.5, 24, 180, '2026-03-19 07:45:24'),
(133, 48, '85', 140, 85, 40, 32, 300, '2026-03-19 07:47:48'),
(139, 49, '85', 140, 85, 40, 32, 300, '2026-03-19 07:56:11'),
(140, 49, '160', 110, 92, 38.5, 24, 180, '2026-03-19 07:56:41'),
(141, 49, '160', 110, 92, 38.5, 24, 180, '2026-03-19 07:57:08'),
(142, 49, '120', 72, 98, 36.8, 16, 110, '2026-03-19 07:57:21'),
(143, 41, '160', 110, 92, 38.5, 24, 180, '2026-03-19 07:58:06'),
(144, 31, '160', 110, 92, 38.5, 24, 180, '2026-03-19 07:59:45'),
(145, 50, '160', 110, 92, 38.5, 24, 180, '2026-03-19 08:47:04'),
(147, 50, '160', 110, 92, 38.5, 24, 180, '2026-03-19 08:47:11'),
(149, 51, '128', 72, 98, 36.8, 16, 110, '2026-03-19 08:48:39'),
(150, 51, '160', 110, 92, 38.5, 24, 180, '2026-03-19 08:50:25'),
(151, 51, '85', 140, 85, 40, 32, 300, '2026-03-19 08:52:17'),
(152, 51, '160', 110, 92, 38.5, 24, 180, '2026-03-19 08:52:44'),
(153, 51, '85', 140, 85, 40, 32, 300, '2026-03-19 08:53:36'),
(154, 51, '160', 110, 92, 38.5, 24, 180, '2026-03-19 08:53:48'),
(155, 51, '85', 140, 85, 40, 32, 300, '2026-03-19 08:55:01'),
(156, 51, '120', 72, 98, 36.8, 16, 110, '2026-03-19 08:55:44'),
(157, 51, '85', 140, 85, 40, 32, 300, '2026-03-19 09:08:39'),
(158, 51, '120', 72, 98, 36.8, 16, 110, '2026-03-19 09:09:14'),
(159, 51, '160', 110, 92, 38.5, 24, 180, '2026-03-19 09:14:15'),
(160, 52, '120', 72, 98, 36.8, 16, 110, '2026-03-19 09:25:37'),
(161, 52, '120', 72, 98, 36.8, 16, 110, '2026-03-20 02:42:53'),
(162, 51, '120', 72, 98, 36.8, 16, 110, '2026-03-20 05:03:48'),
(163, 52, '85', 140, 0, 40, 32, 300, '2026-03-20 08:57:28'),
(164, 52, '120', 72, 98, 36.8, 16, 110, '2026-03-20 09:28:10'),
(165, 52, '120', 72, 98, 36.8, 16, 110, '2026-03-23 02:08:21'),
(166, 52, '85', 140, 85, 40, 32, 300, '2026-03-23 02:18:45'),
(167, 52, '120', 72, 98, 36.8, 16, 110, '2026-03-23 02:19:06'),
(168, 52, '120', 72, 98, 36.8, 16, 110, '2026-03-23 02:28:09'),
(169, 53, '120', 72, 98, 36.8, 16, 110, '2026-03-23 02:48:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `advanced_assessments`
--
ALTER TABLE `advanced_assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `analysis_results`
--
ALTER TABLE `analysis_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `vitals_id` (`vitals_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `login_history`
--
ALTER TABLE `login_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_doctor_id` (`assigned_doctor_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `symptoms`
--
ALTER TABLE `symptoms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `vitals`
--
ALTER TABLE `vitals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `advanced_assessments`
--
ALTER TABLE `advanced_assessments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `analysis_results`
--
ALTER TABLE `analysis_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `login_history`
--
ALTER TABLE `login_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `symptoms`
--
ALTER TABLE `symptoms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `vitals`
--
ALTER TABLE `vitals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `advanced_assessments`
--
ALTER TABLE `advanced_assessments`
  ADD CONSTRAINT `advanced_assessments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `analysis_results`
--
ALTER TABLE `analysis_results`
  ADD CONSTRAINT `analysis_results_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `analysis_results_ibfk_2` FOREIGN KEY (`vitals_id`) REFERENCES `vitals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`assigned_doctor_id`) REFERENCES `doctors` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `symptoms`
--
ALTER TABLE `symptoms`
  ADD CONSTRAINT `symptoms_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vitals`
--
ALTER TABLE `vitals`
  ADD CONSTRAINT `vitals_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
