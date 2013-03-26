<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Raise Your Program</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="main.css" />
<script>
	$(function() {
		$("#accordion").accordion({
			heightStyle: "content"
		});
	});
</script>
<style>
.canceled {
	text-decoration: line-through;
}

.status-list {
	list-style: none;
	margin: 0.2em;
	padding: 0.2em;
}

</style>
<script type="text/javascript">
// called by ui
function submitDonation(button) {
	// ui stuff
	var $button = $(button);
	$button.attr("disabled", "disabled");
	var $row = $button.parents('tr');
	$row.find('input[type="text"]').attr("disabled", "disabled");
	var tempLotId = Math.random();
	$row.find('.donation-status').append('<ul class="status-list" data-lot-id="' + tempLotId + '" ><li class="pending annotation"><img src="images/loading.gif" style="height: 1.2em; width: 1.2em;" onclick="loadDonation(' + tempLotId + ');"/> Creating donation...</li></ol>');
	
	// submit donation to web service
	
}

// is called when a the submission request completes.
function loadDonation(tempLotId) {
	var $statusList = $('ul[data-lot-id="' + tempLotId + '"]');
	var amount = 999;
	var donorName = "Buddy Stoops";
	var lotId = 654;
	$statusList.attr("data-lot-id", lotId);
	// clear out the pending status
	$statusList.children(".pending").remove();
	// assume success
	// append a new status
	$statusList.append('<li class="annotation"><img src="images/status-ok.png" style="height: 1.2em; width: 1.2em;" />Created donation of $' + amount.toFixed(2) +' for ' + donorName + ' (lot #' + lotId + '). <a data-operation="cancel" href="javascript: cancelDonation(' + lotId + ');">Cancel</a></li>');
}

// called by ui
function cancelDonation(lotId) {
	var $statusList = $('ul[data-lot-id="' + lotId + '"]');
	$statusList.children().last().addClass("canceled").find('[data-operation="cancel"]').remove();
	$statusList.append('<li class="pending annotation"><img src="images/loading.gif" style="height: 1.2em; width: 1.2em;" onclick="canceledDonation(' + lotId + ');"/> Canceling...</li>');
}

// is called when the cancellation request completes
function canceledDonation(lotId) {
	var $statusList = $('ul[data-lot-id="' + lotId + '"]');
	// assume success
	// clear out the pending status
	$statusList.children(".pending").remove();
	// assume success
	// append a new status
	$statusList.append('<li class="annotation"><img src="images/status-ok.png" style="height: 1.2em; width: 1.2em;" />Canceled lot #' + lotId + '.</li>');
}

function addDonations() {
	for (var i = 0; i < 5; i++) {
		$('#donations')
			.children()
			.last()
			.before('<tr><td valign="top"><input type="text"/></td><td valign="top"><input type="button" value="Submit" onClick="submitDonation(this);"/></td><td valign="top" class="donation-status"></td></tr>');
	}
}

</script>
</head>
<body>
	<div id="accordion">
		<h1 id="amount-header">Donation amount</h1>
		<div>
			$<input id="amount" type="text" style="text-align: right;" />
	      <input id="amount-commit" type="button" value="Go" onClick="
	      $('#amount,#amount-commit').attr('disabled','disabled');
	      $('#amount-header').text('Donation amount: $' + $('#amount').val());
	      $('#donors-header').click();
	      "/>
		</div>
		<h1 id="donors-header">Enter donors</h1>
		<div>
		<table>
			<thead>
				<tr>
					<th width="144" scope="col">Bidder ID</th>
				</tr>
			</thead>
			<tbody id="donations">
				<tr>
					<td valign="top"><input type="text" value="B064" /></td>
					<td valign="top"><input type="button" value="Submit" onClick="submitDonation(this);"/></td>
					<td valign="top" class="donation-status"></td>
				</tr>
				<!-- 
				<tr>
					<td valign="top"><input name="" type="text" value="B063" disabled="disabled" /></td>
					<td valign="top"><input name="" type="button" value="Submit" disabled="disabled" onClick="$(this).attr('disabled','disabled')"/></td>
					<td valign="top">
							<nobr><img src="images/status-ok.png"
								style="height: 1.2em; width: 1.2em;" /><span
								style="color: #888; text-decoration: line-through;">Added
									donation of $100 for Buddy Stoops.</span></nobr><br />
							<nobr><img src="images/status-ok.png"
								style="height: 1.2em; width: 1.2em;" /><span
								style="color: #888;">Canceled donation, lot ID: 9874.</span></nobr><br />
					</td>
				</tr>
				<tr>
					<td valign="top"><input name="" type="text" value="B01234" /></td>
					<td valign="top"><input name="input2" type="button" value="Submit" onClick="$(this).attr('disabled','disabled')"/></td>
					<td valign="top"><img src="images/status-failed.png"
						style="height: 1.2em; width: 1.2em;" /> <span style="color: red;">Unable
							to find bidder "B01234"</span></td>
				</tr> -->
				<tr>
					<td valign="top"><input name="" type="text" value="" /></td>
					<td valign="top"><input name="" type="button" value="Submit" onClick="$(this).attr('disabled','disabled')"/></td>
					<td valign="top"></td>
				</tr>
				<tr>
					<td valign="top"><input name="" type="text" value="" /></td>
					<td valign="top"><input name="" type="button" value="Submit" onClick="$(this).attr('disabled','disabled')"/></td>
					<td valign="top"></td>
				</tr>
				<tr>
					<td valign="top"><input name="" type="text" value="" /></td>
					<td valign="top"><input name="" type="button" value="Submit" onClick="$(this).attr('disabled','disabled')"/></td>
					<td valign="top"></td>
				</tr>
				<tr>
					<td valign="top"><img src="images/plus.png" style="width: 2.0em; height: 2.0em;" onClick="addDonations();"></td>
				</tr>
			</tbody>
		</table>
		If a bidder ID is rejected, either correct it and submit again or
		cancel it.
		</div>
		<h1>New amount</h1>
		<div>
			<input name="" type="button" value="Start over" onClick="window.location.href=window.location.href;"/>
		</div>

	</div>
	
	
	
</body>
</html>