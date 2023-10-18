<?php
if( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if($_GET["type"] == "vendor"){
		$totalPrice = 0;
		$totalcancelled = 0;
		$totalRefunded = 0;
		if( isset($_GET["id"]) && $vendor = selectDB('vendors',"`id` LIKE '{$_GET["id"]}'") ){
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$shop = $vendor[0]["arShop"];
			}else{
				$shop = $vendor[0]["enShop"];
			}
			$response["vendor"]["id"] = $vendor[0]["id"];
			$response["vendor"]["title"] = $shop;
			
			if( $pending = selectDB('orders',"`vendorId` LIKE '{$_GET["id"]}' AND `status` LIKE '1' GROUP BY `orderId`") ){
				$response["orders"]["pending"] = sizeof($pending);
			}else{
				$response["orders"]["pending"] = 0;
			}
			
			if( $preparing = selectDB('orders',"`vendorId` LIKE '{$_GET["id"]}' AND `status` LIKE '2' GROUP BY `orderId`") ){
				$response["orders"]["preparing"] = sizeof($preparing);
			}else{
				$response["orders"]["preparing"] = 0;
			}
			
			if( $ready = selectDB('orders',"`vendorId` LIKE '{$_GET["id"]}' AND `status` LIKE '3' GROUP BY `orderId`") ){
				$response["orders"]["ready"] = sizeof($ready);
			}else{
				$response["orders"]["ready"] = 0;
			}
			
			if( $delivered = selectDB('orders',"`vendorId` LIKE '{$_GET["id"]}' AND `status` LIKE '4' GROUP BY `orderId` ") ){
				$response["orders"]["delivered"] = sizeof($delivered);
				for ( $i = 0 ; $i < sizeof($delivered) ; $i++ ){
					$totalPrice = $totalPrice + $delivered[$i]["price"];
				}
			}else{
				$response["orders"]["delivered"] = 0;
			}
			
			if( $cancelled = selectDB('orders',"`vendorId` LIKE '{$_GET["id"]}' AND `status` LIKE '5' GROUP BY `orderId`") ){
				$response["orders"]["cancelled"] = sizeof($cancelled);
				for ( $i = 0 ; $i < sizeof($cancelled) ; $i++ ){
					$totalcancelled = $totalcancelled + $cancelled[$i]["price"];
				}
			}else{
				$response["orders"]["cancelled"] = 0;
			}
			
			if( $refunded = selectDB('orders',"`vendorId` LIKE '{$_GET["id"]}' AND `status` LIKE '6' GROUP BY `orderId`") ){
				$response["orders"]["refunded"] = sizeof($refunded);
				for ( $i = 0 ; $i < sizeof($refunded) ; $i++ ){
					$totalRefunded = $totalRefunded + $refunded[$i]["price"];
				}
			}else{
				$response["orders"]["refunded"] = 0;
			}
			$response["totals"]["earning"] = $totalPrice;
			$response["totals"]["cancelled"] = $totalcancelled;
			echo outputData($response);die(); 
		}else{
			$response["msg"] = "No vendor with this `id`";
			echo outputError($response);die();
		}
	}elseif($_GET["type"] == "driver"){
		if ( isset($_GET["id"]) && !empty($_GET["id"]) ){
			if ( $driver = selectDB('user',"`id` = '{$_GET["id"]}' AND `status` = '0' AND `type` = '2'") ){
				if ( isset($_GET["orders"]) && !empty($_GET["orders"]) ){
					if ( isset($_GET["date"]) && !empty($_GET["date"]) ){
						$date = " AND `date` LIKE '%{$_GET["date"]}%'";
					}else{
						$date = "";
					}
					if ( $orders = selectDB('orders',"`driverId` = '{$_GET["id"]}' AND `status` = '{$_GET["orders"]}'{$date}") ){
						for( $i=0; $i<sizeof($orders); $i++ ){
							$response["orders"][$i]["id"] = $orders[$i]["orderId"];
							$response["orders"][$i]["price"] = $orders[$i]["price"];
							$response["orders"][$i]["time"] = $orders[$i]["time"];
							$vendor = selectDB('vendors',"`id` = '{$orders[$i]["vendorId"]}'");
							$response["orders"][$i]["address"] = $vendor[0]["addressLine"];
							if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
								$response["orders"][$i]["title"] = $vendor[0]["arShop"];
							}else{
								$response["orders"][$i]["title"] = $vendor[0]["enShop"];
							}
						}
					}else{
						$response["msg"] = "No Orders Available";
						echo outputError($response);die();
					}
				}else{
					$response["msg"] = "Please enter orders type";
					echo outputError($response);die();
				}
				echo outputData($response);die();
			}else{
				$response["msg"] = "No driver with this `id`";
				echo outputError($response);die();
			}
		}else{
			$response["msg"] = "Please enter driver ID";
			echo outputError($response);die();
		}
	}else{
		$response["msg"] = "Wrong type, Please select type of dashboard 'vendor','driver'";
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please select type of dashboard 'vendor','driver'";
	echo outputError($response);die();
}
?>