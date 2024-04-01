$(document).ready(function() {

    getClosedReport('','');
    $('#reset_btn').click(function(){
        let from_date = $('#from_date').val();let to_date = $('#to_date').val();
        getClosedReport(from_date,to_date);
    })

});



function getClosedReport(from_date,to_date){
    $.post('reportFile/closed/getClosedReport.php',{from_date:from_date,to_date:to_date},function(data){
        $('#closed_table_div').empty().html(data);
        
    });
}