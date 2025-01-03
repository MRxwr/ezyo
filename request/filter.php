<?php
//get tags
$tags = selectDB('tags',"`status` LIKE '0'");
for( $i = 0 ; $i < sizeof($tags) ; $i++ ){
	$tags[$i]["id"] = (STRING)$tags[$i]["id"];
	unset($tags[$i]["userId"],$tags[$i]["status"],$tags[$i]["date"]);
}
$response["tags"] = $tags;
//get banners
$banners = selectDB('banners',"`status` LIKE '0'");
for( $i = 0 ; $i < sizeof($banners) ; $i++ ){
	$banners[$i]["id"] = (STRING)$banners[$i]["id"];
	for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
		unset($banners[$i][$unsetData[$y]]);
	}
}
$response["banners"] = $banners;
//get Vendors
if( isset($_GET["tag"]) && !empty($_GET["tag"]) ){
	$sql = "SELECT v.*
			FROM `vendors` as v
			JOIN `tags_vendors` as tv
			ON v.id = tv.vendorId
			WHERE
			tv.tagId = '".$_GET["tag"]."'
			AND
			tv.status LIKE '0'
			AND
			v.status LIKE '0'
			";
	$sql .=	"GROUP BY v.id";
	if( isset($_GET["filter"]) && $_GET["filter"] == "new" ){
		$sql .= " ORDER BY `id` DESC";
	}elseif( isset($_GET["filter"]) && $_GET["filter"] == "alphabetical" ){
		if ( isset($_GET["lang"]) && $_GET["lang"] == "ar"){
			$sql .= " ORDER BY `arShop` ASC";
		}else{
			$sql .= " ORDER BY `enShop` ASC";
		}
	}elseif( isset($_GET["filter"]) && $_GET["filter"] == "fast" ){
		$sql .= " ORDER BY `time` ASC";
	}
	$result = $dbconnect->query($sql);
	while ( $row = $result->fetch_assoc() ){
		$vendors[] = $row;
	}
	if( !isset($vendors) ){
		$vendors = array();
	}
}elseif( isset($_GET["filter"]) && $_GET["filter"] == "new" ){
	$vendors = selectDB('vendors',"`status` LIKE '0' ORDER BY `id` DESC");
}elseif( isset($_GET["filter"]) && $_GET["filter"] == "alphabetical" ){
	$vendors = selectDB('vendors',"`status` LIKE '0' ORDER BY `enShop` ASC");
	if ( isset($_GET["lang"]) && $_GET["lang"] == "ar"){
		$vendors = selectDB('vendors',"`status` LIKE '0' ORDER BY `arShop` ASC");
	}
}elseif( isset($_GET["filter"]) && $_GET["filter"] == "fast" ){
	$vendors = selectDB('vendors',"`status` LIKE '0' ORDER BY `time` ASC");
}else{
	$vendors = selectDB('vendors',"`status` LIKE '0'");
}
for( $i = 0 ; $i < sizeof($vendors) ; $i++ ){
	$vendors[$i]["id"] = (STRING)$vendors[$i]["id"];
	$vendors[$i]["is_new"] = (STRING)$vendors[$i]["is_new"];
	$vendors[$i]["is_busy"] = (STRING)$vendors[$i]["is_busy"];
	for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
		unset($vendors[$i][$unsetData[$y]]);
	}
}
$response["vendors"] = $vendors;

echo outputData($response);
?>