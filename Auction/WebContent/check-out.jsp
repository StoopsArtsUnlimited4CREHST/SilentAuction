<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/main_template.dwt.jsp" codeOutsideHTMLIsLocked="true" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Check-Out</title>
<!-- InstanceEndEditable -->

<link href="/main.css" rel="stylesheet" type="text/css" />
<link href="/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="/jquery-ui.js"></script>
<!-- InstanceBeginEditable name="head" -->
<!-- <link href="/demo_page.css"
	rel="stylesheet" type="text/css" />
<link href="/demo_table.css"
	rel="stylesheet" type="text/css" /> -->
<style>
td {
	border: thin solid;
	border-color: #BBB;
	margin: 0;
	padding: 0.4em;
}
</style>
<script type="text/javascript" src="/jquery.form.js"></script>
<script class="jsbin"
	src="/jquery.dataTables.nightly.js"></script>
<script type="text/javascript">
var accountId = null;

function setAccountsInTable(table, accounts) {
	var $accounts = $(accounts);
	var $table = $(table);

	// clear table
	$table.find("tr").remove();

	for ( var i = 0; i < $accounts.length; i++) {
		$tr = $("<tr />").appendTo($table);
		var $account = $($accounts[i]);
		$("<td />").appendTo($tr).append('<a href="/check-out.jsp?id=' + $account.find("id").text() + '&phase=Totals">use</a>'); 
		$("<td />").appendTo($tr).text($account.find("id").text());
		$("<td />").appendTo($tr).text($account.find("name").text());
		//$("<td />").appendTo($tr).text($account.find("address").text());
		//$("<td />").appendTo($tr).text($account.find("phone").text());
		//$("<td />").appendTo($tr).text($account.find("email").text());
		//$("<td />").appendTo($tr).text($account.find("taxId").text());
		$("<td />").appendTo($tr).text($account.find("bidderId").text());
		//$("<td />").appendTo($tr).text($account.find("active").text());
		//$("<td />").appendTo($tr).text($account.find("created").text());
		//$("<td />").appendTo($tr).text($account.find("modified").text());

		/*
		for ( var j = 0; j < $account.children.length; j++) {
			$("<td />").appendTo($tr).text($($account.children[j]).text());
		}
		*/
	}
}

function loadAccountsTable(id) {
	var url;
	if (id != null) {
		url = "/api/accounts/" + id;		
	} else {
		url = "/api/accounts";		
	}
	$.ajax({
		url : url,
		success : function(data, textStatus, jqXHR) {
			var $accounts = $(data).find("account");
			setAccountsInTable($("#accountsTable tbody"), $accounts);
			var $table = $(this).find('#accountsTable');
			//$table.dataTable();
		},
		context : document,
	});
}

function setLotsInTable(table, lots) {
	var $lots = $(lots);
	var $table = $(table);

	// clear table
	$table.find("tr").remove();

	for ( var i = 0; i < $lots.length; i++) {
		$tr = $("<tr />").appendTo($table);
		var $lot = $($lots[i]);
		if ($lot.find("status").text() == "BIDDING_CLOSED") {
			// eligible to be paid
			$("<td />").appendTo($tr).append('<input class="lotSelectionCheckbox" type="checkbox" name="lot" value="lot" checked="checked"/>'); 
		} else {
			// not eligible to be paid
			$("<td />").appendTo($tr).append('<span class="annotation">paid</span>'); 
		}
		$('<td class="lotId"/>').appendTo($tr).text($lot.find("id").text());
		$("<td />").appendTo($tr).text($lot.find("title").text());
		//$("<td />").appendTo($tr).text($lot.find("description").text());
		$("<td />").appendTo($tr).text($lot.find("status").text());
		//$("<td />").appendTo($tr).append('<a href="/accounts.jsp?id=' + $lot.find("contributor").text() + '">' + $lot.find("contributor").text() + '</a>');
		//$("<td />").appendTo($tr).text(new Number($lot.find("declaredValue").text()).toFixed(2));
		//$("<td />").appendTo($tr).append('<a href="/accounts.jsp?id=' + $lot.find("winner").text() + '">' + $lot.find("winner").text() + '</a>');
		$('<td class="lotFinalValue" />').appendTo($tr).text(new Number($lot.find("finalValue").text()).toFixed(2));
		//$("<td />").appendTo($tr).text($lot.find("created").text());
		//$("<td />").appendTo($tr).text($lot.find("modified").text());

		/*
		for ( var j = 0; j < $lot.children.length; j++) {
			$("<td />").appendTo($tr).text($($lot.children[j]).text());
		}
		*/
	}
	$(".lotSelectionCheckbox").click(calculatePayableTotal);
	calculatePayableTotal();
	validatePaymentAmount();

	
}

function calculatePayableTotal() {
	var $table = $("#lotsWonTable tbody");
	
	var total = 0;
	$table.find("tr").each(function(index, row) {
		var $row = $(row);
		if ($row.find('input[type="checkbox"]').length > 0
				&& $row.find('input[type="checkbox"]').prop("checked") == true) {
			total += new Number($row.find(".lotFinalValue").text());
		}
	});
	$(".lotsTotalValue").text(total.toFixed(2));
	validatePaymentAmount();
}

function loadLotsTable(id) {
	$.ajax({
		url : "/api/lots?winner=" + id,
		success : function(data, textStatus, jqXHR) {
			var $lots = $(data).find("lot");
			setLotsInTable($("#lotsWonTable tbody"), $lots);
			var $table = $(this).find('#lotsWonTable');
			//$table.dataTable();
		},
		context : document,
	});
}

function validatePaymentAmount() {
	var expected = new Number($(".lotsTotalValue").first().text());
	var actual = new Number($("#sendPaymentText").val());
	//alert("expected=" + expected + "\nactual=" + actual);
	if ((Math.abs(expected - actual) < 0.000001)) {
		if (actual == 0) {
			$("#sendPaymentButton").attr("disabled", "disabled");
			$("#sendPaymentAnnotation").text("Can't submit a zero-dollar payment.");
		} else {
			$("#sendPaymentButton").removeAttr("disabled");		
			$("#sendPaymentAnnotation").text("Amount matches.");
		}
	} else {
		$("#sendPaymentButton").attr("disabled", "disabled");
		$("#sendPaymentAnnotation").text("Amount doesn't match.");
	}
}

function postPayment() {
	// disable inputs
	var $inputs = $("input");
	$inputs.attr("disabled", "disabled");
	$("#paymentStatusList").append("<li>Sending payment information...</li>");

	// construct payment XML
	var lots = "";
	var $table = $("#lotsWonTable tbody");
	$table.find("tr").each(function(index, row) {
		var $row = $(row);
		if ($row.find('input[type="checkbox"]').length > 0
				&& $row.find('input[type="checkbox"]').prop("checked") == true) {
			lots += '<lot><id>' + $row.find(".lotId").text() + '</id></lot>';
		}
	});
	var data = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><payment><account>' + accountId + '</account><amount>' + new Number($("#sendPaymentText").val()).toFixed(2) + '</amount><forLots>' + lots + '</forLots></payment>';
	// data not included
	// '<comments>testing Not sure if cedar chips are legal tender</comments><instrument>Cedar nacho chips</instrument><links href="132465" rel="payment-for"/><modified>2013-03-16T15:50:10-07:00</modified><received>2013-02-16T20:55:03-08:00</received></payment>';
	
	$.ajax({
		url :	"/api/payments",
		type :	"POST",
		data :	data,
		success :	function() {
			$("#paymentStatusList").append("<li>Payment posted successfully.</li>");
			$("#sendPaymentText").val("");
			loadLotsTable(accountId);
		},
		error :	function(data) {
			$("#paymentStatusList").append("<li>Failed to post payment. The server says: " + data + "</li>");
		},
		contentType : "application/xml",
		complete : function() {	$inputs.removeAttr("disabled"); },
	});
}

$(function() {
	// load up any data already selected
	if (document.URL.match(/id=\d+/) != null) {
		var id = document.URL.match(/id=\d+/)[0].replace(/id=/, "");
		accountId = id;
		$("#accountStatement").attr("href", "/api/accounts/" + accountId + "/statement?print=true");
		loadAccountsTable(id);
	} else {
		loadAccountsTable();
	}
	
	// populate data that is known once an ID is selected
	if (accountId != null) {
		loadLotsTable(accountId);
	}
	
	$("#sendPaymentText").change(validatePaymentAmount);
	$("#sendPaymentText").keyup(validatePaymentAmount);
	$("#sendPaymentButton").click(postPayment);
});

</script>
<!-- InstanceEndEditable -->
</head>

<body class="oneColElsCtrHdr">

<div id="container">
  <div id="header" style=";">
    <div style="height: 160px; padding: 1em;">
      <div style="display:block; float:left; height: 160px; width: 260px;"><a href="/"><img src="/images/header.png" name="logo" width="260" height="160" style="border: 0;"/></a></div>
      <!-- InstanceBeginEditable name="Headline" -->
      <div style="font-size:3em; float:left;">Check-Out</div>
      <!-- InstanceEndEditable --></div>
    <div class="nav-bar">
        <a href="/check-in.jsp">Check In</a>
        <!-- <a href="raise-your-program.jsp">Raise Your Program</a>
        <a href="lot-closing.jsp">Lot Closing</a> -->
        <a href="check-out.jsp">Check Out</a>
        <a href="accounts.jsp#view">Accounts</a>
        <a href="lots.jsp#view">Lots</a>
        <!-- <a href="payments.jsp">Payments</a>
        <a href="search.jsp">Search</a>
        <a href="#">Admin</a> -->
    </div>
<!-- end #header --></div>
  <div id="mainContent"><!-- InstanceBeginEditable name="Body" -->
  <div>
  	<a name="select" />
  	<h1>Select a bidder</h1>
        <table id="accountsTable">
            <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <!-- <th scope="col">Address</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Email</th>
                    <th scope="col">Tax ID</th> -->
                    <th scope="col">Bidder ID</th>
                    <!-- <th scope="col">Active</th>
                    <th scope="col">Created</th>
                    <th scope="col">Modified</th> -->
                </tr>
            </thead>
            <tbody></tbody>
            <tfoot>
                <tr>
                    <th scope="col"></th>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <!-- <th scope="col">Address</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Email</th>
                    <th scope="col">Tax ID</th> -->
                    <th scope="col">Bidder ID</th>
                    <!-- <th scope="col">Active</th>
                    <th scope="col">Created</th>
                    <th scope="col">Modified</th> -->
                </tr>
            </tfoot>
        </table>
  </div>
  <div>
  	<a name="totals" />
	<h1>Totals</h1>
    Lots won:
    <table id="lotsWonTable">
        <thead>
            <tr>
                <th scope="col"></th>
                <th scope="col">ID</th>
                <th scope="col">Title</th>
                <!-- <th scope="col">Description</th> -->
                <th scope="col">Status</th>
                <!-- <th scope="col">Contributor</th>
                <th scope="col">Declared Value</th> -->
                <!-- <th scope="col">Winner</th> -->
                <th scope="col">Final Value</th>
                <!-- <th scope="col">Created</th>
                <th scope="col">Modified</th> -->
            </tr>
        </thead>
        <tbody></tbody>
        <tfoot>
            <tr>
                <th scope="col"></th>
                <th scope="col">ID</th>
                <th scope="col">Title</th>
                <!-- <th scope="col">Description</th> -->
                <th scope="col">Status</th>
                <!-- <th scope="col">Contributor</th>
                <th scope="col">Declared Value</th> -->
                <!-- <th scope="col">Winner</th> -->
                <th scope="col">Final Value</th>
                <!-- <th scope="col">Created</th>
                <th scope="col">Modified</th> -->
            </tr>
        </tfoot>
    </table>
    <p>Total: $<span class="lotsTotalValue">0.00</span></p>
  </div>
  <div>
  	<a name="payment" />
	<h1>Payment</h1>
	<p>The total owed is $<span class="lotsTotalValue">0.00</span>.</p>
	<p>Enter the amount paid: 
	    $<input type="text" name="textfield" id="sendPaymentText" />
	    <input type="button" name="button" id="sendPaymentButton" value="Submit Payment" disabled="disabled"/><span id="sendPaymentAnnotation" class="annotation"></span>
	</p>
	<ul id="paymentStatusList" class="annotation"></ul>
  </div>
  <div>
  	<a name="print" />
  	<h1>Print statement of account</h1>
  	<p><a id="accountStatement" target="_blank">Print account statement.</a></p>
  	<p>&nbsp;</p>
  </div>
  <!-- InstanceEndEditable -->
  <!-- end #mainContent --></div>
  <div id="footer">
    
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
<!-- InstanceEnd --></html>
