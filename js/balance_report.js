$(document).ready(function() {

    getBalanceReport('');
    $('#reset_btn').click(function(){
        let to_date = $('#to_date').val();
        getBalanceReport(to_date);
    })
});



function getBalanceReport(to_date){
    $.post('reportFile/balance/getBalanceReport.php',{to_date},function(data){
        $('#balance_table_div').empty().html(data);
        
    });
}