<?php
/*
 * Getting user data by user ID
 */
function user_data($rocuserid) {
	$sql = "SELECT rocuserid as uid, rocuserfirstname as fname, rocuserlastname as lname, rocuseremail as email, rocusercity as city, rocuserstate as state, rocusermobile as mobile, rocuseraddress1 as address1, rocusersaddress2 as address2, rocuserpincode as pincode FROM rocusers WHERE  rocuserid = :rocuserid";
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
		return '{"error":{"message":"'. $e->getMessage() .'"}}'; 
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
			$stmt->bindParam(":rocuserfirstname", $signUpData->fname);
			$stmt->bindParam(":rocuserlastname", $signUpData->lname);
			$stmt->bindParam(":rocuseremail", $signUpData->email);
			$stmt->bindParam(":rocusercity", $signUpData->city);
			$stmt->bindParam(":rocuserstate", $signUpData->state);
			$stmt->bindParam(":rocusermobile", $signUpData->mobile);
			$stmt->bindParam(":rocuserpassword", $signUpData->password);

			$stmt->execute();
			$signUpData->id = $db->lastInsertId();
			$db = null;
			$signUpData_id= $signUpData->id;
			//getUserUpdate($signUpData_id);
			return user_data($signUpData_id);
		} catch(PDOException $e) {
			//error_log($e->getMessage(), 3, '/var/tmp/php.log');
			return '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		}
	}
	else {
		$status_data = array("error" => "duplicate", "error_description" => "This email already exists");
		return json_encode($status_data);
	}
}

function user_signup_validate($signUpData) {
	$signUpData = json_decode($signUpData);
	$fields = array();
	$error = FALSE;
	// return $signUpData->fname;
	if(v::string()->notEmpty()->validate($signUpData->fname)) {
		$fields['fname'] = "First name should not be empty";
		$error = TRUE;
	}
	// if($error) {
	// 	$response = array(
	// 		'error' => 'validation',
	// 		'fields' => $fields
	// 	);
	// 	return json_encode($response);
	// }
	// else {
	// 	return TRUE;
	// }
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
		$stmt->bindParam("rocuseremail", $signUpData->email);
		$stmt->execute();
		$user_data = $stmt->rowCount(PDO::FETCH_OBJ);
		$db = null;
		return $user_data;
		
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":"'. $e->getMessage() .'"}}'; 
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
		$stmt->bindParam(":rocuseremail", $loginData->username);
		$stmt->bindParam(":rocuserpassword", $loginData->password);
		$stmt->execute();
		$user_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		//return json_encode($user_data);
		if(count($user_data)) {
			return user_data($user_data[0]->rocuserid);
		}
		else {
			$status_data = array("error" => "Invalid", "error_description" => "Invalid username or password");
			return json_encode($status_data);
		}
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":"'. $e->getMessage() .'"}}'; 
	}
}

/*
 * User change password by user id and return status
 */
function user_changepassword($passwordData, $rocuserid) {
	$passwordData = json_decode($passwordData);
	$sql = "SELECT rocuserpassword FROM rocusers WHERE rocuserid = :rocuserid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->bindParam(":rocuserid", $rocuserid);
		$stmt->execute();
		$user_data = $stmt->fetch(PDO::FETCH_OBJ);
		$db = null;
		if(count($user_data)) {
			if($user_data->rocuserpassword == $passwordData->opassword) {
				$sql = "UPDATE rocusers SET rocuserpassword = :rocuserpassword WHERE rocuserid = :rocuserid";
				$db = getDB();
				$stmt = $db->prepare($sql);  
				$stmt->bindParam(":rocuserpassword", $passwordData->password);
				$stmt->bindParam(":rocuserid", $rocuserid);
				$stmt->execute();
				if($stmt->rowCount()) {
					return "Password successfully updated";
				}
				else {
					$status_data = array("error" => "Invalid", "error_description" => "Password updating failed");
					return json_encode($status_data);
				}
			}
			else {
				$status_data = array("error" => "Invalid", "error_description" => "Invalid Old Password");
				return json_encode($status_data);
			}
		}
		else {
			$status_data = array("error" => "Invalid", "error_description" => "Invalid user");
			return json_encode($status_data);
		}
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":"'. $e->getMessage() .'"}}'; 
	}
}
?>