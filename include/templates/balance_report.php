<link rel="stylesheet" type="text/css" href="css/ledger_report.css">
<br><br>
<div class="page-header">
    <div style="background-color:#009688; width:100%; padding:12px; color: #ffff; font-size: 20px; border-radius:5px;">
        Marudham -  Balance Report 
	</div>
	
</div><br>

<div class="text-right" style="margin-right: 25px;">
	<!-- <button class="btn btn-primary" id='close_history_card' style="display: none;" >&times;&nbsp;&nbsp;Cancel</button> -->
</div>

<!-- Main container start -->
<div class="main-container">
	<!--form start-->
	<form id = "balance_report_form" name="balance_report_form" action="" method="post" enctype="multipart/form-data"> 
        
        
        <div class="row gutters" id="balance_card">
			<div class="toggle-container col-12" >
				<input type="date" id='to_date' name='to_date' class="toggle-button" value=''>
				<input type="button" id='reset_btn' name='reset_btn' class="toggle-button" style="background-color: #009688;color:white" value='Reload'>
			</div>
			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
				<div class="card">
					<div class="card-header">Balance Report</div>
					<div class="card-body">
						<div id="balance_table_div" class="table-divs"  style="overflow-x: auto;">
                            
						</div>
					</div>
				</div>
			</div>
		</div>

    </form>
</div>