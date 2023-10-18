<?php
if( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if($_GET["type"] == "list"){
		if( $drivers = selectDB('user',"`type` = '2' AND `status` = '0'") ){
			for( $i=0; $i < sizeof($drivers); $i++){
				$response["drivers"][$i]["id"] = $drivers[$i]["id"];
				$response["drivers"][$i]["name"] = $drivers[$i]["name"];
				$response["drivers"][$i]["mobile"] = str_replace("+","",$drivers[$i]["mobile"]);
				if( $orders = selectDB('orders',"`driverId` = '{$drivers[$i]["id"]}' AND `status` = '3'") ){
					$response["drivers"][$i]["orders"] = sizeof($orders);
				}else{
					$response["drivers"][$i]["orders"] = 0;
				}
			}
			echo outputData($response);die(); 
		}else{
			if( isset($_GET["lang"]) && $_GET["lang"] == "ar"){
				$response["msg"] = "لا يوجد سواق متاحين";
			}else{
				$response["msg"] = "No drivers are available";
			}
			echo outputError($response);die();
		}
	}else{
		$response["msg"] = "Please select type of `list`";
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please select type of `list`";
	echo outputError($response);die(); 
}
?>