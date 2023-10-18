<?php
if ( isset($_GET["status"]) ){
	
	$array = selectDB('orders', " `id` LIKE '".$_GET["id"]."'");
	$array1 = selectDB('vendors', " `id` LIKE '".$array[0]["vendorId"]."'");
	if ( $array1[0]["id"] != $userId ){
		?>
	<script>
		//window.location.href = "?page=logout";
	</script>
	<?php
	}
	
	$table = "orders";
	$data = array('status'=> $_GET["status"] );
	$where = "`id` LIKE '".$_GET["id"]."'";
	updateDB($table,$data,$where);
	
	updateOrderStatusNotification($array[0]["orderId"],$_GET["status"]);
	/*
	if ( $_GET["status"] == 6 ){
		$array = selectDB('orders',"`id` LIKE '".$_GET["id"]."'");
		$array1 = selectDB('customers',"`id` LIKE '".$array[0]["customerId"]."'");
		updateDB('customers',array('wallet'=>($array1[0]["wallet"]+$array[0]["price"])),"`id` LIKE '".$array[0]["customerId"]."'");
	}
	*/
}
?>

<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid pt-25">
		<!-- Row -->
		
		<div class="row">
		
			
<!-- /Title -->

<!-- Row -->
<?php
$status 		= array('0','1');
$arrayOfTitles 	= array('List Of Orders','Inactive Addresses');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

$btnArray = ['primary','default','warning','success','danger','info'];
$iconArray = ['money','clock-o','car','check','times','refresh'];
$actions = array('btn'=>$btnArray, 'icon'=>$iconArray);
for($i = 0; $i < 1 ; $i++ ){
?>

<div class="row">
<div class="col-sm-12">
<div class="panel <?php echo $panel[$i] ?> card-view">
<div class="panel-heading">
<div class="pull-left">
<h6 class="panel-title <?php echo $textColor[$i] ?>"><?php echo $arrayOfTitles[$i] ?></h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="table-wrap">
<div class="">

<table id="<?php echo $myTable[$i] ?>" class="table table-hover display  pb-30" >
<thead>
<tr>
<th>Order</th>
<th>Date</th>
<th>Delivery</th>
<th>Customer</th>
<th>Vendor</th>
<!--<th>Voucher</th>
<th>Method</th>-->
<th>Price</th>
<th>Mobile</th>
<th>Status</th>
<th>Actions</th>
</tr>
</thead> 
<tbody>
<?php
$sql = "SELECT o.*, c.name, v.code, ven.enShop
		FROM `orders` as o
		JOIN `customers` as c
		ON o.customerId = c.id
		JOIN `vendors` as ven
		ON o.vendorId = ven.id
		LEFT JOIN `vouchers` as v
		ON o.voucherId = v.id
		WHERE
		o.status != '0'
		GROUP BY o.orderId
		";
if ( isset($_COOKIE["ezyoVCreate"]) ){
	$sql = "SELECT o.*, c.name, v.code, ven.enShop
			FROM `orders` as o
			JOIN `customers` as c
			ON o.customerId = c.id
			JOIN `vendors` as ven
			ON o.vendorId = ven.id
			LEFT JOIN `vouchers` as v
			ON o.voucherId = v.id
			WHERE
			o.vendorId LIKE '".$userId."'
			AND
			o.status != '0'
			GROUP BY o.orderId
			";
}
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	if ( $row["status"] == 1 ){
		$orderStatus = "Paid";
	}elseif( $row["status"] == 2 ){
		$orderStatus = "Preparing";
	}elseif( $row["status"] == 3 ){
		$orderStatus = "Out for delivery";
	}elseif( $row["status"] == 4 ){
		$orderStatus = "Delivered";
	}elseif( $row["status"] == 5 ){
		$orderStatus = "Canceled";
	}elseif( $row["status"] == 6 ){
		$orderStatus = "Refunded";
	}elseif( $row["status"] == 7 ){
		$orderStatus = "Failed";
	}
	
	if ( $row["paymentMethod"] == 1 ){
		$paymentMethod = "K-net";
	}elseif( $row["paymentMethod"] == 2 ){
		$paymentMethod = "Visa/Master";
	}else{
		$paymentMethod = "Wallet";
	}
?>
<tr>
<td><a href="?page=orderView&id=<?php echo $row["orderId"] ?>" target="_blank"><?php echo $row["orderId"] ?></a></td>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["deliveryDate"] ?></td>
<td><?php echo $row["name"] ?></td>
<td><?php echo $row["enShop"] ?></td>
<!--<td><?php if ( !empty($row["code"]) ){ echo $row["code"]; }else{ echo "None";} ?></td>
<td><?php echo $paymentMethod ?></td>-->
<td><?php echo $row["price"]+$row["delivery"]+$row["service"] ?>KD</td>
<td><a href="tel:<?php echo $row["mobile"] ?>"><?php echo $row["mobile"] ?></a></td>
<td>
<button class="btn btn-<?php echo $btnArray[$row["status"]-1] ?> btn-rounded btn-lable-wrap right-label btn-sm" style="width: 100%;"><span class="btn-text btn-sm"><?php echo $orderStatus ?></span> <span class="btn-label btn-sm"><i class="fa fa-<?php echo $iconArray[$row["status"]-1] ?>"></i> </span></button>
</td>
<td>

<?php
if ( $row["status"] == 5 || $row["status"] == 6 ){
	for( $y = 0 ; $y <= 7 ; $y++ ){
		$z = $y+1;
		if ( $row["status"] != $z ){
		?>
		<a href="?page=orders&id=<?php echo $row["id"] ?>&status=<?php echo $z ?>" style="margin:3px" class="btn btn-<?php echo $actions["btn"][$y] ?> btn-icon-anim btn-square btn-sm"><i class="fa fa-<?php echo $actions["icon"][$y] ?>"></i></a>
		<?php
		}
	}
}else{
	for( $y = 0 ; $y <= 7 ; $y++ ){
		$z = $y+1;
		if ( $row["status"] <= $y ){
		?>
		<a href="?page=orders&id=<?php echo $row["id"] ?>&status=<?php echo $z ?>" style="margin:3px" class="btn btn-<?php echo $actions["btn"][$y] ?> btn-icon-anim btn-square btn-sm"><i class="fa fa-<?php echo $actions["icon"][$y] ?>"></i></a>
		<?php
		}
	}
}
?>
</td>
</tr>
<?php
}
?>
</tbody>
</table>

</div>
</div>
</div>
</div>
</div>	
</div>
</div>
<?php
}
?>		
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