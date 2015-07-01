<?php
// $app = \Slim\Slim::getInstance();
/*
 * Get List of users
 */
function users_list() {
	$sql = "SELECT * FROM rocusers";
	try {
		$db = getDB();
		$stmt = $db->prepare($sql);
		$stmt->execute();		
		$bookings_data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		$count = count($bookings_data);
		if($count) {
			$bookings_data = array("total" => $count, "results" => $bookings_data);
			echo json_encode($bookings_data);
		}
		else {
			$bookings_data = array("total" => 0, "results" => array());
			echo json_encode($bookings_data);
		}
	} catch(PDOException $e) {
	    //error_log($e->getMessage(), 3, '/var/tmp/php.log');
		echo '{"error":{"message":"'. $e->getMessage() .'"}}'; 
	}
}
?>