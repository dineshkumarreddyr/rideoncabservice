-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2015 at 07:01 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rideoncab`
--

-- --------------------------------------------------------

--
-- Table structure for table `rocbookinginfo`
--

CREATE TABLE IF NOT EXISTS `rocbookinginfo` (
`rocbookinginfoid` int(11) NOT NULL,
  `roctransactionid` varchar(100) NOT NULL,
  `rocservicetype` varchar(100) NOT NULL,
  `rocservicename` varchar(200) NOT NULL,
  `rocservicechargeperkm` int(11) DEFAULT NULL,
  `rocservicekm` int(11) DEFAULT NULL,
  `rocservicestimatedrs` int(11) DEFAULT NULL,
  `rocbookingfromlocation` mediumtext,
  `rocbookingtolocation` mediumtext,
  `rocserviceclass` varchar(100) NOT NULL,
  `rocuserid` int(11) NOT NULL,
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `createddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `rocbookingdatetime` datetime NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `rocbookingstatus` varchar(45) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocbookinginfo`
--

INSERT INTO `rocbookinginfo` (`rocbookinginfoid`, `roctransactionid`, `rocservicetype`, `rocservicename`, `rocservicechargeperkm`, `rocservicekm`, `rocservicestimatedrs`, `rocbookingfromlocation`, `rocbookingtolocation`, `rocserviceclass`, `rocuserid`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocbookingdatetime`, `rocvendorid`, `rocbookingstatus`) VALUES
(1, '1', 'OLA', 'OLA CAB', 10, 2, 5, 'hitech', 'jublee', '1A', 1, 'Admin', 'Admin', '2015-06-15 00:32:47', '2015-06-15 00:32:47', '0000-00-00 00:00:00', 1, 'Success'),
(3, '', 'OLA', 'OLA CAB', 10, 2, 5, 'hitech', 'jublee', '1A', 1, 'Admin', 'Admin', '2015-06-15 00:33:54', '2015-06-15 00:33:54', '0000-00-00 00:00:00', 1, 'Success');

-- --------------------------------------------------------

--
-- Table structure for table `roccoupons`
--

CREATE TABLE IF NOT EXISTS `roccoupons` (
`roccouponsid` int(11) NOT NULL,
  `roccouponcode` varchar(200) NOT NULL,
  `roccoupondescription` mediumtext,
  `roccoupontype` varchar(200) NOT NULL,
  `rocexpirydatetime` datetime NOT NULL,
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `createddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` varchar(45) DEFAULT 'Now()'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rocusercoupons`
--

CREATE TABLE IF NOT EXISTS `rocusercoupons` (
`rocusercouponsid` int(11) NOT NULL,
  `rocuserid` int(11) NOT NULL,
  `roccouponsid` int(11) NOT NULL,
  `roccouponstatus` varchar(45) DEFAULT 'active',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `createddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` varchar(45) DEFAULT 'Now()'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rocuserratings`
--

CREATE TABLE IF NOT EXISTS `rocuserratings` (
`rocuserratingid` int(11) NOT NULL,
  `rocuserrating` int(11) NOT NULL DEFAULT '0',
  `rocusercomment` mediumtext,
  `rocvendorid` int(11) NOT NULL,
  `rocbookinginfoid` int(11) NOT NULL,
  `createddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rocusers`
--

CREATE TABLE IF NOT EXISTS `rocusers` (
`rocuserid` int(11) NOT NULL,
  `rocuserfirstname` varchar(200) NOT NULL,
  `rocuserlastname` varchar(200) DEFAULT NULL,
  `rocuseremail` varchar(200) NOT NULL,
  `rocusercity` varchar(100) NOT NULL,
  `rocuserstate` varchar(100) NOT NULL,
  `rocusermobile` varchar(20) DEFAULT NULL,
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `createddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `rocuseraddress1` mediumtext,
  `rocusersaddress2` mediumtext,
  `rocuserpincode` int(11) DEFAULT NULL,
  `rocuserpassword` mediumtext
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocusers`
--

INSERT INTO `rocusers` (`rocuserid`, `rocuserfirstname`, `rocuserlastname`, `rocuseremail`, `rocusercity`, `rocuserstate`, `rocusermobile`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocuseraddress1`, `rocusersaddress2`, `rocuserpincode`, `rocuserpassword`) VALUES
(1, 'uday', 'kumar', 'udayakumarswamy@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 19:56:10', '2015-06-14 19:56:10', NULL, NULL, NULL, '12345'),
(2, 'uday', 'kumar', 'udayakumarswamy@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 20:09:04', '2015-06-14 20:09:04', NULL, NULL, NULL, '12345'),
(3, 'uday', 'kumar', 'udayakumarswamy1@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 20:12:31', '2015-06-14 20:12:31', NULL, NULL, NULL, '12345'),
(4, 'uday', 'kumar', 'udayakumarswamy2@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 20:28:51', '2015-06-14 20:28:51', NULL, NULL, NULL, '12345');

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorcharges`
--

CREATE TABLE IF NOT EXISTS `rocvendorcharges` (
`rocvendorchargeid` int(11) NOT NULL,
  `roccabtype` varchar(200) NOT NULL,
  `roccabmodel` varchar(200) NOT NULL,
  `rocchargeperkm` int(11) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `createddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocvendorcharges`
--

INSERT INTO `rocvendorcharges` (`rocvendorchargeid`, `roccabtype`, `roccabmodel`, `rocchargeperkm`, `rocvendorid`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(1, 'MINI', 'indica', 10, 1, '2015-06-14 23:17:54', '2015-06-14 23:17:54', 'Admin', 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `rocvendors`
--

CREATE TABLE IF NOT EXISTS `rocvendors` (
`rocvendorid` int(11) NOT NULL,
  `rocvendorname` varchar(200) NOT NULL,
  `rocvendoraddress` mediumtext NOT NULL,
  `rocvendoremail` varchar(200) NOT NULL,
  `rocvendornumber1` varchar(20) NOT NULL,
  `rocvendornumber2` varchar(20) DEFAULT NULL,
  `rocvendorusername` varchar(200) NOT NULL,
  `rocvendorpassword` mediumtext NOT NULL,
  `rocvendorcontactperson` varchar(200) NOT NULL,
  `rocvendorlogo` mediumtext,
  `createddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` datetime DEFAULT CURRENT_TIMESTAMP,
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `rocvendorrating` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocvendors`
--

INSERT INTO `rocvendors` (`rocvendorid`, `rocvendorname`, `rocvendoraddress`, `rocvendoremail`, `rocvendornumber1`, `rocvendornumber2`, `rocvendorusername`, `rocvendorpassword`, `rocvendorcontactperson`, `rocvendorlogo`, `createddate`, `modifieddate`, `createduser`, `modifieduser`, `rocvendorrating`) VALUES
(1, 'Aneel', 'vanalasti', 'annel@gmail.com', '7569508596', '7569508597', 'aneel@gmail.com', '12345', 'Aneel1', 'logo', '2015-06-14 23:17:21', '2015-06-14 23:17:21', 'Admin', 'Admin', 4),
(2, 'ravi', 'hyd', 'ravi@gmail.com', '7569508595', '7569508596', 'ravi@gmail.com', '12345', 'uday', 'logo', '2015-06-15 22:05:43', '2015-06-15 22:05:43', 'Admin', 'Admin', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rocbookinginfo`
--
ALTER TABLE `rocbookinginfo`
 ADD PRIMARY KEY (`rocbookinginfoid`), ADD UNIQUE KEY `roctransactionid_UNIQUE` (`roctransactionid`), ADD KEY `bookinginfo_idx` (`rocuserid`), ADD KEY `vendorinfo_idx` (`rocvendorid`);

--
-- Indexes for table `roccoupons`
--
ALTER TABLE `roccoupons`
 ADD PRIMARY KEY (`roccouponsid`);

--
-- Indexes for table `rocusercoupons`
--
ALTER TABLE `rocusercoupons`
 ADD PRIMARY KEY (`rocusercouponsid`), ADD UNIQUE KEY `rocusercouponsid_UNIQUE` (`rocusercouponsid`), ADD KEY `couponinfo_idx` (`roccouponsid`), ADD KEY `usercouponsinfo_idx` (`rocuserid`);

--
-- Indexes for table `rocuserratings`
--
ALTER TABLE `rocuserratings`
 ADD PRIMARY KEY (`rocuserratingid`), ADD UNIQUE KEY `rocuserratingid_UNIQUE` (`rocuserratingid`), ADD KEY `ratingvendor_idx` (`rocvendorid`), ADD KEY `ratingbooking_idx` (`rocbookinginfoid`);

--
-- Indexes for table `rocusers`
--
ALTER TABLE `rocusers`
 ADD PRIMARY KEY (`rocuserid`);

--
-- Indexes for table `rocvendorcharges`
--
ALTER TABLE `rocvendorcharges`
 ADD PRIMARY KEY (`rocvendorchargeid`), ADD KEY `vendorid_idx` (`rocvendorid`);

--
-- Indexes for table `rocvendors`
--
ALTER TABLE `rocvendors`
 ADD PRIMARY KEY (`rocvendorid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rocbookinginfo`
--
ALTER TABLE `rocbookinginfo`
MODIFY `rocbookinginfoid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `roccoupons`
--
ALTER TABLE `roccoupons`
MODIFY `roccouponsid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rocusercoupons`
--
ALTER TABLE `rocusercoupons`
MODIFY `rocusercouponsid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rocuserratings`
--
ALTER TABLE `rocuserratings`
MODIFY `rocuserratingid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rocusers`
--
ALTER TABLE `rocusers`
MODIFY `rocuserid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `rocvendorcharges`
--
ALTER TABLE `rocvendorcharges`
MODIFY `rocvendorchargeid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `rocvendors`
--
ALTER TABLE `rocvendors`
MODIFY `rocvendorid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `rocbookinginfo`
--
ALTER TABLE `rocbookinginfo`
ADD CONSTRAINT `bookinginfo` FOREIGN KEY (`rocuserid`) REFERENCES `rocusers` (`rocuserid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `vendorinfo` FOREIGN KEY (`rocvendorid`) REFERENCES `rocvendors` (`rocvendorid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rocusercoupons`
--
ALTER TABLE `rocusercoupons`
ADD CONSTRAINT `couponinfo` FOREIGN KEY (`roccouponsid`) REFERENCES `roccoupons` (`roccouponsid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `usercouponsinfo` FOREIGN KEY (`rocuserid`) REFERENCES `rocusers` (`rocuserid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rocuserratings`
--
ALTER TABLE `rocuserratings`
ADD CONSTRAINT `ratingbooking` FOREIGN KEY (`rocbookinginfoid`) REFERENCES `rocbookinginfo` (`rocbookinginfoid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `ratingvendor` FOREIGN KEY (`rocvendorid`) REFERENCES `rocvendors` (`rocvendorid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rocvendorcharges`
--
ALTER TABLE `rocvendorcharges`
ADD CONSTRAINT `vendorid` FOREIGN KEY (`rocvendorid`) REFERENCES `rocvendors` (`rocvendorid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
