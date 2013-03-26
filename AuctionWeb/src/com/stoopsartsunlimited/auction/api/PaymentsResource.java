package com.stoopsartsunlimited.auction.api;

import java.io.InputStream;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.core.UriBuilder;
import javax.ws.rs.core.UriInfo;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import com.stoopsartsunlimited.auction.AuctionDataSource;
import com.stoopsartsunlimited.auction.Payment;
import com.stoopsartsunlimited.auction.Payments;

@Path("/payments")
public class PaymentsResource {
	
	// post new payment
	@POST
	@Consumes("application/xml")
	public Response createPayment(@Context UriInfo uriInfo, InputStream is) {
		try {
			JAXBContext context = JAXBContext.newInstance(Payment.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			Payment o = (Payment) unmarshaller.unmarshal(is);
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
	
	// get all payments
	@GET
	@Produces("application/xml")
	public Payments readAllPayments() throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		return new Payments(db.getAllPayments());
	}
		
	// get payment by id
	@GET
	@Path("{id:\\d+}")
	@Produces("application/xml")
	public Payment readPayment(@PathParam("id") int id, InputStream is) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		return db.getPayment(id);
	}

	// put payment by id
	@PUT
	@Path("{id:\\d+}")
	@Consumes("application/xml")
	public Response updatePayment(@PathParam("id") int id, Payment payment) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		Payment base = db.getPayment(id);
		if (base == null) {
			throw new WebApplicationException(Status.NOT_FOUND);
		}
		// update base with changes
		base.setAccount(payment.getAccount());
		base.setAmount(payment.getAmount());
		base.setComments(payment.getComments());
		base.setInstrument(payment.getInstrument());
		db.put(base);
		return Response.noContent().build();
	}
}
