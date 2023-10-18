<?php
if ( isset($_POST["vendorId"]) ){
	$allTags = selectDB('tags'," `id` != '0' ");
	var_dump($_POST);
	$table = "tags_vendors";
	$data = array('status'=>'1');
	$where = " `vendorId` LIKE '".$_POST["vendorId"]."'";
	updateDB($table,$data,$where);
	$vendorId = $_POST["vendorId"];
	for( $i=0; $i < sizeof($allTags); $i++){
		if(isset($_POST["tagId$i"])){
			$tags[] = $_POST["tagId$i"];
		}
	}
	unset($_POST);
	for( $i=0; $i < sizeof($tags); $i++){
		$_POST["vendorId"] = $vendorId;
		$_POST["tagId"] = $tags[$i];
		var_dump($_POST);
		insertDB($table,$_POST);
	}
	?>
	<script>
		window.location.href = "?page=vendors";
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
<h6 class="panel-title txt-dark">Select Tags for vendor</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=addTags" method="post" enctype="multipart/form-data">

<?php
$array = selectDB('tags'," `id` != '0' ");
@$array1 = selectDB('tags_vendors'," `vendorId` LIKE '".$_GET["id"]."' AND `status` LIKE '0' ");
for ($i=0 ; $i < sizeof($array) ; $i++){
	@$tags[] = $array1[$i]["tagId"];
}
for ($i=0 ; $i < sizeof($array) ; $i++){
	if ( @in_array($array[$i]["id"],$tags) ){
		$checked = "checked";
	}else{
		$checked = "";
	}
?>
<div class="col-md-2">
<div class="form-group">
<div class="input-group">
<div>
  <input type="checkbox" id="<?php echo $array[$i]["enTitle"] ?>" name="tagId<?php echo $i?>" <?php echo $checked ?> value="<?php echo $array[$i]["id"] ?>">
  <label for="<?php echo $array[$i]["enTitle"] ?>"><?php echo $array[$i]["enTitle"] ?></label>
</div>
</div>
</div>
</div>

<?php
}
?>
<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
</div>

<input type="hidden" name="vendorId" value="<?php echo $_GET["id"] ?>" required>
</form>

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