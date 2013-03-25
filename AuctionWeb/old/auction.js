function showSuccess(message) {
	showMessage("success", message);
}
function showFailure(message) {
	showMessage("failure", message);
}
function showInfo(message) {
	showMessage("info", message);
}
function showMessage(cssClass, message) {
	var host = $("#messageHost");
	host.prepend($("<div />").addClass(cssClass).text(message));
}


function toStringOrBlank(o) {
	if (o == undefined
			|| o == null
			|| o == NaN) {
		return "";
	} else {
		return o.toString();
	}
}

function shorten(o, maxChars) {
	var r = o.toString();
	if (r.length > maxChars)
	r = r.substr(0, maxChars - 3) + "...";
	return r;
}


function getLots_click() {
	var lots = getLotArrayFromXml(null);
	for (var i = 0; i < lots.length; i++) {
    	lots[i].appendToTable('#lots_table');
    }
}


