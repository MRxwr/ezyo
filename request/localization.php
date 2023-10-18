<?php
$language = selectDB('localization',"");
for( $i = 0 ; $i < sizeof($language) ; $i++ ){
	unset($language[$i]["id"]);
	unset($language[$i]["date"]);
	if ( isset($_GET["lang"]) && $_GET["lang"] == "en" ){
		$response["language"][$language[$i]["screen"]][] = array (
		"title" => $language[$i]["enTitle"]);
	}elseif( isset($_GET["lang"]) && $_GET["lang"] == "ar"  ){
		$response["language"][$language[$i]["screen"]][] = array (
		"title" => $language[$i]["arTitle"]);
	}else{
		$response["language"][$language[$i]["screen"]][] = array (
		"enTitle" => $language[$i]["enTitle"],
		"arTitle" => $language[$i]["arTitle"]);
	}
}

echo outputData($response);
?>