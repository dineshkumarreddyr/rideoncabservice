-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 22, 2015 at 03:20 AM
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
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rocbookingdatetime` datetime NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `rocbookingstatus` varchar(45) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocbookinginfo`
--

INSERT INTO `rocbookinginfo` (`rocbookinginfoid`, `roctransactionid`, `rocservicetype`, `rocservicename`, `rocservicechargeperkm`, `rocservicekm`, `rocservicestimatedrs`, `rocbookingfromlocation`, `rocbookingtolocation`, `rocserviceclass`, `rocuserid`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocbookingdatetime`, `rocvendorid`, `rocbookingstatus`) VALUES
(1, '1', 'OLA', 'OLA CAB', 10, 2, 5, 'hitech', 'jublee', '1A', 1, 'Admin', 'Admin', '2015-06-15 00:32:47', '2015-06-15 00:32:47', '0000-00-00 00:00:00', 1, 'Success'),
(3, '2', 'OLA', 'OLA CAB', 10, 2, 5, 'hitech', 'jublee', '1A', 1, 'Admin', 'Admin', '2015-06-15 00:33:54', '2015-06-15 00:33:54', '0000-00-00 00:00:00', 1, 'Success'),
(30, '', 'MINI', 'OLA', 10, 2, 150, 'Hitech', 'Jublee', 'MINI', 1, 'Admin', 'Admin', '2015-06-17 11:58:36', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'book');

-- --------------------------------------------------------

--
-- Table structure for table `roccabservices`
--

CREATE TABLE IF NOT EXISTS `roccabservices` (
`roccabservicesid` int(11) NOT NULL,
  `roccabservices` varchar(200) NOT NULL,
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NULL DEFAULT NULL,
  `createduser` varchar(45) DEFAULT NULL,
  `modifieduser` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
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
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rocuseraddress1` mediumtext,
  `rocusersaddress2` mediumtext,
  `rocuserpincode` int(11) DEFAULT NULL,
  `rocuserpassword` mediumtext
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocusers`
--

INSERT INTO `rocusers` (`rocuserid`, `rocuserfirstname`, `rocuserlastname`, `rocuseremail`, `rocusercity`, `rocuserstate`, `rocusermobile`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocuseraddress1`, `rocusersaddress2`, `rocuserpincode`, `rocuserpassword`) VALUES
(1, 'uday', 'kumar', 'udayakumarswamy@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 19:56:10', '2015-06-14 19:56:10', NULL, NULL, NULL, '12345'),
(2, 'uday', 'kumar', 'udayakumarswamy@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 20:09:04', '2015-06-14 20:09:04', NULL, NULL, NULL, '12345'),
(3, 'uday', 'kumar', 'udayakumarswamy1@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 20:12:31', '2015-06-14 20:12:31', NULL, NULL, NULL, '12345'),
(4, 'uday', 'kumar', 'udayakumarswamy2@gmail.com', 'Hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-14 20:28:51', '2015-06-14 20:28:51', NULL, NULL, NULL, '12345'),
(5, 'uday', 'kumar', 'udayakumarswamy3@gmail.com', 'hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-17 09:50:23', '0000-00-00 00:00:00', NULL, NULL, NULL, '123456'),
(6, 'uday', 'kumar', 'udayakumarswamy4@gmail.com', 'hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-17 10:27:43', '0000-00-00 00:00:00', NULL, NULL, NULL, '123456'),
(7, 'uday', 'kumar', 'udayakumarswamy5@gmail.com', 'hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-17 10:30:35', '0000-00-00 00:00:00', NULL, NULL, NULL, '123456'),
(8, 'uday', 'kumar', 'udayakumarswamy6@gmail.com', 'hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-17 10:32:34', '0000-00-00 00:00:00', NULL, NULL, NULL, '123456'),
(9, 'uday', 'kumar', 'udayakumarswamy7@gmail.com', 'hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-17 10:43:28', '0000-00-00 00:00:00', NULL, NULL, NULL, '123456');

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorcabmodel`
--

CREATE TABLE IF NOT EXISTS `rocvendorcabmodel` (
`rocvendorcabmodelid` int(11) NOT NULL,
  `rocvendorcabtype` varchar(100) NOT NULL,
  `rocvendorcabmodel` varchar(100) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NULL DEFAULT NULL,
  `createduser` varchar(100) DEFAULT NULL,
  `modifieduser` varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocvendorcabmodel`
--

INSERT INTO `rocvendorcabmodel` (`rocvendorcabmodelid`, `rocvendorcabtype`, `rocvendorcabmodel`, `rocvendorid`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(13, 'MINI', '12345', 1, '2015-06-21 07:43:12', NULL, NULL, NULL),
(14, 'MINI', '12345', 1, '2015-06-21 07:43:12', NULL, NULL, NULL),
(15, 'MINI', '12345', 1, '2015-06-21 07:44:54', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorcharges`
--

CREATE TABLE IF NOT EXISTS `rocvendorcharges` (
`rocvendorchargeid` int(11) NOT NULL,
  `roccabtype` varchar(200) NOT NULL,
  `roccabmodelid` varchar(200) NOT NULL,
  `rocchargeperkm` int(11) NOT NULL,
  `roccabservicesid` int(11) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocvendorcharges`
--

INSERT INTO `rocvendorcharges` (`rocvendorchargeid`, `roccabtype`, `roccabmodelid`, `rocchargeperkm`, `roccabservicesid`, `rocvendorid`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(1, 'MINI', 'indica', 10, 0, 1, '2015-06-14 23:17:54', '2015-06-14 23:17:54', 'Admin', 'Admin'),
(2, '', '12345', 100, 12, 1, '2015-06-21 09:41:53', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(3, '', '123', 150, 13, 1, '2015-06-21 09:41:53', '0000-00-00 00:00:00', 'Admin', 'Admin');

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
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `rocvendorrating` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocvendors`
--

INSERT INTO `rocvendors` (`rocvendorid`, `rocvendorname`, `rocvendoraddress`, `rocvendoremail`, `rocvendornumber1`, `rocvendornumber2`, `rocvendorusername`, `rocvendorpassword`, `rocvendorcontactperson`, `rocvendorlogo`, `createddate`, `modifieddate`, `createduser`, `modifieduser`, `rocvendorrating`) VALUES
(1, 'Aneel', 'vanalasti', 'annel@gmail.com', '7569508596', '7569508597', 'aneel@gmail.com', '12345', 'Aneel1', 'logo', '2015-06-14 23:17:21', '2015-06-14 23:17:21', 'Admin', 'Admin', 4),
(2, 'ravi', 'hyd', 'ravi@gmail.com', '7569508595', '7569508596', 'ravi@gmail.com', '12345', 'uday', 'logo', '2015-06-15 22:05:43', '2015-06-15 22:05:43', 'Admin', 'Admin', NULL),
(3, 'Name required', 'Address required', 'Email required', 'Number1 required', 'Number2 required', 'Username required', 'Password required', 'Contact person required', 'Logo required', '2015-06-17 12:47:19', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(4, 'Name required', 'Address required', 'Email required', 'Number1 required', 'Number2 required', 'Username required', 'Password required', 'Contact person required', 'Logo required', '2015-06-17 12:47:31', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(5, 'Name required', 'Address required', 'Email required', 'Number1 required', 'Number2 required', 'Username required', 'Password required', 'Contact person required', 'Logo required', '2015-06-17 12:47:54', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(6, 'Aneel', 'vanalasti', 'aneel@gmail.com', 'Number1 required', 'Number2 required', 'Username required', 'Password required', 'Contact person required', 'Logo required', '2015-06-17 12:49:46', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(7, 'Aneel', 'vanalasti', 'aneel1@gmail.com', 'Number1 required', 'Number2 required', 'Username required', 'Password required', 'Contact person required', 'Logo required', '2015-06-17 12:51:43', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorterms`
--

CREATE TABLE IF NOT EXISTS `rocvendorterms` (
`rocvendortermsid` int(11) NOT NULL,
  `rocvendorterms` text NOT NULL,
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NULL DEFAULT NULL,
  `createduser` varchar(45) DEFAULT NULL,
  `modifieduser` varchar(45) DEFAULT NULL,
  `rocvendorid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocvendorterms`
--

INSERT INTO `rocvendorterms` (`rocvendortermsid`, `rocvendorterms`, `createddate`, `modifieddate`, `createduser`, `modifieduser`, `rocvendorid`) VALUES
(1, 'content', '2015-06-21 10:02:34', NULL, NULL, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rocbookinginfo`
--
ALTER TABLE `rocbookinginfo`
 ADD PRIMARY KEY (`rocbookinginfoid`), ADD UNIQUE KEY `roctransactionid_UNIQUE` (`roctransactionid`), ADD KEY `bookinginfo_idx` (`rocuserid`), ADD KEY `vendorinfo_idx` (`rocvendorid`);

--
-- Indexes for table `roccabservices`
--
ALTER TABLE `roccabservices`
 ADD PRIMARY KEY (`roccabservicesid`);

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
-- Indexes for table `rocvendorcabmodel`
--
ALTER TABLE `rocvendorcabmodel`
 ADD PRIMARY KEY (`rocvendorcabmodelid`), ADD KEY `rocvendorid` (`rocvendorid`);

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
-- Indexes for table `rocvendorterms`
--
ALTER TABLE `rocvendorterms`
 ADD PRIMARY KEY (`rocvendortermsid`), ADD UNIQUE KEY `rocvendorid` (`rocvendorid`), ADD KEY `vendorid_terms_idx` (`rocvendorid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rocbookinginfo`
--
ALTER TABLE `rocbookinginfo`
MODIFY `rocbookinginfoid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `roccabservices`
--
ALTER TABLE `roccabservices`
MODIFY `roccabservicesid` int(11) NOT NULL AUTO_INCREMENT;
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
MODIFY `rocuserid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `rocvendorcabmodel`
--
ALTER TABLE `rocvendorcabmodel`
MODIFY `rocvendorcabmodelid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `rocvendorcharges`
--
ALTER TABLE `rocvendorcharges`
MODIFY `rocvendorchargeid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `rocvendors`
--
ALTER TABLE `rocvendors`
MODIFY `rocvendorid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `rocvendorterms`
--
ALTER TABLE `rocvendorterms`
MODIFY `rocvendortermsid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
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
-- Constraints for table `rocvendorcabmodel`
--
ALTER TABLE `rocvendorcabmodel`
ADD CONSTRAINT `rocvendorid` FOREIGN KEY (`rocvendorid`) REFERENCES `rocvendors` (`rocvendorid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rocvendorcharges`
--
ALTER TABLE `rocvendorcharges`
ADD CONSTRAINT `vendorid` FOREIGN KEY (`rocvendorid`) REFERENCES `rocvendors` (`rocvendorid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rocvendorterms`
--
ALTER TABLE `rocvendorterms`
ADD CONSTRAINT `vendorid_terms` FOREIGN KEY (`rocvendorid`) REFERENCES `rocvendors` (`rocvendorid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
