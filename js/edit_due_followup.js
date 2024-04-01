$(document).ready(function(){

    OnLoadFunctions();
    // getFilterInputs();

    // $('#apply_filter').click(function(){
    //     if(validateFilters() == true){
    //         applyFilters();
    //     }
    // })
    // $('#clear_filter').click(function(){
    //     //while clearing filters, we need to show the original table , so call following method
    //     dueFollowuptableFetch();
        
    //     $('.close-modal').trigger('click');//close the modal while clicking clear to show old table

    //     //this will clear the dropdowns from previously assigned datas
    //     $('#filter_form select').not('#by_branch,#by_loan_cat,#by_agent,#by_status,#by_coll_format').find('option:not(:first)').remove('');

    // })
});
    
function OnLoadFunctions(){

    
    $.ajax({
        url: 'followupFiles/dueFollowup/getDueFollowCus.php',
        cache: false,
        dataType:'json',
        type: 'post',
        success:function(cus_id_arr){
            
        }
    }).then(function(cus_id_arr){
        let follow_cus_sts = [];
        let completedRequests = 0;//for checking the each function completion
        const totalRequests = cus_id_arr.length;

        // $.each(cus_id_arr, function(key, value){
        //     cus_id = value;

        //     $.ajax({
        //         url: 'collectionFile/resetCustomerStatus.php',
        //         data: {'cus_id':cus_id},
        //         dataType:'json',
        //         type:'post',
        //         cache: false,
        //         success: function(response){
        //             if(response.length != 0){

        //                 follow_cus_sts.push(response['follow_cus_sts']);
        //                 completedRequests++;

        //                 // Check if all requests have completed
        //                 if (completedRequests === totalRequests) {
        //                     // Call dueFollowuptableFetch when all requests are done
        //                     dueFollowuptableFetch(cus_id_arr, follow_cus_sts);
        //                 }
        //             }
        //         }
        //     });
        // }).then(function(){
            
        // })
        var requests = [];

        $.each(cus_id_arr, function(key, value){
            var cus_id = value;
            var request = $.ajax({
                url: 'collectionFile/resetCustomerStatus.php',
                data: {'cus_id': cus_id},
                dataType: 'json',
                type: 'post',
                cache: false
            });

            requests.push(request);
        });
        
        $.when.apply($, requests).done(function() {
            // All AJAX requests are completed
            if(arguments[0][0]){
                //if arguments does have 2 dimentions, then can directly assign to responses variable
                var responses = arguments;
            }else{
                //if arguments only have 1 dimention, then it should be pushed inside another dimention to make it two.
                //this is useful for following iteration processes.
                var responses = [];
                responses.push(arguments);
            }
            var follow_cus_sts = [];
            var payable = [];
            var req_of_cus = [];
            var completedRequests = 0;
            var totalRequests = responses.length;

            for (var i = 0; i < responses.length; i++) {
                var response = responses[i][0]; // Get the response of each AJAX request

                if (response.length !== 0) {
                    follow_cus_sts.push(response['follow_cus_sts']);

                    response['payable_as_req'].forEach(e => {
                        payable.push(e);
                    });
                    response['req_id'].forEach(e => {
                        req_of_cus.push(e);
                    });
                    completedRequests++;
                }
            }

            if (completedRequests === totalRequests) {
                // Call dueFollowuptableFetch when all requests are done
                dueFollowuptableFetch(cus_id_arr, follow_cus_sts, payable, req_of_cus);
            }
        });

    }); 
}


function dueFollowuptableFetch(cus_id_arr,follow_cus_sts, payable, req_of_cus){
    // cus_id_arr = cus_id_arr.join(',');
    // follow_cus_sts = follow_cus_sts.join(',');
    $.ajax({
		//in this file, details gonna fetch by customer ID, Not by req id (Because we need all loans from customer)
		url: 'followupFiles/dueFollowup/ajaxDueFollowupFetch.php',
		data: {'cus_id':JSON.stringify(cus_id_arr), "follow_cus_sts":JSON.stringify(follow_cus_sts), "payable":JSON.stringify(payable), "req_of_cus":JSON.stringify(req_of_cus)},
        type:'post',
		cache: false,
		success: function(response){
			$('#dueFollwupDiv').empty()
			$('#dueFollwupDiv').html(response);
            hideOverlay();
		}
	}).then(function(){
		enableDateColoring();
        showOverlay();
        setTimeout(() => {
			$('#due_followup_table').DataTable({
				'processing': true,
				dom: 'lBfrtip',
				buttons: [{
						extend: 'excel',
						title: "Due Followup List"
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
			});
            hideOverlay();
		}, 1500);
	});
}

function enableDateColoring(){
    //for coloring
    $('#due_followup_table tbody tr').not('th').each(function(){
        let tddate = $(this).find('td:eq(13)').text(); // Get the text content of the 12th td element (Follow date)
        let datecorrection = tddate.split("-").reverse().join("-").replaceAll(/\s/g, ''); // Correct the date format
        let values = new Date(datecorrection); // Create a Date object from the corrected date
        values.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let curDate = new Date(); // Get the current date
        curDate.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let colors = {'past':'FireBrick','current':'DarkGreen','future':'CornflowerBlue'}; // Define colors for different date types

        if(tddate != '' && values != 'Invalid Date'){ // Check if the extracted date and the created Date object are valid

            if(values < curDate){ // Compare the extracted date with the current date
                $(this).find('td:eq(13)').css({'background-color':colors.past, 'color':'white'}); // Apply styling for past dates
            }else if(values > curDate){
                $(this).find('td:eq(13)').css({'background-color': colors.future, 'color':'white'}); // Apply styling for future dates
            }else {
                $(this).find('td:eq(13)').css({'background-color':colors.current, 'color':'white'}); // Apply styling for the current date
            }
        }
    });
}

function getFilterInputs(){
    //to get filter modal inputs 

    $.post('followupFiles/dueFollowup/getFilterInputs.php',function(response){
        
        $('#by_branch').empty().append(`<option value="">Select Branch Name</option>`)
        $('#loan_cat').empty().append(`<option value="">Select Loan Category</option>`)
        $('#agent').empty().append(`<option value="">Select Agent Name</option>`)
        for(let i=0; i<response['branch'].length; i++){
            $('#by_branch').append(`<option value="${response['branch'][i].id}">${response['branch'][i].name}</option>`)
        }
        for(let i=0; i<response['loan_cat'].length; i++){
            $('#by_loan_cat').append(`<option value="${response['loan_cat'][i].id}">${response['loan_cat'][i].name}</option>`)
        }
        for(let i=0; i<response['agent'].length; i++){
            $('#by_agent').append(`<option value="${response['agent'][i].id}">${response['agent'][i].name}</option>`)
        }


        $('#by_branch').change(function(){
            $('#by_area').empty().append(`<option value="">Select Area</option>`)
            $('#by_sub_area').empty().append(`<option value="">Select Sub Area</option>`)
            $('#by_line').empty().append(`<option value="">Select Line</option>`)

            if($(this).val() == ''){
                return;
            }else{
                for(let i=0; i<response['line'].length; i++){
                    if(response['line'][i].branch_id == $('#by_branch').val()){
                        $('#by_line').append(`<option value="${response['line'][i].id}">${response['line'][i].name}</option>`)
                    }
                
                }
            }
        });

        $('#by_line').change(function(){
            $('#by_area').empty().append(`<option value="">Select Area Name</option>`)
            $('#by_sub_area').empty().append(`<option value="">Select Sub Area</option>`)

            if($('#by_line').val() == '' || $('#by_branch').val() == ''){
                return;
            }else{
                //this code will first check for selected line id
                for(let i=0; i<response['line'].length; i++){

                    if(response['line'][i].id == $('#by_line').val() ) {
                        //if the selected line id matches, the it will take that respective area ids

                        for(let k=0;k<response['area'].length; k++){//then loop over area table

                            //check for the area id in the line table and if it matches, then append to the area select box.
                            //if the area id is not in the line table, then it will not append to the area select box.
                            if(response['line'][i]['area_id'].includes(response['area'][k]['id'])){

                                $('#by_area').append(`<option value="${response['area'][k].id}">${response['area'][k].name}</option>`)
                            }
                        }
                    }
                }
            }
        
        });

        $('#by_area').change(function(){
            $('#by_sub_area').empty().append(`<option value="">Select Sub Area Name</option>`)
            
            if($('#by_area').val() == '' || $('#by_line').val() == '' || $('#by_branch').val() == ''){
                return;
            }else{
                for(let i=0; i<response['sub_area'].length; i++){
                    if(response['sub_area'][i].area_id == $('#by_area').val()){
                        $('#by_sub_area').append(`<option value="${response['sub_area'][i].id}">${response['sub_area'][i].name}</option>`)
                    }
                }
            
            }
        });
        // ********************************************************************************************************************************************************
        $('#by_loan_cat').change(function(){
            $('#by_sub_cat').empty().append(`<option value="">Select Sub Category</option>`);
            if($('#by_loan_cat').val() == ''){
                return;
            }else{
                $('#by_sub_cat').empty().append(`<option value="">Select Sub Category</option>`)
                for(let i=0; i<response['sub_cat'].length; i++){
                    if(response['sub_cat'][i].loan_cat == $('#by_loan_cat').val()){
                        $('#by_sub_cat').append(`<option value="${response['sub_cat'][i].id}">${response['sub_cat'][i].name}</option>`)
                    }
                }
            }
        
        });

    },'json')
}

function validateFilters(){
    let response = true;
    let by_branch = $('#by_branch').val(); let by_line = $('#by_line').val(); let by_area = $('#by_area').val(); let by_sub_area = $('#by_sub_area').val();
    let by_loan_cat = $('#by_loan_cat').val(); let by_sub_cat = $('#by_sub_cat').val(); let by_agent = $('#by_agent').val();
    let by_status = $('#by_status').val(); let by_coll_format = $('#by_coll_format').val(); let by_comm_date = $('#by_comm_date').val();

    if (by_branch == '' && by_line == '' && by_area == '' && by_sub_area == '' && by_loan_cat == '' && by_sub_cat == '' && by_agent == '' && by_status == '' && by_coll_format == '' && by_comm_date == '') {
        
        swarlInfoAlert('Fields are Empty!','Please choose any options to Apply filters.')
        response = false;
    }else{
        
    }

    return response;
}
function applyFilters(){
    $.post('followupFiles/dueFollowup/ajaxDueFollowupFetch.php',$('#filter_form').serialize(),function(response){
        $('#dueFollwupDiv').empty().html(response);
        $('.close-modal').trigger('click');
        event.preventDefault();
    });
}




function swarlInfoAlert(title, text) {
    Swal.fire({
        title: title,
        text: text,
        icon: 'info',
        showConfirmButton: true,
        confirmButtonColor: '#009688',
    });
}