<?php
if ( isset($_GET["code"]) && !empty($_GET["code"]) ){
	if ( $voucher = selectDB('vouchers',"`code` LIKE '".$_GET["code"]."'") ){
		if ( $voucher[0]["is_all"] != '1' ){
			if( isset($_GET["vendorId"]) && !empty($_GET["vendorId"]) ){
				if ( $voucher = selectDB('vouchers',"`code` LIKE '".$_GET["code"]."' AND `vendorId` LIKE '".$_GET["vendorId"]."'")){
					if ( $voucher[0]["status"] == '1' ){
						$response["msg"] = "This voucher has expired";
						if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
							$response["msg"] = "الكود المستخدم إنتهى";
						}
						echo outputError($response);die();
					}
				}else{
					$response["msg"] = "this vendor has no vouchers";
					if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
							$response["msg"] = "لا يوجد كود خصم لهذا المتجر";
						}
					echo outputError($response);die();
				}
			}else{
				$response["msg"] = "This is not a general Voucher, please enter vendor Id";
				echo outputError($response);die();
			}
		}
		for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
			unset($voucher[0][$unsetData[$y]]);
		}
		$response["voucher"] = $voucher[0];
		echo outputData($response);
	}else{
		$response["msg"] = "No voucher with this code";
		if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
			$response["msg"] = "كود خصم خاطئ";
		}
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please enter voucher code ";
	echo outputError($response);die();
}

?>