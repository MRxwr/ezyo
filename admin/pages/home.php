<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid pt-25">
		<!-- Row -->
		
		<div class="row">
		
			<div class="col-md-12">			
			<div class="row">
<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php echo sizeof(selectDB("customers","`type` LIKE '0'")) ?></span></span>
		<span class="weight-500 uppercase-font block font-13">USERS</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 data-wrap-right">
		<i class="icon-user-following data-right-rep-icon txt-light-blue" style="color:darkblue"></i>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php echo sizeof(selectDB("customers","`type` LIKE '3'")) ?></span></span>
		<span class="weight-500 uppercase-font block font-13">GUESTS</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 data-wrap-right">
		<i class="fa fa-users data-right-rep-icon txt-light-grey" ></i>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php echo sizeof(selectDB("vendors","`status` LIKE '0'")) ?></span></span>
		<span class="weight-500 uppercase-font block font-13">VENDORS</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 data-wrap-right">
		<i class="fa fa-bank data-right-rep-icon txt-light-orange" style="color:orange"></i>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php echo sizeof(selectDB("items","`status` LIKE '0'")) ?></span></span>
		<span class="weight-500 uppercase-font block font-13">Items</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 data-wrap-right">
		<i class="fa fa-reorder data-right-rep-icon txt-light-black" style="color:black"></i>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php echo sizeof(selectDB("orders","`status` NOT LIKE '0'")) ?></span></span>
		<span class="weight-500 uppercase-font block font-13">Orders</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 pt-25  data-wrap-right">
		<div class="sp-small-chart" id="sparkline_4"><canvas width="115" height="50" style="display: inline-block; width: 115px; height: 50px; vertical-align: top;"></canvas></div>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php echo sizeof(selectDB("orders","`status` LIKE '4'")) ?></span></span>
		<span class="weight-500 uppercase-font block font-13">Successful</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 data-wrap-right">
		<i class="fa fa-thumbs-up data-right-rep-icon txt-light-red" style="color:green"></i>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php echo sizeof(selectDB("orders","`status` LIKE '5'")) ?></span></span>
		<span class="weight-500 uppercase-font block font-13">CANCELED</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 data-wrap-right">
		<i class="fa fa-thumbs-down data-right-rep-icon txt-light-red" style="color:red"></i>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
<div class="panel panel-default card-view pa-0">
<div class="panel-wrapper collapse in">
<div class="panel-body pa-0">
<div class="sm-data-box">
<div class="container-fluid">
<div class="row">
	<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
		<span class="txt-dark block counter"><span class="counter-anim"><?php $get = selectDashDB("SUM(price) as realPrice","orders","`status` NOT LIKE '0' OR `status` NOT LIKE '5' OR `status` NOT LIKE '6' GROUP BY `orderId`"); echo $get[0]["realPrice"]?></span>KD</span>
		<span class="weight-500 uppercase-font block font-13">Earnings</span>
	</div>
	<div class="col-xs-6 text-center  pl-0 pr-0 data-wrap-right">
		<i class="fa fa-money data-right-rep-icon txt-light-red" style="color:darkgreen"></i>
	</div>
</div>	
</div>
</div>
</div>
</div>
</div>
</div>

</div>
			</div>
			
		</div>
		
		<!-- /Row -->
	</div>

<!-- Footer -->
	<footer class="footer container-fluid pl-30 pr-30">
		<div class="row">
			<div class="col-sm-12">
				<p>2021 &copy; Create Co.</p>
			</div>
		</div>
	</footer>
	<!-- /Footer -->
	
</div>
<!-- /Main Content -->