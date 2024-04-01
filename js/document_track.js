
// Document is ready
$(document).ready(function () {
    setTimeout(() => {
        $('.view-track').click(function(){
            var cus_id = $(this).data('cusid');
            var cus_name = $(this).data('cusname');
            var req_id = $(this).data('reqid');
            $.ajax({
                url: 'documentTrackFile/viewTrack.php',
                type: 'post',
                data:{'cus_id':cus_id,"req_id":req_id},
                cache:false,
                success:function(html){
                    $('#viewTrackDiv').empty();
                    $('#viewTrackDiv').html(html);
                }
            }).then(function(){
                getAllDocumentList(req_id,cus_name,cus_id);
            });//then function end

        });//click function end

        $('.receive-track').click(function(){
            var tableid = $(this).data('id');
            event.preventDefault();
            if(confirm('Are you sure to Mark this Track as Received?')){
                $.ajax({
                    url: 'documentTrackFile/receiveTrack.php',
                    type: 'post',
                    data:{'id':tableid},
                    cache:false,
                    success:function(response){
                        swalAlert(response);
                        setTimeout(()=>{
                            window.location='document_track';
                        },1500)
                    }
                });
            }
        });

        $('.send-track').click(function(){
            var tableid = $(this).data('id');
            event.preventDefault();
            if(confirm('Are you sure to Mark this Track as Sent?')){
                $.ajax({
                    url: 'documentTrackFile/sendTrack.php',
                    type: 'post',
                    data:{'id':tableid},
                    cache:false,
                    success:function(response){
                        swalAlert(response);
                        setTimeout(()=>{
                            window.location='document_track';
                        },1500)
                    }
                });
            }
        });

        $('.remove-track').click(function(){
            var tableid = $(this).data('id');
            event.preventDefault();
            if(confirm('Are you sure to Remove this Track from List?')){
                $.ajax({
                    url: 'documentTrackFile/removeTrack.php',
                    type: 'post',
                    data:{'id':tableid},
                    cache:false,
                    success:function(response){
                        swalAlert(response);
                        setTimeout(()=>{
                            window.location='document_track';
                        },1500)
                    }
                });
            }
        });
        
        console.log('click events created');
    }, 1000);

});//document ready end


function getAllDocumentList(req_id,cus_name,cus_id){
    // To get the Signed Document List on Checklist
    $.ajax({
        url:'documentTrackFile/getSignedDocList.php',
        data: {'req_id':req_id,'cus_name':cus_name},
        type: 'post',
        cache:false,
        success: function(response){
            
            $('#signDocDiv').empty()
            $('#signDocDiv').html(response);
            
        }
    });


    // To get the unused Cheque List on Checklist
    $.ajax({
        url:'documentTrackFile/getChequeDocList.php',
        data: {'req_id':req_id,'cus_name':cus_name},
        type: 'post',
        cache:false,
        success: function(response){
            
            $('#chequeDiv').empty()
            $('#chequeDiv').html(response);
        }
    });

    // To get the Mortgage List on Checklist
    $.ajax({
        url:'documentTrackFile/getMortgageList.php',
        data: {'req_id':req_id,'cus_name':cus_name},
        type: 'post',
        cache:false,
        success: function(response){
            
            $('#mortgageDiv').empty()
            $('#mortgageDiv').html(response);
        }
    });

    // To get the Endorsement List on Checklist
    $.ajax({
        url:'documentTrackFile/getEndorsementList.php',
        data: {'req_id':req_id,'cus_name':cus_name},
        type: 'post',
        cache:false,
        success: function(response){
            
            $('#endorsementDiv').empty()
            $('#endorsementDiv').html(response);
        }
    });

    // To get the Gold List on Checklist
    $.ajax({
        url:'documentTrackFile/getGoldList.php',
        data: {'req_id':req_id,'cus_name':cus_name},
        type: 'post',
        cache:false,
        success: function(response){
            
            $('#goldDiv').empty()
            $('#goldDiv').html(response);
        }
    });

    // To get the Document List on Checklist
    $.ajax({
        url:'documentTrackFile/getDocumentList.php',
        data: {'req_id':req_id,'cus_name':cus_name},
        type: 'post',
        cache:false,
        success: function(response){
            
            $('#documentDiv').empty()
            $('#documentDiv').html(response);
        }
    });

}

function swalAlert(response){
    if(response.includes('Successfully')){
        Swal.fire({
            title: response,
            icon: 'success',
            timer: 1500,
            showConfirmButton: false,
        })
    }else if(response.includes('Error')){
        Swal.fire({
            title: response,
            icon: 'error',
            timer: 1500,
            showConfirmButton: false,
        });
    }
}