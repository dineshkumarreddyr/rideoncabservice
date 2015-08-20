-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2015 at 05:42 AM
-- Server version: 5.5.39
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `roc_api`
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=135 ;

--
-- Dumping data for table `rocbookinginfo`
--

INSERT INTO `rocbookinginfo` (`rocbookinginfoid`, `roctransactionid`, `rocservicetype`, `rocservicename`, `rocservicechargeperkm`, `rocservicekm`, `rocservicestimatedrs`, `rocbookingfromlocation`, `rocbookingtolocation`, `rocserviceclass`, `rocuserid`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocbookingdatetime`, `rocvendorid`, `rocbookingstatus`) VALUES
(108, 'ROC20150801108', '1', 'Victor Travels', 15, 15, 225, 'Allwyn Colony, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 81, 'Admin', 'Admin', '2015-08-01 11:35:34', '0000-00-00 00:00:00', '2015-08-01 21:00:00', 36, 'book'),
(109, 'ROC20150801109', '1', 'Victor Travels', 15, 10, 150, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 11:51:54', '0000-00-00 00:00:00', '2015-08-01 20:00:00', 36, 'book'),
(110, 'ROC20150801110', '1', 'Victor Travels', 15, 10, 150, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 11:52:17', '0000-00-00 00:00:00', '2015-08-01 20:00:00', 36, 'book'),
(111, 'ROC20150801111', '1', 'Victor Travels', 15, 10, 150, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 11:52:24', '0000-00-00 00:00:00', '2015-08-01 20:00:00', 36, 'book'),
(112, 'ROC20150801112', '1', 'Victor Travels', 15, 10, 150, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 11:52:47', '0000-00-00 00:00:00', '2015-08-01 20:00:00', 36, 'book'),
(113, 'ROC20150801113', '1', 'Victor Travels', 15, 15, 225, 'Allwyn Colony, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 81, 'Admin', 'Admin', '2015-08-01 11:55:51', '0000-00-00 00:00:00', '2015-08-01 23:30:00', 36, 'book'),
(114, 'ROC20150801114', '1', 'Hyderabad Cabs', 14, 10, 140, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 11:59:32', '0000-00-00 00:00:00', '2015-08-01 20:00:00', 37, 'book'),
(115, 'ROC20150801115', '1', 'Hyderabad Cabs', 14, 10, 140, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 11:59:40', '0000-00-00 00:00:00', '2015-08-01 20:00:00', 37, 'book'),
(117, 'ROC20150801117', '1', 'Victor Travels', 15, 15, 225, 'Allwyn Colony, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 81, 'Admin', 'Admin', '2015-08-01 12:00:12', '0000-00-00 00:00:00', '2015-08-01 23:00:00', 36, 'book'),
(119, 'ROC20150801119', '1', 'Victor Travels', 15, 15, 225, 'Allwyn Colony, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 81, 'Admin', 'Admin', '2015-08-01 12:01:12', '0000-00-00 00:00:00', '2015-08-01 23:00:00', 36, 'book'),
(120, 'ROC20150801120', '1', 'Hyderabad Cabs', 14, 19, 266, 'Collab House, Hyderabad, Telangana, India', 'Gachibowli, Hyderabad, Telangana, India', 'Business', 84, 'Admin', 'Admin', '2015-08-01 12:09:13', '0000-00-00 00:00:00', '2015-08-03 01:30:00', 37, 'book'),
(121, 'ROC20150801121', '1', 'Hyderabad Cabs', 12, 7, 84, 'Panjagutta, Hyderabad, Telangana, India', 'Abids, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 12:12:43', '0000-00-00 00:00:00', '2015-08-01 20:00:00', 37, 'book'),
(122, 'ROC20150801122', '1', 'Victor Travels', 15, 3, 45, 'Hyderabad, Telangana, India', 'Kala Dera, Hyderabad, Telangana, India', 'Business', 85, 'Admin', 'Admin', '2015-08-01 12:14:54', '0000-00-00 00:00:00', '2015-08-01 20:30:00', 36, 'book'),
(123, 'ROC20150801123', '1', 'Victor Travels', 15, 17, 255, 'Collab House, Hyderabad, Telangana, India', 'Gachibowli Bus Stop, Gachibowli Miyapur Road, Rajiv gandhi Nagar, Hyderabad, Telangana, India', 'Business', 86, 'Admin', 'Admin', '2015-08-01 12:16:55', '0000-00-00 00:00:00', '2015-08-02 00:30:00', 36, 'book'),
(124, 'ROC20150801124', '1', 'Victor Travels', 15, 9, 120, 'Ameerpet, Hyderabad, Telangana, India', 'Hyderabad, Telangana, India', 'Business', 85, 'Admin', 'Admin', '2015-08-01 13:04:12', '0000-00-00 00:00:00', '2015-08-28 18:36:00', 36, 'book'),
(125, 'ROC20150801125', '1', 'Victor Travels', 15, 10, 150, 'Punjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 87, 'Admin', 'Admin', '2015-08-01 14:02:45', '0000-00-00 00:00:00', '2015-08-20 19:33:00', 36, 'book'),
(126, 'ROC20150801126', '1', 'Victor Travels', 15, 10, 150, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-01 15:04:46', '0000-00-00 00:00:00', '2015-08-01 23:30:00', 36, 'book'),
(127, 'ROC20150802127', '2', 'Hyderabad Cabs', 11, 302, 3322, 'Gachibowli, Hyderabad, Telangana, India', 'Bellampalli, Telangana, India', 'Business', 88, 'Admin', 'Admin', '2015-08-02 06:40:48', '0000-00-00 00:00:00', '2015-08-02 14:30:00', 37, 'book'),
(128, 'ROC20150804128', '1', 'Victor Travels', 15, 10, 150, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-04 17:39:32', '0000-00-00 00:00:00', '2015-08-06 02:00:00', 36, 'book'),
(129, 'ROC20150808129', '5', 'Hyderabad Cabs', 10, 41, 410, 'Brigade Metropolis, Bengaluru, Karnataka, India', 'Kempegowda International Airport, Bengaluru, Karnataka, India', 'Business', 90, 'Admin', 'Admin', '2015-08-08 18:39:07', '0000-00-00 00:00:00', '2015-08-09 06:00:00', 37, 'book'),
(130, 'ROC20150810130', '1', 'Hyderabad Cabs', 12, 10, 120, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 91, 'Admin', 'Admin', '2015-08-10 09:47:31', '0000-00-00 00:00:00', '2015-08-10 18:00:00', 37, 'book'),
(131, 'ROC20150811131', '1', 'Hyderabad Cabs', 12, 49, 576, 'Greater Noida, Uttar Pradesh, India', 'Indira Gandhi International Airport, New Delhi, Delhi, India', 'Business', 92, 'Admin', 'Admin', '2015-08-11 09:56:52', '0000-00-00 00:00:00', '2015-08-12 15:27:00', 37, 'book'),
(132, 'ROC20150813132', '1', 'Victor Travels', 100, 9, 800, 'Fatima Nagar, Hyderabad, Telangana, India', 'Hyderabad, Telangana, India', 'Business', 94, 'Admin', 'Admin', '2015-08-13 13:22:37', '0000-00-00 00:00:00', '2015-08-14 18:55:00', 36, 'book'),
(133, 'ROC20150815133', '1', 'Victor Travels', 15, 13, 180, 'Film Nagar, Hyderabad, Telangana, India', 'Bhoiguda, Hyderabad, Telangana, India', 'Business', 96, 'Admin', 'Admin', '2015-08-15 12:23:37', '0000-00-00 00:00:00', '2015-08-15 21:00:00', 36, 'book'),
(134, 'ROC20150817134', '1', 'Victor Travels', 15, 10, 150, 'Panjagutta, Hyderabad, Telangana, India', 'Madhapur, Hyderabad, Telangana, India', 'Business', 82, 'Admin', 'Admin', '2015-08-17 12:42:02', '0000-00-00 00:00:00', '2015-08-17 21:00:00', 36, 'book');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `roccabservices`
--

INSERT INTO `roccabservices` (`roccabservicesid`, `roccabservices`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(1, 'Point to Point', '2015-07-01 11:06:25', NULL, NULL, NULL),
(2, 'Outstation', '2015-07-01 11:09:10', NULL, NULL, NULL),
(3, 'Hourly Package', '2015-07-01 11:09:10', NULL, NULL, NULL),
(5, 'Airport', '2015-07-04 15:25:08', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roccabtypes`
--

CREATE TABLE IF NOT EXISTS `roccabtypes` (
`roccabtypeid` int(11) NOT NULL,
  `roccabtype` varchar(60) NOT NULL,
  `createdtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdby` int(11) NOT NULL,
  `updatedtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedby` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `roccabtypes`
--

INSERT INTO `roccabtypes` (`roccabtypeid`, `roccabtype`, `createdtime`, `createdby`, `updatedtime`, `updatedby`) VALUES
(1, 'Economic', '2015-07-01 21:19:49', 0, '0000-00-00 00:00:00', 0),
(2, 'Premium', '2015-07-01 21:19:49', 0, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `roccities`
--

CREATE TABLE IF NOT EXISTS `roccities` (
`roccityid` int(11) NOT NULL,
  `roccityname` varchar(60) NOT NULL,
  `roccitystatus` enum('0','1') NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `roccities`
--

INSERT INTO `roccities` (`roccityid`, `roccityname`, `roccitystatus`, `createtime`, `updatedtime`) VALUES
(1, 'Hyderabad', '1', '2015-08-19 18:43:35', '0000-00-00 00:00:00'),
(2, 'Warangal', '1', '2015-08-19 18:43:35', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `roccontactus`
--

CREATE TABLE IF NOT EXISTS `roccontactus` (
`roccontactid` int(11) NOT NULL,
  `roccontactname` varchar(60) NOT NULL,
  `roccontactemail` varchar(255) NOT NULL,
  `roccontactmobile` varchar(20) NOT NULL,
  `roccontactsubject` text NOT NULL,
  `roccontactmsg` longtext NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `roccontactip` varchar(60) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `roccontactus`
--

INSERT INTO `roccontactus` (`roccontactid`, `roccontactname`, `roccontactemail`, `roccontactmobile`, `roccontactsubject`, `roccontactmsg`, `createddate`, `updateddate`, `roccontactip`) VALUES
(1, 'uday', 'uday@gmail.com', '7569508595', 'Hi', 'Hello', '2015-08-19 18:39:38', '0000-00-00 00:00:00', ''),
(2, 'uday', 'uday@gmail.com', '7569508595', 'Hi', 'Hello', '2015-08-19 18:51:21', '0000-00-00 00:00:00', '');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  `rocuseraddress2` mediumtext,
  `rocuserpincode` int(11) DEFAULT NULL,
  `rocuserpassword` mediumtext,
  `rocuserstatus` enum('0','1') NOT NULL,
  `rocuserhash` varchar(255) NOT NULL DEFAULT '12345'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=99 ;

--
-- Dumping data for table `rocusers`
--

INSERT INTO `rocusers` (`rocuserid`, `rocuserfirstname`, `rocuserlastname`, `rocuseremail`, `rocusercity`, `rocuserstate`, `rocusermobile`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocuseraddress1`, `rocuseraddress2`, `rocuserpincode`, `rocuserpassword`, `rocuserstatus`, `rocuserhash`) VALUES
(81, 'Dinesh', 'R', 'dinesh.rachumalla@hotmail.com', 'Hyderbad', 'Telangana', '9491358436', 'Admin', 'Admin', '2015-08-01 11:32:02', '0000-00-00 00:00:00', '#406, Allwyn colony Phase 1', 'Kukatpally', 500032, 'ap04n6203', '0', '9ec5d321383209444b7d1f93cc7e805a377ffc15'),
(82, 'sai', 'kiran', 'sairahul3@gmail.com', 'Hyderabad', 'Telangana', '9849603022', 'Admin', 'Admin', '2015-08-01 11:50:03', '0000-00-00 00:00:00', 'panjagutta', 'somajiguda', 500082, 'saikiran', '0', '0fade7f498d15c8ae9344099e45c52125c6a3027'),
(84, 'Srikar', 'A', 'ananthulasrikar@gmail.com', 'hyd', 'AP', '9293151370', 'Admin', 'Admin', '2015-08-01 12:03:54', '0000-00-00 00:00:00', NULL, NULL, NULL, 'srikarsriram', '1', '554db38c3fb9ff873978c4c3b2995b13e5f2e905'),
(85, 'uday', 'kumar', 'udayakumarswamy@gmail.com', 'Hyderabad', 'Andhra Pradesh', '7569508595', 'Admin', 'Admin', '2015-08-01 12:14:47', '0000-00-00 00:00:00', 'hyd', 'hyd2', 533308, '18211', '0', 'f91cf3252db4b17e6ec4105566802863eb422b53'),
(86, 'Raghuram', 'Korukonda', 'kraghu306@gmail.com', 'Hyderbad', 'Telangana', '9030864528', 'Admin', 'Admin', '2015-08-01 12:15:38', '0000-00-00 00:00:00', 'Hyderabad', '47/41,PUNJABI BAGH WEST, New Delhi', 500032, '69834', '0', 'ba00c8c5c166ec9d48c83755152fdababdecdbce'),
(87, 'Shravan', 'Kasagoni', 'shravan.kasagoni@outlook.com', 'Hyderabad', 'Telangana', '8008003554', 'Admin', 'Admin', '2015-08-01 14:02:34', '0000-00-00 00:00:00', 'Medipatnam', 'Kukatpally', 500082, '84075', '0', 'da853eac4fc55faca5a7f58cabaa7c2dc8325a39'),
(88, 'Abhilash', 'Inumella', 'abhilashi.iiith@gmail.com', 'Hyderabad', 'Andhra Pradesh', '9959337100', 'Admin', 'Admin', '2015-08-02 06:40:41', '0000-00-00 00:00:00', 'IIIT Hyderabad', NULL, 5000032, '63967', '0', 'e8e8b8497484b6996e53e5558fe7bcbbb53e526e'),
(89, 'swetha', 'parameshwar', 'vanswetha@gmail.com', 'hyd', 'AP', '9742149590', 'Admin', 'Admin', '2015-08-05 11:57:01', '0000-00-00 00:00:00', NULL, NULL, NULL, '05c41a0516#', '1', 'cea28390559ff7287cc939b120e15f9bf532d66c'),
(90, 'a', 'a', 'a@a.com', 'Hyderabad', 'Andhra Pradesh', '1', 'Admin', 'Admin', '2015-08-08 18:39:01', '0000-00-00 00:00:00', 'a', 'a', 560048, '28735', '0', '871643fb1b4603ed7a4914952cd6216adc57877c'),
(91, 'RJendra', 'Prasad', 'sairahul3@gmil.com', 'Hyderabad', 'Telangana', '9246896400', 'Admin', 'Admin', '2015-08-10 09:47:20', '0000-00-00 00:00:00', 'Aescfjj', 'Skjsn', 50082, '42322', '0', 'fdf52248e6118442f6d8e8acb3a3db3605ab795e'),
(92, 'test', 'more test', 'ss@gmail.com', 'Hyderabad', 'New Delhi', '9939912121', 'Admin', 'Admin', '2015-08-11 09:56:44', '0000-00-00 00:00:00', 'Delhi', 'Delhi', 110016, '71979', '0', '8f0f0f2f451d7ce33b5d68d483a30882fd7bb533'),
(93, 'Gudala Sandeep', 'Gudala', 'sandeep.gudala@hotmail.com', 'Hyderbad', 'Telangana', '8977326793', 'Admin', 'Admin', '2015-08-11 10:16:18', '0000-00-00 00:00:00', 'goutham nagar', 'mjg', 500081, '47456', '0', 'b593a6011667d46ff9c78f63a0a4ed2db9db829e'),
(94, 'Rahul', 'Jain', 'rahul2308@outlook.com', 'Warangal', 'Telangana', '7794808858', 'Admin', 'Admin', '2015-08-13 13:22:26', '0000-00-00 00:00:00', 'NIT Warangal Gate', NULL, 506004, '41830', '0', '59e6ccab4816f96e7473aab492cbbda0fdfbdacd'),
(95, 'Santosh', 'Viswanatham', 'viswanathamsantosh@gmail.com', 'Hyderbad', 'Telangana', '8885430199', 'Admin', 'Admin', '2015-08-15 12:15:54', '0000-00-00 00:00:00', '1-7-131/39', 'Ramnagar', 500020, 'santoshv225', '1', '531158fdebc014cc7cdf9f53304e9ed70279d7d0'),
(96, 'Akshay', 'Tiwari', 'akshaytiwari.003@gmail.com', 'Hyderabad', 'Telangana', '8790918151', 'Admin', 'Admin', '2015-08-15 12:22:52', '0000-00-00 00:00:00', 'bhoiguda', NULL, 500003, '23989', '1', 'b629ef67adc021528360a1a3dc263e9cede89f9d'),
(97, 's', 'v', 'santosh2101993@gmail.com', 'hyd', 'AP', '7894561234', 'Admin', 'Admin', '2015-08-15 15:22:27', '0000-00-00 00:00:00', NULL, NULL, NULL, '123456789', '1', '65bd68ce1ea49b2f45c3b51225b517402c61bf22'),
(98, 'MOTA', 'LOTS', '22@mail.com', 'Hyderabad', 'Telangana', '9688989898', 'Admin', 'Admin', '2015-08-17 19:34:19', '0000-00-00 00:00:00', 'da', 'adsad', 700189, '99517', '0', 'b4b45b6be6f1b02ea91f697172f0a4d15382179f');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorcharges`
--

CREATE TABLE IF NOT EXISTS `rocvendorcharges` (
`rocvendorchargeid` int(11) NOT NULL,
  `roccabtype` int(11) NOT NULL,
  `roccabmodelid` varchar(200) NOT NULL,
  `rocchargeperkm` int(11) NOT NULL,
  `rocchargeunitsperhour` int(11) NOT NULL,
  `roccabservicesid` int(11) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `createduser` varchar(45) DEFAULT 'Admin',
  `modifieduser` varchar(45) DEFAULT 'Admin'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=69 ;

--
-- Dumping data for table `rocvendorcharges`
--

INSERT INTO `rocvendorcharges` (`rocvendorchargeid`, `roccabtype`, `roccabmodelid`, `rocchargeperkm`, `rocchargeunitsperhour`, `roccabservicesid`, `rocvendorid`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(23, 1, 'Indica', 15, 0, 1, 36, '2015-08-01 11:21:50', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(24, 1, 'Verito', 20, 0, 1, 36, '2015-08-01 11:22:02', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(25, 1, 'Etios', 21, 0, 1, 36, '2015-08-01 11:22:15', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(26, 2, 'Audi', 100, 0, 1, 36, '2015-08-01 11:22:44', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(27, 2, 'Innova', 30, 0, 1, 36, '2015-08-01 11:22:58', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(28, 2, 'Tavera', 28, 0, 1, 36, '2015-08-01 11:23:14', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(29, 1, 'Indica', 14, 0, 2, 36, '2015-08-01 11:23:37', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(30, 2, 'Innova', 200, 1, 3, 36, '2015-08-01 11:23:58', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(31, 1, 'Indica', 12, 0, 1, 37, '2015-08-01 11:39:02', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(32, 1, 'Verito', 14, 0, 1, 37, '2015-08-01 11:42:54', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(33, 1, 'Indica', 100, 1, 3, 37, '2015-08-01 11:43:37', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(34, 1, 'Indica', 400, 4, 3, 37, '2015-08-01 11:44:29', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(35, 1, 'Indica', 11, 0, 2, 37, '2015-08-01 11:44:48', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(36, 1, 'Indica', 10, 0, 5, 37, '2015-08-01 11:45:07', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(37, 2, 'Innova', 16, 0, 1, 37, '2015-08-01 11:45:23', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(38, 2, 'Innova', 17, 0, 2, 37, '2015-08-01 11:45:44', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(39, 2, 'Innovation', 11, 0, 5, 37, '2015-08-01 11:46:14', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(40, 1, 'Indica', 1000, 4, 3, 40, '2015-08-15 14:22:53', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(41, 1, 'Swift Dezire', 1100, 4, 3, 40, '2015-08-15 14:25:40', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(42, 1, 'Verito', 1100, 4, 3, 40, '2015-08-15 14:26:11', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(43, 1, 'Etios', 1100, 4, 3, 40, '2015-08-15 14:26:29', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(44, 1, 'Manza', 1100, 4, 3, 40, '2015-08-15 14:27:00', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(45, 2, 'Honda City', 1350, 4, 3, 40, '2015-08-15 14:28:02', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(46, 2, 'Sunny', 1350, 4, 3, 40, '2015-08-15 14:28:22', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(47, 2, 'Innova', 1400, 4, 3, 40, '2015-08-15 14:28:43', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(48, 1, 'Indigo', 1600, 8, 3, 40, '2015-08-15 14:31:37', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(49, 1, 'Swift Dezire', 1800, 8, 3, 40, '2015-08-15 14:33:23', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(50, 1, 'Verito', 1800, 8, 3, 40, '2015-08-15 14:33:52', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(51, 1, 'Etios', 1800, 8, 3, 40, '2015-08-15 14:34:12', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(52, 1, 'Manza', 1800, 8, 3, 40, '2015-08-15 14:34:36', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(53, 2, 'Honda City', 2350, 8, 3, 40, '2015-08-15 14:35:49', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(54, 2, 'Sunny', 2350, 8, 3, 40, '2015-08-15 14:36:13', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(55, 2, 'Innova', 2500, 8, 3, 40, '2015-08-15 14:36:34', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(56, 2, 'Corolla', 3000, 8, 3, 40, '2015-08-15 14:37:01', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(57, 2, 'Altis', 3500, 8, 3, 40, '2015-08-15 14:37:26', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(58, 2, 'Camry', 6500, 8, 3, 40, '2015-08-15 14:38:00', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(59, 2, 'Accord', 6500, 8, 3, 40, '2015-08-15 14:38:35', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(60, 2, 'Volvo S60', 8500, 8, 3, 40, '2015-08-15 14:40:38', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(61, 2, 'Jaguar XJL', 19000, 8, 3, 40, '2015-08-15 14:41:19', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(62, 2, 'BMW 730LD', 16000, 8, 3, 40, '2015-08-15 14:41:52', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(63, 2, 'Mercedes S Class', 13500, 8, 3, 40, '2015-08-15 14:46:46', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(64, 2, 'Jaguar XF', 13500, 8, 3, 40, '2015-08-15 14:47:24', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(65, 2, 'Audi 6', 12000, 8, 3, 40, '2015-08-15 14:48:25', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(66, 2, 'Volvo XC 60', 12000, 8, 3, 40, '2015-08-15 14:48:56', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(67, 2, 'Mercedes E-350', 10000, 8, 3, 40, '2015-08-15 14:49:46', '0000-00-00 00:00:00', 'Admin', 'Admin'),
(68, 2, 'BMW 5 Series', 10000, 8, 3, 40, '2015-08-15 14:50:08', '0000-00-00 00:00:00', 'Admin', 'Admin');

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
  `rocvendorrating` int(11) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=42 ;

--
-- Dumping data for table `rocvendors`
--

INSERT INTO `rocvendors` (`rocvendorid`, `rocvendorname`, `rocvendoraddress`, `rocvendoremail`, `rocvendornumber1`, `rocvendornumber2`, `rocvendorusername`, `rocvendorpassword`, `rocvendorcontactperson`, `rocvendorlogo`, `rocvendorexp`, `rocvendornocif`, `rocvendorfname`, `rocvendorfemail`, `rocvendorslocation`, `rocvendortlproof`, `rocvendortcards`, `rocvendortarrif`, `rocvendorlandline`, `createddate`, `modifieddate`, `createduser`, `modifieduser`, `rocvendorrating`) VALUES
(35, 'uday', '', 'udayakumarswamy@gmail.com', '', '', 'udayakumarswamy@gmail.com', '123456', '', '', 0, 0, '', '', '', '', '', '', '7569508595', '2015-08-01 11:15:25', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(36, 'Victor Travels', 'Allwyn Colony Phase II', 'dinesh.rachumalla@gmail.com', '0406545434', '8143243040', 'dinesh.rachumalla@gmail.com', 'Password', 'Victor Emmanuel', '', 10, 30, 'Mukesh Goud', 'mukeshg@gmail.com', 'Jagadgiri Gutta', '-NA-', '-NA-', '-NA-', '9738134646', '2015-08-01 11:16:50', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(37, 'Hyderabad Cabs', 'Panjagutta ,Hyderabad', 'sairahul3@hotmail.com', '8801447543', '9849603022', 'sairahul3@hotmail.com', 'saikiran', 'Gopi', '', 2, 10, 'Gopi', 'sairahul3@hotmail.com', 'Panjagutta', '-NA-', '-NA-', '-NA-', '9849603022', '2015-08-01 11:36:25', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(38, 'Sai Kiran  Alagundula', '', 'sairahul3@gmail.com', '', '', 'sairahul3@gmail.com', 'saikiran', '', '', 0, 0, '', '', '', '', '', '', '9849603022', '2015-08-01 11:47:35', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(39, 'madhav rao', '', 'madhavrao@gmail.com', '', '', 'madhavrao@gmail.com', 'sshhdd', '', '', 0, 0, '', '', '', '', '', '', '9230178888', '2015-08-14 13:52:39', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(40, 'MM Travels', 'Somajiguda', 'booking@mmtravels.net', '984902477', '9849070405', 'booking@mmtravels.net', 'rideoncab', 'Moin', '', 10, 20, 'Moin', 'info@mmtravels.net', 'Somajiguda', '-NA-', '-NA-', '-NA-', '9849070405', '2015-08-15 14:11:13', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(41, 'santosh', '', 'viswanathamsantosh@gmail.com', '', '', 'viswanathamsantosh@gmail.com', 'santoshv225', '', '', 0, 0, '', '', '', '', '', '', '8885430199', '2015-08-16 06:02:43', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rocvendorterms`
--

CREATE TABLE IF NOT EXISTS `rocvendorterms` (
`rocvendortermsid` int(11) NOT NULL,
  `rocvendorid` int(11) NOT NULL,
  `roccabmodelid` varchar(255) NOT NULL,
  `rocvendorterms` text NOT NULL,
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modifieddate` timestamp NULL DEFAULT NULL,
  `createduser` varchar(45) DEFAULT NULL,
  `modifieduser` varchar(45) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `rocvendorterms`
--

INSERT INTO `rocvendorterms` (`rocvendortermsid`, `rocvendorid`, `roccabmodelid`, `rocvendorterms`, `createddate`, `modifieddate`, `createduser`, `modifieduser`) VALUES
(20, 36, 'Indica', 'Waiting charges applicable', '2015-08-01 11:25:29', NULL, NULL, NULL),
(21, 36, 'Indica', 'No cancellation', '2015-08-01 11:29:07', NULL, NULL, NULL),
(22, 36, 'Indica', 'A/C Extra charges', '2015-08-01 11:29:26', NULL, NULL, NULL);

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
-- Indexes for table `roccabtypes`
--
ALTER TABLE `roccabtypes`
 ADD PRIMARY KEY (`roccabtypeid`);

--
-- Indexes for table `roccities`
--
ALTER TABLE `roccities`
 ADD PRIMARY KEY (`roccityid`);

--
-- Indexes for table `roccontactus`
--
ALTER TABLE `roccontactus`
 ADD PRIMARY KEY (`roccontactid`);

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
 ADD PRIMARY KEY (`rocvendortermsid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rocbookinginfo`
--
ALTER TABLE `rocbookinginfo`
MODIFY `rocbookinginfoid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=135;
--
-- AUTO_INCREMENT for table `roccabservices`
--
ALTER TABLE `roccabservices`
MODIFY `roccabservicesid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `roccabtypes`
--
ALTER TABLE `roccabtypes`
MODIFY `roccabtypeid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `roccities`
--
ALTER TABLE `roccities`
MODIFY `roccityid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `roccontactus`
--
ALTER TABLE `roccontactus`
MODIFY `roccontactid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
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
MODIFY `rocuserid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT for table `rocvendorcabmodel`
--
ALTER TABLE `rocvendorcabmodel`
MODIFY `rocvendorcabmodelid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rocvendorcharges`
--
ALTER TABLE `rocvendorcharges`
MODIFY `rocvendorchargeid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=69;
--
-- AUTO_INCREMENT for table `rocvendors`
--
ALTER TABLE `rocvendors`
MODIFY `rocvendorid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=42;
--
-- AUTO_INCREMENT for table `rocvendorterms`
--
ALTER TABLE `rocvendorterms`
MODIFY `rocvendortermsid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
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
