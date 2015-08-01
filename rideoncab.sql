-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 01, 2015 at 08:05 PM
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Table structure for table `roccabtypes`
--

CREATE TABLE IF NOT EXISTS `roccabtypes` (
`roccabtypeid` int(11) NOT NULL,
  `roccabtype` varchar(60) NOT NULL,
  `createdtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdby` int(11) NOT NULL,
  `updatedtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedby` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocusers`
--

INSERT INTO `rocusers` (`rocuserid`, `rocuserfirstname`, `rocuserlastname`, `rocuseremail`, `rocusercity`, `rocuserstate`, `rocusermobile`, `createduser`, `modifieduser`, `createddate`, `modifieddate`, `rocuseraddress1`, `rocusersaddress2`, `rocuserpincode`, `rocuserpassword`) VALUES
(10, 'udaya kumar swamy', 'vasa', 'udayakumarswamy@gmail.com', 'hyd', 'AP', '7569508595', 'Admin', 'Admin', '2015-06-25 15:53:49', '0000-00-00 00:00:00', NULL, NULL, NULL, '12345');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocvendors`
--

INSERT INTO `rocvendors` (`rocvendorid`, `rocvendorname`, `rocvendoraddress`, `rocvendoremail`, `rocvendornumber1`, `rocvendornumber2`, `rocvendorusername`, `rocvendorpassword`, `rocvendorcontactperson`, `rocvendorlogo`, `rocvendorexp`, `rocvendornocif`, `rocvendorfname`, `rocvendorfemail`, `rocvendorslocation`, `rocvendortlproof`, `rocvendortcards`, `rocvendortarrif`, `rocvendorlandline`, `createddate`, `modifieddate`, `createduser`, `modifieduser`, `rocvendorrating`) VALUES
(11, 'Venkateshwara Travels', 'mothi nager, hyderabad', 'venkateswara@gmail.com', '9738134646', '7569508597', 'venkateswara@gmail.com', '123456', 'venkata', 'NA', 3, 10, 'uday', 'uday@gmail.com', 'Hyderabad', '123456', '12345', '', '', '2015-06-25 17:56:10', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL),
(12, 'OLA Cab', '', 'ola@gmail.com', '9849434343', '', 'ola@gmail.com', '123456', '', '', 0, 0, '', '', '', '', '', '', '', '2015-06-25 18:09:27', '0000-00-00 00:00:00', 'Admin', 'Admin', NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
MODIFY `rocbookinginfoid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roccabservices`
--
ALTER TABLE `roccabservices`
MODIFY `roccabservicesid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roccabtypes`
--
ALTER TABLE `roccabtypes`
MODIFY `roccabtypeid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
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
MODIFY `rocuserid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `rocvendorcabmodel`
--
ALTER TABLE `rocvendorcabmodel`
MODIFY `rocvendorcabmodelid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rocvendorcharges`
--
ALTER TABLE `rocvendorcharges`
MODIFY `rocvendorchargeid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rocvendors`
--
ALTER TABLE `rocvendors`
MODIFY `rocvendorid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `rocvendorterms`
--
ALTER TABLE `rocvendorterms`
MODIFY `rocvendortermsid` int(11) NOT NULL AUTO_INCREMENT;
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
