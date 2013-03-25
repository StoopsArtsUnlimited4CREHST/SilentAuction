/*
 * Account
 */

function Account() {
	return Account(NaN, null, null, null, null, null, null, false, null, null);
}
function Account(id, name, address, phone, email, taxId, bidderId, active, created, modified) {
	this.id = id;
	this.name = name;
	this.address = address;
	this.phone = phone;
	this.email = email;
	this.taxId = taxId;
	this.bidderId = bidderId;
	this.active = active;
	this.created = created;
	this.modified = modified;
	
	this.getXml = function() {
		var r = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + 
				'<account>' + 
					(this.id != undefined ? ('<id>' + this.id + '</id>') : '') + 
					(this.name != undefined ? ('<name>' + this.name + '</name>') : '') + 
					(this.address != undefined ? ('<address>' + this.address + '</address>') : '') + 
					(this.phone != undefined ?	('<phone>' + this.phone + '</phone>') : '') + 
					(this.email != undefined ? ('<email>' + this.email + '</email>') : '') + 
					(this.taxId != undefined ? ('<taxId>' + this.taxId + '</taxId>') : '') + 
					(this.bidderId != undefined ? ('<bidderId>' + this.bidderId + '</bidderId>') : '') + 
					(this.active != undefined ? ('<active>' + this.active + '</active>') : '') + 
					(this.created != undefined ? ('<created>' + this.created + '</created>') : '') + 
					(this.modified != undefined ? ('<modified>' + this.modified + '</modified>') : '') + 
				'</account>';
		return r;
	};
	this.getTableRow = function() {
		var r = $('<tr class="account">' +
				'<td class="select"><input type="radio" name="account" value="' + this.id.toString() + '" /></td>' +
				'<td class="id">' + this.id + 
				'</td><td class="name">' + this.name +
				'</td><td class="address">' + this.address + 
				'</td><td class="phone">' + this.phone + 
				'</td><td class="email">' + this.email + 
				'</td><td class="taxId">' + this.taxId + 
				'</td><td class="bidderId">' + this.bidderId +
				'</td><td class="active">' + this.active + 
				'</td><td class="created">' + this.created.toDateString() + ' ' + this.created.toLocaleTimeString() +
				'</td><td class="modified">' + this.modified.toDateString() + ' ' + this.modified.toLocaleTimeString() +
				'</td></tr>');
		return r;
	};
	this.appendToTable = function(selector) {
		$(selector).append(this.getTableRow());
	};
}
function getAccountFromInputs(rootElement) {
	var r = new Account(
			$("input.account_id", rootElement).val(), 
			$("input.account_name", rootElement).val(), 
			$("input.account_address", rootElement).val(), 
			$("input.account_phone", rootElement).val(), 
			$("input.account_email", rootElement).val(), 
			$("input.account_taxId", rootElement).val(), 
			$("input.account_bidderId", rootElement).val(), 
			$("input.account_active", rootElement).val(), 
			$("input.account_created", rootElement).val(), 
			$("input.account_modified", rootElement).val());
	return r;
	
}
function getAccountFromXml(xml) {
	var xmlDoc = $.parseXML(xml);
	return getAccountFromDom($(xmlDoc));
}
function getAccountFromDom(dom) {
	var $dom = $(dom);

	var r = new Account(
			parseInt($dom.find("id").text()),
			$dom.find("name").text(), 
			$dom.find("address").text(), 
			$dom.find("phone").text(), 
			$dom.find("email").text(), 
			$dom.find("taxId").text(), 
			$dom.find("bidderId").text(), 
			new Boolean($dom.find("active").text()), 
			new Date(Date.parse($dom.find("created").text())), 
			new Date(Date.parse($dom.find("modified").text())));
	return r;
}
/*
 * Fetches a Accounts object from the given URL and calls the given callback function. 
 */
function getAccounts(url, callback) {
}

function getAccountArrayFromXml(xml) {
	var xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
		'<accounts>' + 
		'<account><active>true</active><address>101 Dog Ln\nPasco, WA 99301</address><created>2013-02-17T19:00:29-08:00</created><email>buddy@michaelstoops.com</email><id>63</id><modified>2013-02-17T19:00:29-08:00</modified><name>Buddy Turbo Stoops</name><phone>555.123.4567</phone></account>' + 
		'<account><active>true</active><address>101 Rat Ln\nPasco, WA 99301</address><created>2013-02-17T19:00:29-08:00</created><email>ratsterlordofcheese@michaelstoops.com</email><id>64</id><modified>2013-02-17T19:00:29-08:00</modified><name>Ratster Stoops</name><phone>555.223.4567</phone></account>' + 
		'<account><active>true</active><address>101 Bird Ln\nPasco, WA 99301</address><created>2013-02-17T19:00:29-08:00</created><email>birdbrain@michaelstoops.com</email><id>65</id><modified>2013-02-17T19:00:29-08:00</modified><name>Birdbrain Stoops</name><phone>800.CHX.STIX</phone><taxId>555-00-1234</taxId></account>' + 
		'<account><active>true</active><address>101 Dog Ln\nPasco, WA 99301</address><created>2013-02-18T00:34:48-08:00</created><email>buddy@michaelstoops.com</email><id>66</id><modified>2013-02-18T00:34:49-08:00</modified><name>Buddy Turbo Stoops</name><phone>555.123.4567</phone></account>' + 
		'<account><active>true</active><address>101 Rat Ln\nPasco, WA 99301</address><created>2013-02-18T00:34:49-08:00</created><email>ratsterlordofcheese@michaelstoops.com</email><id>67</id><modified>2013-02-18T00:34:49-08:00</modified><name>Ratster Stoops</name><phone>555.223.4567</phone></account>' + 
		'<account><active>true</active><address>101 Bird Ln\nPasco, WA 99301</address><created>2013-02-18T00:34:49-08:00</created><email>birdbrain@michaelstoops.com</email><id>68</id><modified>2013-02-18T00:34:49-08:00</modified><name>Birdbrain Stoops</name><phone>800.CHX.STIX</phone><taxId>555-00-1234</taxId></account>' + 
		'<account><active>true</active><address>101 Dog Ln\nPasco, WA 99301</address><created>2013-02-18T00:39:58-08:00</created><email>buddy@michaelstoops.com</email><id>69</id><modified>2013-02-18T00:39:58-08:00</modified><name>Buddy Turbo Stoops</name><phone>555.123.4567</phone></account>' + 
		'<account><active>true</active><address>101 Rat Ln\nPasco, WA 99301</address><created>2013-02-18T00:39:59-08:00</created><email>ratsterlordofcheese@michaelstoops.com</email><id>70</id><modified>2013-02-18T00:39:59-08:00</modified><name>Ratster Stoops</name><phone>555.223.4567</phone></account>' + 
		'<account><active>true</active><address>101 Bird Ln\nPasco, WA 99301</address><created>2013-02-18T00:39:59-08:00</created><email>birdbrain@michaelstoops.com</email><id>71</id><modified>2013-02-18T00:39:59-08:00</modified><name>Birdbrain Stoops</name><phone>800.CHX.STIX</phone><taxId>555-00-1234</taxId></account>' + 
		'</accounts>';
	var xmlDoc = $.parseXML(xml);
	var $xml = $(xmlDoc);
	var r = $xml.find('accounts account');
	r = r.map(function (i,e) {
		return getAccountFromDom(e);
		});
	return r;
	// for each element in account-list accounts
		// deserialize into an object
	// return the array of accounts 
}