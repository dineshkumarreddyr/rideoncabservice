<?php
/*
 * Ride on cab main search list
 */
function search($search) {
	$search = json_decode($search);
	$sql = "SELECT vc.roccabtype, vc.roccabmodel, vc.rocchargeperkm, v.rocvendorid, v.rocvendorname, v.rocvendoraddress, v.rocvendorlogo, v.rocvendorrating FROM rocvendorcharges vc, rocvendors v WHERE vc.rocvendorid = v.rocvendorid AND vc.roccabtype = :roccabtype";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("roccabtype", $search->roccabtype);
		$stmt->execute();
		$search_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if(count($search_data)) {
			return json_encode($search_data);
		}
		else {
			$search_data = array("error" => TRUE, "erro_description" => "No results found");
			return json_encode($search_data);
		}
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}
/*
 * Booking cab with user details
 */
function bookCab($bookingData) {
//	return $bookingData;
	$bookingData = json_decode($bookingData);
	$sql = "INSERT INTO rocbookinginfo (rocservicetype, rocservicename, rocservicechargeperkm, rocservicekm, rocservicestimatedrs, rocbookingfromlocation, rocbookingtolocation, rocserviceclass, rocuserid, rocbookingdatetime, rocvendorid, rocbookingstatus) VALUES (:rocservicetype, :rocservicename, :rocservicechargeperkm, :rocservicekm, :rocservicestimatedrs, :rocbookingfromlocation, :rocbookingtolocation, :rocserviceclass, :rocuserid, :rocbookingdatetime, :rocvendorid, :rocbookingstatus)";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam(":rocservicetype", $bookingData->rocservicetype);
		$stmt->bindParam(":rocservicename", $bookingData->rocservicename);
		$stmt->bindParam(":rocservicechargeperkm", $bookingData->rocservicechargeperkm);
		$stmt->bindParam(":rocservicekm", $bookingData->rocservicekm);
		$stmt->bindParam(":rocservicestimatedrs", $bookingData->rocservicestimatedrs);
		$stmt->bindParam(":rocbookingfromlocation", $bookingData->rocbookingfromlocation);
		$stmt->bindParam(":rocbookingtolocation", $bookingData->rocbookingtolocation);
		$stmt->bindParam(":rocserviceclass", $bookingData->rocserviceclass);
		$stmt->bindParam(":rocuserid", $bookingData->rocuserid);
		$stmt->bindParam(":rocbookingdatetime", $bookingData->rocbookingdatetime);
		$stmt->bindParam(":rocvendorid", $bookingData->rocvendorid);
		$stmt->bindParam(":rocbookingstatus", $bookingData->rocbookingstatus);

		$stmt->execute();
		$bookingData->id = $db->lastInsertId();
		$db = null;
		$bookingData_id= $bookingData->id;
		return $bookingData_id;
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}
/*
 * Vendor Sign UP 
 */
function vendor_signUp($signUpData) {
	if(!vendor_signUpCheck($signUpData)) {
		$signUpData = json_decode($signUpData);
		$sql = "INSERT INTO rocvendors (rocvendorname, rocvendoraddress, rocvendoremail, rocvendornumber1, rocvendornumber2, rocvendorusername, rocvendorpassword, rocvendorcontactperson, rocvendorlogo) VALUES (:rocvendorname, :rocvendoraddress, :rocvendoremail, :rocvendornumber1, :rocvendornumber2, :rocvendorusername, :rocvendorpassword, :rocvendorcontactperson, :rocvendorlogo)";
		try {
			$db = getDB();
			$stmt = $db->prepare($sql);  
			$stmt->bindParam(":rocvendorname", $signUpData->rocvendorname);
			$stmt->bindParam(":rocvendoraddress", $signUpData->rocvendoraddress);
			$stmt->bindParam(":rocvendoremail", $signUpData->rocvendoremail);
			$stmt->bindParam(":rocvendornumber1", $signUpData->rocvendornumber1);
			$stmt->bindParam(":rocvendornumber2", $signUpData->rocvendornumber2);
			$stmt->bindParam(":rocvendorusername", $signUpData->rocvendorusername);
			$stmt->bindParam(":rocvendorpassword", $signUpData->rocvendorpassword);
			$stmt->bindParam(":rocvendorcontactperson", $signUpData->rocvendorcontactperson);
			$stmt->bindParam(":rocvendorlogo", $signUpData->rocvendorlogo);

			$stmt->execute();
			$signUpData->id = $db->lastInsertId();
			$db = null;
			$signUpData_id= $signUpData->id;
			//getUserUpdate($signUpData_id);
			return vendor_data($signUpData_id);
		} catch(PDOException $e) {
			//error_log($e->getMessage(), 3, '/var/tmp/php.log');
			return '{"error":{"text":'. $e->getMessage() .'}}'; 
		}
	}
	else {
		$status_data = array("error" => TRUE, "erro_description" => "This email already exists");
		return json_encode($status_data);
	}
}
/*
 * Vendor check while sign up
 */
function vendor_signUpCheck($signUpData) {
	$signUpData = json_decode($signUpData);
	$sql = "SELECT rocvendorid FROM rocvendors WHERE rocvendoremail = :rocvendoremail";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendoremail", $signUpData->rocvendoremail);
		$stmt->execute();
		$vendor_data = $stmt->rowCount(PDO::FETCH_OBJ);
		$db = null;
		return $vendor_data;
		
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
	
}
/*
 * Getting vendor data by vendor unique ID
 */
function vendor_data($rocvendorid) {
	$sql = "SELECT rocvendorid, rocvendorname, rocvendoraddress, rocvendoremail, rocvendornumber1, rocvendornumber2, rocvendorusername, rocvendorpassword, rocvendorcontactperson, rocvendorlogo FROM rocvendors WHERE  rocvendorid = :rocvendorid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $rocvendorid);
		$stmt->execute();		
		$vendor_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		return json_encode($vendor_data);
		
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}
?>