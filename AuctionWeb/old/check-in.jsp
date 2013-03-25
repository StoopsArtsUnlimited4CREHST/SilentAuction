<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Check-in</title>
<link href="main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.9.1.js"></script>
<script type="text/javascript" src="Account.js"></script>
<script type="text/javascript" src="Lot.js"></script>
<script type="text/javascript" src="auction.js"></script>
<script type="text/javascript">
function getLotFromInputs(rootElement) {
	// find property elements
	var contributor = $("input.lot_contributor", rootElement).val();
	var created = $("input.lot_created", rootElement).val();
	var declaredValue = $("input.lot_declaredValue", rootElement).val();
	var description = $("input.lot_description", rootElement).val();
	var finalValue = $("input.lot_finalValue", rootElement).val();
	var id = $("input.lot_id", rootElement).val();
	var modified = $("input.lot_modified", rootElement).val();
	var status = $("input.lot_status", rootElement).val();
	var title = $("input.lot_title", rootElement).val();
	var winner = $("input.lot_winner", rootElement).val();
	
	var r = new Lot(id, title, description, status, declaredValue, finalValue, winner, contributor, created, modified);
	return r;
}


function postLot() {
	var lot = getLotFromInputs($(newLot));
	listLot(lot, $("#lots_table"));
	$.post(
			"http://localhost:8080/WebAuction/lots",
			lot.getXml(),
			null,
			"xml");
}

function save_onclick() {
	try {
		postLot();
		showSuccess("Lot created.");
	} catch (e) {
		showFailure("Failed to create lot. " + e);
	}
}

function search_accounts_onclick() {
	var accounts = getAccountArrayFromXml("");
	for (var i = 0; i < accounts.length; i++) {
		accounts[i].appendToTable("#account_search_table");
	}
	// add interactives to table
	//$("#account_search_table .account").prepend('<td classe="select"><input type="radio" name="RadioGroup1" value="radio" /></td>');
	// hide some columns
	$("#account_search_table .id").hide()
	$("#account_search_table .taxId").hide()
	$("#account_search_table .bidderId").hide()
	$("#account_search_table .active").hide()
	$("#account_search_table .created").hide()
	$("#account_search_table .modified").hide()
}



function reset() {
	$("#check-in_select").show();
	$("#check-in_edit").hide();
	$("#check-in_print").hide();
}

function select_accept_onclick() {
	$("#check-in_select").hide();
	$("#check-in_edit").show();
}
function edit_rollback_onclick() {
	$("#check-in_edit").hide();
	$("#check-in_select").show();
}
function edit_accept_onclick() {
	$("#check-in_edit").hide();
	$("#check-in_print").show();
}
function print_rollback_onclick() {
	$("#check-in_print").hide();
	$("#check-in_edit").show();
}
function print_accept_onclick() {
	$("#check-in_print").hide();
	$("#check-in_select").show();
}


function listLot(lot, table) {
	$(table).append($('<tr>' + 
			'<td><a href="#">edit</a></td>' + 
			'<td><a href="#">delete</a></td>' + 
			'<td>' + toStringOrBlank(lot.id) + '</td>' + 
			'<td>' + toStringOrBlank(lot.title) + '</td>' + 
			'<td>' + shorten(toStringOrBlank(lot.description), 40) + '</td>' + 
			'<td>' + toStringOrBlank(lot.contributor) + '</td>' + 
			'<td>' + toStringOrBlank(lot.declaredValue) + '</td>' + 
			'<td>' + toStringOrBlank(lot.winner) + '</td>' + 
			'<td>' + toStringOrBlank(lot.finalValue) + '</td>' + 
			'<td>' + toStringOrBlank(lot.status) + '</td>' + 
			//'<td>' + toStringOrBlank(lot.created) + '</td>' + 
			//'<td>' + toStringOrBlank(lot.modified) + '</td>' + 
			'</tr>'));
}

$(document).ready(function() {
	reset();
});
</script>
</head>

<body>
    <div id="messageHost" />
    <div>
      <form>
      	<h1>Check-in</h1>
        <div id="check-in_select">
          <h2>Find account</h2>
          <blockquote class="blurb">"Hi, may I have your name?"</blockquote>
          <p>Select account from list or create a new acount.</p>
          <p>
            <input type="button" onclick="search_accounts_onclick();" value="Search" />
          </p>
		<table width="100%" border="1px" id="account_search_table" style="width:auto;">
		  <tr>
		    <th scope="col" class="select">Select</th>
		    <th scope="col" class="id">ID</th>
		    <th scope="col" class="name">Name</th>
		    <th scope="col" class="address">Address</th>
		    <th scope="col" class="phone">Phone</th>
		    <th scope="col" class="email">Email</th>
		    <th scope="col" class="taxId">Tax ID</th>
		    <th scope="col" class="bidderId">Bidder ID</th>
		    <th scope="col" class="active">Active</th>
		    <th scope="col" class="created">Created</th>
		    <th scope="col" class="modified">Modified</th>
		  </tr>
		  </table>
          <div class="process_nav">
          	<input type="button" onclick="select_accept_onclick();" value="Edit account" />
          </div>
        </div>
        <div id="check-in_edit">
          <h2>Create/update account</h2>
          <blockquote class="blurb">"Let me confirm our contact info for you."</blockquote>
          <p>Edit fields as necessary.</p>
          	<table width="100%" border="1px" id="account">
                <tr class="active">
                  <th scope="row">Active</th>
                  <td>
                  	<input name="" type="checkbox" checked="checked" disabled="disabled"/> <span class="commentary">(Account will be automatically activated.)</span>
                  </td>
                </tr>
                <tr class="id">
                  <th scope="row">ID</th>
                  <td>
                  	123456
                    <!--<input type="text" class="account_id" name="account_id" id="account_id" /> -->
                  </td>
                </tr>
                <tr class="name">
                  <th scope="row">Name</th>
                  <td>
                    <input type="text" class="account_name" name="account_name" id="account_name" />
                  </td>
                </tr>
                <tr class="address">
                  <th scope="row">Address</th>
                  <td><input type="text" class="account_address" name="account_address" id="account_address" /></td>
                </tr>
                <tr class="phone">
                  <th scope="row">Phone</th>
                  <td>
                    <input type="text" class="account_phone" name="account_phone" id="account_phone" />
                  </td>
                </tr>
                <tr class="email">
                  <th scope="row">Email</th>
                  <td><input type="text" class="account_email" name="account_email" id="account_email" /></td>
                </tr>
                <tr class="taxId">
                  <th scope="row">Tax ID </th>
                  <td><input type="text" class="account_tax_id" name="account_tax_id" id="account_tax_id" /><br />
                    <span class="commentary">Not encrypted,  do <strong>NOT</strong> enter a social security number.</span></td>
                </tr>
                <tr class="bidderId">
                  <th scope="row">Bidder ID</th>
                  <td>
                    <input type="text" class="account_bidder_id" name="account_bidder_id" id="account_bidder_id" />
                  </td>
                </tr>
                <tr class="created">
                  <th scope="row">Created</th>
                  <td class="created">
                  	January 1, 1970 12:00:00 AM
                    <!--<input type="text" class="account_created" name="account_created" id="account_created" /> -->
                  </td>
                </tr>
                <tr class="modified">
                  <th scope="row">Last Modified</th>
                  <td class="modified">
                  	January 1, 1970 12:00:00 AM
                    <!--<input type="text" class="account_modified" name="account_modified" id="account_modified" /> -->
                  </td>
                </tr>
	        </table>
          <div class="process_nav">
          	<input type="button" onclick="edit_rollback_onclick();" value="Select different account" />
          	<input type="button" onclick="edit_accept_onclick();" value="Print" />
          </div>
        </div>
        <div id="check-in_print">
          <h2>Print</h2>
          <blockquote class="blurb">"Thank you. Just a minute and I'll have your auction paddle printed out."</blockquote>
          <p>Click print, give the bidder the printout.</p>
          <p>Start the next bidder.</p>
          <div class="process_nav">
          	<input type="button" onclick="print_rollback_onclick();" value="Update bidder info" />
          	<input type="button" onclick="print_accept_onclick();" value="Next Bidder" />
          </div>
        </div>
	</form>
</div>
</body>
</html>