$(document).ready(function(){
    
    $('button').click(function(e){e.preventDefault();})

    $('#sumit_add_lfollow').click(()=>{
        if(validateLoanfollowup() == true){
            submitLoanfollowup();
        }
    })

});


$(function(){
    resetLoanFollowupTable();
})





function submitLoanfollowup(){
    let cus_id = $('#lfollow_cus_id').val();
    let stage = $('#lfollow_stage').val();let label = $('#lfollow_label').val();
    let remark = $('#lfollow_remark').val();let follow_date = $('#lfollow_fdate').val();
    let args = {cus_id,stage,label,remark,follow_date};
    
    $.post('followupFiles/loanFollowup/submitLoanfollowup.php',args,function(response){
        if(response.includes('Error')){
            swarlErrorAlert(response);
        }else{
            swarlSuccessAlert(response);
            $('#addLoanFollow').find('.modal-body input').not('[readonly]').val('');
        }
    })
}
function validateLoanfollowup(){
    let response = true;
    let stage = $('#lfollow_stage').val();let label = $('#lfollow_label').val();
    let remark = $('#lfollow_remark').val();let follow_date = $('#lfollow_fdate').val();
    
    validateField(stage, '#lfollow_stageCheck');
    validateField(label, '#lfollow_labelCheck');
    validateField(remark, '#lfollow_remarkCheck');
    validateField(follow_date, '#lfollow_fdateCheck');

    function validateField(value, fieldId) {
        if (value === '' ) {
            response = false;
            event.preventDefault();
            $(fieldId).show();
        } else {
            $(fieldId).hide();
        }
        
    }

    return response;
}



function resetLoanFollowupTable(){
    $.post('followupFiles/loanFollowup/resetLoanFollowupTable.php',{},function(html){
        $('#loanListDiv').empty();
        $('#loanListDiv').html(html);
        
    }).then(function(){
        loanFollowupTableOnclick();
    })
}
function loanFollowupTableOnclick(){
    
    //on click for customer profile showing in next page
    $('.loan-follow-chart').click(function(){
        let cus_id = $(this).data('cusid');
        $.post('followupFiles/loanFollowup/getLoanFollowupChart.php',{cus_id},function(html){
            $('#loanFollowChartDiv').empty().html(html);
        })
    })

    $('.cust-profile').off('click').click(function(){
        let req_id = $(this).data('reqid');
        window.location.href = 'due_followup_info&upd='+req_id+'&pgeView=1';
    })

    $('.loan-history, .doc-history').off('click').click(function(){
        let req_id = $(this).data('reqid');
        let cus_id = $(this).data('cusid');
        let type = $(this).attr('class');
        historyTableContents(req_id,cus_id,type)
    });

    $('.personal-info').off('click').click(function(){
        let cus_id = $(this).data('cusid');
        $.post('followupFiles/promotion/getPersonalInfo.php',{cus_id},function(html){
            $('#personalInfoDiv').empty().html(html);
        })
    })

    $('.loan-follow-edit').off('click').click(function(){
        //if user clicks on follow chart to add new followup date, then the customer's loan has to be getched as where it is, like in verification, in approval , etc,.
        //the stage of loan is already set in data-stage attribute
        let stage = $(this).data('stage');
        $('#lfollow_stage').val(stage);

        //set cus id to hidden input for submit
        let cus_id = $(this).data('cusid');
        $('#lfollow_cus_id').val(cus_id);

    })
}
//Code snippet from c:\xampp\htdocs\marudham\js\due_followup.js
function historyTableContents(req_id,cus_id,type){
    //To get loan sub Status
    var pending_arr = [];
    var od_arr = [];
    var due_nil_arr = [];
    var closed_arr = [];
    var balAmnt = [];
    $.ajax({
        url: 'closedFile/resetCustomerStsForClosed.php',
        data: {'cus_id':cus_id},
        dataType:'json',
        type:'post',
        cache: false,
        success: function(response){
            if(response.length != 0){

                for(var i=0;i< response['pending_customer'].length;i++){
                    pending_arr[i] = response['pending_customer'][i]
                    od_arr[i] = response['od_customer'][i]
                    due_nil_arr[i] = response['due_nil_customer'][i]
                    closed_arr[i] = response['closed_customer'][i]
                    balAmnt[i] = response['balAmnt'][i]
                }
                var pending_sts = pending_arr.join(',');
                $('#pending_sts').val(pending_sts);
                var od_sts = od_arr.join(',');
                $('#od_sts').val(od_sts);
                var due_nil_sts = due_nil_arr.join(',');
                $('#due_nil_sts').val(due_nil_sts);
                var closed_sts = closed_arr.join(',');
                $('#closed_sts').val(closed_sts);
                balAmnt = balAmnt.join(',');
            }
        }
    })
    showOverlay();//loader start
    setTimeout(()=>{ 

        var pending_sts = $('#pending_sts').val()
        var od_sts = $('#od_sts').val()
        var due_nil_sts = $('#due_nil_sts').val()
        var closed_sts = $('#closed_sts').val()
        var bal_amt = balAmnt;

        if(type == 'loan-history'){

            //for loan history
            $('.loan-history-card').show();
            $('#close_history_card').show();
            $('.doc-history-card').hide();
            $('.loan-list-card').hide();//loan followup list 
            
            $.ajax({
                // Fetching details by customer ID instead of req ID because we need all loans from the customer
                url: 'followupFiles/dueFollowup/viewLoanHistory.php',
                data: {
                    'cus_id': cus_id,
                    'pending_sts': pending_sts,
                    'od_sts': od_sts,
                    'due_nil_sts': due_nil_sts,
                    'closed_sts': closed_sts
                },
                type: 'post',
                cache: false,
                success: function(response) {
                    // Clearing and updating the loan history div with the response
                    $('#loanHistoryDiv').empty().html(response);
                }
            });
        }else{

            //for Document history
            $('.doc-history-card').show();
            $('#close_history_card').show();
            $('.loan-history-card').hide();
            $('.loan-list-card').hide();
    
            $.ajax({
                // Fetching details by customer ID instead of req ID because we need all loans from the customer
                url: 'followupFiles/dueFollowup/viewDocumentHistory.php',
                data: {
                    'cus_id': cus_id,
                    'pending_sts': pending_sts,
                    'od_sts': od_sts,
                    'due_nil_sts': due_nil_sts,
                    'closed_sts': closed_sts,
                    'bal_amt': bal_amt
                },
                type: 'post',
                cache: false,
                success: function(response) {
                    // Emptying the docHistoryDiv and adding the response
                    $('#docHistoryDiv').empty().html(response);
                }
            });
        }

        $('#close_history_card').off('click').click(()=>{
            $('.loan-list-card').show();//shows existing card
            $('.loan-history-card').hide();//hides loan history card
            $('.doc-history-card').hide();//hides document history card
            $('#close_history_card').hide();// Hides the close button
        })
        hideOverlay();//loader stop
    },2000)

}




// Improved code snippet
function swarlErrorAlert(response) {
    Swal.fire({
        title: response,
        icon: 'error',
        confirmButtonText: 'Ok',
        confirmButtonColor: '#009688'
    });
}
function swarlInfoAlert(title, text) {
    Swal.fire({
        title: title,
        text: text,
        icon: 'info',
        showConfirmButton: true,
        showCancelButton: true,
        confirmButtonColor: '#009688',
        cancelButtonColor: '#cc4444',
        cancelButtonText: 'No',
        confirmButtonText: 'Yes'
    }).then(function(result) {
        if (result.isConfirmed) {
        update();
        }
    });
}
function swarlSuccessAlert(response) {
    Swal.fire({
        title: response,
        icon: 'success',
        confirmButtonText: 'Ok',
        confirmButtonColor: '#009688'
    });
}





