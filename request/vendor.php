<?php
if ( isset($_GET["id"]) && !empty($_GET["id"]) ){
	if ( $vendors = selectDB('vendors',"`id` LIKE '".$_GET["id"]."'") ){
		$time = $vendors[0]["time"];
	}else{
		goto jump;
	}
	
	for( $i = 0 ; $i < sizeof($vendors) ; $i++ ){
		$vendors[$i]["id"] = (STRING)$vendors[$i]["id"];
		$vendors[$i]["is_new"] = (STRING)$vendors[$i]["is_new"];
		$vendors[$i]["is_busy"] = (STRING)$vendors[$i]["is_busy"];
		$vendors[$i]["time"] = (STRING)$vendors[$i]["time"];
		for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
			unset($vendors[$i][$unsetData[$y]]);
		}
	}
	$response["vendor"] = $vendors[0];

	if ( ($time/1440) >= 1 ){
		$noOfDays = ceil($time/1440);
		$date = strtotime("+{$noOfDays} day", strtotime($date));
		$response["vendor"]["startDate"] = date("Y-m-d", $date);
	}else{
		$noOfDays = 0;
		$date = strtotime("+{$noOfDays} day", strtotime($date));
		$response["vendor"]["startDate"] = date("Y-m-d", $date);
	}
	
	if ( $times = selectDB('vendor_times'," `vendorId` LIKE '{$response["vendor"]["id"]}'") ){
		for( $i = 0 ; $i < sizeof($times) ; $i++ ){
			for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
				unset($times[$i][$unsetData[$y]]);
			}
			$response["vendor"]["times"][$i] = $times[$i]["start"] . " - " . $times[$i]["end"];
		}
	}else{
		$response["vendor"]["times"] = array();
	}
	
	if ($categories = selectDB('categories',"`vendorId` LIKE '".$_GET["id"]."' AND `status` LIKE '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			$categories[$i]["id"] = (STRING)$categories[$i]["id"];
			$categories[$i]["vendorId"] = (STRING)$categories[$i]["vendorId"];
			for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
				unset($categories[$i][$unsetData[$y]]);
			}
		}
	}else{
		$response["categories"] = array();
	}
	
	if ( isset($categories) && !empty($categories) ){
		for ( $z = 0 ; $z < sizeof($categories); $z++ ){
			if ( $items = selectDB('items',"`categoryId` LIKE '".$categories[$z]["id"]."' AND `status` LIKE '0'") ){
				for( $i = 0 ; $i < sizeof($items) ; $i++ ){
					$items[$i]["id"] = (STRING)$items[$i]["id"];
					$items[$i]["categoryId"] = (STRING)$items[$i]["categoryId"];
					for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
						unset($items[$i][$unsetData[$y]]);
					}
					if ( $items[$i]["discount"] > 0 ){
						$items[$i]["finalPrice"] = $items[$i]["price"] * ( (100-$items[$i]["discount"]) / 100 );
					}else{
						$items[$i]["finalPrice"] = "0";
					}
					$items[$i]["finalPrice"] = (string)$items[$i]["finalPrice"];
				}
				$response["categories"][$z] = $categories[$z];
				$response["categories"][$z]["items"] = $items;
				for ( $a = 0; $a < sizeof($items) ; $a++ ){
					if ( $images = selectDB('images',"`itemId` LIKE '".$items[$a]["id"]."' AND `status` LIKE '0'") ){
						for( $i = 0 ; $i < sizeof($images) ; $i++ ){
							for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
								unset($images[$i][$unsetData[$y]]);
								$response["categories"][$z]["items"][$a]["images"][$i] = $images[$i]["imageurl"];
							}
						}
					}else{
						$response["categories"][$z]["items"][$a]["images"] = array();
					}
				}
			}
		}
	}else{
		$response["categories"][0]["items"] = array();
		//echo outputError('No items available for this vendor');die();
	}
	echo outputData($response);
}else{
	jump:
	$error = array("msg"=>"No Vendor with this id");
	echo outputError($error);
}

?>