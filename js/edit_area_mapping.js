
// Document is ready
$(document).ready(function () {
    
    //Mapping Type Change
    
    $('#line,#group').click(function(){
        var mapping_type = $('input[name=mapping_type]:checked').val();
        if(mapping_type == 'line')
        {
            $('.line_mapping').show();$('.group_mapping').hide();
            dT1();

            // var sortOrder = 1; // 1 for ascending, -1 for descending
            // $('th').off('click')
            // $('th').click(function() {
            //     var columnIndex = $(this).index();
            //     $('tbody').empty();
            //     if(sortOrder ==1 ){dT2();}//First time only sorting working
            //     dT1();
            //     setTimeout(function() {
            //         var $tableRows = $('tbody tr');
            //         $tableRows.sort(function(a, b) {
            //             var textA = $(a).find('td').eq(columnIndex).text().toUpperCase();
            //             var textB = $(b).find('td').eq(columnIndex).text().toUpperCase();
            //             if (textA < textB) {
            //                 return -1 * sortOrder;
            //             }
            //             if (textA > textB) {
            //                 return 1 * sortOrder;
            //             }
            //             return 0;
            //         });
            //         $('tbody').append($tableRows);
            //         sortOrder = -1 * sortOrder;

            //         // update the serial numbers
            //         $('tbody tr').each(function(index) {
            //             $(this).find('td').eq(0).text(index + 1);
            //         });
            //     }, 500)
            // })

        }
        if(mapping_type == 'group')
        {
            $('.line_mapping').hide();$('.group_mapping').show();
            dT2();

            // var sortOrder = 1; // 1 for ascending, -1 for descending
            // $('th').off('click')
            // $('th').click(function() {
            //     var columnIndex = $(this).index();
            //     $('tbody').empty();
            //     if(sortOrder ==1 ){dT1();} //First time only sorting working
            //     dT2();
            //     setTimeout(function() {
            //         var $tableRows = $('tbody tr');
            //         $tableRows.sort(function(a, b) {
            //             var textA = $(a).find('td').eq(columnIndex).text().toUpperCase();
            //             var textB = $(b).find('td').eq(columnIndex).text().toUpperCase();
            //             if (textA < textB) {
            //                 return -1 * sortOrder;
            //             }
            //             if (textA > textB) {
            //                 return 1 * sortOrder;
            //             }
            //             return 0;
            //         });
            //         $('tbody').append($tableRows);
            //         sortOrder = -1 * sortOrder;

            //         // update the serial numbers
            //         $('tbody tr').each(function(index) {
            //             $(this).find('td').eq(0).text(index + 1);
            //         });
            //     }, 500)
            // })
        
            //Unbind or disable all other event listeners to avoid conflict
            // $('#search').unbind('input');
            // $('#search').unbind('keypress');
            // $('#search').unbind('keyup');
            // $('#search').unbind('search');

            //new search on keyup event for search by display content
            // $('#search').keyup(function(){
            //     // Retrieve the input field text and reset the count to zero
            //     var filter = $(this).val(), count = 0;
            //     // Loop through the comment list
            //     $("table tbody tr").each(function(){
            //         // If the list item does not contain the text phrase fade it out
            //         if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            //             $(this).fadeOut();
            //         // Show the list item if the phrase matches and increase the count by 1
            //         } else {
            //             $(this).show();
            //             count++;
            //         }
            //     })
            // })
        }
    })
    



    
});//document ready end

$(function(){
    var mapping_type = $('input[name=mapping_type]:checked').val();
    if(mapping_type == 'line' ){
        dT1();
    }else if(mapping_type == 'group'){
        dT2();
    }

})
function dT1(){
    var table = $('#area_mapping_group_info').DataTable();
    table.destroy();
    
    $('#area_mapping_line_info').empty();
    $('#area_mapping_group_info').empty();
    $('#area_mapping_line_info').append(`<thead><tr><th width="50">S. No.</th><th>Line Name</th><th>Company Name</th><th>Branch Name</th><th>Area Name</th><th>Sub Area</th><th>Status</th><th>Action</th></tr></thead><tbody></tbody>`);



    $('#area_mapping_line_info').DataTable({
            
        "order": [[ 0, "asc" ]],
        // "ordering": false,
        'processing': true,
        'serverSide': true,
        'serverMethod': 'post',
        'ajax': {
            'url':'ajaxFetch/ajaxAreaMappingLineFetch.php',
            'data': function(data){
                var search = $('#search').val();
                data.search      = search;
            }
        },
        dom: 'lBfrtip',
        buttons: [
            {
                extend: 'excel',
                title: "Line List"
            },
            {
                extend:'colvis',
                collectionLayout: 'fixed four-column',
            }
        ],
        "lengthMenu": [
            [10, 25, 50, -1],
            [10, 25, 50, "All"]
        ],
        "drawCallback":function(){
            searchFunction();
            // sortTableL();
        }
    });

}
function dT2(){
    var table = $('#area_mapping_line_info').DataTable();
    table.destroy();
    $('#area_mapping_line_info').empty();
    $('#area_mapping_group_info').empty();
    $('#area_mapping_group_info').append(`<thead><tr><th width="50">S. No.</th><th>Group Name</th><th>Company Name</th><th>Branch Name</th><th>Area Name</th><th>Sub Area</th><th>Status</th><th>Action</th></tr></thead><tbody></tbody>`);

    $('#area_mapping_group_info').DataTable({
        "order": [[ 0, "desc" ]],
        "ordering": false,
        'processing': true,
        'serverSide': true,
        'serverMethod': 'post',
        'ajax': {
            'url':'ajaxFetch/ajaxAreaMappingGroupFetch.php',
            'data': function(data){
                var search = $('#search').val();
                data.search      = search;
            }
        },
        
        dom: 'lBfrtip',
        buttons: [
            {
                extend: 'excel',
                title: "Group List"
            },
            {
                extend:'colvis',
                collectionLayout: 'fixed four-column',
            }
        ],
        "lengthMenu": [
            [10, 25, 50, -1],
            [10, 25, 50, "All"]
        ],
        "drawCallback":function(){
            searchFunction();
            // sortTableG()
        }
    });
}

function sortTableL() {
   
}
function sortTableG() {
   
}

