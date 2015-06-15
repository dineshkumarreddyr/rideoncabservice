<?php
/*
 * Getting user data by user ID
 */
function user_data($rocuserid) {
	$sql = "SELECT rocuserid, rocuserfirstname, rocuserlastname, rocuseremail, rocusercity, rocuserstate, rocusermobile, rocuseraddress1, rocusersaddress2, rocuserpincode FROM rocusers WHERE  rocuserid = :rocuserid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocuserid", $rocuserid);
		$stmt->execute();		
		$user_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		return json_encode($user_data);
		
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}
/*
 * User Sign up
 */
function user_signUp($signUpData) {
	if(!signUpCheck($signUpData)) {
		$signUpData = json_decode($signUpData);
		$sql = "INSERT INTO rocusers (rocuserfirstname, rocuserlastname, rocuseremail, rocusercity, rocuserstate, rocusermobile, rocuserpassword) VALUES (:rocuserfirstname, :rocuserlastname, :rocuseremail, :rocusercity, :rocuserstate, :rocusermobile, :rocuserpassword)";
		try {
			$db = getDB();
			$stmt = $db->prepare($sql);  
			$stmt->bindParam(":rocuserfirstname", $signUpData->rocuserfirstname);
			$stmt->bindParam(":rocuserlastname", $signUpData->rocuserlastname);
			$stmt->bindParam(":rocuseremail", $signUpData->rocuseremail);
			$stmt->bindParam(":rocusercity", $signUpData->rocusercity);
			$stmt->bindParam(":rocuserstate", $signUpData->rocuserstate);
			$stmt->bindParam(":rocusermobile", $signUpData->rocusermobile);
			$stmt->bindParam(":rocuserpassword", $signUpData->rocuserpassword);

			$stmt->execute();
			$signUpData->id = $db->lastInsertId();
			$db = null;
			$signUpData_id= $signUpData->id;
			//getUserUpdate($signUpData_id);
			return user_data($signUpData_id);
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
 * User Sign up check "is user already registered or not"
 */
function signUpCheck($signUpData) {
	$signUpData = json_decode($signUpData);
	$sql = "SELECT rocuserid FROM rocusers WHERE rocuseremail = :rocuseremail";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocuseremail", $signUpData->rocuseremail);
		$stmt->execute();
		$user_data = $stmt->rowCount(PDO::FETCH_OBJ);
		$db = null;
		return $user_data;
		
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
	
}
/*
 * User login by email and password and return user data
 */
function user_login($loginData) {
	$loginData = json_decode($loginData);
	$sql = "SELECT rocuserid FROM rocusers WHERE rocuseremail = :rocuseremail AND rocuserpassword = :rocuserpassword";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam(":rocuseremail", $loginData->rocuseremail);
		$stmt->bindParam(":rocuserpassword", $loginData->rocuserpassword);
		$stmt->execute();
		$user_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		//return json_encode($user_data);
		if(count($user_data)) {
			return user_data($user_data[0]->rocuserid);
		}
		else {
			$status_data = array("error" => TRUE, "erro_description" => "Invalid username or password");
			return json_encode($status_data);
		}
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}
?>