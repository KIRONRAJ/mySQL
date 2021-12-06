-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2021 at 08:00 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lab2`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE `agent` (
  `agent_id` int(15) NOT NULL,
  `agent_username` varchar(20) NOT NULL,
  `agent_password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `agent_work`
--

CREATE TABLE `agent_work` (
  `agent_work_id` int(15) NOT NULL,
  `agent_id` int(15) NOT NULL,
  `employee_id` int(10) NOT NULL,
  `agent_work_status` enum('Assigned','Closed','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `compliant`
--

CREATE TABLE `compliant` (
  `compliant_id` int(15) NOT NULL,
  `user_id` int(10) NOT NULL,
  `compliant_date` datetime NOT NULL,
  `compliant` text NOT NULL,
  `compliant_status` enum('Assigned','Closed','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(15) NOT NULL,
  `employee_username` varchar(20) NOT NULL,
  `employee_password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `employee_work`
--

CREATE TABLE `employee_work` (
  `employee_work_id` int(10) NOT NULL,
  `compliant_id` int(15) NOT NULL,
  `employee_id` int(15) NOT NULL,
  `compliant_status` enum('inprogress','stuck','completed','') NOT NULL,
  `compliant_comments` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `email_id` varchar(25) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent`
--
ALTER TABLE `agent`
  ADD PRIMARY KEY (`agent_id`);

--
-- Indexes for table `agent_work`
--
ALTER TABLE `agent_work`
  ADD PRIMARY KEY (`agent_work_id`),
  ADD KEY `agentid` (`agent_id`),
  ADD KEY `agent_to_employee` (`employee_id`);

--
-- Indexes for table `compliant`
--
ALTER TABLE `compliant`
  ADD PRIMARY KEY (`compliant_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `employee_work`
--
ALTER TABLE `employee_work`
  ADD PRIMARY KEY (`employee_work_id`),
  ADD KEY `employeeid` (`employee_id`),
  ADD KEY `compliantid` (`compliant_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agent`
--
ALTER TABLE `agent`
  MODIFY `agent_id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `agent_work`
--
ALTER TABLE `agent_work`
  MODIFY `agent_work_id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `compliant`
--
ALTER TABLE `compliant`
  MODIFY `compliant_id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_work`
--
ALTER TABLE `employee_work`
  MODIFY `employee_work_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agent_work`
--
ALTER TABLE `agent_work`
  ADD CONSTRAINT `agent_to_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  ADD CONSTRAINT `agentid` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`);

--
-- Constraints for table `compliant`
--
ALTER TABLE `compliant`
  ADD CONSTRAINT `compliant_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `employee_work`
--
ALTER TABLE `employee_work`
  ADD CONSTRAINT `compliantid` FOREIGN KEY (`compliant_id`) REFERENCES `compliant` (`compliant_id`),
  ADD CONSTRAINT `employeeid` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
