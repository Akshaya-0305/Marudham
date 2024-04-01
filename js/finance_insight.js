$(document).ready(function(){


    
    const toggleButtons = $(".toggle-button");
    toggleButtons.removeClass('active'); //initially make all buttons unchecked
    toggleButtons.on("click", function() {
        // Reset active class for all buttons
        toggleButtons.removeClass("active");
        // Add active class to the clicked button
        $(this).addClass("active");

        let chosenOpt = $(this).val();
        if(chosenOpt == 'Today'){
            BalanceSheetCalculations('today','','','');
            BenefitCalculations('today','','','');
            BenefitCheckCalculations('today','','','');
            ProfitCalculations('today','','','');
        }
    });

    $('#submitDaywise').click(function(){
        let from_date = $('#from_date').val();let to_date = $('#to_date').val();
        if(from_date != '' && to_date != '' ){
            
            BalanceSheetCalculations('day',from_date, to_date,'');
            BenefitCalculations('day',from_date, to_date,'');
            BenefitCheckCalculations('day',from_date, to_date,'');
            ProfitCalculations('day',from_date, to_date,'');
            
            $('.close').trigger('click');//it will close modal
        }else{
            swalError('Please Fill Dates!','error');
            event.preventDefault();
        }
    })
    
    $('#submitMonthwise').click(function(){
        let for_month = $('#for_month').val()
        if(for_month != ''){
            
            BalanceSheetCalculations('month','', '',for_month);
            BenefitCalculations('month','', '',for_month);
            BenefitCheckCalculations('month','', '',for_month);
            ProfitCalculations('month','', '',for_month);
            
            $('.close').trigger('click');//it will close modal
        }else{
            swalError('Please Choose Month!','error');
            event.preventDefault();
        }
    })

})//Document Ready End



$(function(){
    
    getUserNames();

})// auto load functions End


function getUserNames(){
    //get user name only who has access of cash tally
    $.post('financeFile/getUsersName.php',function(response){
        $('#by_user').empty()
        $('#by_user').append("<option value=''>Select User</option>")
        $.each(response,function(index,val){
            $('#by_user').append("<option value='"+val['user_id']+"'>"+val['username']+"</option> ");
        })
    },'json')
}

//it will calculate for all type of searches handling by type, after ajax calls are completed then it will trigger to calculate closing details
function BalanceSheetCalculations(type,from_date,to_date,month){

    clearAllContents();

    var user_id = $('#by_user').val();
    if(type == 'today'){var args = {'type':'today','user_id':user_id}; }else
    if(type == 'day'){var args = {'type':'day','from_date':from_date,'to_date':to_date,'user_id':user_id}; }else
    if(type == 'month'){var args = {'type':'month','month':month,'user_id':user_id}; }

    // Create an array to store all the Ajax calls
    let ajaxCalls = [];

    //to get opening balance
    let ajaxCall1 = $.post('financeFile/BS/getOpeningDate.php', args,function(response){
        $('.balance-sheet-card').find('tbody tr:first td:nth-child(2)').text(response['closing_bal']) //it will get the 2nd column value inside tbody // will take you to opening balance credit column
    },'json')

    //to get collection amount
    let ajaxCall2 = $.post('financeFile/BS/getCollectionAmount.php', args,function(response){
        $('.balance-sheet-card').find('tbody tr:nth-child(2) td:nth-child(2)').text(response['collection']);
    },'json')

    //to get Document charges with processing fees
    let ajaxCall3 = $.post('financeFile/BS/getDocumentCharges.php', args,function(response){
        $('.balance-sheet-card').find('tbody tr:nth-child(3) td:nth-child(2)').text(response['doc_charge']);
        $('.balance-sheet-card').find('tbody tr:nth-child(4) td:nth-child(2)').text(response['proc_charge']);
    },'json')

    //to get Other income, bank withdrawal and cash deposit
    let ajaxCall4 = $.post('financeFile/BS/getBSCrContents.php', args,function(response){
        $('.balance-sheet-card').find('tbody tr:nth-child(5) td:nth-child(2)').text(response['other_income']);
        $('.balance-sheet-card').find('tbody tr:nth-child(6) td:nth-child(2)').text(response['bank_withdrawal']);
        $('.balance-sheet-card').find('tbody tr:nth-child(7) td:nth-child(2)').text(response['cash_deposit']);
    },'json')

    //to get Investment, Deposit, EL, Exchange and Agent
    let ajaxCall5 = $.post('financeFile/BS/getBSCrDbContents.php', args,function(response){
        $('.balance-sheet-card').find('tbody tr:nth-child(8) td:nth-child(2)').text(response['cr_investment']);
        $('.balance-sheet-card').find('tbody tr:nth-child(8) td:nth-child(3)').text(response['db_investment']);
        $('.balance-sheet-card').find('tbody tr:nth-child(9) td:nth-child(2)').text(response['cr_deposit']);
        $('.balance-sheet-card').find('tbody tr:nth-child(9) td:nth-child(3)').text(response['db_deposit']);
        $('.balance-sheet-card').find('tbody tr:nth-child(10) td:nth-child(2)').text(response['cr_el']);
        $('.balance-sheet-card').find('tbody tr:nth-child(10) td:nth-child(3)').text(response['db_el']);
        $('.balance-sheet-card').find('tbody tr:nth-child(11) td:nth-child(2)').text(response['cr_exchange']);
        $('.balance-sheet-card').find('tbody tr:nth-child(11) td:nth-child(3)').text(response['db_exchange']);
        $('.balance-sheet-card').find('tbody tr:nth-child(12) td:nth-child(2)').text(response['cr_agent']);
        $('.balance-sheet-card').find('tbody tr:nth-child(12) td:nth-child(3)').text(response['db_agent']);
    },'json')

    //to get Issued, Expense, Bank Deposit and cash withdrawal
    let ajaxCall6 = $.post('financeFile/BS/getBSDbContents.php', args,function(response){
        $('.balance-sheet-card').find('tbody tr:nth-child(13) td:nth-child(3)').text(response['issued']);
        $('.balance-sheet-card').find('tbody tr:nth-child(14) td:nth-child(3)').text(response['expense']);
        $('.balance-sheet-card').find('tbody tr:nth-child(15) td:nth-child(3)').text(response['bank_deposit']);
        $('.balance-sheet-card').find('tbody tr:nth-child(16) td:nth-child(3)').text(response['cash_withdrawal']);
    },'json'); 
    
    ajaxCalls.push(ajaxCall1,ajaxCall2,ajaxCall3,ajaxCall4,ajaxCall5,ajaxCall6);

    // Now use $.when() to wait for all Ajax calls to complete
    $.when.apply($, ajaxCalls).done(function () {
        // This function will be executed when all Ajax calls are completed successfully
        // Put your code here for the function you want to run after all Ajax calls are completed.
        calculateClosingForBS();
        calculateClosingForBenefit();
        calculateClosingForBenefitCheck();
    });
}
// function to calculate closing details for balance sheet calculations
function calculateClosingForBS(){
    var credit = 0; var debit = 0;
    // var op_text = $('.balance-sheet-card').find('tbody tr:first td:nth-child(2)').text();
    // var opening_balance = parseInt(op_text.replaceAll(',',''));

    $('.balance-sheet-card').find('tbody tr').not('tr:last').each(function(){ //included opening balance also for credit total//only removed closing balance while summarizing debit amount for closing bal calculation
        let credit_val = $(this).find('td:nth-child(2)').text() ? $(this).find('td:nth-child(2)').text() : '0';
        credit = credit + parseInt(credit_val.replaceAll(',',''));
        
        let debit_val = $(this).find('td:nth-child(3)').text() ? $(this).find('td:nth-child(3)').text() : '0';
        debit = debit + parseInt(debit_val.replaceAll(',',''));
    })
    
    var closing_balance = credit - debit;
    debit = debit + closing_balance;//included closing balance also for debit total
    var difference = credit - debit;
    $('.balance-sheet-card').find('tbody tr:nth-child(17) td:nth-child(3)').text(moneyFormatIndia(closing_balance));
    $('.benefits-check-card').find('tbody tr:nth-child(9) td:nth-child(3)').text(moneyFormatIndia(closing_balance));//benefit check table also will have same closing balance
    $('.balance-sheet-card').find('tfoot tr:first td:nth-child(2)').text(moneyFormatIndia(credit));
    $('.balance-sheet-card').find('tfoot tr:first td:nth-child(3)').text(moneyFormatIndia(debit )); 
    $('.balance-sheet-card').find('tfoot tr:last td:nth-child(2)').text(moneyFormatIndia(difference));
}



//it will calculate for all type of searches handling by type, after ajax calls are completed then it will trigger to calculate closing details
function BenefitCalculations(type,from_date,to_date,month){

    clearAllContents();

    var user_id = $('#by_user').val();
    if(type == 'today'){var args = {'type':'today','user_id':user_id}; }else
    if(type == 'day'){var args = {'type':'day','from_date':from_date,'to_date':to_date,'user_id':user_id}; }else
    if(type == 'month'){var args = {'type':'month','month':month,'user_id':user_id}; }

    // Create an array to store all the Ajax calls
    let ajaxCalls = [];

    //to get Benefit Amount
    let ajaxCall1 = $.post('financeFile/Benefits/getBenefitAmount.php', args,function(response){
        $('.benefits-card').find('tbody tr:first td:nth-child(2)').text(response['benefit_amount']) //it will get the 2nd column value inside tbody // will take you to opening balance credit column
        $('.benefits-card').find('tbody tr:nth-child(2) td:nth-child(2)').text(response['interest_amount']) //it will get the 2nd column value inside tbody // will take you to opening balance credit column
    },'json')

    //to get Document charges with processing fees
    let ajaxCall2 = $.post('financeFile/BS/getDocumentCharges.php', args,function(response){
        $('.benefits-card').find('tbody tr:nth-child(3) td:nth-child(2)').text(response['doc_charge']);
        $('.benefits-card').find('tbody tr:nth-child(4) td:nth-child(2)').text(response['proc_charge']);
    },'json')
    
    //to get Penalty and fine 
    let ajaxCall3 = $.post('financeFile/Benefits/getPenaltyFine.php', args,function(response){
        $('.benefits-card').find('tbody tr:nth-child(5) td:nth-child(2)').text(response['penalty']);
        $('.benefits-card').find('tbody tr:nth-child(6) td:nth-child(2)').text(response['fine']);
    },'json'); 

    //to get Other income
    let ajaxCall4 = $.post('financeFile/BS/getBSCrContents.php', args,function(response){
        $('.benefits-card').find('tbody tr:nth-child(7) td:nth-child(2)').text(response['other_income']);
    },'json')

    //to get Expense
    let ajaxCall5 = $.post('financeFile/BS/getBSDbContents.php', args,function(response){
        $('.benefits-card').find('tbody tr:nth-child(8) td:nth-child(3)').text(response['expense']);
    },'json'); 
    
    ajaxCalls.push(ajaxCall1,ajaxCall2,ajaxCall3,ajaxCall4,ajaxCall5);

    // Now use $.when() to wait for all Ajax calls to complete
    $.when.apply($, ajaxCalls).done(function () {
        // This function will be executed when all Ajax calls are completed successfully
        // Put your code here for the function you want to run after all Ajax calls are completed.
        calculateClosingForBS();
        calculateClosingForBenefit();
        calculateClosingForBenefitCheck();
    });
}
// function to calculate closing details for Benefits calculations
function calculateClosingForBenefit(){
    var credit = 0; var debit = 0;

    $('.benefits-card').find('tbody tr').each(function(){
        let credit_val = $(this).find('td:nth-child(2)').text() ? $(this).find('td:nth-child(2)').text() : '0';
        credit = credit + parseInt(credit_val.replaceAll(',',''));
        
        let debit_val = $(this).find('td:nth-child(3)').text() ? $(this).find('td:nth-child(3)').text() : '0';
        debit = debit + parseInt(debit_val.replaceAll(',',''));
    })
    
    var difference = credit - debit;
    $('.benefits-card').find('tfoot tr:first td:nth-child(2)').text(moneyFormatIndia(credit));
    $('.benefits-card').find('tfoot tr:first td:nth-child(3)').text(moneyFormatIndia(debit));
    $('.benefits-card').find('tfoot tr:last td:nth-child(2)').text(moneyFormatIndia(difference));
}



//it will calculate for all type of searches handling by type, after ajax calls are completed then it will trigger to calculate closing details
function ProfitCalculations(type,from_date,to_date,month){

    clearAllContents();

    var user_id = $('#by_user').val();
    if(type == 'today'){var args = {'type':'today','user_id':user_id}; }else
    if(type == 'day'){var args = {'type':'day','from_date':from_date,'to_date':to_date,'user_id':user_id}; }else
    if(type == 'month'){var args = {'type':'month','month':month,'user_id':user_id}; }

    // Create an array to store all the Ajax calls
    let ajaxCalls = [];

    //to get Profit Amount
    let ajaxCall1 = $.post('financeFile/Profit/getProfitAmount.php', args,function(response){
        $('.profit-card').find('tbody tr:first td:nth-child(2)').text(response['interest_paid']) //it will get the 2nd column value inside tbody // will take you to Profit amount credit column
    },'json')
    //to get Interest Amount
    let ajaxCall2 = $.post('financeFile/Benefits/getBenefitAmount.php', args,function(response){
        $('.profit-card').find('tbody tr:nth-child(2) td:nth-child(2)').text(response['interest_amount']) 
    },'json')

    //to get Document charges with processing fees
    let ajaxCall3 = $.post('financeFile/BS/getDocumentCharges.php', args,function(response){
        $('.profit-card').find('tbody tr:nth-child(3) td:nth-child(2)').text(response['doc_charge']);
        $('.profit-card').find('tbody tr:nth-child(4) td:nth-child(2)').text(response['proc_charge']);
    },'json')
    
    //to get Penalty and fine 
    let ajaxCall4 = $.post('financeFile/Benefits/getPenaltyFine.php', args,function(response){
        $('.profit-card').find('tbody tr:nth-child(5) td:nth-child(2)').text(response['penalty']);
        $('.profit-card').find('tbody tr:nth-child(6) td:nth-child(2)').text(response['fine']);
    },'json'); 

    //to get Other income
    let ajaxCall5 = $.post('financeFile/BS/getBSCrContents.php', args,function(response){
        $('.profit-card').find('tbody tr:nth-child(7) td:nth-child(2)').text(response['other_income']);
    },'json')

    //to get Expense
    let ajaxCall6 = $.post('financeFile/BS/getBSDbContents.php', args,function(response){
        $('.profit-card').find('tbody tr:nth-child(8) td:nth-child(3)').text(response['expense']);
    },'json'); 
    
    ajaxCalls.push(ajaxCall1,ajaxCall2,ajaxCall3,ajaxCall4,ajaxCall5,ajaxCall6);

    // Now use $.when() to wait for all Ajax calls to complete
    $.when.apply($, ajaxCalls).done(function () {
        // This function will be executed when all Ajax calls are completed successfully
        // Put your code here for the function you want to run after all Ajax calls are completed.
        calculateClosingForBS();
        calculateClosingForBenefit();
        calculateClosingForProfit();
        calculateClosingForBenefitCheck();
    });
}
// function to calculate closing details for Profit calculations
function calculateClosingForProfit(){
    var credit = 0; var debit = 0;

    $('.profit-card').find('tbody tr').each(function(){
        let credit_val = $(this).find('td:nth-child(2)').text() ? $(this).find('td:nth-child(2)').text() : '0';
        credit = credit + parseInt(credit_val.replaceAll(',',''));
        
        let debit_val = $(this).find('td:nth-child(3)').text() ? $(this).find('td:nth-child(3)').text() : '0';
        debit = debit + parseInt(debit_val.replaceAll(',',''));
    })
    
    var difference = credit - debit;
    $('.profit-card').find('tfoot tr:first td:nth-child(2)').text(moneyFormatIndia(credit));
    $('.profit-card').find('tfoot tr:first td:nth-child(3)').text(moneyFormatIndia(debit));
    $('.profit-card').find('tfoot tr:last td:nth-child(2)').text(moneyFormatIndia(difference));
}



//it will calculate for all type of searches handling by type, after ajax calls are completed then it will trigger to calculate closing details
function BenefitCheckCalculations(type,from_date,to_date,month){

    clearAllContents();

    var user_id = $('#by_user').val();
    if(type == 'today'){var args = {'type':'today','user_id':user_id}; }else
    if(type == 'day'){var args = {'type':'day','from_date':from_date,'to_date':to_date,'user_id':user_id}; }else
    if(type == 'month'){var args = {'type':'month','month':month,'user_id':user_id}; }

    // Create an array to store all the Ajax calls
    let ajaxCalls = [];

    //to get opening outstanding
    let ajaxCall1 = $.post('financeFile/BenefitsCheck/getOpeningOutstanding.php', args,function(response){
        $('.benefits-check-card').find('tbody tr:first td:nth-child(2)').text(response['opening_outstanding']) //it will get the 2nd column value inside tbody // will take you to opening outstanding credit column
    },'json');

    //to get opening balance
    let ajaxCall2 = $.post('financeFile/BS/getOpeningDate.php', args,function(response){
        $('.benefits-check-card').find('tbody tr:nth-child(2) td:nth-child(2)').text(response['closing_bal']) //it will get the 2nd column value inside tbody // will take you to opening balance credit column
    },'json')

    //to get Investment, Deposit, EL, Exchange and Agent
    let ajaxCall3 = $.post('financeFile/BS/getBSCrDbContents.php', args,function(response){
        $('.benefits-check-card').find('tbody tr:nth-child(3) td:nth-child(2)').text(response['cr_investment']);
        $('.benefits-check-card').find('tbody tr:nth-child(3) td:nth-child(3)').text(response['db_investment']);
        $('.benefits-check-card').find('tbody tr:nth-child(4) td:nth-child(2)').text(response['cr_deposit']);
        $('.benefits-check-card').find('tbody tr:nth-child(4) td:nth-child(3)').text(response['db_deposit']);
        $('.benefits-check-card').find('tbody tr:nth-child(5) td:nth-child(2)').text(response['cr_el']);
        $('.benefits-check-card').find('tbody tr:nth-child(5) td:nth-child(3)').text(response['db_el']);
        $('.benefits-check-card').find('tbody tr:nth-child(6) td:nth-child(2)').text(response['cr_exchange']);
        $('.benefits-check-card').find('tbody tr:nth-child(6) td:nth-child(3)').text(response['db_exchange']);
        $('.benefits-check-card').find('tbody tr:nth-child(7) td:nth-child(2)').text(response['cr_agent']);
        $('.benefits-check-card').find('tbody tr:nth-child(7) td:nth-child(3)').text(response['db_agent']);
    },'json')

    ajaxCalls.push(ajaxCall1,ajaxCall2,ajaxCall3);

    // Now use $.when() to wait for all Ajax calls to complete
    $.when.apply($, ajaxCalls).done(function () {
        // This function will be executed when all Ajax calls are completed successfully
        // Put your code here for the function you want to run after all Ajax calls are completed.
        calculateClosingForBS();
        calculateClosingForBenefit();
        calculateClosingForBenefitCheck();
    });
}
// function to calculate closing details for Benefits calculations
function calculateClosingForBenefitCheck(){
    var credit = 0; var debit = 0;
    var op_text = $('.benefits-check-card').find('tbody tr:first td:nth-child(2)').text();
    var opening_outstanding = parseInt(op_text.replaceAll(',',''));
    var cl_text = $('.benefits-check-card').find('tbody tr:last td:nth-child(3)').text();
    var closing_balance = parseInt(cl_text.replaceAll(',',''));

    $('.benefits-check-card').find('tbody tr').not('tr:last').each(function(){
        let credit_val = ($(this).find('td:nth-child(2)').text()!='') ? $(this).find('td:nth-child(2)').text() : '0';
        credit = credit + parseInt(credit_val.replaceAll(',',''));
        
        let debit_val = ($(this).find('td:nth-child(3)').text()!='') ? $(this).find('td:nth-child(3)').text() : '0';
        debit = debit + parseInt(debit_val.replaceAll(',',''));
    })
    var closing_outstanding = credit - debit;
    debit = debit + closing_outstanding + closing_balance;//included closing outstanding and closing balance also for debit total
    var difference = credit - debit;
    
    $('.benefits-check-card').find('tbody tr:nth-child(8) td:nth-child(3)').text(moneyFormatIndia(closing_outstanding));
    $('.benefits-check-card').find('tfoot tr:first td:nth-child(2)').text(moneyFormatIndia(credit));
    $('.benefits-check-card').find('tfoot tr:first td:nth-child(3)').text(moneyFormatIndia(debit));
    $('.benefits-check-card').find('tfoot tr:last td:nth-child(2)').text(moneyFormatIndia(difference));

    //to calculate difference between benefit and benefit check tables
    // let ben_diff = $('.benefits-card').find('tfoot tr:last td:nth-child(2)').text().replaceAll(',','');
    // let benc_diff = $('.benefits-check-card').find('tfoot tr:last td:nth-child(2)').text().replaceAll(',','');
    // ben_diff = parseInt(ben_diff) - parseInt(benc_diff);
    // $('#BBDiff').text('Difference: '+ moneyFormatIndia(ben_diff));
}



// to clear all contents
function clearAllContents(){
    $('.balance-sheet-card').find('tbody tr').each(function(){
        $(this).find('td:nth-child(2)').text('')
        $(this).find('td:nth-child(3)').text('')
    })
    $('.benefits-card').find('tbody tr').each(function(){
        $(this).find('td:nth-child(2)').text('')
        $(this).find('td:nth-child(3)').text('')
    })
    $('.benefits-check-card').find('tbody tr').each(function(){
        $(this).find('td:nth-child(2)').text('')
        $(this).find('td:nth-child(3)').text('')
    })
}

//alert message
function swalError(title, icon){
    Swal.fire({
        title: title,
        icon: icon,
        showConfirmButton: true,
        confirmButtonColor: '#009688'
    })
}
