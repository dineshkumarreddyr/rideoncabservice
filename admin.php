<?php
// $app = \Slim\Slim::getInstance();
/*
 * Get List of users
 */
function users_list($app) {
	$sql = "SELECT 
	rocuserid as uid, 
	rocuserfirstname as fname,
	rocuserlastname as lname,
	rocuseremail as email, 
	rocusercity as city, 
	rocuserstate as state, 
	rocusermobile as mobile, 
	rocuseraddress1 as address1, 
	rocusersaddress2 as address2,
	rocuserpincode as pincode 
	FROM rocusers";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->execute();		
		$bookings_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($bookings_data);
		$bookings_data = array("total" => $count, "results" => $bookings_data);
		echo json_encode($bookings_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}

/*
 * Get List of vendors
 */
function vendors_list() {
	$sql = "SELECT 
	rocvendorid as vid, 
	rocvendorname as name, 
	rocvendoraddress as address,
	rocvendoremail as email,
	rocvendornumber1 as number1, 
	rocvendornumber2 as number2, 
	rocvendorusername as username, 
	rocvendorcontactperson as contactperson, 
	rocvendorlogo as logo, 
	rocvendorexp as exp, 
	rocvendornocif as nocif, 
	rocvendorfname as fname, 
	rocvendorfemail as femail, 
	rocvendorslocation as slocation, 
	rocvendortlproof as tlproof, 
	rocvendortcards as tcards, 
	rocvendortarrif as tarrif, 
	rocvendorlandline as landline, 
	createddate as createddate, 
	modifieddate as modifieddate,
	rocvendorrating as rating 
	FROM rocvendors";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->execute();		
		$vendors_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($vendors_data);
		$vendors_data = array("total" => $count, "results" => $vendors_data);
		echo json_encode($vendors_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(400);
	}
}

/*
 * Getting all bookings
 */
function bookings_list($app) {
	$sql = "SELECT 
	rocbookinginfoid as bookingid, 
	rocservicetype as servicetype, 
	rocbookingfromlocation as fromlocation, 
	rocbookingtolocation as tolocation, 
	rocbookingdatetime as bookingdatetime 
	FROM rocbookinginfo";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->execute();		
		$bookings_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($bookings_data);
		$bookings_data = array("total" => $count, "results" => $bookings_data);
		echo json_encode($bookings_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}
?>