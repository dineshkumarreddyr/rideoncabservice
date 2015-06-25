<?php
include 'db.php';
include 'user.php';
include 'vendor.php';
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
				if(!v::string()->notEmpty()->validate($request_data->city)) {
					$fields['city'] = "City should not be empty";
					$error = TRUE;
				}
			} else {
				$fields['city'] = "City required";
				$error = TRUE;
			}
			// checking state is empty or not
			if(isset($request_data->state)) {
				if(!v::string()->notEmpty()->validate($request_data->state)) {
					$fields['state'] = "State should not be empty";
					$error = TRUE;
				}
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
				$json_data = json_decode($response_data);
	    	$user_data = $json_data[0];	// swapping first array object
	    	echo json_encode($user_data);
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
			if(isset($request_data->cabtype)) {
				if(!v::string()->notEmpty()->validate($request_data->cabtype)) {
					$fields['cabtype'] = "Cab type should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabtype'] = "Cab type required";
				$error = TRUE;
			}
			// checking service type is empty or not 
			if(isset($request_data->servicetype)) {
				if(!v::string()->notEmpty()->validate($request_data->servicetype)) {
					$fields['servicetype'] = "Service type should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['cabtype'] = "Cab type required";
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
				$response_data = bookCab($request->getBody());
				$response_json_data = json_decode($response_data);
				// checking is cab successfully booked or not
				if(isset($response_json_data->error)) {
					$app->response->setStatus(409);
					echo $response_data;
				}
				else {
					// book cab and throw booking id
					$app->response->setStatus(201);
					echo $response_data;
				}
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
				if(!v::string()->notEmpty()->validate($request_data->address)) {
					$fields['address'] = "Address should not be empty";
					$error = TRUE;
				}
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
				if(!v::string()->notEmpty()->validate($request_data->number2)) {
					$fields['number2'] = "Number2 should not be empty";
					$error = TRUE;
				}
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
				if(!v::string()->notEmpty()->validate($request_data->contactperson)) {
					$fields['contactperson'] = "Contact person should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['contactperson'] = "Contact person required";
				$error = TRUE;
			}
			// checking logo is empty or not 
			if(isset($request_data->logo)) {
				if(!v::string()->notEmpty()->validate($request_data->logo)) {
					$fields['logo'] = "Logo should not be empty";
					$error = TRUE;
				}
			}
			else {
				$fields['logo'] = "Logo required";
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
				$json_data = json_decode($response_data);
	    	$vendor_data = $json_data;	// swapping first array object
	    	echo json_encode($vendor_data);
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

// GET cab services route
$app->get(
  '/cabservices',
  function () use ($app) {
    echo $response_data = cabservices_data();
    // checking is user id available or not
    /*if($response_data == '[]') {
    	// if user not aavailable with rocuserid throw 404
    	$app->response->setStatus(404);
    }
    else {
    	// if user available throw user data
    	$json_data = json_decode($response_data);
    	$user_data = $json_data[0];	// swapping first array object
			echo json_encode($user_data);
    }*/
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