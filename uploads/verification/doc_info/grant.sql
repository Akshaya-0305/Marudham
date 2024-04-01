-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2022 at 12:12 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grant`
--

-- --------------------------------------------------------

--
-- Table structure for table `candidate_details`
--

CREATE TABLE `candidate_details` (
  `candidate_details_id` int(11) NOT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `applicant_id` varchar(250) DEFAULT NULL,
  `instalment_details` varchar(250) DEFAULT NULL,
  `institute_details` varchar(250) DEFAULT NULL,
  `course_fees` varchar(250) DEFAULT NULL,
  `joining_date` varchar(250) DEFAULT NULL,
  `batch_start_date` varchar(250) DEFAULT NULL,
  `instalment_start_date` varchar(250) DEFAULT NULL,
  `spoc` varchar(250) DEFAULT NULL,
  `contact_details` varchar(250) DEFAULT NULL,
  `voucher_ref` varchar(250) DEFAULT NULL,
  `paid_date` varchar(250) DEFAULT NULL,
  `amount` int(250) DEFAULT NULL,
  `review1` varchar(250) DEFAULT NULL,
  `review2` varchar(250) DEFAULT NULL,
  `review3` varchar(250) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `candidate_details`
--

INSERT INTO `candidate_details` (`candidate_details_id`, `insert_userid`, `update_userid`, `delete_userid`, `applicant_id`, `instalment_details`, `institute_details`, `course_fees`, `joining_date`, `batch_start_date`, `instalment_start_date`, `spoc`, `contact_details`, `voucher_ref`, `paid_date`, `amount`, `review1`, `review2`, `review3`, `status`, `created_date`, `updated_date`) VALUES
(1, 1, NULL, NULL, '-siva', 'sdsdfsd', 'dfsdf', '1000', '2022-11-16', '2022-11-16', '2022-11-16', 'fgdsfgdf', 'dfgsdfg', '', '2022-11-16', 10000, 'fgdfgdsf', 'dfgsdfgsd', 'dfgdsfgdsf', 0, '2022-11-15 12:59:29', '2022-11-15 12:59:29'),
(2, 1, 1, NULL, '-sivabala23', 'sdsdfsd', 'dfsdf', '1000', '2022-11-16', '2022-11-16', '2022-11-16', 'fgdsfgdf', 'dfgsdfg', 'dsfgdsfg', '2022-11-16', 10000, 'dsfdsadf', 'fsdfsadf', 'sdfasdfsadf', 0, '2022-11-15 13:00:21', '2022-11-15 13:00:21');

-- --------------------------------------------------------

--
-- Table structure for table `committee_creation`
--

CREATE TABLE `committee_creation` (
  `committee_id` int(11) NOT NULL,
  `committee_name` varchar(255) DEFAULT NULL,
  `assign_staff` varchar(255) DEFAULT NULL,
  `committee_purpose` text DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `committee_creation`
--

INSERT INTO `committee_creation` (`committee_id`, `committee_name`, `assign_staff`, `committee_purpose`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`) VALUES
(1, 'chandru', 'Balamurugan', 'testing', NULL, NULL, NULL, 0, '2022-11-08 23:27:12', '2022-11-08 23:27:12'),
(2, 'priya', 'siva', 'testing2', NULL, NULL, NULL, 0, '2022-11-08 23:27:28', '2022-11-08 23:27:28'),
(4, 'priya', 'siva', 'Process', NULL, NULL, NULL, 0, '2022-11-09 10:19:07', '2022-11-09 10:19:07'),
(5, 'priya', 'siva', 'Process', NULL, NULL, NULL, 1, '2022-11-09 15:31:14', '2022-11-09 15:31:14'),
(6, 'priya', 'siva', 'Process', NULL, NULL, NULL, 0, '2022-11-09 21:26:03', '2022-11-09 21:26:03'),
(7, 'priya', 'siva', 'Processtest', NULL, NULL, NULL, 0, '2022-11-09 21:41:39', '2022-11-09 21:41:39'),
(8, 'sivashankari', 'Maha', 'tesdfggjhkjlk;lkl;', NULL, NULL, NULL, 1, '2022-11-09 21:51:57', '2022-11-09 21:51:57'),
(9, 'sivashankari', 'Balamurugan', 'ghghjhjj', NULL, NULL, NULL, 0, '2022-11-09 21:52:13', '2022-11-09 21:52:13'),
(10, 'sivashankari', 'Balamurugan', 'test', NULL, NULL, NULL, 1, '2022-11-09 22:06:03', '2022-11-09 22:06:03'),
(11, 'sivasssssss', 'Balamurugan', 'testfff', NULL, 1, NULL, 0, '2022-11-09 22:14:20', '2022-11-09 22:14:20');

-- --------------------------------------------------------

--
-- Table structure for table `committee_review`
--

CREATE TABLE `committee_review` (
  `committee_review_id` int(11) NOT NULL,
  `applicant_id` varchar(250) DEFAULT NULL,
  `course_required` varchar(255) DEFAULT NULL,
  `institute_likely_to_appear` varchar(255) DEFAULT NULL,
  `course_fees` varchar(255) DEFAULT NULL,
  `review_date` varchar(255) DEFAULT NULL,
  `course_completion` varchar(255) DEFAULT NULL,
  `certification_view` varchar(255) DEFAULT NULL,
  `instalment_detils` varchar(255) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `person1` text NOT NULL,
  `person2` text NOT NULL,
  `final_recommodation` varchar(255) DEFAULT NULL,
  `comment` varchar(250) DEFAULT NULL,
  `is_applicant` varchar(250) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `committee_review`
--

INSERT INTO `committee_review` (`committee_review_id`, `applicant_id`, `course_required`, `institute_likely_to_appear`, `course_fees`, `review_date`, `course_completion`, `certification_view`, `instalment_detils`, `start_date`, `end_date`, `person1`, `person2`, `final_recommodation`, `comment`, `is_applicant`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`) VALUES
(1, '', 'tamil', '2', '1000', '', 'B.Sc', NULL, '3', '2022-11-12', '2022-11-26', 'dfsdfsdf', 'dfsadfsadfsd', 'Pass', 'fwefrwer', 'Reject', NULL, NULL, NULL, 0, '2022-11-12 15:42:59', '2022-11-12 15:42:59'),
(2, 'GRANT007-sivabala2', 'tamil', '2,1', '2000', '2022-11-12', 'B.Sc', NULL, '3', '2022-11-12', '2022-11-12', 'test2', 'test', 'Fail', 'testing', 'Reject', NULL, NULL, NULL, 0, '2022-11-12 15:59:41', '2022-11-12 15:59:41'),
(3, '12', 'tamil', '2', '', '2022-11-12', '', NULL, '', '', '', '', '', 'Pass', 'rtertertret', 'Reject', NULL, NULL, NULL, 1, '2022-11-12 16:02:11', '2022-11-12 16:02:11'),
(4, 'GRANT005', 'tamil', '2', '2000', '2022-11-19', 'B.Sc', NULL, '3', '2022-11-19', '2022-11-19', 'test2', 'test', 'Pass', 'testing', 'Approved', NULL, NULL, NULL, 0, '2022-11-12 17:14:19', '2022-11-12 17:14:19'),
(5, 'GRANT002-siva', 'English', '1', '1000', '2022-11-26', 'B.Sc', NULL, '3', '2022-11-26', '2022-11-26', 'test', 'test', 'Pass', 'test', 'Approved', NULL, NULL, NULL, 0, '2022-11-12 17:22:42', '2022-11-12 17:22:42'),
(6, '', '', '', '', '', '', NULL, '', '', '', '', '', 'Pass', 'dsfsdfsdf', 'Reject', 1, NULL, NULL, 0, '2022-11-15 11:10:16', '2022-11-15 11:10:16'),
(7, '', '', '', '', '', '', NULL, '', '', '', '', '', 'Pass', 'fdgdsfg', 'Reject', 1, NULL, NULL, 0, '2022-11-15 11:11:22', '2022-11-15 11:11:22');

-- --------------------------------------------------------

--
-- Table structure for table `confirmation`
--

CREATE TABLE `confirmation` (
  `confirmation_id` int(11) NOT NULL,
  `applicant_name` varchar(255) DEFAULT NULL,
  `course_required` varchar(255) DEFAULT NULL,
  `course_fees` varchar(255) DEFAULT NULL,
  `instalment_details` varchar(255) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `confirmation_date` varchar(255) DEFAULT NULL,
  `course_completion` varchar(255) DEFAULT NULL,
  `certification_view` varchar(255) DEFAULT NULL,
  `batch_start_date` varchar(255) DEFAULT NULL,
  `instalment_start_date` varchar(255) DEFAULT NULL,
  `com_person1` text DEFAULT NULL,
  `com_person2` text DEFAULT NULL,
  `ins_person1` text DEFAULT NULL,
  `scholarship` varchar(255) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `instalment_start_date1` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `confirmation`
--

INSERT INTO `confirmation` (`confirmation_id`, `applicant_name`, `course_required`, `course_fees`, `instalment_details`, `start_date`, `end_date`, `confirmation_date`, `course_completion`, `certification_view`, `batch_start_date`, `instalment_start_date`, `com_person1`, `com_person2`, `ins_person1`, `scholarship`, `insert_userid`, `update_userid`, `delete_userid`, `instalment_start_date1`, `status`, `created_date`, `updated_date`) VALUES
(1, '-siva', 'tamil', '1000', 'sdsdfsd', '2022-11-15', '2022-11-15', '2022-11-15', 'B.Sc', NULL, '2022-11-16', '2022-11-15', 'dfgdsfg', 'dfgdsfg', 'dfgdfsgdsf', 'No', 1, 1, NULL, NULL, 0, '2022-11-14 18:01:04', '2022-11-14 18:01:04'),
(2, '-sivabala23', 'tamil', '1000', 'sdsdfsd', '2022-11-16', '2022-11-16', '2022-11-16', 'B.Sc', NULL, '2022-11-16', '2022-11-16', 'fdfdfd', 'fdfdfdf', 'dfdfdf', 'Yes', 1, NULL, NULL, NULL, 0, '2022-11-15 10:23:04', '2022-11-15 10:23:04'),
(3, 'GRANT012-', 'English', '2000', 'sdsdfsd', '2022-11-17', '2022-11-17', '2022-11-17', 'B.Sc', NULL, '2022-11-17', '2022-11-17', 'xcvxvxc', 'teswt', 'xvxcvxcv', 'Yes', 1, 1, NULL, NULL, 0, '2022-11-15 10:24:00', '2022-11-15 10:24:00'),
(4, '', '', '', '', '', '', '', '', NULL, '', '', '', '', '', 'Yes', 1, NULL, NULL, NULL, 0, '2022-11-15 10:55:14', '2022-11-15 10:55:14'),
(5, '', '', '', '', '', '', '', '', NULL, '', '', '', '', '', 'Yes', 1, NULL, NULL, NULL, 0, '2022-11-15 10:55:30', '2022-11-15 10:55:30'),
(6, '', '', '', '', '', '', '', '', NULL, '', '', '', '', '', 'Yes', 1, NULL, NULL, NULL, 0, '2022-11-15 10:57:16', '2022-11-15 10:57:16'),
(7, '', '', '', '', '', '', '', '', NULL, '', '', '', '', '', 'Yes', 1, NULL, NULL, NULL, 0, '2022-11-15 10:57:32', '2022-11-15 10:57:32');

-- --------------------------------------------------------

--
-- Table structure for table `course_category`
--

CREATE TABLE `course_category` (
  `course_category_id` int(11) NOT NULL,
  `course_category_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course_category`
--

INSERT INTO `course_category` (`course_category_id`, `course_category_name`, `status`, `created_date`, `updated_date`) VALUES
(1, 'test', 0, '2022-11-07 15:26:06', '2022-11-07 15:26:06'),
(2, 'ddd', 0, '2022-11-07 15:26:10', '2022-11-07 15:26:10'),
(3, 'testing', 0, '2022-11-08 14:22:11', '2022-11-08 14:22:11'),
(10, 'testsdsdsd', 0, '2022-11-09 16:59:28', '2022-11-09 16:59:28'),
(11, 'manual', 0, '2022-11-19 16:31:15', '2022-11-19 16:31:15');

-- --------------------------------------------------------

--
-- Table structure for table `course_completion`
--

CREATE TABLE `course_completion` (
  `course_completion_id` int(11) NOT NULL,
  `applicant_name` varchar(250) DEFAULT NULL,
  `course_name` varchar(250) DEFAULT NULL,
  `course_fees` varchar(250) DEFAULT NULL,
  `amount_paid` varchar(250) DEFAULT NULL,
  `certificate` varchar(250) DEFAULT NULL,
  `insert_userid` int(11) NOT NULL,
  `update_userid` int(11) NOT NULL,
  `delete_userid` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `rating` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course_completion`
--

INSERT INTO `course_completion` (`course_completion_id`, `applicant_name`, `course_name`, `course_fees`, `amount_paid`, `certificate`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`, `rating`) VALUES
(1, '', 'TestBatch2', '1000', '500', '', 1, 0, 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '5'),
(2, '-sivabala23', 'TestBatch2', '1000', '500', '', 1, 0, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '5');

-- --------------------------------------------------------

--
-- Table structure for table `course_creation`
--

CREATE TABLE `course_creation` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `course_category` varchar(255) DEFAULT NULL,
  `course_duration` varchar(255) DEFAULT NULL,
  `course_fees` int(11) NOT NULL,
  `minimum_requirement` varchar(255) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course_creation`
--

INSERT INTO `course_creation` (`course_id`, `course_name`, `course_category`, `course_duration`, `course_fees`, `minimum_requirement`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`) VALUES
(1, 'tamil', 'hjhj', '6 months', 0, '12th', NULL, NULL, NULL, 0, '2022-11-09 12:11:19', '2022-11-09 12:11:19'),
(2, 'Eglish', 'test', '6', 0, '12th', NULL, NULL, NULL, 0, '2022-11-09 12:11:19', '2022-11-09 12:11:19'),
(4, 'TestBatch2', '10', '6m', 2147483647, '2', NULL, NULL, NULL, 0, '2022-11-09 17:50:39', '2022-11-09 17:50:39'),
(6, 'TESTINGBATCH', '3', '6m', 0, '3', NULL, NULL, NULL, 1, '2022-11-09 20:39:26', '2022-11-09 20:39:26'),
(7, 'TESTINGBATCH1', '3', '6m', 1000, '3,2,1', NULL, NULL, NULL, 0, '2022-11-09 21:14:47', '2022-11-09 21:14:47'),
(8, 'TestBatch2', '3', '1year', 0, '3,2,1', NULL, NULL, NULL, 0, '2022-11-09 21:23:13', '2022-11-09 21:23:13'),
(9, 'TESTINGBATCH', '10', '1year', 0, '3,2,1', NULL, NULL, NULL, 0, '2022-11-09 21:24:51', '2022-11-09 21:24:51'),
(10, 'TestBatch2', '3', '6m', 1000, '3,2,1', NULL, NULL, NULL, 0, '2022-11-12 18:49:14', '2022-11-12 18:49:14'),
(11, 'php', '2', '4', 23211, '3', 0, 0, 11, 0, '2022-11-19 12:40:17', '2022-11-19 12:40:17'),
(12, 'php', '3', '5', 645654, '3,2,1', 0, NULL, NULL, 1, '2022-11-19 16:29:44', '2022-11-19 16:29:44');

-- --------------------------------------------------------

--
-- Table structure for table `department_creation`
--

CREATE TABLE `department_creation` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department_creation`
--

INSERT INTO `department_creation` (`department_id`, `department_name`, `status`, `created_date`, `updated_date`) VALUES
(1, 'Science', 0, '2022-11-08 23:16:26', '2022-11-08 23:16:26'),
(2, 'Mechanical Engineering', 0, '2022-11-08 23:16:48', '2022-11-08 23:16:48'),
(3, 'Computer Science', 0, '2022-11-08 23:17:00', '2022-11-08 23:17:00');

-- --------------------------------------------------------

--
-- Table structure for table `donator_creation`
--

CREATE TABLE `donator_creation` (
  `donator_id` int(11) NOT NULL,
  `donor_name` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `address3` text DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `pan_number` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `donator_creation`
--

INSERT INTO `donator_creation` (`donator_id`, `donor_name`, `address1`, `address2`, `address3`, `place`, `pincode`, `pan_number`, `contact_number`, `email_id`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`) VALUES
(1, 'Chandru', 'test', '', '', 'test', '605004', '', '', '', NULL, NULL, NULL, 1, '2022-11-09 14:15:17', '2022-11-09 14:15:17'),
(2, 'Chandru', 'test', 'test1', 'test2', 'test', '605004', 'ASDFG1234W', '9895656895', 'test@gmail.com', NULL, NULL, NULL, 0, '2022-11-09 15:20:30', '2022-11-09 15:20:30'),
(3, 'Chandru1', 'test', 'test1', 'test2', 'test', '605004', 'ASDFG1234W', '9895656895', 'test@gmail.com', NULL, NULL, NULL, 0, '2022-11-09 21:48:17', '2022-11-09 21:48:17'),
(4, 'Chan', 'test', 'test1', 'test2', 'test', '605004', 'ASDFG1234W', '9895656895', 'test@gmail.com', NULL, 1, NULL, 0, '2022-11-11 15:11:12', '2022-11-11 15:11:12');

-- --------------------------------------------------------

--
-- Table structure for table `initiate_application`
--

CREATE TABLE `initiate_application` (
  `application_id` int(11) NOT NULL,
  `application_number` varchar(250) DEFAULT NULL,
  `applicant_name` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `address3` text DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `course_required_to_appear` varchar(255) DEFAULT NULL,
  `institute_like_to_appear` varchar(255) DEFAULT NULL,
  `course_fees` varchar(255) DEFAULT NULL,
  `course_duration` varchar(255) DEFAULT NULL,
  `scholarship_avail` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `father_occupation` varchar(255) DEFAULT NULL,
  `father_income` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `course_completion` varchar(255) DEFAULT NULL,
  `certificate` varchar(255) DEFAULT NULL,
  `initiate_image` varchar(250) DEFAULT NULL,
  `minimum_requirement` varchar(250) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `initiate_application`
--

INSERT INTO `initiate_application` (`application_id`, `application_number`, `applicant_name`, `address1`, `address2`, `address3`, `place`, `pincode`, `contact_number`, `email_id`, `course_required_to_appear`, `institute_like_to_appear`, `course_fees`, `course_duration`, `scholarship_avail`, `father_name`, `father_occupation`, `father_income`, `mother_name`, `course_completion`, `certificate`, `initiate_image`, `minimum_requirement`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`) VALUES
(7, 'GRANT002', 'siva', 'test', 'test1', 'test', 'test', '600450', '7845421245', 'test@gmail.com', 'tamil', 'vcc', '10000', '6m', 'Full', 'test', 'test', '1000', 'test', 'B.Sc', '', '', '', NULL, NULL, NULL, 0, '2022-11-11 10:01:14', '2022-11-11 10:01:14'),
(11, 'GRANT006', 'sivabala', 'test', 'test1', '', '', '', '', '', 'English', 'mcc', '2000', '1y', 'Partial', '', '', '', '', '', '', '', '', NULL, NULL, NULL, 0, '2022-11-11 10:26:02', '2022-11-11 10:26:02'),
(12, 'GRANT007', 'sivabala2', 'test', 'test1', '', 'test', '', '', '', 'maths', 'bcc', '3000', '6m', 'Partial', '', '', '', '', '', '', '', '', NULL, NULL, NULL, 0, '2022-11-11 10:30:58', '2022-11-11 10:30:58'),
(20, 'GRANT008', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', 'uploads/applicant_photo/certificate/', '', '', 1, NULL, NULL, 0, '2022-11-14 10:09:17', '2022-11-14 10:09:17'),
(21, 'GRANT009', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', 'uploads/applicant_photo/certificate/', '', '', 1, NULL, NULL, 0, '2022-11-14 14:56:45', '2022-11-14 14:56:45'),
(22, 'GRANT010', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', 'uploads/applicant_photo/certificate/', '', '', 1, NULL, NULL, 0, '2022-11-14 15:04:04', '2022-11-14 15:04:04'),
(23, 'GRANT011', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', 'uploads/applicant_photo/certificate/', '', '', 1, NULL, NULL, 0, '2022-11-14 15:04:30', '2022-11-14 15:04:30'),
(24, 'GRANT012', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', 'uploads/applicant_photo/certificate/', '', '', 1, NULL, NULL, 0, '2022-11-14 15:41:47', '2022-11-14 15:41:47'),
(25, '', 'sivabala2', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:43:12', '2022-11-14 15:43:12'),
(26, '', 'siva', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:46:42', '2022-11-14 15:46:42'),
(27, '', 'siva', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:47:58', '2022-11-14 15:47:58'),
(28, '', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:48:52', '2022-11-14 15:48:52'),
(29, '', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:49:14', '2022-11-14 15:49:14'),
(30, '', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:49:22', '2022-11-14 15:49:22'),
(31, '', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:50:11', '2022-11-14 15:50:11'),
(32, '', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:50:19', '2022-11-14 15:50:19'),
(33, '', '', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:56:10', '2022-11-14 15:56:10'),
(34, '', 'siva', 'test', 'test1', '', '', '', '5464564654', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:56:34', '2022-11-14 15:56:34'),
(35, '', 'sivabala2', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 15:57:20', '2022-11-14 15:57:20'),
(36, '', 'sivabala23', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', 'D:xam	mpphpFC41.tmp', '', '', 1, NULL, NULL, 0, '2022-11-14 16:01:59', '2022-11-14 16:01:59'),
(37, '', 'sivabala23', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', 'D:xam	mpphpB780.tmp', '', '', 1, NULL, NULL, 0, '2022-11-14 16:03:52', '2022-11-14 16:03:52'),
(38, '', 'siva', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 16:28:51', '2022-11-14 16:28:51'),
(39, '', 'siva', '', '', '', '', '', '', '', '', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 16:29:36', '2022-11-14 16:29:36'),
(40, '', 'siva', '', '', '', '', '', '', '', '1', '', '', '', 'Full', '', '', '', '', '', '', '', '', 1, NULL, NULL, 0, '2022-11-14 16:32:32', '2022-11-14 16:32:32');

-- --------------------------------------------------------

--
-- Table structure for table `institute_creation`
--

CREATE TABLE `institute_creation` (
  `institute_id` int(11) NOT NULL,
  `institute_name` varchar(255) DEFAULT NULL,
  `course_offered` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `address3` text DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `spoc` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `instalment_agree` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `ifsc_code` varchar(255) DEFAULT NULL,
  `account_holder_name` varchar(255) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `institute_creation`
--

INSERT INTO `institute_creation` (`institute_id`, `institute_name`, `course_offered`, `address1`, `address2`, `address3`, `place`, `pincode`, `spoc`, `contact_number`, `email_id`, `website`, `instalment_agree`, `account_number`, `bank_name`, `ifsc_code`, `account_holder_name`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`) VALUES
(1, 'Vcc Coaching Center', '1,6', 'ts', 'ts', 'ts', 'ts', '656235', 'tes', '7845215478', 'test@gmail.com', 'vcc.in', 'yes', '78548754784', 'stae', 'huujhghgh', 'hjhjhj', NULL, NULL, NULL, 0, '2022-11-09 12:09:42', '2022-11-09 12:09:42'),
(2, 'Mother Coaching Center', '1,2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2022-11-09 12:09:42', '2022-11-09 12:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `institute_review`
--

CREATE TABLE `institute_review` (
  `institute_review_id` int(11) NOT NULL,
  `ins_applicant_id` varchar(255) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `course_required` varchar(255) DEFAULT NULL,
  `course_fees` varchar(255) DEFAULT NULL,
  `review_date` varchar(255) DEFAULT NULL,
  `course_completion` varchar(255) DEFAULT NULL,
  `certification_view` varchar(255) DEFAULT NULL,
  `com_person1` text DEFAULT NULL,
  `com_person2` text DEFAULT NULL,
  `ins_person1` text DEFAULT NULL,
  `batch_start_date` varchar(255) DEFAULT NULL,
  `instalment_start_date` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `institute_review`
--

INSERT INTO `institute_review` (`institute_review_id`, `ins_applicant_id`, `insert_userid`, `update_userid`, `delete_userid`, `course_required`, `course_fees`, `review_date`, `course_completion`, `certification_view`, `com_person1`, `com_person2`, `ins_person1`, `batch_start_date`, `instalment_start_date`, `status`, `created_date`, `updated_date`) VALUES
(1, NULL, 1, NULL, NULL, 'English', '2000', '', 'B.Sc', NULL, 'test', 'test', 'test', '2022-11-14', '2022-11-14', 0, '2022-11-14 11:49:47', '2022-11-14 11:49:47'),
(2, NULL, 1, NULL, NULL, 'tamil', '1000', '', 'B.Sc', NULL, 'dfsdfasdf', 'sdfsadfasdf', 'sdfsadfsadf', '2022-11-16', '2022-11-16', 0, '2022-11-14 11:54:27', '2022-11-14 11:54:27'),
(3, '5', 1, NULL, 1, 'tamil', '1000', '2022-11-14', 'B.Sc', NULL, 'testtttt', 'testttt', 'dfgdfgdfgdf', '2022-11-15', '2022-11-15', 1, '2022-11-14 12:32:28', '2022-11-14 12:32:28'),
(4, '5', 1, NULL, 1, 'tamil', '1000', '2022-11-17', 'B.Sc', NULL, 'rdsfgdsfgdf', 'dfgdsfgdsfg', 'dfgdsfgdsfgd', '2022-11-15', '2022-11-09', 1, '2022-11-14 12:50:36', '2022-11-14 12:50:36'),
(5, 'GRANT002-siva', 1, 1, NULL, 'tamil', '1000', '2022-11-16', 'B.Sc', NULL, 'cxvdxcxv', 'xcvxcvxc', 'xcvxcvxc', '2022-11-16', '2022-11-16', 0, '2022-11-15 10:21:55', '2022-11-15 10:21:55'),
(6, '', 1, NULL, NULL, '', '', '', '', NULL, '', '', 'dfsdfsadf', '', '', 0, '2022-11-15 10:38:15', '2022-11-15 10:38:15'),
(7, '', 1, NULL, NULL, '', '', '', '', NULL, '', '', 'hjghjgh', '', '', 0, '2022-11-15 10:39:28', '2022-11-15 10:39:28');

-- --------------------------------------------------------

--
-- Table structure for table `minimum_requirement`
--

CREATE TABLE `minimum_requirement` (
  `minimum_requirement_id` int(11) NOT NULL,
  `minimum_requirement_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `minimum_requirement`
--

INSERT INTO `minimum_requirement` (`minimum_requirement_id`, `minimum_requirement_name`, `status`, `created_date`, `updated_date`) VALUES
(1, 'test', 0, '2022-11-07 17:39:07', '2022-11-07 17:39:07'),
(2, 'eee1', 0, '2022-11-07 17:39:11', '2022-11-07 17:39:11'),
(3, 'testing', 0, '2022-11-08 12:05:23', '2022-11-08 12:05:23');

-- --------------------------------------------------------

--
-- Table structure for table `seeker_registration`
--

CREATE TABLE `seeker_registration` (
  `seeker_id` int(11) NOT NULL,
  `applicant_name` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `address3` date DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seeker_registration`
--

INSERT INTO `seeker_registration` (`seeker_id`, `applicant_name`, `contact_number`, `address1`, `address2`, `address3`, `place`, `pincode`, `email_id`, `user_name`, `password`, `status`, `created_date`, `updated_date`) VALUES
(1, 'tet', '3423432432', 'Car Street', '', '0000-00-00', 'test', '342342', 'test@gmail.com', 'test@gmail.com', '3423432432', 0, '2022-11-07 17:55:48', '2022-11-07 17:55:48'),
(2, 'tet', '3243243243', 'Car Street', '', '0000-00-00', 'test', '342342', 'test@gmail.com', 'test@gmail.com', '3243243243', 0, '2022-11-07 18:32:04', '2022-11-07 18:32:04'),
(3, 'tet', '3243243243', 'Car Street', '', '0000-00-00', 'test', '342342', 'test@gmail.com', 'test@gmail.com', '3243243243', 0, '2022-11-07 18:33:45', '2022-11-07 18:33:45'),
(4, 'tet', '3424324234', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3424324234', 0, '2022-11-07 18:33:55', '2022-11-07 18:33:55'),
(5, 'tet', '3242342342', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3242342342', 0, '2022-11-07 18:37:22', '2022-11-07 18:37:22'),
(6, 'tet', '3423423423', 'Car Street', '', '0000-00-00', 'test', '234324', 'test@gmail.com', 'test@gmail.com', '3423423423', 0, '2022-11-07 18:39:11', '2022-11-07 18:39:11'),
(7, 'tet', '4234234234', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '4234234234', 0, '2022-11-07 18:41:11', '2022-11-07 18:41:11'),
(8, 'tet', '4234234234', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '4234234234', 0, '2022-11-07 18:42:00', '2022-11-07 18:42:00'),
(9, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:42:29', '2022-11-07 18:42:29'),
(10, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:42:47', '2022-11-07 18:42:47'),
(11, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:43:06', '2022-11-07 18:43:06'),
(12, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:43:17', '2022-11-07 18:43:17'),
(13, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:43:38', '2022-11-07 18:43:38'),
(14, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:43:53', '2022-11-07 18:43:53'),
(15, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:44:06', '2022-11-07 18:44:06'),
(16, 'tet', '3423423424', 'Car Street', '', '0000-00-00', 'test', '234234', 'test@gmail.com', 'test@gmail.com', '3423423424', 0, '2022-11-07 18:44:21', '2022-11-07 18:44:21');

-- --------------------------------------------------------

--
-- Table structure for table `staff_creation`
--

CREATE TABLE `staff_creation` (
  `staff_id` int(11) NOT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `address3` text DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `in_committee` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `ifsc_code` varchar(255) DEFAULT NULL,
  `account_holder_name` varchar(255) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `staff_image` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff_creation`
--

INSERT INTO `staff_creation` (`staff_id`, `staff_name`, `department`, `address1`, `address2`, `address3`, `place`, `pincode`, `contact_person`, `contact_number`, `email_id`, `in_committee`, `account_number`, `bank_name`, `ifsc_code`, `account_holder_name`, `insert_userid`, `update_userid`, `delete_userid`, `staff_image`, `status`, `created_date`, `updated_date`) VALUES
(1, 'siva', 'Computer Science', 'test', 'test1', 'test2', 'test', '605004', 'bala', '9855548784', 'test@gmail.com', 'Yes', '87854845454', 'Statebank', 'IBOO0123456', 'siva', NULL, NULL, NULL, 'check.png', 0, '2022-11-08 23:18:05', '2022-11-08 23:18:05'),
(2, 'Balamurugan', 'Science', 'test', 'test1', 'test2', 'test', '605010', 'siva', '9865647548', 'testing@gmail.com', 'No', '15487842487', 'Statebank', 'IBOO0123456', 'siva', NULL, NULL, NULL, 'wrong.png', 0, '2022-11-08 23:20:30', '2022-11-08 23:20:30'),
(3, 'Maha', 'Computer Science', 'test', 'test1', 'test2', 'test', '265989', 'priya', '6898656978', 'test@gmail.com', 'Yes', '57878524545', 'Statebank', 'IBOO0123456', 'siva', NULL, NULL, NULL, 'check.png', 0, '2022-11-09 09:35:43', '2022-11-09 09:35:43'),
(5, 'jayasri', 'Computer Science', 'test', '', '', 'test', '554545', 'bala', '5487454545', 'test@gmail.com', 'Yes', '58784548754', 'Statebank', 'IBOO0123456', 'siva', NULL, NULL, NULL, 'check.png', 0, '2022-11-09 11:51:23', '2022-11-09 11:51:23'),
(6, 'Balamurugan', 'Science', 'test', '', '', 'test', '548787', 'bala', '5787454878', 'test@gmail.com', 'Yes', '78744787454', 'Statebank', 'IBOO0123456', 'siva', 1, 1, NULL, '', 0, '2022-11-12 20:55:20', '2022-11-12 20:55:20');

-- --------------------------------------------------------

--
-- Table structure for table `trustee_creation`
--

CREATE TABLE `trustee_creation` (
  `trustee_id` int(11) NOT NULL,
  `trustee_name` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `address3` text DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `pan_number` varchar(255) DEFAULT NULL,
  `trustee_image` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trustee_creation`
--

INSERT INTO `trustee_creation` (`trustee_id`, `trustee_name`, `contact_number`, `address1`, `address2`, `address3`, `place`, `pincode`, `email_id`, `pan_number`, `trustee_image`, `status`, `created_date`, `updated_date`) VALUES
(2, 'test', '3424234234', 'Car Street33', '', '', 'test12', '234324', 'test@gmail.com', 'ABCDE1234F', 'WIN_20210708_17_49_13_Pro.jpg', 1, '2022-11-05 17:51:28', '2022-11-05 17:51:28'),
(3, '', '', '', '', '', '', '', '', '', '', 0, '2022-11-09 16:35:27', '2022-11-09 16:35:27');

-- --------------------------------------------------------

--
-- Table structure for table `trust_creation`
--

CREATE TABLE `trust_creation` (
  `trust_id` int(11) NOT NULL,
  `trust_name` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `address3` text DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `pan_number` varchar(255) DEFAULT NULL,
  `tan_number` varchar(255) DEFAULT NULL,
  `trust_logo` varchar(255) DEFAULT NULL,
  `insert_userid` int(11) DEFAULT NULL,
  `update_userid` int(11) DEFAULT NULL,
  `delete_userid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trust_creation`
--

INSERT INTO `trust_creation` (`trust_id`, `trust_name`, `contact_person`, `contact_number`, `address1`, `address2`, `address3`, `place`, `pincode`, `email_id`, `website`, `pan_number`, `tan_number`, `trust_logo`, `insert_userid`, `update_userid`, `delete_userid`, `status`, `created_date`, `updated_date`) VALUES
(11, 'siva1', 'bala1', '7845784548', 'test1', 'test11', 'test21', 'test1', '605004', 'testing@gmail.com', 'testing.in', 'MLKJA1234E', 'QWERT12345', 'check.png', NULL, NULL, NULL, 0, '2022-11-05 16:25:06', '2022-11-05 16:25:06'),
(13, 'sivabala', 'bala', '9898989989', 'test', '', '', 'test', '888787', '', '', '', '', '', NULL, NULL, NULL, 1, '2022-11-05 16:31:54', '2022-11-05 16:31:54'),
(14, 'sivabarathi', 'bala', '5487854545', 'test', 'test1', 'test2', 'test', '698989', 'testing@gmail.com', 'testing.in', 'LKIJU1234Q', 'LKJHG12345', 'check.png', NULL, NULL, NULL, 0, '2022-11-09 11:09:56', '2022-11-09 11:09:56'),
(15, 'siva', 'bala', '6548787545', 'test', '', '', 'testing', '587875', '', '', '', '', '', NULL, NULL, NULL, 0, '2022-11-09 11:21:29', '2022-11-09 11:21:29'),
(16, 'siva', 'bala', '5487545455', 'test', '', '', 'sssss', '878754', '', '', '', '', '', NULL, NULL, NULL, 0, '2022-11-09 11:27:28', '2022-11-09 11:27:28'),
(17, 'sivas', 'bala', '3214754545', 'test', '', '', 'test1', '545454', '', '', '', '', '', NULL, NULL, NULL, 0, '2022-11-09 11:28:35', '2022-11-09 11:28:35'),
(18, 'sarasu', 'bala', '2455121212', 'test', 'test1', 'test2', 'testing', '356565', 'chandru@gmai.com', 'test.in', 'ASDFG1234W', 'LKJHG12345', 'wrong.png', NULL, NULL, NULL, 0, '2022-11-09 11:30:10', '2022-11-09 11:30:10'),
(19, 'siva', 'bala', '4578421545', 'test', '', '', 'test', '658785', '', '', '', '', '', NULL, NULL, NULL, 0, '2022-11-09 16:54:18', '2022-11-09 16:54:18'),
(20, 'Arun', 'arun', '7373737373', '58A,Rathinam salai, Pugalur road', '', '', 'krr', '639001', '', '', '', '', '7.jpg', 1, NULL, NULL, 0, '2022-11-17 22:00:44', '2022-11-17 22:00:44'),
(21, 'Arun', 'arun', '7373737373', '58A,Rathinam salai, Pugalur road', '', '', 'krr', '639001', '', '', '', '', '7.jpg', 1, NULL, NULL, 0, '2022-11-17 22:04:53', '2022-11-17 22:04:53');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `emailid` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `Createddate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `firstname`, `lastname`, `fullname`, `title`, `emailid`, `user_name`, `user_password`, `role`, `status`, `Createddate`) VALUES
(1, 'Super', 'Admin', 'Super Admin', 'Super Admin', 'support@feathertechnology.in', 'support@feathertechnology.in', 'admin@123', '1', '0', '2021-04-17 17:08:00'),
(18, 'Admin2', 'admin', 'Super Admin2', 'test', 'test@gmil.com', 'test@gmail.com', 'test@123', '1', '0', '2022-11-09 11:19:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `candidate_details`
--
ALTER TABLE `candidate_details`
  ADD PRIMARY KEY (`candidate_details_id`);

--
-- Indexes for table `committee_creation`
--
ALTER TABLE `committee_creation`
  ADD PRIMARY KEY (`committee_id`);

--
-- Indexes for table `committee_review`
--
ALTER TABLE `committee_review`
  ADD PRIMARY KEY (`committee_review_id`);

--
-- Indexes for table `confirmation`
--
ALTER TABLE `confirmation`
  ADD PRIMARY KEY (`confirmation_id`);

--
-- Indexes for table `course_category`
--
ALTER TABLE `course_category`
  ADD PRIMARY KEY (`course_category_id`);

--
-- Indexes for table `course_completion`
--
ALTER TABLE `course_completion`
  ADD PRIMARY KEY (`course_completion_id`);

--
-- Indexes for table `course_creation`
--
ALTER TABLE `course_creation`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `department_creation`
--
ALTER TABLE `department_creation`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `donator_creation`
--
ALTER TABLE `donator_creation`
  ADD PRIMARY KEY (`donator_id`);

--
-- Indexes for table `initiate_application`
--
ALTER TABLE `initiate_application`
  ADD PRIMARY KEY (`application_id`);

--
-- Indexes for table `institute_creation`
--
ALTER TABLE `institute_creation`
  ADD PRIMARY KEY (`institute_id`);

--
-- Indexes for table `institute_review`
--
ALTER TABLE `institute_review`
  ADD PRIMARY KEY (`institute_review_id`);

--
-- Indexes for table `minimum_requirement`
--
ALTER TABLE `minimum_requirement`
  ADD PRIMARY KEY (`minimum_requirement_id`);

--
-- Indexes for table `seeker_registration`
--
ALTER TABLE `seeker_registration`
  ADD PRIMARY KEY (`seeker_id`);

--
-- Indexes for table `staff_creation`
--
ALTER TABLE `staff_creation`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `trustee_creation`
--
ALTER TABLE `trustee_creation`
  ADD PRIMARY KEY (`trustee_id`);

--
-- Indexes for table `trust_creation`
--
ALTER TABLE `trust_creation`
  ADD PRIMARY KEY (`trust_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `candidate_details`
--
ALTER TABLE `candidate_details`
  MODIFY `candidate_details_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `committee_creation`
--
ALTER TABLE `committee_creation`
  MODIFY `committee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `committee_review`
--
ALTER TABLE `committee_review`
  MODIFY `committee_review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `confirmation`
--
ALTER TABLE `confirmation`
  MODIFY `confirmation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `course_category`
--
ALTER TABLE `course_category`
  MODIFY `course_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `course_completion`
--
ALTER TABLE `course_completion`
  MODIFY `course_completion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `course_creation`
--
ALTER TABLE `course_creation`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `department_creation`
--
ALTER TABLE `department_creation`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `donator_creation`
--
ALTER TABLE `donator_creation`
  MODIFY `donator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `initiate_application`
--
ALTER TABLE `initiate_application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `institute_creation`
--
ALTER TABLE `institute_creation`
  MODIFY `institute_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `institute_review`
--
ALTER TABLE `institute_review`
  MODIFY `institute_review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `seeker_registration`
--
ALTER TABLE `seeker_registration`
  MODIFY `seeker_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `staff_creation`
--
ALTER TABLE `staff_creation`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `trustee_creation`
--
ALTER TABLE `trustee_creation`
  MODIFY `trustee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `trust_creation`
--
ALTER TABLE `trust_creation`
  MODIFY `trust_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
