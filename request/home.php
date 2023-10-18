<?php
//get tags
if ( $tags = selectDB('tags',"`status` LIKE '0'") ){
	for( $i = 0 ; $i < sizeof($tags) ; $i++ ){
		unset($tags[$i]["userId"],$tags[$i]["status"],$tags[$i]["date"]);
	}
	$response["tags"] = $tags;
}else{
	$response["tags"] = array();
}

//get banners
if( $banners = selectDB('banners',"`status` LIKE '0'") ){
	for( $i = 0 ; $i < sizeof($banners) ; $i++ ){
		for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
			unset($banners[$i][$unsetData[$y]]);
		}
	}
	$response["banners"] = $banners;
}else{
	$response["banners"] = array();
}


//get Vendors
if ( $vendors = selectDB('vendors',"`status` LIKE '0'")){
	for( $i = 0 ; $i < sizeof($vendors) ; $i++ ){
		for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
			unset($vendors[$i][$unsetData[$y]]);
		}
	} 
	$response["vendors"] = $vendors;
}else{
	$response["vendors"] = array();
}

echo outputData($response);
?>