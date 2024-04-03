-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2024 at 02:27 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marudham`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_db_data_from_req` ()   BEGIN
TRUNCATE `acknowledgement_loan_cal_category`;
TRUNCATE `acknowlegement_customer_profile`;
TRUNCATE `acknowlegement_documentation`;
TRUNCATE `acknowlegement_loan_calculation`;
TRUNCATE `bank_stmt`;
TRUNCATE `cash_tally`;
TRUNCATE `cheque_info`;
TRUNCATE `cheque_no_list`;
TRUNCATE `cheque_upd`;
TRUNCATE `closed_status`;
TRUNCATE `collection`;
TRUNCATE `collection_charges`;
TRUNCATE `commitment`;
TRUNCATE `concern_creation`;
TRUNCATE `concern_subject`;
TRUNCATE `confirmation_followup`;
TRUNCATE `ct_bank_collection`;
TRUNCATE `ct_cr_bag`;
TRUNCATE `ct_cr_bank_withdraw`;
TRUNCATE `ct_cr_bdeposit`;
TRUNCATE `ct_cr_bel`;
TRUNCATE `ct_cr_bexchange`;
TRUNCATE `ct_cr_binvest`;
TRUNCATE `ct_cr_boti`;
TRUNCATE `ct_cr_cash_deposit`;
TRUNCATE `ct_cr_hag`;
TRUNCATE `ct_cr_hdeposit`;
TRUNCATE `ct_cr_hel`;
TRUNCATE `ct_cr_hexchange`;
TRUNCATE `ct_cr_hinvest`;
TRUNCATE `ct_cr_hoti`;
TRUNCATE `ct_db_bag`;
TRUNCATE `ct_db_bank_deposit`;
TRUNCATE `ct_db_bdeposit`;
TRUNCATE `ct_db_bel`;
TRUNCATE `ct_db_bexchange`;
TRUNCATE `ct_db_bexpense`;
TRUNCATE `ct_db_binvest`;
TRUNCATE `ct_db_bissued`;
TRUNCATE `ct_db_cash_withdraw`;
TRUNCATE `ct_db_exf`;
TRUNCATE `ct_db_hag`;
TRUNCATE `ct_db_hdeposit`;
TRUNCATE `ct_db_hel`;
TRUNCATE `ct_db_hexchange`;
TRUNCATE `ct_db_hexpense`;
TRUNCATE `ct_db_hinvest`;
TRUNCATE `ct_db_hissued`;
TRUNCATE `ct_hand_collection`;
TRUNCATE `customer_profile`;
TRUNCATE `customer_register`;
TRUNCATE `cus_old_data`;
TRUNCATE `document_info`;
TRUNCATE `document_track`;
TRUNCATE `doc_mapping`;
TRUNCATE `fingerprints`;
TRUNCATE `gold_info`;
TRUNCATE `in_acknowledgement`;
TRUNCATE `in_approval`;
TRUNCATE `in_issue`;
TRUNCATE `in_verification`;
TRUNCATE `loan_followup`;
TRUNCATE `loan_issue`;
TRUNCATE `loan_summary_feedback`;
TRUNCATE `name_detail_creation`;
TRUNCATE `new_cus_promo`;
TRUNCATE `new_promotion`;
TRUNCATE `noc`;
TRUNCATE `penalty_charges`;
TRUNCATE `request_category_info`;
TRUNCATE `request_creation`;
TRUNCATE `signed_doc`;
TRUNCATE `signed_doc_info`;
TRUNCATE `verification_bank_info`;
TRUNCATE `verification_cus_feedback`;
TRUNCATE `verification_documentation`;
TRUNCATE `verification_family_info`;
TRUNCATE `verification_group_info`;
TRUNCATE `verification_kyc_info`;
TRUNCATE `verification_loan_calculation`;
TRUNCATE `verification_property_info`;
TRUNCATE `verif_loan_cal_category`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_till_collection` (IN `reqid` VARCHAR(20))   BEGIN
    DELETE FROM `request_creation` WHERE req_id = reqid;
    DELETE FROM `request_category_info` WHERE req_ref_id = reqid;
    DELETE FROM `customer_register` WHERE req_ref_id = reqid;
    DELETE FROM `in_verification` WHERE req_id = reqid;
    DELETE FROM `verification_family_info` WHERE req_id = reqid;
    DELETE FROM `customer_profile` WHERE req_id = reqid;
    DELETE FROM `verification_documentation` WHERE req_id = reqid;
    DELETE FROM `verification_loan_calculation` WHERE req_id = reqid;
    DELETE FROM `verif_loan_cal_category` WHERE req_id = reqid;
    DELETE FROM `in_approval` WHERE req_id = reqid;
    DELETE FROM `in_acknowledgement` WHERE req_id = reqid;
    DELETE FROM `acknowlegement_customer_profile` WHERE req_id = reqid;
    DELETE FROM `acknowlegement_documentation` WHERE req_id = reqid;
    DELETE FROM `acknowlegement_loan_calculation` WHERE req_id = reqid;
    DELETE FROM `acknowledgement_loan_cal_category` WHERE req_id = reqid;
    DELETE FROM `in_issue` WHERE req_id = reqid;
    DELETE FROM `document_track` WHERE req_id = reqid;
    DELETE FROM `loan_issue` WHERE req_id = reqid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cus_name` (IN `cusid` VARCHAR(20))  NO SQL SELECT customer_name from customer_register WHERE cus_id = cusid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_kyc_guarentor` (IN `reqid` VARCHAR(20))  NO SQL SELECT a.famname,a.relationship from verification_family_info a 
LEFT JOIN customer_profile b ON a.id = b.guarentor_name
where b.req_id = reqid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_loan_id` (IN `reqid` VARCHAR(20))   SELECT loan_id from in_issue WHERE req_id = reqid$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `acknowledgement_loan_cal_category`
--

CREATE TABLE `acknowledgement_loan_cal_category` (
  `cat_id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `loan_cal_id` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `acknowledgement_loan_cal_category`
--

INSERT INTO `acknowledgement_loan_cal_category` (`cat_id`, `req_id`, `loan_cal_id`, `category`) VALUES
(4, '2', '8', 'Micromax'),
(5, '2', '8', '40'),
(6, '2', '8', 'LED'),
(17, '6', '10', 'Samsung'),
(18, '6', '10', '6inch'),
(22, '5', '11', 'Bajaj'),
(23, '5', '11', 'CBR'),
(27, '7', '12', 'ABC'),
(28, '7', '12', '1styear'),
(29, '8', '13', '8500'),
(30, '1', '14', 'Carrier'),
(31, '1', '14', '1ton'),
(32, '1', '14', 'Split'),
(33, '11', '15', '7500'),
(38, '12', '17', '25000'),
(40, '10', '18', '8500'),
(41, '9', '16', 'Carrier'),
(42, '9', '16', '1ton'),
(43, '9', '16', 'Split'),
(44, '16', '19', '1000 500'),
(45, '16', '19', '5000 sqft'),
(46, '16', '19', '1680000'),
(47, '18', '20', 'Bajaj'),
(48, '18', '20', 'Pulsar 150'),
(49, '21', '21', 'Apple'),
(50, '21', '21', '6 11'),
(51, '22', '22', 'VAO'),
(52, '22', '22', '1'),
(53, '22', '22', '1'),
(54, '24', '24', 'Check'),
(55, '24', '24', 'Check'),
(57, '23', '23', 'Check'),
(58, '23', '23', 'Check'),
(64, '77', '32', '10000'),
(65, '78', '33', '10000'),
(66, '79', '34', '10000'),
(69, '84', '39', '10000'),
(70, '14', '40', 'Fridge'),
(71, '14', '40', 'Fridge'),
(72, '87', '41', '10000'),
(73, '88', '42', '80000');

-- --------------------------------------------------------

--
-- Table structure for table `acknowlegement_customer_profile`
--

CREATE TABLE `acknowlegement_customer_profile` (
  `id` int(11) NOT NULL,
  `req_id` varchar(50) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_name` varchar(255) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `blood_group` varchar(50) DEFAULT NULL,
  `mobile1` varchar(50) DEFAULT NULL,
  `mobile2` varchar(50) DEFAULT NULL,
  `whatsapp` varchar(50) DEFAULT NULL,
  `cus_pic` varchar(255) DEFAULT NULL,
  `guarentor_name` varchar(255) DEFAULT NULL,
  `guarentor_relation` varchar(100) DEFAULT NULL,
  `guarentor_photo` varchar(255) DEFAULT NULL,
  `cus_type` varchar(50) DEFAULT NULL,
  `cus_exist_type` varchar(50) DEFAULT NULL,
  `residential_type` varchar(50) DEFAULT NULL,
  `residential_details` varchar(255) DEFAULT NULL,
  `residential_address` varchar(255) DEFAULT NULL,
  `residential_native_address` varchar(255) DEFAULT NULL,
  `occupation_type` varchar(50) DEFAULT NULL,
  `occupation_details` varchar(255) DEFAULT NULL,
  `occupation_income` varchar(255) DEFAULT NULL,
  `occupation_address` varchar(255) DEFAULT NULL,
  `dow` varchar(255) DEFAULT NULL,
  `abt_occ` varchar(255) DEFAULT NULL,
  `area_confirm_type` varchar(50) DEFAULT NULL,
  `area_confirm_state` varchar(100) DEFAULT NULL,
  `area_confirm_district` varchar(100) DEFAULT NULL,
  `area_confirm_taluk` varchar(100) DEFAULT NULL,
  `area_confirm_area` varchar(255) DEFAULT NULL,
  `area_confirm_subarea` varchar(255) DEFAULT NULL,
  `area_group` varchar(255) DEFAULT NULL,
  `area_line` varchar(255) DEFAULT NULL,
  `communication` varchar(50) DEFAULT NULL,
  `com_audio` varchar(255) DEFAULT NULL,
  `verification_person` varchar(255) DEFAULT NULL,
  `verification_location` varchar(255) DEFAULT NULL,
  `cus_status` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(100) DEFAULT NULL,
  `update_login_id` varchar(100) DEFAULT NULL,
  `delete_login_id` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `acknowlegement_customer_profile`
--

INSERT INTO `acknowlegement_customer_profile` (`id`, `req_id`, `cus_id`, `cus_name`, `gender`, `dob`, `age`, `blood_group`, `mobile1`, `mobile2`, `whatsapp`, `cus_pic`, `guarentor_name`, `guarentor_relation`, `guarentor_photo`, `cus_type`, `cus_exist_type`, `residential_type`, `residential_details`, `residential_address`, `residential_native_address`, `occupation_type`, `occupation_details`, `occupation_income`, `occupation_address`, `dow`, `abt_occ`, `area_confirm_type`, `area_confirm_state`, `area_confirm_district`, `area_confirm_taluk`, `area_confirm_area`, `area_confirm_subarea`, `area_group`, `area_line`, `communication`, `com_audio`, `verification_person`, `verification_location`, `cus_status`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '2', 'Mother', 'download.jpg', 'New', '', 'Select Residential Type', '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', NULL, NULL, NULL, NULL, '10', NULL, '5', NULL, NULL, '2023-07-05 13:27:03', '2023-07-05 13:27:03'),
(2, '7', '300030003000', 'Rakesh', '1', '1992-06-09', '31', '', '9664565132', '', '', 'person_sample_4.jpg', '7', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'New', '', '0', 'MG road', 'MG road', 'MG road', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', '1', '', '300030003000', '0', '10', NULL, '5', '5', NULL, '2023-07-10 12:01:17', '2023-01-03 14:53:55'),
(3, '6', '200020002000', 'Aravind', '1', '1988-03-10', '35', '', '9794949494', '', '', 'pexels-pixabay-220453.jpg', '5', 'Brother', 'person_sample_4.jpg', 'New', '', '1', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', 'GA 1', 'LA1', '1', '', '5', '1', '10', NULL, '2', '2', NULL, '2023-07-10 13:17:06', '2023-07-10 18:26:49'),
(4, '5', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '3', 'Brother', 'pexels-pixabay-220453.jpg', 'Existing', 'Renewal', 'Select Residential Type', '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', '1', '', '3', '0', '10', NULL, '2', '2', NULL, '2023-01-13 10:13:19', '2023-01-13 10:53:21'),
(5, '8', '200020002000', 'Aravind', '1', '1988-03-10', '35', '', '9794949494', '', '', 'pexels-pixabay-220453.jpg', '6', 'Mother', 'Anna_square.jpg', 'Existing', 'Renewal', '1', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-07-15 11:23:54', '2023-07-15 11:23:54'),
(6, '9', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '1', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'Existing', 'Renewal', 'Select Residential Type', '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', '1', '', '100010001000', '0', '10', NULL, '5', '2', NULL, '2023-07-17 18:26:00', '2023-09-05 15:17:44'),
(7, '1', '010720232023', 'Bharath', '1', '1990-02-03', '33', '', '9846546546', '', '', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '8', 'Father', 'depositphotos_12196477-stock-photo-smiling-men-isolated-on-the.jpg', 'New', '', 'Select Residential Type', '', '', '', '1', 'VOA', '18000', '45', '2', 'VOA', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '5', 'Apple', 'Banana 1', NULL, NULL, NULL, NULL, '10', NULL, '3', NULL, NULL, '2023-07-18 18:28:21', '2023-07-18 18:28:21'),
(8, '11', '500050005000', 'Manikandan', '1', '1995-03-02', '28', '', '7888878888', '', '', 'musk.jpg', '9', 'Father', 'construction-worker-screaming-terror-27263479.webp', 'New', '', 'Select Residential Type', '', '', '', '5', 'Watchman', '7500', 'Harington', '2', 'ATM', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-07-21 11:17:06', '2023-07-21 11:17:06'),
(9, '12', '400040004000', 'Bharathi', '1', '1999-01-21', '24', '', '9459416164', '994949494', '', 'images (1).jpg', '11', 'Father', 'istockphoto-1167529858-612x612.jpg', 'New', '', '0', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '17', 'GA 1', 'LA1', '1', '', '400040004000', '0', '10', NULL, '2', '2', NULL, '2023-08-02 15:06:09', '2023-08-02 15:12:05'),
(10, '10', '300030003000', 'Rakesh', '1', '1992-06-09', '31', '', '9664565132', '', '', 'person_sample_4.jpg', '7', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'Existing', 'Additional', '0', 'MG road', 'MG road', 'MG road', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', '1', '', '300030003000', '1', '10', NULL, '2', '2', NULL, '2023-08-07 11:06:36', '2023-08-07 12:01:23'),
(11, '16', '060120230408', 'Gnanasekar', '1', '1990-02-14', '33', '', '9790171511', '', '', 'person_sample_2.jpg', '12', 'Father', 'depositphotos_12196477-stock-photo-smiling-men-isolated-on-the.jpg', 'New', '', '1', 'sfdsf', '', '', '1', 'Opticals', '40000', 'Senguntha puram', '10years', 'Optical store', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '3', 'Apple', 'Banana 2', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-09-07 15:30:35', '2023-09-07 15:30:35'),
(12, '14', '200020002000', 'Aravind', '1', '1988-03-10', '35', '', '9794949494', '', '', 'pexels-pixabay-220453.jpg', '6', 'Mother', 'Anna_square.jpg', 'Existing', 'Additional', '1', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-09-09 18:37:00', '2023-09-09 18:37:00'),
(13, '18', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '1', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'Existing', 'Additional', 'Select Residential Type', '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-09-06 12:11:26', '2023-09-06 12:11:26'),
(14, '21', '261910026191', 'Leo Das', '1', '1999-04-27', '25', '', '2619100261', '', '', '658bc19b427cb.jpg', '14', 'Father', '658d05aa0f542.jpg', 'New', '', '0', 'Own', 'Bussy street', 'pondicherry', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-12-28 10:50:42', '2023-12-28 10:50:42'),
(15, '22', '000000000001', 'Senthil kumaran', '1', '1999-02-02', '25', '', '7526312546', '', '', '6593e1b875db5.png', '15', 'Father', '6593e293c4e64.jpg', 'New', '', '', '', '', '', '1', 'VAO', '1', 'CT', '1', 'VAo', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-02 15:46:51', '2024-01-02 15:46:51'),
(16, '23', '000000000001', 'Senthil kumaran', '1', '1999-02-02', '25', '', '7526312546', '', '', '6593e1b875db5.png', '15', 'Father', '6593e293c4e64.jpg', 'Existing', 'Additional', '', '', '', '', '1', 'VAO', '1', 'CT', '1', 'VAo', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-06 11:28:43', '2024-01-06 11:28:43'),
(17, '24', '000000000001', 'Senthil kumaran', '1', '1999-02-02', '25', '', '7526312546', '', '', '6593e1b875db5.png', '15', 'Father', '6593e293c4e64.jpg', 'Existing', 'Additional', '', '', '', '', '1', 'VAO', '1', 'CT', '1', 'VAo', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-06 11:30:07', '2024-01-06 11:30:07'),
(25, '77', '123412341234', 'Rajesh', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '', '23', 'Spouse', '', 'New', '', '0', 'Illam', '25, Gandhi  road', '', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(26, '78', '474747474747', 'Murugesan', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '65d6f28385849.jpg', '24', 'Spouse', '65d6f0a5d1f4c.jpg', 'New', '', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-02-22 12:36:43'),
(27, '79', '575757575757', 'Sugumaran', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '65d81ec122dbd.jpg', '25', 'Spouse', '65d81ec123488.jpg', 'New', '', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-02-23 09:57:45'),
(32, '84', '676767676767', 'Ilambarithi', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '', '30', 'Spouse', '', 'New', '', '0', 'Illam', '25, Gandhi  road', '', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(33, '87', '525252525252', 'Pooja', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '6605494c00dfe.jpg', '31', 'Spouse', '6605494c01421.jpg', 'New', '', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-03-28 16:11:16'),
(34, '88', '525252525252', 'Pooja', '1', '1994-02-20', '29', '', '7708261661', '', '', '6605494c00dfe.jpg', '31', 'Spouse', '6605494c01421.jpg', 'Existing', 'Renewal', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-03-28 16:16:33', '2024-03-28 16:16:33');

-- --------------------------------------------------------

--
-- Table structure for table `acknowlegement_documentation`
--

CREATE TABLE `acknowlegement_documentation` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id_doc` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `cus_profile_id` varchar(255) DEFAULT NULL,
  `doc_id` varchar(255) DEFAULT NULL,
  `mortgage_process` varchar(100) DEFAULT NULL,
  `mortgage_process_noc` varchar(10) NOT NULL DEFAULT '0',
  `mort_noc_date` varchar(255) DEFAULT NULL,
  `mort_noc_person` varchar(255) DEFAULT NULL,
  `mort_noc_name` varchar(255) DEFAULT NULL,
  `Propertyholder_type` varchar(100) DEFAULT NULL,
  `Propertyholder_name` varchar(255) DEFAULT NULL,
  `Propertyholder_relationship_name` varchar(100) DEFAULT NULL,
  `doc_property_relation` varchar(100) DEFAULT NULL,
  `doc_property_type` varchar(255) DEFAULT NULL,
  `doc_property_measurement` varchar(255) DEFAULT NULL,
  `doc_property_location` varchar(255) DEFAULT NULL,
  `doc_property_value` varchar(255) DEFAULT NULL,
  `mortgage_name` varchar(255) DEFAULT NULL,
  `mortgage_dsgn` varchar(255) DEFAULT NULL,
  `mortgage_nuumber` varchar(255) DEFAULT NULL,
  `reg_office` varchar(255) DEFAULT NULL,
  `mortgage_value` varchar(255) DEFAULT NULL,
  `mortgage_document` varchar(255) DEFAULT NULL,
  `mortgage_document_noc` varchar(10) NOT NULL DEFAULT '0',
  `mort_doc_noc_date` varchar(255) DEFAULT NULL,
  `mort_doc_noc_person` varchar(255) DEFAULT NULL,
  `mort_doc_noc_name` varchar(255) DEFAULT NULL,
  `mortgage_document_used` varchar(10) NOT NULL DEFAULT '0',
  `mortgage_document_upd` varchar(255) DEFAULT NULL,
  `mortgage_document_pending` varchar(150) NOT NULL DEFAULT 'YES',
  `endorsement_process` varchar(50) DEFAULT NULL,
  `endorsement_process_noc` varchar(10) NOT NULL DEFAULT '0',
  `endor_noc_date` varchar(255) DEFAULT NULL,
  `endor_noc_person` varchar(255) DEFAULT NULL,
  `endor_noc_name` varchar(255) DEFAULT NULL,
  `owner_type` varchar(100) DEFAULT NULL,
  `owner_name` varchar(200) DEFAULT NULL,
  `ownername_relationship_name` varchar(100) DEFAULT NULL,
  `en_relation` varchar(100) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `vehicle_process` varchar(50) DEFAULT NULL,
  `en_Company` varchar(200) DEFAULT NULL,
  `en_Model` varchar(200) DEFAULT NULL,
  `vehicle_reg_no` varchar(150) DEFAULT NULL,
  `endorsement_name` varchar(255) DEFAULT NULL,
  `en_RC` varchar(50) DEFAULT NULL,
  `en_RC_noc` varchar(10) NOT NULL DEFAULT '0',
  `en_rc_noc_date` varchar(255) DEFAULT NULL,
  `en_rc_noc_person` varchar(255) DEFAULT NULL,
  `en_rc_noc_name` varchar(255) DEFAULT NULL,
  `en_RC_used` varchar(10) NOT NULL DEFAULT '0',
  `Rc_document_upd` varchar(255) DEFAULT NULL,
  `Rc_document_pending` varchar(150) NOT NULL DEFAULT 'YES',
  `en_Key` varchar(50) DEFAULT NULL,
  `en_Key_noc` varchar(10) NOT NULL DEFAULT '0',
  `en_key_noc_date` varchar(255) DEFAULT NULL,
  `en_key_noc_person` varchar(255) DEFAULT NULL,
  `en_key_noc_name` varchar(255) DEFAULT NULL,
  `en_Key_used` varchar(10) NOT NULL DEFAULT '0',
  `gold_info` varchar(50) DEFAULT NULL,
  `gold_sts` varchar(50) DEFAULT NULL,
  `gold_type` varchar(255) DEFAULT NULL,
  `Purity` varchar(255) DEFAULT NULL,
  `gold_Count` varchar(255) DEFAULT NULL,
  `gold_Weight` varchar(255) DEFAULT NULL,
  `gold_Value` varchar(255) DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_details` varchar(255) DEFAULT NULL,
  `document_type` varchar(50) DEFAULT NULL,
  `doc_info_upload` varchar(255) DEFAULT NULL,
  `doc_info_upload_noc` varchar(10) NOT NULL DEFAULT '0',
  `doc_info_upload_used` varchar(10) NOT NULL DEFAULT '0',
  `document_holder` varchar(50) DEFAULT NULL,
  `docholder_name` varchar(255) DEFAULT NULL,
  `docholder_relationship_name` varchar(50) DEFAULT NULL,
  `doc_relation` varchar(50) DEFAULT NULL,
  `cus_status` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `submitted` varchar(10) DEFAULT NULL,
  `insert_login_id` varchar(50) DEFAULT NULL,
  `update_login_id` varchar(50) DEFAULT NULL,
  `delete_login_id` varchar(50) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `acknowlegement_documentation`
--

INSERT INTO `acknowlegement_documentation` (`id`, `req_id`, `cus_id_doc`, `customer_name`, `cus_profile_id`, `doc_id`, `mortgage_process`, `mortgage_process_noc`, `mort_noc_date`, `mort_noc_person`, `mort_noc_name`, `Propertyholder_type`, `Propertyholder_name`, `Propertyholder_relationship_name`, `doc_property_relation`, `doc_property_type`, `doc_property_measurement`, `doc_property_location`, `doc_property_value`, `mortgage_name`, `mortgage_dsgn`, `mortgage_nuumber`, `reg_office`, `mortgage_value`, `mortgage_document`, `mortgage_document_noc`, `mort_doc_noc_date`, `mort_doc_noc_person`, `mort_doc_noc_name`, `mortgage_document_used`, `mortgage_document_upd`, `mortgage_document_pending`, `endorsement_process`, `endorsement_process_noc`, `endor_noc_date`, `endor_noc_person`, `endor_noc_name`, `owner_type`, `owner_name`, `ownername_relationship_name`, `en_relation`, `vehicle_type`, `vehicle_process`, `en_Company`, `en_Model`, `vehicle_reg_no`, `endorsement_name`, `en_RC`, `en_RC_noc`, `en_rc_noc_date`, `en_rc_noc_person`, `en_rc_noc_name`, `en_RC_used`, `Rc_document_upd`, `Rc_document_pending`, `en_Key`, `en_Key_noc`, `en_key_noc_date`, `en_key_noc_person`, `en_key_noc_name`, `en_Key_used`, `gold_info`, `gold_sts`, `gold_type`, `Purity`, `gold_Count`, `gold_Weight`, `gold_Value`, `document_name`, `document_details`, `document_type`, `doc_info_upload`, `doc_info_upload_noc`, `doc_info_upload_used`, `document_holder`, `docholder_name`, `docholder_relationship_name`, `doc_relation`, `cus_status`, `status`, `submitted`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', '100010001000', 'Ganesan', '1', 'DOC-101', '0', '1', '2023-07-17', '1', 'Ganesan', '0', 'Ganesan', '', 'NIL', 'House', '20*10', 'Chennai', '45000', 'Aksha', 'Emp', '123465', 'Chennai', '40000', '', '0', NULL, NULL, NULL, '0', '', 'NO', '0', '0', NULL, NULL, NULL, '1', 'Aravindh', NULL, 'Brother', '0', '0', 'TVS', 'RTR', 'TN47AB1007', 'Aravindh', '1', '0', NULL, NULL, NULL, '0', '', 'YES', '0', '0', NULL, NULL, '', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '5', '5', NULL, '2023-07-06 10:14:58', '2023-07-06 10:14:58'),
(2, '6', '200020002000', 'Aravind', '3', 'DOC-102', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '0', '1', '2023-09-12', '1', 'Aravind', '0', 'Aravind', '', 'NIL', '0', '0', 'TVS', '100', 'TN47AB1005', 'Endore', '1', '0', NULL, NULL, NULL, '0', '', 'YES', '0', '1', '2023-09-12', '1', 'Aravind', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-07-10 13:17:40', '2023-07-10 13:17:40'),
(4, '5', '100010001000', 'Ganesan', '4', 'DOC-103', '0', '0', NULL, NULL, NULL, '0', 'Ganesan', '', 'NIL', 'asdf', 'asdf', 'asdf', 'asdf', 'asdf', 'asdf', 'asdf', 'asdf', 'asdf', '1', '0', NULL, NULL, NULL, '0', '', 'YES', '0', '0', NULL, NULL, NULL, '1', 'Aravindh', '', 'Brother', '0', '0', 'TVS', 'RTR', 'TN47AB1006', 'Aravindh', '1', '0', NULL, NULL, NULL, '0', '', 'YES', '0', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-01-13 10:21:06', '2023-07-24 18:56:04'),
(5, '7', '300030003000', 'Rakesh', '2', 'DOC-104', '0', '0', NULL, NULL, NULL, '0', 'Rakesh', '', 'NIL', 'House', '10*10', 'Vilupuram', '67800', 'Jeevan Shuraksha', 'Manager', '123456', 'Vilupuram', '67800', '1', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '5', '5', NULL, '2023-07-13 13:31:36', '2023-07-13 13:31:36'),
(6, '8', '200020002000', 'Aravind', '5', 'DOC-105', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-01-01 16:17:35', '2023-01-01 16:17:35'),
(7, '1', '010720232023', 'Bharath', '7', 'DOC-106', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '3', '3', NULL, '2023-07-18 18:33:48', '2023-07-18 18:33:48'),
(8, '11', '500050005000', 'Manikandan', '8', 'DOC-107', '0', '0', NULL, NULL, NULL, '2', '', '9', 'Father', 'Land', '1107*1010', 'Chetpet', '145000', 'Lando', 'NIL', '123', 'Chetpet', '100000', '1', '0', NULL, NULL, NULL, '0', '', 'YES', '0', '0', NULL, NULL, NULL, '0', 'Manikandan', '', 'NIL', '0', '0', 'Bajaj', 'Platina', '123131', 'Vehicle', '0', '0', NULL, NULL, NULL, '0', 'sample1.pdf', 'NO', '0', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-07-21 12:15:37', '2023-07-25 10:33:36'),
(9, '9', '100010001000', 'Ganesan', '6', 'DOC-108', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '5', '2', NULL, '2023-07-27 13:18:50', '2023-07-27 13:18:50'),
(10, '12', '400040004000', 'Bharathi', '9', 'DOC-109', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-08-02 15:06:24', '2023-08-02 15:06:24'),
(11, '10', '300030003000', 'Rakesh', '10', 'DOC-110', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-08-07 11:07:01', '2023-08-07 11:07:01'),
(12, '16', '060120230408', 'Gnanasekar', '11', 'DOC-111', '0', '0', NULL, NULL, NULL, '1', 'Senthil raja', '', 'Father', 'Land', '1107*1010', 'Chetpet', '145000', 'Land', 'Land', '123', 'Karur', '200000', '0', '0', NULL, NULL, NULL, '0', 'Location.png', 'NO', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-09-07 15:31:15', '2023-09-07 15:31:15'),
(13, '18', '100010001000', 'Ganesan', '13', 'DOC-112', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2023-09-06 12:11:41', '2023-09-06 12:11:41'),
(14, '21', '261910026191', 'Leo Das', '14', 'DOC-113', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '4', NULL, '2023-12-28 10:50:58', '2023-12-28 10:50:58'),
(15, '22', '000000000001', 'Senthil kumaran', '15', 'DOC-114', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2024-01-02 15:47:01', '2024-01-02 15:47:01'),
(16, '23', '000000000001', 'Senthil kumaran', '16', 'DOC-115', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2024-01-06 11:28:54', '2024-01-06 11:28:54'),
(17, '24', '000000000001', 'Senthil kumaran', '17', 'DOC-116', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2024-01-06 11:30:16', '2024-01-06 11:30:16'),
(25, '77', '123412341234', 'Rajesh', '25', 'DOC-117', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', NULL, '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', NULL, NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(26, '78', '474747474747', 'Murugesan', '26', 'DOC-118', '0', '1', NULL, NULL, NULL, '0', 'Murugesan', '', 'NIL', '1', '1', '1', '1', 'e', 'e', '1', '1', '1', '0', '1', NULL, NULL, NULL, '0', '65d6f399cae92.png', 'NO', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', NULL, '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', NULL, NULL, '2', '3', NULL, '2024-01-01 00:00:00', '2024-02-22 15:27:33'),
(27, '79', '575757575757', 'Sugumaran', '27', 'DOC-119', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', '0', '1', '2024-02-23', '1', 'Sugumaran', '0', 'Sugumaran', '', 'NIL', '1', '1', 'ss', '22', '11', 'ds', '0', '1', '2024-02-23', '1', 'Sugumaran', '0', '65d81f1b17b52.jpg', 'NO', '0', '1', '2024-02-23', '1', 'Sugumaran', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', NULL, NULL, '2', '5', NULL, '2024-01-01 00:00:00', '2024-02-23 12:55:22'),
(32, '84', '676767676767', 'Ilambarithi', '32', 'DOC-120', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', NULL, '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', NULL, NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(33, '14', '200020002000', 'Aravind', '12', 'DOC-121', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', NULL, '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', NULL, NULL, '2', NULL, NULL, '2024-03-13 10:50:52', '2024-03-13 10:50:52'),
(34, '87', '525252525252', 'Pooja', '33', 'DOC-122', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', '1', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, '', NULL, '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', NULL, NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(35, '88', '525252525252', 'Pooja', '34', 'DOC-123', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '1', '0', NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', '0', NULL, NULL, NULL, '0', '', 'YES', '', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, '11', '0', '1', '2', '2', NULL, '2024-03-28 16:16:58', '2024-03-28 16:16:58');

-- --------------------------------------------------------

--
-- Table structure for table `acknowlegement_loan_calculation`
--

CREATE TABLE `acknowlegement_loan_calculation` (
  `loan_cal_id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id_loan` varchar(255) DEFAULT NULL,
  `cus_name_loan` varchar(255) DEFAULT NULL,
  `cus_data_loan` varchar(255) DEFAULT NULL,
  `mobile_loan` varchar(255) DEFAULT NULL,
  `pic_loan` varchar(255) DEFAULT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `tot_value` varchar(255) DEFAULT NULL,
  `ad_amt` varchar(255) DEFAULT NULL,
  `loan_amt` varchar(255) DEFAULT NULL,
  `profit_type` varchar(255) DEFAULT NULL,
  `due_method_calc` varchar(255) DEFAULT NULL,
  `due_type` varchar(255) DEFAULT NULL,
  `profit_method` varchar(255) DEFAULT NULL,
  `calc_method` varchar(255) DEFAULT NULL,
  `due_method_scheme` varchar(255) DEFAULT NULL,
  `day_scheme` varchar(255) DEFAULT NULL,
  `scheme_name` varchar(255) DEFAULT NULL,
  `int_rate` varchar(255) DEFAULT NULL,
  `due_period` varchar(255) DEFAULT NULL,
  `doc_charge` varchar(255) DEFAULT NULL,
  `proc_fee` varchar(255) DEFAULT NULL,
  `loan_amt_cal` varchar(255) DEFAULT NULL,
  `principal_amt_cal` varchar(255) DEFAULT NULL,
  `int_amt_cal` varchar(255) DEFAULT NULL,
  `tot_amt_cal` varchar(255) DEFAULT NULL,
  `due_amt_cal` varchar(255) DEFAULT NULL,
  `doc_charge_cal` varchar(255) DEFAULT NULL,
  `proc_fee_cal` varchar(255) DEFAULT NULL,
  `net_cash_cal` varchar(255) DEFAULT NULL,
  `due_start_from` varchar(255) DEFAULT NULL,
  `maturity_month` varchar(255) DEFAULT NULL,
  `collection_method` varchar(255) DEFAULT NULL,
  `communication` varchar(50) DEFAULT NULL,
  `com_audio` varchar(255) DEFAULT NULL,
  `verification_person` varchar(255) DEFAULT NULL,
  `verification_location` varchar(255) DEFAULT NULL,
  `cus_status` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `acknowlegement_loan_calculation`
--

INSERT INTO `acknowlegement_loan_calculation` (`loan_cal_id`, `req_id`, `cus_id_loan`, `cus_name_loan`, `cus_data_loan`, `mobile_loan`, `pic_loan`, `loan_category`, `sub_category`, `tot_value`, `ad_amt`, `loan_amt`, `profit_type`, `due_method_calc`, `due_type`, `profit_method`, `calc_method`, `due_method_scheme`, `day_scheme`, `scheme_name`, `int_rate`, `due_period`, `doc_charge`, `proc_fee`, `loan_amt_cal`, `principal_amt_cal`, `int_amt_cal`, `tot_amt_cal`, `due_amt_cal`, `doc_charge_cal`, `proc_fee_cal`, `net_cash_cal`, `due_start_from`, `maturity_month`, `collection_method`, `communication`, `com_audio`, `verification_person`, `verification_location`, `cus_status`, `insert_login_id`, `update_login_id`, `create_date`, `update_date`) VALUES
(8, '2', '100010001000', 'Ganesan', 'New', '6465465464', 'monkey1.avif', '5', 'TV', '43800', '2000', '41800', '2', '', '', '', '', '1', '', '10', '10', '8', '1', '1', '41800', '37620', '4180', '41800', '5225', '418', '418', '36784', '2023-07-10', '2024-03-10', '2', '1', '', '100010001000', '1', '12', '5', '5', '2023-07-07 15:26:11', '2023-07-07 15:47:13'),
(10, '6', '200020002000', 'Aravind', 'New', '9794949494', 'pexels-pixabay-220453.jpg', '6', 'Mobiles', '', '', '50000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '1.6', '6', '1.2', '2', '50000', '45200', '4810', '50010', '8335', '600', '1000', '43600', '2023-06-12', '2024-01-12', '1', '1', '', '5', '1', '12', '2', '2', '2023-06-10 16:33:24', '2023-06-11 10:02:26'),
(11, '5', '100010001000', 'Ganesan', 'Existing', '6465465464', 'monkey1.avif', '2', 'Bike', '65000', '5000', '60000', '2', '', '', '', '', '1', '', '5', '10', '6', '1.4', '1.4', '60000', '54000', '6000', '60000', '10000', '839', '600', '52561', '2023-01-13', '2023-07-13', '2', '1', '', '3', '0', '12', '2', '2', '2023-01-13 10:23:42', '2023-01-13 10:55:10'),
(12, '7', '300030003000', 'Rakesh', 'New', '9664565132', 'person_sample_4.jpg', '9', 'Education', '', '', '56790', '2', '', '', '', '', '1', '', '16', '11', '10', '5', '5', '56790', '50540', '6260', '56800', '5680', '2839', '2839', '44865', '2023-01-03', '2023-11-03', '2', '1', '', '300030003000', '0', '12', '5', '5', '2023-01-03 14:54:34', '2023-01-03 14:54:34'),
(13, '8', '200020002000', 'Aravind', 'Existing', '9794949494', 'pexels-pixabay-220453.jpg', '1', 'Personal', '35500', '3500', '32500', '2', '', '', '', '', '3', '', '8', '7', '20', '1', '1', '32500', '30225', '2275', '32500', '1625', '325', '325', '29575', '2023-01-02', '2023-01-22', '2', '1', '', '200020002000', '0', '12', '2', '2', '2023-01-01 16:21:32', '2023-01-01 16:26:05'),
(14, '1', '010720232023', 'Bharath', 'New', '9846546546', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '5', 'AC', '35000', '3000', '37000', '1', 'Monthly', 'EMI', 'after_intrest', '', '', '', '', '1', '6', '1', '1', '37000', '37000', '2240', '39240', '6540', '370', '370', '36260', '2023-08-01', '2024-02-01', '1', '1', '', '010720232023', '0', '12', '3', NULL, '2023-07-18 18:36:23', '2023-07-18 18:36:23'),
(15, '11', '500050005000', 'Manikandan', 'New', '7888878888', 'musk.jpg', '1', 'Personal', '28000', '2000', '26000', '2', '', '', '', '', '2', '6', '6', '7', '22', '1', '1', '26000', '24180', '1890', '26070', '1185', '260', '260', '23660', '2023-07-22', '2023-12-23', '1', '1', '', '500050005000', '1', '12', '2', '2', '2023-07-21 12:17:06', '2023-07-21 16:53:32'),
(16, '9', '100010001000', 'Ganesan', 'Existing', '6465465464', 'monkey1.avif', '5', 'AC', '35000', '3000', '18500', '1', 'Monthly', 'EMI', 'after_intrest', '', '', '', '', '1', '5', '1', '1', '18500', '18500', '925', '19425', '3885', '185', '185', '18130', '2023-10-01', '2024-03-01', '1', '1', '', '100010001000', '0', '12', '5', '2', '2023-07-27 13:19:47', '2023-09-05 15:17:44'),
(17, '12', '400040004000', 'Bharathi', 'New', '9459416164', 'images (1).jpg', '1', 'Personal', '', '', '100000', '1', 'Monthly', 'Interest', '', 'Monthly', '', '', '', '2', '10', '1', '1', '100000', '100000', '2000', '', '', '1000', '1000', '98000', '2023-08-05', '2024-06-05', '1', '1', '', '400040004000', '0', '12', '2', '2', '2023-08-02 15:09:58', '2023-08-02 15:13:27'),
(18, '10', '300030003000', 'Rakesh', 'Existing', '9664565132', 'person_sample_4.jpg', '1', 'Personal', '52000', '4000', '45800', '1', 'Monthly', 'Interest', '', 'Monthly', '', '', '', '1', '10', '1', '1', '45800', '45800', '460', '', '', '458', '458', '44884', '2023-08-10', '2024-06-10', '1', '1', '', '300030003000', '1', '12', '2', '2', '2023-08-07 11:08:05', '2023-08-07 12:01:54'),
(19, '16', '060120230408', 'Gnanasekar', 'New', '9790171511', 'person_sample_2.jpg', '8', 'Plot Purchase', '50000', '0', '50000', '1', 'Monthly', 'EMI', 'after_intrest', '', '', '', '', '2', '12', '2', '0', '50000', '50000', '12040', '62040', '5170', '1000', '0', '49000', '2023-02-03', '2024-02-03', '1', '1', '', '12', '0', '12', '2', '2', '2023-01-07 15:35:17', '2023-01-07 16:52:04'),
(20, '18', '100010001000', 'Ganesan', 'Existing', '6465465464', 'monkey1.avif', '2', 'Bike', '32000', '5000', '27000', '2', '', '', '', '', '1', '2', '5', '10', '6', '1', '1', '27000', '24300', '2700', '27000', '4500', '270', '270', '23760', '2023-09-15', '2024-02-15', '1', '0', '', '1', '0', '12', '2', '2', '2023-09-06 12:12:52', '2023-09-06 12:16:40'),
(21, '21', '261910026191', 'Leo Das', 'New', '2619100261', '658bc19b427cb.jpg', '6', 'Mobiles', '', '', '45000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '1', '10', '1', '1', '45000', '40500', '4500', '45000', '4500', '450', '450', '39600', '2024-01-01', '2024-10-01', '2', '1', '', '14', '0', '12', '2', NULL, '2023-12-28 10:51:52', '2023-12-28 10:51:52'),
(22, '22', '000000000001', 'Senthil kumaran', 'New', '7526312546', '6593e1b875db5.png', '11', 'Interest R', '', '', '54000', '2', '', '', '', '', '3', '', '26', '1', '45', '100', '100', '54000', '53460', '540', '54000', '1200', '100', '100', '53260', '2024-01-03', '2024-02-16', '1', '1', '', '15', '0', '12', '2', '2', '2024-01-02 15:49:20', '2024-01-02 15:51:11'),
(23, '23', '000000000001', 'Senthil kumaran', 'Existing', '7526312546', '6593e1b875db5.png', '7', 'Small Business', '', '', '11000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '2', '12', '1', '1', '11000', '8360', '2680', '11040', '920', '110', '110', '8140', '2024-01-07', '2024-12-07', '1', '1', '', '000000000001', '0', '12', '2', '2', '2024-01-06 11:29:51', '2024-01-06 11:34:50'),
(24, '24', '000000000001', 'Senthil kumaran', 'Existing', '7526312546', '6593e1b875db5.png', '7', 'Small Business', '', '', '25000', '2', '', '', '', '', '2', '6', '13', '12', '10', '1', '1', '25000', '22000', '3000', '25000', '2500', '250', '5', '21749', '2024-01-13', '2024-03-16', '1', '1', '', '15', '0', '12', '2', '2', '2024-01-06 11:32:03', '2024-01-06 11:34:23'),
(32, '77', '123412341234', 'Rajesh', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '123412341234', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(33, '78', '474747474747', 'Murugesan', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '24', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(34, '79', '575757575757', 'Sugumaran', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '25', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(39, '84', '676767676767', 'Ilambarithi', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '30', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(40, '14', '200020002000', 'Aravind', 'Existing', '9794949494', 'pexels-pixabay-220453.jpg', '7', 'Small Business', '', '', '50000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '1.5', '12', '1', '1', '50000', '41000', '9040', '50040', '4170', '500', '500', '40000', '2024-04-01', '2025-03-01', '1', '1', '', '200020002000', '0', '12', '2', NULL, '2024-03-13 10:51:30', '2024-03-13 10:51:30'),
(41, '87', '525252525252', 'Pooja', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '31', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(42, '88', '525252525252', 'Pooja', 'Existing', '7708261661', '6605494c00dfe.jpg', '1', 'Personal', '100000', '0', '100000', '1', 'Monthly', 'Interest', '', 'Monthly', '', '', '', '3', '12', '1', '2', '100000', '100000', '3000', '', '', '1000', '2000', '97000', '2024-04-05', '2025-03-05', '1', '1', '', '525252525252', '0', '12', '2', '2', '2024-03-28 16:18:33', '2024-03-28 17:08:49');

-- --------------------------------------------------------

--
-- Table structure for table `agent_communication_details`
--

CREATE TABLE `agent_communication_details` (
  `comm_id` int(11) NOT NULL,
  `agent_reff_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `agent_communication_details`
--

INSERT INTO `agent_communication_details` (`comm_id`, `agent_reff_id`, `name`, `designation`, `mobile`, `whatsapp`) VALUES
(2, '2', 'Suresh Kumar', 'MD', '9876546446', '9876546446'),
(4, '1', 'Shanmugam', 'MD', '9845687321', '9845687321');

-- --------------------------------------------------------

--
-- Table structure for table `agent_creation`
--

CREATE TABLE `agent_creation` (
  `ag_id` int(11) NOT NULL,
  `ag_code` varchar(255) DEFAULT NULL,
  `ag_name` varchar(255) DEFAULT NULL,
  `ag_group_id` varchar(255) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `loan_payment` varchar(255) DEFAULT NULL,
  `responsible` varchar(255) DEFAULT NULL,
  `collection_point` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `bank_branch_name` varchar(255) DEFAULT NULL,
  `acc_no` varchar(255) DEFAULT NULL,
  `ifsc` varchar(255) DEFAULT NULL,
  `holder_name` varchar(255) DEFAULT NULL,
  `more_info` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `agent_creation`
--

INSERT INTO `agent_creation` (`ag_id`, `ag_code`, `ag_name`, `ag_group_id`, `company_id`, `branch_id`, `mail`, `state`, `district`, `taluk`, `place`, `pincode`, `loan_category`, `sub_category`, `scheme`, `loan_payment`, `responsible`, `collection_point`, `bank_name`, `bank_branch_name`, `acc_no`, `ifsc`, `holder_name`, `more_info`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'AG-101', 'Alaathi Mobiles and Furniture', '3', '1', '', 'alaathi@gmail.com', 'TamilNadu', 'Karur', 'Karur', 'Karur', '639006', '5,6', 'AC,Fridge,Mobile,TV', '11,15', '0', '0', '0', 'Karur Vaisiya Bank', 'Karur', '123456789', 'KVB16546', 'Shanmugam', '', 0, '1', '1', NULL, '2023-07-01 11:57:29', '2023-07-01 12:08:42'),
(2, 'AG-102', 'Laxhmi Electronics', '1', '1', '', '', 'TamilNadu', 'Karur', 'Karur', 'vengamedu', '639006', '5', 'TV,Mobile,Fridge,AC', '11', '0', '1', '1', 'Lakshmi vilas bank', 'Karur', '3213546498', 'LVB654654', 'Suresh Kumar', '', 0, '1', NULL, NULL, '2023-07-01 11:59:41', '2023-07-01 11:59:41');

-- --------------------------------------------------------

--
-- Table structure for table `agent_group_creation`
--

CREATE TABLE `agent_group_creation` (
  `agent_group_id` int(11) NOT NULL,
  `agent_group_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `agent_group_creation`
--

INSERT INTO `agent_group_creation` (`agent_group_id`, `agent_group_name`, `status`) VALUES
(1, 'Home Appliance', '0'),
(2, 'Digital products', '0'),
(3, 'Home appliances & Digital products', '0'),
(4, 'Two wheeler', '0'),
(5, 'Gold loan', '0'),
(6, 'DCC', '0'),
(7, 'Agent Broker', '0'),
(8, 'Sky', '0'),
(9, 'Education Loan', '0'),
(10, 'XYZ', '0'),
(11, 'Finance R', '0'),
(12, 'Gold Agent R', '0');

-- --------------------------------------------------------

--
-- Table structure for table `area_creation`
--

CREATE TABLE `area_creation` (
  `area_creation_id` int(11) NOT NULL,
  `area_name_id` varchar(255) DEFAULT NULL,
  `sub_area` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `enable` varchar(255) NOT NULL DEFAULT '0',
  `status` int(11) DEFAULT 0,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` varchar(255) DEFAULT NULL,
  `updated_date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `area_creation`
--

INSERT INTO `area_creation` (`area_creation_id`, `area_name_id`, `sub_area`, `taluk`, `district`, `state`, `pincode`, `enable`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', '1,5,2,4,3', 'Vandavasi', 'Tiruvannamalai', 'TamilNadu', '604408', '', 0, '1', '1', NULL, '2023-05-10 15:30:08', '2023-05-11 18:00:35'),
(2, '2', '7,6,9,8,10', 'Uthiramerur', 'Kancheepuram', 'TamilNadu', '603406', '0', 0, '1', NULL, NULL, '2023-05-11 18:04:28', NULL),
(3, '3', '15,16,11,13,12,14', 'Chetpet', 'Tiruvannamalai', 'TamilNadu', '600031', '0', 1, '1', NULL, '1', '2023-05-11 18:07:03', NULL),
(4, '3', '15,16,11,13,12,14', 'Chetpet', 'Tiruvannamalai', 'TamilNadu', '600031', '0', 0, '1', NULL, NULL, '2023-05-11 18:07:08', NULL),
(5, '4', '17', 'Vandavasi', 'Tiruvannamalai', 'TamilNadu', '604407', '0', 0, '1', NULL, NULL, '2023-05-12 15:57:37', NULL),
(6, '6', '20,19,18', 'Vandavasi', 'Tiruvannamalai', 'TamilNadu', '604408', '0', 0, '1', NULL, NULL, '2023-05-12 15:59:09', NULL),
(7, '8', '22,21', 'Vandavasi', 'Tiruvannamalai', 'TamilNadu', '604405', '0', 0, '1', NULL, NULL, '2023-05-12 16:00:31', NULL),
(8, '7', '23', 'Vandavasi', 'Tiruvannamalai', 'TamilNadu', '604404', '0', 0, '1', NULL, NULL, '2023-05-12 16:16:34', NULL),
(9, '5', '24,25', 'Vandavasi', 'Tiruvannamalai', 'TamilNadu', '604407', '0', 0, '1', NULL, NULL, '2023-05-12 16:17:55', NULL),
(10, '10', '29', 'Karur', 'Karur', 'Tamilnadu', '639006', '0', 0, '2', NULL, NULL, '2023-10-09 13:37:01', NULL),
(11, '10', '30', 'Karur', 'Karur', 'Tamilnadu', '639006', '0', 0, '2', NULL, NULL, '2023-10-09 13:37:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `area_group_mapping`
--

CREATE TABLE `area_group_mapping` (
  `map_id` int(11) NOT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  `area_id` varchar(255) DEFAULT NULL,
  `sub_area_id` varchar(255) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `area_group_mapping`
--

INSERT INTO `area_group_mapping` (`map_id`, `group_name`, `area_id`, `sub_area_id`, `company_id`, `branch_id`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'Apple', '1', '1,2,3,4,5', '1', '3', '0', '1', '1', NULL, '2023-05-10 15:30:27', '2023-05-12 12:31:25'),
(2, 'Watermelon', '2', '6,7,9', '1', '2', '0', '1', '1', NULL, '2023-05-11 18:14:02', '2023-05-12 12:32:33'),
(3, 'Watermelon 2', '2', '8,10', '1', '2', '0', '1', '1', NULL, '2023-05-11 18:14:20', '2023-05-12 12:33:08'),
(4, 'Mango', '3', '13,14,15,16,18', '1', '1', '0', '1', '2', NULL, '2023-05-11 18:14:49', '2024-02-01 15:38:37'),
(5, 'GA 1', '4,5,6,7,8', '19,20,21,22,23,24,25,26', '1', '3', '0', '1', '2', NULL, '2023-05-12 16:22:16', '2024-01-26 17:55:02');

-- --------------------------------------------------------

--
-- Table structure for table `area_line_mapping`
--

CREATE TABLE `area_line_mapping` (
  `map_id` int(11) NOT NULL,
  `line_name` varchar(255) DEFAULT NULL,
  `area_id` varchar(255) DEFAULT NULL,
  `sub_area_id` varchar(255) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `area_line_mapping`
--

INSERT INTO `area_line_mapping` (`map_id`, `line_name`, `area_id`, `sub_area_id`, `company_id`, `branch_id`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'Banana 1', '1', '1,5', '1', '3', '0', '1', '1', NULL, '2023-05-11 18:12:10', '2023-05-12 12:34:15'),
(2, 'Banana 2', '1', '2,3,4', '1', '3', '0', '1', '1', NULL, '2023-05-11 18:12:41', '2023-05-12 12:35:03'),
(3, 'Jackfruit', '2', '6,7,8,9,10', '1', '2', '0', '1', '1', NULL, '2023-05-11 18:21:27', '2023-05-12 12:36:02'),
(4, 'Pine apple 1', '3', '15,16,18', '1', '1', '0', '1', '2', NULL, '2023-05-11 18:22:00', '2024-02-01 15:38:07'),
(5, 'Pine apple 2', '3', '11,12,13,14', '1', '1', '0', '1', '1', NULL, '2023-05-11 18:22:28', '2023-05-12 12:37:02'),
(6, 'LA1', '4,5,6,7,8', '19,20,21,22,23,24,25,26', '1', '3', '0', '1', '2', NULL, '2023-05-12 16:21:49', '2024-01-26 17:55:47');

-- --------------------------------------------------------

--
-- Table structure for table `area_list_creation`
--

CREATE TABLE `area_list_creation` (
  `area_id` int(11) NOT NULL,
  `area_name` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `area_enable` int(11) NOT NULL DEFAULT 0,
  `status` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `area_list_creation`
--

INSERT INTO `area_list_creation` (`area_id`, `area_name`, `taluk`, `area_enable`, `status`) VALUES
(1, 'Vandavasi', 'Vandavasi', 0, 0),
(2, 'Uthiramerur', 'Uthiramerur', 0, 0),
(3, 'Chetpet', 'Chetpet', 0, 0),
(4, 'Purisai', 'Vandavasi', 0, 0),
(5, 'Echur', 'Vandavasi', 0, 0),
(6, 'Ponnur', 'Vandavasi', 0, 0),
(7, 'Manamathy', 'Vandavasi', 0, 0),
(8, 'Thellar', 'Vandavasi', 0, 0),
(9, 'Area', NULL, 0, 0),
(10, 'Vengamedu', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bank_creation`
--

CREATE TABLE `bank_creation` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) NOT NULL,
  `acc_no` varchar(255) DEFAULT NULL,
  `ifsc` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `gpay` varchar(255) DEFAULT NULL,
  `company` varchar(255) NOT NULL,
  `under_branch` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `bank_creation`
--

INSERT INTO `bank_creation` (`id`, `bank_name`, `short_name`, `acc_no`, `ifsc`, `branch`, `qr_code`, `gpay`, `company`, `under_branch`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'City Union Bank', 'CUB', '6541348435987', 'CUB001654', 'Chennai', '', '', '1', '2', '0', '1', NULL, NULL, '2023-06-30 12:13:08', '2023-06-30 12:13:08');

-- --------------------------------------------------------

--
-- Table structure for table `bank_stmt`
--

CREATE TABLE `bank_stmt` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `trans_date` date DEFAULT NULL,
  `narration` varchar(255) NOT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `credit` varchar(255) DEFAULT NULL,
  `debit` varchar(255) DEFAULT NULL,
  `balance` varchar(255) DEFAULT NULL,
  `clr_status` varchar(10) NOT NULL DEFAULT '0' COMMENT '0 - unclear,1-cleared',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `bank_stmt`
--

INSERT INTO `bank_stmt` (`id`, `bank_id`, `trans_date`, `narration`, `trans_id`, `credit`, `debit`, `balance`, `clr_status`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', '2023-07-19', 'Check', '564654', '5000', '', '10909.22', '0', '2', NULL, '2023-07-19 16:27:21', '2023-07-19 16:27:21'),
(2, '1', '2023-08-02', 'Check', '12323434', '500', '', '10909.22', '0', '2', NULL, '2023-08-02 17:56:46', '2023-08-02 17:56:46');

-- --------------------------------------------------------

--
-- Table structure for table `branch_creation`
--

CREATE TABLE `branch_creation` (
  `branch_id` int(11) NOT NULL,
  `branch_code` varchar(255) DEFAULT NULL,
  `branch_name` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `whatsapp_number` text DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `landline_number` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `insert_login_id` int(11) DEFAULT NULL,
  `update_login_id` int(11) DEFAULT NULL,
  `delete_login_id` int(11) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branch_creation`
--

INSERT INTO `branch_creation` (`branch_id`, `branch_code`, `branch_name`, `company_name`, `mobile_number`, `address1`, `address2`, `whatsapp_number`, `place`, `pincode`, `email_id`, `landline_number`, `state`, `district`, `taluk`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'M-101', 'Chetpet', '1', '9944430311', 'Chetpet', '', '', 'Chetpet', '606801', 'mcchetpet@gmail.com', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 0, 1, NULL, NULL, '2023-06-30 10:25:34', '2023-06-30 10:25:34'),
(2, 'M-102', 'Uthiramerur', '1', '9944430322', 'No 26', '', '', 'Uthiramerur', '603406', 'mcuthiramerur@gmail.com', '', 'TamilNadu', 'Kancheepuram', 'Kancheepuram', 0, 1, 1, NULL, '2023-06-30 10:25:34', '2023-06-30 10:25:34'),
(3, 'M-103', 'Vandavasi', '1', '9944430300', 'NO.25', '', '', 'Vandavasi', '604408', 'marudhamcapitals@gmail.com', '', 'TamilNadu', 'Tiruvannamalai', 'Thiruvannamalai', 0, 1, 1, NULL, '2023-06-30 10:25:34', '2023-06-30 10:25:34'),
(4, 'M-104', 'Polur', '1', '9842398422', 'Polur', '', '984398422', 'Tiruvannamalai road', '632601', 'polur@marudhamcapitals.com', '0442102103', 'TamilNadu', 'Tiruvannamalai', 'Polur', 0, 1, 1, NULL, '2023-06-30 10:25:34', '2023-06-30 10:25:34'),
(6, 'R-106', 'R Uzhavan Vsi', '1', '994430300', '25 Gandhi road Vandavasi', '', '994430300', 'vandavasi', '604408', 'Ruzhavan@gmail.com', '0418222222', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 0, 1, 1, NULL, '2023-06-30 10:25:34', '2023-06-30 10:25:34'),
(7, 'M-107', 'Vandavasi', '1', '9944430300', '25 Gandhi road Vandavasi', '', '9944430300', 'Vandavasi', '604408', 'www.vsimarudhamgolds.com', '0418222222', 'TamilNadu', 'Tiruvannamalai', 'Thiruvannamalai', 0, 1, NULL, NULL, '2023-06-30 10:25:34', '2023-06-30 10:25:34');

-- --------------------------------------------------------

--
-- Table structure for table `cash_tally`
--

CREATE TABLE `cash_tally` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `op_hand` varchar(255) DEFAULT NULL,
  `op_date` varchar(10) NOT NULL,
  `op_bank` varchar(255) DEFAULT NULL,
  `op_agent` varchar(255) DEFAULT NULL,
  `opening_bal` varchar(255) DEFAULT NULL,
  `cl_date` date NOT NULL,
  `cl_hand` varchar(255) DEFAULT NULL,
  `cl_bank` varchar(255) DEFAULT NULL,
  `bank_untrkd` varchar(255) NOT NULL,
  `cl_agent` varchar(255) DEFAULT NULL,
  `closing_bal` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cash_tally`
--

INSERT INTO `cash_tally` (`id`, `op_hand`, `op_date`, `op_bank`, `op_agent`, `opening_bal`, `cl_date`, `cl_hand`, `cl_bank`, `bank_untrkd`, `cl_agent`, `closing_bal`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(7, '0', '2023-08-02', '0', '0', '0', '2023-08-02', '0', '0', '0', '0', '0', '2', NULL, '2023-08-02 13:53:59', '2023-08-02 13:53:59'),
(8, '0', '2023-08-03', '0', '0', '0', '2023-08-03', '13300', '-6400', '0', '-5400', '1500', '2', NULL, '2023-08-03 13:55:32', '2023-08-03 13:55:32'),
(11, '13300', '2023-08-04', '-6400', '-5400', '1500', '2023-08-04', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:10:37', '2023-09-05 15:10:37'),
(12, '0', '2023-08-05', '0', '0', '1500', '2023-08-05', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:19:39', '2023-09-05 15:19:39'),
(13, '0', '2023-08-06', '0', '0', '1500', '2023-08-06', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:19:51', '2023-09-05 15:19:51'),
(14, '0', '2023-08-07', '0', '0', '1500', '2023-08-07', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:19:57', '2023-09-05 15:19:57'),
(15, '0', '2023-08-08', '0', '0', '1500', '2023-08-08', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:02', '2023-09-05 15:20:02'),
(16, '0', '2023-08-09', '0', '0', '1500', '2023-08-09', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:15', '2023-09-05 15:20:15'),
(17, '0', '2023-08-10', '0', '0', '1500', '2023-08-10', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:21', '2023-09-05 15:20:21'),
(18, '0', '2023-08-11', '0', '0', '1500', '2023-08-11', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:27', '2023-09-05 15:20:27'),
(19, '0', '2023-08-12', '0', '0', '1500', '2023-08-12', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:32', '2023-09-05 15:20:32'),
(20, '0', '2023-08-13', '0', '0', '1500', '2023-08-13', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:37', '2023-09-05 15:20:37'),
(21, '0', '2023-08-14', '0', '0', '1500', '2023-08-14', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:43', '2023-09-05 15:20:43'),
(22, '0', '2023-08-15', '0', '0', '1500', '2023-08-15', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:49', '2023-09-05 15:20:49'),
(23, '0', '2023-08-16', '0', '0', '1500', '2023-08-16', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:20:54', '2023-09-05 15:20:54'),
(24, '0', '2023-08-17', '0', '0', '1500', '2023-08-17', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:00', '2023-09-05 15:21:00'),
(25, '0', '2023-08-18', '0', '0', '1500', '2023-08-18', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:05', '2023-09-05 15:21:05'),
(26, '0', '2023-08-19', '0', '0', '1500', '2023-08-19', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:11', '2023-09-05 15:21:11'),
(27, '0', '2023-08-20', '0', '0', '1500', '2023-08-20', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:20', '2023-09-05 15:21:20'),
(28, '0', '2023-08-21', '0', '0', '1500', '2023-08-21', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:25', '2023-09-05 15:21:25'),
(29, '0', '2023-08-22', '0', '0', '1500', '2023-08-22', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:29', '2023-09-05 15:21:29'),
(30, '0', '2023-08-23', '0', '0', '1500', '2023-08-23', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:34', '2023-09-05 15:21:34'),
(31, '0', '2023-08-24', '0', '0', '1500', '2023-08-24', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:39', '2023-09-05 15:21:39'),
(32, '0', '2023-08-25', '0', '0', '1500', '2023-08-25', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:44', '2023-09-05 15:21:44'),
(33, '0', '2023-08-26', '0', '0', '1500', '2023-08-26', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:53', '2023-09-05 15:21:53'),
(34, '0', '2023-08-27', '0', '0', '1500', '2023-08-27', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:21:58', '2023-09-05 15:21:58'),
(35, '0', '2023-08-28', '0', '0', '1500', '2023-08-28', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:22:03', '2023-09-05 15:22:03'),
(36, '0', '2023-08-29', '0', '0', '1500', '2023-08-29', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:22:07', '2023-09-05 15:22:07'),
(37, '0', '2023-08-30', '0', '0', '1500', '2023-08-30', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:22:14', '2023-09-05 15:22:14'),
(38, '0', '2023-08-31', '0', '0', '1500', '2023-08-31', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:22:20', '2023-09-05 15:22:20'),
(39, '0', '2023-09-01', '0', '0', '1500', '2023-09-01', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:22:27', '2023-09-05 15:22:27'),
(40, '0', '2023-09-02', '0', '0', '1500', '2023-09-02', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:23:20', '2023-09-05 15:23:20'),
(41, '0', '2023-09-03', '0', '0', '1500', '2023-09-03', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:23:24', '2023-09-05 15:23:24'),
(42, '0', '2023-09-04', '0', '0', '1500', '2023-09-04', '0', '0', '0', '0', '1500', '2', NULL, '2023-09-05 15:23:37', '2023-09-05 15:23:37'),
(43, '0', '2023-09-05', '0', '0', '1500', '2023-09-05', '-300', '0', '0', '0', '1200', '2', NULL, '2023-09-05 16:15:00', '2023-09-05 16:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `cash_tally_modes`
--

CREATE TABLE `cash_tally_modes` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `modes` varchar(255) DEFAULT NULL,
  `admin_access` varchar(10) NOT NULL DEFAULT '1',
  `handcredit` varchar(10) NOT NULL DEFAULT '1',
  `bankcredit` varchar(10) NOT NULL DEFAULT '1',
  `handdebit` varchar(10) NOT NULL DEFAULT '1',
  `bankdebit` varchar(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cash_tally_modes`
--

INSERT INTO `cash_tally_modes` (`id`, `modes`, `admin_access`, `handcredit`, `bankcredit`, `handdebit`, `bankdebit`) VALUES
(1, 'Collection', '1', '0', '0', '1', '1'),
(2, 'Bank Withdrawal', '1', '0', '1', '1', '1'),
(3, 'Other Income', '1', '0', '0', '1', '1'),
(4, 'Exchange', '1', '0', '0', '0', '0'),
(5, 'Cash Deposit', '1', '1', '0', '1', '1'),
(6, 'Bank Deposit', '1', '1', '1', '0', '1'),
(7, 'Cash Withdrawal', '1', '1', '1', '1', '0'),
(8, 'Agent', '1', '0', '0', '0', '0'),
(9, 'Investment', '0', '0', '0', '0', '0'),
(10, 'Deposit', '0', '0', '0', '0', '0'),
(11, 'EL', '0', '0', '0', '0', '0'),
(12, 'Excess Fund', '0', '1', '1', '1', '0'),
(13, 'Issued', '1', '1', '1', '0', '0'),
(14, 'Expenses', '1', '1', '1', '0', '0');

-- --------------------------------------------------------

--
-- Table structure for table `cheque_info`
--

CREATE TABLE `cheque_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` varchar(50) DEFAULT NULL,
  `cus_profile_id` varchar(50) DEFAULT NULL,
  `holder_type` varchar(255) DEFAULT NULL,
  `holder_name` varchar(255) DEFAULT NULL,
  `holder_relationship_name` varchar(255) DEFAULT NULL,
  `cheque_relation` varchar(255) DEFAULT NULL,
  `chequebank_name` varchar(255) DEFAULT NULL,
  `cheque_count` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cheque_info`
--

INSERT INTO `cheque_info` (`id`, `cus_id`, `req_id`, `cus_profile_id`, `holder_type`, `holder_name`, `holder_relationship_name`, `cheque_relation`, `chequebank_name`, `cheque_count`) VALUES
(1, '100010001000', '2', '4', '0', 'Ganesan', '', 'NIL', 'SBI', '1'),
(2, '500050005000', '11', '8', '0', 'Manikandan', '', 'NIL', 'HDFC', '2'),
(3, '100010001000', '9', '6', '1', 'Guna', '', 'Father', 'IOB', '2'),
(4, '100010001000', '9', '6', '0', 'Ganesan', '', 'NIL', 'KVB', '1'),
(5, '100010001000', '9', '6', '2', '', '3', 'Brother', 'LVB', '1');

-- --------------------------------------------------------

--
-- Table structure for table `cheque_no_list`
--

CREATE TABLE `cheque_no_list` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cheque_table_id` varchar(255) DEFAULT NULL,
  `cheque_holder_type` varchar(255) DEFAULT NULL,
  `cheque_holder_name` varchar(255) DEFAULT NULL,
  `cheque_no` varchar(200) DEFAULT NULL,
  `used_status` varchar(255) NOT NULL DEFAULT '0',
  `noc_given` varchar(10) NOT NULL DEFAULT '0',
  `noc_date` varchar(255) DEFAULT NULL,
  `noc_person` varchar(255) DEFAULT NULL,
  `noc_name` varchar(255) DEFAULT NULL,
  `temp_sts` varchar(10) NOT NULL DEFAULT '0',
  `temp_date` date DEFAULT NULL,
  `temp_person` varchar(255) DEFAULT NULL,
  `temp_purpose` varchar(255) DEFAULT NULL,
  `temp_remarks` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(100) DEFAULT NULL,
  `update_login_id` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cheque_no_list`
--

INSERT INTO `cheque_no_list` (`id`, `cus_id`, `req_id`, `cheque_table_id`, `cheque_holder_type`, `cheque_holder_name`, `cheque_no`, `used_status`, `noc_given`, `noc_date`, `noc_person`, `noc_name`, `temp_sts`, `temp_date`, `temp_person`, `temp_purpose`, `temp_remarks`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '100010001000', '2', '1', '0', 'Ganesan', '123456', '0', '0', NULL, NULL, NULL, '0', '2023-07-27', '1', 'Ganesan', NULL, NULL, '2', NULL, '2023-07-27 13:33:18'),
(12, '100010001000', '9', '3', ' 1', 'Guna', '132', '0', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 13:21:02'),
(13, '100010001000', '9', '3', ' 1', 'Guna', '142', '0', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 13:21:02');

-- --------------------------------------------------------

--
-- Table structure for table `cheque_upd`
--

CREATE TABLE `cheque_upd` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cheque_table_id` varchar(255) DEFAULT NULL,
  `upload_cheque_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cheque_upd`
--

INSERT INTO `cheque_upd` (`id`, `cus_id`, `req_id`, `cheque_table_id`, `upload_cheque_name`) VALUES
(1, '100010001000', '2', '1', 'asdf.pdf'),
(11, '100010001000', '9', '3', 'sample3.pdf'),
(12, '100010001000', '9', '3', 'sample4.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `closed_status`
--

CREATE TABLE `closed_status` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `closed_sts` varchar(50) DEFAULT NULL,
  `consider_level` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `cus_sts` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(100) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `closed_status`
--

INSERT INTO `closed_status` (`id`, `req_id`, `cus_id`, `closed_sts`, `consider_level`, `remark`, `cus_sts`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', '100010001000', '1', '1', 'Ok customer', '21', '2', '2', '2023-12-14 16:08:42', '2023-12-14 16:09:06'),
(2, '6', '200020002000', '1', '3', 'Average', '21', '2', '2', '2023-07-21 16:02:17', '2023-07-21 16:02:21'),
(3, '77', '123412341234', '1', '5', 'Diamond', '21', '5', '5', '2024-02-21 16:08:38', '2024-02-21 16:08:51'),
(4, '78', '474747474747', '2', '', 'WL/10', '21', '5', '5', '2024-02-22 12:43:17', '2024-02-22 12:43:20'),
(5, '79', '575757575757', '3', '', 'BK', '21', '5', '5', '2024-02-23 10:00:49', '2024-02-23 10:00:51'),
(6, '87', '525252525252', '3', NULL, 'Dashboard check', '21', '5', '5', '2024-03-25 13:14:08', '2024-03-25 13:16:52');

-- --------------------------------------------------------

--
-- Table structure for table `collection`
--

CREATE TABLE `collection` (
  `coll_id` int(11) NOT NULL COMMENT 'Primary Key',
  `coll_code` varchar(255) DEFAULT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_name` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `sub_area` varchar(255) DEFAULT NULL,
  `line` varchar(255) DEFAULT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `coll_status` varchar(255) DEFAULT NULL,
  `coll_sub_status` varchar(255) DEFAULT NULL,
  `tot_amt` varchar(255) DEFAULT NULL,
  `paid_amt` varchar(255) DEFAULT NULL,
  `bal_amt` varchar(255) DEFAULT NULL,
  `due_amt` varchar(255) DEFAULT NULL,
  `pending_amt` varchar(255) DEFAULT NULL,
  `payable_amt` varchar(255) DEFAULT NULL,
  `penalty` varchar(255) DEFAULT NULL,
  `coll_charge` varchar(255) DEFAULT NULL,
  `coll_mode` varchar(255) DEFAULT NULL,
  `bank_id` varchar(10) NOT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `trans_date` date DEFAULT NULL,
  `coll_location` varchar(255) DEFAULT NULL,
  `coll_date` datetime DEFAULT current_timestamp(),
  `due_amt_track` varchar(255) NOT NULL DEFAULT '0',
  `princ_amt_track` varchar(255) DEFAULT '0',
  `int_amt_track` varchar(255) DEFAULT '0',
  `penalty_track` varchar(255) NOT NULL DEFAULT '0',
  `coll_charge_track` varchar(255) NOT NULL DEFAULT '0',
  `total_paid_track` varchar(255) NOT NULL DEFAULT '0',
  `pre_close_waiver` varchar(255) NOT NULL DEFAULT '0',
  `penalty_waiver` varchar(255) NOT NULL DEFAULT '0',
  `coll_charge_waiver` varchar(255) NOT NULL DEFAULT '0',
  `total_waiver` varchar(255) NOT NULL DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL COMMENT 'Create Time',
  `updated_date` datetime DEFAULT current_timestamp() COMMENT 'Update Time'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `collection`
--

INSERT INTO `collection` (`coll_id`, `coll_code`, `req_id`, `cus_id`, `cus_name`, `branch`, `area`, `sub_area`, `line`, `loan_category`, `sub_category`, `coll_status`, `coll_sub_status`, `tot_amt`, `paid_amt`, `bal_amt`, `due_amt`, `pending_amt`, `payable_amt`, `penalty`, `coll_charge`, `coll_mode`, `bank_id`, `cheque_no`, `trans_id`, `trans_date`, `coll_location`, `coll_date`, `due_amt_track`, `princ_amt_track`, `int_amt_track`, `penalty_track`, `coll_charge_track`, `total_paid_track`, `pre_close_waiver`, `penalty_waiver`, `coll_charge_waiver`, `total_waiver`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'COL-101', '6', '200020002000', 'Aravind', '3', '8', '23', '6', '6', 'Mobiles', 'Present', 'Pending', '50010', '0', '50010', '8335', '0', '8335', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-06-12 00:00:00', '8335', '0', '0', '', '', '8335', '', '', '', '', '2', NULL, NULL, '2023-06-12 15:49:11', '2023-06-12 15:49:11'),
(2, 'COL-102', '6', '200020002000', 'Aravind', '3', '8', '23', '6', '6', 'Mobiles', 'Present', 'Current', '50010', '8335', '41675', '8335', '0', '8335', '0', '0', '5', '1', '', '700700700', '2023-07-11', '1', '2023-07-11 00:00:00', '16670', '0', '0', '', '', '16670', '', '', '', '', '2', NULL, NULL, '2023-07-11 15:54:51', '2023-07-11 15:54:51'),
(3, 'COL-103', '6', '200020002000', 'Aravind', '3', '8', '23', '6', '6', 'Mobiles', 'Present', 'Current', '50010', '25005', '25005', '8335', '0', '0', '0', '450', '1', '', '', '', '0000-00-00', '1', '2023-07-11 00:00:00', '', '0', '0', '', '', '', '', '', '450', '450', '2', NULL, NULL, '2023-07-11 16:07:48', '2023-07-11 16:07:48'),
(4, 'COL-104', '2', '100010001000', 'Ganesan', '1', '3', '13', '5', '', '', 'Present', 'Pending', '41800', '0', '41800', '5225', '0', '5225', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-07-12 00:00:00', '41800', '0', '0', '', '', '41800', '', '', '', '', '2', NULL, NULL, '2023-07-12 11:43:20', '2023-07-12 11:43:20'),
(5, 'COL-105', '6', '200020002000', 'Aravind', '3', '8', '23', '6', '6', 'Mobiles', 'Present', 'Current', '50010', '25005', '25005', '8335', '0', '0', '0', '0', '1', '', '', '', '0000-00-00', '2', '2023-07-12 00:00:00', '25005', '0', '0', '', '', '25005', '', '', '', '', '2', NULL, NULL, '2023-07-12 15:18:22', '2023-07-12 15:18:22'),
(6, 'COL-106', '5', '100010001000', 'Ganesan', '1', '3', '13', '5', '2', 'Bike', 'Present', 'Pending', '60000', '0', '60000', '10000', '0', '10000', '0', '0', '1', '', '', '', '0000-00-00', '2', '2023-01-13 00:00:00', '10000', '0', '0', '', '', '10000', '', '', '', '', '2', NULL, NULL, '2023-01-13 11:09:16', '2023-01-13 11:09:16'),
(7, 'COL-107', '5', '100010001000', 'Ganesan', '1', '3', '13', '5', '2', 'Bike', 'Present', 'Current', '60000', '10000', '50000', '10000', '0', '10000', '0', '0', '1', '', '', '', '0000-00-00', '2', '2023-02-13 00:00:00', '10000', '0', '0', '', '', '10000', '', '', '', '', '2', NULL, NULL, '2023-02-13 11:10:01', '2023-02-13 11:10:01'),
(8, 'COL-108', '5', '100010001000', 'Ganesan', '1', '3', '13', '5', '2', 'Bike', 'Present', 'Current', '60000', '20000', '40000', '10000', '0', '10000', '0', '150', '5', '1', '', '6484984984654', '2023-03-15', '2', '2023-03-15 00:00:00', '10000', '0', '0', '', '150', '10150', '', '', '', '', '2', NULL, NULL, '2023-03-15 11:11:07', '2023-03-15 11:11:07'),
(9, 'COL-109', '5', '100010001000', 'Ganesan', '1', '3', '13', '5', '2', 'Bike', 'Present', 'Current', '60000', '30000', '30000', '10000', '0', '10000', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-04-14 00:00:00', '8000', '0', '0', '', '', '8000', '', '', '', '', '2', NULL, NULL, '2023-04-14 11:11:40', '2023-04-14 11:11:40'),
(10, 'COL-110', '5', '100010001000', 'Ganesan', '1', '3', '13', '5', '2', 'Bike', 'Present', 'Pending', '60000', '38000', '22000', '10000', '2000', '12000', '0', '200', '1', '', '', '', '0000-00-00', '2', '2023-05-15 00:00:00', '12000', '0', '0', '', '100', '12100', '', '', '100', '100', '2', NULL, NULL, '2023-05-15 11:13:03', '2023-05-15 11:13:03'),
(11, 'COL-111', '5', '100010001000', 'Ganesan', '1', '3', '13', '5', '2', 'Bike', 'Present', 'Current', '60000', '50000', '10000', '10000', '0', '10000', '0', '0', '5', '1', '', '654654654', '2023-06-13', '2', '2023-06-13 00:00:00', '10000', '0', '0', '', '', '10000', '', '', '', '', '2', NULL, NULL, '2023-06-13 11:14:18', '2023-06-13 11:14:18'),
(12, 'COL-112', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Pending', '56800', '0', '56800', '5680', '0', '5680', '0', '0', '1', '', '', '', '0000-00-00', '2', '2023-01-03 00:00:00', '5680', '0', '0', '', '', '5680', '', '', '', '', '5', NULL, NULL, '2023-01-03 00:00:00', '2023-01-03 00:00:00'),
(13, 'COL-113', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '5680', '51120', '5680', '0', '5680', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-02-15 00:00:00', '5680', '0', '0', '', '', '5680', '', '', '', '', '5', NULL, NULL, '2023-02-15 15:14:01', '2023-02-15 15:14:01'),
(14, 'COL-114', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '11360', '45440', '5680', '0', '5680', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-03-09 00:00:00', '3000', '0', '0', '', '', '3000', '', '', '', '', '5', NULL, NULL, '2023-03-09 15:14:24', '2023-03-09 15:14:24'),
(15, 'COL-115', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '14360', '42440', '5680', '0', '2680', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-03-14 00:00:00', '2680', '0', '0', '', '', '2680', '', '', '', '', '5', NULL, NULL, '2023-03-14 15:14:47', '2023-03-14 15:14:47'),
(16, 'COL-116', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '17040', '39760', '5680', '0', '5680', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-04-14 00:00:00', '10000', '0', '0', '', '', '10000', '', '', '', '', '5', NULL, NULL, '2023-04-14 15:15:10', '2023-04-14 15:15:10'),
(17, 'COL-117', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '27040', '29760', '5680', '0', '1360', '0', '0', '1', '', '', '', '0000-00-00', '2', '2023-04-14 00:00:00', '6000', '0', '0', '', '', '6000', '', '', '', '', '5', NULL, NULL, '2023-05-12 15:15:47', '2023-05-12 15:15:47'),
(18, 'COL-118', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Pending', '56800', '33040', '23760', '5680', '1040', '6720', '340', '0', '1', '', '', '', '0000-00-00', '1', '2023-07-12 00:00:00', '7000', '0', '0', '340', '', '7340', '', '', '', '', '5', NULL, NULL, '2023-07-12 16:17:08', '2023-08-02 16:17:08'),
(19, 'COL-119', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '40040', '16760', '5680', '0', '5400', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-08-04 00:00:00', '3400', '0', '0', '', '', '3400', '', '', '', '', '5', NULL, NULL, '2023-08-04 09:32:10', '2023-08-04 09:32:10'),
(20, 'COL-120', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '43440', '13360', '5680', '0', '2000', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-08-13 00:00:00', '2000', '0', '0', '', '', '2000', '', '', '', '', '5', NULL, NULL, '2023-08-13 09:32:33', '2023-08-13 09:32:33'),
(21, 'COL-121', '7', '300030003000', 'Rakesh', '1', '3', '15', '4', '9', 'Education', 'Present', 'Current', '56800', '45440', '11360', '5680', '0', '5680', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-09-11 00:00:00', '6000', '0', '0', '', '', '6000', '', '', '', '', '5', NULL, NULL, '2023-09-11 11:26:03', '2023-09-11 11:26:03'),
(26, 'COL-122', '8', '200020002000', 'Aravind', '3', '8', '23', '6', '1', 'Personal', 'Present', 'Pending', '32500', '0', '32500', '1625', '0', '1625', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-01-01 16:04:52', '1625', '0', '0', '', '', '1625', '', '', '', '', '2', NULL, NULL, '2023-01-01 16:27:41', '2023-01-01 16:27:41'),
(27, 'COL-123', '8', '200020002000', 'Aravind', '3', '8', '23', '6', '1', 'Personal', 'Present', 'Current', '32500', '1625', '30875', '1625', '0', '1625', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-01-03 16:06:56', '1625', '0', '0', '', '', '1625', '', '', '', '', '2', NULL, NULL, '2023-01-03 16:45:49', '2023-01-03 16:45:49'),
(28, 'COL-124', '1', '010720232023', 'Bharath', '3', '1', '5', '1', '5', 'AC', 'Present', 'Pending', '39240', '0', '39240', '6540', '0', '6540', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-07-19 00:00:00', '6540', '0', '0', '', '', '6540', '', '', '', '', '3', NULL, NULL, '2023-07-19 11:14:55', '2023-07-19 11:14:55'),
(40, 'COL-125', '10', '300030003000', 'Rakesh', '1', '3', '15', '4', '1', 'Personal', 'Present', 'Pending', '45800', '0', '45800', '460', '0', '312', '0', '0', '1', '', '', '', '0000-00-00', '1', '2023-09-24 00:00:00', '', '', '312', '', '', '312', '', '', '', '', '5', NULL, NULL, '2023-09-24 16:05:27', '2023-09-24 16:05:27'),
(41, 'COL-126', '10', '300030003000', 'Rakesh', '1', '3', '15', '4', '1', 'Personal', 'Present', 'Pending', '45800', '0', '45800', '460', '0', '460', '0', '0', '1', '', '', '', '0000-00-00', '2', '2023-10-24 00:00:00', '', '800', '460', '', '', '1260', '', '', '', '0', '5', NULL, NULL, '2023-10-24 16:06:38', '2023-10-24 16:06:38'),
(42, 'COL-127', '10', '300030003000', 'Rakesh', '1', '3', '15', '4', '1', 'Personal', 'Present', 'Pending', '45800', '800', '45000', '450', '460', '920', '14', '0', '1', '', '', '', '0000-00-00', '1', '2023-12-24 00:00:00', '', '5000', '920', '10', '', '5930', '', '', '', '0', '5', NULL, NULL, '2023-12-24 16:07:41', '2023-12-24 16:07:41'),
(43, 'COL-128', '10', '300030003000', 'Rakesh', '1', '3', '15', '4', '1', 'Personal', 'Present', 'Pending', '45800', '5800', '40000', '400', '0', '0', '4', '0', '1', '', '', '', '0000-00-00', '1', '2023-12-24 17:50:55', '', '', '', '4', '', '4', '', '', '', '', '5', NULL, NULL, '2023-12-24 16:08:12', '2023-12-24 16:08:12'),
(45, 'COL-129', '1', '010720232023', 'Bharath', '3', '1', '5', '1', '5', 'AC', 'Present', 'Current', '39240', '6540', '32700', '6540', '0', '6540', '980', '0', '1', '', '', '', '0000-00-00', '1', '2023-09-05 00:00:00', '6500', '', '', '200', '', '6700', '', '', '', '0', '2', NULL, NULL, '2023-09-05 15:15:54', '2023-09-05 15:15:54'),
(46, 'COL-130', '12', '400040004000', 'Bharathi', '3', '3', '17', '6', '1', 'Personal', 'Present', 'Current', '100000', '0', '100000', '2000', '0', '1678', '180', '599', '1', '', '', '', '0000-00-00', '2', '2023-09-11 00:00:00', '', '', '', '', '300', '300', '', '', '', '', '2', NULL, NULL, '2023-12-11 17:18:02', '2023-09-11 17:18:02'),
(47, 'COL-131', '11', '500050005000', 'Manikandan', '1', '3', '15', '4', '1', 'Personal', 'Present', 'Pending', '26070', '0', '26070', '1185', '13035', '14220', '756', '0', '1', '', '', '', '0000-00-00', '1', '2023-10-07 00:00:00', '1185', '', '', '', '', '1185', '', '', '', '0', '5', NULL, NULL, '2023-10-07 17:46:23', '2023-10-07 17:46:23'),
(48, 'COL-132', '9', '100010001000', 'Ganesan', '1', '3', '13', '5', '5', 'AC', 'Present', 'Pending', '19425', '0', '19425', '3885', '7770', '11655', '351', '0', '5', '1', '', '132131', '2023-12-27', '1', '2023-12-27 00:00:00', '655', '', '', '', '', '655', '', '', '', '0', '2', NULL, NULL, '2023-12-27 12:54:10', '2023-12-27 12:54:10'),
(74, 'COL-133', '22', '000000000001', 'Senthil kumaran', '3', '3', '18', '6', '11', 'Interest R', 'Present', 'Pending', '54000', '0', '54000', '1200', '2400', '3600', '84', '0', '1', '', '', '', '0000-00-00', '1', '2024-01-02 00:00:00', '1200', '', '', '', '', '1200', '', '', '', '', '6', NULL, NULL, '2024-01-02 17:42:48', '2024-01-02 17:42:48'),
(76, 'COL-134', '22', '000000000001', 'Senthil kumaran', '3', '3', '18', '6', '11', 'Interest R', 'Present', 'Pending', '54000', '1200', '52800', '1200', '1200', '2400', '84', '0', '1', '', '', '', '0000-00-00', '1', '2024-01-05 00:00:00', '1000', '', '', '', '', '1000', '', '', '', '', '6', NULL, NULL, '2024-01-05 18:12:14', '2024-01-05 18:12:14'),
(762, 'COL-135', '77', '123412341234', 'Rajesh', '3', '5', '26', '6', '1', 'Personal', 'Present', 'Current', '30000', '0', '30000', '3000', '0', '3000', '0', '0', '1', '', '', '', '0000-00-00', '1', '2024-02-21 00:00:00', '30000', '', '', '', '', '30000', '', '', '', '0', '5', NULL, NULL, '2024-02-21 16:00:10', '2024-02-21 16:00:10'),
(763, 'COL-136', '78', '474747474747', 'Murugesan', '3', '5', '26', '6', '1', 'Personal', 'Present', 'Current', '30000', '0', '30000', '3000', '0', '3000', '0', '0', '1', '', '', '', '0000-00-00', '1', '2024-02-22 00:00:00', '', '', '', '', '', '', '30000', '', '', '30000', '5', NULL, NULL, '2024-02-22 12:42:48', '2024-02-22 12:42:48'),
(764, 'COL-137', '79', '575757575757', 'Sugumaran', '3', '5', '26', '6', '1', 'Personal', 'Present', 'Current', '30000', '0', '30000', '3000', '0', '3000', '0', '0', '1', '', '', '', '0000-00-00', '2', '2024-02-23 00:00:00', '30000', '', '', '', '', '30000', '', '', '', '0', '5', NULL, NULL, '2024-02-23 10:00:32', '2024-02-23 10:00:32'),
(765, 'COL-138', '22', '000000000001', 'Senthil kumaran', '3', '3', '18', '6', '11', 'Interest R', 'Present', 'OD', '54000', '2200', '51800', '1200', '50600', '51800', '8976', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-10 00:00:00', '800', '', '', '', '', '800', '', '', '', '0', '2', NULL, NULL, '2024-03-19 11:22:08', '2024-03-19 11:22:08'),
(766, 'COL-139', '10', '300030003000', 'Rakesh', '1', '3', '15', '4', '1', 'Personal', 'Present', 'Pending', '45800', '5800', '40000', '400', '620', '1020', '114', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-10 00:00:00', '', '620', '', '', '', '620', '', '', '', '0', '2', NULL, NULL, '2024-03-19 15:11:18', '2024-03-19 15:11:18'),
(767, 'COL-140', '9', '100010001000', 'Ganesan', '1', '3', '13', '5', '5', 'AC', 'Present', 'Pending', '19425', '655', '18770', '3885', '14885', '18770', '468', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-19 00:00:00', '14885', '', '', '', '', '14885', '', '', '', '0', '2', NULL, NULL, '2024-03-19 15:12:37', '2024-03-19 15:12:37'),
(768, 'COL-141', '9', '100010001000', 'Ganesan', '1', '3', '13', '5', '5', 'AC', 'Present', 'Pending', '19425', '15540', '3885', '3885', '0', '3885', '468', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-19 00:00:00', '3885', '', '', '', '', '3885', '', '', '', '0', '2', NULL, NULL, '2024-03-19 15:13:00', '2024-03-19 15:13:00'),
(769, 'COL-142', '8', '200020002000', 'Aravind', '3', '8', '23', '6', '1', 'Personal', 'Present', 'OD', '32500', '3250', '29250', '1625', '29250', '29250', '931', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-19 00:00:00', '1625', '', '', '', '', '1625', '', '', '', '0', '5', NULL, NULL, '2024-03-19 16:11:07', '2024-03-19 16:11:07'),
(770, 'COL-143', '87', '525252525252', 'Pooja', '3', '5', '26', '6', '1', 'Personal', 'Present', 'Pending', '30000', '0', '30000', '3000', '3000', '6000', '90', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-25 00:00:00', '30000', '', '', '', '', '30000', '', '', '', '0', '5', NULL, NULL, '2024-03-25 13:10:02', '2024-03-25 13:10:02'),
(771, 'COL-144', '87', '525252525252', 'Pooja', '3', '5', '26', '6', '1', 'Personal', 'Present', 'Due Nil', '30000', '30000', '0', '3000', '0', '0', '90', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-25 00:00:00', '', '', '', '', '', '', '', '90', '', '90', '5', NULL, NULL, '2024-03-25 13:10:14', '2024-03-25 13:10:14'),
(773, 'COL-145', '882', '525252525252', 'Pooja', '3', '5', '26', '6', '1', 'Personal', 'Present', 'Current', '100000', '0', '100000', '3000', '0', '0', '0', '0', '1', '', '', '', '0000-00-00', '1', '2024-03-29 00:00:00', '', '25000', '', '', '', '25000', '', '', '', '0', '5', NULL, NULL, '2024-03-29 17:28:35', '2024-03-29 17:28:35');

-- --------------------------------------------------------

--
-- Table structure for table `collection_charges`
--

CREATE TABLE `collection_charges` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `coll_date` varchar(255) DEFAULT NULL,
  `coll_purpose` varchar(255) DEFAULT NULL,
  `coll_charge` varchar(255) NOT NULL DEFAULT '0',
  `paid_date` varchar(255) DEFAULT NULL,
  `paid_amnt` varchar(255) DEFAULT '0',
  `waiver_amnt` varchar(255) DEFAULT '0',
  `status` int(11) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL COMMENT 'Create Time',
  `updated_date` datetime DEFAULT current_timestamp() COMMENT 'Update Time'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `collection_charges`
--

INSERT INTO `collection_charges` (`id`, `req_id`, `cus_id`, `coll_date`, `coll_purpose`, `coll_charge`, `paid_date`, `paid_amnt`, `waiver_amnt`, `status`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '6', '200020002000', '2023-07-11', 'Chumma', '450', NULL, '0', '0', 0, '2', NULL, '2023-07-11 16:05:44', '2023-07-11 16:05:44'),
(2, '6', NULL, NULL, NULL, '0', '2023-07-11', '', '450', NULL, NULL, NULL, NULL, '2023-07-11 16:07:48'),
(3, '5', '100010001000', '2023-03-13', 'Date Exceeded', '150', NULL, '0', '0', 0, '2', NULL, '2023-03-15 11:10:44', '2023-03-15 11:10:44'),
(4, '5', NULL, NULL, NULL, '0', '2023-03-15', '150', '', NULL, NULL, NULL, NULL, '2023-03-15 11:11:07'),
(5, '5', '100010001000', '2023-04-15', 'May date exceed', '200', NULL, '0', '0', 0, '2', NULL, '2023-05-15 11:12:43', '2023-05-15 11:12:43'),
(6, '5', NULL, NULL, NULL, '0', '2023-05-15', '100', '100', NULL, NULL, NULL, NULL, '2023-05-15 11:13:04'),
(7, '12', '400040004000', '2023-09-09', 'check', '134', NULL, '0', '0', 0, '2', NULL, '2023-09-11 17:16:39', '2023-09-11 17:16:39'),
(8, '12', '400040004000', '2023-09-11', 'ccc', '465', NULL, '0', '0', 0, '2', NULL, '2023-09-11 17:17:18', '2023-09-11 17:17:18'),
(9, '12', NULL, NULL, NULL, '0', '2023-09-11', '300', '', NULL, NULL, NULL, NULL, '2023-09-11 17:18:02');

-- --------------------------------------------------------

--
-- Table structure for table `commitment`
--

CREATE TABLE `commitment` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) NOT NULL,
  `ftype` varchar(10) DEFAULT NULL,
  `fstatus` varchar(55) DEFAULT NULL,
  `person_type` varchar(255) DEFAULT NULL,
  `person_name` varchar(255) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `comm_date` date DEFAULT NULL,
  `hint` varchar(255) DEFAULT NULL,
  `comm_err` varchar(10) NOT NULL,
  `insert_login_id` varchar(55) DEFAULT NULL,
  `updated_login_id` varchar(55) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `commitment`
--

INSERT INTO `commitment` (`id`, `req_id`, `cus_id`, `ftype`, `fstatus`, `person_type`, `person_name`, `relationship`, `remark`, `comm_date`, `hint`, `comm_err`, `insert_login_id`, `updated_login_id`, `created_date`, `updated_date`) VALUES
(10, '1', '010720232023', '2', '5', '', '', '', 'Switch off', '0000-00-00', 'try again', '2', '2', NULL, '2023-08-24 15:40:10', '2023-08-24 15:40:10'),
(11, '7', '300030003000', '1', '1', '1', 'Rakesh', 'NIL', 'Commitment', '2023-08-27', 'Commitment', '1', '2', NULL, '2023-08-24 15:40:44', '2023-08-24 15:40:44'),
(12, '10', '300030003000', '1', '2', '', '', '', 'not in home', '0000-00-00', 'try again tomorrow', '3', '2', NULL, '2023-08-24 15:41:29', '2023-08-24 15:41:29'),
(13, '10', '300030003000', '1', '1', '3', '7', 'Father', 'family issue', '2023-09-01', 'will pay', '2', '2', NULL, '2023-08-24 15:42:38', '2023-08-24 15:42:38'),
(14, '1', '010720232023', '1', '1', '1', 'Bharath', 'NIL', '234', '2023-08-27', 'asdf', '3', '2', NULL, '2023-08-24 19:05:28', '2023-08-24 19:05:28'),
(15, '1', '010720232023', '1', '2', '', '', '', 'Not available', '0000-00-00', '123', '1', '2', NULL, '2023-08-30 09:57:14', '2023-08-30 09:57:14'),
(16, '1', '010720232023', '1', '1', '2', 'Senthil kumar', 'Father', 'Checked', '2023-09-03', 'Checked', '2', '2', NULL, '2023-08-30 09:58:08', '2023-08-30 09:58:08'),
(17, '9', '100010001000', '1', '1', '1', 'Ganesan', 'NIL', 'aa', '2023-12-16', 'OK', '3', '2', NULL, '2023-12-15 11:15:27', '2023-12-15 11:15:27');

-- --------------------------------------------------------

--
-- Table structure for table `company_creation`
--

CREATE TABLE `company_creation` (
  `company_id` int(11) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mailid` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(255) DEFAULT NULL,
  `landline` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0',
  `insert_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_creation`
--

INSERT INTO `company_creation` (`company_id`, `company_name`, `address1`, `address2`, `state`, `district`, `taluk`, `place`, `pincode`, `website`, `mailid`, `mobile`, `whatsapp`, `landline`, `status`, `insert_user_id`, `update_user_id`, `created_date`, `updated_date`) VALUES
(1, 'Marudham Capitals', 'NO.25', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vadavasi', '604408', 'www.marudhamcapitals.in', 'www.marudhamcapitals@gmail.com', '9944430300', '', '', '0', 1, 1, '2023-06-30 10:05:54', '2023-06-30 10:23:15');

-- --------------------------------------------------------

--
-- Table structure for table `concern_creation`
--

CREATE TABLE `concern_creation` (
  `id` int(11) NOT NULL,
  `raising_for` varchar(50) DEFAULT NULL,
  `self_name` varchar(255) DEFAULT NULL,
  `self_code` varchar(150) DEFAULT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `staff_dept_name` varchar(255) DEFAULT NULL,
  `staff_team_name` varchar(255) DEFAULT NULL,
  `ag_name` varchar(255) DEFAULT NULL,
  `ag_grp` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_name` varchar(255) DEFAULT NULL,
  `cus_area` varchar(255) DEFAULT NULL,
  `cus_sub_area` varchar(255) DEFAULT NULL,
  `cus_group` varchar(255) DEFAULT NULL,
  `cus_line` varchar(255) DEFAULT NULL,
  `com_date` varchar(50) DEFAULT NULL,
  `com_code` varchar(50) DEFAULT NULL,
  `branch_name` varchar(50) DEFAULT NULL,
  `concern_to` varchar(50) DEFAULT NULL,
  `to_dept_name` varchar(255) DEFAULT NULL,
  `to_team_name` varchar(255) DEFAULT NULL,
  `com_sub` varchar(50) DEFAULT NULL,
  `com_remark` varchar(255) DEFAULT NULL,
  `com_priority` varchar(10) DEFAULT NULL,
  `staff_assign_to` varchar(50) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `solution_date` varchar(50) DEFAULT NULL,
  `communication` varchar(50) DEFAULT NULL,
  `uploads` varchar(255) DEFAULT NULL,
  `solution_remark` varchar(255) DEFAULT NULL,
  `feedback_date` varchar(10) DEFAULT NULL,
  `feedback_rating` varchar(10) DEFAULT NULL,
  `insert_user_id` varchar(50) DEFAULT NULL,
  `update_user_id` varchar(50) DEFAULT NULL,
  `delete_user_id` varchar(50) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concern_creation`
--

INSERT INTO `concern_creation` (`id`, `raising_for`, `self_name`, `self_code`, `staff_name`, `staff_dept_name`, `staff_team_name`, `ag_name`, `ag_grp`, `cus_id`, `cus_name`, `cus_area`, `cus_sub_area`, `cus_group`, `cus_line`, `com_date`, `com_code`, `branch_name`, `concern_to`, `to_dept_name`, `to_team_name`, `com_sub`, `com_remark`, `com_priority`, `staff_assign_to`, `status`, `solution_date`, `communication`, `uploads`, `solution_remark`, `feedback_date`, `feedback_rating`, `insert_user_id`, `update_user_id`, `delete_user_id`, `created_date`, `updated_date`) VALUES
(1, '4', '', '', '', '', '', '', '', '100010001000', 'Ganesan', 'Chetpet', 'EVR road', 'Mango', 'Pine apple 2', '2023-07-19', 'CC-101', '3', '1', 'Development', '', '1', 'Not delivered project', '2', '1', 2, '2023-11-29', '2', '', 'Done', '2023-11-29', '1', '2', '2', NULL, '2023-07-19 11:52:57', '2023-11-29 15:10:57'),
(2, '2', '', '', 'Prakash', 'Sales', 'Kurunji beta ', '', '', '', '', '', '', '', '', '2023-11-29', 'CC-102', '3', '1', 'Sales', '', '1', 'bad words', '1', '2', 1, '2023-11-29', '2', '', 'gadgdg', NULL, NULL, '2', '6', NULL, '2023-11-29 17:21:00', '2023-11-29 17:21:14');

-- --------------------------------------------------------

--
-- Table structure for table `concern_subject`
--

CREATE TABLE `concern_subject` (
  `concern_sub_id` int(11) NOT NULL,
  `concern_subject` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `insert_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `delete_user_id` int(11) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concern_subject`
--

INSERT INTO `concern_subject` (`concern_sub_id`, `concern_subject`, `status`, `insert_user_id`, `update_user_id`, `delete_user_id`, `created_date`, `updated_date`) VALUES
(1, 'Behaviour', 0, NULL, NULL, NULL, '2023-07-19 11:49:31', '2023-07-19 11:49:31');

-- --------------------------------------------------------

--
-- Table structure for table `confirmation_followup`
--

CREATE TABLE `confirmation_followup` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) NOT NULL,
  `cus_id` varchar(255) NOT NULL,
  `person_type` varchar(255) NOT NULL,
  `person_name` varchar(255) NOT NULL,
  `relationship` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `upload` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `sub_status` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `remove_status` varchar(10) NOT NULL DEFAULT '0',
  `insert_login_id` varchar(50) NOT NULL,
  `update_login_id` varchar(50) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `confirmation_followup`
--

INSERT INTO `confirmation_followup` (`id`, `req_id`, `cus_id`, `person_type`, `person_name`, `relationship`, `mobile`, `upload`, `status`, `sub_status`, `label`, `remark`, `remove_status`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(5, '6', '200020002000', '1', 'Aravind', 'NIL', '4345464656', '', '2', '1', '', '', '0', '2', NULL, '2023-08-22 16:10:51', '2023-08-22 16:10:51'),
(6, '6', '200020002000', '2', 'Ganesan', 'Brother', '1242423233', '', '3', '', 'asf', 'das', '0', '2', NULL, '2023-08-22 16:12:06', '2023-08-22 16:12:06'),
(7, '6', '200020002000', '3', '4', 'Father', '4645645656', '', '2', '2', '', '', '0', '2', NULL, '2023-08-22 16:12:54', '2023-08-22 16:12:54'),
(8, '6', '200020002000', '1', 'Aravind', 'NIL', '2345465456', '', '1', '', '', '', '0', '2', NULL, '2023-08-22 16:43:29', '2023-08-22 16:43:29'),
(9, '6', '200020002000', '2', 'Ganesan', 'Brother', '2424234234', '', '2', '2', '', '', '0', '2', NULL, '2023-08-22 18:10:17', '2023-08-22 18:10:17'),
(10, '6', '200020002000', '1', 'Aravind', 'NIL', '2423423423', '', '2', '1', '', '', '0', '2', NULL, '2023-08-22 18:12:06', '2023-08-22 18:12:06'),
(12, '6', '200020002000', '1', 'Aravind', 'NIL', '2142143242', 'sample2.pdf', '1', '', '', '', '1', '2', NULL, '2023-08-22 18:22:19', '2023-08-22 18:22:19'),
(13, '10', '300030003000', '2', 'Vivek', 'Father', '4546575768', '64e4b0e8333b9.pdf', '2', '2', '', '', '0', '2', NULL, '2023-08-22 18:28:16', '2023-08-22 18:28:16'),
(14, '11', '500050005000', '1', 'Manikandan', 'NIL', '3234546567', '', '2', '1', '', '', '0', '2', NULL, '2023-09-05 16:34:24', '2023-09-05 16:34:24'),
(15, '11', '500050005000', '2', 'Mani kapoor', 'Father', '2534544354', '', '1', '', '', '', '0', '2', NULL, '2023-09-05 16:34:55', '2023-09-05 16:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `ct_bank_collection`
--

CREATE TABLE `ct_bank_collection` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `credited_amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_bank_collection`
--

INSERT INTO `ct_bank_collection` (`id`, `bank_id`, `credited_amt`, `insert_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', '0', '2', '2023-08-01 00:00:00', '2023-08-01 13:52:42'),
(2, '1', '0', '2', '2023-08-02 00:00:00', '2023-08-02 13:53:53'),
(3, '1', '0', '2', '2023-08-03 00:00:00', '2023-08-03 13:55:26'),
(4, '1', '0', '2', '2023-08-04 00:00:00', '2023-09-05 15:10:10'),
(5, '1', '0', '2', '2023-08-05 00:00:00', '2023-09-05 15:19:35'),
(6, '1', '0', '2', '2023-08-06 00:00:00', '2023-09-05 15:19:47'),
(7, '1', '0', '2', '2023-08-07 00:00:00', '2023-09-05 15:19:54'),
(8, '1', '0', '2', '2023-08-08 00:00:00', '2023-09-05 15:19:59'),
(9, '1', '0', '2', '2023-08-09 00:00:00', '2023-09-05 15:20:10'),
(10, '1', '0', '2', '2023-08-10 00:00:00', '2023-09-05 15:20:17'),
(11, '1', '0', '2', '2023-08-11 00:00:00', '2023-09-05 15:20:23'),
(12, '1', '0', '2', '2023-08-12 00:00:00', '2023-09-05 15:20:29'),
(13, '1', '0', '2', '2023-08-13 00:00:00', '2023-09-05 15:20:34'),
(14, '1', '0', '2', '2023-08-14 00:00:00', '2023-09-05 15:20:40'),
(15, '1', '0', '2', '2023-08-15 00:00:00', '2023-09-05 15:20:45'),
(16, '1', '0', '2', '2023-08-16 00:00:00', '2023-09-05 15:20:51'),
(17, '1', '0', '2', '2023-08-17 00:00:00', '2023-09-05 15:20:56'),
(18, '1', '0', '2', '2023-08-18 00:00:00', '2023-09-05 15:21:02'),
(19, '1', '0', '2', '2023-08-19 00:00:00', '2023-09-05 15:21:07'),
(20, '1', '0', '2', '2023-08-20 00:00:00', '2023-09-05 15:21:17'),
(21, '1', '0', '2', '2023-08-21 00:00:00', '2023-09-05 15:21:22'),
(22, '1', '0', '2', '2023-08-22 00:00:00', '2023-09-05 15:21:26'),
(23, '1', '0', '2', '2023-08-23 00:00:00', '2023-09-05 15:21:31'),
(24, '1', '0', '2', '2023-08-24 00:00:00', '2023-09-05 15:21:36'),
(25, '1', '0', '2', '2023-08-25 00:00:00', '2023-09-05 15:21:41'),
(26, '1', '0', '2', '2023-08-26 00:00:00', '2023-09-05 15:21:49'),
(27, '1', '0', '2', '2023-08-27 00:00:00', '2023-09-05 15:21:55'),
(28, '1', '0', '2', '2023-08-28 00:00:00', '2023-09-05 15:21:59'),
(29, '1', '0', '2', '2023-08-29 00:00:00', '2023-09-05 15:22:04'),
(30, '1', '0', '2', '2023-08-30 00:00:00', '2023-09-05 15:22:11'),
(31, '1', '0', '2', '2023-08-31 00:00:00', '2023-09-05 15:22:17'),
(32, '1', '0', '2', '2023-09-01 00:00:00', '2023-09-05 15:22:24'),
(33, '1', '0', '2', '2023-09-02 00:00:00', '2023-09-05 15:23:16'),
(34, '1', '0', '2', '2023-09-03 00:00:00', '2023-09-05 15:23:21'),
(35, '1', '0', '2', '2023-09-04 00:00:00', '2023-09-05 15:23:32'),
(36, '1', '0', '2', '2023-09-05 00:00:00', '2023-09-05 16:14:53');

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_bag`
--

CREATE TABLE `ct_cr_bag` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ag_id` varchar(10) NOT NULL,
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_bank_withdraw`
--

CREATE TABLE `ct_cr_bank_withdraw` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `db_ref_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `from_bank_id` varchar(20) DEFAULT NULL,
  `cheque_no` varchar(35) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_dae` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_bdeposit`
--

CREATE TABLE `ct_cr_bdeposit` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_bel`
--

CREATE TABLE `ct_cr_bel` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_bexchange`
--

CREATE TABLE `ct_cr_bexchange` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `db_ref_id` varchar(255) DEFAULT NULL,
  `from_bank_id` varchar(10) NOT NULL,
  `to_bank_id` varchar(10) NOT NULL,
  `from_user_id` varchar(10) NOT NULL,
  `to_user_id` varchar(10) NOT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) NOT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_binvest`
--

CREATE TABLE `ct_cr_binvest` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_boti`
--

CREATE TABLE `ct_cr_boti` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ref_code` varchar(255) DEFAULT NULL,
  `to_bank_id` varchar(10) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_cash_deposit`
--

CREATE TABLE `ct_cr_cash_deposit` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `db_ref_id` varchar(255) DEFAULT NULL,
  `to_bank_id` varchar(20) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(10) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_hag`
--

CREATE TABLE `ct_cr_hag` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ag_id` varchar(10) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_cr_hag`
--

INSERT INTO `ct_cr_hag` (`id`, `ag_id`, `remark`, `amt`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', 'Collection amount', '15000', '2', NULL, '2023-07-19 00:00:00', '2023-07-19 11:06:14');

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_hdeposit`
--

CREATE TABLE `ct_cr_hdeposit` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_hel`
--

CREATE TABLE `ct_cr_hel` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_cr_hel`
--

INSERT INTO `ct_cr_hel` (`id`, `name_id`, `area`, `ident`, `remark`, `amt`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', 'PDY', 'Kalai', '123', '50000', '2', NULL, '2023-08-03 00:00:00', '2023-08-03 14:57:12');

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_hexchange`
--

CREATE TABLE `ct_cr_hexchange` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `db_ref_id` varchar(255) DEFAULT NULL,
  `to_user_id` varchar(10) NOT NULL,
  `from_user_id` varchar(10) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_hinvest`
--

CREATE TABLE `ct_cr_hinvest` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_cr_hoti`
--

CREATE TABLE `ct_cr_hoti` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `category` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_cr_hoti`
--

INSERT INTO `ct_cr_hoti` (`id`, `category`, `remark`, `amt`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, 'OTI', 'Check for', '6800', '2', NULL, '2023-08-03 00:00:00', '2023-08-03 14:58:25'),
(2, 'Papers', '1kg', '1500', '2', NULL, '2023-08-03 00:00:00', '2023-08-03 13:55:15');

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_bag`
--

CREATE TABLE `ct_db_bag` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ag_id` varchar(10) NOT NULL,
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_bank_deposit`
--

CREATE TABLE `ct_db_bank_deposit` (
  `id` int(11) NOT NULL,
  `to_bank_id` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `received` int(10) NOT NULL DEFAULT 1,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_bdeposit`
--

CREATE TABLE `ct_db_bdeposit` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_bel`
--

CREATE TABLE `ct_db_bel` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_bexchange`
--

CREATE TABLE `ct_db_bexchange` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ref_code` varchar(255) DEFAULT NULL,
  `from_acc_id` varchar(255) DEFAULT NULL,
  `to_bank_id` varchar(255) DEFAULT NULL,
  `to_user_id` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `received` int(10) NOT NULL DEFAULT 1,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_bexpense`
--

CREATE TABLE `ct_db_bexpense` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `username` varchar(255) DEFAULT NULL,
  `usertype` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `bank_id` varchar(10) NOT NULL,
  `cat` varchar(255) DEFAULT NULL,
  `part` varchar(255) DEFAULT NULL,
  `vou_id` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) NOT NULL,
  `rec_per` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `upload` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_binvest`
--

CREATE TABLE `ct_db_binvest` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `bank_id` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_db_binvest`
--

INSERT INTO `ct_db_binvest` (`id`, `bank_id`, `ref_code`, `trans_id`, `name_id`, `area`, `ident`, `remark`, `amt`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', 'INV-100001', '132321', '1', 'PDY', 'Kalai', '123', '6400', '2', NULL, '2023-08-03 00:00:00', '2023-08-03 14:56:51');

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_bissued`
--

CREATE TABLE `ct_db_bissued` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ref_code` varchar(255) DEFAULT NULL,
  `li_id` varchar(10) NOT NULL,
  `li_user_id` varchar(255) DEFAULT NULL,
  `li_bank_id` varchar(10) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `usertype` varchar(255) DEFAULT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `netcash` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_cash_withdraw`
--

CREATE TABLE `ct_db_cash_withdraw` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ref_code` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `from_bank_id` varchar(255) DEFAULT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `received` varchar(10) NOT NULL DEFAULT '1',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_exf`
--

CREATE TABLE `ct_db_exf` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `username` varchar(255) DEFAULT NULL,
  `usertype` varchar(255) DEFAULT NULL,
  `bank_id` varchar(10) NOT NULL,
  `ucl_ref_code` varchar(255) DEFAULT NULL,
  `ref_code` varchar(255) DEFAULT NULL,
  `ucl_trans_id` varchar(255) DEFAULT NULL,
  `trans_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_hag`
--

CREATE TABLE `ct_db_hag` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `ag_id` varchar(10) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_db_hag`
--

INSERT INTO `ct_db_hag` (`id`, `ag_id`, `remark`, `amt`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', 'For issue', '50000', '2', NULL, '2023-07-19 00:00:00', '2023-07-19 11:05:47'),
(2, '1', 'nothing', '5400', '2', NULL, '2023-08-03 00:00:00', '2023-08-03 16:03:58');

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_hdeposit`
--

CREATE TABLE `ct_db_hdeposit` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_hel`
--

CREATE TABLE `ct_db_hel` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_hexchange`
--

CREATE TABLE `ct_db_hexchange` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `to_user_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `received` int(10) NOT NULL DEFAULT 1,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_db_hexchange`
--

INSERT INTO `ct_db_hexchange` (`id`, `to_user_id`, `remark`, `amt`, `received`, `insert_login_id`, `created_date`, `updated_date`) VALUES
(1, '5', '123', '45000', 1, '2', '2023-08-03 00:00:00', '2023-08-03 14:57:58');

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_hexpense`
--

CREATE TABLE `ct_db_hexpense` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `username` varchar(255) DEFAULT NULL,
  `usertype` varchar(255) DEFAULT NULL,
  `cat` varchar(255) DEFAULT NULL,
  `part` varchar(255) DEFAULT NULL,
  `vou_id` varchar(255) DEFAULT NULL,
  `rec_per` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `upload` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_db_hexpense`
--

INSERT INTO `ct_db_hexpense` (`id`, `username`, `usertype`, `cat`, `part`, `vou_id`, `rec_per`, `remark`, `amt`, `upload`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(2, 'Arun', 'Staff', '5', 'book', '5555', 'press', 'book', '12000', '', '2', NULL, '2023-09-05 00:00:00', '2023-09-05 15:31:58');

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_hinvest`
--

CREATE TABLE `ct_db_hinvest` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `name_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ct_db_hissued`
--

CREATE TABLE `ct_db_hissued` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `li_user_id` varchar(255) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `netcash` varchar(255) DEFAULT NULL,
  `amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(10) NOT NULL,
  `update_login_id` varchar(10) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_db_hissued`
--

INSERT INTO `ct_db_hissued` (`id`, `li_user_id`, `user_type`, `user_name`, `netcash`, `amt`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', 'Staff', 'Arun', '23760', '', '2', '', '2023-09-06 00:00:00', '2023-09-06 12:17:44');

-- --------------------------------------------------------

--
-- Table structure for table `ct_hand_collection`
--

CREATE TABLE `ct_hand_collection` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `user_id` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `line_id` varchar(255) DEFAULT NULL,
  `pre_bal` varchar(255) DEFAULT NULL,
  `coll_amt` varchar(255) DEFAULT NULL,
  `tot_amt` varchar(255) DEFAULT NULL,
  `rec_amt` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ct_hand_collection`
--

INSERT INTO `ct_hand_collection` (`id`, `user_id`, `user_name`, `branch_id`, `line_id`, `pre_bal`, `coll_amt`, `tot_amt`, `rec_amt`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', 'Arun', '3', '1,2,3,5,6', '1,25,190', '6,700', '1,25,190', '6700', '2', NULL, '2023-09-05 00:00:00', '2023-09-05 15:24:49'),
(2, '2', 'Arun', '3', '1,2,3,5,6', '1,18,490', '6,700', '1,18,490', '5000', '2', NULL, '2023-09-05 00:00:00', '2023-09-05 15:44:45');

-- --------------------------------------------------------

--
-- Table structure for table `customer_profile`
--

CREATE TABLE `customer_profile` (
  `id` int(11) NOT NULL,
  `req_id` varchar(50) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_name` varchar(255) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `blood_group` varchar(50) DEFAULT NULL,
  `mobile1` varchar(50) DEFAULT NULL,
  `mobile2` varchar(50) DEFAULT NULL,
  `whatsapp` varchar(50) DEFAULT NULL,
  `cus_pic` varchar(255) DEFAULT NULL,
  `guarentor_name` varchar(255) DEFAULT NULL,
  `guarentor_relation` varchar(100) DEFAULT NULL,
  `guarentor_photo` varchar(255) DEFAULT NULL,
  `cus_type` varchar(50) DEFAULT NULL,
  `cus_exist_type` varchar(50) DEFAULT NULL,
  `residential_type` varchar(50) DEFAULT NULL,
  `residential_details` varchar(255) DEFAULT NULL,
  `residential_address` varchar(255) DEFAULT NULL,
  `residential_native_address` varchar(255) DEFAULT NULL,
  `occupation_type` varchar(50) DEFAULT NULL,
  `occupation_details` varchar(255) DEFAULT NULL,
  `occupation_income` varchar(255) DEFAULT NULL,
  `occupation_address` varchar(255) DEFAULT NULL,
  `dow` varchar(255) DEFAULT NULL,
  `abt_occ` varchar(255) DEFAULT NULL,
  `area_confirm_type` varchar(50) DEFAULT NULL,
  `area_confirm_state` varchar(100) DEFAULT NULL,
  `area_confirm_district` varchar(100) DEFAULT NULL,
  `area_confirm_taluk` varchar(100) DEFAULT NULL,
  `area_confirm_area` varchar(255) DEFAULT NULL,
  `area_confirm_subarea` varchar(255) DEFAULT NULL,
  `area_group` varchar(255) DEFAULT NULL,
  `area_line` varchar(255) DEFAULT NULL,
  `communication` varchar(50) DEFAULT NULL,
  `com_audio` varchar(255) DEFAULT NULL,
  `verification_person` varchar(255) DEFAULT NULL,
  `verification_location` varchar(255) DEFAULT NULL,
  `cus_status` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(100) DEFAULT NULL,
  `update_login_id` varchar(100) DEFAULT NULL,
  `delete_login_id` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_profile`
--

INSERT INTO `customer_profile` (`id`, `req_id`, `cus_id`, `cus_name`, `gender`, `dob`, `age`, `blood_group`, `mobile1`, `mobile2`, `whatsapp`, `cus_pic`, `guarentor_name`, `guarentor_relation`, `guarentor_photo`, `cus_type`, `cus_exist_type`, `residential_type`, `residential_details`, `residential_address`, `residential_native_address`, `occupation_type`, `occupation_details`, `occupation_income`, `occupation_address`, `dow`, `abt_occ`, `area_confirm_type`, `area_confirm_state`, `area_confirm_district`, `area_confirm_taluk`, `area_confirm_area`, `area_confirm_subarea`, `area_group`, `area_line`, `communication`, `com_audio`, `verification_person`, `verification_location`, `cus_status`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '2', 'Mother', 'download.jpg', 'New', '', '', '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', NULL, NULL, NULL, NULL, '10', NULL, '5', NULL, NULL, '2023-07-05 13:27:03', '2023-07-05 13:27:03'),
(2, '7', '300030003000', 'Rakesh', '1', '1992-06-09', '31', '', '9664565132', '', '', 'person_sample_4.jpg', '7', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'New', '', '0', 'MG road', 'MG road', 'MG road', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', NULL, NULL, NULL, NULL, '10', NULL, '5', NULL, NULL, '2023-07-10 12:01:17', '2023-07-10 12:01:17'),
(3, '6', '200020002000', 'Aravind', '1', '1988-03-10', '35', '', '9794949494', '', '', 'pexels-pixabay-220453.jpg', '5', 'Brother', 'person_sample_4.jpg', 'New', '', '1', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-07-10 13:17:06', '2023-07-10 13:17:06'),
(4, '5', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '3', 'Brother', 'pexels-pixabay-220453.jpg', 'Existing', 'Renewal', NULL, '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-01-13 10:13:19', '2023-01-13 10:13:19'),
(5, '8', '200020002000', 'Aravind', '1', '1988-03-10', '35', '', '9794949494', '', '', 'pexels-pixabay-220453.jpg', '6', 'Mother', 'Anna_square.jpg', 'Existing', 'Renewal', '1', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-07-15 11:23:54', '2023-07-15 11:23:54'),
(6, '9', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '1', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'Existing', 'Renewal', NULL, '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', NULL, NULL, NULL, NULL, '10', NULL, '5', NULL, NULL, '2023-07-17 18:26:00', '2023-07-17 18:26:00'),
(7, '1', '010720232023', 'Bharath', '1', '1990-02-03', '33', '', '9846546546', '', '', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '8', 'Father', 'depositphotos_12196477-stock-photo-smiling-men-isolated-on-the.jpg', 'New', '', NULL, '', '', '', '1', 'VOA', '18000', '45', '2', 'VOA', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '5', 'Apple', 'Banana 1', NULL, NULL, NULL, NULL, '10', NULL, '3', NULL, NULL, '2023-07-18 18:28:21', '2023-07-18 18:28:21'),
(8, '11', '500050005000', 'Manikandan', '1', '1995-03-02', '28', '', '7888878888', '', '', 'musk.jpg', '9', 'Father', 'construction-worker-screaming-terror-27263479.webp', 'New', '', NULL, '', '', '', '5', 'Watchman', '7500', 'Harington', '2', 'ATM', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-07-21 11:17:06', '2023-07-21 11:17:06'),
(9, '12', '400040004000', 'Bharathi', '1', '1999-01-21', '24', '', '9459416164', '994949494', '', 'images (1).jpg', '11', 'Father', 'istockphoto-1167529858-612x612.jpg', 'New', '', '0', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '17', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-08-02 15:06:09', '2023-08-02 15:06:09'),
(10, '10', '300030003000', 'Rakesh', '1', '1992-06-09', '31', '', '9664565132', '', '', 'person_sample_4.jpg', '7', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'Existing', 'Additional', '0', 'MG road', 'MG road', 'MG road', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-08-07 11:06:36', '2023-08-07 11:06:36'),
(11, '16', '060120230408', 'Gnanasekar', '1', '1990-02-14', '33', '', '9790171511', '', '', 'person_sample_2.jpg', '12', 'Father', 'depositphotos_12196477-stock-photo-smiling-men-isolated-on-the.jpg', 'New', '', '1', 'sfdsf', '', '', '1', 'Opticals', '40000', 'Senguntha puram', '10years', 'Optical store', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '3', 'Apple', 'Banana 2', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-09-07 15:30:35', '2023-09-07 15:30:35'),
(12, '14', '200020002000', 'Aravind', '1', '1988-03-10', '35', '', '9794949494', '', '', 'pexels-pixabay-220453.jpg', '6', 'Mother', 'Anna_square.jpg', 'Existing', 'Additional', '1', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-09-09 18:37:00', '2023-09-09 18:37:00'),
(13, '18', '100010001000', 'Ganesan', '1', '1996-06-01', '27', '', '6465465464', '', '', 'monkey1.avif', '1', 'Father', 'depositphotos_330369456-stock-photo-smart-middle-aged-grayed-man.jpg', 'Existing', 'Additional', '', '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-09-06 12:11:26', '2023-09-06 12:11:26'),
(14, '21', '261910026191', 'Leo Das', '1', '1999-04-27', '25', '', '2619100261', '', '', '658bc19b427cb.jpg', '14', 'Father', '658d05aa0f542.jpg', 'New', '', '0', 'Own', 'Bussy street', 'pondicherry', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2023-12-28 10:50:42', '2023-12-28 10:50:42'),
(15, '22', '000000000001', 'Senthil kumaran', '1', '1999-02-02', '25', '', '7526312546', '', '', '6593e1b875db5.png', '15', 'Father', '6593e293c4e64.jpg', 'New', '', '', '', '', '', '1', 'VAO', '1', 'CT', '1', 'VAo', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-02 15:46:51', '2024-01-02 15:46:51'),
(16, '23', '000000000001', 'Senthil kumaran', '1', '1999-02-02', '25', '', '7526312546', '', '', '6593e1b875db5.png', '15', 'Father', '6593e293c4e64.jpg', 'Existing', 'Additional', '', '', '', '', '1', 'VAO', '1', 'CT', '1', 'VAo', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-06 11:28:43', '2024-01-06 11:28:43'),
(17, '24', '000000000001', 'Senthil kumaran', '1', '1999-02-02', '25', '', '7526312546', '', '', '6593e1b875db5.png', '15', 'Father', '6593e293c4e64.jpg', 'Existing', 'Additional', '', '', '', '', '1', 'VAO', '1', 'CT', '1', 'VAo', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-06 11:30:07', '2024-01-06 11:30:07'),
(25, '77', '123412341234', 'Rajesh', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '', '23', 'Spouse', '', 'New', '', '0', 'Illam', '25, Gandhi  road', '', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(26, '78', '474747474747', 'Murugesan', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '65d6f28385849.jpg', '24', 'Spouse', '65d6f0a5d1f4c.jpg', 'New', '', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-02-22 12:36:43'),
(27, '79', '575757575757', 'Sugumaran', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '65d81ec122dbd.jpg', '25', 'Spouse', '65d81ec123488.jpg', 'New', '', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-02-23 09:57:45'),
(32, '84', '676767676767', 'Ilambarithi', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '', '30', 'Spouse', '', 'New', '', '0', 'Illam', '25, Gandhi  road', '', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(33, '87', '525252525252', 'Pooja', '1', '1994-02-20', '29', '', '7708261661', '', '7708261661', '6605494c00dfe.jpg', '31', 'Spouse', '6605494c01421.jpg', 'New', '', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-03-28 16:11:16'),
(34, '88', '525252525252', 'Pooja', '1', '1994-02-20', '29', '', '7708261661', '', '', '6605494c00dfe.jpg', '31', 'Spouse', '6605494c01421.jpg', 'Existing', 'Renewal', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', NULL, NULL, NULL, NULL, '10', NULL, '2', NULL, NULL, '2024-03-28 16:16:33', '2024-03-28 16:16:33');

-- --------------------------------------------------------

--
-- Table structure for table `customer_register`
--

CREATE TABLE `customer_register` (
  `cus_reg_id` int(11) NOT NULL COMMENT 'Primary Key',
  `req_ref_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `blood_group` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `sub_area` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `mobile1` varchar(255) DEFAULT NULL,
  `mobile2` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `marital` varchar(255) DEFAULT NULL,
  `spouse` varchar(255) DEFAULT NULL,
  `occupation_type` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `how_to_know` varchar(100) DEFAULT NULL,
  `loan_count` varchar(50) DEFAULT NULL,
  `first_loan_date` varchar(255) DEFAULT NULL,
  `travel_with_company` varchar(255) DEFAULT NULL,
  `monthly_income` varchar(255) DEFAULT NULL,
  `other_income` varchar(255) DEFAULT NULL,
  `support_income` varchar(255) DEFAULT NULL,
  `commitment` varchar(255) DEFAULT NULL,
  `monthly_due_capacity` varchar(255) DEFAULT NULL,
  `loan_limit` varchar(255) DEFAULT NULL,
  `about_customer` varchar(255) DEFAULT NULL,
  `residential_type` varchar(10) DEFAULT NULL,
  `residential_details` varchar(150) DEFAULT NULL,
  `residential_address` varchar(255) DEFAULT NULL,
  `residential_native_address` varchar(255) DEFAULT NULL,
  `occupation_info_occ_type` varchar(10) DEFAULT NULL,
  `occupation_details` varchar(255) DEFAULT NULL,
  `occupation_income` varchar(255) DEFAULT NULL,
  `occupation_address` varchar(255) DEFAULT NULL,
  `dow` varchar(255) NOT NULL,
  `abt_occ` varchar(255) NOT NULL,
  `area_confirm_type` varchar(50) DEFAULT NULL,
  `area_confirm_state` varchar(50) DEFAULT NULL,
  `area_confirm_district` varchar(50) DEFAULT NULL,
  `area_confirm_taluk` varchar(50) DEFAULT NULL,
  `area_confirm_area` varchar(50) DEFAULT NULL,
  `area_confirm_subarea` varchar(50) DEFAULT NULL,
  `area_group` varchar(50) DEFAULT NULL,
  `area_line` varchar(50) DEFAULT NULL,
  `cus_status` varchar(255) DEFAULT '0',
  `create_time` datetime DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `customer_register`
--

INSERT INTO `customer_register` (`cus_reg_id`, `req_ref_id`, `cus_id`, `customer_name`, `dob`, `age`, `gender`, `blood_group`, `state`, `district`, `taluk`, `area`, `sub_area`, `address`, `mobile1`, `mobile2`, `father_name`, `mother_name`, `marital`, `spouse`, `occupation_type`, `occupation`, `pic`, `how_to_know`, `loan_count`, `first_loan_date`, `travel_with_company`, `monthly_income`, `other_income`, `support_income`, `commitment`, `monthly_due_capacity`, `loan_limit`, `about_customer`, `residential_type`, `residential_details`, `residential_address`, `residential_native_address`, `occupation_info_occ_type`, `occupation_details`, `occupation_income`, `occupation_address`, `dow`, `abt_occ`, `area_confirm_type`, `area_confirm_state`, `area_confirm_district`, `area_confirm_taluk`, `area_confirm_area`, `area_confirm_subarea`, `area_group`, `area_line`, `cus_status`, `create_time`, `updated_date`) VALUES
(1, '1', '010720232023', 'Bharath', '1990-02-03', '33', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '4', '46', '9846546546', '', 'Sugumar', 'Seetha', '2', '', '2', 'Supervisor', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '1', '0', '', '', '18000', '0', '0', '0', '5000', '48000', 'Ok customer', 'Select Res', '', '', '', '1', 'VOA', '18000', '45', '2', 'VOA', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '5', 'Apple', 'Banana 1', '14', '2023-07-01 13:26:37', '2023-08-19 13:25:31'),
(3, '2', '100010001000', 'Ganesan', '1996-06-01', '27', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '0', '3', '13-01-2023', '7 Months,0 Years.', '35000', '0', '0', '5000', '10000', '75000', 'Checked', 'Select Res', '', '', '', '7', 'Coconut shop', '40000', 'Pondy', '2 years', 'Coconut shop', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Mango', 'Pine apple 2', '21', '2023-07-01 16:21:20', '2023-08-19 13:25:31'),
(4, '6', '200020002000', 'Aravind', '1988-03-10', '35', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', '22', '9794949494', '', 'Vedha', 'Vidhya', '2', '', '4', 'Departmental Store', 'pexels-pixabay-220453.jpg', '1', '2', '01-01-2023', '8 Months,0 Years.', '46000', '0', '0', '0', '6500', '80000', 'Good', '1', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', 'GA 1', 'LA1', '21', '2023-07-03 12:25:41', '2023-08-19 13:25:31'),
(5, '1', '010720232023', 'Bharath', '1990-02-03', '33', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '4', '46', '9846546546', '', 'Sugumar', 'Seetha', '2', '', '2', 'Supervisor', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '1', '0', '', '', '18000', '0', '0', '0', '5000', '48000', 'Ok customer', 'Select Res', '', '', '', '1', 'VOA', '18000', '45', '2', 'VOA', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '5', 'Apple', 'Banana 1', '14', '2023-07-03 12:42:44', '2023-08-19 13:25:31'),
(6, '7', '300030003000', 'Rakesh', '1992-06-09', '31', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', '78A', '9664565132', '', 'Joshwa', 'Sheethal', '2', '', '3', 'Coconut shop', 'person_sample_4.jpg', '1', '1', '03-01-2023', '7 Months,0 Years.', '45000', '0', '0', '0', '5000', '75000', 'GG', '0', 'MG road', 'MG road', 'MG road', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', '16', '2023-07-03 14:53:00', '2023-08-19 13:25:31'),
(7, '11', '500050005000', 'Manikandan', '1995-03-02', '28', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Harington road', '7888878888', '', 'Mani Kapoor', 'Mani megalai', '2', '', '5', 'Watchman', 'musk.jpg', '1', '0', '', '', '7500', '0', '0', '2500', '2500', '50000', 'Good trusted customer', 'Select Res', '', '', '', '5', 'Watchman', '7500', 'Harington', '2', 'ATM', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Mango', 'Pine apple 1', '14', '2023-07-21 11:11:38', '2023-08-19 13:25:31'),
(8, '12', '400040004000', 'Bharathi', '1999-01-21', '24', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '17', 'EVR', '9459416164', '994949494', 'Vedha', 'Gayathri', '2', '', '1', 'Watchman', 'images (1).jpg', '0', '0', '', '', '20000', '0', '0', '0', '2000', '70000', 'OK', '0', 'Chennai', 'Triplicane', 'Vandavasi', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '17', 'GA 1', 'LA1', '14', '2023-08-02 14:59:57', '2023-08-19 13:25:31'),
(9, '16', '060120230408', 'Gnanasekar', '1990-02-14', '33', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '4', '19', 'Purisai', '9790171511', '', 'Sengunthan', 'Aarthi', '2', '', '2', 'Best Opticals', 'person_sample_2.jpg', '0', '0', '', '', '40000', '0', '0', '0', '5000', '100000', 'Good spoken', '1', 'sfdsf', '', '', '1', 'Opticals', '40000', 'Senguntha puram', '10years', 'Optical store', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '3', 'Apple', 'Banana 2', '13', '2023-01-07 16:12:25', '2024-03-15 18:36:02'),
(10, '17', '090920230103', 'Janaki', '2023-09-06', '0', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', 'MRS', '9002777732', '', 'Dineshkumar', 'Dineshi', '2', '', '2', 'IT', 'download.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '2023-09-09 13:15:22', '2023-09-09 13:15:25'),
(25, '21', '261910026191', 'Leo Das', '1999-04-27', '25', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '16', 'MGR Salai', '2619100261', '', 'Anthony', 'Unknown', '1', 'Sathya', '1', 'Undercover Agent', '658bc19b427cb.jpg', '5', '0', '', '', '150000', '0', '0', '0', '8000', '78000', 'Just good', '0', 'Own', 'Bussy street', 'pondicherry', '', '', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', '13', '2023-12-27 11:48:03', '2023-12-28 10:53:27'),
(26, '22', '000000000001', 'Senthil kumaran', '1999-02-02', '25', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'CT', '7526312546', '', 'Kumaran', 'Kumari', '2', '', '1', 'VAO', '6593e1b875db5.png', '4', '1', '02-01-2024', '0 Months,0 Years.', '1', '1', '1', '1', '5000', '78000', '11', '', '', '', '', '1', 'VAO', '1', 'CT', '1', 'VAo', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'GA 1', 'LA1', '14', '2024-01-02 15:43:12', '2024-01-02 15:50:15'),
(30, '19', '600060006000', 'Subramani', '1995-05-02', '28', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Check', '2619002619', '', 'Leo', 'Trisha', '2', '', '4', 'Bite', 'subramani.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '2024-01-08 17:05:46', '2024-01-08 17:05:46'),
(45, '77', '123412341234', 'Rajesh', '1994-02-20', '29', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '2', '0', '0', '0', '18000', '0', '0', '0', '3000', '100000', 'xxx', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', '21', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(46, '78', '474747474747', 'Murugesan', '1994-02-20', '29', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '65d6f28385849.jpg', '2', '1', '10-01-2024', '1 Months,0 Years.', '18000', '0', '0', '0', '3000', '100000', 'xxx', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', '21', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(47, '79', '575757575757', 'Sugumaran', '1994-02-20', '29', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '65d81ec122dbd.jpg', '2', '1', '10-01-2024', '1 Months,0 Years.', '18000', '0', '0', '0', '3000', '100000', 'xxx', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', '21', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(52, '84', '676767676767', 'Ilambarithi', '1994-02-20', '29', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '2', '0', '0', '0', '18000', '0', '0', '0', '3000', '100000', 'xxx', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', '14', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(53, '85', '789789789789', 'Arjun', '2003-02-04', '21', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', '1', '9874563210', '', 'Dheena', 'Rani', '2', '', '1', 'VAO', '65e9a17e9d353.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '2024-03-07 16:44:06', '2024-03-11 17:48:57'),
(54, '87', '525252525252', 'Pooja', '1994-02-20', '29', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '6605494c00dfe.jpg', '2', '1', '10-01-2024', '2 Months,0 Years.', '18000', '0', '0', '0', '3000', '200000', 'Good', '0', 'Illam', '25, Gandhi  road', 'Echur', '2', 'Supervisor', '', '', '', '', '0', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', 'GA 1', 'LA1', '21', '2024-01-01 00:00:00', '2024-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `cus_old_data`
--

CREATE TABLE `cus_old_data` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `cus_id` varchar(50) DEFAULT NULL,
  `cus_name` varchar(200) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `sub_area` varchar(100) DEFAULT NULL,
  `loan_cat` varchar(100) DEFAULT NULL,
  `sub_cat` varchar(100) DEFAULT NULL,
  `loan_amt` varchar(100) DEFAULT NULL,
  `due_chart_file` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cus_old_data`
--

INSERT INTO `cus_old_data` (`id`, `cus_id`, `cus_name`, `mobile`, `area`, `sub_area`, `loan_cat`, `sub_cat`, `loan_amt`, `due_chart_file`, `created_date`, `updated_date`) VALUES
(1, '010720232023', 'Bharath', '9846545654', 'Karur', 'Gandigramam', 'Vehicle', 'bike', '35000', '655c9c38e6cea.pdf', '2023-11-21 17:32:00', '2023-11-21 17:32:00'),
(2, '010720232023', 'Bharath', '3235345345', 'asdfsdfsdf', 'sdf', 'asfd', 'asdf', '234345', '655c9e105f802.pdf', '2023-11-21 17:39:52', '2023-11-21 17:39:52'),
(3, '010720232023', 'Bharath', '9846546549', 'Trichy', 'Main trichy', 'Electronics', 'Laptop', '75000', '655ca02951355.pdf', '2023-11-21 17:48:49', '2023-11-21 17:48:49'),
(4, '200020002000', 'Aravind', '9849465465', 'Pondy', 'Bussy st', 'Personal', 'Personal', '45000', '655ca9cb5dd24.jpg', '2023-11-21 18:29:55', '2023-11-21 18:29:55');

-- --------------------------------------------------------

--
-- Table structure for table `director_creation`
--

CREATE TABLE `director_creation` (
  `dir_id` int(11) NOT NULL,
  `dir_code` varchar(255) DEFAULT NULL,
  `dir_type` varchar(255) DEFAULT NULL,
  `dir_name` varchar(255) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `mail_id` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(255) DEFAULT NULL,
  `whatsapp_no` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `director_creation`
--

INSERT INTO `director_creation` (`dir_id`, `dir_code`, `dir_type`, `dir_name`, `company_id`, `branch_id`, `address1`, `address2`, `state`, `district`, `taluk`, `place`, `pincode`, `mail_id`, `mobile_no`, `whatsapp_no`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'D-101', '1', 'Will Smith', '1', '', '26', '', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', 'www.saravanan@gmail.com', '9842301827', '', '0', '1', NULL, NULL, '2023-06-30 11:51:01', '2023-06-30 11:51:01');

-- --------------------------------------------------------

--
-- Table structure for table `document_info`
--

CREATE TABLE `document_info` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` varchar(255) NOT NULL,
  `doc_name` varchar(255) DEFAULT NULL,
  `doc_detail` varchar(255) DEFAULT NULL,
  `doc_type` varchar(255) DEFAULT NULL,
  `doc_holder` varchar(255) DEFAULT NULL,
  `holder_name` varchar(255) DEFAULT NULL,
  `relation_name` varchar(255) NOT NULL,
  `relation` varchar(255) DEFAULT NULL,
  `doc_upload` varchar(255) DEFAULT NULL,
  `doc_info_upload_noc` int(11) DEFAULT 0,
  `noc_date` varchar(255) NOT NULL,
  `noc_person` varchar(255) NOT NULL,
  `noc_name` varchar(255) NOT NULL,
  `doc_info_upload_used` int(11) DEFAULT 0,
  `temp_sts` varchar(10) NOT NULL DEFAULT '0',
  `temp_date` date DEFAULT NULL,
  `temp_person` varchar(255) DEFAULT NULL,
  `temp_purpose` varchar(255) DEFAULT NULL,
  `temp_remarks` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `document_info`
--

INSERT INTO `document_info` (`id`, `cus_id`, `req_id`, `doc_name`, `doc_detail`, `doc_type`, `doc_holder`, `holder_name`, `relation_name`, `relation`, `doc_upload`, `doc_info_upload_noc`, `noc_date`, `noc_person`, `noc_name`, `doc_info_upload_used`, `temp_sts`, `temp_date`, `temp_person`, `temp_purpose`, `temp_remarks`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, '100010001000', '2', 'House Document', 'House Document', '0', '0', 'Ganesan', '', 'NIL', 'Text Formatting.docx', 0, '', '', '', 0, '1', '2023-08-05', '1', 'Ganesan', NULL, '5', '2', NULL, '2023-07-06 10:14:00', '2023-08-05 13:04:27'),
(2, '100010001000', '2', 'Ration card', 'Ration card', '1', '2', '', '1', 'Father', 'welcome1.docx', 1, '2023-07-17', '1', 'Ganesan', 0, '0', '2023-08-05', '1', 'Ganesan', NULL, '5', '2', NULL, '2023-07-06 10:14:35', '2023-08-05 11:42:38'),
(3, '300030003000', '7', 'DL', 'License', '1', '2', '', '7', 'Father', NULL, 0, '', '', '', 0, '0', NULL, NULL, NULL, NULL, '5', NULL, NULL, '2023-07-10 12:02:13', '2023-07-10 12:02:13'),
(4, '300030003000', '7', 'PAN', '123', '0', '0', 'Rakesh', '', 'NIL', NULL, 0, '', '', '', 0, '0', NULL, NULL, NULL, NULL, '5', NULL, NULL, '2023-07-10 12:03:15', '2023-07-10 12:03:15'),
(5, '010720232023', '1', 'Ration card', 'Ration card', '0', '1', 'Senthil kumar', '', 'Father', 'feather-technology-logo.png', 0, '', '', '', 0, '0', NULL, NULL, NULL, NULL, '3', '2', NULL, '2023-07-18 18:33:45', '2023-10-03 11:54:36'),
(6, '500050005000', '11', 'Land paper', 'Land paper', '0', '1', 'Mani kapoor', '', 'Father', 'sample1.pdf', 0, '', '', '', 0, '0', NULL, NULL, NULL, NULL, '2', '2', NULL, '2023-07-21 12:10:18', '2023-07-26 12:10:21'),
(7, '500050005000', '11', 'Car RC', 'Rc Book', '1', '0', 'Manikandan', '', 'NIL', 'sample3.pdf', 0, '', '', '', 0, '0', '2023-08-02', '1', 'Manikandan', NULL, '2', '2', NULL, '2023-07-21 12:15:29', '2023-08-02 17:51:57');

-- --------------------------------------------------------

--
-- Table structure for table `document_track`
--

CREATE TABLE `document_track` (
  `id` int(11) NOT NULL,
  `req_id` varchar(100) NOT NULL,
  `cus_id` varchar(255) NOT NULL,
  `sign_doc_id` varchar(255) NOT NULL,
  `cheque_doc_id` varchar(255) NOT NULL,
  `ack_doc_id` varchar(100) NOT NULL,
  `gold_doc_id` varchar(50) NOT NULL,
  `doc_id` varchar(50) NOT NULL,
  `track_status` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(50) NOT NULL,
  `update_login_id` varchar(50) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_track`
--

INSERT INTO `document_track` (`id`, `req_id`, `cus_id`, `sign_doc_id`, `cheque_doc_id`, `ack_doc_id`, `gold_doc_id`, `doc_id`, `track_status`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(3, '9', '100010001000', '', '', '', '', '', '5', '4', '2', '2023-07-29 14:19:11', '2023-07-29 21:13:18'),
(4, '10', '300030003000', '', '', '', '', '', '1', '2', '', '2023-08-07 12:01:29', '0000-00-00 00:00:00'),
(5, '9', '100010001000', '', '', '', '', '', '1', '2', '', '2023-09-05 15:17:53', '0000-00-00 00:00:00'),
(6, '18', '100010001000', '', '', '', '', '', '1', '2', '', '2023-09-06 12:14:25', '0000-00-00 00:00:00'),
(7, '21', '261910026191', '', '', '', '', '', '2', '4', '2', '2023-12-28 10:53:27', '2024-01-11 16:00:59'),
(8, '22', '000000000001', '', '', '', '', '', '1', '2', '', '2024-01-02 15:50:15', '0000-00-00 00:00:00'),
(9, '24', '000000000001', '', '', '', '', '', '1', '2', '', '2024-01-06 11:33:26', '0000-00-00 00:00:00'),
(10, '23', '000000000001', '', '', '', '', '', '1', '2', '', '2024-01-06 11:33:31', '0000-00-00 00:00:00'),
(16, '77', '123412341234', '', '', '', '', '', '1', '2', '', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(17, '77', '123412341234', '', '', '', '', '', '3', '5', '', '2024-02-21 16:08:51', '0000-00-00 00:00:00'),
(18, '78', '474747474747', '', '', '', '', '', '1', '2', '', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(19, '78', '474747474747', '', '', '', '', '', '3', '5', '', '2024-02-22 12:43:20', '0000-00-00 00:00:00'),
(20, '79', '575757575757', '', '', '', '', '', '1', '2', '', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(21, '79', '575757575757', '', '', '', '', '', '3', '5', '', '2024-02-23 10:00:51', '0000-00-00 00:00:00'),
(24, '84', '676767676767', '', '', '', '', '', '1', '2', '', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(25, '16', '060120230408', '', '', '', '', '', '1', '2', '', '2024-03-15 18:36:03', '0000-00-00 00:00:00'),
(26, '87', '525252525252', '', '', '', '', '', '1', '2', '', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(27, '87', '525252525252', '', '', '', '', '', '3', '5', '', '2024-03-25 13:16:52', '0000-00-00 00:00:00'),
(28, '88', '525252525252', '', '', '', '', '', '1', '2', '', '2024-03-28 17:08:05', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `doc_mapping`
--

CREATE TABLE `doc_mapping` (
  `doc_map_id` int(11) NOT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `doc_creation` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_category`
--

CREATE TABLE `expense_category` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `category` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `expense_category`
--

INSERT INTO `expense_category` (`id`, `category`) VALUES
(1, 'Pooja'),
(2, 'Vehicle'),
(3, 'Fuel'),
(4, 'Stationary'),
(5, 'Press'),
(6, 'Food'),
(7, 'Donation'),
(8, 'Maintenance'),
(9, 'Salary'),
(10, 'Staff Welfare'),
(11, 'Tax'),
(12, 'Incentive'),
(13, 'Int Less'),
(14, 'Interest'),
(15, 'Common');

-- --------------------------------------------------------

--
-- Table structure for table `fingerprints`
--

CREATE TABLE `fingerprints` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `adhar_num` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `hand` varchar(50) DEFAULT NULL,
  `ansi_template` longtext NOT NULL,
  `bitmap_data` longtext DEFAULT NULL,
  `insert_user_id` varchar(50) DEFAULT NULL,
  `update_user_id` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `fingerprints`
--

INSERT INTO `fingerprints` (`id`, `adhar_num`, `name`, `hand`, `ansi_template`, `bitmap_data`, `insert_user_id`, `update_user_id`, `created_date`, `updated_date`) VALUES
(2, '100010001000', 'Ganesan', '2', 'Rk1SACAyMAAA+AA1AA0AAAE8AWIAxQDFAQAAACgkQHEAx2cAQGIAtGUAQKMBC0kAQDUA0XMAgKMBKDwAQMQAnU4AgGYBQJIAQO0A/KYAQDYAeWUAgIkBWz8AQBYBU40AQIAAK6UAQJ8A21QAQHgAp64AQLYA+0sAQIMAk1kAgIQBO54AQMoBIoAAQHMAcVgAgJ8BUAAAgCIAjAoAQO0BGpYAQIgAN0sAQBcARGMAgJABAG4AQJMBEosAgHEBHYoAgEsBGoUAQCsBBX4AQOMA9JkAQA4AynQAgN8BLIUAQH0BXJ0AQHABYDoAQFsANlUAQIgAHlAAAAA=', NULL, '5', '2', '2023-07-10 12:19:32', '2023-09-05 15:17:13'),
(3, '200020002000', 'Aravind', '1', 'Rk1SACAyMAABIgA1AA0AAAE8AWIAxQDFAQAAACgrQIwA0rAAQFoA2l4AQJMBF5UAQFkAuVsAQEAA8gMAQFEBJ2AAQDsBG2UAQNgAxFYAgHUAfwMAQKEBRosAQO4AzaEAQCsAlAoAgFcAbWAAQKAAWAgAgM4ATQYAQIIA+qwAgKUA+aAAgLkA4KIAgGEBG6IAQDsA6WIAQEcBGa8AQCoAyWAAgM0ApbAAgEsBN5sAgEYBPWQAQDQBM2oAQMsAilYAQEIBVHkAQQ8AsKsAgJAA81gAgJQAsloAQG0ArwAAQKwArbIAQMIA8U4AQHMBNosAQCsAv14AQFsBPIgAQDwBKgIAQIQBToYAQL0AgLAAgDgBRGwAQPIAlAEAQRcAyJ0AAAA=', NULL, '2', '2', '2023-07-10 16:35:55', '2023-01-01 16:24:46'),
(4, '300030003000', 'Rakesh', '1', 'Rk1SACAyMAABKAA1AA0AAAE8AWIAxQDFAQAAACgsQIwA0w4AgLcA47MAQGcA+G8AQF4AyBIAgJQBKgEAgFQBFXQAQLQBNp4AgEsAmxMAQIsAcwsAQDABAnAAQQcAy6cAQIABWXwAgREAragAQOkAbgQAQEwBWYAAgKEA7WoAgLUAxQEAQLcBCKkAQJQAoA0AQMIAnWUAgKsAiAwAQNoAl7IAQOABJJwAQKIBR50AQM8BPZcAQB4A0GwAQCABDRcAQQIAk1YAQPwAgKwAgIMAPRQAgJoA+AoAQHwAsm0AQMgAzGAAQFYA22wAQF8BHRcAgH4BNBAAQHgBP3cAQC4A9nEAQJoAdGQAQH4BSw8AQQgBAp0AQMEAZxAAQGEAXhcAQD4BT3gAAAA=', NULL, '5', '2', '2023-01-03 14:46:44', '2023-08-07 12:00:56'),
(5, '010720232023', 'Bharath', '1', 'Rk1SACAyMAABIgA1AA0AAAE8AWIAxQDFAQAAACgrgH0A2KkAQF4A4wEAQHQA+Z8AQKEAml4AQJEBH5MAQDUAoQYAQNMA3J4AQDsBHmEAQIkAaFsAQN8ApkwAQLQAaQUAgDQAbQgAgB8BLm4AQJcBXIwAQOwAT7MAgGgA12EAQJcAyFYAQFsAmWEAQCsA0WUAQLsAnqcAQGEBI5QAQHcBMI4AQBkA7gsAgOUAw6AAgN0BBpkAQCUBJAcAQD4BO4AAQDsBSnsAQFwAPQwAgIoAu6sAQFsAvAUAQHIAjwUAgEYBDKsAgJMAgQMAQCUAr2IAQMEBD5QAQEsBLpAAQHwAYgEAQDgBKqUAQOIAlKQAQNUAfqwAgGYBWIMAQI0ALggAAAA=', NULL, '3', NULL, '2023-07-18 18:37:11', '2023-07-18 18:37:11'),
(6, '500050005000', 'Manikandan', '1', 'Rk1SACAyMAAAyAA1AA0AAAE8AWIAxQDFAQAAACgcgHkBDLMAgJ0A464AQFUA4AsAgE4BGQwAgNMA+6gAQIsArAsAQHgBUacAQB8A/w0AQCMBM2wAQBgBWBIAQIQA5GIAgHgBK64AQF8BL2cAQMgBGaYAQMEAzasAQFoBPwcAQFYArgYAQO0BJEwAgL4AiAMAQIoBFV4AgHAAywgAgMMA5VEAQEEA7WgAQLEAubMAQGMAs2AAgMUBVJ8AgOABQqAAQQIA208AAAA=', NULL, '2', NULL, '2023-07-21 15:01:41', '2023-07-21 15:01:41'),
(7, '400040004000', 'Bharathi', '1', 'Rk1SACAyMAABcAA1AA0AAAE8AWIAxQDFAQAAACg4gIcA9bEAQIABCmwAQG4BAg8AQGcBDXgAQFAA6xcAgGwBIn4AQI8BMYEAQIUBNn4AQJwBQn4AQCsA13MAgD0BJn8AQHoBTSQAQIMAcwsAgKQBWkEAQLQAcmMAgO4BOI8AQBYBIB8AgQcAk6EAQLgAPwgAQIwAyAcAgJIAu2gAgKgAtq4AQG8BFRIAgFYAxnEAgEUA5XUAgKsAlrAAQEcArm8AgG8Ah2wAQEoBLSAAQCMAzXMAgFgBQ40AgC0BH3sAgEABPoQAQPsArKAAQM8AcqwAgRQA3J4AQPYAdlAAQOQAUK4AQKoA2aUAQKUBBZsAQIIBGagAQH8ApA0AQMEBEZYAQNEA+ZkAQLsAoF4AQFEAmxIAgLsBOYgAgGMBPSUAgPgA5pkAQG8BTikAgBsA3xkAQMwBSYcAgNQBSIoAgJ0AXQgAgD8AbxQAQPYAZqUAAAA=', NULL, '2', NULL, '2023-08-02 15:11:28', '2023-08-02 15:11:28'),
(9, '100010002000', 'Guna', '1', 'Rk1SACAyMAABWAA1AA0AAAE8AWIAxQDFAQAAACg0QJMAvGcAgK4A+awAgJUA/gcAQNoA5KAAQI8BEwUAQLIBG5MAQI4BIHMAQLoAe2YAgGcBHBYAQPgBB5QAQHsBNRoAQDkA+hUAQFgBNHwAQO4AYQgAgE8AZg0AQOcBVYcAQM4AQAQAQQUAPQwAQMQAzQEAgHkA0mwAQL8AowcAQIgAmmUAQMgBDpQAQJUAiwoAQFAAvA0AQFIBAnEAQOABH48AQKgBO3gAQGwBNIUAQK4BTXUAgIoAWA0AQHcBU5gAQN0BVoUAgRUAd6sAQN0ARF8AQIAA3g4AgM0AwWIAQI0BB24AgOQAwKsAQGIAuGcAgF8ArWkAgOoAn7AAgFwBE3UAQPoArFoAQM8AcQgAQE8AhWcAgNABRYIAQP4Ad2EAQGoAVmYAQQEBQ4wAQCEBHHUAQKYAIRIAAAA=', NULL, '2', NULL, '2023-08-05 17:53:48', '2023-08-05 17:53:48'),
(11, '100010003000', 'Selvi', '1', 'Rk1SACAyMAAA/gA1AA0AAAE8AWIAxQDFAQAAACglgKcA6LIAQLcA8V4AQHIAzGoAgKQAqgkAQFAA4Q4AQJYAlGIAQL8AiwsAgQMA3aQAQPUArqgAQJgBXJkAQCMBGW4AQGIAdhIAgPMAaQEAQHsA8gwAgIwBDWcAQIUBGwgAQKIBLaUAQFMBE20AQPcA+qIAgHwBS7EAQOYAmbIAgD4BL28AQCIA2CkAgGABVg4AgQ0BJp4AgKMBCK4AQIYAwAsAQLcAwWIAQNAAwK0AQEUA82kAgEQArw8AQPkAwlIAQMcBTpkAQEYBOhQAQPQBNJgAQBwBCGkAgIsAWQ8AAAA=', NULL, '2', NULL, '2023-08-05 18:00:31', '2023-08-05 18:00:31'),
(12, '261910026191', 'Leo Das', '1', 'Rk1SACAyMAABZAA1AA0AAAE8AWIAxQDFAQAAACg2QJMA46UAQJcAw60AQGABDmYAQKEBGZMAgJ0Ao7AAgGIBHqkAQDUA6xIAQGkBOH8AQEcAmg4AQIAAewgAQHMBTXwAQFIBRh8AQMoAgawAgCQBKhsAQBcBKXgAgDUAcA8AQPIAhFAAQO8AcakAgHkAzQwAgGcA/LAAQHEAqgkAQLgBBJcAQEIAy2wAQEcBDXMAgE0BIHcAQDgArWkAQF4BOXgAQOgA85kAQO0Au6IAQMgBQI8AQFgBUiIAgP4A5J8AgNUBUJQAQI0AVF8AQREAykkAQLkATQsAgH8AxGkAQIYBDZkAQHMBGpUAQFEBBQkAQK4ArFsAQE0BFgwAgGkAjGgAQCYA424AgJYBPoQAQLAAgGAAQKYBT4cAgDsBOx4AQJwAaQgAQDQBQ4wAgP0AoKUAQIAAUAUAQBQBTTcAQOAAXLMAAAA=', NULL, '4', NULL, '2023-12-28 10:53:21', '2023-12-28 10:53:21'),
(13, '261910026192', 'Antony Das', '1', 'Rk1SACAyMAABCgA1AA0AAAE8AWIAxQDFAQAAACgngIcA7hQAgJwBA3IAQG4AzHEAQLAArGoAgJcAnA8AQIQAiWYAQP0A06kAgDoAuhcAgIYBURQAQDcBJnMAgC8BGXIAQNQAewUAQEsAeBkAgKwA1QYAgJcBDhQAQIEAuRIAQFYA5RYAQE4A+nAAgJwBRgUAQGQBPBsAQOQBMp4AQKsAdhIAQPAAnVcAQQoBDp8AQNYBT5kAQB4BLxkAgLAA9gIAQL8A22QAQLkBGq4AgGIBFHQAQMkApAAAQHcAiQ0AgFcBNncAQLsBTaAAgQIAtawAQJoBWnAAQOkAi68AgRwA+aIAQG4AVRYAAAA=', NULL, '4', NULL, '2023-12-28 10:53:21', '2023-12-28 10:53:21');

-- --------------------------------------------------------

--
-- Table structure for table `gold_info`
--

CREATE TABLE `gold_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `gold_sts` varchar(255) DEFAULT NULL,
  `gold_type` varchar(255) DEFAULT NULL,
  `Purity` varchar(255) DEFAULT NULL,
  `gold_Count` varchar(255) DEFAULT NULL,
  `gold_Weight` varchar(255) DEFAULT NULL,
  `gold_Value` varchar(255) DEFAULT NULL,
  `gold_upload` varchar(100) NOT NULL,
  `noc_given` varchar(10) NOT NULL DEFAULT '0',
  `noc_date` varchar(255) DEFAULT NULL,
  `noc_person` varchar(255) DEFAULT NULL,
  `noc_name` varchar(255) DEFAULT NULL,
  `used_status` varchar(10) NOT NULL DEFAULT '0',
  `temp_sts` varchar(10) NOT NULL DEFAULT '0',
  `temp_date` date DEFAULT NULL,
  `temp_person` varchar(255) DEFAULT NULL,
  `temp_purpose` varchar(255) DEFAULT NULL,
  `temp_remarks` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(100) DEFAULT NULL,
  `update_login_id` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gold_info`
--

INSERT INTO `gold_info` (`id`, `cus_id`, `req_id`, `gold_sts`, `gold_type`, `Purity`, `gold_Count`, `gold_Weight`, `gold_Value`, `gold_upload`, `noc_given`, `noc_date`, `noc_person`, `noc_name`, `used_status`, `temp_sts`, `temp_date`, `temp_person`, `temp_purpose`, `temp_remarks`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '100010001000', '5', '1', 'Ring', '916', '1', '3.146', '22000', '6565c87a7b8f4.png', '0', '', '', '', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 15:48:19'),
(2, '200020002000', '8', '1', 'Ring', '916', '1', '300', '32000', '', '0', NULL, NULL, NULL, '0', '0', '2023-07-27', '1', 'Aravind', NULL, NULL, '2', NULL, '2023-07-27 15:58:08'),
(3, '100010001000', '2', '1', 'Chain', '24k', '1', '3.146', '25000', '6565cfb5242fe.png', '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 15:48:19'),
(4, '500050005000', '11', '1', 'Metti', '24k916', '2', '290', '42000', '', '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 15:48:19'),
(6, '500050005000', '11', '0', 'Kammal', '24k', '1', '1.5', '59000', '', '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 15:48:19'),
(12, '200020002000', '14', '1', '2', '3', '1', '4', '2', '6565c5fa56fd9.png', '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-28 16:19:00'),
(13, '060120230408', '16', '1', 'check', 'check', '2', '100', '27300', '6565d2c155091.jpg', '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-28 17:15:05'),
(14, '474747474747', '78', '1', '1', '2', '1', '2', '1111', '', '1', '2024-03-27', '1', 'Murugesan', '0', '0', NULL, NULL, NULL, NULL, NULL, '5', NULL, '2024-03-27 12:24:10'),
(15, '575757575757', '79', '1', '22', '2', '1', '1', '1', '', '1', '2024-02-23', '1', 'Sugumaran', '0', '0', NULL, NULL, NULL, NULL, NULL, '5', NULL, '2024-02-23 12:34:54'),
(16, '575757575757', '79', '0', '2', '2', '1', '2', '2', '', '1', '2024-02-23', '2', '25', '0', '0', NULL, NULL, NULL, NULL, NULL, '5', NULL, '2024-02-24 12:55:22');

-- --------------------------------------------------------

--
-- Table structure for table `in_acknowledgement`
--

CREATE TABLE `in_acknowledgement` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_status` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(50) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp(),
  `inserted_user` varchar(10) NOT NULL,
  `inserted_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `in_acknowledgement`
--

INSERT INTO `in_acknowledgement` (`id`, `req_id`, `cus_id`, `cus_status`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_on`, `updated_date`, `inserted_user`, `inserted_date`) VALUES
(3, '2', '100010001000', '21', '0', '5', '2', NULL, '2023-07-07 16:26:28', '2023-08-02 17:41:38', '5', '2023-07-07'),
(5, '6', '200020002000', '21', '0', '2', '2', NULL, '2023-07-10 16:45:52', '2023-07-10 17:41:38', '2', '2023-07-10'),
(6, '5', '100010001000', '20', '0', '2', '2', NULL, '2023-01-13 10:46:16', '2023-08-02 17:41:38', '2', '2023-01-13'),
(7, '7', '300030003000', '14', '0', '5', '5', NULL, '2023-01-03 13:38:50', '2023-08-02 17:41:38', '5', '2023-01-03'),
(8, '8', '200020002000', '14', '0', '2', '2', NULL, '2023-01-01 16:17:35', '2023-08-02 17:41:38', '2', '2023-01-01'),
(9, '1', '010720232023', '14', '0', '3', '3', NULL, '2023-07-18 18:36:45', '2023-07-02 17:41:38', '2', '2023-07-18'),
(10, '11', '500050005000', '14', '0', '2', '2', NULL, '2023-07-21 12:17:22', '2023-08-02 17:41:38', '2', '2023-07-21'),
(11, '9', '100010001000', '3', '0', '5', NULL, NULL, '2023-07-27 13:20:05', '2023-08-02 17:41:38', '5', '2023-07-27'),
(12, '12', '400040004000', '3', '0', '2', NULL, NULL, '2023-08-02 15:10:16', '2023-08-02 17:41:38', '2', '2023-08-02'),
(13, '10', '300030003000', '3', '0', '2', NULL, NULL, '2023-08-07 11:08:19', '2023-08-07 11:08:19', '2', '2023-08-07'),
(14, '16', '060120230408', '13', '0', '2', '2', NULL, '2023-01-10 16:53:40', '2024-03-15 18:36:03', '2', '2023-01-10'),
(15, '18', '100010001000', '14', '0', '2', '0', NULL, '2023-09-06 12:13:45', '2023-09-06 12:13:45', '2', '2023-09-06'),
(16, '21', '261910026191', '13', '0', '2', NULL, NULL, '2023-12-28 10:52:10', '2023-12-28 10:53:27', '2', '2023-12-28'),
(17, '22', '000000000001', '14', '0', '2', '0', NULL, '2024-01-02 15:49:33', '2024-01-02 15:50:15', '2', '2024-01-02'),
(18, '24', '000000000001', '14', '0', '2', '0', NULL, '2024-01-06 11:32:16', '2024-01-06 11:33:26', '2', '2024-01-06'),
(19, '23', '000000000001', '14', '0', '2', '0', NULL, '2024-01-06 11:32:21', '2024-01-06 11:33:31', '2', '2024-01-06'),
(25, '77', '123412341234', '21', '0', '2', '0', NULL, '2024-01-01 00:00:00', '2024-02-21 16:00:10', '2', '2024-01-01'),
(26, '78', '474747474747', '21', '0', '2', '0', NULL, '2024-01-01 00:00:00', '2024-02-22 12:42:48', '2', '2024-01-01'),
(27, '79', '575757575757', '21', '0', '2', '0', NULL, '2024-01-01 00:00:00', '2024-02-23 10:00:32', '2', '2024-01-10'),
(32, '84', '676767676767', '14', '0', '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-10 00:00:00', '2', '2024-01-01'),
(33, '14', '200020002000', '3', '0', '2', NULL, NULL, '2024-03-14 09:57:47', '2024-03-14 09:57:47', '2', '2024-03-14'),
(34, '87', '525252525252', '21', '0', '2', '0', NULL, '2024-01-01 00:00:00', '2024-03-25 13:10:14', '2', '2024-01-01'),
(35, '88', '525252525252', '14', '0', '2', '0', NULL, '2024-03-28 16:54:31', '2024-03-28 17:08:05', '2', '2024-03-28');

-- --------------------------------------------------------

--
-- Table structure for table `in_approval`
--

CREATE TABLE `in_approval` (
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_status` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `in_approval`
--

INSERT INTO `in_approval` (`req_id`, `cus_id`, `cus_status`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `updated_date`) VALUES
('2', '100010001000', '21', '0', '5', '2', NULL, NULL),
('6', '200020002000', '21', '0', '2', '2', NULL, NULL),
('5', '100010001000', '20', '0', '2', '2', NULL, NULL),
('7', '300030003000', '16', '0', '5', '5', NULL, NULL),
('8', '200020002000', '14', '0', '2', '2', NULL, NULL),
('1', '010720232023', '14', '0', '3', '3', NULL, NULL),
('11', '500050005000', '14', '0', '2', '2', NULL, NULL),
('9', '100010001000', '14', '0', '5', '2', NULL, NULL),
('12', '400040004000', '14', '0', '2', '2', NULL, NULL),
('10', '300030003000', '14', '0', '2', '2', NULL, NULL),
('16', '060120230408', '13', '0', '2', '2', NULL, NULL),
('18', '100010001000', '14', '0', '2', '2', NULL, NULL),
('21', '261910026191', '13', '0', '2', NULL, NULL, NULL),
('22', '000000000001', '14', '0', '2', '2', NULL, NULL),
('23', '000000000001', '14', '0', '2', '2', NULL, NULL),
('24', '000000000001', '14', '0', '2', '2', NULL, NULL),
('77', '123412341234', '21', '0', '2', '5', NULL, '2024-02-21 16:00:10'),
('78', '474747474747', '21', '0', '2', '5', NULL, '2024-02-22 12:42:48'),
('79', '575757575757', '21', '0', '2', '5', NULL, '2024-02-23 10:00:32'),
('84', '676767676767', '14', '0', '2', '2', NULL, NULL),
('14', '200020002000', '3', '0', '2', NULL, NULL, NULL),
('87', '525252525252', '21', '0', '2', '5', NULL, '2024-03-25 13:10:14'),
('88', '525252525252', '14', '0', '2', '2', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `in_issue`
--

CREATE TABLE `in_issue` (
  `id` int(11) NOT NULL,
  `loan_id` varchar(255) DEFAULT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_status` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(50) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT NULL,
  `inserted_user` varchar(10) NOT NULL,
  `inserted_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `in_issue`
--

INSERT INTO `in_issue` (`id`, `loan_id`, `req_id`, `cus_id`, `cus_status`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`, `inserted_user`, `inserted_date`) VALUES
(1, 'LID-101', '2', '100010001000', '21', '0', '5', '2', NULL, '2023-07-10 12:25:26', '2023-07-17 15:19:12', '5', '2023-07-10 12:25:26'),
(2, 'LID-102', '6', '200020002000', '21', '0', '2', '2', NULL, '2023-07-10 18:30:57', '2023-07-17 16:02:21', '2', '2023-07-10 18:30:57'),
(3, 'LID-103', '5', '100010001000', '20', '0', '2', '2', NULL, '2023-01-13 10:53:37', '2023-01-13 11:14:18', '2', '2023-01-13 10:53:37'),
(4, 'LID-104', '7', '300030003000', '16', '0', '5', '5', NULL, '2023-01-03 14:54:34', '2023-09-14 17:59:07', '5', '2023-01-03 14:54:34'),
(5, 'LID-105', '8', '200020002000', '14', '0', '2', '2', NULL, '2023-01-01 16:25:22', '2023-09-08 18:28:25', '2', '2023-01-01 16:25:22'),
(6, 'LID-106', '1', '010720232023', '14', '0', '3', '3', NULL, '2023-07-18 18:37:20', '2023-07-19 10:59:17', '4', '2023-07-18 18:37:20'),
(7, 'LID-107', '11', '500050005000', '14', '0', '2', '2', NULL, '2023-07-21 15:02:51', '2023-07-21 16:53:52', '2', '2023-07-21 15:02:51'),
(8, 'LID-108', '12', '400040004000', '14', '0', '2', '2', NULL, '2023-08-02 15:02:51', '2023-08-02 15:02:51', '2', '2023-08-02 15:02:51'),
(9, 'LID-109', '10', '300030003000', '14', '0', '2', '2', NULL, '2023-08-07 12:01:29', '2023-08-07 12:01:59', '2', '2023-08-07 12:01:29'),
(10, 'LID-110', '9', '100010001000', '14', '0', '2', '2', NULL, '2023-09-05 15:17:53', '2023-09-05 15:18:08', '2', '2023-09-05 15:17:53'),
(11, 'LID-114', '18', '100010001000', '14', '0', '2', '2', NULL, '2023-09-06 12:14:25', '2023-09-06 13:20:44', '2', '2023-09-06 12:14:25'),
(12, NULL, '21', '261910026191', '13', '0', '4', NULL, NULL, '2023-12-28 10:53:27', '2023-12-28 10:53:27', '4', '2023-12-28 10:53:27'),
(13, 'LID-115', '22', '000000000001', '14', '0', '2', '2', NULL, '2024-01-02 15:50:15', '2024-01-02 15:51:18', '2', '2024-01-02 15:50:15'),
(14, 'LID-117', '24', '000000000001', '14', '0', '2', '2', NULL, '2024-01-06 11:33:26', '2024-01-06 11:35:03', '2', '2024-01-06 11:33:26'),
(15, 'LID-116', '23', '000000000001', '14', '0', '2', '2', NULL, '2024-01-06 11:33:31', '2024-01-06 11:34:56', '2', '2024-01-06 11:33:31'),
(21, 'LID-118', '77', '123412341234', '21', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-01-10 00:00:00', '2', '2024-01-01 00:00:00'),
(22, 'LID-119', '78', '474747474747', '21', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-01-10 00:00:00', '2', '2024-01-01 00:00:00'),
(23, 'LID-120', '79', '575757575757', '21', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-01-10 00:00:00', '2', '2024-01-10 00:00:00'),
(26, 'LID-121', '84', '676767676767', '14', '0', '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-10 00:00:00', '2', '2024-01-01 00:00:00'),
(27, NULL, '16', '060120230408', '13', '0', '2', NULL, NULL, '2024-03-15 18:36:03', NULL, '2', '2024-03-15 18:36:03'),
(28, 'LID-122', '87', '525252525252', '21', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-01-10 00:00:00', '2', '2024-01-01 00:00:00'),
(29, 'LID-123', '88', '525252525252', '14', '0', '2', '2', NULL, '2024-03-28 17:08:05', '2024-03-28 17:08:57', '2', '2024-03-28 17:08:05');

-- --------------------------------------------------------

--
-- Table structure for table `in_verification`
--

CREATE TABLE `in_verification` (
  `req_id` int(11) NOT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `agent_id` varchar(255) DEFAULT NULL,
  `responsible` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `declaration` varchar(255) DEFAULT NULL,
  `req_code` varchar(255) DEFAULT NULL,
  `dor` date DEFAULT NULL,
  `cus_reg_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_data` varchar(255) DEFAULT NULL,
  `cus_name` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `blood_group` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `sub_area` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `mobile1` varchar(255) DEFAULT NULL,
  `mobile2` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `marital` varchar(255) DEFAULT NULL,
  `spouse_name` varchar(255) DEFAULT NULL,
  `occupation_type` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `tot_value` varchar(255) DEFAULT NULL,
  `ad_amt` varchar(255) DEFAULT NULL,
  `ad_perc` varchar(255) DEFAULT NULL,
  `loan_amt` varchar(255) DEFAULT NULL,
  `poss_type` varchar(255) DEFAULT NULL,
  `due_amt` varchar(255) DEFAULT NULL,
  `due_period` varchar(255) DEFAULT NULL,
  `cus_status` varchar(255) DEFAULT '0',
  `prompt_remark` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `in_verification`
--

INSERT INTO `in_verification` (`req_id`, `user_type`, `user_name`, `agent_id`, `responsible`, `remarks`, `declaration`, `req_code`, `dor`, `cus_reg_id`, `cus_id`, `cus_data`, `cus_name`, `dob`, `age`, `gender`, `blood_group`, `state`, `district`, `taluk`, `area`, `sub_area`, `address`, `mobile1`, `mobile2`, `father_name`, `mother_name`, `marital`, `spouse_name`, `occupation_type`, `occupation`, `pic`, `loan_category`, `sub_category`, `tot_value`, `ad_amt`, `ad_perc`, `loan_amt`, `poss_type`, `due_amt`, `due_period`, `cus_status`, `prompt_remark`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'Agent', 'Alaathi Mobiles and Furniture', '1', '0', '', 'New customer for us', 'REQ-101', '2023-07-01', '1', '010720232023', 'New', 'Bharath', '1990-02-03', '33', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '4', '46', '9846546546', '', 'Sugumar', 'Seetha', '2', '', '2', 'Supervisor', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '5', 'AC', '35000', '3000', '8.6', '32000', '1', '3470', '', '14', '', '0', '3', '3', NULL, '2023-07-01 13:26:37', '0000-00-00 00:00:00'),
(2, 'Staff', 'Arun', '2', '', 'Customer for laxhmi', '', 'REQ-102', '2023-07-01', '3', '100010001000', 'New', 'Ganesan', '1996-06-01', '27', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '5', 'TV', '20000', '3000', '15.0', '17000', '2', '', '12', '21', '', '0', '2', '2', NULL, '2023-07-01 13:36:34', '0000-00-00 00:00:00'),
(5, 'Staff', 'Arun', '', '', 'Old customer new prod', '', 'REQ-103', '2023-01-01', '3', '100010001000', 'Existing', 'Ganesan', '1996-06-01', '27', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '2', 'Bike', '65000', '5000', '7.7', '60000', '1', '4500', '', '20', '', '0', '2', '2', NULL, '2023-01-01 16:10:08', '2023-01-01 16:10:08'),
(6, 'Staff', 'Arun', '', '', 'Relative Customer', '', 'REQ-104', '2023-07-03', '4', '200020002000', 'New', 'Aravind', '1988-03-10', '35', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', '22', '9794949494', '', 'Vedha', 'Vidhya', '2', '', '4', 'Departmental Store', 'pexels-pixabay-220453.jpg', '6', 'Mobiles', '', '', '', '50000', '1', '4500', '', '21', '', '0', '2', '2', NULL, '2023-07-03 12:25:41', '2023-07-03 12:25:41'),
(7, 'Director', 'Will Smith', '', '0', '', 'Just declaration', 'REQ-105', '2023-07-03', '6', '300030003000', 'New', 'Rakesh', '1992-06-09', '31', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', '78A', '9664565132', '', 'Joshwa', 'Sheethal', '2', '', '3', 'Coconut shop', 'person_sample_4.jpg', '9', 'Education', '', '', '', '56500', '2', '', '24', '16', '', '0', '5', '5', NULL, '2023-07-03 14:53:00', '2023-07-03 14:53:00'),
(8, 'Staff', 'Arun', '', '', 'Old customer new prod', '', 'REQ-106', '2023-01-02', '4', '200020002000', 'Existing', 'Aravind', '1988-03-10', '35', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', '22', '9794949494', '', 'Vedha', 'Vidhya', '2', '', '4', 'Departmental Store', 'pexels-pixabay-220453.jpg', '1', 'Personal', '35500', '3500', '9.9', '32000', '1', '4500', '', '14', '', '0', '2', '2', NULL, '2023-01-02 16:17:35', '2023-01-02 16:17:35'),
(9, 'Staff', 'Arun', '2', '', 'Old customer new prod', '', 'REQ-107', '2023-07-15', '3', '100010001000', 'Existing', 'Ganesan', '1996-06-01', '27', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '5', 'AC', '35000', '3000', '8.6', '32000', '2', '', '10', '14', '', '0', '2', '2', NULL, '2023-07-15 10:55:01', '2023-09-05 15:17:53'),
(10, 'Staff', 'Arun', '', '', 'checking Rakesh', '', 'REQ-108', '2023-07-15', '6', '300030003000', 'Existing', 'Rakesh', '1992-06-09', '31', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', '78A', '9664565132', '', 'Joshwa', 'Sheethal', '2', '', '3', 'Coconut shop', 'person_sample_4.jpg', '1', 'Personal', '52000', '4000', '7.7', '48000', '1', '4400', '', '14', '', '0', '2', '2', NULL, '2023-07-15 11:08:11', '2023-07-15 11:08:11'),
(11, 'Staff', 'Arun', '', '', 'New customer', '', 'REQ-109', '2023-07-21', '7', '500050005000', 'New', 'Manikandan', '1995-03-02', '28', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Harington road', '7888878888', '', 'Mani Kapoor', 'Mani megalai', '2', '', '5', 'Watchman', 'musk.jpg', '1', 'Personal', '28000', '2000', '7.1', '26000', '2', '', '12', '14', '', '0', '2', '2', NULL, '2023-07-21 11:11:38', '2023-07-21 11:11:38'),
(12, 'Staff', 'Arun', '', '', 'Check', '', 'REQ-110', '2023-08-02', '8', '400040004000', 'New', 'Bharathi', '1999-01-21', '24', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '17', 'EVR', '9459416164', '994949494', 'Vedha', 'Gayathri', '2', '', '1', 'Watchman', 'images (1).jpg', '5', 'AC', '50000', '0', '0.0', '50000', '1', '1600', '', '14', '', '0', '2', '2', NULL, '2023-08-02 14:59:57', '2023-08-02 14:59:57'),
(14, 'Staff', 'Arun', '', '', 'Check', '', 'REQ-112', '2023-08-19', '4', '200020002000', 'Existing', 'Aravind', '1988-03-10', '35', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', '22', '9794949494', '', 'Vedha', 'Vidhya', '2', '', '4', 'Departmental Store', 'pexels-pixabay-220453.jpg', '7', 'Small Business', '', '', '', '50000', '1', '460', '', '3', '', '0', '2', '2', NULL, '2023-08-19 09:53:42', '2024-03-14 09:57:47'),
(16, 'Staff', 'Arun', '', '', 'Check once ', '', 'REQ-113', '2023-09-06', '9', '060120230408', 'New', 'Gnanasekar', '1990-02-14', '33', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '4', '19', 'Purisai', '9790171511', '', 'Sengunthan', 'Aarthi', '2', '', '2', 'Best Opticals', 'person_sample_2.jpg', '8', 'Plot Purchase', '50000', '0', '0.0', '50000', '2', '', '12', '13', '', '0', '2', '2', NULL, '2023-01-07 04:42:25', '2024-03-15 18:36:03'),
(17, 'Director', 'Will Smith', '', '1', '', 'okok', 'REQ-114', '2023-09-09', '10', '090920230103', 'New', 'Janaki', '2023-09-06', '0', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', 'MRS', '9002777732', '', 'Dineshkumar', 'Dineshi', '2', '', '2', 'IT', 'download.jpg', '7', 'Small Business', '', '', '', '60000', '1', '5500', '', '1', '', '0', '5', '5', NULL, '2023-09-09 13:15:22', '2023-09-09 13:15:25'),
(18, 'Staff', 'Arun', '', '', 'First Bike', '', 'REQ-115', '2023-09-13', '3', '100010001000', 'Existing', 'Ganesan', '1996-06-01', '27', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '2', 'Bike', '32000', '5000', '15.6', '27000', '1', '4500', '', '14', '', '0', '2', '2', NULL, '2023-09-13 11:46:44', '2023-09-06 12:14:25'),
(21, 'Staff', 'Jafar', '', '', 'Personal friend', '', 'REQ-118', '2023-12-27', '25', '261910026191', 'New', 'Leo Das', '1999-04-27', '25', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '16', 'MGR Salai', '2619100261', '', 'Anthony', 'Unknown', '1', 'Sathya', '1', 'Undercover Agent', '658bc19b427cb.jpg', '6', 'Mobiles', '', '', '', '45000', '1', '4000', '', '13', '', '0', '4', '4', NULL, '2023-12-27 11:48:03', '2023-12-28 10:53:27'),
(22, 'Staff', 'Arun', '', '', 'c', '', 'REQ-119', '2024-01-02', '26', '000000000001', 'New', 'Senthil kumaran', '1999-02-02', '25', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'CT', '7526312546', '', 'Kumaran', 'Kumari', '2', '', '1', 'VAO', '6593e1b875db5.png', '11', 'Interest R', '', '', '', '54000', '1', '5400', '', '14', '', '0', '2', '2', NULL, '2024-01-02 15:43:12', '2024-01-02 15:50:15'),
(23, 'Staff', 'Arun', '', '', 'c', '', 'REQ-120', '2024-01-06', '26', '000000000001', 'Existing', 'Senthil kumaran', '1999-02-02', '25', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'CT', '7526312546', '', 'Kumaran', 'Kumari', '2', '', '1', 'VAO', '6593e1b875db5.png', '7', 'Small Business', '', '', '', '11000', '2', '', '11', '14', '', '0', '2', '2', NULL, '2024-01-06 11:26:58', '2024-01-06 11:33:31'),
(24, 'Staff', 'Arun', '', '', 'c', '', 'REQ-121', '2024-01-06', '26', '000000000001', 'Existing', 'Senthil kumaran', '1999-02-02', '25', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'CT', '7526312546', '', 'Kumaran', 'Kumari', '2', '', '1', 'VAO', '6593e1b875db5.png', '8', 'Plot Purchase', '15000', '2000', '13.3', '13000', '2', '', '11', '14', '', '0', '2', '2', NULL, '2024-01-06 11:27:55', '2024-01-06 11:33:26'),
(77, 'Staff', 'Arun', '', '', '', '', 'REQ-122', '2024-01-01', '45', '123412341234', 'New', 'Rajesh', '1994-02-20', '29', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-02-21 16:00:10'),
(78, 'Staff', 'Arun', '', '', '', '', 'REQ-123', '2024-01-01', '46', '474747474747', 'New', 'Murugesan', '1994-02-20', '29', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-02-22 12:42:48'),
(79, 'Staff', 'Arun', '', '', '', '', 'REQ-124', '2024-01-01', '47', '575757575757', 'New', 'Sugumaran', '1994-02-20', '29', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-02-23 10:00:32'),
(84, 'Staff', 'Arun', '', '', '', '', 'REQ-125', '2024-01-01', '52', '676767676767', 'New', 'Ilambarithi', '1994-02-20', '29', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '14', '', '0', '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(85, 'Staff', 'Arun', '', '', 'ssf', '', 'REQ-126', '2024-03-07', '53', '789789789789', 'New', 'Arjun', '2003-02-04', '21', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', '1', '9874563210', '', 'Dheena', 'Rani', '2', '', '1', 'VAO', '65e9a17e9d353.jpg', '8', 'Plot Purchase', '50000', '5000', '10.0', '45000', '1', '155', '', '1', '', '0', '2', '2', NULL, '2024-03-07 16:44:06', '2024-03-11 17:48:57'),
(86, 'Staff', 'Arun', '', '', 'qwe', '', 'REQ-127', '2024-03-12', '53', '789789789789', 'Existing', 'Arjun', '2003-02-04', '21', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', '1', '9874563210', '', 'Dheena', 'Rani', '2', '', '1', 'VAO', '65e9a17e9d353.jpg', '11', 'Interest R', '', '', '', '15000', '1', '1111', '', '1', '', '0', '2', '2', NULL, '2024-03-12 12:24:55', '2024-03-12 12:25:04'),
(87, 'Staff', 'Arun', '', '', '', '', 'REQ-128', '2024-01-01', '54', '525252525252', 'New', 'Pooja', '1994-02-20', '29', '1', NULL, 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-03-25 13:10:14'),
(88, 'Staff', 'Arun', '', '', 'req', '', 'REQ-129', '2024-03-28', '54', '525252525252', 'Existing', 'Pooja', '1994-02-20', '29', '1', '', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '6605494c00dfe.jpg', '1', 'Personal', '100000', '0', '0.0', '100000', '1', '3000', '', '14', '', '0', '2', '2', NULL, '2024-03-28 16:14:59', '2024-03-28 17:08:05');

-- --------------------------------------------------------

--
-- Table structure for table `loan_calculation`
--

CREATE TABLE `loan_calculation` (
  `loan_cal_id` int(11) NOT NULL,
  `loan_category` varchar(250) DEFAULT NULL,
  `sub_category` varchar(250) DEFAULT NULL,
  `due_method` varchar(250) DEFAULT NULL,
  `due_type` varchar(250) DEFAULT NULL,
  `profit_method` varchar(250) DEFAULT NULL,
  `calculate_method` varchar(250) DEFAULT NULL,
  `intrest_rate_min` varchar(250) DEFAULT NULL,
  `intrest_rate_max` varchar(250) DEFAULT NULL,
  `due_period_min` varchar(250) DEFAULT NULL,
  `due_period_max` varchar(250) DEFAULT NULL,
  `document_charge_min` varchar(250) DEFAULT NULL,
  `document_charge_max` varchar(250) DEFAULT NULL,
  `processing_fee_min` varchar(250) DEFAULT NULL,
  `processing_fee_max` varchar(250) DEFAULT NULL,
  `loan_limit` varchar(255) DEFAULT NULL,
  `due_date` varchar(250) DEFAULT NULL,
  `grace_period` varchar(250) DEFAULT NULL,
  `penalty` varchar(250) DEFAULT NULL,
  `overdue` varchar(250) DEFAULT NULL,
  `collection_info` varchar(250) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `insert_login_id` int(11) DEFAULT NULL,
  `update_login_id` int(11) DEFAULT NULL,
  `delete_login_id` int(11) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_calculation`
--

INSERT INTO `loan_calculation` (`loan_cal_id`, `loan_category`, `sub_category`, `due_method`, `due_type`, `profit_method`, `calculate_method`, `intrest_rate_min`, `intrest_rate_max`, `due_period_min`, `due_period_max`, `document_charge_min`, `document_charge_max`, `processing_fee_min`, `processing_fee_max`, `loan_limit`, `due_date`, `grace_period`, `penalty`, `overdue`, `collection_info`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, '1', 'Personal', 'Monthly', 'intrest', '', 'Monthly', '1', '3', '10', '24', '1', '2', '1', '2', NULL, '', '', '', '3', 'Yes', 0, 1, 2, NULL, '2023-05-10 15:28:57', '2023-05-10 15:28:57'),
(2, '1', 'Education loan', 'Monthly', 'intrest', '', 'Monthly', '0', '1', '10', '12', '0', '1', '0', '1', NULL, '', '', '', '1', 'No', 0, 0, 1, NULL, '2023-05-11 17:31:55', '2023-05-11 17:31:55'),
(3, '4', 'Coin', 'Monthly', 'intrest', '', 'Monthly', '0', '2', '10', '12', '1', '2', '1', '2', NULL, '', '', '', '3', 'No', 0, 1, 1, NULL, '2023-05-11 17:34:49', '2023-05-11 17:34:49'),
(4, '5', 'AC', 'Monthly', 'emi', 'after_intrest', '', '1', '2', '6', '12', '1', '2', '1', '2', NULL, '', '', '', '3', 'Yes', 0, 1, 1, NULL, '2023-05-11 17:37:01', '2023-05-11 17:37:01'),
(5, '2', 'Bike', 'Monthly', 'emi', 'after_intrest', '', '1', '2', '10', '12', '1', '2', '1', '2', NULL, '', '', '', '3', 'Yes', 0, 1, 1, NULL, '2023-05-11 17:39:26', '2023-05-11 17:39:26'),
(6, '5', 'AC', 'Monthly', 'emi', 'pre_intrest,after_intrest', '', '1', '2', '5', '10', '1', '2', '1', '2', NULL, '', '', '', '3', 'No', 0, 1, 1, NULL, '2023-05-11 18:49:16', '2023-05-11 18:49:16'),
(7, '6', 'Mobiles', 'Monthly', 'emi', 'pre_intrest', '', '1', '2', '5', '10', '1', '2', '1', '2', NULL, '', '', '', '3', 'No', 0, 1, NULL, NULL, '2023-05-11 18:50:52', '2023-05-11 18:50:52'),
(8, '6', 'Tab', 'Monthly', 'emi', 'pre_intrest', '', '1', '2', '5', '10', '1', '2', '1', '2', NULL, '', '', '', '3', 'No', 0, 1, NULL, NULL, '2023-05-11 18:51:55', '2023-05-11 18:51:55'),
(9, '7', 'Small Business', 'Monthly', 'emi', 'pre_intrest,after_intrest', '', '1.5', '3', '5', '18', '1', '2', '0', '1', NULL, '', '', '', '3', 'No', 0, 1, 1, NULL, '2023-05-12 15:27:55', '2023-05-12 15:27:55'),
(10, '8', 'Plot Purchase', 'Monthly', 'emi', 'after_intrest', '', '1.5', '3', '12', '24', '2', '3', '1', '2', NULL, '', '', '', '2', 'Yes', 0, 1, NULL, NULL, '2023-05-12 15:42:34', '2023-05-12 15:42:34'),
(11, '5', 'TV', 'Monthly', 'emi', 'pre_intrest,after_intrest', '', '1', '2', '5', '10', '1', '2', '1', '2', NULL, '', '', '', '3', 'Yes', 0, 1, NULL, NULL, '2023-05-13 15:16:48', '2023-05-13 15:16:48'),
(12, '5', 'fridge', 'Monthly', 'emi', 'pre_intrest,after_intrest', '', '1', '2', '6', '10', '1', '2', '1', '2', NULL, '', '', '', '3', 'No', 0, 1, 1, NULL, '2023-05-13 16:03:56', '2023-05-13 16:03:56'),
(13, '9', 'Education', 'Monthly', 'intrest', '', 'Monthly', '1', '2', '10', '18', '1', '2', '1', '2', NULL, '', '', '', '3', 'No', 0, 1, 1, NULL, '2023-05-14 13:16:55', '2023-05-14 13:16:55'),
(14, '10', 'Home loan', 'Monthly', 'intrest', '', 'Monthly', '1', '2', '12', '18', '1', '2', '1', '2', NULL, '', '', '', '3', 'Yes', 0, 1, 1, NULL, '2023-05-15 16:44:29', '2023-05-15 16:44:29'),
(15, '11', 'Personal loan R', 'Monthly', 'emi', 'pre_intrest', '', '0', '2', '5', '10', '0', '2', '0', '2', NULL, '', '', '', '2', 'No', 0, 1, NULL, NULL, '2023-06-13 11:37:20', '2023-06-13 11:37:20'),
(16, '5', 'AC Pre R ', 'Monthly', 'emi', 'pre_intrest', '', '0', '2', '5', '10', '0', '2', '0', '2', NULL, '', '', '', '2', 'Yes', 0, 1, NULL, NULL, '2023-06-13 11:39:00', '2023-06-13 11:39:00'),
(17, '5', 'TV After R', 'Monthly', 'emi', 'after_intrest', '', '0', '2', '5', '10', '0', '2', '0', '2', NULL, '', '', '', '2', 'Yes', 0, 1, NULL, NULL, '2023-06-13 11:40:56', '2023-06-13 11:40:56'),
(18, '11', 'Interest R', 'Monthly', 'intrest', '', 'Monthly', '0', '2', '5', '10', '0', '2', '0', '2', NULL, '', '', '', '2', 'No', 0, 1, NULL, NULL, '2023-06-13 11:46:45', '2023-06-13 11:46:45'),
(19, '4', 'Chain Pre aftr R', 'Monthly', 'emi', 'pre_intrest,after_intrest', '', '0', '2', '5', '10', '0', '2', '0', '2', NULL, '', '', '', '2', 'No', 0, 1, NULL, NULL, '2023-06-13 11:48:50', '2023-06-13 11:48:50');

-- --------------------------------------------------------

--
-- Table structure for table `loan_category`
--

CREATE TABLE `loan_category` (
  `loan_category_id` int(11) NOT NULL,
  `loan_category_name` varchar(255) DEFAULT NULL,
  `sub_category_name` varchar(255) DEFAULT NULL,
  `loan_limit` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `insert_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `delete_user_id` int(11) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_category`
--

INSERT INTO `loan_category` (`loan_category_id`, `loan_category_name`, `sub_category_name`, `loan_limit`, `status`, `insert_user_id`, `update_user_id`, `delete_user_id`, `created_date`, `updated_date`) VALUES
(3, '4', 'Coin', '54136', 0, 1, NULL, NULL, '2023-05-11 17:22:20', '2023-05-11 17:22:20'),
(4, '2', 'Bike', '69966', 0, 1, NULL, NULL, '2023-05-11 17:24:40', '2023-05-11 17:24:40'),
(5, '2', 'Scooty', '52420', 0, 1, NULL, NULL, '2023-05-11 17:25:33', '2023-05-11 17:25:33'),
(6, '4', 'Chain', '52204', 0, 1, NULL, NULL, '2023-05-11 17:28:02', '2023-05-11 17:28:02'),
(7, '5', 'TV', '58761', 0, 1, NULL, NULL, '2023-05-11 18:40:07', '2023-05-11 18:40:07'),
(8, '6', 'Mobiles', '47192', 0, 1, NULL, NULL, '2023-05-11 18:45:07', '2023-05-11 18:45:07'),
(9, '6', 'Tab', '59679', 0, 1, NULL, NULL, '2023-05-11 18:45:33', '2023-05-11 18:45:33'),
(10, '5', 'AC', '66820', 0, 1, NULL, NULL, '2023-05-11 18:47:54', '2023-05-11 18:47:54'),
(11, '5', 'Mobile', '65061', 0, 1, NULL, NULL, '2023-05-12 14:59:38', '2023-05-12 14:59:38'),
(12, '7', 'Small Business', '79844', 0, 1, NULL, NULL, '2023-05-12 15:01:54', '2023-05-12 15:01:54'),
(13, '7', 'Medium Business', '69036', 0, 1, NULL, NULL, '2023-05-12 15:02:33', '2023-05-12 15:02:33'),
(14, '7', 'Large Business', '60648', 0, 1, NULL, NULL, '2023-05-12 15:03:20', '2023-05-12 15:03:20'),
(15, '8', 'Plot Purchase', '51132', 0, 1, NULL, NULL, '2023-05-12 15:05:48', '2023-05-12 15:05:48'),
(16, '8', 'Construction Loan', '73720', 0, 1, NULL, NULL, '2023-05-12 15:08:00', '2023-05-12 15:08:00'),
(17, '1', 'Educarion', '80200', 0, 1, NULL, NULL, '2023-05-12 15:51:50', '2023-05-12 15:51:50'),
(18, '5', 'Fridge', '89841', 0, 1, NULL, NULL, '2023-05-13 16:02:40', '2023-05-13 16:02:40'),
(19, '9', 'Education', '73604', 0, 1, NULL, NULL, '2023-05-14 12:27:16', '2023-05-14 12:27:16'),
(20, '1', 'Personal', '100000', 0, 1, NULL, NULL, '2023-05-15 15:59:27', '2023-05-15 15:59:27'),
(21, '10', 'Home loan', '46680', 0, 1, NULL, NULL, '2023-05-15 16:43:15', '2023-05-15 16:43:15'),
(22, '7', 'SME Loan', '72906', 0, 1, NULL, NULL, '2023-06-08 11:35:08', '2023-06-08 11:35:08'),
(23, '2', 'Car Loan', '89490', 0, 1, NULL, NULL, '2023-06-08 11:40:10', '2023-06-08 11:40:10'),
(24, '8', 'Agri Land', '48727', 0, 1, NULL, NULL, '2023-06-08 11:42:16', '2023-06-08 11:42:16'),
(25, '3', 'Construction Loan', '65171', 0, 1, NULL, NULL, '2023-06-08 11:43:49', '2023-06-08 11:43:49'),
(26, '11', 'Personal loan R', '89673', 0, 1, NULL, NULL, '2023-06-13 11:11:33', '2023-06-13 11:11:33'),
(27, '5', 'AC Pre R ', '72850', 0, 1, NULL, NULL, '2023-06-13 11:15:46', '2023-06-13 11:15:46'),
(28, '5', 'TV After R', '50232', 0, 1, NULL, NULL, '2023-06-13 11:21:38', '2023-06-13 11:21:38'),
(29, '4', 'Chain Pre aftr R', '77614', 0, 1, NULL, NULL, '2023-06-13 11:33:16', '2023-06-13 11:33:16'),
(30, '11', 'Interest R', '57369', 0, 1, NULL, NULL, '2023-06-13 11:34:58', '2023-06-13 11:34:58'),
(31, '9', 'asdfa', '54004', 0, 1, NULL, NULL, '2023-06-29 15:52:36', '2023-06-29 15:52:36');

-- --------------------------------------------------------

--
-- Table structure for table `loan_category_creation`
--

CREATE TABLE `loan_category_creation` (
  `loan_category_creation_id` int(11) NOT NULL,
  `loan_category_creation_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `insert_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `delete_user_id` int(11) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_category_creation`
--

INSERT INTO `loan_category_creation` (`loan_category_creation_id`, `loan_category_creation_name`, `status`, `insert_user_id`, `update_user_id`, `delete_user_id`, `created_date`, `updated_date`) VALUES
(1, 'Personal', 0, NULL, NULL, NULL, '2023-05-10 02:57:14', '2023-05-10 02:57:14'),
(2, 'Vehicle loan', 0, NULL, NULL, NULL, '2023-05-11 04:46:41', '2023-05-11 04:46:41'),
(3, 'Housing loan', 0, NULL, NULL, NULL, '2023-05-11 04:46:54', '2023-05-11 04:46:54'),
(4, 'Gold loan', 0, NULL, NULL, NULL, '2023-05-11 04:47:07', '2023-05-11 04:47:07'),
(5, 'Home Appliance', 0, NULL, NULL, NULL, '2023-05-11 06:05:51', '2023-05-11 06:05:51'),
(6, 'Digital products', 0, NULL, NULL, NULL, '2023-05-11 06:06:34', '2023-05-11 06:06:34'),
(7, 'Business', 0, NULL, NULL, NULL, '2023-05-12 02:30:02', '2023-05-12 02:30:02'),
(8, 'Property ', 0, NULL, NULL, NULL, '2023-05-12 02:33:55', '2023-05-12 02:33:55'),
(9, 'Education', 0, NULL, NULL, NULL, '2023-05-13 23:55:50', '2023-05-13 23:55:50'),
(10, 'Home ', 0, NULL, NULL, NULL, '2023-05-15 04:07:47', '2023-05-15 04:07:47'),
(11, 'Finance R', 0, NULL, NULL, NULL, '2023-06-12 22:39:15', '2023-06-12 22:39:15');

-- --------------------------------------------------------

--
-- Table structure for table `loan_category_ref`
--

CREATE TABLE `loan_category_ref` (
  `loan_category_ref_id` int(11) NOT NULL,
  `loan_category_ref_name` varchar(255) DEFAULT NULL,
  `loan_category_id` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `insert_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `delete_user_id` int(11) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_category_ref`
--

INSERT INTO `loan_category_ref` (`loan_category_ref_id`, `loan_category_ref_name`, `loan_category_id`, `status`, `insert_user_id`, `update_user_id`, `delete_user_id`, `created_date`, `updated_date`) VALUES
(9, 'Company', '4', 0, NULL, NULL, NULL, '2023-05-11 17:24:40', '2023-05-11 17:24:40'),
(10, 'Model', '4', 0, NULL, NULL, NULL, '2023-05-11 17:24:40', '2023-05-11 17:24:40'),
(11, 'Gold Type', '3', 0, NULL, NULL, NULL, '2023-05-11 17:27:14', '2023-05-11 17:27:14'),
(12, 'Gram / sovereign', '3', 0, NULL, NULL, NULL, '2023-05-11 17:27:14', '2023-05-11 17:27:14'),
(13, 'Market value', '3', 0, NULL, NULL, NULL, '2023-05-11 17:27:14', '2023-05-11 17:27:14'),
(14, 'Brand', '11', 0, NULL, NULL, NULL, '2023-05-12 14:59:38', '2023-05-12 14:59:38'),
(15, 'Model', '11', 0, NULL, NULL, NULL, '2023-05-12 14:59:38', '2023-05-12 14:59:38'),
(16, 'IMEI Number', '11', 0, NULL, NULL, NULL, '2023-05-12 14:59:38', '2023-05-12 14:59:38'),
(17, 'Business type', '12', 0, NULL, NULL, NULL, '2023-05-12 15:01:54', '2023-05-12 15:01:54'),
(18, 'Ownership', '12', 0, NULL, NULL, NULL, '2023-05-12 15:01:54', '2023-05-12 15:01:54'),
(19, 'Business type', '13', 0, NULL, NULL, NULL, '2023-05-12 15:02:33', '2023-05-12 15:02:33'),
(20, 'Ownership', '13', 0, NULL, NULL, NULL, '2023-05-12 15:02:33', '2023-05-12 15:02:33'),
(21, 'CIN', '14', 0, NULL, NULL, NULL, '2023-05-12 15:03:20', '2023-05-12 15:03:20'),
(22, 'Business Type', '14', 0, NULL, NULL, NULL, '2023-05-12 15:03:20', '2023-05-12 15:03:20'),
(23, 'PAN', '14', 0, NULL, NULL, NULL, '2023-05-12 15:03:20', '2023-05-12 15:03:20'),
(24, 'Plot Dimension', '15', 0, NULL, NULL, NULL, '2023-05-12 15:05:48', '2023-05-12 15:05:48'),
(25, 'Sq ft', '15', 0, NULL, NULL, NULL, '2023-05-12 15:05:48', '2023-05-12 15:05:48'),
(26, 'Plot Value', '15', 0, NULL, NULL, NULL, '2023-05-12 15:05:48', '2023-05-12 15:05:48'),
(27, 'Total Value For Construction', '16', 0, NULL, NULL, NULL, '2023-05-12 15:08:00', '2023-05-12 15:08:00'),
(28, 'Ownership Detail', '16', 0, NULL, NULL, NULL, '2023-05-12 15:08:00', '2023-05-12 15:08:00'),
(29, 'Company', '5', 0, NULL, NULL, NULL, '2023-05-12 15:37:17', '2023-05-12 15:37:17'),
(30, 'Model', '5', 0, NULL, NULL, NULL, '2023-05-12 15:37:17', '2023-05-12 15:37:17'),
(31, 'Company', '10', 0, NULL, NULL, NULL, '2023-05-12 15:43:12', '2023-05-12 15:43:12'),
(32, 'AC capacity', '10', 0, NULL, NULL, NULL, '2023-05-12 15:43:12', '2023-05-12 15:43:12'),
(33, 'AC type', '10', 0, NULL, NULL, NULL, '2023-05-12 15:43:12', '2023-05-12 15:43:12'),
(34, 'Brand', '9', 0, NULL, NULL, NULL, '2023-05-12 15:47:30', '2023-05-12 15:47:30'),
(35, 'Screen size', '9', 0, NULL, NULL, NULL, '2023-05-12 15:47:30', '2023-05-12 15:47:30'),
(36, 'Brand', '8', 0, NULL, NULL, NULL, '2023-05-12 15:48:00', '2023-05-12 15:48:00'),
(37, 'Screen size', '8', 0, NULL, NULL, NULL, '2023-05-12 15:48:00', '2023-05-12 15:48:00'),
(38, 'Passed out ', '17', 0, NULL, NULL, NULL, '2023-05-12 15:53:44', '2023-05-12 15:53:44'),
(39, 'percentage', '17', 0, NULL, NULL, NULL, '2023-05-12 15:53:44', '2023-05-12 15:53:44'),
(40, 'Brand ', '7', 0, NULL, NULL, NULL, '2023-05-13 15:15:44', '2023-05-13 15:15:44'),
(41, 'Screen size', '7', 0, NULL, NULL, NULL, '2023-05-13 15:15:44', '2023-05-13 15:15:44'),
(42, 'TV Type', '7', 0, NULL, NULL, NULL, '2023-05-13 15:15:44', '2023-05-13 15:15:44'),
(43, 'Brand', '18', 0, NULL, NULL, NULL, '2023-05-13 16:23:16', '2023-05-13 16:23:16'),
(44, 'Door', '18', 0, NULL, NULL, NULL, '2023-05-13 16:23:16', '2023-05-13 16:23:16'),
(45, 'Institute', '19', 0, NULL, NULL, NULL, '2023-05-15 11:02:43', '2023-05-15 11:02:43'),
(46, 'Class', '19', 0, NULL, NULL, NULL, '2023-05-15 11:02:43', '2023-05-15 11:02:43'),
(47, 'Current salary', '20', 0, NULL, NULL, NULL, '2023-05-15 15:59:27', '2023-05-15 15:59:27'),
(48, 'Business Type', '22', 0, NULL, NULL, NULL, '2023-06-08 11:35:52', '2023-06-08 11:35:52'),
(49, 'Bussiness Value', '22', 0, NULL, NULL, NULL, '2023-06-08 11:35:52', '2023-06-08 11:35:52'),
(50, 'Business Location', '22', 0, NULL, NULL, NULL, '2023-06-08 11:35:52', '2023-06-08 11:35:52'),
(51, '', '22', 0, NULL, NULL, NULL, '2023-06-08 11:35:52', '2023-06-08 11:35:52'),
(52, 'Brand', '23', 0, NULL, NULL, NULL, '2023-06-08 11:40:10', '2023-06-08 11:40:10'),
(53, 'Model', '23', 0, NULL, NULL, NULL, '2023-06-08 11:40:10', '2023-06-08 11:40:10'),
(54, 'Acre', '24', 0, NULL, NULL, NULL, '2023-06-08 11:42:16', '2023-06-08 11:42:16'),
(55, 'Borewel type', '24', 0, NULL, NULL, NULL, '2023-06-08 11:42:16', '2023-06-08 11:42:16'),
(56, 'Harvesting type', '24', 0, NULL, NULL, NULL, '2023-06-08 11:42:16', '2023-06-08 11:42:16'),
(57, 'Quotation Value', '25', 0, NULL, NULL, NULL, '2023-06-08 11:43:49', '2023-06-08 11:43:49'),
(58, 'Current Designation', '26', 0, NULL, NULL, NULL, '2023-06-13 11:12:10', '2023-06-13 11:12:10'),
(59, 'No. of months working', '26', 0, NULL, NULL, NULL, '2023-06-13 11:12:10', '2023-06-13 11:12:10'),
(60, 'Salary', '26', 0, NULL, NULL, NULL, '2023-06-13 11:12:10', '2023-06-13 11:12:10'),
(61, 'Company', '27', 0, NULL, NULL, NULL, '2023-06-13 11:20:35', '2023-06-13 11:20:35'),
(62, 'Model', '27', 0, NULL, NULL, NULL, '2023-06-13 11:20:35', '2023-06-13 11:20:35'),
(63, 'Year', '27', 0, NULL, NULL, NULL, '2023-06-13 11:20:35', '2023-06-13 11:20:35'),
(64, 'Company', '28', 0, NULL, NULL, NULL, '2023-06-13 11:21:38', '2023-06-13 11:21:38'),
(65, 'Model', '28', 0, NULL, NULL, NULL, '2023-06-13 11:21:38', '2023-06-13 11:21:38'),
(66, 'Year', '28', 0, NULL, NULL, NULL, '2023-06-13 11:21:38', '2023-06-13 11:21:38'),
(67, 'Purity', '29', 0, NULL, NULL, NULL, '2023-06-13 11:33:16', '2023-06-13 11:33:16'),
(68, 'Gram', '29', 0, NULL, NULL, NULL, '2023-06-13 11:33:16', '2023-06-13 11:33:16'),
(69, 'Current designation', '30', 0, NULL, NULL, NULL, '2023-06-13 11:34:58', '2023-06-13 11:34:58'),
(70, 'No. of months working', '30', 0, NULL, NULL, NULL, '2023-06-13 11:34:58', '2023-06-13 11:34:58'),
(71, 'Salary', '30', 0, NULL, NULL, NULL, '2023-06-13 11:34:58', '2023-06-13 11:34:58'),
(72, 'ertert', '31', 0, NULL, NULL, NULL, '2023-06-29 15:52:36', '2023-06-29 15:52:36');

-- --------------------------------------------------------

--
-- Table structure for table `loan_followup`
--

CREATE TABLE `loan_followup` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(255) NOT NULL,
  `stage` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `follow_date` date NOT NULL,
  `insert_login_id` varchar(50) NOT NULL,
  `update_login_id` varchar(50) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_followup`
--

INSERT INTO `loan_followup` (`id`, `cus_id`, `stage`, `label`, `remark`, `follow_date`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '100010001000', 'Acknowledgement', 'Check', 'Check', '2023-08-21', '2', NULL, '2023-08-21 12:27:01', '2023-08-21 12:27:01'),
(2, '100010001000', 'Acknowledgement', 'Check', 'Check', '2023-08-20', '2', NULL, '2023-08-21 12:27:34', '2023-08-21 12:27:34'),
(3, '100010001000', 'Acknowledgement', 'Check', 'Check', '2023-08-22', '2', NULL, '2023-08-21 12:27:56', '2023-08-21 12:27:56'),
(4, '200020002000', 'Verification', 'Check', 'Check', '2023-09-05', '2', NULL, '2023-09-05 16:29:23', '2023-09-05 16:29:23'),
(5, '200020002000', 'Verification', 'check for future', 'check for future', '2023-09-15', '2', NULL, '2023-09-13 18:37:17', '2023-09-13 18:37:17');

-- --------------------------------------------------------

--
-- Table structure for table `loan_issue`
--

CREATE TABLE `loan_issue` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `issued_to` varchar(255) NOT NULL,
  `agent_id` varchar(255) NOT NULL,
  `issued_mode` varchar(50) NOT NULL,
  `payment_type` varchar(50) NOT NULL,
  `cash` varchar(255) DEFAULT NULL,
  `bank_id` varchar(10) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `cheque_value` varchar(255) NOT NULL,
  `cheque_remark` varchar(255) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `transaction_value` varchar(255) NOT NULL,
  `transaction_remark` varchar(255) NOT NULL,
  `balance_amount` varchar(255) NOT NULL,
  `loan_amt` varchar(255) NOT NULL,
  `net_cash` varchar(255) NOT NULL,
  `cash_guarentor_name` varchar(255) NOT NULL,
  `relationship` varchar(100) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(50) DEFAULT NULL,
  `update_login_id` varchar(50) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_issue`
--

INSERT INTO `loan_issue` (`id`, `req_id`, `cus_id`, `issued_to`, `agent_id`, `issued_mode`, `payment_type`, `cash`, `bank_id`, `cheque_no`, `cheque_value`, `cheque_remark`, `transaction_id`, `transaction_value`, `transaction_remark`, `balance_amount`, `loan_amt`, `net_cash`, `cash_guarentor_name`, `relationship`, `status`, `insert_login_id`, `update_login_id`, `created_date`) VALUES
(1, '6', '200020002000', 'Aravind', '', '1', '0', '43600', '', '', '', '', '', '', '', '0', '50000', '43600', '200020002000', 'Customer', '0', '2', NULL, '2023-07-11 10:02:25'),
(2, '5', '100010001000', 'Ganesan', '', '1', '0', '52561', '', '', '', '', '', '', '', '0', '60000', '52561', '100010001000', 'Customer', '0', '2', NULL, '2023-01-13 10:55:10'),
(3, '7', '300030003000', 'Rakesh', '', '1', '0', '44865', '', '', '', '', '', '', '', '0', '56790', '44865', '300030003000', 'Customer', '0', '5', NULL, '2023-01-03 14:55:24'),
(4, '8', '200020002000', 'Aravind', '', '1', '0', '29575', '', '', '', '', '', '', '', '0', '32500', '29575', '200020002000', 'Customer', '0', '2', NULL, '2023-01-01 16:26:05'),
(7, '1', '010720232023', 'Agent', '1', '', '', '36260', '', '', '', '', '', '', '', '0', '37000', '36260', '', '', NULL, '3', NULL, '2023-07-19 10:59:17'),
(8, '11', '500050005000', 'Manikandan', '', '1', '0', '23660', '', '', '', '', '', '', '', '0', '26000', '23660', '500050005000', 'Customer', '0', '2', NULL, '2023-07-21 16:53:32'),
(9, '12', '400040004000', 'Bharathi', '', '1', '0', '98000', '', '', '', '', '', '', '', '0', '100000', '98000', '400040004000', 'Customer', '0', '2', NULL, '2023-08-02 15:13:27'),
(10, '10', '300030003000', 'Rakesh', '', '1', '0', '44884', '', '', '', '', '', '', '', '0', '45800', '44884', '300030003000', 'Customer', '0', '2', NULL, '2023-08-07 12:01:54'),
(11, '9', '100010001000', 'Agent', '2', '', '', '18130', '', '', '', '', '', '', '', '0', '18500', '18130', '', '', NULL, '2', NULL, '2023-09-05 15:18:08'),
(12, '18', '100010001000', 'Ganesan', '', '1', '0', '23760', '', '', '', '', '', '', '', '0', '27000', '23760', '100010001000', 'Customer', '0', '2', NULL, '2023-09-06 12:16:40'),
(13, '22', '000000000001', 'Senthil kumaran', '', '1', '0', '53260', '', '', '', '', '', '', '', '0', '54000', '53260', '000000000001', '', '0', '2', NULL, '2024-01-02 15:51:11'),
(14, '24', '000000000001', 'Senthil kumaran', '', '1', '0', '21749', '', '', '', '', '', '', '', '0', '25000', '21749', '000000000001', '', '0', '2', NULL, '2024-01-06 11:34:23'),
(15, '23', '000000000001', 'Senthil kumaran', '', '1', '0', '8140', '', '', '', '', '', '', '', '0', '11000', '8140', '000000000001', '', '0', '2', NULL, '2024-01-06 11:34:50'),
(21, '77', '123412341234', 'Rajesh', '', '1', '0', '24500', '', '', '', '', '', '', '', '0', '25000', '24500', '123412341234', 'Customer', '0', '2', NULL, '2024-01-10 00:00:00'),
(22, '78', '474747474747', 'Murugesan', '', '1', '0', '24500', '', '', '', '', '', '', '', '0', '25000', '24500', '474747474747', 'Customer', '0', '2', NULL, '2024-01-10 00:00:00'),
(23, '79', '575757575757', 'Sugumaran', '', '1', '0', '24500', '', '', '', '', '', '', '', '0', '25000', '24500', '575757575757', 'Customer', '0', '2', NULL, '2024-01-10 00:00:00'),
(26, '84', '676767676767', 'Ilambarithi', '', '1', '0', '24500', '', '', '', '', '', '', '', '0', '25000', '24500', '123123000000', 'Spouse', '0', '2', NULL, '2024-01-10 00:00:00'),
(27, '87', '525252525252', 'Rajesh', '', '1', '0', '24500', '', '', '', '', '', '', '', '0', '25000', '24500', '123412341234', 'Customer', '0', '2', NULL, '2024-01-10 00:00:00'),
(28, '88', '525252525252', 'Pooja', '', '1', '0', '97000', '', '', '', '', '', '', '', '0', '100000', '97000', '525252525252', '', '0', '2', NULL, '2024-03-28 17:08:49');

-- --------------------------------------------------------

--
-- Table structure for table `loan_scheme`
--

CREATE TABLE `loan_scheme` (
  `scheme_id` int(11) NOT NULL,
  `scheme_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `due_method` varchar(255) DEFAULT NULL,
  `profit_method` varchar(255) DEFAULT NULL,
  `intrest_rate` varchar(255) DEFAULT NULL,
  `total_due` varchar(255) DEFAULT NULL,
  `advance_due` varchar(255) DEFAULT NULL,
  `due_period` varchar(255) DEFAULT NULL,
  `doc_charge_type` varchar(255) DEFAULT NULL,
  `doc_charge_min` varchar(255) DEFAULT NULL,
  `doc_charge_max` varchar(255) DEFAULT NULL,
  `proc_fee_type` varchar(255) DEFAULT NULL,
  `proc_fee_min` varchar(255) DEFAULT NULL,
  `proc_fee_max` varchar(255) DEFAULT NULL,
  `due_date` varchar(255) DEFAULT NULL,
  `overdue` varchar(255) DEFAULT NULL,
  `grace_period` varchar(255) DEFAULT NULL,
  `penalty` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `insert_login_id` int(11) DEFAULT NULL,
  `update_login_id` int(11) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_scheme`
--

INSERT INTO `loan_scheme` (`scheme_id`, `scheme_name`, `short_name`, `loan_category`, `sub_category`, `due_method`, `profit_method`, `intrest_rate`, `total_due`, `advance_due`, `due_period`, `doc_charge_type`, `doc_charge_min`, `doc_charge_max`, `proc_fee_type`, `proc_fee_min`, `proc_fee_max`, `due_date`, `overdue`, `grace_period`, `penalty`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'Scheme 1B', '1B', '1', 'Personal', 'monthly', 'pre_intrest', '8', '5', '1', '4', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 1, 1, NULL, '2023-05-11 17:46:49', '2023-05-15 17:27:53'),
(2, 'Scheme 1A', '1A', '1', 'Education loan', 'monthly', 'pre_intrest', '7', '12', '2', '10', 'percentage', '0', '1', 'percentage', '0', '1', '', '1', '', '', 0, 1, NULL, NULL, '2023-05-11 17:48:27', '2023-05-11 17:48:27'),
(3, 'Scheme 2A', '2A', '4', 'Coin', 'monthly', 'pre_intrest', '8', '7', '2', '5', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 1, 1, 1, '1', '2023-05-11 17:50:07', '2023-05-15 17:33:14'),
(4, 'Scheme 2B', '2B', '4', 'Chain', 'monthly', 'pre_intrest', '9', '12', '1', '11', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 1, NULL, NULL, '2023-05-11 17:50:57', '2023-05-11 17:50:57'),
(5, 'Scheme 3A', '3A', '2', 'Bike', 'monthly', 'pre_intrest', '10', '8', '2', '6', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 1, 1, NULL, '2023-05-11 17:52:22', '2023-05-15 17:29:43'),
(6, 'Scheme 1A', '1A', '1', 'Personal', 'weekly', 'pre_intrest', '7', NULL, NULL, '22', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', NULL, NULL, 0, 1, 1, NULL, '2023-05-11 17:53:34', '2023-05-15 17:41:22'),
(7, 'scheme 2A', '2A', '4', 'Chain', 'weekly', 'pre_intrest', '8', NULL, NULL, '12', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', NULL, NULL, 1, 1, NULL, '1', '2023-05-11 17:54:50', '2023-05-11 17:54:50'),
(8, 'Scheme 1A', '1A', '1', 'Personal', 'daily', 'pre_intrest', '7', NULL, NULL, '20', 'percentage', '1', '2', 'percentage', '1', '2', NULL, '3', NULL, NULL, 0, 1, 1, NULL, '2023-05-11 17:56:33', '2023-05-15 17:41:38'),
(9, 'Scheme 2A', '2A', '1', 'Personal', 'daily', 'pre_intrest', '8', NULL, NULL, '150', 'percentage', '1', '2', 'percentage', '1', '2', NULL, '3', NULL, NULL, 0, 1, NULL, NULL, '2023-05-11 17:57:26', '2023-05-11 17:57:26'),
(10, 'Scheme 3A', '3A', '5', 'TV', 'monthly', 'pre_intrest', '10', '10', '2', '8', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 1, NULL, NULL, '2023-05-12 09:51:01', '2023-05-12 09:51:01'),
(11, 'Scheme 3A', '3A', '5', 'AC', 'monthly', 'pre_intrest', '10', '10', '2', '8', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 1, 1, NULL, '2023-05-12 09:51:58', '2023-05-13 15:17:15'),
(12, 'SB Monthly', 'SB 5', '7', 'Small Business', 'monthly', 'pre_intrest', '12', '5', '', '5', 'amt', '0', '0', 'amt', '0', '0', '', '3', '', '', 0, 1, 1, NULL, '2023-05-12 15:44:11', '2023-05-12 15:46:35'),
(13, 'SB Weekly', 'SB 10', '7', 'Small Business', 'weekly', 'pre_intrest', '12', NULL, NULL, '10', 'percentage', '0', '2', 'amt', '0', '1', '', '3', NULL, NULL, 0, 1, NULL, NULL, '2023-05-12 15:45:05', '2023-05-12 15:45:05'),
(14, 'SB Daily', 'SB 100', '7', 'Small Business', 'daily', 'pre_intrest', '12', NULL, NULL, '100', 'percentage', '1', '2', 'amt', '0', '1', NULL, '3', NULL, NULL, 0, 1, 1, NULL, '2023-05-12 15:45:49', '2023-05-12 15:46:10'),
(15, 'Scheme 4A', '4A', '5', 'fridge', 'monthly', 'pre_intrest', '10', '10', '3', '7', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 1, NULL, NULL, '2023-05-13 16:05:13', '2023-05-13 16:05:13'),
(16, 'Education', 'Edu 10', '9', 'Education', 'monthly', 'pre_intrest', '11', '10', '0', '10', 'percentage', '5', '6', 'percentage', '5', '6', '', '3', '', '', 0, 1, NULL, NULL, '2023-05-14 12:29:16', '2023-05-14 12:29:16'),
(17, 'Large 50', 'L 50', '7', 'Large Business', 'monthly', 'pre_intrest', '20', '20', '0', '20', 'percentage', '2', '2', 'percentage', '0', '2', '', '2', '', '', 0, 1, NULL, NULL, '2023-05-15 12:07:52', '2023-05-15 12:07:52'),
(18, 'Scheme 4A', '4A', '10', 'Home loan', 'monthly', 'pre_intrest', '10', '10', '3', '7', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 1, 1, NULL, '2023-05-15 17:24:37', '2023-05-15 17:29:03'),
(19, 'Scheme 2A', '2A', '4', 'Coin', 'monthly', 'pre_intrest', '8', '7', '2', '5', 'percentage', '1', '2', 'percentage', '1', '2', '', '3', '', '', 0, 0, 1, NULL, '2023-05-15 17:32:05', '2023-05-15 17:34:31'),
(20, 'SME 10', 'S10', '7', 'SME Loan', 'monthly', 'pre_intrest', '15', '10', '0', '10', 'percentage', '0', '2', 'percentage', '0', '2', '', '3', '', '', 0, 1, NULL, NULL, '2023-06-08 12:17:21', '2023-06-08 12:17:21'),
(21, 'Scheme 10 R', '10 R', '5', 'AC Pre R ', 'monthly', 'pre_intrest', '2', '10', '3', '7', 'percentage', '0', '2', 'percentage', '0', '2', '', '2', '', '', 0, 1, 1, NULL, '2023-06-13 11:54:53', '2023-06-13 12:00:20'),
(22, 'Scheme 5 R', '5 R', '11', 'Personal loan R', 'weekly', 'pre_intrest', '2', NULL, NULL, '5', 'percentage', '0', '2', 'percentage', '0', '2', '', '2', NULL, NULL, 0, 1, 1, NULL, '2023-06-13 11:56:37', '2023-06-13 12:00:33'),
(23, 'Scheme 100 R', '100 R', '11', 'Personal loan R', 'daily', 'pre_intrest', '2', NULL, NULL, '100', 'percentage', '0', '2', 'percentage', '0', '2', NULL, '2', NULL, NULL, 0, 1, 1, NULL, '2023-06-13 11:59:57', '2023-06-13 12:00:45'),
(26, 'Daily int', 'Daily int', '11', 'Interest R', 'daily', 'pre_intrest', '1', NULL, NULL, '45', 'amt', '100', '200', 'amt', '100', '200', NULL, '1', NULL, NULL, 0, 2, NULL, NULL, '2024-01-02 15:48:37', '2024-01-02 15:48:37');

-- --------------------------------------------------------

--
-- Table structure for table `loan_summary_feedback`
--

CREATE TABLE `loan_summary_feedback` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `feedback_label` varchar(255) DEFAULT NULL,
  `cus_feedback` varchar(255) DEFAULT NULL,
  `feedback_remark` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_summary_feedback`
--

INSERT INTO `loan_summary_feedback` (`id`, `req_id`, `cus_id`, `feedback_label`, `cus_feedback`, `feedback_remark`) VALUES
(1, '6', '200020002000', 'Average customer', '3', 'Average customer'),
(2, '2', '100010001000', 'Check ok', '4', 'Check ok');

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `screens` varchar(255) DEFAULT NULL,
  `modules` varchar(255) DEFAULT NULL,
  `access` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `screens`, `modules`, `access`) VALUES
(61, 'Company Creation', 'edit_company_creation', 'company_creation'),
(62, 'Branch Creation', 'edit_branch_creation', 'branch_creation'),
(63, 'Loan Category', 'edit_loan_category', 'loan_category'),
(64, 'Loan Calculation', 'edit_loan_calculation', 'loan_calculation'),
(65, 'Loan Scheme', 'edit_loan_scheme', 'loan_scheme'),
(66, 'Area Creation', 'edit_area_creation', 'area_creation'),
(67, 'Area Mapping', 'edit_area_mapping', 'area_mapping'),
(68, 'Area Approval', 'area_status', 'area_approval'),
(69, 'Director Creation', 'edit_director_creation', 'director_creation'),
(70, 'Agent Creation', 'edit_agent_creation', 'agent_creation'),
(71, 'Staff Creation', 'edit_staff_creation', 'staff_creation'),
(72, 'Bank Creation', 'edit_bank_creation', 'bank_creation'),
(73, 'Manage Users', 'edit_manage_user', 'manage_user'),
(74, 'Request', 'edit_request', 'request'),
(75, 'Verification', 'verification_list', 'verification'),
(76, 'Acknowledgement', 'edit_acknowledgement_list', 'acknowledgement'),
(77, 'Loan Issue', 'edit_loan_issue', 'loan_issue'),
(78, 'Collection', 'edit_collection', 'collection'),
(79, 'Closed', 'edit_closed', 'closed'),
(80, 'NOC', 'edit_noc', 'noc'),
(81, 'Update', 'edit_update', 'update_screen'),
(82, 'Concern Creation', 'edit_concern_creation', 'concern_creation'),
(83, 'Concern Solution', 'edit_concern_solution', 'concern_solution'),
(84, 'Concern Feedback', 'edit_concern_feedback', 'concern_feedback'),
(85, 'Bank Clearance', 'edit_bank_clearance', 'bank_clearance'),
(86, 'Due Followup', 'edit_due_followup', 'due_followup'),
(87, 'Approval', 'approval_list', 'approvalmodule'),
(88, 'Document Track', 'document_track', 'doctrack'),
(89, 'Cash Tally', 'cash_tally', 'cash_tally'),
(90, 'Financial Insights', 'finance_insight', 'finance_insight'),
(91, 'Promotion Activity', 'promotion_activity', 'promotion_activity'),
(92, 'Loan Followup', 'loan_followup', 'loan_followup'),
(93, 'Confirmation Followup', 'confirmation_followup', 'confirmation_followup'),
(94, 'Dashboard', 'dashboard', 'dashboard');

-- --------------------------------------------------------

--
-- Table structure for table `name_detail_creation`
--

CREATE TABLE `name_detail_creation` (
  `name_id` int(11) NOT NULL COMMENT 'Primary Key',
  `name` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `ident` varchar(255) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `name_detail_creation`
--

INSERT INTO `name_detail_creation` (`name_id`, `name`, `area`, `ident`, `status`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, 'Kalai', 'PDY', 'Kalai', '0', '2', NULL, NULL, '2023-08-03 14:56:39');

-- --------------------------------------------------------

--
-- Table structure for table `new_cus_promo`
--

CREATE TABLE `new_cus_promo` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `sub_area` varchar(255) DEFAULT NULL,
  `int_status` varchar(10) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `new_cus_promo`
--

INSERT INTO `new_cus_promo` (`id`, `cus_id`, `cus_name`, `mobile`, `area`, `sub_area`, `int_status`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(5, '123456789012', 'Arun', '7894561230', 'Karur', 'vengamedu', '0', '2', '2', '2023-08-17 17:28:32', '2023-08-17 17:28:32'),
(6, '123456789013', 'Kumar', '9876543210', 'Chennai', 'Ennore', NULL, '2', '2', '2023-08-17 18:35:28', '2023-08-17 18:35:28'),
(7, '123456789014', 'Dinesh', '7418529630', 'Coimbatore', 'Ukkadam', NULL, '2', '2', '2023-08-18 09:46:31', '2023-08-18 09:46:31');

-- --------------------------------------------------------

--
-- Table structure for table `new_promotion`
--

CREATE TABLE `new_promotion` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `follow_date` datetime DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `new_promotion`
--

INSERT INTO `new_promotion` (`id`, `cus_id`, `status`, `label`, `remark`, `follow_date`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(21, '123456789012', 'Interested', 'Check', 'Check', '2023-08-20 00:00:00', '2', NULL, '2023-08-18 18:25:27', '2023-08-18 00:00:00'),
(22, '123456789012', 'Not Interested', 'Checked', 'Checked', '2023-09-01 00:00:00', '2', NULL, '2023-08-18 18:26:36', '2023-08-18 00:00:00'),
(23, '100010001000', 'Interested', 'Existing check', 'Existing check', '2023-09-01 00:00:00', '2', NULL, '2023-08-18 18:31:07', '2023-08-18 18:31:07'),
(24, '100010001000', 'Not Interested', 'Existing check', 'Existing check 2', '2023-10-01 00:00:00', '2', NULL, '2023-08-18 18:31:43', '2023-08-18 18:31:43'),
(25, '400040004000', 'Interested', 'Color check', 'Color check', '2023-08-09 00:00:00', '2', NULL, '2023-08-19 15:07:36', '2023-08-19 15:07:36'),
(26, '400040004000', 'Not Interested', 'Color check', 'Color check', '2023-08-20 00:00:00', '2', NULL, '2023-08-19 15:07:57', '2023-08-19 15:07:57'),
(29, '400040004000', 'Interested', 'Color check', 'Color check', '2023-08-09 00:00:00', '2', NULL, '2023-08-19 15:27:39', '2023-08-19 15:27:39'),
(30, '400040004000', 'Not Interested', 'Color check', 'Color check', '2023-08-19 00:00:00', '2', NULL, '2023-08-19 15:53:33', '2023-08-19 15:53:33'),
(31, '400040004000', 'Not Interested', 'Check', 'check', '2023-09-01 00:00:00', '2', NULL, '2023-08-19 16:13:25', '2023-08-19 16:13:25'),
(32, '400040004000', 'Interested', 'Check', 'Check', '2023-08-19 00:00:00', '2', NULL, '2023-08-19 16:14:24', '2023-08-19 16:14:24'),
(33, '400040004000', 'Interested', 'check', 'check', '2023-08-20 00:00:00', '2', NULL, '2023-08-19 16:14:57', '2023-08-19 16:14:57'),
(35, '400040004000', 'Not Interested', 'asdf', 'asdf', '2023-08-11 00:00:00', '2', NULL, '2023-08-19 18:40:48', '2023-08-19 18:40:48'),
(36, '400040004000', 'Not Interested', 'asdf', 'asdf', '2023-08-19 00:00:00', '2', NULL, '2023-08-19 18:41:14', '2023-08-19 18:41:14'),
(37, '400040004000', 'Not Interested', 'Check', 'Check', '2023-08-22 00:00:00', '2', NULL, '2023-08-21 10:25:33', '2023-08-21 10:25:33'),
(38, '400040004000', 'Interested', 'Check', 'Check', '2023-08-21 00:00:00', '2', NULL, '2023-08-21 10:27:20', '2023-08-21 10:27:20'),
(39, '100010001000', 'Not Interested', 'Check', 'Check', '2023-08-19 00:00:00', '2', NULL, '2023-08-21 10:27:32', '2023-08-21 10:27:32'),
(40, '123456789012', 'Interested', 'interested', 'interested', '2023-09-10 00:00:00', '2', NULL, '2023-09-05 16:19:50', '2023-09-05 16:19:50'),
(41, '200020002000', 'Not Interested', 'Repromotion', 'Repromotion', '2023-10-08 00:00:00', '2', NULL, '2023-09-05 16:24:05', '2023-09-05 16:24:05');

-- --------------------------------------------------------

--
-- Table structure for table `noc`
--

CREATE TABLE `noc` (
  `noc_id` int(11) NOT NULL COMMENT 'Primary Key',
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `sign_checklist` varchar(255) DEFAULT NULL,
  `cheque_checklist` varchar(255) DEFAULT NULL,
  `gold_checklist` varchar(255) DEFAULT NULL,
  `mort_checklist` varchar(255) DEFAULT NULL,
  `endorse_checklist` varchar(255) DEFAULT NULL,
  `doc_checklist` varchar(255) DEFAULT NULL,
  `noc_date` varchar(255) DEFAULT NULL,
  `noc_member` varchar(255) DEFAULT NULL,
  `mem_name` varchar(255) DEFAULT NULL,
  `cus_status` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `noc`
--

INSERT INTO `noc` (`noc_id`, `req_id`, `cus_id`, `sign_checklist`, `cheque_checklist`, `gold_checklist`, `mort_checklist`, `endorse_checklist`, `doc_checklist`, `noc_date`, `noc_member`, `mem_name`, `cus_status`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', '100010001000', '4', '', '', 'Mortgage Process noc', '', '2', '2023-07-17', '1', 'Ganesan', '21', '2', NULL, '2023-07-17 13:19:34', '2023-07-17 13:19:34'),
(2, '6', '200020002000', '', '', '', '', 'Endorsement Process noc,Key noc', '', '2023-09-12', '1', 'Aravind', '21', '2', NULL, '2023-09-12 14:33:19', '2023-09-12 14:33:19'),
(9, '79', '575757575757', '', '', '15', '', '', '', '23-02-2024', '1', 'Sugumaran', '21', '5', NULL, '2024-02-23 12:34:54', '2024-02-23 12:34:54'),
(10, '79', '575757575757', '', '', '16', '', 'Endorsement Process noc,RC noc,Key noc', '', '23-02-2024', '3', '25', '21', '5', NULL, '2024-02-23 12:55:22', '2024-02-23 12:55:22'),
(11, '78', '474747474747', '', '', '14', '', '', '', '27-03-2024', '1', 'Murugesan', '21', '5', NULL, '2024-03-27 12:24:10', '2024-03-27 12:24:10');

-- --------------------------------------------------------

--
-- Table structure for table `penalty_charges`
--

CREATE TABLE `penalty_charges` (
  `req_id` varchar(255) DEFAULT NULL,
  `penalty_date` varchar(255) DEFAULT NULL,
  `penalty` varchar(255) DEFAULT NULL,
  `paid_date` varchar(255) DEFAULT NULL,
  `paid_amnt` varchar(255) DEFAULT '0',
  `waiver_amnt` varchar(255) DEFAULT '0',
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `penalty_charges`
--

INSERT INTO `penalty_charges` (`req_id`, `penalty_date`, `penalty`, `paid_date`, `paid_amnt`, `waiver_amnt`, `created_date`, `updated_time`) VALUES
('7', '2023-05', '170', NULL, '0', '0', '2023-07-12 16:16:19', '2023-07-12 16:16:19'),
('7', '2023-06', '170', NULL, '0', '0', '2023-07-12 16:16:19', '2023-07-12 16:16:19'),
('7', NULL, NULL, '2023-07-12', '340', '', '2023-07-12 16:17:08', '2023-07-12 16:17:08'),
('7', '2023-10', '170', NULL, '0', '0', '2023-12-12 11:41:35', '2023-12-12 11:41:35'),
('8', '2023-01-02', '49', NULL, '0', '0', '2023-07-18 18:56:11', '2023-07-18 18:56:11'),
('8', '2023-01-04', '49', NULL, '0', '0', '2023-07-18 18:56:11', '2023-07-18 18:56:11'),
('8', '2023-01-05', '49', NULL, '0', '0', '2023-07-18 18:56:11', '2023-07-18 18:56:11'),
('8', '2023-01-06', '49', NULL, '0', '0', '2023-07-18 18:56:11', '2023-07-18 18:56:11'),
('8', '2023-01-07', '49', NULL, '0', '0', '2023-07-18 18:56:11', '2023-07-18 18:56:11'),
('8', '2023-01-08', '49', NULL, '0', '0', '2023-07-18 18:56:11', '2023-07-18 18:56:11'),
('8', '2023-01-09', '49', NULL, '0', '0', '2023-07-18 18:56:11', '2023-07-18 18:56:11'),
('8', '2023-01-10', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-11', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-12', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-13', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-14', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-15', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-16', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-17', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-18', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-19', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-20', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', '2023-01-21', '49', NULL, '0', '0', '2023-07-18 18:56:12', '2023-07-18 18:56:12'),
('8', NULL, NULL, '2023-08-02', '931', '', '2023-08-02 17:39:50', '2023-08-02 17:39:50'),
('8', NULL, NULL, '2023-08-02', '931', '', '2023-08-02 17:40:35', '2023-08-02 17:40:35'),
('8', NULL, NULL, '2023-08-02', '931', '', '2023-08-02 17:42:01', '2023-08-02 17:42:01'),
('10', '2023-11', '14', NULL, '0', '0', '2023-12-24 16:06:59', '2023-12-24 16:06:59'),
('10', NULL, NULL, '2023-12-24', '10', '', '2023-12-24 16:07:41', '2023-12-24 16:07:41'),
('10', NULL, NULL, '2023-12-24', '4', '', '2023-12-24 16:08:12', '2023-12-24 16:08:12'),
('10', '2024-01', '12', NULL, '0', '0', '2024-02-19 10:11:32', '2024-02-19 10:11:32'),
('10', '2024-02', '12', NULL, '0', '0', '2023-08-10 10:20:28', '2023-08-10 10:20:28'),
('10', '2024-03', '12', NULL, '0', '0', '2023-08-10 10:20:28', '2023-08-10 10:20:28'),
('10', '2024-04', '12', NULL, '0', '0', '2023-08-10 10:20:28', '2023-08-10 10:20:28'),
('10', '2024-05', '12', NULL, '0', '0', '2023-12-31 10:21:44', '2023-12-31 10:21:44'),
('11', '2023-07-22', '36', NULL, '0', '0', '2023-08-10 11:02:54', '2023-08-10 11:02:54'),
('11', '2023-07-29', '36', NULL, '0', '0', '2023-08-10 11:02:54', '2023-08-10 11:02:54'),
('11', '2023-08-05', '36', NULL, '0', '0', '2023-08-10 11:02:54', '2023-08-10 11:02:54'),
('11', '2023-08-12', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-08-19', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-08-26', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-09-02', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-09-09', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-09-16', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-09-23', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-09-30', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-10-07', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-10-14', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-10-21', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-10-28', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-11-04', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-11-11', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-11-18', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-11-25', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-12-02', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('11', '2023-12-09', '36', NULL, '0', '0', '2023-08-10 11:03:00', '2023-08-10 11:03:00'),
('1', '2023-08', '196', NULL, '0', '0', '2023-08-10 12:04:39', '2023-08-10 12:04:39'),
('1', '2023-09', '196', NULL, '0', '0', '2023-08-10 12:04:39', '2023-08-10 12:04:39'),
('1', '2023-10', '196', NULL, '0', '0', '2023-08-10 12:04:39', '2023-08-10 12:04:39'),
('1', '2023-11', '196', NULL, '0', '0', '2023-08-10 12:04:39', '2023-08-10 12:04:39'),
('1', '2023-12', '196', NULL, '0', '0', '2023-08-10 12:04:39', '2023-08-10 12:04:39'),
('10', '2023-09', '14', NULL, '0', '0', '2023-08-10 12:25:50', '2023-08-10 12:25:50'),
('10', '2023-10', '14', NULL, '0', '0', '2023-08-10 12:25:50', '2023-08-10 12:25:50'),
('10', '2023-12', '14', NULL, '0', '0', '2023-08-10 12:25:50', '2023-08-10 12:25:50'),
('10', '2023-08', '12', NULL, '0', '0', '2023-12-10 16:30:34', '2023-12-10 16:30:34'),
('12', '2023-09', '60', NULL, '0', '0', '2023-12-04 16:48:50', '2023-12-04 16:48:50'),
('12', '2023-10', '60', NULL, '0', '0', '2023-12-04 16:48:50', '2023-12-04 16:48:50'),
('12', '2023-11', '60', NULL, '0', '0', '2023-12-04 16:48:50', '2023-12-04 16:48:50'),
('1', NULL, NULL, '2023-09-05', '200', '', '2023-09-05 15:15:54', '2023-09-05 15:15:54'),
('18', '2023-09', '135', NULL, '0', '0', '2023-12-14 16:56:34', '2023-12-14 16:56:34'),
('18', '2023-10', '135', NULL, '0', '0', '2023-12-14 16:56:34', '2023-12-14 16:56:34'),
('18', '2023-11', '135', NULL, '0', '0', '2023-12-14 16:56:34', '2023-12-14 16:56:34'),
('11', '2023-12-16', '36', NULL, '0', '0', '2023-12-23 16:00:15', '2023-12-23 16:00:15'),
('9', '2023-10', '117', NULL, '0', '0', '2023-12-25 11:22:03', '2023-12-25 11:22:03'),
('9', '2023-11', '234', NULL, '0', '0', '2023-12-25 11:22:03', '2023-12-25 11:22:03'),
('22', '2024-01-03', '12', NULL, '0', '0', '2024-01-04 16:59:45', '2024-01-04 16:59:45'),
('23', '2024-01', '28', NULL, '0', '0', '2024-03-04 17:08:40', '2024-03-04 17:08:40'),
('23', '2024-02', '56', NULL, '0', '0', '2024-03-04 17:08:40', '2024-03-04 17:08:40'),
('22', '2024-01-04', '12', NULL, '0', '0', '2024-01-07 17:46:35', '2024-01-07 17:46:35'),
('22', '2024-01-05', '24', NULL, '0', '0', '2024-01-07 17:46:35', '2024-01-07 17:46:35'),
('22', '2024-01-06', '36', NULL, '0', '0', '2024-01-07 17:46:35', '2024-01-07 17:46:35'),
('22', '2024-01-07', '12', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-08', '24', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-09', '36', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-10', '48', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-11', '60', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-12', '72', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-13', '84', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-14', '96', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-15', '108', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-16', '120', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-17', '132', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-18', '144', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-19', '156', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-20', '168', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-21', '180', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-22', '192', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-23', '204', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-24', '216', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-25', '228', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-26', '240', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-27', '252', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-28', '264', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-29', '276', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-30', '288', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-01-31', '300', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-01', '312', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-03', '324', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-04', '336', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-06', '348', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-07', '360', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-08', '372', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-09', '384', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-10', '396', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-11', '408', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-12', '420', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-13', '432', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-14', '444', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('22', '2024-02-15', '456', NULL, '0', '0', '2024-02-19 17:48:25', '2024-02-19 17:48:25'),
('9', '2024-01', '117', NULL, '0', '0', '2024-03-19 15:12:22', '2024-03-19 15:12:22'),
('87', '2024-02', '90', NULL, '0', '0', '2024-03-25 13:09:48', '2024-03-25 13:09:48'),
('87', NULL, NULL, '2024-03-25', '', '90', '2024-03-25 13:10:14', '2024-03-25 13:10:14'),
('84', '2024-02', '90', NULL, '0', '0', '2024-03-28 15:55:24', '2024-03-28 15:55:24'),
('88', '2024-05', '180', NULL, '0', '0', '2024-05-03 16:08:40', '2024-05-03 16:08:40');

-- --------------------------------------------------------

--
-- Table structure for table `request_category_info`
--

CREATE TABLE `request_category_info` (
  `cat_info` int(11) NOT NULL,
  `req_ref_id` varchar(255) DEFAULT NULL,
  `category_info` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `request_category_info`
--

INSERT INTO `request_category_info` (`cat_info`, `req_ref_id`, `category_info`) VALUES
(11, '5', 'Bajaj'),
(12, '5', 'CBR'),
(13, '2', 'Micromax'),
(14, '2', '40'),
(15, '2', 'LED'),
(16, '6', 'Samsung'),
(17, '6', '6inch'),
(18, '1', 'Carrier'),
(19, '1', '1ton'),
(20, '1', 'Split'),
(21, '7', 'ABC'),
(22, '7', '1styear'),
(23, '8', '8500'),
(24, '9', 'Carrier'),
(25, '9', '1ton'),
(26, '9', 'Split'),
(27, '10', '8500'),
(28, '11', '7500'),
(29, '12', 'Bajaj'),
(30, '12', 'Bajaj'),
(31, '12', 'Bajaj'),
(32, '13', 'LG'),
(33, '13', '1ton'),
(34, '13', 'Inverter'),
(35, '14', 'Fridge'),
(36, '14', 'Fridge'),
(39, '16', '1000 500'),
(40, '16', '5000 sqft'),
(41, '16', '1680000'),
(42, '17', 'Coffee shop'),
(43, '17', 'Franchise'),
(44, '18', 'Bajaj'),
(45, '18', 'Pulsar 150'),
(74, '20', 'Micromax'),
(75, '20', '15'),
(76, '21', 'Apple'),
(77, '21', '6 11'),
(78, '22', 'VAO'),
(79, '22', '1'),
(80, '22', '1'),
(81, '23', 'Check'),
(82, '23', 'Check'),
(83, '24', '1'),
(84, '24', '1'),
(85, '24', '1'),
(94, '19', 'Haier'),
(95, '19', '3.2'),
(96, '19', '3.3'),
(126, '77', '10000'),
(127, '78', '10000'),
(128, '79', '10000'),
(133, '84', '10000'),
(134, '85', '10*10'),
(135, '85', '10*10'),
(136, '85', '1000000'),
(137, '86', 'VAO'),
(138, '86', '24'),
(139, '86', '17500'),
(140, '87', '10000'),
(141, '88', '80000');

-- --------------------------------------------------------

--
-- Table structure for table `request_creation`
--

CREATE TABLE `request_creation` (
  `req_id` int(11) NOT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `agent_id` varchar(255) DEFAULT NULL,
  `responsible` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `declaration` varchar(255) DEFAULT NULL,
  `req_code` varchar(255) DEFAULT NULL,
  `dor` date DEFAULT NULL,
  `cus_reg_id` varchar(255) DEFAULT NULL,
  `cus_id` varchar(255) DEFAULT NULL,
  `cus_data` varchar(255) DEFAULT NULL,
  `cus_name` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `sub_area` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `mobile1` varchar(255) DEFAULT NULL,
  `mobile2` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `marital` varchar(255) DEFAULT NULL,
  `spouse_name` varchar(255) DEFAULT NULL,
  `occupation_type` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `tot_value` varchar(255) DEFAULT NULL,
  `ad_amt` varchar(255) DEFAULT NULL,
  `ad_perc` varchar(255) DEFAULT NULL,
  `loan_amt` varchar(255) DEFAULT NULL,
  `poss_type` varchar(255) DEFAULT NULL,
  `due_amt` varchar(255) DEFAULT NULL,
  `due_period` varchar(255) DEFAULT NULL,
  `cus_status` varchar(255) DEFAULT '0',
  `prompt_remark` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request_creation`
--

INSERT INTO `request_creation` (`req_id`, `user_type`, `user_name`, `agent_id`, `responsible`, `remarks`, `declaration`, `req_code`, `dor`, `cus_reg_id`, `cus_id`, `cus_data`, `cus_name`, `dob`, `age`, `gender`, `state`, `district`, `taluk`, `area`, `sub_area`, `address`, `mobile1`, `mobile2`, `father_name`, `mother_name`, `marital`, `spouse_name`, `occupation_type`, `occupation`, `pic`, `loan_category`, `sub_category`, `tot_value`, `ad_amt`, `ad_perc`, `loan_amt`, `poss_type`, `due_amt`, `due_period`, `cus_status`, `prompt_remark`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'Agent', 'Alaathi Mobiles and Furniture', '1', '0', '', 'New customer for us', 'REQ-101', '2023-07-01', '1', '010720232023', 'New', 'Bharath', '1990-02-03', '33', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '1', '4', '46', '9846546546', '', 'Sugumar', 'Seetha', '2', '', '2', 'Supervisor', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '5', 'AC', '35000', '3000', '8.6', '32000', '1', '3470', '', '14', '', '0', '3', '3', NULL, '2023-07-01 00:00:00', '2023-07-01 00:00:00'),
(2, 'Staff', 'Arun', '2', '', 'Customer for laxhmi', '', 'REQ-102', '2023-07-01', '3', '100010001000', 'New', 'Ganesan', '1996-06-01', '27', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '5', 'TV', '20000', '3000', '15', '17000', '2', '', '12', '21', '', '0', '2', '2', NULL, '2023-07-01 00:00:00', '2023-07-01 00:00:00'),
(5, 'Staff', 'Arun', '', '', 'Old customer new prod', '', 'REQ-103', '2023-01-01', '3', '100010001000', 'Existing', 'Ganesan', '1996-06-01', '27', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '2', 'Bike', '65000', '5000', '7.7', '60000', '1', '4500', '', '20', '', '0', '2', '2', NULL, '2023-01-01 00:00:00', '2023-01-01 00:00:00'),
(6, 'Staff', 'Arun', '', '', 'Relative Customer', '', 'REQ-104', '2023-07-03', '4', '200020002000', 'New', 'Aravind', '1988-03-10', '35', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', '22', '9794949494', '', 'Vedha', 'Vidhya', '2', '', '4', 'Departmental Store', 'pexels-pixabay-220453.jpg', '6', 'Mobiles', '', '', '', '50000', '1', '4500', '', '21', '', '0', '2', '2', NULL, '2023-07-03 00:00:00', '2023-07-03 00:00:00'),
(7, 'Director', 'Will Smith', '', '0', '', 'Just declaration', 'REQ-105', '2023-07-03', '6', '300030003000', 'New', 'Rakesh', '1992-06-09', '31', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', '78A', '9664565132', '', 'Joshwa', 'Sheethal', '2', '', '3', 'Coconut shop', 'person_sample_4.jpg', '9', 'Education', '', '', '', '56500', '2', '', '24', '16', '', '0', '5', '5', NULL, '2023-07-03 00:00:00', '2023-07-03 00:00:00'),
(8, 'Staff', 'Arun', '', '', 'Old customer new prod', '', 'REQ-106', '2023-01-02', '4', '200020002000', 'Existing', 'Aravind', '1988-03-10', '35', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', '22', '9794949494', '', 'Vedha', 'Vidhya', '2', '', '4', 'Departmental Store', 'pexels-pixabay-220453.jpg', '1', 'Personal', '35500', '3500', '9.9', '32000', '1', '4500', '', '14', '', '0', '2', '2', NULL, '2023-01-02 00:00:00', '2023-01-02 00:00:00'),
(9, 'Staff', 'Arun', '2', '', 'Old customer new prod', '', 'REQ-107', '2023-07-15', '3', '100010001000', 'Existing', 'Ganesan', '1996-06-01', '27', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '5', 'AC', '35000', '3000', '8.6', '32000', '2', '', '10', '14', '', '0', '2', '2', NULL, '2023-07-15 00:00:00', '2023-09-05 00:00:00'),
(10, 'Staff', 'Arun', '', '', 'checking Rakesh', '', 'REQ-108', '2023-07-15', '6', '300030003000', 'Existing', 'Rakesh', '1992-06-09', '31', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', '78A', '9664565132', '', 'Joshwa', 'Sheethal', '2', '', '3', 'Coconut shop', 'person_sample_4.jpg', '1', 'Personal', '52000', '4000', '7.7', '48000', '1', '4400', '', '14', '', '0', '2', '2', NULL, '2023-07-15 00:00:00', '2023-07-15 00:00:00'),
(11, 'Staff', 'Arun', '', '', 'New customer', '', 'REQ-109', '2023-07-21', '7', '500050005000', 'New', 'Manikandan', '1995-03-02', '28', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', 'Harington road', '7888878888', '', 'Mani Kapoor', 'Mani megalai', '2', '', '5', 'Watchman', 'musk.jpg', '1', 'Personal', '28000', '2000', '7.1', '26000', '2', '', '12', '14', '', '0', '2', '2', NULL, '2023-07-21 00:00:00', '2023-07-21 00:00:00'),
(12, 'Staff', 'Arun', '', '', 'Check', '', 'REQ-110', '2023-08-02', '8', '400040004000', 'New', 'Bharathi', '1999-01-21', '24', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '17', 'EVR', '9459416164', '994949494', 'Vedha', 'Gayathri', '2', '', '1', 'Watchman', 'images (1).jpg', '5', 'AC', '50000', '0', '0', '50000', '1', '1600', '', '14', '', '0', '2', '2', NULL, '2023-08-02 00:00:00', '2023-08-02 00:00:00'),
(14, 'Staff', 'Arun', '', '', 'Check', '', 'REQ-112', '2023-08-19', '4', '200020002000', 'Existing', 'Aravind', '1988-03-10', '35', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '8', '23', '22', '9794949494', '', 'Vedha', 'Vidhya', '2', '', '4', 'Departmental Store', 'pexels-pixabay-220453.jpg', '7', 'Small Business', '', '', '', '50000', '1', '460', '', '3', '', '0', '2', '2', NULL, '2023-08-19 00:00:00', '2024-03-14 09:57:47'),
(16, 'Staff', 'Arun', '', '', 'Check once ', '', 'REQ-113', '2023-09-06', '9', '060120230408', 'New', 'Gnanasekar', '1990-02-14', '33', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '4', '19', 'Purisai', '9790171511', '', 'Sengunthan', 'Aarthi', '2', '', '2', 'Best Opticals', 'person_sample_2.jpg', '8', 'Plot Purchase', '50000', '0', '0', '50000', '2', '', '12', '13', '', '0', '2', '2', NULL, '2023-01-07 00:00:00', '2024-03-15 18:36:02'),
(17, 'Director', 'Will Smith', '', '1', '', 'okok', 'REQ-114', '2023-09-09', '10', '090920230103', 'New', 'Janaki', '2023-09-06', '0', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '14', 'MRS', '9002777732', '', 'Dineshkumar', 'Dineshi', '2', '', '2', 'IT', 'download.jpg', '7', 'Small Business', '', '', '', '60000', '1', '5500', '', '1', '', '0', '5', '5', NULL, '2023-09-09 00:00:00', '2023-09-09 00:00:00'),
(18, 'Staff', 'Arun', '', '', 'First Bike', '', 'REQ-115', '2023-09-13', '3', '100010001000', 'Existing', 'Ganesan', '1996-06-01', '27', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'EVR', '6465465464', '', 'Gurumoorthi', 'Gayathri', '2', '', '4', 'Departmental Store', 'monkey1.avif', '2', 'Bike', '32000', '5000', '15.6', '27000', '1', '4500', '', '14', '', '0', '2', '2', NULL, '2023-09-13 00:00:00', '2023-09-06 00:00:00'),
(21, 'Staff', 'Jafar', '', '', 'Personal friend', '', 'REQ-118', '2023-12-27', '25', '261910026191', 'New', 'Arjun Das', '1999-04-27', '25', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '16', 'MGR Salai', '2619100261', '', 'Anthony', 'Unknown', '1', 'Sathya', '1', 'Undercover Agent', '658bc19b427cb.jpg', '6', 'Mobiles', '', '', '', '45000', '1', '4000', '', '13', '', '0', '4', '4', NULL, '2023-12-27 00:00:00', '2023-12-28 00:00:00'),
(22, 'Staff', 'Arun', '', '', 'c', '', 'REQ-119', '2024-01-02', '26', '000000000001', 'New', 'Senthil kumaran', '1999-02-02', '25', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'CT', '7526312546', '', 'Kumaran', 'Kumari', '2', '', '1', 'VAO', '6593e1b875db5.png', '11', 'Interest R', '', '', '', '54000', '1', '5400', '', '14', '', '0', '2', '2', NULL, '2024-01-02 00:00:00', '2024-01-02 00:00:00'),
(23, 'Staff', 'Arun', '', '', 'c', '', 'REQ-120', '2024-01-06', '26', '000000000001', 'Existing', 'Senthil kumaran', '1999-02-02', '25', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'CT', '7526312546', '', 'Kumaran', 'Kumari', '2', '', '1', 'VAO', '6593e1b875db5.png', '7', 'Small Business', '', '', '', '11000', '2', '', '11', '14', '', '0', '2', '2', NULL, '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
(24, 'Staff', 'Arun', '', '', 'c', '', 'REQ-121', '2024-01-06', '26', '000000000001', 'Existing', 'Senthil kumaran', '1999-02-02', '25', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '18', 'CT', '7526312546', '', 'Kumaran', 'Kumari', '2', '', '1', 'VAO', '6593e1b875db5.png', '8', 'Plot Purchase', '15000', '2000', '13.3', '13000', '2', '', '11', '14', '', '0', '2', '2', NULL, '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
(36, 'Staff', 'Arun', '', '', 'remark', '', 'REQ-111', '2023-08-03', NULL, '400040004000', 'Existing', 'Bharathi', '1999-01-21', '24', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '17', 'EVR', '9459416164', '994949494', 'Vedha', 'Gayathri', '2', '', '1', 'Watchman', 'images (1).jpg', '5', 'AC', '45000', '3000', '6.7', '42000', '1', '1500', '', '8', 'Prompt Remarks', '0', '2', '2', NULL, '2023-08-03 00:00:00', '2023-08-19 00:00:00'),
(41, 'Staff', 'Arun', '1', '', 'Check', '', 'REQ-116', '2023-11-04', NULL, '600060006000', 'New', 'Subramani', '1995-05-02', '28', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Check', '2619002619', '', 'Leo', 'Trisha', '2', '', '4', 'Bite', 'subramani.jpg', '5', 'AC Pre R ', '15000', '0', '0', '15000', '2', '', '30', '4', 'repromotion check', '0', '2', '2', NULL, '2023-11-04 00:00:00', '2024-02-17 00:00:00'),
(42, 'Staff', 'Arun', '', '', 'sdf', '', 'REQ-117', '2023-11-06', NULL, '600060006000', 'Existing', 'Subramani', '1995-05-02', '28', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '13', 'Check', '2619002619', '', 'Leo', 'Trisha', '2', '', '4', 'Bite', 'subramani.jpg', '6', 'Mobiles', '', '', '', '15000', '1', '1500', '', '8', 'repromotion check', '0', '2', '2', NULL, '2023-11-06 00:00:00', '2024-02-17 00:00:00'),
(77, 'Staff', 'Arun', '', '', '', '', 'REQ-122', '2024-01-01', '45', '123412341234', 'New', 'Rajesh', '1994-02-20', '29', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-02-21 16:00:10'),
(78, 'Staff', 'Arun', '', '', '', '', 'REQ-123', '2024-01-01', '46', '474747474747', 'New', 'Murugesan', '1994-02-20', '29', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-02-22 12:42:48'),
(79, 'Staff', 'Arun', '', '', '', '', 'REQ-124', '2024-01-01', '47', '575757575757', 'New', 'Sugumaran', '1994-02-20', '29', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-02-23 10:00:32'),
(84, 'Staff', 'Arun', '', '', '', '', 'REQ-125', '2024-01-01', '52', '676767676767', 'New', 'Ilambarithi', '1994-02-20', '29', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '14', '', '0', '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(85, 'Staff', 'Arun', '', '', 'ssf', '', 'REQ-126', '2024-03-07', '53', '789789789789', 'New', 'Arjun', '2003-02-04', '21', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', '1', '9874563210', '', 'Dheena', 'Rani', '2', '', '1', 'VAO', '65e9a17e9d353.jpg', '8', 'Plot Purchase', '50000', '5000', '10.0', '45000', '1', '155', '', '1', '', '0', '2', '2', NULL, '2024-03-07 16:44:06', '2024-03-11 17:48:57'),
(86, 'Staff', 'Arun', '', '', 'qwe', '', 'REQ-127', '2024-03-12', '53', '789789789789', 'Existing', 'Arjun', '2003-02-04', '21', '1', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', '3', '15', '1', '9874563210', '', 'Dheena', 'Rani', '2', '', '1', 'VAO', '65e9a17e9d353.jpg', '11', 'Interest R', '', '', '', '15000', '1', '1111', '', '1', '', '0', '2', '2', NULL, '2024-03-12 12:24:55', '2024-03-12 12:25:04'),
(87, 'Staff', 'Arun', '', '', '', '', 'REQ-128', '2024-01-01', '54', '525252525252', 'New', 'Pooja', '1994-02-20', '29', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '', '1', 'Personal', '', '', '', '25000', '1', '3000', '', '21', '', '0', '2', '5', NULL, '2024-01-01 00:00:00', '2024-03-25 13:10:14'),
(88, 'Staff', 'Arun', '', '', 'req', '', 'REQ-129', '2024-03-28', '54', '525252525252', 'Existing', 'Pooja', '1994-02-20', '29', '1', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', '5', '26', '50', '7708261661', '', 'Lingam', 'Rajeshwari', '1', 'Sowmiya', '2', 'Supervisor', '6605494c00dfe.jpg', '1', 'Personal', '100000', '0', '0.0', '100000', '1', '3000', '', '14', '', '0', '2', '2', NULL, '2024-03-28 16:14:59', '2024-03-28 17:08:56');

-- --------------------------------------------------------

--
-- Table structure for table `signed_doc`
--

CREATE TABLE `signed_doc` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `signed_doc_id` varchar(255) DEFAULT NULL,
  `upload_doc_name` varchar(255) DEFAULT NULL,
  `noc_given` varchar(10) NOT NULL DEFAULT '0',
  `noc_date` varchar(255) DEFAULT NULL,
  `noc_person` varchar(255) DEFAULT NULL,
  `noc_name` varchar(255) DEFAULT NULL,
  `used_status` varchar(10) NOT NULL DEFAULT '0',
  `temp_sts` varchar(10) NOT NULL DEFAULT '0',
  `temp_date` date DEFAULT NULL,
  `temp_person` varchar(255) DEFAULT NULL,
  `temp_purpose` varchar(255) DEFAULT NULL,
  `temp_remarks` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(100) DEFAULT NULL,
  `update_login_id` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `signed_doc`
--

INSERT INTO `signed_doc` (`id`, `cus_id`, `req_id`, `signed_doc_id`, `upload_doc_name`, `noc_given`, `noc_date`, `noc_person`, `noc_name`, `used_status`, `temp_sts`, `temp_date`, `temp_person`, `temp_purpose`, `temp_remarks`, `insert_login_id`, `update_login_id`, `created_date`, `updated_date`) VALUES
(1, '100010001000', '2', '8', 'Order_ID_4479904631.pdf', '1', '2023-07-15', '2', '2', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 11:15:42'),
(2, '100010001000', '2', '7', 'Invoice_4479904631.pdf', '0', NULL, NULL, NULL, '0', '1', '2023-08-05', '1', 'Ganesan', NULL, NULL, '2', NULL, '2023-08-05 11:42:54'),
(3, '100010001000', '2', '5', 'Mantra_RD_Service_Manual_Windows.pdf', '0', NULL, NULL, NULL, '0', '0', '2023-07-27', '1', 'Ganesan', NULL, NULL, '2', NULL, '2023-07-27 12:46:12'),
(4, '100010001000', '2', '1', 'VVDN SCANNER MobileApp_ Architecture  (1).pdf', '1', '2023-07-17', '1', 'Ganesan', '0', '0', '2023-08-05', 'Guna', 'Regular checkup', 'Regular checkup', NULL, '2', NULL, '2023-08-05 17:17:43'),
(6, '100010001000', '5', '9', 'VVDN SCANNER MobileApp_ Architecture  (1).pdf', '0', '', '', '', '0', '1', '2023-07-27', '1', 'Ganesan', NULL, NULL, '2', NULL, '2023-07-27 16:09:09'),
(12, '500050005000', '11', '11', 'sample5.pdf', '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-27 11:07:21'),
(13, '060120230408', '16', '12', 'musk.jpg', '0', NULL, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-01-08 18:59:27');

-- --------------------------------------------------------

--
-- Table structure for table `signed_doc_info`
--

CREATE TABLE `signed_doc_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `doc_name` varchar(255) DEFAULT NULL,
  `sign_type` varchar(255) DEFAULT NULL,
  `signType_relationship` varchar(255) DEFAULT NULL,
  `doc_Count` varchar(255) DEFAULT NULL,
  `req_id` varchar(150) DEFAULT NULL,
  `cus_profile_id` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `signed_doc_info`
--

INSERT INTO `signed_doc_info` (`id`, `cus_id`, `doc_name`, `sign_type`, `signType_relationship`, `doc_Count`, `req_id`, `cus_profile_id`) VALUES
(1, '100010001000', '0', '1', '2', '1', '2', '1'),
(5, '100010001000', '1', '2', '3', '1', '2', '1'),
(7, '100010001000', '2', '3', '1', '1', '2', '1'),
(8, '100010001000', '3', '0', '', '1', '2', '1'),
(9, '100010001000', '0', '1', '3', '1', '5', '4'),
(10, '500050005000', '1', '3', '9', '1', '11', '8'),
(11, '500050005000', '2', '0', '', '1', '11', '8'),
(12, '060120230408', '0', '1', '12', '1', '16', '11');

-- --------------------------------------------------------

--
-- Table structure for table `staff_creation`
--

CREATE TABLE `staff_creation` (
  `staff_id` int(11) NOT NULL,
  `staff_code` varchar(255) DEFAULT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `staff_type` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `taluk` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `mobile1` varchar(255) DEFAULT NULL,
  `mobile2` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(255) DEFAULT NULL,
  `cug_no` varchar(255) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `team` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `staff_creation`
--

INSERT INTO `staff_creation` (`staff_id`, `staff_code`, `staff_name`, `staff_type`, `address`, `state`, `district`, `taluk`, `place`, `pincode`, `mail`, `mobile1`, `mobile2`, `whatsapp`, `cug_no`, `company_id`, `department`, `team`, `designation`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'ST-122', 'Arun', '4', '58', 'TamilNadu', 'Karur', 'Karur', 'karur', '639001', 'arunfeather27@gmail.com', '7845123265', '', '7845123265', '', '1', 'Development', 'PHP', 'Software Developer', '0', '1', '1', NULL, '2023-06-30 12:05:24', '2023-06-30 12:05:33'),
(2, 'ST-101', 'J Prakash Kumar', '1', '25', 'TamilNadu', 'Tiruvannamalai', 'Thiruvannamalai', 'Vandavasi', '604408', 'hariprakash1292@gmail.com', '7530037575', '', '', '', '1', 'Sales', 'Apple', 'TL', '0', '1', '1', NULL, '2023-05-12 11:08:47', '2023-05-12 11:35:22'),
(3, 'ST-102', 'E Kathiravan', '1', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', 'Kathiravan.logon@gmail.com', '9597058101', '', '', '', '1', 'Collection', '', 'TL', '0', '1', '1', NULL, '2023-05-12 11:15:16', '2023-05-25 18:17:49'),
(4, 'ST-103', 'A Vinoth Kumar', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'Vandavasi', '606801', 'vinoar07@gmail.com', '900342641607', '', '', '', '1', 'Sales', 'Apple', 'Executive', '0', '1', '1', NULL, '2023-05-12 11:19:35', '2023-05-12 11:38:15'),
(5, 'ST-104', 'E Deepak', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', 'deepakadh66@gmail.com', '8667769300', '', '', '', '1', 'Collection', 'Banana 1', 'Executive', '0', '1', '1', NULL, '2023-05-12 11:21:47', '2023-05-12 13:25:38'),
(6, 'ST-104', 'E Deepak', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', 'deepakadh66@gmail.com', '8667769300', '', '', '', '1', 'Sales', 'Kurunji beta ', 'Executive', '1', '1', '1', NULL, '2023-05-12 11:21:48', '2023-05-12 11:21:48'),
(7, 'ST-105', 'K Harisankar', '1', '26', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', 'harisankar1770@gmail.com', '9944062263', '', '', '', '1', 'Sales', 'Mango', 'TL', '0', '1', '1', NULL, '2023-05-12 11:23:40', '2023-06-22 16:02:05'),
(8, 'ST-106', 'P Prakash', '2', '26', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', 'prakashpp02@gmail.com', '9942882229', '', '', '', '1', 'Sales', 'Mango', 'Executive', '0', '1', '1', NULL, '2023-05-12 11:27:20', '2023-05-12 11:39:06'),
(9, 'ST-107', 'J Manivannan', '1', '26', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', 'madhanj5685@gmail.com', '6369515985', '', '', '', '1', 'Collection', 'Pine apple 1', 'TL', '0', '1', '1', NULL, '2023-05-12 11:28:49', '2023-06-22 16:02:17'),
(10, 'ST-108', 'S Vijayan', '2', '26', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', 'suijayan06@gmail.com', '7010608919', '', '', '', '1', 'Collection', 'Pine apple 1', 'Executive', '0', '1', '1', NULL, '2023-05-12 11:30:08', '2023-05-12 13:34:09'),
(11, 'ST-109', 'B Dhakshnamoorthi', '1', '27', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', 'ashwinbeukah1989@gmail.com', '8675606936', '', '', '', '1', 'Sales', 'Water melon 1', 'TL', '0', '1', '1', NULL, '2023-05-12 11:33:00', '2023-05-12 12:39:29'),
(12, 'ST-110', 'J Prabakaran', '2', '27', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', 'jpraba1994@gmail.com', '9500288723', '', '', '', '1', 'Sales', 'Water melon 1', 'Executive', '0', '1', '1', NULL, '2023-05-12 11:34:24', '2023-05-12 12:40:18'),
(13, 'ST-111', 'M Sathishkumar', '1', '27', 'TamilNadu', 'Kancheepuram', 'Kancheepuram', 'Uthiramerur', '603406', 'sathish19051992@gmail.com', '9500809268', '', '', '', '1', 'Collection', 'Jack fruit', 'TL', '0', '1', NULL, NULL, '2023-05-12 11:42:17', '2023-05-12 11:42:17'),
(14, 'ST-112', 'M Vignesh', '2', '27', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', 'lingeshvicky3@gmail.com', '7639806909', '', '', '', '1', 'Collection', 'Jackfruit', 'Executive', '0', '1', NULL, NULL, '2023-05-12 11:44:20', '2023-05-12 11:44:20'),
(15, 'ST-113', 'C Chinnadurai', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604404', 'Chinnadurai.v309@gmail.com', '9080424365', '', '', '', '1', 'Sales', 'Apple', 'Executive', '0', '1', NULL, NULL, '2023-05-12 11:47:39', '2023-05-12 11:47:39'),
(16, 'ST-114', 'V Ramesh', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', 'kvramesh34@gmail.com', '8124426133', '', '', '', '1', 'Sales', 'Apple', 'Executive', '0', '1', NULL, NULL, '2023-05-12 11:49:33', '2023-05-12 11:49:33'),
(17, 'ST-115', 'V Arun Kumar', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', 'arunv2219@gmail.com', '9952616003', '', '', '', '1', 'Collection', 'Banana 1', 'Executive', '0', '1', '1', NULL, '2023-05-12 11:51:23', '2023-05-12 13:25:47'),
(18, 'ST-116', 'S Siva', '2', '26', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', 'ss7967018@gmail.com', '6380949704', '', '', '', '1', 'Sales', 'Watermelon', 'Executive', '0', '1', NULL, NULL, '2023-05-12 12:13:17', '2023-05-12 12:13:17'),
(19, 'ST-117', 'G Ramachandran', '2', '26', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', 'indianfivestar@gmail.com', '9626344296', '', '', '', '1', 'Sales', 'Water melon 1', 'Executive', '0', '1', '1', NULL, '2023-05-12 12:15:12', '2023-05-12 12:39:53'),
(20, 'ST-118', 'S Dinesh', '2', '26', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', 'dinesh0871995@gmail.com', '9597579939', '', '', '', '1', 'Collection', 'Jackfruit', 'Executive', '0', '1', NULL, NULL, '2023-05-12 12:17:16', '2023-05-12 12:17:16'),
(21, 'ST-117', 'G Ramachandran', '2', '26', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', 'tamilarasananjalai@gmail.com', '9597347847', '', '', '', '1', 'Sales', 'Mango', 'Executive', '0', '1', '1', NULL, '2023-05-12 12:19:09', '2023-05-12 12:21:33'),
(22, 'ST-118', 'C Pushparaj', '2', '27', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', 'Pushparajc678@gmail.com', '9715418670', '', '', '', '1', 'Collection', 'Pine apple 1', 'Executive', '0', '1', '1', NULL, '2023-05-12 12:23:06', '2023-05-12 13:33:50'),
(24, 'ST-119', 'S Parthiban', '1', '26', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', '', '9790722953', '', '', '', '1', 'Sales', 'Water melon 2', 'TL', '0', '1', NULL, NULL, '2023-05-12 13:22:58', '2023-05-12 13:22:58'),
(25, 'ST-120', 'R Sathish Kumar', '2', '26', 'TamilNadu', 'Kancheepuram', 'Uthiramerur', 'Uthiramerur', '603406', '', '7871361549', '', '', '', '1', 'Sales', 'Water melon 2', 'Executive', '0', '1', NULL, NULL, '2023-05-12 13:24:07', '2023-05-12 13:24:07'),
(26, 'ST-121', 'A Karthick', '1', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', '', '9080597463', '', '', '', '1', 'Collection', 'Banana 2', 'TL', '0', '1', NULL, NULL, '2023-05-12 13:28:55', '2023-05-12 13:28:55'),
(27, 'ST-122', 'E Divakar', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', '', '7708946686', '', '', '', '1', 'Collection', 'Banana 2', 'Executive', '0', '1', NULL, NULL, '2023-05-12 13:30:16', '2023-05-12 13:30:16'),
(28, 'ST-123', 'Jafar', '1', '27', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', '', '9655678668', '', '', '', '1', 'Collection', 'Pine apple 2', 'TL', '0', '1', NULL, NULL, '2023-05-12 13:35:46', '2023-05-12 13:35:46'),
(29, 'ST-124', 'Anwar', '2', '27', 'TamilNadu', 'Tiruvannamalai', 'Chetpet', 'chetpet', '606801', '', '9655678558', '', '', '', '1', 'Collection', 'Pine apple 2', 'Executive', '0', '1', NULL, NULL, '2023-05-12 13:36:38', '2023-05-12 13:36:38'),
(30, 'ST-125', 'Malik', '2', '27', 'SelectState', '', '', 'chetpet', '606801', '', '9655678448', '', '', '', '1', 'Collection', 'Pine apple 2', 'Executive', '0', '1', NULL, NULL, '2023-05-12 13:37:19', '2023-05-12 13:37:19'),
(31, 'ST-126', 'Marudhu', '1', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', '', '9597072411', '', '', '', '1', 'Collection', 'Banana1', 'TL', '0', '1', '1', NULL, '2023-05-26 10:10:06', '2023-05-26 10:10:49'),
(32, 'ST-127', 'Vasanth', '2', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', '', '9597072422', '', '', '', '1', 'Collection', 'Banana2', 'Executive', '0', '1', NULL, NULL, '2023-05-26 10:17:07', '2023-05-26 10:17:07'),
(33, 'ST-128', 'Somesh', '3', '25', 'TamilNadu', 'Tiruvannamalai', 'Vandavasi', 'Vandavasi', '604408', '', '9597072433', '', '', '', '1', 'Office assistant', 'Office', 'Accountant', '0', '1', '1', NULL, '2023-05-26 11:10:49', '2023-05-26 11:11:43'),
(34, 'ST-129', 'Tester', '4', 'check address', 'TamilNadu', 'Coimbatore', 'Aanaimalai', 'cbe', '632132', '', '', '', '', '', '1', 'test', 'test', 'test', '0', '1', '1', NULL, '2023-06-29 17:17:09', '2023-06-29 17:18:03');

-- --------------------------------------------------------

--
-- Table structure for table `staff_type_creation`
--

CREATE TABLE `staff_type_creation` (
  `staff_type_id` int(11) NOT NULL,
  `staff_type_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `staff_type_creation`
--

INSERT INTO `staff_type_creation` (`staff_type_id`, `staff_type_name`, `status`) VALUES
(1, 'TL', '0'),
(2, 'Executive', '0'),
(3, 'Accountant', '0'),
(4, 'Developer', '0');

-- --------------------------------------------------------

--
-- Table structure for table `sub_area_list_creation`
--

CREATE TABLE `sub_area_list_creation` (
  `sub_area_id` int(11) NOT NULL,
  `area_id_ref` varchar(255) DEFAULT NULL,
  `sub_area_name` varchar(255) DEFAULT NULL,
  `sub_area_enable` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `sub_area_list_creation`
--

INSERT INTO `sub_area_list_creation` (`sub_area_id`, `area_id_ref`, `sub_area_name`, `sub_area_enable`, `status`) VALUES
(1, '1', 'Sub Area', 0, '0'),
(2, '2', 'Chetpet', 0, '0'),
(3, '1', 'Gandhi road', 0, '0'),
(4, '1', 'old bustand', 0, '0'),
(5, '1', 'sannathi st', 0, '0'),
(6, '1', 'Pottinaidu st', 0, '0'),
(7, '1', 'KVT nagar', 0, '0'),
(8, '2', 'Endathur road', 0, '0'),
(9, '2', 'Chinarasampettai road', 0, '0'),
(10, '2', 'mettu street', 0, '0'),
(11, '2', 'karuneegar st', 0, '0'),
(12, '2', 'periya sengunthar st', 0, '0'),
(13, '3', 'EVR road', 0, '0'),
(14, '3', 'Mayor ramanathan salai', 0, '0'),
(15, '3', 'Harington road', 0, '0'),
(16, '3', 'MGR salai', 0, '0'),
(17, '3', 'Anna nagar', 0, '0'),
(18, '3', 'Chinna theru', 0, '0'),
(19, '4', 'Purisai', 0, '0'),
(20, '6', 'Ponnur', 0, '0'),
(21, '6', 'Paiyanur', 0, '0'),
(22, '6', 'Anniyur', 0, '0'),
(23, '8', 'Thellar', 0, '0'),
(24, '8', 'Koot Road', 1, '0'),
(25, '7', 'Manamathy', 0, '0'),
(26, '5', 'Echur', 0, '0'),
(27, '5', 'Sugar mill', 0, '0'),
(28, '9', 'Sub Area', 0, '0'),
(29, '10', 'Vennaimalai', 0, '0'),
(30, '0', 'Vangapalayam', 0, '0');

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
  `role_type` varchar(255) DEFAULT NULL,
  `dir_id` varchar(255) DEFAULT NULL,
  `ag_id` varchar(255) DEFAULT NULL,
  `staff_id` varchar(255) DEFAULT NULL,
  `company_id` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `loan_cat` varchar(255) DEFAULT NULL,
  `agentforstaff` varchar(255) DEFAULT NULL,
  `line_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(255) DEFAULT NULL,
  `mastermodule` varchar(255) DEFAULT '1',
  `company_creation` varchar(255) DEFAULT '1',
  `branch_creation` varchar(255) DEFAULT '1',
  `loan_category` varchar(255) DEFAULT '1',
  `loan_calculation` varchar(255) DEFAULT '1',
  `loan_scheme` varchar(255) DEFAULT '1',
  `area_creation` varchar(255) DEFAULT '1',
  `area_mapping` varchar(255) DEFAULT '1',
  `area_approval` varchar(255) DEFAULT '1',
  `adminmodule` varchar(255) DEFAULT '1',
  `director_creation` varchar(255) DEFAULT '1',
  `agent_creation` varchar(255) DEFAULT '1',
  `staff_creation` varchar(255) DEFAULT '1',
  `manage_user` varchar(255) DEFAULT '1',
  `doc_mapping` varchar(255) NOT NULL DEFAULT '1',
  `bank_creation` varchar(10) NOT NULL DEFAULT '1',
  `requestmodule` varchar(255) DEFAULT '1',
  `request` varchar(255) DEFAULT '1',
  `request_list_access` varchar(255) NOT NULL DEFAULT '1',
  `verificationmodule` varchar(255) DEFAULT '1',
  `verification` varchar(255) DEFAULT '1',
  `approvalmodule` varchar(255) NOT NULL DEFAULT '1',
  `approval` varchar(255) NOT NULL DEFAULT '1',
  `acknowledgementmodule` varchar(255) NOT NULL DEFAULT '1',
  `acknowledgement` varchar(255) NOT NULL DEFAULT '1',
  `loanissuemodule` varchar(255) DEFAULT '1',
  `loan_issue` varchar(255) DEFAULT '1',
  `collectionmodule` varchar(25) NOT NULL DEFAULT '1',
  `collection` varchar(25) NOT NULL DEFAULT '1',
  `collection_access` varchar(25) NOT NULL DEFAULT '1',
  `closedmodule` varchar(10) NOT NULL DEFAULT '1',
  `closed` varchar(10) NOT NULL DEFAULT '1',
  `nocmodule` varchar(10) NOT NULL DEFAULT '1',
  `noc` varchar(10) NOT NULL DEFAULT '1',
  `doctrackmodule` varchar(50) NOT NULL DEFAULT '1',
  `doctrack` varchar(50) NOT NULL DEFAULT '1',
  `doc_rec_access` varchar(50) NOT NULL DEFAULT '1',
  `updatemodule` varchar(10) NOT NULL DEFAULT '1',
  `update_screen` varchar(10) NOT NULL DEFAULT '1',
  `concernmodule` varchar(10) DEFAULT '1',
  `concern_creation` varchar(10) DEFAULT '1',
  `concern_solution` varchar(10) DEFAULT '1',
  `concern_feedback` varchar(50) DEFAULT '1',
  `accountsmodule` varchar(10) NOT NULL DEFAULT '1',
  `cash_tally` varchar(10) NOT NULL DEFAULT '1',
  `bank_details` varchar(255) DEFAULT NULL,
  `cash_tally_admin` varchar(10) NOT NULL DEFAULT '1',
  `bank_clearance` varchar(10) NOT NULL DEFAULT '1',
  `finance_insight` varchar(10) NOT NULL DEFAULT '1',
  `followupmodule` varchar(10) DEFAULT '1',
  `promotion_activity` varchar(10) DEFAULT '1',
  `loan_followup` varchar(10) DEFAULT '1',
  `confirmation_followup` varchar(10) DEFAULT '1',
  `due_followup` varchar(10) DEFAULT '1',
  `reportmodule` varchar(10) NOT NULL DEFAULT '1',
  `ledger_report` varchar(10) NOT NULL DEFAULT '1',
  `request_report` varchar(10) NOT NULL DEFAULT '1',
  `cus_profile_report` varchar(10) NOT NULL DEFAULT '1',
  `loan_issue_report` varchar(10) NOT NULL DEFAULT '1',
  `collection_report` varchar(10) NOT NULL DEFAULT '1',
  `balance_report` varchar(10) NOT NULL DEFAULT '1',
  `due_list_report` varchar(10) NOT NULL DEFAULT '1',
  `closed_report` varchar(10) NOT NULL DEFAULT '1',
  `search_module` varchar(10) NOT NULL DEFAULT '1',
  `search` varchar(10) NOT NULL DEFAULT '1',
  `bulk_upload_module` varchar(10) NOT NULL DEFAULT '1',
  `bulk_upload` varchar(10) NOT NULL DEFAULT '1',
  `loan_track_module` varchar(10) NOT NULL DEFAULT '1',
  `loan_track` varchar(10) NOT NULL DEFAULT '1',
  `status` varchar(255) NOT NULL DEFAULT '0',
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `delete_login_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `updated_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `firstname`, `lastname`, `fullname`, `title`, `emailid`, `user_name`, `user_password`, `role`, `role_type`, `dir_id`, `ag_id`, `staff_id`, `company_id`, `branch_id`, `loan_cat`, `agentforstaff`, `line_id`, `group_id`, `mastermodule`, `company_creation`, `branch_creation`, `loan_category`, `loan_calculation`, `loan_scheme`, `area_creation`, `area_mapping`, `area_approval`, `adminmodule`, `director_creation`, `agent_creation`, `staff_creation`, `manage_user`, `doc_mapping`, `bank_creation`, `requestmodule`, `request`, `request_list_access`, `verificationmodule`, `verification`, `approvalmodule`, `approval`, `acknowledgementmodule`, `acknowledgement`, `loanissuemodule`, `loan_issue`, `collectionmodule`, `collection`, `collection_access`, `closedmodule`, `closed`, `nocmodule`, `noc`, `doctrackmodule`, `doctrack`, `doc_rec_access`, `updatemodule`, `update_screen`, `concernmodule`, `concern_creation`, `concern_solution`, `concern_feedback`, `accountsmodule`, `cash_tally`, `bank_details`, `cash_tally_admin`, `bank_clearance`, `finance_insight`, `followupmodule`, `promotion_activity`, `loan_followup`, `confirmation_followup`, `due_followup`, `reportmodule`, `ledger_report`, `request_report`, `cus_profile_report`, `loan_issue_report`, `collection_report`, `balance_report`, `due_list_report`, `closed_report`, `search_module`, `search`, `bulk_upload_module`, `bulk_upload`, `loan_track_module`, `loan_track`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, 'Super', 'Admin', 'Super Admin', 'Super Admin', 'support@feathertechnology.in', 'support@feathertechnology.in', 'admin@123', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', NULL, '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '', '', '1', '1', '0', NULL, NULL, NULL, '2021-04-17 17:08:00', '2023-03-21 09:51:34'),
(2, NULL, NULL, 'Arun', NULL, 'arunfeather27@gmail.com', 'arun', '123', '3', '4', '', '', '1', '1', '1,2,3', '1,2,6,7,8,11', '1,2', '1,2,3,4,5', '1,2,3,4,5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '2', NULL, '2023-07-01 12:10:48', '2024-03-11 16:58:46'),
(3, NULL, NULL, 'Alaathi Mobiles and Furniture', NULL, 'alaathi@gmail.com', 'alaathi', '123', '2', '', '', '1', '', '1', '3', '', '', '1,6', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '', '', '1', '1', '0', '2', '2', NULL, '2023-07-01 12:12:04', '2024-02-01 15:17:15'),
(4, NULL, NULL, 'Jafar', NULL, '', 'jafar', '123', '3', '1', '', '', '28', '1', '1', '5,7,8', '', '4,5', '4', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '1', '0', '0', '1', '1', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1', '0', '1', '1', '1', '1', '1', '1', '1', '', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '', '', '1', '1', '0', '2', '2', NULL, '2023-07-03 11:59:48', '2024-01-11 16:01:41'),
(5, NULL, NULL, 'Will Smith', NULL, 'www.saravanan@gmail.com', 'will', '123', '1', '11', '1', '', '', '1', '1,2,3,4,6,7', '', '', '4,5,6', '4', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1', '1', '1', '0', '1', '1', '0', '0', '1', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '', '1', '1', '1', '0', '1', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '2', '2', NULL, '2023-07-03 13:31:46', '2024-03-09 09:35:36'),
(6, NULL, NULL, 'J Prakash Kumar', NULL, 'hariprakash1292@gmail.com', 'prakash', '123', '3', '1', '', '', '2', '1', '1,3', '5,10,11', '', '4,6', '4', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1', '0', '1', '1', '1', '', '1', '1', '1', '0', '1', '1', '1', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '', '', '1', '1', '0', '2', '2', NULL, '2023-11-29 17:20:14', '2024-01-06 15:42:29');

-- --------------------------------------------------------

--
-- Table structure for table `verification_bank_info`
--

CREATE TABLE `verification_bank_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` int(11) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `acc_holder_name` varchar(100) NOT NULL,
  `acc_no` bigint(20) NOT NULL,
  `ifsc_code` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verification_bank_info`
--

INSERT INTO `verification_bank_info` (`id`, `cus_id`, `req_id`, `bank_name`, `branch_name`, `acc_holder_name`, `acc_no`, `ifsc_code`) VALUES
(1, '500050005000', 11, 'HDFC', 'Chetpet', 'Manikandan', 123456789, 'HDFC123');

-- --------------------------------------------------------

--
-- Table structure for table `verification_cus_feedback`
--

CREATE TABLE `verification_cus_feedback` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `feedback_label` varchar(255) DEFAULT NULL,
  `cus_feedback` varchar(255) DEFAULT NULL,
  `feedback_remark` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verification_cus_feedback`
--

INSERT INTO `verification_cus_feedback` (`id`, `cus_id`, `req_id`, `feedback_label`, `cus_feedback`, `feedback_remark`) VALUES
(1, '300030003000', '7', 'GG', '4', ''),
(2, '200020002000', '6', 'Good', '4', ''),
(3, '100010001000', '7', 'Average', '4', 'Average'),
(4, '500050005000', '11', 'Good trusted customer', '5', '');

-- --------------------------------------------------------

--
-- Table structure for table `verification_documentation`
--

CREATE TABLE `verification_documentation` (
  `id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id_doc` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `cus_profile_id` varchar(255) DEFAULT NULL,
  `doc_id` varchar(255) DEFAULT NULL,
  `mortgage_process` varchar(100) DEFAULT NULL,
  `Propertyholder_type` varchar(100) DEFAULT NULL,
  `Propertyholder_name` varchar(255) DEFAULT NULL,
  `Propertyholder_relationship_name` varchar(100) DEFAULT NULL,
  `doc_property_relation` varchar(100) DEFAULT NULL,
  `doc_property_type` varchar(255) DEFAULT NULL,
  `doc_property_measurement` varchar(255) DEFAULT NULL,
  `doc_property_location` varchar(255) DEFAULT NULL,
  `doc_property_value` varchar(255) DEFAULT NULL,
  `mortgage_name` varchar(255) DEFAULT NULL,
  `mortgage_dsgn` varchar(255) DEFAULT NULL,
  `mortgage_nuumber` varchar(255) DEFAULT NULL,
  `reg_office` varchar(255) DEFAULT NULL,
  `mortgage_value` varchar(255) DEFAULT NULL,
  `mortgage_document` varchar(255) DEFAULT NULL,
  `mortgage_document_upd` varchar(255) DEFAULT NULL,
  `mortgage_document_pending` varchar(150) DEFAULT NULL,
  `endorsement_process` varchar(50) DEFAULT NULL,
  `owner_type` varchar(100) DEFAULT NULL,
  `owner_name` varchar(200) DEFAULT NULL,
  `ownername_relationship_name` varchar(100) DEFAULT NULL,
  `en_relation` varchar(100) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `vehicle_process` varchar(50) DEFAULT NULL,
  `en_Company` varchar(200) DEFAULT NULL,
  `en_Model` varchar(200) DEFAULT NULL,
  `vehicle_reg_no` varchar(150) DEFAULT NULL,
  `endorsement_name` varchar(255) DEFAULT NULL,
  `en_RC` varchar(50) DEFAULT NULL,
  `Rc_document_upd` varchar(255) DEFAULT NULL,
  `Rc_document_pending` varchar(150) DEFAULT NULL,
  `en_Key` varchar(50) DEFAULT NULL,
  `gold_info` varchar(50) DEFAULT NULL,
  `gold_sts` varchar(50) DEFAULT NULL,
  `gold_type` varchar(255) DEFAULT NULL,
  `Purity` varchar(255) DEFAULT NULL,
  `gold_Count` varchar(255) DEFAULT NULL,
  `gold_Weight` varchar(255) DEFAULT NULL,
  `gold_Value` varchar(255) DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_details` varchar(255) DEFAULT NULL,
  `document_type` varchar(50) DEFAULT NULL,
  `document_holder` varchar(50) DEFAULT NULL,
  `docholder_name` varchar(255) DEFAULT NULL,
  `docholder_relationship_name` varchar(50) DEFAULT NULL,
  `doc_relation` varchar(50) DEFAULT NULL,
  `cus_status` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `insert_login_id` varchar(50) DEFAULT NULL,
  `update_login_id` varchar(50) DEFAULT NULL,
  `delete_login_id` varchar(50) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verification_documentation`
--

INSERT INTO `verification_documentation` (`id`, `req_id`, `cus_id_doc`, `customer_name`, `cus_profile_id`, `doc_id`, `mortgage_process`, `Propertyholder_type`, `Propertyholder_name`, `Propertyholder_relationship_name`, `doc_property_relation`, `doc_property_type`, `doc_property_measurement`, `doc_property_location`, `doc_property_value`, `mortgage_name`, `mortgage_dsgn`, `mortgage_nuumber`, `reg_office`, `mortgage_value`, `mortgage_document`, `mortgage_document_upd`, `mortgage_document_pending`, `endorsement_process`, `owner_type`, `owner_name`, `ownername_relationship_name`, `en_relation`, `vehicle_type`, `vehicle_process`, `en_Company`, `en_Model`, `vehicle_reg_no`, `endorsement_name`, `en_RC`, `Rc_document_upd`, `Rc_document_pending`, `en_Key`, `gold_info`, `gold_sts`, `gold_type`, `Purity`, `gold_Count`, `gold_Weight`, `gold_Value`, `document_name`, `document_details`, `document_type`, `document_holder`, `docholder_name`, `docholder_relationship_name`, `doc_relation`, `cus_status`, `status`, `insert_login_id`, `update_login_id`, `delete_login_id`, `created_date`, `updated_date`) VALUES
(1, '2', '100010001000', 'Ganesan', '1', 'DOC-101', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '5', NULL, NULL, '2023-07-06 10:14:58', '2023-07-06 10:14:58'),
(2, '6', '200020002000', 'Aravind', '3', 'DOC-102', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', 'Aravind', '', 'NIL', '0', '0', 'TVS', '100', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-07-10 13:17:40', '2023-07-10 13:17:40'),
(3, '6', '200020002000', 'Aravind', '3', 'DOC-102', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', 'Aravind', '', 'NIL', '0', '0', 'TVS', '100', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-07-10 13:23:39', '2023-07-10 13:23:39'),
(4, '5', '100010001000', 'Ganesan', '4', 'DOC-103', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '1', 'Aravindh', '', 'Brother', '0', '0', 'TVS', 'RTR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-01-13 10:21:06', '2023-01-13 10:21:06'),
(5, '7', '300030003000', 'Rakesh', '2', 'DOC-104', '0', '0', 'Rakesh', '', 'NIL', 'House', '10*10', 'Vilupuram', '67800', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '5', NULL, NULL, '2023-07-13 13:31:36', '2023-07-13 13:31:36'),
(6, '8', '200020002000', 'Aravind', '5', 'DOC-105', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-01-01 16:17:35', '2023-01-01 16:17:35'),
(7, '1', '010720232023', 'Bharath', '7', 'DOC-106', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '3', NULL, NULL, '2023-07-18 18:33:48', '2023-07-18 18:33:48'),
(8, '11', '500050005000', 'Manikandan', '8', 'DOC-107', '0', '2', '', '9', 'Father', 'Land', '1107*1010', 'Chetpet', '145000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', 'Manikandan', '', 'NIL', '0', '0', 'Bajaj', 'Platina', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-07-21 12:15:37', '2023-07-21 12:15:37'),
(9, '9', '100010001000', 'Ganesan', '6', 'DOC-108', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '5', NULL, NULL, '2023-07-27 13:18:50', '2023-07-27 13:18:50'),
(10, '12', '400040004000', 'Bharathi', '9', 'DOC-109', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-08-02 15:06:24', '2023-08-02 15:06:24'),
(11, '10', '300030003000', 'Rakesh', '10', 'DOC-110', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-08-07 11:07:01', '2023-08-07 11:07:01'),
(12, '16', '060120230408', 'Gnanasekar', '11', 'DOC-111', '0', '1', 'Senthil raja', '', 'Father', 'Land', '1107*1010', 'Chetpet', '145000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-09-07 15:31:15', '2023-09-07 15:31:15'),
(13, '18', '100010001000', 'Ganesan', '13', 'DOC-112', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-09-06 12:11:41', '2023-09-06 12:11:41'),
(14, '21', '261910026191', 'Leo Das', '14', 'DOC-113', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2023-12-28 10:50:58', '2023-12-28 10:50:58'),
(15, '22', '000000000001', 'Senthil kumaran', '15', 'DOC-114', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2024-01-02 15:47:01', '2024-01-02 15:47:01'),
(16, '23', '000000000001', 'Senthil kumaran', '16', 'DOC-115', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2024-01-06 11:28:54', '2024-01-06 11:28:54'),
(17, '24', '000000000001', 'Senthil kumaran', '17', 'DOC-116', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2024-01-06 11:30:16', '2024-01-06 11:30:16'),
(25, '77', '123412341234', 'Rajesh', '25', 'DOC-117', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(26, '78', '474747474747', 'Murugesan', '26', 'DOC-118', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(27, '79', '575757575757', 'Sugumaran', '27', 'DOC-119', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(32, '84', '676767676767', 'Ilambarithi', '32', 'DOC-120', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(33, '14', '200020002000', 'Aravind', '12', 'DOC-121', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2024-03-13 10:50:52', '2024-03-13 10:50:52'),
(34, '87', '525252525252', 'Pooja', '33', 'DOC-122', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', '2', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(35, '88', '525252525252', 'Pooja', '34', 'DOC-123', '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2', NULL, NULL, '2024-03-28 16:16:58', '2024-03-28 16:16:58');

-- --------------------------------------------------------

--
-- Table structure for table `verification_family_info`
--

CREATE TABLE `verification_family_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(100) DEFAULT NULL,
  `req_id` int(11) NOT NULL,
  `famname` varchar(100) NOT NULL,
  `relationship` text NOT NULL,
  `other_remark` varchar(100) DEFAULT NULL,
  `other_address` varchar(200) DEFAULT NULL,
  `relation_age` int(11) NOT NULL,
  `relation_aadhar` varchar(50) NOT NULL,
  `relation_Mobile` double NOT NULL,
  `relation_Occupation` text NOT NULL,
  `relation_Income` double NOT NULL,
  `relation_Blood` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verification_family_info`
--

INSERT INTO `verification_family_info` (`id`, `cus_id`, `req_id`, `famname`, `relationship`, `other_remark`, `other_address`, `relation_age`, `relation_aadhar`, `relation_Mobile`, `relation_Occupation`, `relation_Income`, `relation_Blood`, `status`) VALUES
(1, '100010001000', 2, 'Guna', 'Father', '', ' ', 45, '100010002000', 9894966545, 'Retired', 0, 'O+', 0),
(2, '100010001000', 2, 'Selvi', 'Mother', '', ' ', 43, '100010003000', 9894984954, 'House wife', 0, 'B+', 0),
(3, '100010001000', 2, 'Aravindh', 'Brother', '', ' ', 35, '200020002000', 9794949494, 'Coconut shop', 15000, '', 0),
(4, '200020002000', 6, 'Guna', 'Father', '', ' ', 45, '100010002000', 9894966545, 'Retired', 0, '', 0),
(5, '200020002000', 6, 'Ganesan', 'Brother', '', ' ', 27, '100010001000', 6465465464, 'shop', 20000, '', 0),
(6, '200020002000', 6, 'Selvi', 'Mother', '', ' ', 42, '100010003000', 9894984954, 'Housewife', 0, '', 0),
(7, '300030003000', 7, 'Vivek', 'Father', '', ' ', 57, '165489798798', 9844654213, 'VIP', 0, '', 0),
(8, '010720232023', 1, 'Senthil kumar', 'Father', '', ' ', 55, '465461321321', 8949165165, 'NIL', 0, '', 0),
(9, '500050005000', 11, 'Mani kapoor', 'Father', '', ' ', 45, '500150015001', 7999979999, 'NA', 0, '', 0),
(10, '500050005000', 11, 'Manimegalai', 'Mother', '', ' ', 43, '500250025002', 7444474444, 'NA', 0, 'O+', 0),
(11, '400040004000', 12, 'Vedha', 'Father', '', ' ', 45, '400140014001', 98465, 'NIL', 0, '', 0),
(12, '060120230408', 16, 'Senthil raja', 'Father', '', ' ', 55, '070920230325', 9382964883, 'Mechanic', 15000, '', 0),
(14, '261910026191', 21, 'Antony Das', 'Father', '', ' ', 55, '261910026192', 2619100262, 'Rowdy', 0, '', 0),
(15, '000000000001', 22, 'Kumaran', 'Father', '', ' ', 45, '100000000001', 7646540213, 'VIP', 0, '', 0),
(17, '123412341234', 71, 'Sowmiya', 'Spouse', NULL, NULL, 25, '123123000000', 9952741651, 'NO', 0, '', 0),
(23, '123412341234', 77, 'Sowmiya', 'Spouse', NULL, NULL, 25, '123123000000', 9952741651, 'NO', 0, '', 0),
(24, '474747474747', 78, 'Sowmiya', 'Spouse', NULL, NULL, 25, '123123000000', 9952741651, 'NO', 0, '', 0),
(25, '575757575757', 79, 'Sowmiya', 'Spouse', NULL, NULL, 25, '123123000000', 9952741651, 'NO', 0, '', 0),
(30, '676767676767', 84, 'Sowmiya', 'Spouse', NULL, NULL, 25, '123123000000', 9952741651, 'NO', 0, '', 0),
(31, '525252525252', 87, 'Sowmiya', 'Spouse', NULL, NULL, 25, '123123000000', 9952741651, 'NO', 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `verification_group_info`
--

CREATE TABLE `verification_group_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` int(11) NOT NULL,
  `group_name` varchar(50) NOT NULL,
  `group_age` int(11) NOT NULL,
  `group_aadhar` text NOT NULL,
  `group_mobile` double NOT NULL,
  `group_gender` text NOT NULL,
  `group_designation` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verification_group_info`
--

INSERT INTO `verification_group_info` (`id`, `cus_id`, `req_id`, `group_name`, `group_age`, `group_aadhar`, `group_mobile`, `group_gender`, `group_designation`) VALUES
(3, '2000 2000 2000', 6, 'Aravindh', 35, '200020002000', 9794949494, '1', 'Member'),
(4, '500050005000', 11, 'Manikandan', 28, '500050005000', 7888878888, '1', 'Employer');

-- --------------------------------------------------------

--
-- Table structure for table `verification_kyc_info`
--

CREATE TABLE `verification_kyc_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` int(11) NOT NULL,
  `proofOf` varchar(50) NOT NULL,
  `fam_mem` varchar(255) NOT NULL,
  `proof_type` varchar(50) NOT NULL,
  `proof_no` varchar(50) NOT NULL,
  `upload` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verification_kyc_info`
--

INSERT INTO `verification_kyc_info` (`id`, `cus_id`, `req_id`, `proofOf`, `fam_mem`, `proof_type`, `proof_no`, `upload`) VALUES
(9, '100010001000', 2, '0', '', '3', '325356', ''),
(10, '100010001000', 2, '2', 'Guna', '2', '255456', ''),
(12, '300030003000', 7, '0', '', '2', '12345647987', ''),
(13, '2000 2000 2000', 6, '0', '', '10', '64654654', ''),
(14, '100010001000', 5, '0', '', '2', '253445676', ''),
(15, '200020002000', 8, '0', '', '10', '1232435', ''),
(16, '100010001000', 9, '1', '', '1', '132', ''),
(17, '010720232023', 1, '0', '', '3', '1324', ''),
(18, '500050005000', 11, '3', '', '1', '123', ''),
(19, '500050005000', 11, '0', '', '2', '123', ''),
(20, '400040004000', 12, '0', '', '1', '123', ''),
(21, '060120230408', 16, '0', '', '2', '123456', ''),
(25, '010720232023', 1, '0', '', '2', '232', '7726900d60273ca6bd9ef225e8eb1764.png'),
(26, '200020002000', 14, '2', 'Ganesan', '8', '123', ''),
(27, '261910026191', 21, '2', 'Antony Das', '5', '132131321', ''),
(28, '000000000001', 22, '0', '', '9', '123', ''),
(29, '090920230103', 17, '0', '', '4', '1213', ''),
(30, '090920230103', 17, '1', '', '5', '223', ''),
(31, '200020002000', 14, '1', '', '2', '1111', ''),
(32, '525252525252', 88, '0', '', '1', '525252525252', '66054a752eab4.');

-- --------------------------------------------------------

--
-- Table structure for table `verification_loan_calculation`
--

CREATE TABLE `verification_loan_calculation` (
  `loan_cal_id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `cus_id_loan` varchar(255) DEFAULT NULL,
  `cus_name_loan` varchar(255) DEFAULT NULL,
  `cus_data_loan` varchar(255) DEFAULT NULL,
  `mobile_loan` varchar(255) DEFAULT NULL,
  `pic_loan` varchar(255) DEFAULT NULL,
  `loan_category` varchar(255) DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `tot_value` varchar(255) DEFAULT NULL,
  `ad_amt` varchar(255) DEFAULT NULL,
  `loan_amt` varchar(255) DEFAULT NULL,
  `profit_type` varchar(255) DEFAULT NULL,
  `due_method_calc` varchar(255) DEFAULT NULL,
  `due_type` varchar(255) DEFAULT NULL,
  `profit_method` varchar(255) DEFAULT NULL,
  `calc_method` varchar(255) DEFAULT NULL,
  `due_method_scheme` varchar(255) DEFAULT NULL,
  `day_scheme` varchar(255) DEFAULT NULL,
  `scheme_name` varchar(255) DEFAULT NULL,
  `int_rate` varchar(255) DEFAULT NULL,
  `due_period` varchar(255) DEFAULT NULL,
  `doc_charge` varchar(255) DEFAULT NULL,
  `proc_fee` varchar(255) DEFAULT NULL,
  `loan_amt_cal` varchar(255) DEFAULT NULL,
  `principal_amt_cal` varchar(255) DEFAULT NULL,
  `int_amt_cal` varchar(255) DEFAULT NULL,
  `tot_amt_cal` varchar(255) DEFAULT NULL,
  `due_amt_cal` varchar(255) DEFAULT NULL,
  `doc_charge_cal` varchar(255) DEFAULT NULL,
  `proc_fee_cal` varchar(255) DEFAULT NULL,
  `net_cash_cal` varchar(255) DEFAULT NULL,
  `due_start_from` varchar(255) DEFAULT NULL,
  `maturity_month` varchar(255) DEFAULT NULL,
  `collection_method` varchar(255) DEFAULT NULL,
  `communication` varchar(50) DEFAULT NULL,
  `com_audio` varchar(255) DEFAULT NULL,
  `verification_person` varchar(255) DEFAULT NULL,
  `verification_location` varchar(255) DEFAULT NULL,
  `cus_status` varchar(255) DEFAULT NULL,
  `insert_login_id` varchar(255) DEFAULT NULL,
  `update_login_id` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `verification_loan_calculation`
--

INSERT INTO `verification_loan_calculation` (`loan_cal_id`, `req_id`, `cus_id_loan`, `cus_name_loan`, `cus_data_loan`, `mobile_loan`, `pic_loan`, `loan_category`, `sub_category`, `tot_value`, `ad_amt`, `loan_amt`, `profit_type`, `due_method_calc`, `due_type`, `profit_method`, `calc_method`, `due_method_scheme`, `day_scheme`, `scheme_name`, `int_rate`, `due_period`, `doc_charge`, `proc_fee`, `loan_amt_cal`, `principal_amt_cal`, `int_amt_cal`, `tot_amt_cal`, `due_amt_cal`, `doc_charge_cal`, `proc_fee_cal`, `net_cash_cal`, `due_start_from`, `maturity_month`, `collection_method`, `communication`, `com_audio`, `verification_person`, `verification_location`, `cus_status`, `insert_login_id`, `update_login_id`, `create_date`, `update_date`) VALUES
(8, '2', '100010001000', 'Ganesan', 'New', '6465465464', 'monkey1.avif', '5', 'TV', '43800', '2000', '41800', '2', '', '', '', '', '1', '', '10', '10', '8', '1', '1', '41800', '37620', '4180', '41800', '5225', '418', '418', '36784', '2023-07-10', '2024-03-10', '2', '1', '', '100010001000', '1', '12', '5', '5', '2023-07-07 15:26:11', '2023-07-07 15:47:13'),
(10, '6', '200020002000', 'Aravind', 'New', '9794949494', 'pexels-pixabay-220453.jpg', '6', 'Mobiles', '', '', '50000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '1.6', '6', '1.2', '2', '50000', '45200', '4810', '50010', '8335', '600', '1000', '43600', '2023-07-15', '2024-01-15', '1', '1', '', '5', '1', '12', '2', NULL, '2023-07-10 16:33:24', '2023-07-10 16:33:24'),
(11, '5', '100010001000', 'Ganesan', 'Existing', '6465465464', 'monkey1.avif', '2', 'Bike', '65000', '5000', '60000', '2', '', '', '', '', '1', '', '5', '10', '6', '1.4', '1.9', '60000', '54000', '6000', '60000', '10000', '839', '600', '52561', '2023-01-14', '2023-07-14', '1', '1', '', '3', '0', '12', '2', NULL, '2023-01-13 10:23:42', '2023-01-13 10:23:42'),
(12, '7', '300030003000', 'Rakesh', 'New', '9664565132', 'person_sample_4.jpg', '9', 'Education', '', '', '56790', '2', '', '', '', '', '1', '', '16', '11', '10', '5', '5', '56790', '50540', '6260', '56800', '5680', '2839', '2839', '44865', '2023-01-03', '2023-11-03', '2', '1', '', '300030003000', '0', '12', '5', NULL, '2023-01-03 13:37:32', '2023-01-03 13:37:32'),
(13, '8', '200020002000', 'Aravind', 'Existing', '9794949494', 'pexels-pixabay-220453.jpg', '1', 'Personal', '35500', '3500', '32500', '2', '', '', '', '', '3', '', '8', '7', '20', '1', '1', '32500', '30225', '2275', '32500', '1625', '325', '325', '29575', '2023-01-02', '2023-01-22', '2', '1', '', '200020002000', '0', '12', '2', NULL, '2023-01-01 16:21:32', '2023-01-01 16:21:32'),
(14, '1', '010720232023', 'Bharath', 'New', '9846546546', 'cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.avif', '5', 'AC', '35000', '3000', '37000', '1', 'Monthly', 'EMI', 'after_intrest', '', '', '', '', '1', '6', '1', '1', '37000', '37000', '2240', '39240', '6540', '370', '370', '36260', '2023-08-01', '2024-02-01', '1', '1', '', '010720232023', '0', '12', '3', NULL, '2023-07-18 18:36:23', '2023-07-18 18:36:23'),
(15, '11', '500050005000', 'Manikandan', 'New', '7888878888', 'musk.jpg', '1', 'Personal', '28000', '2000', '26000', '2', '', '', '', '', '2', '6', '6', '7', '22', '1', '1', '26000', '24180', '1890', '26070', '1185', '260', '260', '23660', '2023-07-22', '2023-12-23', '1', '1', '', '500050005000', '1', '12', '2', NULL, '2023-07-21 12:17:06', '2023-07-21 12:17:06'),
(16, '9', '100010001000', 'Ganesan', 'Existing', '6465465464', 'monkey1.avif', '5', 'AC', '35000', '3000', '18500', '1', 'Monthly', 'EMI', 'after_intrest', '', '', '', '', '1', '5', '1', '1', '18500', '18500', '925', '19425', '3885', '185', '185', '18130', '2023-08-02', '2024-01-02', '1', '1', '', '100010001000', '0', '12', '5', NULL, '2023-07-27 13:19:47', '2023-07-27 13:19:47'),
(17, '12', '400040004000', 'Bharathi', 'New', '9459416164', 'images (1).jpg', '1', 'Personal', '', '', '100000', '1', 'Monthly', 'Interest', '', 'Monthly', '', '', '', '2', '10', '1', '1', '100000', '100000', '2000', '', '', '1000', '1000', '98000', '2023-08-02', '2024-06-02', '1', '1', '', '400040004000', '0', '12', '2', NULL, '2023-08-02 15:09:58', '2023-08-02 15:09:58'),
(18, '10', '300030003000', 'Rakesh', 'Existing', '9664565132', 'person_sample_4.jpg', '1', 'Personal', '52000', '4000', '45800', '1', 'Monthly', 'Interest', '', 'Monthly', '', '', '', '1', '10', '1', '1', '45800', '45800', '460', '', '', '460', '460', '44884', '2023-08-10', '2024-06-10', '1', '1', '', '300030003000', '1', '12', '2', NULL, '2023-08-07 11:08:05', '2023-08-07 11:08:05'),
(19, '16', '060120230408', 'Gnanasekar', 'New', '9790171511', 'person_sample_2.jpg', '8', 'Plot Purchase', '50000', '0', '50000', '1', 'Monthly', 'EMI', 'after_intrest', '', '', '', '', '2', '12', '2', '0', '50000', '50000', '12040', '62040', '5170', '1000', '0', '49000', '2023-02-03', '2024-02-03', '1', '1', '', '12', '0', '12', '2', '2', '2023-01-07 15:35:17', '2023-01-07 16:52:04'),
(20, '18', '100010001000', 'Ganesan', 'Existing', '6465465464', 'monkey1.avif', '2', 'Bike', '32000', '5000', '27000', '2', '', '', '', '', '1', '2', '5', '10', '6', '1', '1', '27000', '24300', '2700', '27000', '4500', '270', '270', '23760', '2023-09-15', '2024-02-15', '1', '0', '', '1', '0', '12', '2', NULL, '2023-09-06 12:12:52', '2023-09-06 12:12:52'),
(21, '21', '261910026191', 'Leo Das', 'New', '2619100261', '658bc19b427cb.jpg', '6', 'Mobiles', '', '', '45000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '1', '10', '1', '1', '45000', '40500', '4500', '45000', '4500', '450', '450', '39600', '2024-01-01', '2024-10-01', '2', '1', '', '14', '0', '12', '2', NULL, '2023-12-28 10:51:52', '2023-12-28 10:51:52'),
(22, '22', '000000000001', 'Senthil kumaran', 'New', '7526312546', '6593e1b875db5.png', '11', 'Interest R', '', '', '54000', '2', '', '', '', '', '3', '', '26', '1', '45', '100', '100', '54000', '53460', '540', '54000', '1200', '100', '100', '53260', '2024-01-03', '2024-02-16', '1', '1', '', '15', '0', '12', '2', NULL, '2024-01-02 15:49:20', '2024-01-02 15:49:20'),
(23, '23', '000000000001', 'Senthil kumaran', 'Existing', '7526312546', '6593e1b875db5.png', '7', 'Small Business', '', '', '11000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '2', '12', '1', '1', '11000', '8360', '2680', '11040', '920', '110', '110', '8140', '2024-01-07', '2024-12-07', '1', '1', '', '000000000001', '0', '12', '2', NULL, '2024-01-06 11:29:51', '2024-01-06 11:29:51'),
(24, '24', '000000000001', 'Senthil kumaran', 'Existing', '7526312546', '6593e1b875db5.png', '7', 'Small Business', '', '', '25000', '2', '', '', '', '', '2', '6', '13', '12', '10', '1', '1', '25000', '22000', '3000', '25000', '2500', '250', '5', '21749', '2024-01-13', '2024-03-16', '1', '1', '', '15', '0', '12', '2', NULL, '2024-01-06 11:32:03', '2024-01-06 11:32:03'),
(32, '77', '123412341234', 'Rajesh', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '123412341234', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(33, '78', '474747474747', 'Murugesan', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '24', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(34, '79', '575757575757', 'Sugumaran', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '25', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(39, '84', '676767676767', 'Ilambarithi', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '656565.mp3', '30', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(40, '14', '200020002000', 'Aravind', 'Existing', '9794949494', 'pexels-pixabay-220453.jpg', '7', 'Small Business', '', '', '50000', '1', 'Monthly', 'EMI', 'pre_intrest', '', '', '', '', '1.5', '12', '1', '1', '50000', '41000', '9040', '50040', '4170', '500', '500', '40000', '2024-04-01', '2025-03-01', '1', '1', '', '200020002000', '0', '12', '2', NULL, '2024-03-13 10:51:30', '2024-03-13 10:51:30'),
(41, '87', '525252525252', 'Pooja', 'New', '7708261661', '', '1', 'Personal', '', '', '25000', '1', 'Monthly', 'EMI', 'after_interest', '', '', '', '', '2', '10', '2', '0', '25000', '25000', '5000', '30000', '3000', '500', '0', '24500', '2024-02-01', '2024-11-01', '1', '1', '', '31', '1', '12', '2', '2', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
(42, '88', '525252525252', 'Pooja', 'Existing', '7708261661', '6605494c00dfe.jpg', '1', 'Personal', '100000', '0', '100000', '1', 'Monthly', 'Interest', '', 'Monthly', '', '', '', '3', '12', '1', '2', '100000', '100000', '3000', '', '', '1000', '2000', '97000', '2024-04-05', '2025-03-05', '1', '1', '', '525252525252', '0', '12', '2', NULL, '2024-03-28 16:18:33', '2024-03-28 16:18:33');

-- --------------------------------------------------------

--
-- Table structure for table `verification_property_info`
--

CREATE TABLE `verification_property_info` (
  `id` int(11) NOT NULL,
  `cus_id` varchar(250) DEFAULT NULL,
  `req_id` int(11) NOT NULL,
  `property_type` varchar(50) NOT NULL,
  `property_measurement` varchar(50) NOT NULL,
  `property_value` varchar(50) NOT NULL,
  `property_holder` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verification_property_info`
--

INSERT INTO `verification_property_info` (`id`, `cus_id`, `req_id`, `property_type`, `property_measurement`, `property_value`, `property_holder`) VALUES
(1, '200020002000', 6, 'House', '1500*1000', '150000', 'Aravind');

-- --------------------------------------------------------

--
-- Table structure for table `verif_loan_cal_category`
--

CREATE TABLE `verif_loan_cal_category` (
  `cat_id` int(11) NOT NULL,
  `req_id` varchar(255) DEFAULT NULL,
  `loan_cal_id` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `verif_loan_cal_category`
--

INSERT INTO `verif_loan_cal_category` (`cat_id`, `req_id`, `loan_cal_id`, `category`) VALUES
(34, '2', '8', 'Micromax'),
(35, '2', '8', '40'),
(36, '2', '8', 'LED'),
(37, '6', '10', 'Samsung'),
(38, '6', '10', '6inch'),
(39, '5', '11', 'Bajaj'),
(40, '5', '11', 'CBR'),
(41, '7', '12', 'ABC'),
(42, '7', '12', '1styear'),
(43, '8', '13', '8500'),
(44, '1', '14', 'Carrier'),
(45, '1', '14', '1ton'),
(46, '1', '14', 'Split'),
(47, '11', '15', '7500'),
(48, '9', '16', 'Carrier'),
(49, '9', '16', '1ton'),
(50, '9', '16', 'Split'),
(51, '12', '17', '25000'),
(52, '10', '18', '8500'),
(56, '16', '19', '1000 500'),
(57, '16', '19', '5000 sqft'),
(58, '16', '19', '1680000'),
(59, '18', '20', 'Bajaj'),
(60, '18', '20', 'Pulsar 150'),
(61, '21', '21', 'Apple'),
(62, '21', '21', '6 11'),
(63, '22', '22', 'VAO'),
(64, '22', '22', '1'),
(65, '22', '22', '1'),
(66, '23', '23', 'Check'),
(67, '23', '23', 'Check'),
(68, '24', '24', 'Check'),
(69, '24', '24', 'Check'),
(77, '77', '32', '10000'),
(78, '78', '33', '10000'),
(79, '79', '34', '10000'),
(84, '84', '39', '10000'),
(85, '14', '40', 'Fridge'),
(86, '14', '40', 'Fridge'),
(87, '87', '41', '10000'),
(88, '88', '42', '80000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acknowledgement_loan_cal_category`
--
ALTER TABLE `acknowledgement_loan_cal_category`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `acknowlegement_customer_profile`
--
ALTER TABLE `acknowlegement_customer_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `acknowlegement_documentation`
--
ALTER TABLE `acknowlegement_documentation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `acknowlegement_loan_calculation`
--
ALTER TABLE `acknowlegement_loan_calculation`
  ADD PRIMARY KEY (`loan_cal_id`);

--
-- Indexes for table `agent_communication_details`
--
ALTER TABLE `agent_communication_details`
  ADD PRIMARY KEY (`comm_id`);

--
-- Indexes for table `agent_creation`
--
ALTER TABLE `agent_creation`
  ADD PRIMARY KEY (`ag_id`);

--
-- Indexes for table `agent_group_creation`
--
ALTER TABLE `agent_group_creation`
  ADD PRIMARY KEY (`agent_group_id`);

--
-- Indexes for table `area_creation`
--
ALTER TABLE `area_creation`
  ADD PRIMARY KEY (`area_creation_id`);

--
-- Indexes for table `area_group_mapping`
--
ALTER TABLE `area_group_mapping`
  ADD PRIMARY KEY (`map_id`);

--
-- Indexes for table `area_line_mapping`
--
ALTER TABLE `area_line_mapping`
  ADD PRIMARY KEY (`map_id`);

--
-- Indexes for table `area_list_creation`
--
ALTER TABLE `area_list_creation`
  ADD PRIMARY KEY (`area_id`);

--
-- Indexes for table `bank_creation`
--
ALTER TABLE `bank_creation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_stmt`
--
ALTER TABLE `bank_stmt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branch_creation`
--
ALTER TABLE `branch_creation`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `cash_tally`
--
ALTER TABLE `cash_tally`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_tally_modes`
--
ALTER TABLE `cash_tally_modes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cheque_info`
--
ALTER TABLE `cheque_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cheque_no_list`
--
ALTER TABLE `cheque_no_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cheque_upd`
--
ALTER TABLE `cheque_upd`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `closed_status`
--
ALTER TABLE `closed_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `collection`
--
ALTER TABLE `collection`
  ADD PRIMARY KEY (`coll_id`);

--
-- Indexes for table `collection_charges`
--
ALTER TABLE `collection_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commitment`
--
ALTER TABLE `commitment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_creation`
--
ALTER TABLE `company_creation`
  ADD PRIMARY KEY (`company_id`);

--
-- Indexes for table `concern_creation`
--
ALTER TABLE `concern_creation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `concern_subject`
--
ALTER TABLE `concern_subject`
  ADD PRIMARY KEY (`concern_sub_id`);

--
-- Indexes for table `confirmation_followup`
--
ALTER TABLE `confirmation_followup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_bank_collection`
--
ALTER TABLE `ct_bank_collection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_bag`
--
ALTER TABLE `ct_cr_bag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_bank_withdraw`
--
ALTER TABLE `ct_cr_bank_withdraw`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_bdeposit`
--
ALTER TABLE `ct_cr_bdeposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_bel`
--
ALTER TABLE `ct_cr_bel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_bexchange`
--
ALTER TABLE `ct_cr_bexchange`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_binvest`
--
ALTER TABLE `ct_cr_binvest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_boti`
--
ALTER TABLE `ct_cr_boti`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_cash_deposit`
--
ALTER TABLE `ct_cr_cash_deposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_hag`
--
ALTER TABLE `ct_cr_hag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_hdeposit`
--
ALTER TABLE `ct_cr_hdeposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_hel`
--
ALTER TABLE `ct_cr_hel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_hexchange`
--
ALTER TABLE `ct_cr_hexchange`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_hinvest`
--
ALTER TABLE `ct_cr_hinvest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_cr_hoti`
--
ALTER TABLE `ct_cr_hoti`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_bag`
--
ALTER TABLE `ct_db_bag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_bank_deposit`
--
ALTER TABLE `ct_db_bank_deposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_bdeposit`
--
ALTER TABLE `ct_db_bdeposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_bel`
--
ALTER TABLE `ct_db_bel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_bexchange`
--
ALTER TABLE `ct_db_bexchange`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_bexpense`
--
ALTER TABLE `ct_db_bexpense`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_binvest`
--
ALTER TABLE `ct_db_binvest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_bissued`
--
ALTER TABLE `ct_db_bissued`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_cash_withdraw`
--
ALTER TABLE `ct_db_cash_withdraw`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_exf`
--
ALTER TABLE `ct_db_exf`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_hag`
--
ALTER TABLE `ct_db_hag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_hdeposit`
--
ALTER TABLE `ct_db_hdeposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_hel`
--
ALTER TABLE `ct_db_hel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_hexchange`
--
ALTER TABLE `ct_db_hexchange`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_hexpense`
--
ALTER TABLE `ct_db_hexpense`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_hinvest`
--
ALTER TABLE `ct_db_hinvest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_db_hissued`
--
ALTER TABLE `ct_db_hissued`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ct_hand_collection`
--
ALTER TABLE `ct_hand_collection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_profile`
--
ALTER TABLE `customer_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_register`
--
ALTER TABLE `customer_register`
  ADD PRIMARY KEY (`cus_reg_id`);

--
-- Indexes for table `cus_old_data`
--
ALTER TABLE `cus_old_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `director_creation`
--
ALTER TABLE `director_creation`
  ADD PRIMARY KEY (`dir_id`);

--
-- Indexes for table `document_info`
--
ALTER TABLE `document_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document_track`
--
ALTER TABLE `document_track`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doc_mapping`
--
ALTER TABLE `doc_mapping`
  ADD PRIMARY KEY (`doc_map_id`);

--
-- Indexes for table `expense_category`
--
ALTER TABLE `expense_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fingerprints`
--
ALTER TABLE `fingerprints`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gold_info`
--
ALTER TABLE `gold_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `in_acknowledgement`
--
ALTER TABLE `in_acknowledgement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `in_issue`
--
ALTER TABLE `in_issue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `in_verification`
--
ALTER TABLE `in_verification`
  ADD PRIMARY KEY (`req_id`);

--
-- Indexes for table `loan_calculation`
--
ALTER TABLE `loan_calculation`
  ADD PRIMARY KEY (`loan_cal_id`);

--
-- Indexes for table `loan_category`
--
ALTER TABLE `loan_category`
  ADD PRIMARY KEY (`loan_category_id`);

--
-- Indexes for table `loan_category_creation`
--
ALTER TABLE `loan_category_creation`
  ADD PRIMARY KEY (`loan_category_creation_id`);

--
-- Indexes for table `loan_category_ref`
--
ALTER TABLE `loan_category_ref`
  ADD PRIMARY KEY (`loan_category_ref_id`);

--
-- Indexes for table `loan_followup`
--
ALTER TABLE `loan_followup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_issue`
--
ALTER TABLE `loan_issue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_scheme`
--
ALTER TABLE `loan_scheme`
  ADD PRIMARY KEY (`scheme_id`);

--
-- Indexes for table `loan_summary_feedback`
--
ALTER TABLE `loan_summary_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `name_detail_creation`
--
ALTER TABLE `name_detail_creation`
  ADD PRIMARY KEY (`name_id`);

--
-- Indexes for table `new_cus_promo`
--
ALTER TABLE `new_cus_promo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `new_promotion`
--
ALTER TABLE `new_promotion`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `noc`
--
ALTER TABLE `noc`
  ADD PRIMARY KEY (`noc_id`);

--
-- Indexes for table `request_category_info`
--
ALTER TABLE `request_category_info`
  ADD PRIMARY KEY (`cat_info`);

--
-- Indexes for table `request_creation`
--
ALTER TABLE `request_creation`
  ADD PRIMARY KEY (`req_id`);

--
-- Indexes for table `signed_doc`
--
ALTER TABLE `signed_doc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `signed_doc_info`
--
ALTER TABLE `signed_doc_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff_creation`
--
ALTER TABLE `staff_creation`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `staff_type_creation`
--
ALTER TABLE `staff_type_creation`
  ADD PRIMARY KEY (`staff_type_id`);

--
-- Indexes for table `sub_area_list_creation`
--
ALTER TABLE `sub_area_list_creation`
  ADD PRIMARY KEY (`sub_area_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- Indexes for table `verification_bank_info`
--
ALTER TABLE `verification_bank_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verification_cus_feedback`
--
ALTER TABLE `verification_cus_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verification_documentation`
--
ALTER TABLE `verification_documentation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verification_family_info`
--
ALTER TABLE `verification_family_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verification_group_info`
--
ALTER TABLE `verification_group_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verification_kyc_info`
--
ALTER TABLE `verification_kyc_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verification_loan_calculation`
--
ALTER TABLE `verification_loan_calculation`
  ADD PRIMARY KEY (`loan_cal_id`);

--
-- Indexes for table `verification_property_info`
--
ALTER TABLE `verification_property_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verif_loan_cal_category`
--
ALTER TABLE `verif_loan_cal_category`
  ADD PRIMARY KEY (`cat_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acknowledgement_loan_cal_category`
--
ALTER TABLE `acknowledgement_loan_cal_category`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `acknowlegement_customer_profile`
--
ALTER TABLE `acknowlegement_customer_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `acknowlegement_documentation`
--
ALTER TABLE `acknowlegement_documentation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `acknowlegement_loan_calculation`
--
ALTER TABLE `acknowlegement_loan_calculation`
  MODIFY `loan_cal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `agent_communication_details`
--
ALTER TABLE `agent_communication_details`
  MODIFY `comm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `agent_creation`
--
ALTER TABLE `agent_creation`
  MODIFY `ag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `agent_group_creation`
--
ALTER TABLE `agent_group_creation`
  MODIFY `agent_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `area_creation`
--
ALTER TABLE `area_creation`
  MODIFY `area_creation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `area_group_mapping`
--
ALTER TABLE `area_group_mapping`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `area_line_mapping`
--
ALTER TABLE `area_line_mapping`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `area_list_creation`
--
ALTER TABLE `area_list_creation`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bank_creation`
--
ALTER TABLE `bank_creation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bank_stmt`
--
ALTER TABLE `bank_stmt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `branch_creation`
--
ALTER TABLE `branch_creation`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cash_tally`
--
ALTER TABLE `cash_tally`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `cash_tally_modes`
--
ALTER TABLE `cash_tally_modes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cheque_info`
--
ALTER TABLE `cheque_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cheque_no_list`
--
ALTER TABLE `cheque_no_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `cheque_upd`
--
ALTER TABLE `cheque_upd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `closed_status`
--
ALTER TABLE `closed_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `collection`
--
ALTER TABLE `collection`
  MODIFY `coll_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=774;

--
-- AUTO_INCREMENT for table `collection_charges`
--
ALTER TABLE `collection_charges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `commitment`
--
ALTER TABLE `commitment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `company_creation`
--
ALTER TABLE `company_creation`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `concern_creation`
--
ALTER TABLE `concern_creation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `concern_subject`
--
ALTER TABLE `concern_subject`
  MODIFY `concern_sub_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `confirmation_followup`
--
ALTER TABLE `confirmation_followup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `ct_bank_collection`
--
ALTER TABLE `ct_bank_collection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `ct_cr_bag`
--
ALTER TABLE `ct_cr_bag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_bank_withdraw`
--
ALTER TABLE `ct_cr_bank_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_bdeposit`
--
ALTER TABLE `ct_cr_bdeposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_bel`
--
ALTER TABLE `ct_cr_bel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_bexchange`
--
ALTER TABLE `ct_cr_bexchange`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_binvest`
--
ALTER TABLE `ct_cr_binvest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_boti`
--
ALTER TABLE `ct_cr_boti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_cash_deposit`
--
ALTER TABLE `ct_cr_cash_deposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_hag`
--
ALTER TABLE `ct_cr_hag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ct_cr_hdeposit`
--
ALTER TABLE `ct_cr_hdeposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_hel`
--
ALTER TABLE `ct_cr_hel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ct_cr_hexchange`
--
ALTER TABLE `ct_cr_hexchange`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_hinvest`
--
ALTER TABLE `ct_cr_hinvest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_cr_hoti`
--
ALTER TABLE `ct_cr_hoti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ct_db_bag`
--
ALTER TABLE `ct_db_bag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_bank_deposit`
--
ALTER TABLE `ct_db_bank_deposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ct_db_bdeposit`
--
ALTER TABLE `ct_db_bdeposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_bel`
--
ALTER TABLE `ct_db_bel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_bexchange`
--
ALTER TABLE `ct_db_bexchange`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_bexpense`
--
ALTER TABLE `ct_db_bexpense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ct_db_binvest`
--
ALTER TABLE `ct_db_binvest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ct_db_bissued`
--
ALTER TABLE `ct_db_bissued`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_cash_withdraw`
--
ALTER TABLE `ct_db_cash_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_exf`
--
ALTER TABLE `ct_db_exf`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_hag`
--
ALTER TABLE `ct_db_hag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ct_db_hdeposit`
--
ALTER TABLE `ct_db_hdeposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_hel`
--
ALTER TABLE `ct_db_hel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_hexchange`
--
ALTER TABLE `ct_db_hexchange`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ct_db_hexpense`
--
ALTER TABLE `ct_db_hexpense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ct_db_hinvest`
--
ALTER TABLE `ct_db_hinvest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `ct_db_hissued`
--
ALTER TABLE `ct_db_hissued`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ct_hand_collection`
--
ALTER TABLE `ct_hand_collection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer_profile`
--
ALTER TABLE `customer_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `customer_register`
--
ALTER TABLE `customer_register`
  MODIFY `cus_reg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `cus_old_data`
--
ALTER TABLE `cus_old_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `director_creation`
--
ALTER TABLE `director_creation`
  MODIFY `dir_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `document_info`
--
ALTER TABLE `document_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `document_track`
--
ALTER TABLE `document_track`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `doc_mapping`
--
ALTER TABLE `doc_mapping`
  MODIFY `doc_map_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_category`
--
ALTER TABLE `expense_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `fingerprints`
--
ALTER TABLE `fingerprints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `gold_info`
--
ALTER TABLE `gold_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `in_acknowledgement`
--
ALTER TABLE `in_acknowledgement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `in_issue`
--
ALTER TABLE `in_issue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `loan_calculation`
--
ALTER TABLE `loan_calculation`
  MODIFY `loan_cal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `loan_category`
--
ALTER TABLE `loan_category`
  MODIFY `loan_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `loan_category_creation`
--
ALTER TABLE `loan_category_creation`
  MODIFY `loan_category_creation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `loan_category_ref`
--
ALTER TABLE `loan_category_ref`
  MODIFY `loan_category_ref_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `loan_followup`
--
ALTER TABLE `loan_followup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `loan_issue`
--
ALTER TABLE `loan_issue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `loan_scheme`
--
ALTER TABLE `loan_scheme`
  MODIFY `scheme_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `loan_summary_feedback`
--
ALTER TABLE `loan_summary_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `name_detail_creation`
--
ALTER TABLE `name_detail_creation`
  MODIFY `name_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `new_cus_promo`
--
ALTER TABLE `new_cus_promo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `new_promotion`
--
ALTER TABLE `new_promotion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `noc`
--
ALTER TABLE `noc`
  MODIFY `noc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `request_category_info`
--
ALTER TABLE `request_category_info`
  MODIFY `cat_info` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `request_creation`
--
ALTER TABLE `request_creation`
  MODIFY `req_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `signed_doc`
--
ALTER TABLE `signed_doc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `signed_doc_info`
--
ALTER TABLE `signed_doc_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `staff_creation`
--
ALTER TABLE `staff_creation`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `staff_type_creation`
--
ALTER TABLE `staff_type_creation`
  MODIFY `staff_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sub_area_list_creation`
--
ALTER TABLE `sub_area_list_creation`
  MODIFY `sub_area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `verification_bank_info`
--
ALTER TABLE `verification_bank_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `verification_cus_feedback`
--
ALTER TABLE `verification_cus_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `verification_documentation`
--
ALTER TABLE `verification_documentation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `verification_family_info`
--
ALTER TABLE `verification_family_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `verification_group_info`
--
ALTER TABLE `verification_group_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `verification_kyc_info`
--
ALTER TABLE `verification_kyc_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `verification_loan_calculation`
--
ALTER TABLE `verification_loan_calculation`
  MODIFY `loan_cal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `verification_property_info`
--
ALTER TABLE `verification_property_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `verif_loan_cal_category`
--
ALTER TABLE `verif_loan_cal_category`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
