<?php
function selectDBUpdated($table, $where){
    GLOBAL $dbconnect;
    $check = [';', '"'];
    $where = str_replace($check, "", $where);
    $sql = "SELECT * FROM `{$table}`";
    if (!empty($where)) {
        $sql .= " WHERE {$where}";
    }
    if ($stmt = $dbconnect->prepare($sql)) {
        $stmt->execute();
        $result = $stmt->get_result();
        $array = array();
        while ($row = $result->fetch_assoc()) {
            $array[] = $row;
        }
        if (isset($array) && is_array($array)) {
            return $array;
        } else {
            return 0;
        }
    } else {
        $error = array("msg" => "select table error");
        return outputError($error);
    }
}

function selectDashDB($select,$table, $where){
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$where = str_replace($check,"",$where);
	$sql = "SELECT {$select} FROM {$table}";
	if ( !empty($where) ){
		$sql .= " WHERE {$where}";
	}
	if($result = $dbconnect->query($sql)){
		while($row = $result->fetch_assoc() ){
			$array[] = $row;
		}
		if ( isset($array) AND is_array($array) ){
			return $array;
		}else{
			return 0;
		}
	}else{
		$error = array("msg"=>"select table error");
		return outputError($error);
	}
}

function selectDB($table, $where){
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$where = str_replace($check,"",$where);
	$sql = "SELECT * FROM `".$table."`";
	if ( !empty($where) ){
		$sql .= " WHERE " . $where;
	}
	if($result = $dbconnect->query($sql)){
		while($row = $result->fetch_assoc() ){
			$array[] = $row;
		}
		if ( isset($array) AND is_array($array) ){
			return $array;
		}else{
			return 0;
		}
	}else{
		$error = array("msg"=>"select table error");
		return outputError($error);
	}
}

function insertDB($table, $data){
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"',"'"];
	$data = str_replace($check,"",$data);
	$keys = array_keys($data);
	$sql = "INSERT INTO `".$table."`(";
	for($i = 0 ; $i < sizeof($keys) ; $i++ ){
		$sql .= "`".$keys[$i]."`";
		if ( isset($keys[$i+1]) ){
			$sql .= ", ";
		}
	}
	$sql .= ")VALUES(";
	for($i = 0 ; $i < sizeof($data) ; $i++ ){
		$sql .= "'".$data[$keys[$i]]."'";
		if ( isset($keys[$i+1]) ){
			$sql .= ", ";
		}
	}		
	$sql .= ")";
	if($dbconnect->query($sql)){
		return 1;
	}else{
		$error = array("msg"=>"insert table error");
		return outputError($error);
	}
}

function updateDB($table ,$data, $where){
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$data = str_replace($check,"",$data);
	$where = str_replace($check,"",$where);
	$keys = array_keys($data);
	$sql = "UPDATE `".$table."` SET ";
	for($i = 0 ; $i < sizeof($data) ; $i++ ){
		$sql .= "`".$keys[$i]."` = '".$data[$keys[$i]]."'";
		if ( isset($keys[$i+1]) ){
			$sql .= ", ";
		}
	}		
	$sql .= " WHERE " . $where;
	if($dbconnect->query($sql)){
		return 1;
	}else{
		$error = array("msg"=>"update table error");
		return outputError($error);
	}
}

function updateItemQuantity($data){
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"',"'"];
	$data = str_replace($check,"",$data);
	$sql = "UPDATE `items`
			SET 
			`quantity` = `quantity`-".$data["quantity"]."
			WHERE
			`id` LIKE '".$data["id"]."'
			";
	if($dbconnect->query($sql)){
		return 1;
	}else{
		$error = array("msg"=>"update quantity error");
		return outputError($error);
	}
}

function outputData($data){
	$response["ok"] = true;
	$response["error"] = "0";
	$response["status"] = "successful";
	$response["data"] = $data;
	return json_encode($response);
}

function outputError($data){
	$response["ok"] = false;
	$response["error"] = "1";
	$response["status"] = "Error";
	$response["data"] = $data;
	return json_encode($response);
}

function payment($data){
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://createapi.link/api/v2/index.php',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => json_encode($data),
	));
	$response = curl_exec($curl);
	curl_close($curl);
	$response = json_decode($response,true);
	print_r($response);die();
	$array = [
		"url" => $response["data"]["PaymentURL"],
		"id" => $response["data"]["InvoiceId"]
	];
	return $array;
}

function checkPayment($data){
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://createapi.link/api/v2/index.php',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => json_encode($data),
	));
	$response = curl_exec($curl);
	curl_close($curl);
	$response = json_decode($response,true);
	if ( !isset($response["data"]["Data"]["InvoiceStatus"]) ){
		$status = "Failed";
	}else{
		$status = $response["data"]["Data"]["InvoiceStatus"];
	}
	if ( !isset($response["data"]["Data"]["InvoiceId"]) ){
		$id = $data["Key"];
	}else{
		$id = $response["data"]["Data"]["InvoiceId"];
	}
	$array = [
		"status" => $status,
		"id" => $id
	];
	return $array;
}

function driverNotification($orderId, $driverId){
	$server_key = 'AAAASqGYwIQ:APA91bFFEKYafvLvX3QZPR-n5GiXS32Y3CH6ZMOYuApZzENQkw_WuIWtEYQr2Ifq03SBMibLxp1UlhORBaDQO0Sfmnd2EmlFz6D9oKV71nyYikmphg-tCVN_A08qtITkWpDcJDZHsyKl'; 
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	//$order = selectDB("orders","`orderId` = '{$orderId}'");
	$driver = selectDB("user","`id` = '{$driverId}'");
		$to = $driver[0]["deviceToken"];
		$title = "Order Ready for delivery - {$orderId}";
		$body = "You have a new order to deliver.";
		$json_data = array(
			"to" => "{$to}",
			"notification" => array(
				"body" => "{$body}",
				"text" => "{$body}",
				"title" => "{$title}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			),
			"data" => array(
				"body" => "{$body}",
				"title" => "{$title}",
				"text" => "{$body}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			)
		);
		$data = json_encode($json_data);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$response = curl_exec($ch);
		curl_close($ch);
}

function orderDelivered($orderId){
	$server_key = 'AAAASqGYwIQ:APA91bFFEKYafvLvX3QZPR-n5GiXS32Y3CH6ZMOYuApZzENQkw_WuIWtEYQr2Ifq03SBMibLxp1UlhORBaDQO0Sfmnd2EmlFz6D9oKV71nyYikmphg-tCVN_A08qtITkWpDcJDZHsyKl'; 
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	$order = selectDB("orders","`orderId` = '{$orderId}'");
	$vendor = selectDB("vendors","`id` = '{$order[0]["vendorId"]}'");
		$to = $vendor[0]["deviceToken"];
		$title = "Order delivery - {$orderId}";
		$body = "Your order has been delived.";
		$json_data = array(
			"to" => "{$to}",
			"notification" => array(
				"body" => "{$body}",
				"text" => "{$body}",
				"title" => "{$title}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			),
			"data" => array(
				"body" => "{$body}",
				"title" => "{$title}",
				"text" => "{$body}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			)
		);
		$data = json_encode($json_data);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$response = curl_exec($ch);
		curl_close($ch);
}

function newOrderNoti($orderId){
	$server_key = 'AAAASqGYwIQ:APA91bFFEKYafvLvX3QZPR-n5GiXS32Y3CH6ZMOYuApZzENQkw_WuIWtEYQr2Ifq03SBMibLxp1UlhORBaDQO0Sfmnd2EmlFz6D9oKV71nyYikmphg-tCVN_A08qtITkWpDcJDZHsyKl'; 
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	$order = selectDB("orders","`orderId` = '{$orderId}'");
	$vendor = selectDB("vendors","`id` = '{$order[0]["vendorId"]}'");
		$to = $vendor[0]["deviceToken"];
		$title = "New order - {$orderId}";
		$body = "You have recevied a new order.";
		$json_data = array(
			"to" => "{$to}",
			"notification" => array(
				"body" => "{$body}",
				"text" => "{$body}",
				"title" => "{$title}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			),
			"data" => array(
				"body" => "{$body}",
				"title" => "{$title}",
				"text" => "{$body}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			)
		);
		$data = json_encode($json_data);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$response = curl_exec($ch);
		curl_close($ch);
}

function updateOrderStatusNotification($orderId, $status){
	$server_key = 'AAAAiO4BayE:APA91bHBugBp5KSbIQKXkOzRboEAutP_nhwZXwJnUkaMtrWBXhMMsDfro6Ge-BSf7V3w2zLdGDV4C1Y42wKjX2PEb6kEVDVzqWZCkxXWrDn8uX9OsClLvXMhq4WgQ1qioazKuyXSsrwS'; 
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	$order = selectDB("orders","`orderId` = '{$orderId}'");
	$firebase = selectDB("firebase","`customerId` = '{$order[0]["customerId"]}'");
		$to = $firebase[0]["deviceToken"];
		$title = "EZYo Order status";
		if( $status == 2 ){
			$body = "You order #{$orderId} is being prepared.";
		}elseif( $status == 3 ){
			$body = "You order #{$orderId} is out for delivery.";
		}elseif( $status == 4 ){
			$body = "You order #{$orderId} is delivered.";
		}elseif( $status == 5 ){
			$body = "You order #{$orderId} is cancelled.";
		}elseif( $status == 6 ){
			$body = "You order #{$orderId} is refunded.";
		}else{
			$body = "You order #{$orderId} status being updated.";
		}
		$json_data = array(
			"to" => "{$to}",
			"notification" => array(
				"body" => "{$body}",
				"text" => "{$body}",
				"title" => "{$title}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			),
			"data" => array(
				"body" => "{$body}",
				"title" => "{$title}",
				"text" => "{$body}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			)
		);
		$data = json_encode($json_data);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$response = curl_exec($ch);
		curl_close($ch);
}
?>