<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/main_template.dwt.jsp" codeOutsideHTMLIsLocked="true" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Check-In</title>
<!-- InstanceEndEditable -->

<link href="/main.css" rel="stylesheet" type="text/css" />
<link href="/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="/jquery-ui.js"></script>
<!-- InstanceBeginEditable name="head" -->
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
	var strings = new Array();

	for ( var i = 0; i < $accounts.length; i++) {
		var $account = $($accounts[i]);
		strings.push("<tr><td>");
		strings.push('<a href="/check-in.jsp?id=' + $account.find("id").text() + '&phase=Update">use</a>');
		strings.push("</td><td>");
		strings.push($account.find("bidderId").text());
		strings.push("</td><td>");
		strings.push($account.find("name").text());
		strings.push("</td><td>");
		strings.push($account.find("address").text());
		strings.push("</td><td>");
		strings.push($account.find("phone").text());
		strings.push("</td><td>");
		strings.push($account.find("email").text());
		strings.push("</td><td>");
		/*
		strings.push($account.find("taxId").text());
		strings.push("</td><td>");
		strings.push($account.find("active").text());
		strings.push("</td><td>");
		strings.push($account.find("created").text());
		strings.push("</td><td>");
		strings.push($account.find("modified").text());
		strings.push("</td><td>");
		*/
		strings.push($account.find("id").text());
		strings.push("</td></tr>");
	}
	$table.append(strings.join(""));

	/*
	for ( var i = 0; i < $accounts.length; i++) {
		$tr = $("<tr />").appendTo($table);
		var $account = $($accounts[i]);
		$("<td />").appendTo($tr).append('<a href="/check-in.jsp?id=' + $account.find("id").text() + '&phase=Update">use</a>'); 
		$("<td />").appendTo($tr).text($account.find("bidderId").text());
		$("<td />").appendTo($tr).text($account.find("name").text());
		$("<td />").appendTo($tr).text($account.find("address").text());
		$("<td />").appendTo($tr).text($account.find("phone").text());
		$("<td />").appendTo($tr).text($account.find("email").text());
		//$("<td />").appendTo($tr).text($account.find("taxId").text());
		//$("<td />").appendTo($tr).text($account.find("active").text());
		//$("<td />").appendTo($tr).text($account.find("created").text());
		//$("<td />").appendTo($tr).text($account.find("modified").text());
		$("<td />").appendTo($tr).text($account.find("id").text());
	}
	*/
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

$(function() {
	// load up any data already selected
	if (document.URL.match(/id=\d+/) != null) {
		var id = document.URL.match(/id=\d+/)[0].replace(/id=/, "");
		accountId = id;
		loadAccountsTable(id);
		
	} else {
		loadAccountsTable();
	}
	
	// populate data that is known once an ID is selected
	if (accountId != null) {
		$.ajax({
			url: "/api/accounts/" + accountId,
			success: loadEditForm,
		});
	}
	
	$('#editAccountForm input[type="reset"]').click(function() {
		$('#editAccountForm [name="id"]').text("");
		$('#editAccountForm [name="created"]').text("");
		$('#editAccountForm [name="modified"]').text("");
		$(".status-icon").hide();
		$("#editAccountForm").ajaxForm({
			success : success,
			complete : complete,
			error : error,
			url : "/api/accounts/",
			type : "POST",
			context : $("#editAccountForm"),
			beforeSend : beforeSend,
		});

	});
	// reset the form
	$('#editAccountForm input[type="reset"]').click();

});


function loadEditForm(data, textStatus, jqXHR) {
	var $data = $(data);
	
	var $form = $("#editAccountForm");
	
	// enable UI
	$form.find('input,select').removeAttr("disabled");
	$form.find('input[name="active"]').attr("disabled", "disabled");
	$form.find('textarea').removeAttr("readonly");
	
	// populate UI
	// <input> tags
	$form.find('[name="name"]').val($data.find("name").text());
	$form.find('[name="address"]').val($data.find("address").text());
	$form.find('[name="phone"]').val($data.find("phone").text());
	$form.find('[name="email"]').val($data.find("email").text());
	$form.find('[name="taxId"]').val($data.find("taxId").text());
	$form.find('[name="bidderId"]').val($data.find("bidderId").text());
	// always activate accounts
	//if ($data.find("active").text() != "false") {
		$form.find('[name="active"]').prop("checked", true);
	//} else {
	//	$form.find('[name="active"]').prop("checked", false);
	//}
	// <p> tags
	$form.find('[name="id"]').text($data.find("id").text());
	$form.find('[name="created"]').text($data.find("created").text());
	$form.find('[name="modified"]').text($data.find("modified").text());
	
	$form.ajaxForm({
		success : success,
		complete : complete,
		error : error,
		url : "/api/accounts/" + $data.find("id").text(),
		type : "PUT",
		context : $("#editAccountForm"),
		beforeSend : beforeSend,
	});
	
}


//called by ui
function beforeSend(jqXHR, settings) {
	// lock the UI
	this.find('input,select').attr("disabled", "disabled");
	this.find('textarea').attr("readonly", "readonly");
	this.find(".status-icon").attr("src", "/images/loading.gif").show();
	//$row.find('.donation-status').append('<ul class="status-list" data-lot-id="' + tempLotId + '" ><li class="pending annotation"><img src="/images/loading.gif" style="height: 1.2em; width: 1.2em;" onclick="loadDonation(' + tempLotId + ');"/> Creating donation...</li></ol>');
}

//is called when a the submission request completes.
function success(data, textStatus, jqXHR) {
	this.find(".status-icon").attr("src", "/images/status-ok.png").show();
}

function error(data, textStatus, jqXHR) {
	this.find(".status-icon").attr("src", "/images/status-failed.png").show();
}

function complete(data, textStatus, jqXHR) {
	this.find('input,select').removeAttr("disabled");
	this.find('input[name="active"]').attr("disabled", "disabled");
	this.find('textarea').removeAttr("readonly");
}

</script>
<!-- InstanceEndEditable -->
</head>

<body class="oneColElsCtrHdr">

<div id="container">
  <div id="header" style=";">
    <div style="height: 160px; padding: 1em;">
      <div style="display:block; float:left; height: 160px; width: 260px;"><a href="/"><img src="/images/header.png" name="logo" width="260" height="160" style="border: 0;"/></a></div>
      <!-- InstanceBeginEditable name="Headline" -->
      <div style="font-size:3em; float:left;">Check-In</div>
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
    <div> <a name="select" id="select" /></a>
          <h1>Select Account</h1>
          <blockquote>Welcome, could I have your name?</blockquote>
          <p>Check the list for an existing account:</p>
      <table id="accountsTable">
            <thead>
              <tr>
                <th scope="col"></th>
                <th scope="col">Bidder ID</th>
                <th scope="col">Name</th>
                <th scope="col">Address</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Email</th>
                <!--     <th scope="col">Tax ID</th>
                <th scope="col">Active</th>
                    <th scope="col">Created</th>
                    <th scope="col">Modified</th> -->
                <th scope="col">Internal ID</th>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
              <tr>
                <th scope="col"></th>
                <th scope="col">Bidder ID</th>
                <th scope="col">Name</th>
                <th scope="col">Address</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Email</th>
                <!--     <th scope="col">Tax ID</th>
                <th scope="col">Active</th>
                    <th scope="col">Created</th>
                    <th scope="col">Modified</th> -->
                <th scope="col">Internal ID</th>
              </tr>
            </tfoot>
          </table>
          
    </div>
        <div> <a name="update" id="update" /></a>
          <h1>Create or Update Account</h1>
          <blockquote>Let's make sure we have the right contact info for you.</blockquote>
				<div id="edit">
					<form id="editAccountForm">
						<table>
						  <tr>
						    <td style="vertical-align: top; padding-right: 4em;"><p>Name:<br />
						      <input name="name" type="text" style="font-size: 2.0em; width: 100%;"/>
						      </p>
						      <p>Email:<br />
						        <input name="email" type="text" style="width: 100%;" />
					          </p>
						      <p>Phone:<br />
						        <input name="phone" type="text" style="width: 100%;" value="(509) "/>
						        <span class="annotation">(509) 943-9000</span></p>
						      <p> Address:<br />
						        <textarea name="address" cols="80" rows="2"></textarea>
						        <span class="annotation"><strong><br />
						          </strong></span> <span class="annotation">123 Any St<br />
						            Richland, WA, 99352</span> </p></td>
						    <td style="vertical-align: top; padding-right: 4em;"><p>Tax ID:<br />
						      <input name="taxId" type="text" />
						      <br />
						      <span class="annotation">Do <strong>NOT</strong> enter a Social Security number </span></p>
						      <p>Bidder ID:<br />
						        <input name="bidderId" type="text" />
						        <span class="annotation"><br />
						          From the bidder's program</span></p>
						      <p>
						        <label>
						          <input type="checkbox" name="active" value="active" checked="checked" disabled="disabled" />
						          Active</label>
					          </p></td>
						    <td style="vertical-align: top; padding-right: 4em;"><p>Internal ID:<br />
						      <span name="id" /></span></span></span></p>
						      <p>Created:<br />
						        <span name="created" /></span></span></p>
						      <p>Modified:<br />
						        <span name="modified" /></span></span></p></td>
					      </tr>
					  </table>
						<p>
						  <input id="editAccountButton" type="submit" value="Save/Confirm" />
						  <input
								id="cancelEditAccountButton" type="reset" value="Reset" /> 
						  <img class="status-icon"
								id="editAccountStatus" src="/images/blank.png" />
					  </p>
					</form>
				</div>
            </div>
            <div> <a name="update" id="update" /></a>
              <h1>Done</h1>
              <blockquote>Thank you very much, happy bidding!</blockquote>
              <p>Click <a href="/check-in.jsp">here</a> to start over.</p>
            </div>
  <!-- InstanceEndEditable -->
  <!-- end #mainContent --></div>
  <div id="footer">
    
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
<!-- InstanceEnd --></html>
