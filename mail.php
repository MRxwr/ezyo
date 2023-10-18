<?php
if ( isset($_POST["email"]) ){
	
	$body = array(
		'site' => 'EZYO',
		'subject' => 'Become a partner',
		'body' => "{$_POST["name"]} - {$_POST["shop"]} - {$_POST["email"]} - {$_POST["phone"]} - {$_POST["Country"]} - {$_POST["account"]}",
		'from_email' => $_POST["email"],
		'to_email' => 'ezyokuwait@gmail.com'
	);
	
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'myid.createkwservers.com/api/v1/send/notify',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => $body,
	));
	$response = curl_exec($curl);
	curl_close($curl);

}

echo $response ;
?>