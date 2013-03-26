<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/main_template.dwt.jsp" codeOutsideHTMLIsLocked="true" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Accounts</title>
<!-- InstanceEndEditable -->

<link href="main.css" rel="stylesheet" type="text/css" />
<link href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<!-- InstanceBeginEditable name="head" -->
<link href="http://live.datatables.net/media/css/demo_page.css"
	rel="stylesheet" type="text/css" />
<link href="http://live.datatables.net/media/css/demo_table.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery.form.js"></script>
<script class="jsbin"
	src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
<script type="text/javascript">
	$(function() {
		$("#createAccountForm").ajaxForm({
			success : success,
			complete : complete,
			error : error,
			context : $("#createAccountForm"),
			beforeSend : beforeSend,
		});

		// disable edit for UI until there is something to edit
		$("#cancelEditAccountButton").click(function(){
			$("#editAccountForm").find('input,select').attr("disabled", "disabled");
			$("#editAccountForm").find('textarea').attr("readonly", "readonly");
			$("#editAccountForm").find('[name="created"],[name="modified"],[name="id"]').text("");
		}).click();
		
		$('#editAccountForm input[type="reset"]').click(function() {
			$(".status-icon").hide();
		});
		$("#tabs").tabs();
		$("#viewTab").click(reloadTable);
		
		
		// switch to tab view
		if (document.URL.match(/#create/) != null) {
			$("#createTab").click();
		} else if (document.URL.match(/#edit/) != null) {
			$("#editTab").click();
		} else if (document.URL.match(/#view/) != null) {
			$("#viewTab").click();
		}
	});
	
	function loadEditForm(data, textStatus, jqXHR) {
		var $data = $(data);
		
		var $form = $("#editAccountForm");
		
		// enable UI
		$form.find('input,select').removeAttr("disabled");
		$form.find('textarea').removeAttr("readonly");
		
		// populate UI
		// <input> tags
		$form.find('[name="name"]').val($data.find("name").text());
		$form.find('[name="address"]').val($data.find("address").text());
		$form.find('[name="phone"]').val($data.find("phone").text());
		$form.find('[name="email"]').val($data.find("email").text());
		$form.find('[name="taxId"]').val($data.find("taxId").text());
		$form.find('[name="bidderId"]').val($data.find("bidderId").text());
		if ($data.find("active").text() != "false") {
			$form.find('[name="active"]').prop("checked", true);
		} else {
			$form.find('[name="active"]').prop("checked", false);
		}
		// <p> tags
		$form.find('[name="id"]').text($data.find("id").text());
		$form.find('[name="created"]').text($data.find("created").text());
		$form.find('[name="modified"]').text($data.find("modified").text());
		
		$form.ajaxForm({
			success : success,
			complete : complete,
			error : error,
			url : "/AuctionRestApi/accounts/" + $data.find("id").text(),
			type : "PUT",
			context : $("#editAccountForm"),
			beforeSend : beforeSend,
		});

		// view edit page 
		$("#editTab").click();
		
	}

	function setAccountsInTable(table, accounts) {
		var $accounts = $(accounts);
		var $table = $(table);

		// clear table
		$table.find("tr").remove();

		for ( var i = 0; i < $accounts.length; i++) {
			$tr = $("<tr />").appendTo($table);
			var $account = $($accounts[i]);
			$("<td />").appendTo($tr).append('<input type="button" value="Edit" onclick="javascript: $.ajax({url: \'/AuctionRestApi/accounts/' + $account.find("id").text() +'\', success: loadEditForm});" />'); 
			$("<td />").appendTo($tr).text($account.find("id").text());
			$("<td />").appendTo($tr).text($account.find("name").text());
			$("<td />").appendTo($tr).text($account.find("address").text());
			$("<td />").appendTo($tr).text($account.find("phone").text());
			$("<td />").appendTo($tr).text($account.find("email").text());
			$("<td />").appendTo($tr).text($account.find("taxId").text());
			$("<td />").appendTo($tr).text($account.find("bidderId").text());
			$("<td />").appendTo($tr).text($account.find("active").text());
			$("<td />").appendTo($tr).text($account.find("created").text());
			$("<td />").appendTo($tr).text($account.find("modified").text());

			/*
			for ( var j = 0; j < $account.children.length; j++) {
				$("<td />").appendTo($tr).text($($account.children[j]).text());
			}
			*/
		}
	}

	function reloadTable() {
		$.ajax({
			url : "/AuctionRestApi/accounts",
			success : function(data, textStatus, jqXHR) {
				var $accounts = $(data).find("account");
				setAccountsInTable($("#example tbody"), $accounts);
				var $table = $(this).find('#example');
				//$table.dataTable();
			},
			context : document,
		});
	}

	// called by ui
	function beforeSend(jqXHR, settings) {
		// lock the UI
		this.find('input,select').attr("disabled", "disabled");
		this.find('textarea').attr("readonly", "readonly");
		this.find(".status-icon").attr("src", "images/loading.gif").show();
		//$row.find('.donation-status').append('<ul class="status-list" data-lot-id="' + tempLotId + '" ><li class="pending annotation"><img src="images/loading.gif" style="height: 1.2em; width: 1.2em;" onclick="loadDonation(' + tempLotId + ');"/> Creating donation...</li></ol>');
	}

	// is called when a the submission request completes.
	function success(data, textStatus, jqXHR) {
		this.find(".status-icon").attr("src", "images/status-ok.png").show();
	}

	function error(data, textStatus, jqXHR) {
		this.find(".status-icon").attr("src", "images/status-failed.png").show();
	}

	function complete(data, textStatus, jqXHR) {
		this.find('input,select').removeAttr("disabled");
		this.find('textarea').removeAttr("readonly");
	}
</script>
<style>
.status-icon {
	height: 2em;
	width: 2em;
}
</style>
<!-- InstanceEndEditable -->
</head>

<body class="oneColElsCtrHdr">

<div id="container">
  <div id="header" style=";">
    <div style="height: 160px; padding: 1em;">
      <div style="background-image: url(); background-repeat:no-repeat; display:block; float:left; height: 160px; width: 260px;"><a href="/AuctionWeb"><img name="logo" src="http://www.crehst.org/wp-content/themes/crehst/images/header.png" alt="" style="border: 0;"/></a></div>
      <!-- InstanceBeginEditable name="Headline" -->
      <div style="font-size:3em; float:left;">Accounts</div>
      <!-- InstanceEndEditable --></div>
    <div class="nav-bar">
        <a href="check-in.jsp">Check In</a>
        <a href="raise-your-program.jsp">Raise Your Program</a>
        <a href="lot-closing.jsp">Lot Closing</a>
        <a href="check-out.jsp">Check Out</a>
        <a href="accounts.jsp">Accounts</a>
        <a href="lots.jsp">Lots</a>
        <!-- <a href="payments.jsp">Payments</a>
        <a href="search.jsp">Search</a>
        <a href="#">Admin</a> -->
    </div>
<!-- end #header --></div>
  <div id="mainContent"><!-- InstanceBeginEditable name="Body" -->
			<h1>Accounts</h1>
			<div id="tabs">
				<ul>
					<li><a href="#create" id="createTab">Create</a></li>
					<li><a href="#edit" id="editTab">Edit</a></li>
					<li><a href="#container" id="viewTab">View</a></li>
				</ul>
				<div id="create">
					<form id="createAccountForm" action="/AuctionRestApi/accounts"
						method="post">
					  <table>
					    <tr>
					      <td style="vertical-align: top; padding-right: 4em;"><p>Name:<br /><input name="name" type="text" style="font-size: 2.0em; width: 100%;"/>
					      </p>
					        <p>Email:<br /><input name="email" type="text" style="width: 100%;" />
					        </p>
					        <p>Phone:<br /><input name="phone" type="text" style="width: 100%;" value="(509) "/>
					          <span class="annotation">(509) 943-9000</span></p>
					        <p>
					          Address:<br /><textarea name="address" cols="80" rows="2"></textarea>
				              <span class="annotation"><strong><br />
				              </strong></span>
				              <span class="annotation">John Doe<br />
					        123 Any St<br />
					        Richland, WA, 99352</span>
</p>
					        </td>
					      <td style="vertical-align: top; padding-right: 4em;"><p>Tax ID:<br /><input name="taxId" type="text" />
				            <br />
			                <span class="annotation">Do <strong>NOT</strong> enter a Social Security number </span></p>
					        <p>Bidder ID:<br />
					          <input name="bidderId" type="text" />
					          <span class="annotation"><br />
					          From the bidder's program</span></p>
					        <p>
					          <label>
					            <input type="checkbox" name="active" value="active"/>
					            Active</label>
					        </p></td>
					      <td style="vertical-align: top; padding-right: 4em;"><p>Internal ID:<br />
					        <span name="id" /></span></span></p>
                            <p>Created:<br /><span name="created" /></span></p>
					        <p>Modified:<br /><span name="modified" /></span></p></td>
				        </tr>
				      </table>
					  <p>
						  <input id="createAccountButton" type="submit" value="Create" /> <input
								id="clearAccountButton" type="reset" value="Clear" /> <img class="status-icon"
								id="createAccountStatus" src="images/blank.png" />
					  </p>
				  </form>
				</div>
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
						          </strong></span> <span class="annotation">John Doe<br />
						            123 Any St<br />
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
						          <input type="checkbox" name="active" value="active" />
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
						  <input id="editAccountButton" type="submit" value="Save" />
						  <input
								id="cancelEditAccountButton" type="reset" value="Cancel" /> 
						  <img class="status-icon"
								id="editAccountStatus" src="images/blank.png" />
					  </p>
					</form>
				</div>
                				<div id="container">
					<table cellpadding="0" cellspacing="0" border="0" class="display"
						id="example">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">ID</th>
								<th scope="col">Name</th>
								<th scope="col">Address</th>
								<th scope="col">Phone</th>
								<th scope="col">Email</th>
								<th scope="col">Tax ID</th>
								<th scope="col">Bidder ID</th>
								<th scope="col">Active</th>
								<th scope="col">Created</th>
								<th scope="col">Modified</th>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
							<tr>
								<th scope="col"></th>
								<th scope="col">ID</th>
								<th scope="col">Name</th>
								<th scope="col">Address</th>
								<th scope="col">Phone</th>
								<th scope="col">Email</th>
								<th scope="col">Tax ID</th>
								<th scope="col">Bidder ID</th>
								<th scope="col">Active</th>
								<th scope="col">Created</th>
								<th scope="col">Modified</th>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
              <!-- InstanceEndEditable -->
  <!-- end #mainContent --></div>
  <div id="footer">
    <p>Footer</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
<!-- InstanceEnd --></html>
