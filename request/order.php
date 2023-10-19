<?php
if( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "list" ){
		if( isset($_GET["customerId"]) && !empty($_GET["customerId"]) ){
		if ( $order = selectDB('orders',"`customerId` LIKE {$_GET["customerId"]} AND `status` != '0'  GROUP BY `orderId` ORDER BY `id` DESC")){
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
			$response["msg"] = "Please enter customer Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "submit" ){
		$paymentData = array();
		$data = $_GET;
		unset($data["submit"]);
		$checkArray = ['customerId','addressId','vendorId','items','voucherId','orderNote','paymentMethod'];
		$keys = array_keys($data);
		for ( $i = 0 ; $i < sizeof($checkArray) ; $i++ ){
			if( !in_array($checkArray[$i],$keys) ){
				$response["msg"] = "Please enter order data correctly";
				echo outputError($response);die();
			}
		}
		
		if ( $vouchers = selectDB('vouchers',"`id` = '{$data["voucherId"]}'") ){
			$data["voucherDiscount"] = $vouchers[0]["discount"];
			$voucher = $vouchers[0]["discount"];
		}else{
			$data["voucherDiscount"] = 0;
			$voucher = 0;
		}
		
		for( $i=0 ; $i < sizeof($data["items"]) ; $i++ ){
			$items = selectDB('items',"`id` = '{$data["items"][$i]["id"]}'");
			if ( $items[0]["discount"] == 0 ){
				$price[$i] = ($items[0]["price"] * ((100 - $voucher) / 100 ))*$data["items"][$i]["quantity"];
				$data["price"][$i] = $price[$i];
				$quantity[$i] = $data["items"][$i]["quantity"];
				$orderNotes[$i] = $data["items"][$i]["orderNotes"];
				$id[$i] = $data["items"][$i]["id"];
				$discount[$i] = $items[0]["discount"];
			}else{
				$price[$i] = $items[0]["price"] * ( (100 - $items[0]["discount"]) / 100 )*$data["items"][$i]["quantity"];
				$data["price"][$i] = $price[$i];
				$quantity[$i] = $data["items"][$i]["quantity"];
				$orderNotes[$i] = $data["items"][$i]["orderNotes"];
				$id[$i] = $data["items"][$i]["id"];
				$discount[$i] = $items[0]["discount"];
			}
		}
		unset($data["items"]);
		unset($data["action"]);
		unset($data["type"]);
		$data["price"] = array_sum($price);
		
		$address = selectDB('addresses',"`id` LIKE '".$data["addressId"]."'");
		$data["mobile"] = $address[0]["mobile"];
		
		$address = selectDB('customers',"`id` LIKE '".$data["customerId"]."'");
		$email = $address[0]["email"];
		$name = $address[0]["name"];
		
		$settings = selectDB('settings',"");
		$data["delivery"] = $settings[0]["delivery"];
		$data["service"] = $settings[0]["services"];
		$totalPrice = $data["service"] + $data["delivery"] + $data["price"];
		
		if ( $data["paymentMethod"] == 3 ){
			$RealPaymentMethod = 3;
			$data["paymentMethod"] == '1';
		}
		
		$vendorDetails = selectDB('vendors',"`id` = '{$data["vendorId"]}'");
		$extraMerchantsData = array(
			"amounts" => array( "0" => $totalPrice),
			"charges" => array( "0" => $vendorDetails[0]["kent"] ),
			"chargeType" => array( "0" => $vendorDetails[0]["kentType"] ),
			"cc_charge" => array( "0" => $vendorDetails[0]["visa"] ),
			"cc_chargetype" => array( "0" => $vendorDetails[0]["visaType"] ),
			"ibans" => array( "0" => $vendorDetails[0]["iban"] )
		);
		
		
		$paymentData = [
			'endpoint' => 'PaymentRequestExicuteForVendors',
			'apikey' => 'CKW-1659216594-2896',
			'PaymentMethodId' => $data["paymentMethod"],
			'CustomerName' => $name,
			'DisplayCurrencyIso' => 'KWD',
			'MobileCountryCode' => '+965',
			'CustomerMobile' => (string)substr($data["mobile"],0,11),
			'CustomerEmail' => $email,
			'invoiceValue' => $totalPrice,
			'CallBackUrl' => 'https://ezyokw.com/request/index.php?page=success',
			'ErrorUrl' => 'https://ezyokw.com/request/index.php?page=failure',
			'extraMerchantsData' => $extraMerchantsData
			];
			
		/*
		for ( $i = 0 ; $i < sizeof($id) ; $i++ ){
			$paymentData["InvoiceItems"][$i]["ItemName"] = $id[$i];
			$paymentData["InvoiceItems"][$i]["Quantity"] = $quantity[$i];
			$paymentData["InvoiceItems"][$i]["UnitPrice"] = $price[$i];
		}
		*/
		//print_r($paymentData);die();
		$invoiceDetails = payment($paymentData);
		$data["orderId"] = $invoiceDetails["id"];
		$url = $invoiceDetails["url"];
		
		if ( isset($RealPaymentMethod) ){
			$data["paymentMethod"] == '3';
			$url = 'https://ezyokw.com/request/index.php?page=success?orderId='.$data["orderId"];
		}
		
		//print_r($data = json_encode($data));
		for($i=0 ; $i < sizeof($id) ; $i++){
			$data["quantity"] = $quantity[$i];
			$data["itemNote"] = $orderNotes[$i];
			$data["itemId"] = $id[$i];
			$data["itemDiscount"] = $discount[$i];
			$data["itemPrice"] = $price[$i];
			insertDB('orders',$data);
		}
		echo outputData(array('orderId' => (int)$data["orderId"] ,'url'=>$url));
		//submitting order to database
		
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
			$response["vendor"]["logo"] = $vendor[0]["logo"];
			
			if($voucher = selectDB('vouchers',"`id` LIKE '".$order[0]["voucherId"]."'")){
				$response["voucher"]["code"] = $voucher[0]["code"];
				$response["voucher"]["discount"] = $order[0]["voucherDiscount"];
			}else{
				$response["voucher"]["code"] = "";
				$response["voucher"]["discount"] = "";
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
	}
}else{
	$response["msg"] = "Please select type of order 'list','submit','details'";
	echo outputError($response);die();
}

?>