<?php
include 'db.php';
include 'user.php';
include 'vendor.php';
include 'admin.php';

// SMTP mail integration
include 'mail.php';

// SMS integration
include 'sms.php';

/**
 * Step 1: Require the Slim Framework
 *
 * If you are not using Composer, you need to require the
 * Slim Framework and register its PSR-0 autoloader.
 *
 * If you are using Composer, you can skip this step.
 */
require 'Slim/Slim.php';
use Respect\Validation\Validator as v;

\Slim\Slim::registerAutoloader();

/**
 * Step 2: Instantiate a Slim application
 *
 * This example instantiates a Slim application using
 * its default settings. However, you will usually configure
 * your Slim application now by passing an associative array
 * of setting names and values into the application constructor.
 */
$app = new \Slim\Slim();

// Get request object
$req = $app->request;
session_start();
//Get base URI
$_SESSION['baseUrl'] = $req->getUrl()."/rideoncabservice/";


$app->response->headers->set('Access-Control-Allow-Origin', '*');
$app->response->headers->set('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
$app->response->headers->set('Access-Control-Allow-Headers', 'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version');

/**
 * Step 3: Define the Slim application routes
 *
 * Here we define several Slim application routes that respond
 * to appropriate HTTP request methods. In this example, the second
 * argument for `Slim::get`, `Slim::post`, `Slim::put`, `Slim::patch`, and `Slim::delete`
 * is an anonymous function.
 */

// GET user details by userid route
$app->get(
	'/user/:rocuserid',
	function ($rocuserid) use ($app) {
		$response_data = user_data($rocuserid);
    // checking is user id available or not
		if($response_data == '[]') {
    	// if user not aavailable with rocuserid throw 404
			$app->response->setStatus(404);
		}
		else {
    	// if user available throw user data
			$json_data = json_decode($response_data);
    	$user_data = $json_data[0];	// swapping first array object
    	echo json_encode($user_data);
    }
}
);

// Delete User by userid route
$app->delete(
	'/user/:rocuserid',
	function ($rocuserid) use ($app) {
		user_delete($app, $rocuserid);
	}
	);

// GET user signup email confirmation with hash code
$app->get(
	'/user/signup/confirmation/:email/:hash',
	function ($email, $hash) use ($app) {
		$response_data = user_signup_confirmation($app, $email, $hash);
	}
	);


// User signUp route
$app->post(
	'/user/signup',
	function () use ($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking first name is empty or not 
			if(isset($request_data->fname)) {
				if(!v::string()->notEmpty()->validate($request_data->fname)) {
					$fields['fname'] = "First name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['fname'] = "First required";
				$error = TRUE;
			}
			// checking first name is empty or not
			if(isset($request_data->lname)) {
				if(!v::string()->notEmpty()->validate($request_data->lname)) {
					$fields['lname'] = "Last name should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['lname'] = "Last required";
				$error = TRUE;
			}
			// checking email is empty or not
			if(isset($request_data->email)) {
				if(!v::string()->notEmpty()->validate($request_data->email)) {
					$fields['email'] = "Email should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['email'] = "Email required";
				$error = TRUE;
			}
			// checking city is empty or not
			if(isset($request_data->city)) {
				/*if(!v::string()->notEmpty()->validate($request_data->city)) {
					$fields['city'] = "City should not be empty";
					$error = TRUE;
				}*/
			} else {
				$fields['city'] = "City required";
				$error = TRUE;
			}
			// checking state is empty or not
			if(isset($request_data->state)) {
				/*if(!v::string()->notEmpty()->validate($request_data->state)) {
					$fields['state'] = "State should not be empty";
					$error = TRUE;
				}*/
			} else {
				$fields['state'] = "State required";
				$error = TRUE;
			}
			// checking mobile is empty or not
			if(isset($request_data->mobile)) {
				if(!v::string()->notEmpty()->validate($request_data->mobile)) {
					$fields['mobile'] = "Mobile should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['mobile'] = "Mobile required";
				$error = TRUE;
			}
			// checking password is empty or not
			if(isset($request_data->password)) {
				if(!v::string()->notEmpty()->validate($request_data->password)) {
					$fields['password'] = "Password should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['password'] = "Password required";
				$error = TRUE;
			}
			// Checking is validation there
			if($error) {
				$response = array(
					'error' => 'validation',
					'fields' => $fields
					);
				$app->response->setStatus(400);
				echo json_encode($response);
			}
			else {
				// If no validation errors
				$response_data = user_signUp($request->getBody());
				$response_json_data = json_decode($response_data);
				// checking is user successfully created or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					$app->response->setStatus(201);
					$json_data = json_decode($response_data);
		    	$user_data = $json_data[0];	// swapping first array object
		    	echo json_encode($user_data);
		    }
		}
	}
}
);

// User register while book cab route
$app->post(
	'/user/register',
	function () use ($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking first name is empty or not 
			if(isset($request_data->fname)) {
				if(!v::string()->notEmpty()->validate($request_data->fname)) {
					$fields['fname'] = "First name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['fname'] = "First required";
				$error = TRUE;
			}
			// checking first name is empty or not
			if(isset($request_data->lname)) {
				if(!v::string()->notEmpty()->validate($request_data->lname)) {
					$fields['lname'] = "Last name should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['lname'] = "Last required";
				$error = TRUE;
			}
			// checking mobile is empty or not
			if(isset($request_data->mobile)) {
				if(!v::string()->notEmpty()->validate($request_data->mobile)) {
					$fields['mobile'] = "Mobile should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['mobile'] = "Mobile required";
				$error = TRUE;
			}
			// checking email is empty or not
			if(isset($request_data->email)) {
				if(!v::string()->notEmpty()->validate($request_data->email)) {
					$fields['email'] = "Email should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['email'] = "Email required";
				$error = TRUE;
			}
			// checking Address1 is empty or not
			if(isset($request_data->address1)) {
				if(!v::string()->notEmpty()->validate($request_data->address1)) {
					$fields['address1'] = "Address1 should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['address1'] = "Address1 required";
				$error = TRUE;
			}
			// checking Address2 is empty or not
			if(isset($request_data->address2)) {
				/*if(!v::string()->notEmpty()->validate($request_data->address2)) {
					$fields['address2'] = "Address2 should not be empty";
					$error = TRUE;
				}*/
			} else {
				/*$fields['address2'] = "Address2 required";
				$error = TRUE;*/
			}
			// checking city is empty or not
			if(isset($request_data->city)) {
				/*if(!v::string()->notEmpty()->validate($request_data->city)) {
					$fields['city'] = "City should not be empty";
					$error = TRUE;
				}*/
			} else {
				$fields['city'] = "City required";
				$error = TRUE;
			}
			// checking state is empty or not
			if(isset($request_data->state)) {
				/*if(!v::string()->notEmpty()->validate($request_data->state)) {
					$fields['state'] = "State should not be empty";
					$error = TRUE;
				}*/
			} else {
				$fields['state'] = "State required";
				$error = TRUE;
			}
			
			// checking pincode is empty or not
			if(isset($request_data->pincode)) {
				if(!v::string()->notEmpty()->validate($request_data->pincode)) {
					$fields['pincode'] = "pincode should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['pincode'] = "pincode required";
				$error = TRUE;
			}
			// Checking is validation there
			if($error) {
				$response = array(
					'error' => 'validation',
					'fields' => $fields
					);
				$app->response->setStatus(400);
				echo json_encode($response);
			}
			else {
				// If no validation errors
				$response_data = user_register($app, $request->getBody());
				$response_json_data = json_decode($response_data);
				// checking is user successfully created or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					$app->response->setStatus(201);
					$json_data = json_decode($response_data);
		    	$user_data = $json_data[0];	// swapping first array object
		    	echo json_encode($user_data);
		    }
		}
	}
}
);

// User Login route
$app->post(
	'/user/login',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking username is empty or not 
			if(isset($request_data->username)) {
				if(!v::string()->notEmpty()->validate($request_data->username)) {
					$fields['username'] = "Username should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['username'] = "username required";
				$error = TRUE;
			}
			// checking password is empty or not 
			if(isset($request_data->password)) {
				if(!v::string()->notEmpty()->validate($request_data->password)) {
					$fields['password'] = "Password should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['password'] = "password required";
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
				// If no validation errors
				$response_data = user_login($request->getBody());
				$response_json_data = json_decode($response_data);
				// checking is user successfully logggedin or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(401);
					echo $response_data;
				}
				else {
					//$json_data = json_decode($response_data);
    			$user_data = $response_json_data[0];	// swapping first array object
    			echo json_encode($user_data);
    		}
    	}
    }
}
);

// User forgot password route
$app->post(
	'/user/forgotpassword',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking email is empty or not 
			if(isset($request_data->email)) {
				if(!v::string()->notEmpty()->validate($request_data->email)) {
					$fields['email'] = "Email should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['email'] = "Email required";
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
				// If no validation errors
				user_forgotpassword($app, $request->getBody());
			}
		}
	}
	);

// User update details route
$app->put(
	'/user/updatedetails/:userid',
	function ($userid) use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking fname is empty or not 
			if(isset($request_data->fname)) {
				if(!v::string()->notEmpty()->validate($request_data->fname)) {
					$fields['fname'] = "First Name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['fname'] = "First Name required";
				$error = TRUE;
			}
			// checking last name is empty or not 
			if(isset($request_data->lname)) {
				if(!v::string()->notEmpty()->validate($request_data->lname)) {
					$fields['lname'] = "Last Name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['lname'] = "Last Name  required";
				$error = TRUE;
			}
			// checking address1 is empty or not 
			if(isset($request_data->address1)) {
				if(!v::string()->notEmpty()->validate($request_data->address1)) {
					$fields['address1'] = "Address1 should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['address1'] = "Address1 required";
				$error = TRUE;
			}
			// checking address2 is empty or not 
			if(isset($request_data->address2)) {
				if(!v::string()->notEmpty()->validate($request_data->address2)) {
					$fields['address2'] = "Address2 should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['address2'] = "Address2 required";
				$error = TRUE;
			}
			// checking city is empty or not 
			if(isset($request_data->city)) {
				if(!v::string()->notEmpty()->validate($request_data->city)) {
					$fields['city'] = "City should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['city'] = "City required";
				$error = TRUE;
			}
			// checking state is empty or not 
			if(isset($request_data->state)) {
				if(!v::string()->notEmpty()->validate($request_data->state)) {
					$fields['state'] = "State should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['state'] = "State required";
				$error = TRUE;
			}
			// checking pincode is empty or not 
			if(isset($request_data->pincode)) {
				if(!v::string()->notEmpty()->validate($request_data->pincode)) {
					$fields['pincode'] = "Pincode should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['pincode'] = "Pincode required";
				$error = TRUE;
			}
			// checking mobile  is empty or not 
			if(isset($request_data->mobile)) {
				if(!v::string()->notEmpty()->validate($request_data->mobile)) {
					$fields['mobile'] = "Mobile should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['mobile'] = "Mobile required";
				$error = TRUE;
			}
			
			// Checking is validation there
			if($error) {
				$response = array(
					'error' => 'validation',
					'fields' => $fields
					);
				$app->response->setStatus(400);
				echo json_encode($response);
			}
			else {
				// If no validation errors
				$response_data = user_updatedetails($userid, $request->getBody());
				$response_json_data = json_decode($response_data);
				// checking is vendor successfully updated or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					$app->response->setStatus(200);
					echo $response_data;
				}
			}
		}
	}
	);

// User Login route
$app->put(
	'/user/changepassword/:rocuserid',
	function ($rocuserid) use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking password is empty or not 
			if(isset($request_data->password)) {
				if(!v::string()->notEmpty()->validate($request_data->password)) {
					$fields['password'] = "Password should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['password'] = "password required";
				$error = TRUE;
			}

			// checking old password is empty or not 
			if(isset($request_data->opassword)) {
				if(!v::string()->notEmpty()->validate($request_data->opassword)) {
					$fields['opassword'] = "Old password should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['opassword'] = "Old password required";
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
				// If no validation errors
				$response_data = user_changepassword($request->getBody(), $rocuserid);
				$response_json_data = json_decode($response_data);
				// checking is user password successfully changed or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(401);
					echo $response_data;
				}
				else {
					echo $response_data;
				}
			}
		}
	}
	);

// List of Vendor SEARCH RESULT  route
$app->post(
	'/search',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking cab type is empty or not 
			/*if(isset($request_data->cabtype)) {
				if(!v::string()->notEmpty()->validate($request_data->cabtype)) {
					$fields['cabtype'] = "Cab type should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabtype'] = "Cab type required";
				$error = TRUE;
			}*/
			// checking service type is empty or not 
			if(isset($request_data->servicetype)) {
				if(!v::string()->notEmpty()->validate($request_data->servicetype)) {
					$fields['servicetype'] = "Service type should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['servicetype'] = "Service type required";
				$error = TRUE;
			}

			// checking user location is empty or not 
			if(isset($request_data->base_loc)) {
				if(!v::string()->notEmpty()->validate($request_data->base_loc)) {
					$fields['servicetype'] = "base location should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['base_loc'] = "base location required";
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
				// If no validation errors
				echo search($request->getBody());
			}
		}
	}
	);

// Cab Booking route
$app->post(
	'/bookcab',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking service type is empty or not 
			if(isset($request_data->servicetype)) {
				if(!v::string()->notEmpty()->validate($request_data->servicetype)) {
					$fields['servicetype'] = "Service type should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['servicetype'] = "Service type required";
				$error = TRUE;
			}
			// checking service name is empty or not 
			if(isset($request_data->servicename)) {
				if(!v::string()->notEmpty()->validate($request_data->servicename)) {
					$fields['servicename'] = "Service name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['servicename'] = "Service name required";
				$error = TRUE;
			}
			// checking service charge per km is empty or not 
			if(isset($request_data->servicechargeperkm)) {
				if(!v::string()->notEmpty()->validate($request_data->servicechargeperkm)) {
					$fields['servicechargeperkm'] = "Service charge per km should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['servicechargeperkm'] = "Service charge per km required";
				$error = TRUE;
			}
			// checking service km is empty or not 
			if(isset($request_data->servicekm)) {
				if(!v::string()->notEmpty()->validate($request_data->servicekm)) {
					$fields['servicekm'] = "Service km should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['servicekm'] = "Service km required";
				$error = TRUE;
			}
			// checking service estimated rs is empty or not 
			if(isset($request_data->servicestimatedrs)) {
				if(!v::string()->notEmpty()->validate($request_data->servicestimatedrs)) {
					$fields['servicestimatedrs'] = "Service estimated rs should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['servicestimatedrs'] = "Service estimated rs required";
				$error = TRUE;
			}
			// checking booking from location is empty or not 
			if(isset($request_data->bookingfromlocation)) {
				if(!v::string()->notEmpty()->validate($request_data->bookingfromlocation)) {
					$fields['bookingfromlocation'] = "Booking from location should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['bookingfromlocation'] = "Booking from location required";
				$error = TRUE;
			}
			// checking booking to location is empty or not 
			if(isset($request_data->bookingtolocation)) {
				if(!v::string()->notEmpty()->validate($request_data->bookingtolocation)) {
					$fields['bookingtolocation'] = "Booking to location should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['bookingtolocation'] = "Booking to location required";
				$error = TRUE;
			}
			// checking service class is empty or not 
			if(isset($request_data->serviceclass)) {
				if(!v::string()->notEmpty()->validate($request_data->serviceclass)) {
					$fields['serviceclass'] = "Service class should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['serviceclass'] = "Service class required";
				$error = TRUE;
			}
			// checking user id is empty or not 
			if(isset($request_data->userid)) {
				if(!v::string()->notEmpty()->validate($request_data->userid)) {
					$fields['userid'] = "User id should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['userid'] = "User id required";
				$error = TRUE;
			}
			// checking booking date time is empty or not 
			if(isset($request_data->bookingdatetime)) {
				if(!v::string()->notEmpty()->validate($request_data->bookingdatetime)) {
					$fields['bookingdatetime'] = "Booking datetime should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['bookingdatetime'] = "Booking datetime required";
				$error = TRUE;
			}
			// checking vendor id is empty or not 
			if(isset($request_data->vendorid)) {
				if(!v::string()->notEmpty()->validate($request_data->vendorid)) {
					$fields['vendorid'] = "Vendor id should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['vendorid'] = "Vendor id required";
				$error = TRUE;
			}
			// checking booking status is empty or not 
			if(isset($request_data->bookingstatus)) {
				if(!v::string()->notEmpty()->validate($request_data->bookingstatus)) {
					$fields['bookingstatus'] = "Booking status should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['bookingstatus'] = "Booking status required";
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
				// If no validation errors
				bookCab($app, $request->getBody());
				/*$response_json_data = json_decode($response_data);
				// checking is cab successfully booked or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					// book cab and throw booking id
					$app->response->setStatus(201);
					echo $response_data;
				}*/
			}
		}
	}
	);


// Cab Booking confirmation route
$app->post(
	'/bookconf',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking booking id is empty or not 
			if(isset($request_data->bookingid)) {
				if(!v::string()->notEmpty()->validate($request_data->bookingid)) {
					$fields['bookingid'] = "Booking ID should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['bookingid'] = "Booking ID required";
				$error = TRUE;
			}
			// checking cab reg no is empty or not 
			if(isset($request_data->cabregno)) {
				if(!v::string()->notEmpty()->validate($request_data->cabregno)) {
					$fields['cabregno'] = "Cab Reg no should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabregno'] = "Cab Reg no required";
				$error = TRUE;
			}
			// checking driver name is empty or not 
			if(isset($request_data->drivername)) {
				if(!v::string()->notEmpty()->validate($request_data->drivername)) {
					$fields['drivername'] = "Driver name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['drivername'] = "Driver name required";
				$error = TRUE;
			}
			// checking driver mobile is empty or not 
			if(isset($request_data->drivermobile)) {
				if(!v::string()->notEmpty()->validate($request_data->drivermobile)) {
					$fields['drivermobile'] = "Driver mobile should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['drivermobile'] = "Driver mobile required";
				$error = TRUE;
			}
			// checking booking status is empty or not 
			if(isset($request_data->bookingstatus)) {
				if(!v::string()->notEmpty()->validate($request_data->bookingstatus)) {
					$fields['bookingstatus'] = "Booking status should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['bookingstatus'] = "Booking status required";
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
				// If no validation errors
				bookConf($app, $request->getBody());
				/*$response_json_data = json_decode($response_data);
				// checking is cab successfully booked or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					// book cab and throw booking id
					$app->response->setStatus(201);
					echo $response_data;
				}*/
			}
		}
	}
	);

// Vendor signUp route
$app->post(
	'/vendor/signup',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking name is empty or not 
			if(isset($request_data->name)) {
				if(!v::string()->notEmpty()->validate($request_data->name)) {
					$fields['name'] = "Name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['name'] = "Name required";
				$error = TRUE;
			}
			// checking address is empty or not 
			if(isset($request_data->address)) {
				/*if(!v::string()->notEmpty()->validate($request_data->address)) {
					$fields['address'] = "Address should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['address'] = "Address required";
				$error = TRUE;
			}
			// checking email is empty or not 
			if(isset($request_data->email)) {
				if(!v::string()->notEmpty()->validate($request_data->email)) {
					$fields['email'] = "Email should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['email'] = "Email required";
				$error = TRUE;
			}
			// checking number1 is empty or not 
			if(isset($request_data->number1)) {
				/*if(!v::string()->notEmpty()->validate($request_data->number1)) {
					$fields['number1'] = "Number1 should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['number1'] = "Number1 required";
				$error = TRUE;
			}
			// checking number2 is empty or not 
			if(isset($request_data->number2)) {
				/*if(!v::string()->notEmpty()->validate($request_data->number2)) {
					$fields['number2'] = "Number2 should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['number2'] = "Number2 required";
				$error = TRUE;
			}
			// checking username is empty or not 
			if(isset($request_data->username)) {
				if(!v::string()->notEmpty()->validate($request_data->username)) {
					$fields['username'] = "Username should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['username'] = "Username required";
				$error = TRUE;
			}
			// checking password is empty or not 
			if(isset($request_data->password)) {
				if(!v::string()->notEmpty()->validate($request_data->password)) {
					$fields['password'] = "Password should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['password'] = "Password required";
				$error = TRUE;
			}
			// checking contact person is empty or not 
			if(isset($request_data->contactperson)) {
				/*if(!v::string()->notEmpty()->validate($request_data->contactperson)) {
					$fields['contactperson'] = "Contact person should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['contactperson'] = "Contact person required";
				$error = TRUE;
			}
			// checking logo is empty or not 
			if(isset($request_data->logo)) {
				/*if(!v::string()->notEmpty()->validate($request_data->logo)) {
					$fields['logo'] = "Logo should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['logo'] = "Logo required";
				$error = TRUE;
			}
			// checking landline is empty or not 
			if(isset($request_data->landline)) {
				/*if(!v::string()->notEmpty()->validate($request_data->logo)) {
					$fields['logo'] = "Logo should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['landline'] = "Landline required";
				$error = TRUE;
			}
			// Checking is validation there
			if($error) {
				$response = array(
					'error' => 'validation',
					'fields' => $fields
					);
				$app->response->setStatus(400);
				echo json_encode($response);
			}
			else {
				// If no validation errors
				$response_data = vendor_signUp($request->getBody());
				$response_json_data = json_decode($response_data);
				// checking is vendor successfully created or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					$app->response->setStatus(201);
					$json_data = json_decode($response_data);
		    	$user_data = $json_data[0];	// swapping first array object
		    	echo json_encode($user_data);
		    }
		}
	}
}
);

// Vendor Login route
$app->post(
	'/vendor/login',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking username is empty or not 
			if(isset($request_data->username)) {
				if(!v::string()->notEmpty()->validate($request_data->username)) {
					$fields['username'] = "Username should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['username'] = "username required";
				$error = TRUE;
			}
			// checking password is empty or not 
			if(isset($request_data->password)) {
				if(!v::string()->notEmpty()->validate($request_data->password)) {
					$fields['password'] = "Password should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['password'] = "password required";
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
				// If no validation errors
				$response_data = vendor_login($request->getBody());
				$response_json_data = json_decode($response_data);
	    	// checking is vendor successfully logggedin or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(401);
					echo $response_data;
				}
				else {
					//$json_data = json_decode($response_data);
    			$vendor_data = $response_json_data;	// swapping first array object
    			echo json_encode($vendor_data);
    		}
    	}
    }
}
);

// Delete vendor by vendorid route
$app->delete(
	'/vendor/:rocvendorid',
	function ($rocvendorid) use ($app) {
		vendor_delete($app, $rocvendrid);
	}
	);

// Vendor update details route
$app->put(
	'/vendor/updatedetails/:vendorid',
	function ($vendorid) use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking name is empty or not 
			if(isset($request_data->name)) {
				if(!v::string()->notEmpty()->validate($request_data->name)) {
					$fields['name'] = "Name should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['name'] = "Name required";
				$error = TRUE;
			}
			// checking contact person is empty or not 
			if(isset($request_data->contactperson)) {
				if(!v::string()->notEmpty()->validate($request_data->contactperson)) {
					$fields['contactperson'] = "Contact person should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['contactperson'] = "Contact person required";
				$error = TRUE;
			}
			// checking number1 is empty or not 
			if(isset($request_data->number1)) {
				if(!v::string()->notEmpty()->validate($request_data->number1)) {
					$fields['number1'] = "Number1 should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['number1'] = "Number1 required";
				$error = TRUE;
			}
			// checking number2 is empty or not 
			if(isset($request_data->number2)) {
				/*if(!v::string()->notEmpty()->validate($request_data->number2)) {
					$fields['number2'] = "Number2 should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['number2'] = "Number2 required";
				$error = TRUE;
			}
			/*// checking email is empty or not 
			if(isset($request_data->email)) {
				if(!v::string()->notEmpty()->validate($request_data->email)) {
					$fields['email'] = "Email should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['email'] = "Email required";
				$error = TRUE;
			}*/
			// checking address is empty or not 
			if(isset($request_data->address)) {
				/*if(!v::string()->notEmpty()->validate($request_data->address)) {
					$fields['address'] = "Address should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['address'] = "Address required";
				$error = TRUE;
			}
			// checking experience is empty or not 
			if(isset($request_data->exp)) {
				/*if(!v::string()->notEmpty()->validate($request_data->exp)) {
					$fields['exp'] = "Experience should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['exp'] = "Experience required";
				$error = TRUE;
			}
			// checking No of cabs in fleet is empty or not 
			if(isset($request_data->nocif)) {
				/*if(!v::string()->notEmpty()->validate($request_data->nocif)) {
					$fields['nocif'] = "No of cabs in fleet should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['nocif'] = "No of cabs in fleet required";
				$error = TRUE;
			}
			// checking Founder Name is empty or not 
			if(isset($request_data->fname)) {
				/*if(!v::string()->notEmpty()->validate($request_data->fname)) {
					$fields['fname'] = "Founder Name should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['fname'] = "Founder Name required";
				$error = TRUE;
			}
			// checking Founder Email is empty or not 
			if(isset($request_data->femail)) {
				/*if(!v::string()->notEmpty()->validate($request_data->femail)) {
					$fields['femail'] = "Founder Email should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['femail'] = "Founder Email required";
				$error = TRUE;
			}
			// checking Service Location is empty or not 
			if(isset($request_data->slocation)) {
				/*if(!v::string()->notEmpty()->validate($request_data->slocation)) {
					$fields['slocation'] = "Service Location should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['slocation'] = "Service Location required";
				$error = TRUE;
			}
			// checking City is empty or not 
			if(isset($request_data->city)) {
				/*if(!v::string()->notEmpty()->validate($request_data->slocation)) {
					$fields['slocation'] = "Service Location should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['city'] = "City required";
				$error = TRUE;
			}
			// checking State is empty or not 
			if(isset($request_data->state)) {
				/*if(!v::string()->notEmpty()->validate($request_data->slocation)) {
					$fields['slocation'] = "Service Location should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['state'] = "State required";
				$error = TRUE;
			}
			// checking pincode is empty or not 
			if(isset($request_data->pincode)) {
				/*if(!v::string()->notEmpty()->validate($request_data->slocation)) {
					$fields['slocation'] = "Service Location should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['pincode'] = "Pincode required";
				$error = TRUE;
			}
			// checking  travel licence proof is empty or not 
			if(isset($request_data->tlproof)) {
				/*if(!v::string()->notEmpty()->validate($request_data->tlproof)) {
					$fields['tlproof'] = " Travel licence proof should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['tlproof'] = "Travel licence proof required";
				$error = TRUE;
			}
			// checking  tarrif cards is empty or not 
			if(isset($request_data->tcards)) {
				/*if(!v::string()->notEmpty()->validate($request_data->tcards)) {
					$fields['tcards'] = " Tarrif cards should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['tcards'] = "Tarrif cards proof required";
				$error = TRUE;
			}
			// checking  tarrif is empty or not 
			if(isset($request_data->tarrif)) {
				/*if(!v::string()->notEmpty()->validate($request_data->tarrif)) {
					$fields['tarrif'] = " Tarrif should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['tarrif'] = "Tarrif required";
				$error = TRUE;
			}
			// checking  vendor landline number is empty or not 
			if(isset($request_data->landline)) {
				/*if(!v::string()->notEmpty()->validate($request_data->landline)) {
					$fields['tcards'] = "Landline number should not be empty";
					$error = TRUE;
				}*/
			}
			else {
				$fields['landline'] = "Landline number proof required";
				$error = TRUE;
			}
			// Checking is validation there
			if($error) {
				$response = array(
					'error' => 'validation',
					'fields' => $fields
					);
				$app->response->setStatus(400);
				echo json_encode($response);
			}
			else {
				// If no validation errors
				$response_data = vendor_updatedetails($vendorid, $request->getBody());
				$response_json_data = json_decode($response_data);
				// checking is vendor successfully updated or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					$app->response->setStatus(200);
					echo $response_data;
				}
			}
		}
	}
	);

// Vendor forgot password route
$app->post(
	'/vendor/forgotpassword',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking email is empty or not 
			if(isset($request_data->email)) {
				if(!v::string()->notEmpty()->validate($request_data->email)) {
					$fields['email'] = "Email should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['email'] = "Email required";
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
				// If no validation errors
				vendor_forgotpassword($app, $request->getBody());
			}
		}
	}
	);

// Vendor Change password route
$app->put(
	'/vendor/changepassword/:rocuserid',
	function ($rocuserid) use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking password is empty or not 
			if(isset($request_data->password)) {
				if(!v::string()->notEmpty()->validate($request_data->password)) {
					$fields['password'] = "Password should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['password'] = "password required";
				$error = TRUE;
			}

			// checking old password is empty or not 
			if(isset($request_data->opassword)) {
				if(!v::string()->notEmpty()->validate($request_data->opassword)) {
					$fields['opassword'] = "Old password should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['opassword'] = "Old password required";
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
				// If no validation errors
				$response_data = vendor_changepassword($request->getBody(), $rocuserid);
				$response_json_data = json_decode($response_data);
				// checking is user password successfully changed or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(401);
					echo $response_data;
				}
				else {
					echo $response_data;
				}
			}
		}
	}
	);

// vendor services
$app->post(
	'/vendor/services',
	function() use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking services is empty or not 
			if(empty($request_data->services)) {
				$fields['services'] = "services required";
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
				// If no validation errors
				echo $response_data = insert_vendorservices($request->getBody());
			}
		}
	}
	);

// GET Vendor Cab model by vendorid route
$app->get(
	'/vendor/cabmodel/:vendorid',
	function ($vendorid) use ($app) {
		$response_data = vendor_cabmodel_data($vendorid);
    // checking is vendor id available or not
		if($response_data == '[]') {
    	// if user not aavailable with rocuserid throw 404
			$app->response->setStatus(404);
		}
		else {
    	// if user available throw user data
			echo $response_data;
		}
	}
	);

// vendor price
$app->post(
	'/vendor/prices',
	function() use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
				// If no validation errors
				echo $response_data = insert_vendorprices($request->getBody());
			}
		}
	}
	);

// update vendor price
$app->put(
	'/vendor/prices',
	function() use($app) {
		$request = \Slim\Slim::getInstance()->request();
		update_vendorprices($app, $request->getBody());		
	}
	);

// vendor terms and conditions by vendor id
$app->get(
	'/vendor/terms/:vendorid',
	function($vendorid) use($app) {
		$response_data = get_vendorterms($vendorid);
		// checking is vendor id available or not
		if($response_data == '[]') {
    	// if terms not aavailable with vendorid throw 404
			$app->response->setStatus(404);
			echo $response_data;
		}
		else {
    	// if terms available throw terms data
			echo $response_data;
		}
	}
	);

// Delete User by userid route
$app->delete(
	'/vendor/terms/:vendorid/:termid',
	function ($vendorid, $termid) use ($app) {
		terms_delete($app, $vendorid, $termid);
	}
	);

// vendor terms and conditions
$app->post(
	'/vendor/terms',
	function() use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking terms cab model is empty or not 
			if(isset($request_data->cabmodel)) {
				if(!v::string()->notEmpty()->validate($request_data->cabmodel)) {
					$fields['cabmodel'] = "Cab model should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabmodel'] = "Cab model required";
				$error = TRUE;
			}
			// checking terms cab service is empty or not 
			if(isset($request_data->cabservice)) {
				if(!v::string()->notEmpty()->validate($request_data->cabservice)) {
					$fields['cabservice'] = "Cab service should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabservice'] = "Cab service required";
				$error = TRUE;
			}
			// checking terms content is empty or not 
			if(isset($request_data->content)) {
				if(!v::string()->notEmpty()->validate($request_data->content)) {
					$fields['content'] = "Content should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['content'] = "Content required";
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
				// If no validation errors
				echo $response_data = insert_vendorterms($request->getBody());
			}
		}
	}
	);

// update vendor terms and conditions
$app->put(
	'/vendor/terms',
	function() use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking vendor term id is empty or not 
			if(isset($request_data->termid)) {
				if(!v::string()->notEmpty()->validate($request_data->termid)) {
					$fields['termid'] = "Vendor term id should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['termid'] = "Vendor term id required";
				$error = TRUE;
			}
			// checking terms cab model is empty or not 
			if(isset($request_data->cabmodel)) {
				if(!v::string()->notEmpty()->validate($request_data->cabmodel)) {
					$fields['cabmodel'] = "Cab model should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabmodel'] = "Cab model required";
				$error = TRUE;
			}
			// checking terms cab service is empty or not 
			if(isset($request_data->cabservice)) {
				if(!v::string()->notEmpty()->validate($request_data->cabservice)) {
					$fields['cabservice'] = "Cab service should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabservice'] = "Cab service required";
				$error = TRUE;
			}
			// checking terms content is empty or not 
			if(isset($request_data->content)) {
				if(!v::string()->notEmpty()->validate($request_data->content)) {
					$fields['content'] = "Content should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['content'] = "Content required";
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
				// If no validation errors
				echo $response_data = update_vendorterms($request->getBody());
			}
		}
	}
	);

// GET cab services route
$app->get(
	'/cabservices',
	function () use ($app) {
		cabservices_data($app);
	}
	);

// GET cab types route
$app->get(
	'/cabtypes',
	function () use ($app) {
		cabtypes_data($app);
	}
	);

// GET cab models list route for auto list in manage service and vendor terms
$app->get(
	'/cabmodels',
	function () use ($app) {
		cabmodels_data($app);
	}
	);

// GET manage services by vendor id route
$app->get(
	'/vendor/services/:vendorid',
	function ($vendorid) use ($app) {
		echo $response_data = vendor_services($vendorid);
	}
	);

// DELETE manage services by vendor id route
$app->delete(
	'/vendor/prices/:vendorid/:vcid',
	function ($vendorid, $vcid) use ($app) {
		vendor_prices_delete($app, $vendorid, $vcid);
	}
	);

// GET registered users route
$app->get(
	'/admin/users',
	function () use ($app) {
		users_list($app);
	}
	);

// GET registered users route
$app->get(
	'/admin/vendors',
	function () use ($app) {
		vendors_list($app);
	}
	);

// GET user bookings list route
$app->get(
	'/user/bookings/:userid',
	function ($userid) use ($app) {
		user_bookings_list($app, $userid);
	}
	);

// GET admin bookings list route
$app->get(
	'/vendor/bookings/:vendorid',
	function ($vendorid) use ($app) {
		vendor_bookings_list($app, $vendorid);
	}
	);

// GET admin bookings list route
$app->get(
	'/admin/bookings',
	function () use ($app) {
		bookings_list($app);
	}
	);

// GET admin bookings list route
$app->get(
	'/vendor/terms',
	function () use ($app) {
		vendor_terms($app);
	}
	);

// GET cities list route
$app->get(
	'/cities',
	function () use ($app) {
		get_cities($app);
	}
	);

// POST contactus form submit
$app->post(
	'/contact',
	function () use ($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
		if(!isJson($request_data)) {
			$response = array(
				'error' => 'Invalid JSON',
				'error_description' => 'Invalid JSON'
				);
			$app->response->setStatus(400);
			echo json_encode($response);
		}
		else {
			contact_us($app, $request_data);
		}
	}
	);

// User validate user coupon code
$app->post(
	'/coupon/validate',
	function () use($app) {
		$request = \Slim\Slim::getInstance()->request();
		$request_data = $request->getBody();
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
			// checking user id is empty or not 
			if(isset($request_data->user)) {
				if(!v::string()->notEmpty()->validate($request_data->user)) {
					$fields['user'] = "User should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['user'] = "User required";
				$error = TRUE;
			}

			// checking coupon code is empty or not 
			if(isset($request_data->code)) {
				if(!v::string()->notEmpty()->validate($request_data->code)) {
					$fields['code'] = "coupon code should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['code'] = "Coupon code required";
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
				// If no validation errors
				validate_coupon($app, json_decode($request->getBody()));
			}
		}
	}
	);

$app->contentType('application/json');
/**
 * Step 4: Run the Slim application
 *
 * This method should be called last. This executes the Slim application
 * and returns the HTTP response to the HTTP client.
 */
$app->run();

function isJson($string) {
	// if($string == '' || $string == '{}') return FALSE;
	json_decode($string);
	return (json_last_error() == JSON_ERROR_NONE);
}