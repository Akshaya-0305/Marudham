$(document).ready(function() {

    getRequestReport('','');

    $('#reset_btn').click(function(){
        let from_date = $('#from_date').val();let to_date = $('#to_date').val();
        getRequestReport(from_date,to_date);
    })
});



function getRequestReport(from_date,to_date){
    $.post('reportFile/request/getRequestReport.php',{from_date:from_date,to_date:to_date},function(response){
        $('#request_table_div').empty().html(response);
        
    });
}