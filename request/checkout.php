<?php
if ( isset($_GET["customerId"]) && !empty($_GET["customerId"]) ){
	if($customer = selectDB('customers',"`id` LIKE '".$_GET["customerId"]."'")){
		$wallet = $customer[0]["wallet"];
	}else{
		$response["msg"] = "Please enter a valid customer Id";
		echo outputError($response);die();
	}
	if( isset($_GET["voucherId"]) && !empty($_GET["voucherId"]) ){
		$voucher = selectDB('vouchers',"`id` LIKE '".$_GET["voucherId"]."'");
		$voucherCode = $voucher[0]["code"];
		$voucher = $voucher[0]["discount"];
	}else{
		$voucher = 0;
		$voucherCode = "";
	}
	if( isset($_GET["items"]) && !empty($_GET["items"]) ){
		for( $i=0 ; $i < sizeof($_GET["items"]) ; $i++ ){
			$items = selectDB('items',"`id` LIKE '".$_GET["items"][$i]["id"]."'");
			if ( $items[0]["discount"] == 0 ){
				$price[] = ($items[0]["price"] * ( (100 - $voucher) / 100 ))*$_GET["items"][$i]["quantity"];
			}else{
				$price[] = $items[0]["price"] * ( (100 - $items[0]["discount"]) / 100 )*$_GET["items"][$i]["quantity"];
			}
		}
	}else{
		$response["msg"] = "Please add items 1st";
		echo outputError($response);die();
	}
	$settings = selectDB('settings',"`id` LIKE '1'");
	$response = [
		"wallet" => (STRING)$wallet,
		"delivery" => (STRING)$settings[0]["delivery"],
		"service" => (STRING)$settings[0]["services"],
		"total" => (string)(array_sum($price)+$settings[0]["services"]+ $settings[0]["delivery"]),
		"voucher" => (STRING)$voucherCode
	];
	echo outputData($response);
}else{
	$response["msg"] = "Please enter customer Id";
	echo outputError($response);die();
}

?>