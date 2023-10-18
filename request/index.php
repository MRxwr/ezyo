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
}elseif( isset($_GET["action"]) && $_GET["action"] == "filter" ){
	require("filter.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "search" ){
	require("search.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "vendor" ){
	require("vendor.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "item" ){
	require("item.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "cart" ){
	require("cart.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "voucher" ){
	require("voucher.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "address" ){
	require("address.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "checkout" ){
	require("checkout.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "order" ){
	require("order.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "settings" ){
	require("settings.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "success" ){
	require("success.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "user" ){
	require("user.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "failure" ){
	require("failure.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "localization" ){
	require("localization.php");
}elseif( isset($_GET["page"]) && $_GET["page"] == "success" ){
	require("success.php");
}elseif( isset($_GET["page"]) && $_GET["page"] == "failure" ){
	require("failure.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "hide" ){
	require("hide.php");
}else{
	$error = array("msg"=>"please select the correct action");
	echo outputError($error);die();
}
?>