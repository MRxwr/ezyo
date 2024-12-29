<?php
if ( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if ( $_GET["type"] == "list" ){
		$settigns = selectDB('settings'," `id` LIKE '1'");
		$response["version"] = (STRING)$settigns[0]["version"];
		$response["enTerms"] = (STRING)$settigns[0]["enTerms"];
		$response["arTerms"] = (STRING)$settigns[0]["arTerms"];
		$response["enPolicy"] = (STRING)$settigns[0]["enPolicy"];
		$response["arPolicy"] = (STRING)$settigns[0]["arPolicy"];
		$response["whatsapp"] = "96551365731";
		if ( isset($_GET["customerId"]) && !empty($_GET["customerId"]) ){
			$customer = selectDB('customers'," `id` LIKE '".$_GET["customerId"]."'");
			$response["wallet"] = (STRING)$customer[0]["wallet"];
		}else{
			$response["wallet"] = "0";
		}
		
		echo outputData($response);
	}elseif( $_GET["type"] == "profile" ){
		if ( isset($_GET["customerId"]) && !empty($_GET["customerId"]) ){
			if( isset($_GET["update"]) && $_GET["update"] == 1 ){
				if ( isset($_GET["name"]) && !empty($_GET["name"]) ){
					$data = array("name" => $_GET["name"]);
					$where = " `id` LIKE '".$_GET["customerId"]."'";
					updateDB('customers',$data,$where);
				}else{
					$error = array("msg" => 'please enter cutomer name correctly');
					echo outputError($error);die();
				}
			}
			$customer = selectDB('customers'," `id` LIKE '".$_GET["customerId"]."'");
			$response["name"] = (STRING)$customer[0]["name"];
			$response["email"] = (STRING)$customer[0]["email"];
			echo outputData($response);
		}else{
			$error = array("msg" => 'please enter cutomer Id');
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "password" ){
		if ( isset($_GET["customerId"]) && !empty($_GET["customerId"]) ){
			if( isset($_GET["update"]) && $_GET["update"] == 1 ){
				if ( (isset($_GET["oldPassword"]) && !empty($_GET["oldPassword"])) && ( isset($_GET["newPassword"]) && !empty($_GET["newPassword"]))  ){
					$customer = selectDB('customers'," `id` LIKE '".$_GET["customerId"]."'");
					if ( sha1($_GET["oldPassword"]) == $customer[0]["password"] ){
						$data = array("password" => sha1($_GET["newPassword"]) );
						$where = " `id` LIKE '".$_GET["customerId"]."'";
						updateDB('customers',$data,$where);
						$response = array("msg" => "password updated successfully");
						echo outputData($response);
					}else{
						$error = array("msg" => 'old password is not a match, please enter old password correctly');
						echo outputError($error);die();
					}
				}else{
					$error = array("msg" => 'please enter old and new passwords correctly');
					echo outputError($error);die();
				}
			}
		}else{
			$error = array("msg" => 'please enter cutomer Id');
			echo outputError($error);die();
		}
	}
}else{
	$error = array("msg" => "Please enter type, 'list', 'profile', 'password'");
	echo outputError($error);die();
}
?>