<?php
//get address
if ( isset($_GET["type"]) ){
	if ( $_GET["type"] == "list" ){
		if ( isset($_GET["customerId"]) AND !empty($_GET["customerId"]) ){
			if( $address = selectDB('addresses',"`customerId` LIKE '".$_GET["customerId"]."' AND `status` LIKE '0'") ){
				for( $i = 0 ; $i < sizeof($address) ; $i++ ){
					for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
						unset($address[$i][$unsetData[$y]]);
					}
					$keys = array_keys($address[$i]);
					for( $z = 0; $z < sizeof($keys) ; $z++ ){
						$address[$i][$keys[$z]] = (STRING)$address[$i][$keys[$z]];
					}
				}
				$response["address"] = $address;
				echo outputData($response);
			}else{
				$response["msg"] = "Wrong cusomter Id";
				echo outputError($response);die();
			}
		}else{
			$response["msg"] = "Please enter customer Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "add" ){
		if ( isset($_GET["customerId"]) AND !empty($_GET["customerId"]) ){
			$data = $_GET;
			unset($data["action"]);
			unset($data["type"]);
			if( $query = insertDB('addresses',$data ) ){
				if ( $address = selectDB('addresses'," `id` LIKE (SELECT LAST_INSERT_ID()) ") ){
					for( $i = 0 ; $i < sizeof($address) ; $i++ ){
						for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
							unset($address[$i][$unsetData[$y]]);
						}
						$keys = array_keys($address[$i]);
						for( $z = 0; $z < sizeof($keys) ; $z++ ){
							$address[$i][$keys[$z]] = (STRING)$address[$i][$keys[$z]];
						}
					}
					$response["address"] = $address[0];
					echo outputData($response);
				}else{
					$response["msg"] = "Address has not been added. please try again";
					if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
						$response["msg"] = "لم تتم اضافة العنوان بالشكل الصحيح الرجاء المحاولة من جديد";
					}
					echo outputError($response);die();
				}
			}else{
				$response["msg"] = "Wrong cusomter Id";
				echo outputError($response);die();
			}
		}else{
			$response["msg"] = "Please enter customer Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "edit" ){
		if ( isset($_GET["addressId"]) AND !empty($_GET["addressId"]) ){
			$data = $_GET;
			unset($data["action"]);
			unset($data["type"]);
			unset($data["addressId"]);
			if( $query = updateDB('addresses',$data,"`id` LIKE '".$_GET["addressId"]."'" ) ){
				if ( $address = selectDB('addresses'," `id` LIKE '".$_GET["addressId"]."' ") ){
					for( $i = 0 ; $i < sizeof($address) ; $i++ ){
						for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
							unset($address[$i][$unsetData[$y]]);
						}
						$keys = array_keys($address[$i]);
						for( $z = 0; $z < sizeof($keys) ; $z++ ){
							$address[$i][$keys[$z]] = (STRING)$address[$i][$keys[$z]];
						}
					}
					$response["address"] = $address[0];
					echo outputData($response);
				}else{
					$response["msg"] = "Address has not been updated. please try again";
					if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
						$response["msg"] = "لم يتم تعديل العنوان بالشكل الصحيح الرجاء المحاولة من جديد";
					}
					echo outputError($response);die();
				}
			}else{
				$response["msg"] = "Wrong address Id";
				echo outputError($response);die();
			}
		}else{
			$response["msg"] = "Please enter address Id";
			echo outputError($response);die();
			
		}
	}else{
		$response["msg"] = "Wrong type, 'list' or 'add' or 'edit'";
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please enter type of operation.";
	echo outputError($response);die();
}
?>