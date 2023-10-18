<?php
if ( !isset($_GET["page"]) ){
	require_once('pages/home.php');
}elseif( $_GET["page"] == "home" ){
	require_once('pages/home.php');
}elseif( $_GET["page"] == "vendors" ){
	require_once('pages/vendors.php');
}elseif( $_GET["page"] == "categories" ){
	require_once('pages/categories.php');
}elseif( $_GET["page"] == "items" ){
	require_once('pages/items.php');
}elseif( $_GET["page"] == "settings" ){
	require_once('pages/settings.php');
}elseif( $_GET["page"] == "tags" ){
	require_once('pages/tags.php');
}elseif( $_GET["page"] == "employees" ){
	require_once('pages/employees.php');
}elseif( $_GET["page"] == "addTags" ){
	require_once('pages/addTags.php');
}elseif( $_GET["page"] == "images" ){
	require_once('pages/images.php');
}elseif( $_GET["page"] == "vouchers" ){
	require_once('pages/vouchers.php');
}elseif( $_GET["page"] == "users" ){
	require_once('pages/users.php');
}elseif( $_GET["page"] == "addresses" ){
	require_once('pages/addresses.php');
}elseif( $_GET["page"] == "orders" ){
	require_once('pages/orders.php');
}elseif( $_GET["page"] == "orderView" ){
	require_once('pages/orderView.php');
}elseif( $_GET["page"] == "logout" ){
	require_once('pages/logout.php');
}elseif( $_GET["page"] == "profile" ){
	require_once('pages/profile.php');
}elseif( $_GET["page"] == "reports" ){
	require_once('pages/reports.php');
}elseif( $_GET["page"] == "adminReports" ){
	require_once('pages/adminReports.php');
}elseif( $_GET["page"] == "banners" ){
	require_once('pages/banners.php');
}elseif( $_GET["page"] == "localization" ){
	require_once('pages/localization.php');
}elseif( $_GET["page"] == "notification" ){
	require_once('pages/notification.php');
}elseif( $_GET["page"] == "times" ){
	require_once('pages/times.php');
}else{
	require_once('pages/home.php');
}
?>