-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2021 at 1:38 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airline_reservation`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`Harry`@`localhost` PROCEDURE `GetFlightStatistics` (IN `j_date` DATE)  BEGIN
 select flight_no,departure_date,IFNULL(no_of_passengers, 0) as no_of_passengers,total_capacity from (
select f.flight_no,f.departure_date,sum(t.no_of_passengers) as no_of_passengers,j.total_capacity 
from flight_details f left join ticket_details t 
on t.booking_status='CONFIRMED' 
and t.flight_no=f.flight_no 
and f.departure_date=t.journey_date 
inner join jet_details j on j.jet_id=f.jet_id
group by flight_no,journey_date) k where departure_date=j_date;
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` varchar(20) NOT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  `staff_id` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `pwd`, `staff_id`, `name`, `email`) VALUES
('admin', 'passpass', '101', 'Harry Roshan', 'harryroshan1997@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` varchar(20) NOT NULL,
  `pwd` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `address` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `pwd`, `name`, `email`, `phone_no`, `address`) VALUES
('bob', 'saybob', 'Bob M', 'bob98@gmail.com', '206-216-5859', '82 Lookout St'),
('charles', 'charles_pass', 'Charles', 'charles@gmail.com', '863-272-9477', '89 NW. Ridge Street Lemont'),
('harryroshan', 'passpasshello', 'Harry Roshan', 'harryroshan1997@gmail.com', '209-212-0061', '287 Livingston Ave'),
('jay198', 'bookit', 'Jay', 'jay@gmail.com', '423-324-3478', '900 Main St NW'),
('nick008', 'nick', 'Nick M', 'nick@gmail.com', '239-209-6871', '427 North Miles Lane Crown Point'),
('Tim', 'tim123', 'Tim', 'tim12@gmail.com', '210-205-8362', '228 Colonial Street'),
('user', 'user123', 'Steve W', 'steave@hotmail.com', '318-986-6060', '355 Manchester Ave');
-- --------------------------------------------------------

--
-- Table structure for table `flight_details`
--

CREATE TABLE `flight_details` (
  `flight_no` varchar(10) NOT NULL,
  `from_city` varchar(20) DEFAULT NULL,
  `to_city` varchar(20) DEFAULT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `seats_economy` int(5) DEFAULT NULL,
  `seats_business` int(5) DEFAULT NULL,
  `price_economy` int(10) DEFAULT NULL,
  `price_business` int(10) DEFAULT NULL,
  `jet_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `flight_details`
--

INSERT INTO `flight_details` (`flight_no`, `from_city`, `to_city`, `departure_date`, `arrival_date`, `departure_time`, `arrival_time`, `seats_economy`, `seats_business`, `price_economy`, `price_business`, `jet_id`) VALUES
('AA101', 'Chattanooga', 'Los Angeles', '2021-06-03', '2021-06-03', '21:00:00', '01:00:00', 195, 95, 500, 750, '10001'),
('AA101', 'Chattanooga', 'Los Angeles', '2021-06-05', '2021-06-05', '10:30:56', '12:55:56', 150, 45, 470, 725, '10002'),
('AA102', 'Chattanooga', 'Atlanta', '2021-06-02', '2021-06-02', '10:00:56', '10:50:05', 100, 20, 250, 450, '10007'),
('AA102', 'Chattanooga', 'San Diego', '2021-06-04', '2021-06-04', '10:00:00', '12:00:00', 199, 75, 525, 750, '10004'),
('AA103', 'Chattanooga', 'Atlanta', '2021-06-02', '2021-06-02', '06:30:00', '07:15:10', 250, 55, 200, 375, '10007'),
('AA103', 'Chattanooga', 'Orlando', '2021-06-06', '2021-06-06', '17:00:00', '17:45:00', 150, 75, 1200, 1500, '10004'),
('AA104', 'Chattanooga', 'Washington D.C.', '2021-06-10', '2021-06-10', '11:16:58', '13:32:30', 112, 35, 395, 600, '10003'),
('AA104', 'Chattanooga', 'Dallas', '2021-06-12', '2021-06-12', '09:00:00', '09:17:00', 37, 4, 450, 700, '10003'),
('AA105', 'Chattanooga', 'Boston', '2021-06-12', '2021-06-12', '02:30:14', '07:45:40', 118, 31, 435, 685, '10003'),
('AA105', 'Chattanooga', 'Boston', '2021-06-13', '2021-06-13', '01:20:30', '06:30:20', 187, 42, 445, 700, '10003'),
('AA106', 'Chattanooga', 'Miami', '2021-06-03', '2021-06-03', '01:30:20', '05:45:30', 140, 58, 250, 400, '10003'),
('AA106', 'Chattanooga', 'NewYork', '2021-06-05', '2021-06-05', '07:10:45', '11:15:50', 133, 45, 250, 400, '10004'),
('AA106', 'Chattanooga', 'Detroit', '2021-06-08', '2021-06-08', '13:00:00', '14:00:00', 150, 75, 500, 750, '10004'),
('AA107', 'Chattanooga', 'Chicago', '2021-06-01', '2021-06-01', '01:10:15', '05:30:45', 98, 15, 700, 950, '10003');

-- --------------------------------------------------------

--
-- Table structure for table `frequent_flier_details`
--

CREATE TABLE `frequent_flier_details` (
  `frequent_flier_no` varchar(20) NOT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `mileage` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `frequent_flier_details`
--

INSERT INTO `frequent_flier_details` (`frequent_flier_no`, `customer_id`, `mileage`) VALUES
('10001000', 'user', 375),
('20002000', 'harryroshan', 150);

-- --------------------------------------------------------

--
-- Table structure for table `jet_details`
--

CREATE TABLE `jet_details` (
  `jet_id` varchar(10) NOT NULL,
  `jet_type` varchar(20) DEFAULT NULL,
  `total_capacity` int(5) DEFAULT NULL,
  `active` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jet_details`
--

INSERT INTO `jet_details` (`jet_id`, `jet_type`, `total_capacity`, `active`) VALUES
('10001', 'Delta', 300, 'Yes'),
('10002', 'American Airlines', 275, 'Yes'),
('10003', 'Southwest Airlines', 315, 'Yes'),
('10004', 'United Airlines', 225, 'Yes'),
('10007', 'Test_Model', 250, 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `passenger_id` int(10) NOT NULL,
  `pnr` varchar(15) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `gender` varchar(8) DEFAULT NULL,
  `meal_choice` varchar(5) DEFAULT NULL,
  `frequent_flier_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`passenger_id`, `pnr`, `name`, `age`, `gender`, `meal_choice`, `frequent_flier_no`) VALUES
(1, '1655313', 'passsenger1', 30, 'male', 'yes', NULL),
(1, '1669050', 'Harry Roshan', 20, 'male', 'yes', '20002000'),
(1, '2369143', 'blah', 20, 'male', 'yes', NULL),
(1, '3027167', 'aadith_name', 10, 'male', 'yes', NULL),
(1, '3191998', 'passsenger1', 30, 'other', 'yes', NULL),
(1, '3773951', 'harry', 51, 'male', 'yes', NULL),
(1, '4797983', 'pass1', 34, 'male', 'yes', NULL),
(1, '5421865', 'pass1', 10, 'male', 'yes', NULL),
(1, '6980157', 'roshan', 20, 'male', 'yes', NULL),
(1, '8503285', 'aadith_name', 10, 'male', 'yes', '10001000'),
(2, '1655313', 'passsenger2', 32, 'female', 'yes', NULL),
(2, '1669050', 'berti harry', 45, 'female', 'yes', NULL),
(2, '2369143', 'blah', 51, 'male', 'yes', NULL),
(2, '3027167', 'roshan', 20, 'male', 'yes', NULL),
(2, '3773951', 'berti', 42, 'female', 'yes', NULL),
(2, '4797983', 'Harry Roshan', 20, 'male', 'yes', '20002000'),
(2, '5421865', 'pass2', 20, 'female', 'yes', NULL),
(2, '6980157', 'aadith', 9, 'male', 'yes', NULL),
(2, '8503285', 'roshan_name', 20, 'male', 'yes', NULL),
(3, '1669050', 'aadith_name', 10, 'male', 'yes', NULL),
(3, '2369143', 'blah', 10, 'male', 'yes', NULL),
(3, '3773951', 'aadith', 11, 'male', 'yes', '10001000'),
(3, '4797983', 'aadith_name', 10, 'male', 'yes', '10001000'),
(3, '5421865', 'pass3', 30, 'male', 'yes', NULL),
(4, '2369143', 'blah', 42, 'female', 'yes', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `payment_id` varchar(20) NOT NULL,
  `pnr` varchar(15) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_amount` int(6) DEFAULT NULL,
  `payment_mode` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`payment_id`, `pnr`, `payment_date`, `payment_amount`, `payment_mode`) VALUES
('120000248', '4797983', '2021-02-14', 4200, 'credit card'),
('142539461', '3773951', '2021-02-14', 4050, 'credit card'),
('165125569', '8503285', '2021-02-14', 7500, 'net banking'),
('203785497', '1655313', '2021-02-14', 11700, 'debit card'),
('467972527', '2369143', '2021-02-14', 33400, 'debit card'),
('557778944', '6980157', '2021-02-14', 11700, 'credit card'),
('620041544', '1669050', '2021-02-14', 4800, 'debit card'),
('665360715', '5421865', '2021-02-14', 15750, 'net banking'),
('862686553', '3027167', '2021-02-14', 10700, 'debit card'),
('965523027', '3191998', '2021-02-14', 5750, 'debit card');

--
-- Triggers `payment_details`
--
DELIMITER $$
CREATE TRIGGER `update_ticket_after_payment` AFTER INSERT ON `payment_details` FOR EACH ROW UPDATE ticket_details
     SET booking_status='CONFIRMED', payment_id= NEW.payment_id
   WHERE pnr = NEW.pnr
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_details`
--

CREATE TABLE `ticket_details` (
  `pnr` varchar(15) NOT NULL,
  `date_of_reservation` date DEFAULT NULL,
  `flight_no` varchar(10) DEFAULT NULL,
  `journey_date` date DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  `booking_status` varchar(20) DEFAULT NULL,
  `no_of_passengers` int(5) DEFAULT NULL,
  `lounge_access` varchar(5) DEFAULT NULL,
  `priority_checkin` varchar(5) DEFAULT NULL,
  `insurance` varchar(5) DEFAULT NULL,
  `payment_id` varchar(20) DEFAULT NULL,
  `customer_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ticket_details`
--

INSERT INTO `ticket_details` (`pnr`, `date_of_reservation`, `flight_no`, `journey_date`, `class`, `booking_status`, `no_of_passengers`, `lounge_access`, `priority_checkin`, `insurance`, `payment_id`, `customer_id`) VALUES
('1655313', '2021-02-14', 'AA101', '2021-02-14', 'economy', 'CANCELED', 2, 'yes', 'yes', 'yes', '203785497', 'user'),
('1669050', '2021-02-14', 'AA104', '2021-02-17', 'business', 'CONFIRMED', 3, 'yes', 'yes', 'yes', '620041544', 'harryroshan'),
('2369143', '2021-02-14', 'AA101', '2021-02-14', 'business', 'CONFIRMED', 4, 'yes', 'yes', 'yes', '467972527', 'blah'),
('3027167', '2021-02-14', 'AA101', '2021-02-14', 'economy', 'CONFIRMED', 2, 'no', 'no', 'yes', '862686553', 'user'),
('3191998', '2021-02-14', 'AA101', '2021-02-14', 'economy', 'CANCELED', 1, 'yes', 'yes', 'no', '965523027', 'user'),
('3773951', '2021-02-14', 'AA104', '2021-02-17', 'economy', 'CONFIRMED', 3, 'yes', 'yes', 'yes', '142539461', 'user'),
('4797983', '2021-02-14', 'AA104', '2021-02-17', 'business', 'CONFIRMED', 3, 'yes', 'no', 'yes', '120000248', 'harryroshan'),
('5421865', '2021-02-14', 'AA101', '2021-02-14', 'economy', 'CONFIRMED', 3, 'no', 'no', 'no', '665360715', 'harryroshan'),
('6980157', '2021-02-14', 'AA101', '2021-02-14', 'economy', 'CANCELED', 2, 'yes', 'yes', 'yes', '557778944', 'user'),
('8503285', '2021-02-14', 'AA102', '2021-02-15', 'business', 'CONFIRMED', 2, 'yes', 'yes', 'no', '165125569', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `flight_details`
--
ALTER TABLE `flight_details`
  ADD PRIMARY KEY (`flight_no`,`departure_date`),
  ADD KEY `jet_id` (`jet_id`);

--
-- Indexes for table `frequent_flier_details`
--
ALTER TABLE `frequent_flier_details`
  ADD PRIMARY KEY (`frequent_flier_no`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `jet_details`
--
ALTER TABLE `jet_details`
  ADD PRIMARY KEY (`jet_id`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`passenger_id`,`pnr`),
  ADD KEY `pnr` (`pnr`),
  ADD KEY `frequent_flier_no` (`frequent_flier_no`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `pnr` (`pnr`);

--
-- Indexes for table `ticket_details`
--
ALTER TABLE `ticket_details`
  ADD PRIMARY KEY (`pnr`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `journey_date` (`journey_date`),
  ADD KEY `flight_no` (`flight_no`),
  ADD KEY `flight_no_2` (`flight_no`,`journey_date`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flight_details`
--
ALTER TABLE `flight_details`
  ADD CONSTRAINT `flight_details_ibfk_1` FOREIGN KEY (`jet_id`) REFERENCES `jet_details` (`jet_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `frequent_flier_details`
--
ALTER TABLE `frequent_flier_details`
  ADD CONSTRAINT `frequent_flier_details_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `passengers`
--
ALTER TABLE `passengers`
  ADD CONSTRAINT `passengers_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket_details` (`pnr`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `passengers_ibfk_2` FOREIGN KEY (`frequent_flier_no`) REFERENCES `frequent_flier_details` (`frequent_flier_no`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD CONSTRAINT `payment_details_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket_details` (`pnr`) ON UPDATE CASCADE;

--
-- Constraints for table `ticket_details`
--
ALTER TABLE `ticket_details`
  ADD CONSTRAINT `ticket_details_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_details_ibfk_3` FOREIGN KEY (`flight_no`,`journey_date`) REFERENCES `flight_details` (`flight_no`, `departure_date`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
