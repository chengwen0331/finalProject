-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2023 at 07:14 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barterlt_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `apps_carts`
--

CREATE TABLE `apps_carts` (
  `cart_id` int(5) NOT NULL,
  `item_id` varchar(5) NOT NULL,
  `cart_qty` int(5) NOT NULL,
  `cart_price` float NOT NULL,
  `user_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `cart_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `apps_items`
--

CREATE TABLE `apps_items` (
  `item_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_desc` varchar(200) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_price` float NOT NULL,
  `item_qty` int(5) NOT NULL,
  `item_con` varchar(50) NOT NULL,
  `item_trade` varchar(50) NOT NULL,
  `item_lat` varchar(50) NOT NULL,
  `item_long` varchar(50) NOT NULL,
  `item_state` varchar(50) NOT NULL,
  `item_locality` varchar(50) NOT NULL,
  `item_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `item_status` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `apps_items`
--

INSERT INTO `apps_items` (`item_id`, `user_id`, `item_name`, `item_desc`, `item_type`, `item_price`, `item_qty`, `item_con`, `item_trade`, `item_lat`, `item_long`, `item_state`, `item_locality`, `item_date`, `item_status`) VALUES
(4, 3, 'Table Tennis Racket', 'Shakehand Racket', 'Sports & Fitness', 79.9, 2, 'Good, New', 'STIGA Pro Carbon+ Racket', '4.58283', '101.06917', 'Perak', 'Ipoh', '2023-06-12 17:51:46.888659', 'New'),
(6, 3, 'Sofa', 'White color, cotton', 'Home & Furniture', 299.9, 1, '7/10', 'Table', '4.70602', '101.127535', 'Perak', 'Chemor', '2023-06-12 18:49:14.584636', 'New'),
(8, 2, 'PS4', 'High game resolution', 'Toys & Games', 2100, 1, '9/10', 'Nintendo Switch', '4.7087567', '101.1247883', 'Perak', 'Chemor', '2023-06-12 20:44:59.970806', 'New'),
(9, 1, 'Apple Pencil', '2nd Generation', 'Electronics', 499.9, 2, '10/10', 'Pink Color Apple Pencil', '4.58283', '101.06917', 'Perak', 'Ipoh', '2023-06-12 22:33:55.497309', 'New'),
(10, 1, 'Wooden Table', '75cm in height', 'Home & Furniture', 499.9, 1, 'New', 'Alpha Table', '6.5186633', '100.1984133', 'Perlis', 'Kangar', '2023-07-03 10:13:43.526192', 'New'),
(11, 1, 'Philips Kettle', '1.5L with stainless matte steel cylindrical body', 'Electronics', 159, 1, '7/10', 'Panasonic 1.2L Kettle', '5.2554533', '100.4741933', 'Pulau Pinang', 'Simpang Ampat', '2023-07-04 17:28:38.068603', 'New'),
(12, 2, 'Harry Potter', 'Full Set, total has seven books', 'Books & Media', 169.9, 1, 'New', 'Other Collection', '2.26644', '102.3022717', 'Malacca', 'Ayer Keroh', '2023-07-04 20:23:30.480830', 'New'),
(13, 2, 'Prada Sunglasses', 'PR 01OS, black in color', 'Fashion & Accessories', 960, 1, '9/10', 'PR 16WS Sunglasses', '3.97434', '102.4380567', 'Pahang', 'Jerantut', '2023-07-05 15:06:56.777085', 'New'),
(14, 2, 'Gucci Bag', 'Ring shoulder bag, black in color', 'Fashion & Accessories', 3500, 1, '9/10', 'Mini Model Chain Bag', '6.3499983', '99.7999983', 'Kedah', 'Langkawi', '2023-07-05 15:12:51.698524', 'New'),
(15, 2, 'Beauty Device', 'Ulike X Jmoon', 'Beauty & Personal Care', 1529, 2, '8/10', 'Foreo Facial Toning Device', '3.4239767', '101.7932', 'Pahang', 'Genting Highlands', '2023-07-05 15:15:31.988808', 'New'),
(16, 2, 'Graco Car Seat', 'Safety TurboBooster Backless Booster Car Seat, for children', 'Other', 180, 1, '6/10', 'High Back Car Seat', '4.3914867', '117.9503483', 'Sabah', 'Tawau', '2023-07-05 15:20:38.018978', 'New'),
(17, 2, 'Speaker', 'Good Sound', 'Electronics', 59.9, 1, '8/10', 'Earphone', '4.189535', '100.71115', 'Perak', 'Sitiawan', '2023-07-06 01:09:32.025305', 'New'),
(18, 2, 'Bicycle', 'Expensive, Good quality', 'Automotive', 69.9, 1, '10/10', 'Green color bicycle', '4.7676067', '101.1103683', 'Perak', 'Chemor', '2023-07-06 01:18:32.362301', 'New');

-- --------------------------------------------------------

--
-- Table structure for table `apps_orderdetails`
--

CREATE TABLE `apps_orderdetails` (
  `orderdetail_id` int(5) NOT NULL,
  `order_bill` varchar(8) NOT NULL,
  `item_id` varchar(5) NOT NULL,
  `orderdetail_qty` int(5) NOT NULL,
  `orderdetail_paid` float NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `orderdetail_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `apps_orderdetails`
--

INSERT INTO `apps_orderdetails` (`orderdetail_id`, `order_bill`, `item_id`, `orderdetail_qty`, `orderdetail_paid`, `buyer_id`, `seller_id`, `orderdetail_date`) VALUES
(1, 'boxoxrpe', '4', 1, 79.9, '2', '3', '2023-07-19 10:11:56.918240'),
(2, 'boxoxrpe', '6', 1, 299.9, '2', '3', '2023-07-19 10:11:56.941388'),
(3, 'i5h60cv9', '4', 1, 79.9, '2', '3', '2023-07-19 10:56:17.865321'),
(4, 'f0jho4db', '6', 1, 299.9, '2', '3', '2023-07-19 17:20:32.293086'),
(5, '34573', '4', 1, 79.9, '2', '3', '2023-07-19 22:32:45.231188'),
(6, '34166', '6', 1, 299.9, '2', '3', '2023-07-19 22:36:02.107990'),
(7, '24237', '9', 1, 499.9, '2', '1', '2023-07-19 22:42:56.813786'),
(8, '68847', '11', 1, 159, '2', '1', '2023-07-19 22:43:52.153904'),
(9, '35392', '6', 1, 299.9, '2', '3', '2023-07-19 22:49:52.962572'),
(10, '63360', '6', 1, 299.9, '2', '3', '2023-07-19 22:52:55.168467'),
(11, '43070', '9', 1, 499.9, '2', '1', '2023-07-19 22:54:29.403737'),
(12, '22308', '9', 1, 499.9, '3', '1', '2023-07-20 02:07:00.194178'),
(13, '76818', '8', 1, 2100, '3', '2', '2023-07-20 02:14:29.974137'),
(14, '15724', '4', 1, 79.9, '2', '3', '2023-07-20 18:44:36.908098'),
(15, '77984', '4', 1, 79.9, '2', '3', '2023-07-20 20:26:42.770867'),
(16, '67141', '6', 1, 299.9, '2', '3', '2023-07-20 20:27:19.388456'),
(17, '63556', '6', 1, 299.9, '2', '3', '2023-07-20 20:27:51.435840'),
(18, '97948', '4', 1, 79.9, '2', '3', '2023-07-20 20:38:47.750519'),
(19, '17165', '9', 1, 499.9, '2', '1', '2023-07-20 20:49:15.458035'),
(20, '90756', '6', 1, 299.9, '2', '3', '2023-07-20 20:56:43.204166'),
(21, '47704', '4', 1, 79.9, '2', '3', '2023-07-20 20:57:12.165100'),
(22, '83268', '4', 2, 159.8, '2', '3', '2023-07-20 22:31:36.602913'),
(23, '83268', '6', 1, 299.9, '2', '3', '2023-07-20 22:31:36.608151');

-- --------------------------------------------------------

--
-- Table structure for table `apps_orders`
--

CREATE TABLE `apps_orders` (
  `order_id` int(5) NOT NULL,
  `order_bill` varchar(8) NOT NULL,
  `order_paid` float NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `order_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `order_status` varchar(20) NOT NULL,
  `order_lat` varchar(12) NOT NULL,
  `order_lng` varchar(12) NOT NULL,
  `order_state` varchar(50) NOT NULL,
  `order_locality` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `apps_orders`
--

INSERT INTO `apps_orders` (`order_id`, `order_bill`, `order_paid`, `buyer_id`, `seller_id`, `order_date`, `order_status`, `order_lat`, `order_lng`, `order_state`, `order_locality`) VALUES
(1, '34573', 79.9, '2', '3', '2023-07-19 22:32:45.227772', 'Completed', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(2, '34166', 299.9, '2', '3', '2023-07-19 22:36:02.103974', 'Completed', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(3, '24237', 499.9, '2', '1', '2023-07-19 22:42:56.809712', 'New', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(4, '68847', 159, '2', '1', '2023-07-19 22:43:52.148937', 'New', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(5, '35392', 299.9, '2', '3', '2023-07-19 22:49:52.958802', 'Completed', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(6, '63360', 299.9, '2', '3', '2023-07-19 22:52:55.164755', 'Completed', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(7, '43070', 499.9, '2', '1', '2023-07-19 22:54:29.396928', 'New', '', '', '', ''),
(11, '22308', 499.9, '3', '1', '2023-07-20 02:07:00.180080', 'Completed', '4.189535', '100.71115', 'Perak', 'Sitiawan'),
(12, '76818', 2100, '3', '2', '2023-07-20 02:14:29.971760', 'Completed', '4.189535', '100.71115', 'Perak', 'Sitiawan'),
(13, '15724', 79.9, '2', '3', '2023-07-20 18:44:36.906040', 'Completed', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(14, '77984', 79.9, '2', '3', '2023-07-20 20:26:42.761372', 'Completed', '', '', '', ''),
(15, '67141', 299.9, '2', '3', '2023-07-20 20:27:19.385111', 'Completed', '', '', '', ''),
(16, '63556', 299.9, '2', '3', '2023-07-20 20:27:51.432726', 'Completed', '', '', '', ''),
(17, '97948', 79.9, '2', '3', '2023-07-20 20:38:47.747586', 'Completed', '', '', '', ''),
(18, '17165', 499.9, '2', '1', '2023-07-20 20:49:15.455072', 'New', '', '', '', ''),
(19, '90756', 299.9, '2', '3', '2023-07-20 20:56:43.199456', 'Completed', '', '', '', ''),
(20, '47704', 79.9, '2', '3', '2023-07-20 20:57:12.162229', 'Completed', '4.7676067', '101.1103683', 'Perak', 'Chemor'),
(21, '83268', 459.7, '2', '3', '2023-07-20 22:31:36.606960', 'New', '4.189535', '100.71115', 'Perak', 'Sitiawan');

-- --------------------------------------------------------

--
-- Table structure for table `apps_user`
--

CREATE TABLE `apps_user` (
  `user_id` int(5) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `user_pass` varchar(40) NOT NULL,
  `user_otp` varchar(5) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `apps_user`
--

INSERT INTO `apps_user` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_pass`, `user_otp`, `user_datereg`) VALUES
(1, 'ch3ngw3n0331@gmail.com', 'chengwenn', '0182129139', '1916b1b5e0a7f751366b0f136d7884cd7de07777', '61543', '0000-00-00 00:00:00.000000'),
(2, 'kaizhi@gmail.com', 'Kai Zhi', '0174563278', '41e017dd6114f685d37a46af5debac2bc09d3444', '51201', '0000-00-00 00:00:00.000000'),
(3, 'huiyi@gmail.com', 'huiyiooi', '0145214590', '331c121e56f555aa4c8e4eabb3af4b1985f8cbb8', '36274', '2023-05-22 13:15:11.827998');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apps_carts`
--
ALTER TABLE `apps_carts`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `apps_items`
--
ALTER TABLE `apps_items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `apps_orderdetails`
--
ALTER TABLE `apps_orderdetails`
  ADD PRIMARY KEY (`orderdetail_id`);

--
-- Indexes for table `apps_orders`
--
ALTER TABLE `apps_orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `apps_user`
--
ALTER TABLE `apps_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apps_carts`
--
ALTER TABLE `apps_carts`
  MODIFY `cart_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `apps_items`
--
ALTER TABLE `apps_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `apps_orderdetails`
--
ALTER TABLE `apps_orderdetails`
  MODIFY `orderdetail_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `apps_orders`
--
ALTER TABLE `apps_orders`
  MODIFY `order_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `apps_user`
--
ALTER TABLE `apps_user`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
