<style>
	.table thead th {
		vertical-align: middle !important;
	}
</style>

<br><br>
<div class="page-header">
	<div style="background-color:#009688; width:100%; padding:12px; color: #ffff; font-size: 20px; border-radius:5px;">
		Marudham - Search
	</div>

</div><br>

<div class="text-right" style="margin-right: 25px;">
	<!-- <button class="btn btn-primary" id='close_history_card' style="display: none;" >&times;&nbsp;&nbsp;Cancel</button> -->
</div>

<!-- Main container start -->
<div class="main-container">
	<!--form start-->
	<form id="search_module_form" name="search_module_form" action="" method="post" enctype="multipart/form-data">
		<div class="row gutters">
			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
				<div class="card">
					<div class="card-header">Search Customer</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-12">
								<div class="row">
									<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
										<div class="form-group">
											<label for="cus_id">Customer ID</label>
											<input type="text" class="form-control" id="cus_id" name="cus_id" placeholder="Enter Customer ID" maxlength="14">
										</div>
									</div>
									<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
										<div class="form-group">
											<label for="cus_name">Customer Name</label>
											<input type="text" class="form-control" id="cus_name" name="cus_name" placeholder="Enter Customer Name">
										</div>
									</div>
									<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
										<div class="form-group">
											<label for="cus_area">Area</label>
											<input type="text" class="form-control" id="cus_area" name="cus_area" placeholder="Enter Area">
										</div>
									</div>
									<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
										<div class="form-group">
											<label for="cus_sub_area">Sub Area</label>
											<input type="text" class="form-control" id="cus_sub_area" name="cus_sub_area" placeholder="Enter Sub Area">
										</div>
									</div>
									<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
										<div class="form-group">
											<label for="mobile">Mobile Number</label>
											<input type="text" class="form-control" id="mobile" name="mobile" placeholder="Enter Mobile Number">
										</div>
									</div>
									<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12" style="text-align:center">
										<div class="form-group">
											<label for="" style="visibility:hidden"></label>
											<!-- <input type="button" class="form-control btn btn-primary" id="search" name="search" value="Search" data-toggle="modal" data-target="#customerDetailModal"> -->
											<input type="submit" class="form-control btn btn-primary" id="search" name="search" value="Search" onclick="event.preventDefault();">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card " id="customer_list_card" style="display: none;">
					<div class="card-header">Customer List</div>
					<div class="card-body">
						<!-- <div class="col-md-12 ">
							<div class="row">
								<div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-12"></div>
								<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-12">
									<div class="form-group" style="text-align:right;">
										<label>Search</label>
									</div>
								</div>
								<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-12">
									<div class="form-group" style="text-align:left;">
										<input type="text" id="searchbox" name="searchbox" class='form-control' width="50px">
									</div>
								</div>
							</div>
						</div> -->
						<div id="customer_list" style="overflow-x:auto">

						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>


<!-- Modal for Customer Status   -->
<div class="modal fade" id="customerStatusModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-lg " role="document">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">Customer Status</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid" id='customerStatusDiv'>

				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" data-dismiss="modal" tabindex="">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal for Personal Info   -->
<div class="modal fade" id="personalInfoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-lg " role="document" style="height: 90vh;width:300vh;">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">Personal Info</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid row" id='personalInfoDiv'>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" data-dismiss="modal" tabindex="7">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal for Due Chart -->
<div class="modal fade DueChart" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title" id="dueChartTitle"> Due Chart</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="dueChartTableDiv">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal for Penalty Chart -->
<div class="modal fade PenaltyChart" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="height: 90vh;width:300vh;">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title"> Penalty Chart</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="penaltyChartTableDiv">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal for Fine Chart -->
<div class="modal fade collectionChargeChart" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="height: 90vh;width:300vh;">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title"> Fine Chart</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="collectionChargeDiv">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal for Commitment Chart -->
<div class="modal fade" id="commitmentChart" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-lg " role="document" style="height: 90vh;width:300vh;">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title">Commitment Chart</h5>
				<button type="button" class="close" data-dismiss="modal" tabindex="1" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<div id='commChartDiv'></div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" data-dismiss="modal" tabindex="2">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal for Loan Summary -->
<div class="modal fade loansummarychart" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="height: 90vh;width:300vh;">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title" id="myLargeModalLabel"> Loan Summary </h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="loanSummaryDiv">

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal for NOC Summary -->
<div class="modal fade noc-summary-modal " tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen-xl">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title"> NOC Summary </h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="nocsummaryModal">

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="">Close</button>
			</div>
		</div>
	</div>
</div>
<style>
	.modal {
		padding: 0 !important;
	}

	.modal .modal-dialog {
		width: 100%;
		max-width: none;
		/* height: 100%; */
		margin-top: 0;
	}

	.modal .modal-content {
		height: 100%;
		border: 0;
		border-radius: 0;
	}

	.modal .modal-body {
		overflow-y: auto;
	}

	@mixin modal-fullscreen() {
		padding: 0 !important;

		.modal-dialog {
			width: 100%;
			max-width: none;
			height: 100%;
			margin: 0;
		}

		.modal-content {
			height: 100%;
			border: 0;
			border-radius: 0;
		}

		.modal-body {
			overflow-y: auto;
		}

	}

	@each $breakpoint in map-keys($grid-breakpoints) {
		@include media-breakpoint-down($breakpoint) {
			$infix: breakpoint-infix($breakpoint, $grid-breakpoints);

			.modal-fullscreen#{$infix} {
				@include modal-fullscreen();
			}
		}
	}
</style>