
<!-- Page header start -->
<br><br>
<div class="page-header">
    <div style="background-color:#009688; width:100%; padding:12px; color: #ffff; font-size: 20px; border-radius:5px;">
		Marudham -  Collection
	</div>
</div><br>
<!-- <div class="text-right" style="margin-right: 25px;">
    <a href="verification">
        <button type="button" class="btn btn-primary"><span class="icon-add"></span>&nbsp; Add verification</button>
    </a>
</div><br><br> -->
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
					$id=$_GET['id'];
					if($mscid==1 and $id !='')
					{?>
					<div class="alert alert-success" role="alert">
						<div class="alert-text"> Collection Submitted Successfully! </div>
						<!-- To show print page and assign id value as collection id from collection.php -->
						<input type="hidden" id='id' name='id' value=<?php echo $id;?>>
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
					
					}else{ //for print page not to show define id as 0
						?>
						<input type="hidden" id='id' name='id' value=<?php echo $id;?>>
						<?php
					}
					?>
					<table id="collection_table" class="table custom-table" >
						<thead>
							<tr>
								<th width="50">S.No.</th>
								<th>Customer ID</th>
								<th>Customer Name</th>
								<th>Area</th>
								<th>Sub Area</th>
								<th>Branch</th>
								<th>Line</th>
								<th>Mobile</th>
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
<div id="printcollection" style="display: none"></div>


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
	var id = $('#id').val();
	if(id != 0){
		setTimeout(()=>{
			Swal.fire({
				title: 'Print',
				text: 'Do you want to print this collection?',
				// icon: 'question',
				// showConfirmButton: true,
				// confirmButtonColor: '#009688',
				imageUrl: 'img/printer.png',
				imageWidth: 300,
				imageHeight: 210,
				imageAlt: 'Custom image',
				showCancelButton: true,
				confirmButtonColor: '#009688',
				cancelButtonColor: '#d33',
				cancelButtonText: 'No',
				confirmButtonText: 'Yes'
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						url:'collectionFile/print_collection.php',
						data:{'coll_id':id},
						type:'post',
						cache:false,
						success:function(html){
							$('#printcollection').html(html)
							// Get the content of the div element
							var content = $("#printcollection").html();

							// Create a new window
							var w = window.open();

							// Write the content to the new window
							$(w.document.body).html(content);

							// Print the new window
							w.print();

							// Close the new window
							w.close();
						}
					})
				}
			})
		},2000)
	}
</script>