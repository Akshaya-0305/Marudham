
<!-- Page header start -->
<br><br>
<div class="page-header">
    <div style="background-color:#009688; width:100%; padding:12px; color: #ffff; font-size: 20px; border-radius:5px;">
		Marudham - Concern Creation
	</div>
</div><br>

<?php 
@session_start();
include('ajaxconfig.php');

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}
    
$userQry = $con->query("SELECT 1 FROM USER WHERE user_id = '$userid' && role ='3'"); // Check Whether the user is staff or not ,if not means concern screen will not be show.
$rowuser = mysqli_num_rows($userQry);
if($rowuser > 0){ 
?>

	<div class="text-right" style="margin-right: 25px;">
    <a href="concern_creation">
        <button type="button" class="btn btn-primary"><span class="icon-add"></span>&nbsp; Add Concern Creation</button>
    </a>
</div><br><br>
<!-- Page header end -->

<!-- Main container start -->
<div class="main-container" >
	<!-- Row start -->
	<div class="row gutters">
		<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
			<div class="table-container" >

				<div class="table-responsive">
					<?php
					$mscid=0;
					$id=0;
					if(isset($_GET['msc']))
					{
					$mscid=$_GET['msc'];
					if($mscid==1)
					{?>
					<div class="alert alert-success" role="alert">
						<div class="alert-text"> Concern Submitted Successfully! </div>
					</div> 
					<?php
					}
					if($mscid==2)
					{?>
						<div class="alert alert-success" role="alert">
						<div class="alert-text"> Collection Removed Successfully! </div>
					</div>
					<?php
					}
					
					}
					?>
					<table id="concern_table" class="table custom-table" >
						<thead>
							<tr>
								<th width="50">S.No.</th>
								<th>Concern Code</th>
								<th>Concern Date</th>
								<th>Branch Name</th>
								<th>Staff Assign</th>
								<th>Subject</th>
								<th>Status</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- Row end -->
</div>
<!-- Main container end -->
 <?php }else{?> 
	
	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
		<div class="card">
			<div class="card-header" style="text-align: center;">  </div>
			<div class="card-body">
				<div class="row">

					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" >
						<div class="form-group">
							<h4 style="display: flex; justify-content: center; align-items: center; font-weight: bold;"> Concern Creation is only for Staffs </h4>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<?php } ?>

<script>
	var sortOrder = 1; // 1 for ascending, -1 for descending

	document.querySelectorAll('th').forEach(function(th) {
	th.addEventListener('click', function() {
		var columnIndex = this.cellIndex;
		document.querySelector('tbody').innerHTML = '';
		dT();
		setTimeout(function() {
		var tableRows = Array.prototype.slice.call(document.querySelectorAll('tbody tr'));

		tableRows.sort(function(a, b) {
			var textA = a.querySelectorAll('td')[columnIndex].textContent.toUpperCase();
			var textB = b.querySelectorAll('td')[columnIndex].textContent.toUpperCase();

			if (textA < textB) {
			return -1 * sortOrder;
			}
			if (textA > textB) {
			return 1 * sortOrder;
			}
			return 0;
		});

		tableRows.forEach(function(row) {
			document.querySelector('tbody').appendChild(row);
		});

		sortOrder = -1 * sortOrder;

		// update the serial numbers
		document.querySelectorAll('tbody tr').forEach(function(row, index) {
			row.querySelectorAll('td')[0].textContent = index + 1;
		});
		}, 1000);
	});
	});

	function dT() {
		// Collection datatable
		var collection_table = $('#collection_table').DataTable();
		collection_table.destroy();
		var collection_table = $('#collection_table').DataTable({
			"order": [[ 0, "desc" ]],
			"ordering": false,
			'paging':false,
			'processing': true,
			'serverSide': true,
			'serverMethod': 'post',
			'ajax': {
			'url': 'ajaxFetch/ajaxCollectionFetch.php',
			'data': function(data) {
				var search = $('input[type=search]').val();
				data.search = search;
			}
			},
			dom: 'lBfrtip',
			buttons: [
			{
				extend: 'excel',
				title: "Collection List"
			},
			{
				extend: 'colvis',
				collectionLayout: 'fixed four-column',
			}
			],
			"lengthMenu": [
			[10, 25, 50, -1],
			[10, 25, 50, "All"]
			],
			// "columnDefs": [ {
			//     "targets": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18],
			//     "orderable": false
			// } ]

		});
	}

</script>