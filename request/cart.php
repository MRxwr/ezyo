<?php
if ( isset($_GET["id"]) && !empty($_GET["id"]) ){
	for ( $z = 0; $z < sizeof($_GET["id"]) ; $z++ ){
		if ( $items = selectDB('items',"`id` LIKE '".$_GET["id"][$z]."' AND `status` LIKE '0'") ){
			for( $i = 0 ; $i < sizeof($items) ; $i++ ){
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
			$categoryId = selectDB('categories',"`id` LIKE '".$items[0]["categoryId"]."'");
			$vendor = selectDB('vendors',"`id` LIKE '".$categoryId[0]["id"]."'");
			
			for( $i = 0 ; $i < sizeof($vendor) ; $i++ ){
				for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
					unset($vendor[$i][$unsetData[$y]]);
				}
			}
			$response["vendor"] = $vendor[0];
			
			$response["item"][$z] = $items[0];
			if ( $images =  selectDB('images',"`itemId` LIKE '".$items[0]["id"]."' AND `status` LIKE '0'") ){
				for( $i = 0 ; $i < sizeof($images) ; $i++ ){
					for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
						unset($images[$i][$unsetData[$y]]);
						$response["item"][$z]["images"][$i] = $images[$i]["imageurl"];
					}
				}
			}
		}
	}
	echo outputData($response);
}else{
	jump:
	$error = array("msg"=>"No item with this id");
	echo outputError($error);
}

?>