<?php
if ( isset($_COOKIE["ezyoVCreate"])  && !isset($_GET["edit"]) ){
	$array = selectDB('categories', " `id` LIKE '".$_GET["id"]."'");
	if ( $array[0]["vendorId"] != $userId ){
		?>
	<script>
		window.location.href = "?page=logout";
	</script>
	<?php
	}

}
if ( isset($_COOKIE["ezyoVCreate"])  && isset($_GET["edit"]) ){
	$array = selectDB('items', " `id` LIKE '".$_GET["id"]."'");
	$array1 = selectDB('categories', " `id` LIKE '".$array[0]["categoryId"]."'");
	if ( $array1[0]["vendorId"] != $userId ){
		?>
	<script>
		window.location.href = "?page=logout";
	</script>
	<?php
	}

}

if ( isset($_POST["enTitle"]) && !isset($_POST["edit"]) ){
	$table = "items";
	insertDB($table,$_POST);
	?>
	<script>
		window.location.href = "?page=items&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["delete"]) ){
	$table = "items";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=items&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["return"]) ){
	$table = "items";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=items&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["edit"]) ){
	$table = "items";
	$where = "`id` LIKE '".$_GET["id"]."'";
	$data = selectDB($table,$where);
}

if ( isset($_POST["edit"]) ){
	$table = "items";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	unset($_POST["edit"]);
	$data = $_POST;
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=items&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
?>

<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid pt-25">
		<!-- Row -->
		
		<div class="row">
		
			
<!-- /Title -->

<div class="row">

<div class="col-md-12">
<div class="panel panel-default card-view">
<div class="panel-heading">
<div class="pull-left">
<h6 class="panel-title txt-dark">Item Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=items&id=<?php echo $_GET["id"] ?>" method="post" enctype="multipart/form-data">

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">English Title</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Full Name" name="enTitle" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["enTitle"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Arabic Title</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="arTitle" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["arTitle"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">English Details</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Full Name" name="enDetails" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["enDetails"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Arabic Details</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="arDetails" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["arDetails"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-3">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Quantity</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="number" class="form-control" id="exampleInputuname_1" placeholder="Full Name" name="quantity" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["quantity"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Price</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="price" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["price"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Discount</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="discount" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["discount"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-3">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Video</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="video" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["video"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="categoryId" value="<?php echo $_GET["id"] ?>">
<input type="hidden" name="date" value="<?php echo $date ?>">
<?php if(isset($_GET["edit"])){?>
<input type="hidden" name="edit" value="<?php echo $_GET["id"] ?>">
<?php }?>
</div>

</form>

</div>
</div>
</div>
</div>
</div>
</div>
</div>

</div>

<!-- Row -->
<?php
if ( !isset($_GET["edit"]) ){
$status 		= array('0','1');
$arrayOfTitles 	= array('Active Items','Inactive Items');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

for($i = 0; $i < 2 ; $i++ ){
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
<th>Date</th>
<th>English Title</th>
<th>Arabic Title</th>
<th>Quantity</th>
<th>Price</th>
<th>Discount</th>
<th>Video</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `items`
		WHERE
		status = '".$status[$i]."'
		AND
		categoryId LIKE '".$_GET["id"]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["enTitle"] ?></td>
<td><?php echo $row["arTitle"] ?></td>
<td><?php echo $row["quantity"] ?></td>
<td><?php echo $row["price"] ?>KD</td>
<td><?php echo $row["discount"] ?>%</td>
<td><?php if ( !empty($row["video"]) ){ echo '<a href="'.$row["video"].'" target="_blank">View</a>'; }else{ echo "None";} ?></td>
<td>

<a href="?page=items&edit=1&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=images&edit=1&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-file-image-o"></i></a>

<a href="?page=items&id=<?php echo $_GET["id"] ?>&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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