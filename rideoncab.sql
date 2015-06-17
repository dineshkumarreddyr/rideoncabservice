-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 17, 2015 at 12:55 PM
-- Server version: 5.5.37-0ubuntu0.13.10.1
-- PHP Version: 5.5.3-1ubuntu2.6

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
  `rocbookinginfoid` int(11) NOT NULL AUTO_INCREMENT,
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
  `rocbookingstatus` varchar(45) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`rocbookinginfoid`),
  UNIQUE KEY `roctransactionid_UNIQUE` (`roctransactionid`),
  KEY `bookinginfo_idx` (`rocuserid`),
  KEY `vendorinfo_idx` (`rocvendorid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `rocbookinginfo`
--

INSERT INTO `rocbookinginfo` (`rocbookinginfoid`, `roctransactionid`, `rocservicetype`, `rocservicename`, `rocservicechargeperkm`, `rocservicekm`, `rocservicestimatedrs`, `rocbookingfromlocation`, `rocbookingtolocation`, `rocserviceclass`, `rocuserid`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocbookingdatetime`, `rocvendorid`, `rocbookingstatus`) VALUES
(1, '1', 'OLA', 'OLA CAB', 10, 2, 5, 'hitech', 'jublee', '1A', 1, 'Admin', 'Admin', '2015-06-15 00:32:47', '2015-06-15 00:32:47', '0000-00-00 00:00:00', 1, 'Success'),
(3, '2', 'OLA', 'OLA CAB', 10, 2, 5, 'hitech', 'jublee', '1A', 1, 'Admin', 'Admin', '2015-06-15 00:33:54', '2015-06-15 00:33:54', '0000-00-00 00:00:00', 1, 'Success'),
(30, '', 'MINI', 'OLA', 10, 2, 150, 'Hitech', 'Jublee', 'MINI', 1, 'Admin', 'Admin', '2015-06-17 11:58:36', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'book');

-- --------------------------------------------------------

--
-- Table structure for table `roccoupons`
--

CREATE TABLE IF NOT EXISTS `roccoupons` (
  `roccouponsid` int(11) NOT NULL AUTO_INCREMENT,
  `roccouponcode` varchar(200) NOT NULL,
  `roccoupondescription` mediumtext,
  `roccoupontype` varchar(200) NOT NULL,
  `rocexpirydatetime` datetime NOT NULL,
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` varchar(45) DEFAULT 'Now()',
  PRIMARY KEY (`roccouponsid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rocusercoupons`
--

CREATE TABLE IF NOT EXISTS `rocusercoupons` (
  `rocusercouponsid` int(11) NOT NULL AUTO_INCREMENT,
  `rocuserid` int(11) NOT NULL,
  `roccouponsid` int(11) NOT NULL,
  `roccouponstatus` varchar(45) DEFAULT 'active',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` varchar(45) DEFAULT 'Now()',
  PRIMARY KEY (`rocusercouponsid`),
  UNIQUE KEY `rocusercouponsid_UNIQUE` (`rocusercouponsid`),
  KEY `couponinfo_idx` (`roccouponsid`),
  KEY `usercouponsinfo_idx` (`rocuserid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rocuserratings`
--

CREATE TABLE IF NOT EXISTS `rocuserratings` (
  `rocuserratingid` int(11) NOT NULL AUTO_INCREMENT,
  `rocuserrating` int(11) NOT NULL DEFAULT '0',
  `rocusercomment` mediumtext,
  `rocvendorid` int(11) NOT NULL,
  `rocbookinginfoid` int(11) NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  PRIMARY KEY (`rocuserratingid`),
  UNIQUE KEY `rocuserratingid_UNIQUE` (`rocuserratingid`),
  KEY `ratingvendor_idx` (`rocvendorid`),
  KEY `ratingbooking_idx` (`rocbookinginfoid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rocusers`
--

CREATE TABLE IF NOT EXISTS `rocusers` (
  `rocuserid` int(11) NOT NULL AUTO_INCREMENT,
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
  `rocuserpassword` mediumtext,
  PRIMARY KEY (`rocuserid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

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
-- Table structure for table `rocvendorcharges`
--

CREATE TABLE IF NOT EXISTS `rocvendorcharges` (
  `rocvendorchargeid` int(11) NOT NULL AUTO_INCREMENT,
  `roccabtype` varchar(200) NOT NULL,
  `roccabmodel` varchar(200) NOT NULL,
  `rocchargeperkm` int(11) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  PRIMARY KEY (`rocvendorchargeid`),
  KEY `vendorid_idx` (`rocvendorid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

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
  `rocvendorid` int(11) NOT NULL AUTO_INCREMENT,
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
  `rocvendorrating` int(11) DEFAULT NULL,
  PRIMARY KEY (`rocvendorid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

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
