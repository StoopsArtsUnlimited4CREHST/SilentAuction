<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/main_template.dwt.jsp" codeOutsideHTMLIsLocked="true" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Lots</title>
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
#allLotsTable td {
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
	$(function() {
		$("#createLotForm").ajaxForm({
			success : success,
			complete : complete,
			error : error,
			context : $("#createLotForm"),
			beforeSend : beforeSend,
		});

		// disable edit for UI until there is something to edit
		$("#cancelEditLotButton").click(function(){
			$("#editLotForm").find('input,select').attr("disabled", "disabled");
			$("#editLotForm").find('textarea').attr("readonly", "readonly");
			$("#editLotForm").find('[name="created"],[name="modified"],[name="id"]').text("");
		}).click();
		
		$('#createLotForm input[type="reset"]').click(function() {
			$(".status-icon").hide();
		});
		$("#tabs").tabs();
		$("#viewTab").click(reloadTable);
		
		
		// switch to tab view
		if (document.URL.match(/id=\d*/) != null) {
			var id = document.URL.match(/id=\d*/)[0]
						.replace("id=", "");
			$.ajax({url: '/api/lots/' + id, success: loadEditForm});
		} else if (document.URL.match(/#create/) != null) {
			$("#createTab").click();
		} else if (document.URL.match(/#edit/) != null) {
			$("#editTab").click();
		} else if (document.URL.match(/#view/) != null) {
			$("#viewTab").click();
		}
	});
	
	function loadEditForm(data, textStatus, jqXHR) {
		var $data = $(data);
		
		var $form = $("#editLotForm");
		
		// enable UI
		$form.find('input,select').removeAttr("disabled");
		$form.find('textarea').removeAttr("readonly");
		
		// populate UI
		// <input> tags
		$form.find('[name="title"]').val($data.find("title").text());
		$form.find('[name="description"]').val($data.find("description").text());
		$form.find('[name="type"]').val($data.find("type").text());
		$form.find('[name="status"]').val($data.find("status").text());
		$form.find('[name="contributor"]').val($data.find("contributor").text());
		$form.find('[name="winner"]').val($data.find("winner").text());
		$form.find('[name="declaredValue"]').val($data.find("declaredValue").text());
		$form.find('[name="finalValue"]').val($data.find("finalValue").text());
		// <p> tags
		$form.find('[name="id"]').text($data.find("id").text());
		$form.find('[name="created"]').text($data.find("created").text());
		$form.find('[name="modified"]').text($data.find("modified").text());
		
		$form.ajaxForm({
			success : success,
			complete : complete,
			error : error,
			url : "/api/lots/" + $data.find("id").text(),
			type : "PUT",
			context : $("#editLotForm"),
			beforeSend : beforeSend,
		});
		
		

		// view edit page 
		$("#editTab").click();
		
	}

	function setLotsInTable(table, lots) {
		var $lots = $(lots);
		var $table = $(table);

		// clear table
		$table.find("tr").remove();
		var strings = new Array();

		for ( var i = 0; i < $lots.length; i++) {
			var $account = $($accounts[i]);
			var $lot = $($lots[i]);
			strings.push("<tr><td>");
			strings.push('<input type="button" value="Edit" onclick="javascript: $.ajax({url: \'/api/lots/' + $lot.find("id").text() +'\', success: loadEditForm});" />');
			strings.push("</td><td>");
			strings.push($lot.find("id").text());
			strings.push("</td><td>");
			strings.push($lot.find("title").text());
			strings.push("</td><td>");
			strings.push($lot.find("description").text());
			strings.push("</td><td>");
			strings.push($lot.find("type").text());
			strings.push("</td><td>");
			strings.push($lot.find("status").text());
			strings.push("</td><td>");
			strings.push('<a href="/accounts.jsp?id=' + $lot.find("contributor").text() + '">' + $lot.find("contributor").text() + '</a>');
			strings.push("</td><td>");
			strings.push($lot.find("declaredValue").text());
			strings.push("</td><td>");
			strings.push('<a href="/accounts.jsp?id=' + $lot.find("winner").text() + '">' + $lot.find("winner").text() + '</a>');
			strings.push("</td><td>");
			strings.push($lot.find("finalValue").text());
			strings.push("</td><td>");
			strings.push($lot.find("created").text());
			strings.push("</td><td>");
			strings.push($lot.find("modified").text());
			strings.push("</td></tr>");
		}
		$table.append(strings.join(""));
		

		/*
		$("<td />").appendTo($tr).append(''); 
			$("<td />").appendTo($tr).text($lot.find("id").text());
			$("<td />").appendTo($tr).text($lot.find("title").text());
			$("<td />").appendTo($tr).text($lot.find("description").text());
			$("<td />").appendTo($tr).text($lot.find("type").text());
			$("<td />").appendTo($tr).text($lot.find("status").text());
			$("<td />").appendTo($tr).append();
			$("<td />").appendTo($tr).text($lot.find("declaredValue").text());
			$("<td />").appendTo($tr).append();
			$("<td />").appendTo($tr).text($lot.find("finalValue").text());
			$("<td />").appendTo($tr).text($lot.find("created").text());
			$("<td />").appendTo($tr).text($lot.find("modified").text());

		}
		*/
	}

	function reloadTable() {
		$.ajax({
			url : "/api/lots",
			success : function(data, textStatus, jqXHR) {
				var $lots = $(data).find("lot");
				setLotsInTable($("#allLotsTable tbody"), $lots);
				var $table = $(this).find('#allLotsTable');
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
		this.find(".status-icon").attr("src", "/images/loading.gif").show();
		//$row.find('.donation-status').append('<ul class="status-list" data-lot-id="' + tempLotId + '" ><li class="pending annotation"><img src="/images/loading.gif" style="height: 1.2em; width: 1.2em;" onclick="loadDonation(' + tempLotId + ');"/> Creating donation...</li></ol>');
	}

	// is called when a the submission request completes.
	function success(data, textStatus, jqXHR) {
		this.find(".status-icon").attr("src", "/images/status-ok.png").show();
	}

	function error(data, textStatus, jqXHR) {
		this.find(".status-icon").attr("src", "/images/status-failed.png").show();
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
      <div style="display:block; float:left; height: 160px; width: 260px;"><a href="/"><img src="/images/header.png" name="logo" width="260" height="160" style="border: 0;"/></a></div>
      <!-- InstanceBeginEditable name="Headline" -->
      <div style="font-size:3em; float:left;">Lots</div>
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
			<h1>Lots</h1>
			<div id="tabs">
				<ul>
					<li><a href="#create" id="createTab">Create</a></li>
					<li><a href="#edit" id="editTab">Edit</a></li>
					<li><a href="#container" id="viewTab">View</a></li>
				</ul>
				<div id="create">
					<form id="createLotForm" action="/api/lots"
						method="post">
						<table border="0">
							<tr>
								<td rowspan="3" style="vertical-align: top; padding-right: 4em;">
									Title<br /> <input name="title" type="text" value=""
									style="font-size: 2.0em; width: 100%;" />

									<p>
										Description<br />
										<textarea name="description" cols="80" rows="4"></textarea>
									</p>
								</td>
								<td>Status:<br /> <select name="status" title="Status">
										<option value="NONE">-</option>
										<option value="NOT_YET_OPENED">New</option>
										<option value="BIDDING_OPEN">Open for bidding</option>
										<option value="BIDDING_CLOSED">Closed to bidding</option>
										<option value="CLOSED_PAID">Closed and paid</option>
										<option value="CANCELLED">Cancelled</option>
								</select>
								</td>
								<td style="padding-right: 4em;">Type:<br /> <select name="type" title="Type">
										<option value="">-</option>
										<option value="RYP">Raise your program</option>
										<option value="SAL">Silent auction lot</option>
								</select></td>
								<td><p name="id">&nbsp;</p></td>
							</tr>
							<tr>
								<td>Contributor ID<br /> <input name="contributor"
									type="text" value="0" />
								</td>
								<td style="padding-right: 4em;">Declared value<br /> $<input
									name="declaredValue" type="text" value="0.00" />
								</td>
								<td><p name="created">&nbsp;</p></td>
							</tr>
							<tr>
								<td>Winner ID<br /> <input name="winner" type="text"
									value="0" />
								</td>
								<td style="padding-right: 4em;">Winning bid<br /> $<input
									name="finalValue" type="text" value="0.00" />
								</td>
								<td><p name="modified">&nbsp;</p></td>
							</tr>
						</table>
						<p>
							<input id="createLotButton" type="submit" value="Create" /> <input
								id="clearLotButton" type="reset" value="Clear" /> <img class="status-icon"
								id="createLotStatus" src="/images/blank.png" />
						</p>
					</form>
				</div>
				<div id="edit">
					<form id="editLotForm">
						<table border="0">
							<tr>
								<td rowspan="3" style="vertical-align: top; padding-right: 4em;">
									Title<br /> <input name="title" type="text" value=""
									style="font-size: 2.0em; width: 100%;" />

									<p>
										Description<br />
										<textarea name="description" cols="80" rows="4"></textarea>
									</p>
								</td>
								<td>Status:<br /> <select name="status" title="Status">
										<option value="NONE">-</option>
										<option value="NOT_YET_OPENED">New</option>
										<option value="BIDDING_OPEN">Open for bidding</option>
										<option value="BIDDING_CLOSED">Closed to bidding</option>
										<option value="CLOSED_PAID">Closed and paid</option>
										<option value="CANCELLED">Cancelled</option>
								</select>
								</td>
								<td style="padding-right: 4em;">Type:<br /> <select name="type" title="Type">
										<option value="">-</option>
										<option value="RYP">Raise your program</option>
										<option value="SAL">Silent auction lot</option>
								</select></td>
								<td>Internal ID:<br /><span name="id" /></td>
							</tr>
							<tr>
								<td>Contributor ID<br /> <input name="contributor"
									type="text" value="0" />
								</td>
								<td style="padding-right: 4em;">Declared value<br /> $<input
									name="declaredValue" type="text" value="0.00" />
								</td>
								<td>Created:<br /><span name="created" /></td>
							</tr>
							<tr>
								<td>Winner ID<br /> <input name="winner" type="text"
									value="0" />
								</td>
								<td style="padding-right: 4em;">Winning bid<br /> $<input
									name="finalValue" type="text" value="0.00" />
								</td>
								<td>Modified:<br /><span name="modified" /></td>
							</tr>
						</table>
						<p>
							<input id="editLotButton" type="submit" value="Save" /> <input
								id="cancelEditLotButton" type="reset" value="Cancel" /> <img class="status-icon"
								id="editLotStatus" src="/images/blank.png" />
						</p>
					</form>
				</div>
                				<div id="container">
					<table cellpadding="0" cellspacing="0" border="0" class="display"
						id="allLotsTable">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">ID</th>
								<th scope="col">Title</th>
								<th scope="col">Description</th>
								<th scope="col">Type</th>
								<th scope="col">Status</th>
								<th scope="col">Contributor</th>
								<th scope="col">Declared Value</th>
								<th scope="col">Winner</th>
								<th scope="col">Final Value</th>
								<th scope="col">Created</th>
								<th scope="col">Modified</th>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
							<tr>
								<th scope="col"></th>
								<th scope="col">ID</th>
								<th scope="col">Title</th>
								<th scope="col">Description</th>
								<th scope="col">Type</th>
								<th scope="col">Status</th>
								<th scope="col">Contributor</th>
								<th scope="col">Declared Value</th>
								<th scope="col">Winner</th>
								<th scope="col">Final Value</th>
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
    
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
<!-- InstanceEnd --></html>
