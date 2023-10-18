<?php
if( isset($_GET["PaymentID"]) && !empty($_GET["PaymentID"]) ){
	$data = array(
		'endpoint' => 'PaymentStatusCheck',
		'apikey' => 'CKW-1627824132-1075',
		'Key' => $_GET["PaymentID"],
		'KeyType' => 'PaymentID'
		);
	$response1 = outputData(checkPayment($data));
	$response = json_decode($response1,true);
	$orderId = $response["data"]["id"];
	if ( $response["data"]["status"] == "Paid" ){
		$orders = selectDB('orders'," `orderId` LIKE '".$orderId."'");
		if ( $orders[0]["status"] == "0" ){
			updateDB('orders',array('status'=>"1")," `orderId` LIKE '".$orderId."'");
			for( $i = 0 ; $i < sizeof($orders) ; $i++ ){
				$data = array(
					"id" => $orders[$i]["itemId"],
					"quantity" => $orders[$i]["quantity"]
					);
				updateItemQuantity($data);
			}
			//echo outputData($response1);
			newOrderNoti($orderId);
		}
	}else{
		$error = array("msg" => "Something went wrong, please check payment Id.");
		//echo outputError($error);
	}
}elseif( isset($_GET["orderId"]) && !empty($_GET["orderId"]) ){
	$orderId = $_GET["orderId"];
	if ( $orders = selectDB('orders'," `orderId` LIKE '".$orderId."'") ){
		if ( $orders[0]["status"] == "0" ){
			updateDB('orders',array('status'=>"1")," `orderId` LIKE '".$orderId."'");
			for( $i = 0 ; $i < sizeof($orders) ; $i++ ){
				$data = array(
					"id" => $orders[$i]["itemId"],
					"quantity" => $orders[$i]["quantity"]
					);
				updateItemQuantity($data);
			}
			newOrderNoti($orderId);
			$customerId = $orders[0]["customerId"];
			$price = $orders[0]["price"];
			$customer = selectDB('customers'," `id` LIKE '".$customerId."'");
			$wallet = $customer[0]["wallet"];
			$newWallet = $wallet - ($price + $orders[0]["delivery"] + $orders[0]["service"]);
			if ( $newWallet <= 0 ){
				$newWallet = 0;
			}
			updateDB('customers',array('wallet'=>$newWallet)," `id` LIKE '".$customerId."'");
			//echo outputData(array("orderId"=>$_GET["orderId"],"status"=>"success"));
		}else{
			$error = array("msg" => "order with this Id is already regitered in the system.");
			//echo outputError($orders);
		}
	}else{
		$error = array("msg" => "Something went wrong, orderId");
		//echo outputError($error);
	}
}else{
	$error = array("msg" => "Something wrong happned please contact administration");
	//echo outputError($error);
}
?>