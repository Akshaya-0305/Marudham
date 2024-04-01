
<!-- Page header start -->
<br><br>
<div class="page-header">
    <div style="background-color:#009688; width:100%; padding:12px; color: #ffff; font-size: 20px; border-radius:5px;">
		Marudham -  Users List 
	</div>
</div><br>
<div class="text-right" style="margin-right: 25px;">
    <a href="manage_user">
        <button type="button" class="btn btn-primary"><span class="icon-add"></span>&nbsp; Add User</button>
    </a>
</div><br><br>
<!-- Page header end -->

<!-- Main container start -->
<div class="main-container">
	<!-- Row start -->
	<div class="row gutters">
		<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
			<div class="table-container">

				<div class="table-responsive">
					<?php
					$mscid=0;
					if(isset($_GET['msc']))
					{
					$mscid=$_GET['msc'];
					if($mscid==1)
					{?>
					<div class="alert alert-success" role="alert">
						<div class="alert-text">User Added Successfully!</div>
					</div> 
					<?php
					}
					if($mscid==2)
					{?>
						<div class="alert alert-success" role="alert">
						<div class="alert-text">User Updated Successfully!</div>
					</div>
					<?php
					}
					if($mscid==3)
					{?>
					<div class="alert alert-danger" role="alert">
						<div class="alert-text">User Inactive Successfully!</div>
					</div>
					<?php
					}
					}
					?>
					<table id="manage_user_table" class="table custom-table">
						<thead>
							<tr>
								<th width="50">S.No.</th>
								<th>Role</th>
								<th>Role Type</th>
								<th>Name</th>
								<th>User ID</th>
								<th>Company Name</th>
								<th>Branch Name</th>
								<th>Line Name</th>
								<th>Group Name</th>
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
		// Loan category datatable
		var manage_user_table = $('#manage_user_table').DataTable();
		manage_user_table.destroy();
		var manage_user_table = $('#manage_user_table').DataTable({
			"order": [[ 0, "desc" ]],
			"ordering": false,
			'paging':false,
			'processing': true,
			'serverSide': true,
			'serverMethod': 'post',
			'ajax': {
			'url': 'ajaxFetch/ajaxManageUserFetch.php',
			'data': function(data) {
				var search = $('input[type=search]').val();
				data.search = search;
			}
			},
			dom: 'lBfrtip',
			buttons: [
			{
				extend: 'excel',
				title: "Manage Users List"
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
