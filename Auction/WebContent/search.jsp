<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Search</title>
<link href="main.css" rel="stylesheet" type="text/css" />
<link href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<style>
</style>
<script type="text/javascript">
	$(function() {
		$("#accordion").accordion({
			heightStyle : "content"
		});
		$("#search-results").selectable({
			selected : function(event, ui) {
				$.ajax({
					url: $(ui.selected).attr("data-href"), 
					success: loadItem,
					cache: false,
				});
				$(ui.selected).removeClass("ui-selected");
			},
		});
		$("#search").autocomplete({
			source : "/AuctionRestApi/search/autocomplete",
		//minLength: 3
		});
		$(".tabs").tabs();
		$("input[type=submit], a, button").button().click(function(event) {
			event.preventDefault();
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#searchButton").click(doSearch);
	});

	function doSearch(criteria) {
		$.ajax({
			url : "/AuctionRestApi/search?q=" + encodeURIComponent(criteria),
			success : loadSearchResults,
			cache : false,
		});
	};

	function loadSearchResults(data, textStatus, jqXHR) {
		$results = $(data).find("results");
		var $d = $("#search-results");
		$d.children().remove();
		$results.children().each(
				function(index, result) {
					var $r = $(result);
					var $e = null;
					switch ($r.prop("tagName").toLowerCase()) {
					case "account":
						$e = $('<li />').appendTo($d).attr("data-href",
								$r.find('link[rel="self"]').attr("href")).text(
								$r.find("name").text()).prepend(
								$('<img />').addClass("search-result-icon"));
						if ($r.find("active").text() != "false") {
							$e.find(".search-result-icon").attr("src",
									"images/user-active.png");
						} else {
							$e.find(".search-result-icon").attr("src",
									"images/user-inactive.png");
						}
						break;
					case "lot":
						$e = $('<li />').appendTo($d).attr("data-href",
								$r.find('link[rel="self"]').attr("href")).text(
								$r.find("title").text()).prepend(
								$('<img />').addClass("search-result-icon"));
						if ($r.find("status").text() != "PAID") {
							// NONE, BIDDING, CLOSED
							$e.find(".search-result-icon").attr("src",
									"images/lot-active.png");
						} else {
							// PAID
							$e.find(".search-result-icon").attr("src",
									"images/lot-inactive.png");
						}
						break;
					default:
						$d.append('<li>unrecognized result type: '
								+ $r.prop("tagName") + '</li>');
					}

				});
		$d.children().addClass("ui-widget-content");
	}

	function bindText($html, $xmlItem) {
		var $xmlTag = $xmlItem.find($html.attr("data-xml-selector"));
		if ($xmlTag.text() != "") {
			$html.html($xmlTag.text()).removeClass("empty-field");
		} else {
			$html.html($html.attr("data-default")).addClass("empty-field");
		}
	}
	function loadItem(data, textStatus, jqXHR) {
		var $data = $($(data)); // double wrap for deep copy

		// reformat data for our purposes
		if ($data.find("id").text() != "") { $data.find("id").text("Internal ID: " + $data.find("id").text()); }
		// convert CR, LF ,and CRLF to HTML <br> tag
		var $address = $data.find("address");
		$address.text($address.text().replace(/\r\n/g, "<br>").replace(/[\r\n]/g, "<br>")); 
		
		// automatic binding for most fields
		$("#item-details .xml-bound").each(function(index, element) {
			bindText($(element), $data);
		});
		
		// explicit binding
		$("#item-details-header").text("Account: " + $('#item-details [data-xml-selector="name"]').text());
		
		if ($data.find("active").text() != "false") {
			$("#item-details .account-active").text("Active");
			$("#item-details .account-active-icon").attr("src",
					"images/user-active.png");
		} else {
			$("#item-details .account-active").text("Inactive");
			$("#item-details .account-active-icon").attr("src",
					"images/user-inactive.png");
		}

		// switch view
		$("#item-details-account").hide();
		$("#item-details-lot").hide();
		switch ($data.children().prop("tagName")) {
		case "account":
			$("#item-details-account").show();
			break;
		case "lot":
			$("#item-details-lot").show();
			break;
		}
		$("#item-details-header").click();
	}
</script>
</head>

<body>
	<div id="accordion">
		<h2>All accounts and lots</h2>
		<div id="item-selection">
			<input id="search" type="text" /> <input id="searchButton"
				type="button" value="Search" />
			<ol id="search-results">
				<!-- <li class="ui-widget-content" data-href="1.xml">Item 1</li> -->
			</ol>
		</div>
		<h3 id="item-details-header">Account:</h3>
		<div id="item-details" style="padding: 0;">
			<div id="item-details-account" class="tabs" style="padding: 0; margin: 0; border: none;">
				<ul>
					<li><a href="#tabs-general">General</a></li>
					<li><a href="#tabs-lots-donated">Lots donated</a></li>
					<li><a href="#tabs-lots-won">Lots won</a></li>
					<li><a href="#tabs-payments">Payments</a></li>
				</ul>
				<div id="tabs-general" style="min-height: 150px;">
					<div class="account-active-container" align="center"
						style="float: right; border: thin solid gray; border-radius: 1em;">
						<img class="account-active-icon" src="images/user-active.png"><br>
						<span class="account-active">Active</span>
					</div>
					<table>
						<tr>
							<td style="vertical-align: top; padding-right: 4em;">
								<p class="account-name xml-bound" data-xml-selector="name" data-default="[no name]">[name]</p>
								<p class="account-email xml-bound" data-xml-selector="email" data-default="[no email]">[email]</p>
								<p class="account-phone xml-bound" data-xml-selector="phone" data-default="[no phone]">[phone]</p>
								<address class="account-address xml-bound" data-xml-selector="address" data-default="[no address]">[address]</address>
							</td>
							<td style="vertical-align: top; padding-right: 4em;">
								<p class="account-id xml-bound" data-xml-selector="id" data-default="[no internal ID]">[internal ID]</p>
								<p class="account-tax-id xml-bound" data-xml-selector="taxId" data-default="[no tax ID]">[tax ID]</p>
								<p class="account-bidder-id xml-bound" data-xml-selector="bidderId" data-default="[no bidder ID]">[bidder ID]</p>
							</td>
							<td style="vertical-align: top; padding-right: 4em;">
								<p class="account-created xml-bound" data-xml-selector="created" data-default="[no created timestamp]">[created timestamp]</p>
								<p class="account-modified xml-bound" data-xml-selector="modified" data-default="[no modified timestamp]">[modified timestamp]</p>
							</td>
						</tr>
					</table>
				</div>
				<div id="tabs-lots-donated">
					<p>tabs-lots-donated</p>
				</div>
				<div id="tabs-lots-won">
					<p>tabs-lots-won</p>
				</div>
				<div id="tabs-payments">
					<p>tabs-payments</p>
				</div>
			</div>
			<div id="item-details-lot" class="tabs" style="padding: 0; margin: 0; border: none;">
				<ul>
					<li><a href="#tabs-general">General</a></li>
				</ul>
				<div id="tabs-general" style="min-height: 150px;">
					<div class="lot-active-container" align="center"
						style="float: right; border: thin solid gray; border-radius: 1em;">
						<img class="lot-active-icon" src="images/lot-active.png" height="128px" width="128px"><br>
						<span class="lot-active">Active</span>
					</div>
					<table border="0">
					  <tr>
					    <td rowspan="3" style="vertical-align: top; padding-right: 4em;"><h1 class="lot-title xml-bound" data-xml-selector="title" data-default="[no title]">[title]</h1>
				        <p class="lot-description xml-bound" data-xml-selector="description" data-default="[no description]">[description]</p></td>
					    <td><p class="lot-status xml-bound" data-xml-selector="status" data-default="[no status]">[status]</p></td>
					    <td style="padding-right: 4em;">&nbsp;</td>
					    <td ><p class="lot-id xml-bound" data-xml-selector="id" data-default="[no internal ID]">[ID]</p></td>
				      </tr>
					  <tr>
					    <td><p class="lot-contributor xml-bound" data-xml-selector="contributor" data-default="[no contributor]">[contributor]</p></td>
					    <td style="padding-right: 4em;"><p class="lot-declared-value xml-bound" data-xml-selector="declaredValue" data-default="[no declared value]">[declared value]</p></td>
					    <td><p class="lot-created xml-bound" data-xml-selector="created" data-default="[no created timestamp]">[created]</p></td>
				      </tr>
					  <tr>
					    <td><p class="lot-winner xml-bound" data-xml-selector="winner" data-default="[no winner]">[winner]</p></td>
					    <td style="padding-right: 4em;"><p class="lot-final-value xml-bound" data-xml-selector="finalValue" data-default="[no final value]">[winning bid]</p></td>
					    <td><p class="lot-modified xml-bound" data-xml-selector="modified" data-default="[no modified timestamp]">[modified]</p></td>
				      </tr>
				  </table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>