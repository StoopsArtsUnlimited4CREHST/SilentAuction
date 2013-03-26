package com.stoopsartsunlimited.auction.api;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import com.stoopsartsunlimited.atom.Link;

@Path("/search")
public class SearchResource {
	// get search results
	@GET
	@Produces("application/xml")
	public SearchResults getSearchResults() throws Exception {
		SearchResults results = new SearchResults();
		
		SearchResult result = new SearchResult();
		result.setType("account");
		result.setActive(true);
		result.setDescription("Result number one");
		result.setLink(new Link("self", null, "http://success", null));
		results.getList().add(result);

		return results;
		
		/*
		DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
		Document doc = docBuilder.newDocument();
		Node results = doc.appendChild(doc.createElement("results"));
		
		Node result = results.appendChild(doc.createElement("account"));
		Element link = doc.createElement("link");
		Element active = doc.createElement("active");
		Element name = doc.createElement("name");
		result.appendChild(link);
		result.appendChild(active);
		result.appendChild(name);
		
		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");

		StreamResult streamResult = new StreamResult(new StringWriter());
		DOMSource source = new DOMSource(doc);
		transformer.transform(source, streamResult);

		String r = streamResult.getWriter().toString();
		System.out.println(r);
		return r;
		*/
		
		//return "<results>\n\t<account>\n\t\t<link rel=\"self\" href=\"http://localhost:8080/AuctionRestApi/accounts/63\"/>\n\t\t<active>true</active>\n\t\t<name>Buddy Turbo Stoops</name>\n\t</account>\n\t<account>\n\t\t<link rel=\"self\" href=\"http://localhost:8080/AuctionRestApi/accounts/64\"/>\n\t\t<active>true</active>\n\t\t<name>Ratster Stoops</name>\n\t</account>\n\t<account>\n\t\t<link rel=\"self\" href=\"http://localhost:8080/AuctionRestApi/accounts/65\"/>\n\t\t<active>false</active>\n\t\t<name>Birdbrain Stoops</name>\n\t</account>\n\t<lot>\n\t\t<link rel=\"self\" href=\"http://localhost:8080/AuctionRestApi/lots/119\"/>\n\t\t<status>NONE</status>\n\t\t<title>Chewed Plush Hedgehog</title>\n\t</lot>\n\t<lot>\n\t\t<link rel=\"self\" href=\"http://localhost:8080/AuctionRestApi/lots/120\"/>\n\t\t<status>PAID</status>\n\t\t<title>Block of Cheese</title>\n\t</lot>\n\t<lot>\n\t\t<link rel=\"self\" href=\"http://localhost:8080/AuctionRestApi/lots/121\"/>\n\t\t<status>NONE</status>\n\t\t<title>Chicken Breasts</title>\n\t</lot>\n</results>";
		//AuctionDataSource db = new AuctionDataSource();
	}
	
	// get autocomplete options for a certain search term
	@GET
	@Path("autocomplete")
	@Produces("application/json")
	public String getAutocompleteResults(@QueryParam("term") String term) throws Exception {
		return "[{\"label\":\"Michael\"},{\"label\":\"Stoops\"},{\"label\":\"Ratster\"},{\"label\":\"Buddy\"}]";
		/*
		AuctionDataSource db = new AuctionDataSource();
		Account account = db.getAccount(id);
		if (account == null) {
			throw new WebApplicationException(Status.NOT_FOUND);
		}
		// TODO: Donor Acknowledgment form shouldn't be hardcoded.
		String base = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n<title>Donor Acknowledgement</title>\n<style>\nbody {\n\tfont-family:\"Times New Roman\", Times, serif;\n\tfont-size:12pt;\n\tmargin: 96pt 40pt 40pt 40pt;\n\tline-height: 115%;\n}\n \nh1 {\n\ttext-align:center;\n\ttext-decoration:underline;\n\tfont-weight:bold;\n\tfont-family:Arial, Helvetica, sans-serif;\n\tfont-size:14pt;\n\tmargin-top:28pt;\n\tmargin-bottom: 28pt;\n}\n\ntable.donation-list {\n\tborder:none;\n\twidth:100%;\n}\n\ntd.item {\n\twidth:50%;\n\tpadding-left:36pt;\n}\n\n</style>\n</head>\n\n<body>\n<p><span name=\"current-date\">{current-date}</span></p>\n<p><br /><span name=\"account-name\">{account-name}</span><br />\n  <span name=\"account-address\">{account-address}</span></p>\n<h1>Donor Acknowledgement</h1>\n<p>Dear  <span name=\"account-name\">{account-name}</span>,</p>\n<p>On  behalf of the Board of Directors, the Staff and dedicated Volunteers, the CREHST Museum  would like to thank you for your support during the 2013 CREHST Museum Spring  Swing annual fundraiser.\u00a0 Thanks to your  generosity and that of many others we are able to continue to carry out the  mission of the museum.\u00a0 </p>\n<p>The  CREHST Museum would like to acknowledge the  following contribution(s) totaling <strong><span name=\"donation-total\">{donation-total}</span></strong> :</p>\n<table class=\"donation-list\">\n<tr><td class=\"item\">Raise Your Program</td><td class=\"amount\"><span name=\"raise-your-program-subtotal\">{raise-your-program-subtotal}</span></td></tr>\n<tr><td class=\"item\">Silent Auction</td><td class=\"amount\"><span name=\"silent-auction-subtotal\">{silent-auction-subtotal}</span></td></tr>\n<tr><td class=\"item\">Other Item</td><td class=\"amount\"><span name=\"other-donation-subtotal\">{other-donation-subtotal}</span></td></tr>\n</table>\n<p>\n<br />\n  The  museum operates under Environmental Science &amp; Technology Foundation, a  nonprofit organization operating under the Internal Revenue Code as a 501(c)(3)  tax exempt organization, ID# 91-1587106.\u00a0  Donations made to the CREHST   Museum are deductible as  allowed by law.\u00a0\u00a0 No funds will be placed  in a donor advised fund nor given to a supporting organization, and no benefits  were received by the donor as a result of the above contribution(s).</p>\n<p><br />Sincerely,</p>\n<p>&nbsp;</p>\n<p>Paul  Schuler, Business Manager<br />\n  CREHST Museum </p>\n<script language=\"javascript\">\nfunction getParameterByName(name) {\n    var match = RegExp(\'[?&]\' + name + \'=([^&]*)\').exec(window.location.search);\n    return match && decodeURIComponent(match[1].replace(/\\+/g, \' \'));\n}\n\nvar p = getParameterByName(\"print\");\nif (p != null\n\t\t&& p != 0\n\t\t&& p != \"false\") {\n\twindow.print();\n}\n\n</script>\n</body>\n</html>\n";
		DateFormat df = new SimpleDateFormat("MMMM dd, yyyy");
		return base.replaceAll("\\{current-date\\}", df.format(new Date()))
				.replaceAll("\\{account-name\\}", account.getName() != null ? account.getName() : "null")
				.replaceAll("\\{account-address\\}", (account.getAddress() != null ? account.getAddress() : "null").replaceAll("\r\n", "<br />").replaceAll("[\r\n]", "<br />"))
				.replaceAll("\\{donation-total\\}", "[donation-total]")
				.replaceAll("\\{raise-your-program-subtotal\\}", "[raise-your-program-subtotal]")
				.replaceAll("\\{silent-auction-subtotal\\}", "[silent-auction-subtotal]")
				.replaceAll("\\{other-donation-subtotal\\}", "[other-donation-subtotal]");
		*/
	}
}
