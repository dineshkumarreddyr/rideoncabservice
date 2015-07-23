<?php
function prepare_sms($userMobiles, $message) {

	$smsUrl = 'http://alerts.solutionsinfini.com/api/v3/index.php'; 
	$smsApi = 'A778850aa698b0602f8a2e6b1ff660db6'; 
	$smsFormat = 'php';
	$method = 'sms';
	$sender = 'RIDEONC';
	// $message = 'MESSAGE Dev';
	// $userMobiles = '7569508595';

	$params = array(
	   "api_key" => $smsApi,
	   "to" => $userMobiles,
	   "sender" => $sender,
	   "format" => $smsFormat,
	   "method" => $method,
	   "message" => $message
	);

	$sendSms = sendSms($smsUrl,$params);
	$sendSms = unserialize($sendSms);
	// print_r($sendSms);
	$smsStatus = $sendSms['status'];

	if($smsStatus == "OK")
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

function sendSms($url,$params)
{
	$postData = '';

	foreach($params as $k => $v) 
	{ 
	  $postData .= $k . '='.$v.'&'; 
	}
	rtrim($postData, '&');

	$ch = curl_init();  

	curl_setopt($ch,CURLOPT_URL,$url);
	curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
	curl_setopt($ch,CURLOPT_HEADER, false); 
	curl_setopt($ch, CURLOPT_POST, count($postData));
		curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);    

	$output=curl_exec($ch);

	curl_close($ch);
	return $output;
}


?>