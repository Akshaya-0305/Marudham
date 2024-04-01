$(document).ready(function() {

    getLoanIssueReport('','');
    $('#reset_btn').click(function(){
        let from_date = $('#from_date').val();let to_date = $('#to_date').val();
        getLoanIssueReport(from_date,to_date);
    })
});



function getLoanIssueReport(from_date,to_date){
    $.post('reportFile/loan_issue/getLoanIssueReport.php',{from_date:from_date,to_date:to_date},function(data){
        $('#loan_issue_table_div').empty().html(data);
        
    });
}