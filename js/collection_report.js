$(document).ready(function() {

    getCollectionReport('','');
    $('#reset_btn').click(function(){
        let from_date = $('#from_date').val();let to_date = $('#to_date').val();
        getCollectionReport(from_date,to_date);
    })
});



function getCollectionReport(from_date,to_date){
    $.post('reportFile/collection/getCollectionReport.php',{from_date:from_date,to_date:to_date},function(data){
        $('#collection_table_div').empty().html(data);
        
    });
}