-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 05, 2015 at 06:54 PM
-- Server version: 5.5.42-cll
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `crestdzi_rideoncab`
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `rocbookinginfo`
--

INSERT INTO `rocbookinginfo` (`rocbookinginfoid`, `roctransactionid`, `rocservicetype`, `rocservicename`, `rocservicechargeperkm`, `rocservicekm`, `rocservicestimatedrs`, `rocbookingfromlocation`, `rocbookingtolocation`, `rocserviceclass`, `rocuserid`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocbookingdatetime`, `rocvendorid`, `rocbookingstatus`) VALUES
(7, '201507057', '1', 'Venkateshwara Travels', 12, 19, 216, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 17:55:00', '0000-00-00 00:00:00', '2015-07-05 19:00:00', 11, 'book'),
(8, '201507058', '1', 'Venkateshwara Travels', 12, 19, 216, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 17:55:52', '0000-00-00 00:00:00', '2015-07-05 19:00:00', 11, 'book'),
(9, '201507059', '1', 'Venkateshwara Travels', 12, 19, 216, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 17:55:55', '0000-00-00 00:00:00', '2015-07-05 19:00:00', 11, 'book'),
(10, '2015070510', '1', 'Venkateshwara Travels', 12, 19, 216, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 17:56:37', '0000-00-00 00:00:00', '2015-07-05 19:00:00', 11, 'book'),
(11, '2015070511', '1', 'Venkateshwara Travels', 12, 19, 216, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 17:57:21', '0000-00-00 00:00:00', '2015-07-05 19:00:00', 11, 'book'),
(12, '2015070512', '1', 'Venkateshwara Travels', 12, 19, 216, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 18:01:51', '0000-00-00 00:00:00', '2015-07-05 19:00:00', 11, 'book'),
(13, '2015070513', '1', 'Venkateshwara Travels', 200, 17, 3200, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli Bus Stop, Gachibowli Miyapur Road, Rajiv gandhi Nagar, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 18:08:51', '0000-00-00 00:00:00', '2015-07-05 03:00:00', 11, 'book'),
(14, 'ROC2015070514', '1', 'Venkateshwara Travels', 200, 17, 3200, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli Bus Stop, Gachibowli Miyapur Road, Rajiv gandhi Nagar, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 18:12:07', '0000-00-00 00:00:00', '2015-07-05 03:00:00', 11, 'book'),
(15, 'ROC2015070515', '1', 'Venkateshwara Travels', 200, 17, 3200, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli Bus Stop, Gachibowli Miyapur Road, Rajiv gandhi Nagar, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 18:13:18', '0000-00-00 00:00:00', '2015-07-05 03:00:00', 11, 'book'),
(16, 'ROC2015070516', '1', 'Venkateshwara Travels', 200, 17, 3200, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli Bus Stop, Gachibowli Miyapur Road, Rajiv gandhi Nagar, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 18:13:39', '0000-00-00 00:00:00', '2015-07-05 03:00:00', 11, 'book'),
(17, 'ROC2015070517', '1', 'Venkateshwara Travels', 80, 19, 1440, 'Ameerpet, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 11, 'Admin', 'Admin', '2015-07-05 18:50:59', '0000-00-00 00:00:00', '2015-07-06 02:00:00', 11, 'book');

-- --------------------------------------------------------

--
-- Table structure for table `roccabservices`
--

CREATE TABLE IF NOT EXISTS `roccabservices` (
  `roccabservicesid` int(11) NOT NULL AUTO_INCREMENT,
  `roccabservices` varchar(200) NOT NULL,
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NULL DEFAULT NULL,
  `createduser` varchar(45) DEFAULT NULL,
  `modifieduser` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`roccabservicesid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `roccabservices`
--

INSERT INTO `roccabservices` (`roccabservicesid`, `roccabservices`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(1, 'Point to Point', '2015-07-01 07:06:25', NULL, NULL, NULL),
(2, 'Outstation', '2015-07-01 07:09:10', NULL, NULL, NULL),
(3, 'Hourly Package', '2015-07-01 07:09:10', NULL, NULL, NULL),
(4, 'Cab Here', '2015-07-01 07:09:20', NULL, NULL, NULL),
(5, 'Airport', '2015-07-04 11:25:08', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roccabtypes`
--

CREATE TABLE IF NOT EXISTS `roccabtypes` (
  `roccabtypeid` int(11) NOT NULL AUTO_INCREMENT,
  `roccabtype` varchar(60) NOT NULL,
  `createdtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdby` int(11) NOT NULL,
  `updatedtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedby` int(11) NOT NULL,
  PRIMARY KEY (`roccabtypeid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `roccabtypes`
--

INSERT INTO `roccabtypes` (`roccabtypeid`, `roccabtype`, `createdtime`, `createdby`, `updatedtime`, `updatedby`) VALUES
(1, 'Economic', '2015-07-01 17:19:49', 0, '0000-00-00 00:00:00', 0),
(2, 'Premium', '2015-07-01 17:19:49', 0, '0000-00-00 00:00:00', 0);

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
  `rocuseraddress2` mediumtext,
  `rocuserpincode` int(11) DEFAULT NULL,
  `rocuserpassword` mediumtext,
  PRIMARY KEY (`rocuserid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Dumping data for table `rocusers`
--

INSERT INTO `rocusers` (`rocuserid`, `rocuserfirstname`, `rocuserlastname`, `rocuseremail`, `rocusercity`, `rocuserstate`, `rocusermobile`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocuseraddress1`, `rocuseraddress2`, `rocuserpincode`, `rocuserpassword`) VALUES
(10, 'udaya kumar swamy', 'vasa', 'udayakumarswamy@gmail.com', 'hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-25 15:53:49', '0000-00-00 00:00:00', NULL, NULL, NULL, '12345'),
(11, 'Dinesh', 'Kumar', 'dinesh.rachumalla@hotmail.com', 'Hyderabad', 'Telanga', '9738134646', 'Admin', 'Admin', '2015-07-01 18:30:37', '0000-00-00 00:00:00', '#406, Phase 1', 'Allwyn colony', 500072, '1234'),
(12, 'Dinesh', 'Kumar', 'dinesh.rachumalla1@hotmail.com', 'Hyderabad', 'Telangana', '9738134646', 'Admin', 'Admin', '2015-07-04 12:26:10', '0000-00-00 00:00:00', NULL, NULL, NULL, NULL),
(13, 'Dinesha', 'Kumar', 'dinesh.rachumalla2@hotmail.com', 'Hyderabad', 'Telangana', '9738134646', 'Admin', 'Admin', '2015-07-04 12:29:46', '0000-00-00 00:00:00', NULL, NULL, NULL, NULL),
(23, 'Test', 'Test lastname', 'test11111111@gmail.com', '', '', '998888888', 'Admin', 'Admin', '2015-07-05 08:17:37', '0000-00-00 00:00:00', 'Gachibowliee', 'Street', 500038, '43729'),
(24, 'Test', 'Test Lasname', 'indira@gmail.com', '', '', '9422321121', 'Admin', 'Admin', '2015-07-05 08:18:09', '0000-00-00 00:00:00', 'Indira Nagar', 'Gachibowli', 500038, '76046'),
(25, 'Test2', 'Test2 lastname', 'test2@gmail.com', 'Hyderabad', 'Andhra Pradesh', '9832232212', 'Admin', 'Admin', '2015-07-05 16:30:20', '0000-00-00 00:00:00', 'Indira Nagar', 'Gachibowli', 500038, '322'),
(26, 'Test3', 'Test3 Lastname', 'test3@gmail.com', 'Warangal', 'Telanga', '987322322', 'Admin', 'Admin', '2015-07-05 16:34:17', '0000-00-00 00:00:00', 'Veranna Palya', 'BTM Layout', 534332, '17509'),
(27, 'Test 4', 'Test4 lastname', 'test4@gmail.com', 'Tirupati', 'Andhra Pradesh', '9342322222', 'Admin', 'Admin', '2015-07-05 16:37:35', '0000-00-00 00:00:00', 'lg nagar', 'Indira Nagar, Gachibowli', 454434, '180'),
(28, 'Test5', 'Test5 lastname', 'test5@gmail.com', 'Vijayawada', 'Andhra Pradesh', '9993332322', 'Admin', 'Admin', '2015-07-05 16:38:34', '0000-00-00 00:00:00', 'Yakut Nagar', 'Kukatpally', 500045, '92750'),
(29, 'test6', 'Test6 lastname', 'test6@gmail.com', 'Vijayawada', 'Andhra Pradesh', '9434332322', 'Admin', 'Admin', '2015-07-05 16:42:40', '0000-00-00 00:00:00', 'Nehru Park', 'Putlampalli', 500045, '48349');

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorcabmodel`
--

CREATE TABLE IF NOT EXISTS `rocvendorcabmodel` (
  `rocvendorcabmodelid` int(11) NOT NULL AUTO_INCREMENT,
  `rocvendorcabtype` varchar(100) NOT NULL,
  `rocvendorcabmodel` varchar(100) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NULL DEFAULT NULL,
  `createduser` varchar(100) DEFAULT NULL,
  `modifieduser` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`rocvendorcabmodelid`),
  KEY `rocvendorid` (`rocvendorid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorcharges`
--

CREATE TABLE IF NOT EXISTS `rocvendorcharges` (
  `rocvendorchargeid` int(11) NOT NULL AUTO_INCREMENT,
  `roccabtype` int(11) NOT NULL,
  `roccabmodelid` varchar(200) NOT NULL,
  `rocchargeperkm` int(11) NOT NULL,
  `rocchargeunitsperhour` int(11) NOT NULL,
  `roccabservicesid` int(11) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  PRIMARY KEY (`rocvendorchargeid`),
  KEY `vendorid_idx` (`rocvendorid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `rocvendorcharges`
--

INSERT INTO `rocvendorcharges` (`rocvendorchargeid`, `roccabtype`, `roccabmodelid`, `rocchargeperkm`, `rocchargeunitsperhour`, `roccabservicesid`, `rocvendorid`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(1, 1, 'Indica', 12, 0, 1, 11, '2015-07-01 19:07:36', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(2, 1, 'Verito', 15, 0, 1, 11, '2015-07-01 19:07:55', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(3, 2, 'Vento', 30, 0, 2, 11, '2015-07-01 21:40:33', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(4, 1, 'BMW', 60, 0, 1, 11, '2015-07-01 21:49:58', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(5, 2, 'Mercedes Benz', 80, 0, 1, 11, '2015-07-01 21:50:43', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(7, 2, 'Jaguar 2', 200, 0, 1, 11, '2015-07-01 21:53:09', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(8, 1, 'Nano', 10, 0, 1, 11, '2015-07-01 21:55:51', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(9, 1, 'Indica', 13, 0, 1, 13, '2015-07-01 21:59:19', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(10, 1, 'Verito', 15, 0, 1, 13, '2015-07-01 21:59:32', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(11, 1, 'Vento', 20, 0, 1, 13, '2015-07-01 21:59:41', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(12, 2, 'Audi', 300, 0, 1, 13, '2015-07-01 21:59:50', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(13, 1, 'Indica', 12, 0, 1, 12, '2015-07-03 10:36:04', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(14, 1, 'porse', 150, 0, 1, 11, '2015-07-03 18:05:37', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(15, 1, 'Indica', 15, 0, 1, 15, '2015-07-04 07:23:36', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(16, 2, 'Innova', 20, 0, 1, 15, '2015-07-04 07:23:54', '0000-00-00 00:00:00', 'Admin', 'Admin');

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
  `rocvendorexp` int(11) NOT NULL,
  `rocvendornocif` int(11) NOT NULL,
  `rocvendorfname` varchar(60) NOT NULL,
  `rocvendorfemail` varchar(225) NOT NULL,
  `rocvendorslocation` varchar(60) NOT NULL,
  `rocvendortlproof` varchar(60) NOT NULL,
  `rocvendortcards` varchar(60) NOT NULL,
  `rocvendortarrif` varchar(225) NOT NULL,
  `rocvendorlandline` varchar(20) NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin',
  `rocvendorrating` int(11) DEFAULT NULL,
  PRIMARY KEY (`rocvendorid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `rocvendors`
--

INSERT INTO `rocvendors` (`rocvendorid`, `rocvendorname`, `rocvendoraddress`, `rocvendoremail`, `rocvendornumber1`, `rocvendornumber2`, `rocvendorusername`, `rocvendorpassword`, `rocvendorcontactperson`, `rocvendorlogo`, `rocvendorexp`, `rocvendornocif`, `rocvendorfname`, `rocvendorfemail`, `rocvendorslocation`, `rocvendortlproof`, `rocvendortcards`, `rocvendortarrif`, `rocvendorlandline`, `createddate`, `modifieddate`, `createduser`, `modifieduser`, `rocvendorrating`) VALUES
(11, 'Venkateshwara Travels', 'mothi nager, hyderabad', 'venkateswara@gmail.com', '9738134646', '7569508597', 'venkateswara@gmail.com', '123456', 'Kashyap', 'NA', 3, 10, 'uday', 'uday@gmail.com', 'Allwyn Colony', '-NA-', '-NA-', '-NA-', '0407665656', '2015-06-25 17:56:10', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(12, 'OLA Cab', 'Nehru Palya', 'ola@gmail.com', '9849434343', '7545442422', 'ola@gmail.com', '123456', 'Venkateswarulu Somsekhar', '', 23, 1211, 'Ramesh Bhopati', 'rameshbopati@gmail.com', 'Mothi Nagar', '-NA-', '-NA-', '-NA-', '040545443', '2015-06-25 18:09:27', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(13, 'Uber Cabs', 'Aravind Nagar, Hyderabad', 'uber@gmail.com', '040666666', '9656554544', 'uber@gmail.com', '1234', 'Gagan Nath', '', 2, 600, 'Ausothosh', 'asth@gmail.com', 'Film Nagar', '-NA-', '-NA-', '-NA-', '040545444', '2015-07-01 21:57:52', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(14, 'Sai Travels', '', 'saitravels@gmail.com', '9738133322', '', 'saitravels@gmail.com', '123456', '', '', 0, 0, '', '', '', '', '', '', '', '2015-07-03 11:25:08', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(15, 'City Cabs', 'Karan Apartments,Ground Floor,Begumpet,Hyderabad', 'info@mycitycabs.com', '8885610448', '9959248987', 'info@mycitycabs.com', 'eysVLp88', 'Imran Baig', '', 3, 10, 'Imran', 'imran_baig2505@yahoo.com', 'Begumpet', '-NA-', '-NA-', '-NA-', '04066206620', '2015-07-04 07:18:02', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorterms`
--

CREATE TABLE IF NOT EXISTS `rocvendorterms` (
  `rocvendortermsid` int(11) NOT NULL AUTO_INCREMENT,
  `rocvendorid` int(11) NOT NULL,
  `roccabmodelid` varchar(255) NOT NULL,
  `rocvendorterms` text NOT NULL,
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NULL DEFAULT NULL,
  `createduser` varchar(45) DEFAULT NULL,
  `modifieduser` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`rocvendortermsid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `rocvendorterms`
--

INSERT INTO `rocvendorterms` (`rocvendortermsid`, `rocvendorid`, `roccabmodelid`, `rocvendorterms`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(10, 12, '', 'Waiting Charges', '2015-07-03 10:44:12', NULL, NULL, NULL),
(11, 12, '', 'Waiting Charges', '2015-07-03 10:45:16', NULL, NULL, NULL),
(12, 12, '', 'Person seating', '2015-07-03 10:45:54', NULL, NULL, NULL),
(14, 11, 'Nano', 'Terms Nano', '2015-07-04 18:56:59', NULL, NULL, NULL);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
