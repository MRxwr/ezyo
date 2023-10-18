<?php
header("Content-Type: application/json");
require_once('../admin/includes/config.php');
require_once('../admin/includes/functions.php');
/*
if ( isset(getallheaders()["ezyocreate"]) ){
	$headerAPI =  getallheaders()["ezyocreate"];
}else{
	$error = array("msg"=>"Please set headres");
	echo outputError($error);die();
}

if ( $headerAPI != "CreateEZYo" ){
	$error = array("msg"=>"APIKEY value is wrong");
	echo outputError($error);die();
}*/

$unsetData = ["userId","status","date", "username", "password", "cookie", "name", "type", "email", "forgetPassword"];

if( isset($_GET["action"]) && $_GET["action"] == "home" ){
	require("home.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "user" ){
	require("user.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "settings" ){
	require("settings.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "order" ){
	require("order.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "drivers" ){
	require("drivers.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "dashboard" ){
	require("dashboard.php");
}else{
	$error = array("msg"=>"please select the correct action");
	echo outputError($error);die();
}
?>