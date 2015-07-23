<?php
use Respect\Validation\Validator as v;
/*
 * Ride on cab main search list
 */
function search($search) {
	$search = json_decode($search);
	$sql = "SELECT DISTINCT(v.rocvendorid) as vendorid, vc.roccabtype as cabtype, vc.roccabmodelid as cabmodel, vc.rocchargeperkm as chargeperkm, v.rocvendorname as vendorname, v.rocvendoraddress as vendoraddress, v.rocvendorlogo as vendorlogo, v.rocvendorrating as vendorrating FROM rocvendorcharges vc, rocvendors v, roccabservices cs WHERE vc.rocvendorid = v.rocvendorid AND vc.roccabservicesid = :roccabservicesid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		// $stmt->bindParam("roccabtype", $search->cabtype);
		$stmt->bindParam("roccabservicesid", $search->servicetype);
		$stmt->execute();
		$search_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($search_data);
		if($count) {
			$search_data = array("total" => $count, "results" => $search_data);
			return json_encode($search_data);
		}
		else {
			$search_data = array("total" => 0, "results" => array());
			return json_encode($search_data);
		}
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":"'. $e->getMessage() .'""}}'; 
	}
}
/*
 * Booking cab with user details
 */
function bookCab($app, $bookingData) {
//	return $bookingData;
	$bookingData = json_decode($bookingData);
	$sql = "INSERT INTO rocbookinginfo (rocservicetype, rocservicename, rocservicechargeperkm, rocservicekm, rocservicestimatedrs, rocbookingfromlocation, rocbookingtolocation, rocserviceclass, rocuserid, rocbookingdatetime, rocvendorid, rocbookingstatus) VALUES (:rocservicetype, :rocservicename, :rocservicechargeperkm, :rocservicekm, :rocservicestimatedrs, :rocbookingfromlocation, :rocbookingtolocation, :rocserviceclass, :rocuserid, :rocbookingdatetime, :rocvendorid, :rocbookingstatus)";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam(":rocservicetype", $bookingData->servicetype);
		$stmt->bindParam(":rocservicename", $bookingData->servicename);
		$stmt->bindParam(":rocservicechargeperkm", $bookingData->servicechargeperkm);
		$stmt->bindParam(":rocservicekm", $bookingData->servicekm);
		$stmt->bindParam(":rocservicestimatedrs", $bookingData->servicestimatedrs);
		$stmt->bindParam(":rocbookingfromlocation", $bookingData->bookingfromlocation);
		$stmt->bindParam(":rocbookingtolocation", $bookingData->bookingtolocation);
		$stmt->bindParam(":rocserviceclass", $bookingData->serviceclass);
		$stmt->bindParam(":rocuserid", $bookingData->userid);
		$stmt->bindParam(":rocbookingdatetime", $bookingData->bookingdatetime);
		$stmt->bindParam(":rocvendorid", $bookingData->vendorid);
		$stmt->bindParam(":rocbookingstatus", $bookingData->bookingstatus);

		$stmt->execute();
		$bookingData->id = $db->lastInsertId();
		$db = null;
		$bookingData_id= $bookingData->id;

		// generate and store transaction ID
		if(generate_transactionid($app, $bookingData_id) == TRUE) {

			$user_data = json_decode(user_data($bookingData->userid));
			$user_data = $user_data[0];

			$transaction_id = 'ROC' . date('Ymd') . $bookingData_id;
			$mobile = $user_data->mobile;
			$message = "CAB successfully booked, Booking ID:" . $transaction_id;
			// sending message to user with booking id
			prepare_sms($mobile, $message);

			// sending booking confirmation mail to user
			$msg  = 'Hi ' . $user_data->fname . ', <br> ' . $message;
			$subj = 'Ride on cab : Booking confirmation';
			$to   = $user_data->email;
			mailer($to, $subj, $msg);

			// return total booking info data
			booking_info_data($app, $bookingData_id);
		}
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}

/*
 * generate and store transaction ID for booked info
 */
function generate_transactionid($app, $bookingData_id = 0) {
	$transaction_id = 'ROC' . date('Ymd') . $bookingData_id;
	$sql = "UPDATE rocbookinginfo SET roctransactionid =:roctransactionid WHERE rocbookinginfoid = :rocbookinginfoid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("roctransactionid", $transaction_id);
		$stmt->bindParam("rocbookinginfoid", $bookingData_id);
		$stmt->execute();
		$db = null;
		return TRUE;
	} catch(PDOException $e) {
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}

/*
 * total booking info data by booking id
 */
function booking_info_data($app, $bookingData_id = 0) {
	$sql = "SELECT bi.rocbookinginfoid as bid, bi.roctransactionid as transid, bi.rocservicetype as serviceid, cs.roccabservices as servicetype, bi.rocservicename as servicename, bi.rocservicechargeperkm scpkm, bi.rocservicekm as servicekm, bi.rocservicestimatedrs as sers, bi.rocbookingfromlocation bfl, bi.rocbookingtolocation as btl, bi.rocserviceclass as sc, bi.rocuserid as uid, bi.rocvendorid as vid, bi.rocbookingdatetime as bdatetime, bi.rocbookingstatus bstatus FROM rocbookinginfo bi, roccabservices cs WHERE bi.rocbookinginfoid = :rocbookinginfoid AND bi.rocservicetype = cs.roccabservicesid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocbookinginfoid", $bookingData_id);
		$stmt->execute();
		$booking_data = $stmt->fetch(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($booking_data);
		$app->response->setStatus(201);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":"'. $e->getMessage() .'""}}'; 
		$app->response->setStatus(500);
	}
}

/*
 * Vendor Sign UP 
 */
function vendor_signUp($signUpData) {
	if(!vendor_signUpCheck($signUpData)) {
		$signUpData = json_decode($signUpData);
		$sql = "INSERT INTO rocvendors (rocvendorname, rocvendoraddress, rocvendoremail, rocvendornumber1, rocvendornumber2, rocvendorusername, rocvendorpassword, rocvendorcontactperson, rocvendorlogo, rocvendorlandline) VALUES (:rocvendorname, :rocvendoraddress, :rocvendoremail, :rocvendornumber1, :rocvendornumber2, :rocvendorusername, :rocvendorpassword, :rocvendorcontactperson, :rocvendorlogo, :rocvendorlandline)";
		try {
			$db = getDB();
			$stmt = $db->prepare($sql);  
			$stmt->bindParam(":rocvendorname", $signUpData->name);
			$stmt->bindParam(":rocvendoraddress", $signUpData->address);
			$stmt->bindParam(":rocvendoremail", $signUpData->email);
			$stmt->bindParam(":rocvendornumber1", $signUpData->number1);
			$stmt->bindParam(":rocvendornumber2", $signUpData->number2);
			$stmt->bindParam(":rocvendorusername", $signUpData->username);
			$stmt->bindParam(":rocvendorpassword", $signUpData->password);
			$stmt->bindParam(":rocvendorcontactperson", $signUpData->contactperson);
			$stmt->bindParam(":rocvendorlogo", $signUpData->logo);
			$stmt->bindParam(":rocvendorlandline", $signUpData->landline);

			$stmt->execute();
			$signUpData->id = $db->lastInsertId();
			$db = null;
			$signUpData_id= $signUpData->id;
			//getUserUpdate($signUpData_id);
			return vendor_data($signUpData_id);
		} catch(PDOException $e) {
			//error_log($e->getMessage(), 3, '/var/tmp/php.log');
			return '{"error":{"text":"'. $e->getMessage() .'"}}'; 
		}
	}
	else {
		$status_data = array("error" => "duplicate", "erro_description" => "This email already exists");
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
		$stmt->bindParam("rocvendoremail", $signUpData->email);
		$stmt->execute();
		$vendor_data = $stmt->rowCount(PDO::FETCH_OBJ);
		$db = null;
		return $vendor_data;
		
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"message":"'. $e->getMessage() .'"}}'; 
	}
	
}

/*
 * Vendor login by email and password and return vendor data
 */
function vendor_login($loginData) {
	$loginData = json_decode($loginData);
	$sql = "SELECT rocvendorid FROM rocvendors WHERE rocvendoremail = :rocvendoremail AND rocvendorpassword = :rocvendorpassword";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam(":rocvendoremail", $loginData->username);
		$stmt->bindParam(":rocvendorpassword", $loginData->password);
		$stmt->execute();
		$vendor_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		//return json_encode($vendor_data);
		if(count($vendor_data)) {
			return vendor_data($vendor_data[0]->rocvendorid, 'full');
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
 * Getting vendor data by vendor unique ID
 */
function vendor_data($rocvendorid, $mode = 'mini') {
	if($mode == 'full') {
		$sql = "SELECT rocvendorid as vid, rocvendorname as name, rocvendorcontactperson as contactperson, rocvendornumber1 as number1, rocvendornumber2 as number2, rocvendoraddress as address, rocvendoremail as email, rocvendorexp as exp, rocvendornocif as nocif, rocvendorfname as fname, rocvendorfemail as femail, rocvendorslocation as slocation, rocvendortlproof as tlproof, rocvendortcards as tcards, rocvendortarrif as tarrif, rocvendorlandline as landline FROM rocvendors WHERE  rocvendorid = :rocvendorid";
	}
	else {
		$sql = "SELECT rocvendorid as vid, rocvendorname as name, rocvendoraddress as address, rocvendoremail as email, rocvendornumber1 as number1, rocvendornumber2 as number2, rocvendorusername as username, rocvendorcontactperson as contactperson, rocvendorlogo as logo FROM rocvendors WHERE  rocvendorid = :rocvendorid";
	}
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $rocvendorid);
		$stmt->execute();		
		$vendor_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		return json_encode($vendor_data[0]);
		
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"message":"'. $e->getMessage() .'"}}'; 
	}
}

/*
 * Vendor update details 
 */
function vendor_updatedetails($vendorid, $updateDetails) {
	// if(!vendor_signUpCheck($signUpData)) {
		$updateDetails = json_decode($updateDetails);
		$sql = "UPDATE rocvendors SET rocvendorname = :rocvendorname, rocvendorcontactperson = :rocvendorcontactperson, rocvendornumber1 = :rocvendornumber1, rocvendornumber2 = :rocvendornumber2, rocvendoraddress = :rocvendoraddress, rocvendorexp = :rocvendorexp,  rocvendornocif = :rocvendornocif, rocvendorfname = :rocvendorfname, rocvendorfemail = :rocvendorfemail, rocvendorslocation = :rocvendorslocation, rocvendortlproof = :rocvendortlproof, rocvendortcards =:rocvendortcards, rocvendortarrif = :rocvendortarrif, rocvendorlandline = :rocvendorlandline WHERE rocvendorid = :rocvendorid";
		try {
			$db = getDB();
			$stmt = $db->prepare($sql);  
			$stmt->bindParam(":rocvendorname", $updateDetails->name);
			$stmt->bindParam(":rocvendorcontactperson", $updateDetails->contactperson);
			$stmt->bindParam(":rocvendornumber1", $updateDetails->number1);
			$stmt->bindParam(":rocvendornumber2", $updateDetails->number2);
			$stmt->bindParam(":rocvendoraddress", $updateDetails->address);
			$stmt->bindParam(":rocvendorexp", $updateDetails->exp);
			$stmt->bindParam(":rocvendornocif", $updateDetails->nocif);
			$stmt->bindParam(":rocvendorfname", $updateDetails->fname);
			$stmt->bindParam(":rocvendorfemail", $updateDetails->femail);
			$stmt->bindParam(":rocvendorslocation", $updateDetails->slocation);
			$stmt->bindParam(":rocvendortlproof", $updateDetails->tlproof);
			$stmt->bindParam(":rocvendortcards", $updateDetails->tcards);
			$stmt->bindParam(":rocvendortarrif", $updateDetails->tarrif);
			$stmt->bindParam(":rocvendorlandline", $updateDetails->landline);
			$stmt->bindParam(":rocvendorid", $vendorid);

			$stmt->execute();
			$db = null;
			return vendor_data($vendorid, 'full');
		} catch(PDOException $e) {
			//error_log($e->getMessage(), 3, '/var/tmp/php.log');
			return '{"error":{"text":"'. $e->getMessage() .'"}}'; 
		}
	// }
	// else {
	// 	$status_data = array("error" => "duplicate", "erro_description" => "This email already exists");
	// 	return json_encode($status_data);
	// }
}

/*
 * Vendor forgot password by user email and return status
 */
function vendor_forgotpassword($app, $rocvendor) {
	$rocvendor = json_decode($rocvendor);
	$sql = "SELECT rocvendorpassword FROM rocvendors WHERE rocvendoremail = :rocvendoremail";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->bindParam(":rocvendoremail", $rocvendor->email);
		$stmt->execute();
		$vendor_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		if(count($vendor_data)) {
			$msg  = 'Hi, <br> your password = ' . $vendor_data[0]->rocvendorpassword;
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
 * Vendor change password by user id and return status
 */
function vendor_changepassword($passwordData, $rocvendorid) {
	$passwordData = json_decode($passwordData);
	$sql = "SELECT rocvendorpassword FROM rocvendors WHERE rocvendorid = :rocvendorid";
	// $sql = "UPDATE rocvendors SET rocvendorpassword = :rocvendorpassword WHERE rocvendorid = :rocvendorid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);  
		// $stmt->bindParam(":rocvendorpassword", $passwordData->password);
		$stmt->bindParam(":rocvendorid", $rocvendorid);
		$stmt->execute();
		$vendor_data = $stmt->fetch(PDO::FETCH_OBJ);
		$db = null;

		if(count($vendor_data)) {
			if($vendor_data->rocvendorpassword == $passwordData->opassword) {
				$sql = "UPDATE rocvendors SET rocvendorpassword = :rocvendorpassword WHERE rocvendorid = :rocvendorid";
				$db = getDB();
				$stmt = $db->prepare($sql);  
				$stmt->bindParam(":rocvendorpassword", $passwordData->password);
				$stmt->bindParam(":rocvendorid", $rocvendorid);
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
 * insert vendor services
 */
function insert_vendorservices($vendorservices) {
	$vendorservices = json_decode($vendorservices);
	$vendor_id = $vendorservices->vid;
	$services = $vendorservices->services;
	foreach($services as $service) {
		$error = FALSE;
		// checking cab type is empty or not 
		if(isset($service->cabtype)) {
			if(empty($service->cabtype)) {
				$error = TRUE;
			}
		}
		else {
			$error = TRUE;
		}
		// checking cab model is empty or not 
		if(isset($service->cabmodel)) {
			if(empty($service->cabmodel)) {
				$error = TRUE;
			}
		}
		else {
			$error = TRUE;
		}

		// Checking is validation errors there
		if(!$error) {
			$sql = "INSERT INTO rocvendorcabmodel(rocvendorcabtype, rocvendorcabmodel, rocvendorid) VALUES(:rocvendorcabtype, :rocvendorcabmodel, :rocvendorid)";
			try {
				$db = getDB();
				$stmt = $db->prepare($sql); 
				$stmt->bindParam("rocvendorcabtype", $service->cabtype);
				$stmt->bindParam("rocvendorcabmodel", $service->cabmodel);
				$stmt->bindParam("rocvendorid", $vendor_id);
				$stmt->execute();
				$db = null;
			} catch(PDOException $e) {
				//error_log($e->getMessage(), 3, '/var/tmp/php.log');
				return '{"error":{"text":"'. $e->getMessage() .'""}}'; 
				//break;
			}
		}
	}
	$status_data = array("result" => "success", "message" => "Successfully updated");
	return json_encode($status_data);
}

function vendor_cabmodel_data($vendor_id) {
	$sql = "SELECT rocvendorcabmodelid as vcmid, rocvendorcabmodel as vcm FROM rocvendorcabmodel WHERE  rocvendorid = :rocvendorid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $vendor_id);
		$stmt->execute();		
		$vendor_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($vendor_data);
		if($count) {
			$vendor_data = array("total" => $count, "results" => $vendor_data);
			return json_encode($vendor_data);
		}
		else {
			$vendor_data = array("total" => 0, "results" => array());
			return json_encode($vendor_data);
		}
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"message":"'. $e->getMessage() .'"}}'; 
	}
}

/*
 * insert vendor services
 */
function insert_vendorprices($vendorprices) {
	$vendorprices = json_decode($vendorprices);
	$vendor_id = $vendorprices->vid;
	$prices = $vendorprices->prices;
	foreach($prices as $price) {
		$error = FALSE;
		
		// checking cab type id is empty or not 
		if(isset($price->ctype)) {
			if(empty($price->ctype)) {
				$error = TRUE;
			}
		}
		else {
			$error = TRUE;
		}

		// checking cab model id is empty or not 
		if(isset($price->vcmid)) {
			if(empty($price->vcmid)) {
				$error = TRUE;
			}
		}
		else {
			$error = TRUE;
		}
		// checking charge per km is empty or not 
		if(isset($price->cpkm)) {
			if(empty($price->cpkm)) {
				$error = TRUE;
			}
		}
		else {
			$error = TRUE;
		}
		// checking cab service id is empty or not 
		if(isset($price->csid)) {
			if(empty($price->csid)) {
				$error = TRUE;
			}
		}
		else {
			$error = TRUE;
		}

		// Checking is validation errors there
		if(!$error) {
			$sql = "INSERT INTO rocvendorcharges(roccabtype, roccabmodelid, rocchargeperkm, rocchargeunitsperhour, roccabservicesid, rocvendorid) VALUES(:roccabtype, :roccabmodelid, :rocchargeperkm, :rocchargeunitsperhour, :roccabservicesid, :rocvendorid)";
			try {
				$db = getDB();
				$stmt = $db->prepare($sql); 
				$stmt->bindParam("roccabtype", $price->ctype);
				$stmt->bindParam("roccabmodelid", $price->vcmid);
				$stmt->bindParam("rocchargeperkm", $price->cpkm);
				$stmt->bindParam("rocchargeunitsperhour", $price->cunitsph);
				$stmt->bindParam("roccabservicesid", $price->csid);
				$stmt->bindParam("rocvendorid", $vendor_id);
				$stmt->execute();
				$db = null;
			} catch(PDOException $e) {
				//error_log($e->getMessage(), 3, '/var/tmp/php.log');
				return '{"error":{"text":"'. $e->getMessage() .'""}}'; 
				//break;
			}
		}
	}
	$status_data = array("result" => "success", "message" => "Successfully updated");
	return json_encode($status_data);
}

/*
 * update vendor service prices
 */
function update_vendorprices($app, $request_data) {
	if(!isJson($request_data)) {
		$response = array(
			'error' => 'Invalid JSON',
			'error_description' => 'Invalid JSON'
		);
		$app->response->setStatus(400);
		echo json_encode($response);
	}
	else {
		$request_data = json_decode($request_data);
		$fields = array(); // error fields array creation
		$error = FALSE; // validation error checking variable
		// checking vendor id is empty or not 
		if(isset($request_data->vid)) {
			if(!v::string()->notEmpty()->validate($request_data->vid)) {
				$fields['vid'] = "Vendor id should not be empty";
				$error = TRUE;
			}
		}
		else {
			$fields['vid'] = "Vendor id required";
			$error = TRUE;
		}
		// checking prices is empty or not 
		if(empty($request_data->prices)) {
			$fields['prices'] = "prices required";
			$error = TRUE;
		}

		// Checking is validation errors there
		if($error) {
			// If any validation errors
			$response = array(
				'error' => 'validation',
				'fields' => $fields
			);
			$app->response->setStatus(400);
			echo json_encode($response);
		}
		else {
			$vendor_id = $request_data->vid;
			$prices = $request_data->prices;
			foreach($prices as $price) {
				$error = FALSE;
				
				// checking charge id is empty or not 
				if(isset($price->vcid)) {
					if(empty($price->vcid)) {
						$error = TRUE;
					}
				}
				else {
					$error = TRUE;
				}

				// checking cab type id is empty or not 
				if(isset($price->ctype)) {
					if(empty($price->ctype)) {
						$error = TRUE;
					}
				}
				else {
					$error = TRUE;
				}

				// checking cab model id is empty or not 
				if(isset($price->vcmid)) {
					if(empty($price->vcmid)) {
						$error = TRUE;
					}
				}
				else {
					$error = TRUE;
				}
				// checking charge per km is empty or not 
				if(isset($price->cpkm)) {
					if(empty($price->cpkm)) {
						$error = TRUE;
					}
				}
				else {
					$error = TRUE;
				}
				// checking cab service id is empty or not 
				if(isset($price->csid)) {
					if(empty($price->csid)) {
						$error = TRUE;
					}
				}
				else {
					$error = TRUE;
				}

				// Checking is validation errors there
				if(!$error) {
					$sql = "UPDATE rocvendorcharges SET roccabtype = :roccabtype, roccabmodelid = :roccabmodelid, rocchargeperkm = :rocchargeperkm, rocchargeunitsperhour = :rocchargeunitsperhour, roccabservicesid = :roccabservicesid WHERE rocvendorid = :rocvendorid AND rocvendorchargeid = :rocvendorchargeid";
					try {
						$db = getDB();
						$stmt = $db->prepare($sql); 
						$stmt->bindParam("roccabtype", $price->ctype);
						$stmt->bindParam("roccabmodelid", $price->vcmid);
						$stmt->bindParam("rocchargeperkm", $price->cpkm);
						$stmt->bindParam("rocchargeunitsperhour", $price->cunitsph);
						$stmt->bindParam("roccabservicesid", $price->csid);
						$stmt->bindParam("rocvendorchargeid", $price->vcid);
						$stmt->bindParam("rocvendorid", $vendor_id);
						$stmt->execute();
						$db = null;
						$status_data = array("result" => "success", "message" => "Successfully updated");
						echo json_encode($status_data);
						$app->response->setStatus(200);
					} catch(PDOException $e) {
						//error_log($e->getMessage(), 3, '/var/tmp/php.log');
						echo '{"error":{"text":"'. $e->getMessage() .'""}}'; 
						$app->response->setStatus(500);
						//break;
					}
				}
			}
		}
	}
}

/*
 * get vendor terms and conditions by vendor id
 */
function get_vendorterms($vendorid) {
	$sql = "SELECT rocvendortermsid as vtid, roccabmodelid as cabmodel, rocvendorterms as terms FROM rocvendorterms WHERE rocvendorid = :rocvendorid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $vendorid);
		$stmt->execute();
		$terms_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		return json_encode($terms_data);
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":"'. $e->getMessage() .'""}}'; 
		//break;
	}
}

/*
 * insert vendor terms and conditions
 */
function insert_vendorterms($vendorterms) {
	$vendorterms = json_decode($vendorterms);
	$vendor_id = $vendorterms->vid;
	$cabmodel = $vendorterms->cabmodel;
	$content = $vendorterms->content;
	$sql = "INSERT INTO rocvendorterms(rocvendorid, roccabmodelid, rocvendorterms) VALUES(:rocvendorid, :roccabmodelid, :rocvendorterms)";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $vendor_id);
		$stmt->bindParam("roccabmodelid", $cabmodel);
		$stmt->bindParam("rocvendorterms", $content);
		$stmt->execute();
		$db = null;
		$status_data = array("result" => "success", "message" => "Successfully inserted");
		return json_encode($status_data);
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":"'. $e->getMessage() .'""}}'; 
		//break;
	}
}

/*
 * update vendor terms and conditions
 */
function update_vendorterms($vendorterms) {
	$vendorterms = json_decode($vendorterms);
	$vendor_id = $vendorterms->vid;
	$term_id = $vendorterms->termid;
	$cabmodel = $vendorterms->cabmodel;
	$content = $vendorterms->content;
	$sql = "UPDATE rocvendorterms SET roccabmodelid =:roccabmodelid, rocvendorterms = :rocvendorterms WHERE rocvendorid = :rocvendorid AND rocvendortermsid = :rocvendortermsid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $vendor_id);
		$stmt->bindParam("rocvendortermsid", $term_id);
		$stmt->bindParam("roccabmodelid", $cabmodel);
		$stmt->bindParam("rocvendorterms", $content);
		$stmt->execute();
		$db = null;
		$status_data = array("result" => "success", "message" => "Successfully updated");
		return json_encode($status_data);
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"text":"'. $e->getMessage() .'""}}'; 
		//break;
	}
}

/*
 * Getting cab services data
 */
function cabservices_data($app) {
	$sql = "SELECT roccabservicesid as sid, roccabservices as service FROM roccabservices";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->execute();		
		$services_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($services_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}

/*
 * Getting cab type data
 */
function cabtypes_data($app) {
	$sql = "SELECT roccabtypeid as ctid, roccabtype as ctype FROM roccabtypes";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->execute();		
		$services_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($services_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}

/*
 * Getting cab models data
 */
function cabmodels_data($app) {
	echo $roccabmodelid;
	$sql = "SELECT DISTINCT(roccabmodelid) as cabmodel FROM rocvendorcharges";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->execute();		
		$models_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$models_data = array('total' => count($models_data), 'result' => $models_data);
		echo json_encode($models_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
		$app->response->setStatus(500);
	}
}

/*
 * Getting all services by vendor for vendor manage services
 */
function vendor_services($vendorid) {
	$sql = "SELECT 
	vc.rocvendorchargeid as vcid, 
	vc.roccabtype as vctype, 
	ct.roccabtype as cabtype, 
	vc.roccabmodelid as vcmid, 
	vc.rocchargeperkm as cpkm, 
	vc.rocchargeunitsperhour as cunitsph, 
	vc.roccabservicesid as csid, 
	cs.roccabservices as cabservice 
	FROM rocvendorcharges vc, roccabtypes ct, roccabservices cs WHERE 
	vc.rocvendorid = :rocvendorid AND 
	vc.roccabtype = ct.roccabtypeid AND 
	vc.roccabservicesid = cs.roccabservicesid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("rocvendorid", $vendorid);
		$stmt->execute();		
		$bookings_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($bookings_data);
		if($count) {
			$bookings_data = array("total" => $count, "results" => $bookings_data);
			return json_encode($bookings_data);
		}
		else {
			$bookings_data = array("total" => 0, "results" => array());
			return json_encode($bookings_data);
		}
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"message":"'. $e->getMessage() .'"}}'; 
	}
}

/*
 * Delete vendor services by vendorid and chargeid
 */
function vendor_prices_delete($app, $rocvendorid = 0, $vcid = 0) {
	$sql = "DELETE FROM rocvendorcharges WHERE  rocvendorid = :rocvendorid AND rocvendorchargeid = :rocvendorchargeid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $rocvendorid);
		$stmt->bindParam("rocvendorchargeid", $vcid);
		$stmt->execute();		
		$db = null;
		$status_data = array("result" => "success", "message" => "Vendor service successfully Deleted");
		echo json_encode($status_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}';
		$app->response->setStatus(500);
	}
}

/*
 * Delete vendor by vendorid
 */
function vendor_delete($app, $rocvendorid = 0) {
	$sql = "DELETE FROM rocvendors WHERE  rocvendorid = :rocvendorid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $rocvendorid);
		$stmt->execute();		
		$db = null;
		$status_data = array("result" => "success", "message" => "Vendor successfully Deleted");
		echo json_encode($status_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}';
		$app->response->setStatus(500);
	}
}

/*
 * Delete vendor terms by vendorid and termid
 */
function terms_delete($app, $vendorid = 0, $termid = 0) {
	$sql = "DELETE FROM rocvendorterms WHERE  rocvendorid = :rocvendorid AND rocvendortermsid = :rocvendortermsid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->bindParam("rocvendorid", $vendorid);
		$stmt->bindParam("rocvendortermsid", $termid);
		$stmt->execute();		
		$db = null;
		$status_data = array("result" => "success", "message" => "Vendor successfully Deleted");
		echo json_encode($status_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		return '{"error":{"message":"'. $e->getMessage() .'"}}';
		$app->response->setStatus(500);
	}
}


/*
 * Get List of bookings by vendor id
 */
function vendor_bookings_list($app, $vendorid) {
	$sql = "SELECT bi.rocbookinginfoid as bid, bi.roctransactionid as transid, bi.rocservicetype as serviceid, cs.roccabservices as servicetype, bi.rocservicename as servicename, bi.rocservicechargeperkm scpkm, bi.rocservicekm as servicekm, bi.rocservicestimatedrs as sers, bi.rocbookingfromlocation bfl, bi.rocbookingtolocation as btl, bi.rocserviceclass as sc, bi.rocuserid as uid, bi.rocvendorid as vid, bi.rocbookingdatetime as bdatetime, bi.rocbookingstatus bstatus FROM rocbookinginfo bi, roccabservices cs WHERE bi.rocservicetype = cs.roccabservicesid AND bi.rocvendorid = :rocvendorid";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->bindParam(":rocvendorid", $vendorid);
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

function vendor_terms($app) {
	$sql = "SELECT rocvendortermsid as vtid, rocvendorid as vid, roccabmodelid as cabmodel, rocvendorterms as terms FROM rocvendorterms";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql); 
		$stmt->execute();
		$terms_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($terms_data);
		$app->response->setStatus(200);
	} catch(PDOException $e) {
		//error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"text":"'. $e->getMessage() .'""}}'; 
		//break;
		$app->response->setStatus(500);
	}
}
?>