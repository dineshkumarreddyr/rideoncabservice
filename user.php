<?php
use Respect\Validation\Validator as v;
/*
 * Getting user data by user ID
 */
function user_data($rocuserid) {
	$sql = "SELECT rocuserid as uid, rocuserfirstname as fname, rocuserlastname as lname, rocuseremail as email, rocusercity as city, rocuserstate as state, rocusermobile as mobile, rocuseraddress1 as address1, rocuseraddress2 as address2, rocuserpincode as pincode FROM rocusers WHERE  rocuserid = :rocuserid";
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
		// checking password is empty or not. if empty set default random password
		if(!isset($signUpData->password)) {
			$signUpData->password = rand(00000, 99999);
		}
		$hash = sha1(rand(00000, 99999));
		$sql = "INSERT INTO rocusers (rocuserfirstname, rocuserlastname, rocuseremail, rocuseraddress1, rocuseraddress2, rocusercity, rocuserstate, rocuserpincode, rocusermobile, rocuserpassword, rocuserhash) VALUES (:rocuserfirstname, :rocuserlastname, :rocuseremail, :rocuseraddress1, :rocuseraddress2, :rocusercity, :rocuserstate, :rocuserpincode, :rocusermobile, :rocuserpassword, :rocuserhash)";
		try {
			$db = getDB();
			$stmt = $db->prepare($sql);  
			$stmt->bindParam(":rocuserfirstname", $signUpData->fname);
			$stmt->bindParam(":rocuserlastname", $signUpData->lname);
			$stmt->bindParam(":rocuseremail", $signUpData->email);
			$stmt->bindParam(":rocuseraddress1", $signUpData->address1);
			$stmt->bindParam(":rocuseraddress2", $signUpData->address2);
			$stmt->bindParam(":rocusercity", $signUpData->city);
			$stmt->bindParam(":rocuserstate", $signUpData->state);
			$stmt->bindParam(":rocuserpincode", $signUpData->pincode);
			$stmt->bindParam(":rocusermobile", $signUpData->mobile);
			$stmt->bindParam(":rocuserpassword", $signUpData->password);
			$stmt->bindParam(":rocuserhash", $hash);

			$stmt->execute();
			$signUpData->id = $db->lastInsertId();
			$db = null;
			$signUpData_id= $signUpData->id;
			$confirmation_link = $baseUrl . 'user/signup/confirmation?e=' . urlencode($signUpData->email) . '&h=' . $hash ;

			// sending user registrattioin confirmation mail to user
			$msg  = '
			<div class="wrapmain" style="padding:30px;text-align:center">
             <h2 style="font-size:30px;text-align:center;color:#e38e00;font-weight:700;margin-top:0;">Thankyou!</h2>
             <p style="font-size:15px;line-height:21px;color:#000;text-align:center;">Your email has been successfully registered. Please click the below link to verify your email address.</p>
             <a href="' . $confirmation_link . '" style="color:#;text-decoration:none;">Activate your account.</a>
            </div>';
			$subj = 'Ride on cab : Account Registratioin Confirmation';
			$to   = $signUpData->email;
			mailer($to, $subj, $msg);

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
 * User forgot password by user email and return status
 */
function user_forgotpassword($app, $rocuser) {
	$rocuser = json_decode($rocuser);
	$sql = "SELECT rocuserfirstname as fname,rocuserpassword FROM rocusers WHERE rocuseremail = :rocuseremail";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->bindParam(":rocuseremail", $rocuser->email);
		$stmt->execute();
		$user_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if(count($user_data)) {
			$msg  = '
			<div class="wrapmain" style="padding:30px;text-align:center">
		     <h2 style="font-size:30px;text-align:center;color:#e38e00;font-weight:700;margin-top:0;">Hi ' . $user_data[0]->fname . '..!</h2>
		     <p style="font-size:15px;line-height:21px;color:#000;text-align:center;">Your password - ' . $user_data[0]->rocuserpassword . '</p>
		    </div>';
			$subj = 'Ride on cab : Forgot password';
			$to   = $rocuser->email;

			if(mailer($to, $subj, $msg)) {
				$app->response->setStatus(200);
				$status_data = array("result" => "success", "message" => "Password successfully sent to your mail, please check..");
				echo json_encode($status_data);
			}
		}
		else {
			$app->response->setStatus(400);
			$status_data = array("error" => "Invalid", "error_description" => "Invalid user");
			echo json_encode($status_data);
		}
	} catch(PDOException $e) {
		$app->response->setStatus(500);
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":"'. $e->getMessage() .'"}}'; 
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
					$status_data = array("result" => "success", "message" => "Password successfully updated");
					return json_encode($status_data);
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

/*
 * Delete user by userid
 */
function user_delete($app, $rocuserid = 0) {
	$sql = "DELETE FROM rocusers WHERE  rocuserid = :rocuserid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocuserid", $rocuserid);
		$stmt->execute();		
		$db = null;
		$status_data = array("result" => "success", "message" => "User successfully Deleted");
		echo json_encode($status_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"message":"'. $e->getMessage() .'"}}';
		$app->response->setStatus(500);
	}
}

/*
 * Register user while book cab
 */
function user_register($app, $register_data) {
	$parsed_data = json_decode($register_data);
	// checking is loggedin user data or not 
	if(isset($parsed_data->uid)) {
		return user_updatedetails($parsed_data->uid, $register_data);
	}
	else {
		if(signUpCheck($register_data)) {
			// if already registered user
			$sql = "SELECT rocuserid FROM rocusers WHERE rocuseremail = :rocuseremail";
			$db = getDB();
			$stmt = $db->prepare($sql); 
			$stmt->bindParam("rocuseremail", $parsed_data->email);
			$stmt->execute();
			$user_data = $stmt->fetch(PDO::FETCH_OBJ);
			$db = null;

			$userid = $user_data->rocuserid;
			return user_updatedetails($userid, $register_data);
		}
		else {
			// if not registered user, register with data
			return user_signUp($register_data);
		}
	}
}

/*
 * User update details
 */
function user_updatedetails($userid, $updateDetails) {
	$updateDetails = json_decode($updateDetails);
	$sql = "UPDATE rocusers SET rocuserfirstname = :rocuserfirstname, rocuserlastname = :rocuserlastname, rocusercity = :rocusercity, rocuserstate = :rocuserstate, rocuseraddress1 = :rocuseraddress1, rocuseraddress2 = :rocuseraddress2, rocuserpincode = :rocuserpincode, rocusermobile = :rocusermobile WHERE rocuserid = :rocuserid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam(":rocuserfirstname", $updateDetails->fname);
		$stmt->bindParam(":rocuserlastname", $updateDetails->lname);
		$stmt->bindParam(":rocuseraddress1", $updateDetails->address1);
		$stmt->bindParam(":rocuseraddress2", $updateDetails->address2);
		$stmt->bindParam(":rocusercity", $updateDetails->city);
		$stmt->bindParam(":rocuserstate", $updateDetails->state);
		$stmt->bindParam(":rocuserpincode", $updateDetails->pincode);
		$stmt->bindParam(":rocusermobile", $updateDetails->mobile);
		$stmt->bindParam(":rocuserid", $userid);

		$stmt->execute();
		$db = null;
		return user_data($userid);
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"message":"'. $e->getMessage() .'"}}'; 
	}
}

/*
 * Get List of bookings by user id
 */
function user_bookings_list($app, $userid) {
	$sql = "SELECT bi.rocbookinginfoid as bid, bi.roctransactionid as transid, bi.rocservicetype as serviceid, cs.roccabservices as servicetype, bi.rocservicename as servicename, bi.rocservicechargeperkm scpkm, bi.rocservicekm as servicekm, bi.rocservicestimatedrs as sers, bi.rocbookingfromlocation bfl, bi.rocbookingtolocation as btl, bi.rocserviceclass as sc, bi.rocuserid as uid, bi.rocvendorid as vid, bi.rocbookingdatetime as bdatetime, bi.rocbookingstatus bstatus FROM rocbookinginfo bi, roccabservices cs WHERE bi.rocservicetype = cs.roccabservicesid AND bi.rocuserid = :rocuserid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->bindParam(":rocuserid", $userid);
		$stmt->execute();
		$booking_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($booking_data);
		if($count) {
			$booking_data = array("total" => $count, "results" => $booking_data);
			echo json_encode($booking_data);
			$app->response->setStatus(200);
		}
		else {
			$booking_data = array("total" => 0, "results" => array());
			echo json_encode($booking_data);
			$app->response->setStatus(200);
		}
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}
?>