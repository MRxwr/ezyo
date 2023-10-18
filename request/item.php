<?php
if ( isset($_GET["id"]) && !empty($_GET["id"]) ){
	if ( $items = selectDB('items',"`id` LIKE '".$_GET["id"]."' AND `status` LIKE '0'") ){
		for( $i = 0 ; $i < sizeof($items) ; $i++ ){
			for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
				unset($items[$i][$unsetData[$y]]);
			}
			$response["item"] = $items[$i];
			if ( $items[$i]["discount"] > 0 ){
				$response["item"]["finalPrice"] = $items[$i]["price"] * ( (100-$items[$i]["discount"]) / 100 );
			}else{
				$response["item"]["finalPrice"] = "0";
			}
			$response["item"]["finalPrice"] = (string)$response["item"]["finalPrice"];
		}
		
		if ( $images =  selectDB('images',"`itemId` LIKE '".$items[0]["id"]."' AND `status` LIKE '0'") ){
			for( $i = 0 ; $i < sizeof($images) ; $i++ ){
				for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
					unset($images[$i][$unsetData[$y]]);
					$response["item"]["images"][$i] = $images[$i]["imageurl"];
				}
			}
		}else{
			$response["item"]["images"] = array();
		}
	}else{
		$response["item"] = array();
	}
	echo outputData($response);
}else{
	jump:
	$error = array("msg"=>"No item with this id");
	echo outputError($error);
}

?>