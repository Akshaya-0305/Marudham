$(document).ready(function() {

    getCustomerProfileReport();

});



function getCustomerProfileReport(){
    $.post('reportFile/customer_profile/getCustomerProfileReport.php',{},function(data){
        $('#customer_profile_table_div').empty().html(data);
        
    });
}