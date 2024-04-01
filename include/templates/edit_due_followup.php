<script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
<style>
	.filter-btn-div{
		float:right;
		padding-bottom: 10px;
		padding-right: 10px;
	}
	.filter-btn{
		color: #ffffff;
		background-color: #009688;
		border-color: #009688;
		border-bottom: 1px solid rgba(0, 0, 0, 0.2);
		border-radius: 3px;
		border: 1px solid transparent;
		font-size: 17px;
		padding: 7px 12px;
	}
</style>

<!-- Page header start -->
<br><br>
<div class="page-header">
    <div style="background-color:#009688; width:100%; padding:12px; color: #ffff; font-size: 20px; border-radius:5px;">
		Marudham -  Due Follow Up
	</div>
</div>
<br><br>

<input type="hidden" name="pending_sts" id="pending_sts" value="" />
<input type="hidden" name="od_sts" id="od_sts" value="" />
<input type="hidden" name="due_nil_sts" id="due_nil_sts" value="" />
<input type="hidden" name="closed_sts" id="closed_sts" value="" />
<input type="hidden" name="balAmnt" id="balAmnt" value="" />


<!-- Main container start -->
<div class="main-container" >
	<!-- Row start -->
	<div class="row gutters">
		<div class="col-12">
			<!-- <div class="filter-btn-div">
				<button class="filter-btn" data-target="#filter_modal" data-toggle="modal"><i class="fas fa-filter fa-sm" style="color: #ffffff;"></i>&nbsp;Filter</button>
			</div> -->
		</div>
		<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
			<div class="table-container" ><br>
				<div class="table-responsive" id='dueFollwupDiv'>
					
				</div>
			</div>
		</div>
	</div>
	<!-- Row end -->
</div>
<!-- Main container end -->

<!-- Modal for Filter By contents   -->
<div class="modal fade" id="filter_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-md modal-dialog-centered" role="document">
		<div class="modal-content" style="background-color: white">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">Filter By</h5>
				<button type='button' class="close close-modal" data-dismiss="modal" tabindex="1" aria-label="Close" >
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="filter_form" name="filter_form" method="post" action="">
				<div class="modal-body">
					<div class="container-fluid">
						<div class="col-12" >
							<div class="row">
								
								<div class="col-12">
									<div class="alert alert-danger" role="alert" id='alert_text' style="display: none;">
										<div class="alert-text"> Please Select Any one option to Apply Filter! </div>
									</div>
									<div class="form-group">
										<label for="filter_by" style="float:left"><b>By Area</b></label><br>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_branch" name="by_branch" tabindex='1'>
											<option value="">Select Branch Name</option>
										</select>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_line" name="by_line" tabindex='2'>
											<option value="">Select Line</option>
										</select>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_area" name="by_area" tabindex='3'>
											<option value="">Select Area Name</option>
										</select>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_sub_area" name="by_sub_area" tabindex='4'>
											<option value="">Select Sub Area Name</option>
										</select>
									</div>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<label for="filter_by" style="float:left"><b>By Loan</b></label><br>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_loan_cat" name="by_loan_cat" tabindex='5'>
											<option value="">Select Loan Category</option>
										</select>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_sub_cat" name="by_sub_cat" tabindex='6'>
											<option value="">Select Sub Category</option>
										</select>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_agent" name="by_agent" tabindex='7'>
											<option value="">Select Agent</option>
										</select>
									</div>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<label for="filter_by" style="float:left"><b>By Status</b></label><br>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_status" name="by_status" tabindex='8'>
											<option value="">Select Status</option>
											<option value="1">Current</option>
											<option value="2">Pending</option>
											<option value="3">OD</option>
											<option value="4">Error</option>
											<option value="5">Legal</option>
										</select>
									</div>
								</div>
								
							</div>
							<hr>
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<label for="filter_by" style="float:left"><b>By Collection Format</b></label><br>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<select class="form-control" id="by_coll_format" name="by_coll_format" tabindex='9'>
											<option value="">Select Status</option>
											<option value="1">By Self</option>
											<option value="2">On Spot</option>
											<option value="3">ECS</option>
											<option value="4">Cheque</option>
										</select>
									</div>
								</div>
								
							</div>
							<hr>
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<label for="filter_by" style="float:left"><b>By Commitment Date</b></label><br>
									</div>
								</div>
								<div class="col-4">
									<div class="form-group">
										<input type="date" class="form-control" id="by_comm_date" name="by_comm_date" tabindex='10'>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" >
					<input type='reset' class="btn btn-secondary-outline " id='clear_filter' tabindex="11" value="&#10006;&nbsp;Clear Filters">
					<input type='button' class="btn btn-primary" id='apply_filter' tabindex="12" value="Apply Filters">
					<input type='button' class="btn btn-secondary close-modal" data-dismiss="modal" tabindex="13" value="Close">
				</div>
			</form>
		</div>
	</div>
</div>