<?php 
include('../ajaxconfig.php');
if(isset($_POST['cus_id'])){
    $cus_id = $_POST['cus_id'];
}
if(isset($_POST['req_id'])){
    $req_id = $_POST['req_id'];
}

$records = array();

$result=$con->query("SELECT lsf.feedback_label,lsf.cus_feedback,lsf.feedback_remark FROM loan_summary_feedback lsf where lsf.cus_id='$cus_id' ");

if($result->num_rows>0){
    $feedbackLabels = [
        '1' => 'Bad',
        '2' => 'Poor',
        '3' => 'Average',
        '4' => 'Good',
        '5' => 'Excellent'
    ];
    $i=0;
    while($row = $result->fetch_assoc()){

        $records[$i]['feedback_label'] = $row['feedback_label'];
        $records[$i]['cus_feedback'] = $feedbackLabels[$row['cus_feedback']];
        $records[$i]['feedback_remark'] = $row['feedback_remark'];
        $i++;
    }

    
}

?>

    <thead>
        <tr>
            <th width="25">S. No</th>
            <th>Closed Feedback Label</th>
            <th>Closed Feedback Rating</th>
            <th>Remarks</th>
        </tr>
    </thead>
    <tbody>
        <?php for($i=0;$i<sizeof($records);$i++){?>
        <tr>
            <td></td>
            <td><?php echo $records[$i]['feedback_label'];?></td>
            <td><?php echo $records[$i]['cus_feedback']?></td>
            <td><?php echo $records[$i]['feedback_remark'];?></td>
        </tr>
        <?php } ?>
    </tbody>
<script>
    var table = $('#loanSummaryTable').DataTable();
    table.destroy();
    $('#loanSummaryTable').DataTable({
            'processing': true,
            'iDisplayLength': 5,
            "lengthMenu": [
                [10, 25, 50, -1],
                [10, 25, 50, "All"]
            ],
            "createdRow": function(row, data, dataIndex) {
                $(row).find('td:first').html(dataIndex + 1);
            },
            "drawCallback": function(settings) {
                this.api().column(0).nodes().each(function(cell, i) {
                    cell.innerHTML = i + 1;
                });
            },
            dom: 'lBfrtip',
            buttons: [{
                    extend: 'excel',
                },
                {
                    extend: 'colvis',
                    collectionLayout: 'fixed four-column',
                }
            ],
        });
    </script>
<?php

?>

