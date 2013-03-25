/*
 * Lot
 */

function Lot() {
	return Lot(NaN, null, null, "NONE", NaN, NaN, NaN, NaN, null, null);
}
function Lot(id, title, description, status, declaredValue, finalValue, winner, contributor, created, modified) {
	this.id = id;
	this.title = title;
	this.description = description;
	this.status = status;
	this.declaredValue = declaredValue;
	this.finalValue = finalValue;
	this.winner = winner;
	this.contributor = contributor;
	this.created = created;
	this.modified = modified;
	
	this.getXml = function() {
		var r = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + 
				'<lot>' + 
					(this.contributor != undefined ? ('<contributor>' + this.contributor + '</contributor>') : '') + 
					(this.created != undefined ? ('<created>' + this.created + '</created>') : '') + 
					(this.declaredValue != undefined ? ('<declaredValue>' + this.declaredValue + '</declaredValue>') : '') + 
					(this.description != undefined ?	('<description>' + this.description + '</description>') : '') + 
					(this.finalValue != undefined ? ('<finalValue>' + this.finalValue + '</finalValue>') : '') + 
					(this.id != undefined ? ('<id>' + this.id + '</id>') : '') + 
					(this.modified != undefined ? ('<modified>' + this.modified + '</modified>') : '') + 
					(this.status != undefined ? ('<status>' + this.status + '</status>') : '') + 
					(this.title != undefined ? ('<title>' + this.title + '</title>') : '') + 
					(this.winner != undefined ? ('<winner>' + this.winner + '</winner>') : '') + 
				'</lot>';
		return r;
	};
	this.getTableRow = function() {
		var r = $('<tr><td><a href="' + '#' + '">edit</a>' +
				'</td><td><a href="' + '#' + '">delete</a>' +
				'</td><td>' + this.id + 
				'</td><td>' + this.title +
				'</td><td>' + this.description + 
				'</td><td>' + this.contributor + 
				'</td><td>' + this.declaredValue + 
				'</td><td>' + this.winner + 
				'</td><td>' + this.finalValue +
				'</td><td>' + this.status + 
				'</td><td>' + this.created.toDateString() + ' ' + this.created.toLocaleTimeString() +
				'</td><td>' + this.modified.toDateString() + ' ' + this.modified.toLocaleTimeString() +
				'</td></tr>');
		return r;
	};
	this.appendToTable = function(selector) {
		$(selector).append(this.getTableRow());
	};
}
function getLotFromInputs(rootElement) {
	var r = new Lot(
			$("input.lot_id", rootElement).val(), 
			$("input.lot_title", rootElement).val(), 
			$("input.lot_description", rootElement).val(), 
			$("input.lot_status", rootElement).val(), 
			$("input.lot_declaredValue", rootElement).val(), 
			$("input.lot_finalValue", rootElement).val(), 
			$("input.lot_winner", rootElement).val(), 
			$("input.lot_contributor", rootElement).val(), 
			$("input.lot_created", rootElement).val(), 
			$("input.lot_modified", rootElement).val());
	return r;
	
}
function getLotFromXml(xml) {
	var xmlDoc = $.parseXML(xml);
	return getLotFromDom($(xmlDoc));
}
function getLotFromDom(dom) {
	var $dom = $(dom);

	var r = new Lot(
			$dom.find("id").text(),
			$dom.find("title").text(), 
			$dom.find("description").text(), 
			$dom.find("status").text(), 
			$dom.find("declaredValue").text(), 
			$dom.find("finalValue").text(), 
			$dom.find("winner").text(), 
			$dom.find("contributor").text(), 
			new Date(Date.parse($dom.find("created").text())), 
			new Date(Date.parse($dom.find("modified").text())));
	return r;
}
/*
 * Fetches a Lots object from the given URL and calls the given callback function. 
 */
function getLots(url, callback) {
}

function getLotArrayFromXml(xml) {
	var xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><lots><lot><contributor>101</contributor><created>2013-02-18T00:45:42-08:00</created><declaredValue>0.05</declaredValue><description>A fairly wet, plush hedgehog. Smells funny. Funny bad. Used to squeak.</description><finalValue>0.0</finalValue><id>119</id><modified>2013-02-20T22:49:14-08:00</modified><status>NONE</status><title>Chewed Plush Hedgehog</title><winner>0</winner></lot><lot><contributor>102</contributor><created>2013-02-18T00:45:42-08:00</created><declaredValue>0.99</declaredValue><description>Block of Cheese</description><finalValue>0.0</finalValue><id>120</id><modified>2013-02-18T00:45:42-08:00</modified><status>NONE</status><title>Block of Cheese</title><winner>0</winner></lot><lot><contributor>103</contributor><created>2013-02-18T00:45:42-08:00</created><declaredValue>5.0</declaredValue><description>Whole Roaster Chicken</description><finalValue>0.0</finalValue><id>121</id><modified>2013-02-18T00:45:42-08:00</modified><status>NONE</status><title>Chicken Breasts</title><winner>0</winner></lot></lots>';
	var xmlDoc = $.parseXML(xml);
	var $xml = $(xmlDoc);
	var r = $xml.find('lots lot');
	r = r.map(function (i,e) {
		return getLotFromDom(e);
		});
	return r;
	// for each element in lot-list lots
		// deserialize into an object
	// return the array of lots 
}