<?php
function getDB() {
	$dbhost="localhost";
	$dbuser="root";
	$dbpass="Awesome@143";
	$dbname="roc_api";
	$dbConnection = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);	
	$dbConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbConnection;
}
?>