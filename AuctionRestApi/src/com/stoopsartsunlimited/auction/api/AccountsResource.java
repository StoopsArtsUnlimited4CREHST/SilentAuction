package com.stoopsartsunlimited.auction.api;

import java.io.InputStream;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.core.UriBuilder;
import javax.ws.rs.core.UriInfo;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;

import com.stoopsartsunlimited.auction.Account;
import com.stoopsartsunlimited.auction.Accounts;
import com.stoopsartsunlimited.auction.AuctionDataSource;
import com.stoopsartsunlimited.auction.Lot.BiddingStatus;

@Path("/accounts")
public class AccountsResource {
	// post new account
	@POST
	@Consumes(MediaType.APPLICATION_XML)
	public Response createAccount(@Context UriInfo uriInfo, InputStream is) {
		try {
			JAXBContext context = JAXBContext.newInstance(Account.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			Account o = (Account) unmarshaller.unmarshal(is);
			AuctionDataSource db = new AuctionDataSource();
			db.put(o);
			UriBuilder builder = uriInfo.getAbsolutePathBuilder();
			builder.path(new Integer(o.getId()).toString());
			return Response.created(builder.build()).build();
		} catch (Exception e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	// post new account from an HTML form
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public Response createAccount(@Context UriInfo uriInfo, String entity) {
		try {
			Account o = new Account();
			o.setActive(false);
			
			List<NameValuePair> nvps = URLEncodedUtils.parse(entity, Charset.forName("US-ASCII"));
			for (NameValuePair nvp : nvps) {
				switch (nvp.getName()) {
				case "active":
					o.setActive(nvp.getValue().equals("active"));
					break;
				case "address":
					o.setAddress(nvp.getValue());
					break;
				case "bidderId":
					o.setBidderId(nvp.getValue());
					break;
				case "email":
					o.setEmail(nvp.getValue());
					break;
				case "name":
					o.setName(nvp.getValue());
					break;
				case "phone":
					o.setPhone(nvp.getValue());
					break;
				case "taxId":
					o.setTaxId(nvp.getValue());
					break;

				default:
					throw new WebApplicationException(Status.BAD_REQUEST);
				}
			}
			
			AuctionDataSource db = new AuctionDataSource();
			db.put(o);
			UriBuilder builder = uriInfo.getAbsolutePathBuilder();
			builder.path(new Integer(o.getId()).toString());
			return Response.created(builder.build()).build();
		} catch (Exception e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	
	// get all accounts
	@GET
	@Produces(MediaType.APPLICATION_XML)
	public Accounts readAllAccounts() throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		return new Accounts(db.getAllAccounts());
	}
		
	
	// get account by id
	@GET
	@Path("{id:\\d+}")
	@Produces(MediaType.APPLICATION_XML)
	public Account readAccount(@PathParam("id") int id, InputStream is) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		return db.getAccount(id);
	}

	// put Account by id
	@PUT
	@Path("{id:\\d+}")
	@Consumes(MediaType.APPLICATION_XML)
	public Response updateAccount(@PathParam("id") int id, Account account) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		Account base = db.getAccount(id);
		if (base == null) {
			throw new WebApplicationException(Status.NOT_FOUND);
		}
		// update base with changes
		base.setAddress(account.getAddress());
		base.setBidderId(account.getBidderId());
		base.setEmail(account.getEmail());
		base.setName(account.getName());
		base.setPhone(account.getPhone());
		base.setTaxId(account.getTaxId());
		db.put(base);
		return Response.noContent().build();
	}
	// put Account by id from an html form
	@PUT
	@Path("{id:\\d+}")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public Response updateAccount(@PathParam("id") int id, String entity) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		Account base = db.getAccount(id);
		if (base == null) {
			throw new WebApplicationException(Status.NOT_FOUND);
		}
		// update base with changes
		base.setActive(false); // active must default to false
		List<NameValuePair> nvps = URLEncodedUtils.parse(entity, Charset.forName("US-ASCII"));
		for (NameValuePair nvp : nvps) {
			switch (nvp.getName()) {
			case "active":
				base.setActive(nvp.getValue().equals("active"));
				break;
			case "address":
				base.setAddress(nvp.getValue());
				break;
			case "bidderId":
				base.setBidderId(nvp.getValue());
				break;
			case "email":
				base.setEmail(nvp.getValue());
				break;
			case "name":
				base.setName(nvp.getValue());
				break;
			case "phone":
				base.setPhone(nvp.getValue());
				break;
			case "taxId":
				base.setTaxId(nvp.getValue());
				break;

			default:
				throw new WebApplicationException(Status.BAD_REQUEST);
			}
		}
		db.put(base);
		return Response.noContent().build();
	}

	// get account statement by id
	@GET
	@Path("{id:\\d+}/statement")
	@Produces("text/html")
	public String readAccountStatement(@PathParam("id") int id, InputStream is) throws Exception {
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
	}

	// get account statement by id
	@GET
	@Path("{id:\\d+}/paddle")
	@Produces("text/html")
	public String readAccountPaddle(@PathParam("id") int id, InputStream is) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		Account account = db.getAccount(id);
		if (account == null) {
			throw new WebApplicationException(Status.NOT_FOUND);
		}
		// TODO: Paddle form shouldn't be hardcoded.
		String base = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n<title>Untitled Document</title>\n<style>\nbody {\n\tfont-size: 8pt;\n}\n\n#account-bidder-id {\n\tfont-size:144pt;\n\tfont-weight: bolder;\n}\n\n#account-id {\n\tfont-size:18pt;\n}\n\n#account-name {\n\tfont-size:18pt;\n}\n\n</style>\n</head>\n\n<body>\n<p>\n\tBidder ID:<br />\n    <span id=\"account-bidder-id\">{account-bidder-id}</span>\n    </p>\n<p>\n\tAccount ID:<br />\n    <span id=\"account-id\">{account-id}</span>\n</p>\n<p>\n\tName:<br />\n    <span id=\"account-name\">{account-name}</span>\n</p>\n<script language=\"javascript\">\nfunction getParameterByName(name) {\n    var match = RegExp(\'[?&]\' + name + \'=([^&]*)\').exec(window.location.search);\n    return match && decodeURIComponent(match[1].replace(/\\+/g, \' \'));\n}\n\nvar p = getParameterByName(\"print\");\nif (p != null\n\t\t&& p != 0\n\t\t&& p != \"false\") {\n\twindow.print();\n}\n\n</script>\n</body>\n</html>\n";
		return base.replaceAll("\\{account-name\\}", account.getName() != null ? account.getName() : "null")
				.replaceAll("\\{account-bidder-id\\}", account.getBidderId() != null ? account.getBidderId() : "null")
				.replaceAll("\\{account-id\\}", Integer.toString(account.getId()));
	}
}
