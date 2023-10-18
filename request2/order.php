<?php
if( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "list" ){
		if( isset($_POST["vendorId"]) && !empty($_POST["vendorId"]) ){
		if ( $order = selectDB('orders',"`vendorId` LIKE {$_POST["vendorId"]} AND `status` != '0' AND `status` = '{$_POST["orderType"]}' GROUP BY `orderId` ORDER BY `id` DESC")){
				for ( $i = 0 ; $i < sizeof($order) ; $i++ ){
					$vendor = selectDB('vendors',"`id` LIKE '".$order[$i]["vendorId"]."'");
					$response[$i]["vendor"]["enTitle"] = $vendor[0]["enShop"];
					$response[$i]["vendor"]["arTitle"] = $vendor[0]["arShop"];
					$response[$i]["vendor"]["logo"] = $vendor[0]["logo"];
					
					if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
						if ( $order[$i]["status"] == 1 ){
							$statusText = "مدفوع";
						}elseif( $order[$i]["status"] == 2 ){
							$statusText = "جاري التحضير";
						}elseif( $order[$i]["status"] == 3 ){
							$statusText = "جاري التوصيل";
						}elseif( $order[$i]["status"] == 4 ){
							$statusText = "تم التوصيل";
						}elseif( $order[$i]["status"] == 5 ){
							$statusText = "ملغي";
						}elseif( $order[$i]["status"] == 6 ){
							$statusText = "مسترجع";
						}elseif( $order[$i]["status"] == 7 ){
							$statusText = "فاشل";
						}else{
							$statusText = "";
						}
					}else{
						if ( $order[$i]["status"] == 1 ){
							$statusText = "Paid";
						}elseif( $order[$i]["status"] == 2 ){
							$statusText = "Preparing";
						}elseif( $order[$i]["status"] == 3 ){
							$statusText = "Out for delivery";
						}elseif( $order[$i]["status"] == 4 ){
							$statusText = "Delivered";
						}elseif( $order[$i]["status"] == 5 ){
							$statusText = "Canceled";
						}elseif( $order[$i]["status"] == 6 ){
							$statusText = "Refunded";
						}elseif( $order[$i]["status"] == 7 ){
							$statusText = "Failed";
						}else{
							$statusText = "";
						}
					}
					
					$response[$i]["order"]["id"] = $order[$i]["orderId"];
					$response[$i]["order"]["date"] = $order[$i]["date"];
					$response[$i]["order"]["status"] = $statusText;
					//$response[$i]["order"]["price"] = $order[$i]["price"];
					$response[$i]["order"]["price"] = (string)($order[$i]["price"]+$order[$i]["service"]+$order[$i]["delivery"]);
				}
			}else{
				$response = array();
			}
			echo outputData($response);
			
		}else{
			$response["msg"] = "Please enter Vendor Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "details" ){
		if( !isset($_GET["orderId"]) || empty($_GET["orderId"]) ){
			$error = array("msg"=>"Please enter a correct Order Id");
			echo outputError($error);die();
		}
			if($order = selectDB('orders',"`orderId` LIKE '".$_GET["orderId"]."'")){
			if ( $order[0]["paymentMethod"] == 1 ){
				$paymentText = "K-net";
			}elseif( $order[0]["paymentMethod"] == 2 ){
				$paymentText = "Visa/Master";
			}elseif( $order[0]["paymentMethod"] == 3 ){
				$paymentText = "Wallet";
			}else{
				$paymentText = "";
			}
			
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				if ( $order[0]["status"] == 1 ){
					$statusText = "مدفوع";
				}elseif( $order[0]["status"] == 2 ){
					$statusText = "جاري التحضير";
				}elseif( $order[0]["status"] == 3 ){
					$statusText = "جاري التوصيل";
				}elseif( $order[0]["status"] == 4 ){
					$statusText = "تم التوصيل";
				}elseif( $order[0]["status"] == 5 ){
					$statusText = "ملغي";
				}elseif( $order[0]["status"] == 6 ){
					$statusText = "مسترجع";
				}elseif( $order[0]["status"] == 7 ){
					$statusText = "فاشل";
				}else{
					$statusText = "";
				}
			}else{
				if ( $order[0]["status"] == 1 ){
					$statusText = "Paid";
				}elseif( $order[0]["status"] == 2 ){
					$statusText = "Preparing";
				}elseif( $order[0]["status"] == 3 ){
					$statusText = "Out for delivery";
				}elseif( $order[0]["status"] == 4 ){
					$statusText = "Delivered";
				}elseif( $order[0]["status"] == 5 ){
					$statusText = "Canceled";
				}elseif( $order[0]["status"] == 6 ){
					$statusText = "Refunded";
				}elseif( $order[0]["status"] == 7 ){
					$statusText = "Failed";
				}else{
					$statusText = "";
				}
			}
			
			$response["orderId"] = $order[0]["orderId"];
			$response["date"] = $order[0]["date"];
			$response["payment"] = $paymentText;
			$response["delivery"] = $order[0]["delivery"];
			$response["service"] = $order[0]["service"];
			$response["price"] = (string)($order[0]["price"]+$order[0]["service"]+$order[0]["delivery"]);
			$response["status"] = $statusText;
			$response["note"] = $order[0]["orderNote"];
			$response["time"] = $order[0]["time"];
			$response["deliveryDate"] = $order[0]["deliveryDate"];
			
			$customer = selectDB('customers',"`id` LIKE '".$order[0]["customerId"]."'");
			$response["customer"]["name"] = $customer[0]["name"];
			
			$address = selectDB('addresses',"`id` LIKE '".$order[0]["addressId"]."'");
			unset($address[0]["id"]);
			unset($address[0]["customerId"]);
			unset($address[0]["date"]);
			unset($address[0]["status"]);
			$response["address"] = $address[0];
			
			$vendor = selectDB('vendors',"`id` LIKE '".$order[0]["vendorId"]."'");
			$response["vendor"]["enTitle"] = $vendor[0]["enShop"];
			$response["vendor"]["arTitle"] = $vendor[0]["arShop"];
			$response["vendor"]["address"] = $vendor[0]["addressLine"];
			$response["vendor"]["logo"] = $vendor[0]["logo"];
			
			if($voucher = selectDB('vouchers',"`id` LIKE '".$order[0]["voucherId"]."'")){
				$response["voucher"]["code"] = $voucher[0]["code"];
				$response["voucher"]["discount"] = $order[0]["voucherDiscount"];
			}else{
				$response["voucher"]["code"] = "";
				$response["voucher"]["discount"] = 0;
			}
			
			
			for( $i=0 ; $i < sizeof($order) ; $i++){
				$items = selectDB('items',"`id` LIKE '".$order[$i]["itemId"]."'");
				$response["items"][$i]["arTitle"] = $items[0]["arTitle"];
				$response["items"][$i]["enTitle"] = $items[0]["enTitle"];
				$response["items"][$i]["quantity"] = $order[$i]["quantity"];
				$response["items"][$i]["discount"] = $order[$i]["itemDiscount"];
				$response["items"][$i]["price"] = $order[$i]["itemPrice"];
				$response["items"][$i]["note"] = $order[$i]["itemNote"];
				if ( $images = selectDB('images',"`itemId` LIKE '".$order[$i]["itemId"]."' AND `status` = '0'")){
					$response["items"][$i]["logo"] = $images[0]["imageurl"];
				}
			}
			
			echo outputData($response);
			
		}else{
			$response["msg"] = "Please enter order Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "update" ){
		if ( !isset($_POST["orderId"]) || empty($_POST["orderId"]) ){
			$error = array("msg"=>"Please enter Order Id");
			echo outputError($error);die();
		}elseif ( !isset($_POST["status"]) || empty($_POST["status"]) ){
			$error = array("msg"=>"Please enter Status");
			echo outputError($error);die();
		}elseif ( (!isset($_POST["driverId"]) || empty($_POST["driverId"])) && $_POST["status"] == 3 ){
			$error = array("msg"=>"Please enter driver ID");
			echo outputError($error);die();
		}else{
			if ( $_POST["status"] == 3 ){
				$updateOrder = array(
					"status" => $_POST["status"],
					"driverId" => $_POST["driverId"],
				);
				driverNotification($_POST["orderId"],$_POST["driverId"]);
			}elseif( $_POST["status"] == 4 ){
				orderDelivered($_POST["orderId"]);
				$updateOrder = array(
					"status" => $_POST["status"],
				);
			}else{
				$updateOrder = array(
					"status" => $_POST["status"],
				);
			}
			if ( updateDB('orders',$updateOrder,"`orderId` LIKE '{$_POST["orderId"]}'")){
				updateOrderStatusNotification($_POST["orderId"],$_POST["status"]);
				if( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$msg = array("msg"=>"تم تحديث حالة الطلب بنجاح");
				}else{
					$msg = array("msg"=>"order status has been updated successfully.");
				}
				echo outputData($msg);die();
			}else{
				$error = array("msg"=>"Please enter a correct OrderId");
				echo outputError($error);die();
			}
		}
	}
}else{
	$response["msg"] = "Please select type of order 'list','update','details'";
	echo outputError($response);die();
}

?>