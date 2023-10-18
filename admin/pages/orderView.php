<?php
	$array = selectDB('orders'," `orderId` LIKE '".$_GET["id"]."' ");
?>

<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid">
		<!-- Row -->
		
		<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default card-view">
				<div class="panel-heading">
					<div class="pull-left">
						<h6 class="panel-title txt-dark">Invoice</h6>
					</div>
					<div class="pull-right">
						<h6 class="txt-dark">Order # <?php echo $array[0]["orderId"] ?></h6>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<div class="row">
							
							<div class="col-xs-6">
								<span class="txt-dark head-font inline-block capitalize-font mb-5 text-center"> 
								<?php
								$vendor = selectDB('vendors',"`id` LIKE '".$array[0]["vendorId"]."'");
								?>
								<img src="logos/<?php echo $vendor[0]["logo"] ?>" style="width:50px;height:50px">
								
								<br>Vendor: 
								<?php
								$vendor = selectDB('vendors',"`id` LIKE '".$array[0]["vendorId"]."'");
								echo $vendor[0]["enShop"];
								?>
								
								<address>
									<span class="txt-dark head-font capitalize-font mb-5">Date:</span>
									<?php echo $array[0]["date"] ?><br><br>
								</address>
								
								</span>
							</div>
							
							<div class="col-xs-6 text-right">
								<span class="txt-dark head-font inline-block capitalize-font mb-5">Delivery:</span>
								<address class="mb-15">
									
								<?php
								$address = selectDB('addresses',"`id` LIKE '".$array[0]["addressId"]."'");
								$address= $address[0];
								$keys = array_keys($address);
								for ( $i = 0 ; $i < sizeof($keys) ; $i++ ){
									if ( $i > 3 && !empty($address[$keys[$i]]) ){
										echo $keys[$i] . ": " . $address[$keys[$i]] ;
										if ( $i != sizeof($keys)-2 ){
											echo ",<br>";
										}
									}
								}
								?>
									
								</address>
							</div>
						</div>
												
<div class="invoice-bill-table">
<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Item</th>
				<th>Price</th>
			</tr>
		</thead>
		<tbody>
			<?php
			for ( $i = 0 ; $i < sizeof($array) ; $i++ ){
			?>
				<tr>
					<td>
					<?php
					echo $array[$i]["quantity"] . "x";
					$item = selectDB('items',"`id` LIKE '".$array[$i]["itemId"]."'");
					echo $item[0]["enTitle"];
					?>
					</td>
					<td>
					<?php
					echo $itemPriceDB = (((100-$array[$i]["itemDiscount"])/100)*$array[$i]["itemPrice"]);
					$subTotal[] = $itemPriceDB;
					?>KD
					</td>
				</tr>
			<?php
			}
			?>
			<tr class="txt-dark">
				<td>Subtotal</td>
				<td><?php echo array_sum($subTotal); ?>KD</td>
			</tr>
			<?php
			if ($array[0]["voucherId"] != 0){
			$voucher = selectDB('vouchers',"`id` LIKE '".$array[0]["voucherId"]."'");
			?>				
			<tr class="txt-dark">
				<td>Voucher</td>
				<td><?php echo $voucher[0]["code"] ?></td>
			</tr>
			<?php
			}
			if($array[0]["voucherDiscount"] != 0){
			?>
			<tr class="txt-dark">
				<td>Discount</td>
				<td><?php echo $array[0]["voucherDiscount"] ?>%</td>
			</tr>
			<?php
			}
			?>
			<tr class="txt-dark">
				<td>Delivery</td>
				<td><?php echo $array[0]["delivery"] ?>KD</td>
			</tr>
			<tr class="txt-dark">
				<td>Service Charges</td>
				<td><?php echo $array[0]["service"] ?>KD</td>
			</tr>
			<tr class="txt-dark">
				<td>Total</td>
				<td><?php echo $array[0]["price"]+$array[0]["delivery"]+$array[0]["service"] ?>KD</td>
			</tr>
			<tr class="txt-dark">
				<td>Delivery time</td>
				<td><?php if ( !empty($array[0]["deliveryDate"]) ){ echo "{$array[0]["deliveryDate"]} {$array[0]["time"]}";}else{ $explode = explode(" ",$array[0]["date"]); echo $explode[0]; } ?></td>
			</tr>
		</tbody>
	</table>
	</div>
							<div class="button-list pull-right">
								<!--<button type="button" class="btn btn-primary btn-outline btn-icon left-icon" onclick="javascript:window.print();"> 
									<i class="fa fa-print"></i><span> Print</span> 
								</button>-->
							</div>
							<div class="clearfix"></div>
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
			
		</div>
	</footer>
	<!-- /Footer -->
	
</div>
<!-- /Main Content -->