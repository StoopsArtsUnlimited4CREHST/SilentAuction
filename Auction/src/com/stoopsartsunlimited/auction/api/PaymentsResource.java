package com.stoopsartsunlimited.auction.api;

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

import com.stoopsartsunlimited.auction.AuctionDataSource;
import com.stoopsartsunlimited.auction.Lot;
import com.stoopsartsunlimited.auction.Payment;
import com.stoopsartsunlimited.auction.Payments;
import com.stoopsartsunlimited.auction.Lot.BiddingStatus;

@Path("/payments")
public class PaymentsResource {
	
	// post new payment
	@POST
	@Consumes(MediaType.APPLICATION_XML)
	public Response createPayment(@Context UriInfo uriInfo, Payment payment) {
		try {
			AuctionDataSource db = new AuctionDataSource();
			
			// check the lots
			double total = 0;
			for (Lot lot : payment.getForLots().getList()) {
				Lot dbLot = db.getLot(lot.getId());
				if (dbLot == null) {
					return Response.status(Status.BAD_REQUEST).entity("Lot " + lot.getId() + " does not exist in the database.").build();
				}
				if (dbLot.getStatus() != BiddingStatus.BIDDING_CLOSED) {
					return Response.status(Status.BAD_REQUEST).entity("Lot " + lot.getId() + " is not payable.").build();
				}
				total += dbLot.getFinalValue();
			}
			// check whether total amount is correct
			if (total != payment.getAmount()) {
				return Response.status(Status.BAD_REQUEST).entity("Amount of payment does not match the total of the lots.").build();
			}
			
			// checks passed, execute payment
			db.put(payment);
			for (Lot lot : payment.getForLots().getList()) {
				Lot dbLot = db.getLot(lot.getId());
				dbLot.setStatus(BiddingStatus.CLOSED_PAID);
				db.put(dbLot);
			}
			
			UriBuilder builder = uriInfo.getAbsolutePathBuilder();
			builder.path(new Integer(payment.getId()).toString());
			return Response.created(builder.build()).build();
		} catch (Exception e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	
	// get all payments
	@GET
	@Produces(MediaType.APPLICATION_XML)
	public Payments readAllPayments() throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		return new Payments(db.getAllPayments());
	}

	// get payment by id
	@GET
	@Path("{id:\\d+}")
	@Produces(MediaType.APPLICATION_XML)
	public Payment readPayment(@PathParam("id") int id) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		Payment p = db.getPayment(id);
		/*p.setLink(new ArrayList<Link>());
		p.getLink().add(new Link("payment-for", null, "132465", null));
		LinkedList<Lot> lots = new LinkedList<Lot>();
		lots.add(new Lot(100));
		lots.add(new Lot(101));
		lots.add(new Lot(102));
		p.setForLots(new Lots(lots));*/
		return p;
	}

	// put payment by id
	@PUT
	@Path("{id:\\d+}")
	@Consumes(MediaType.APPLICATION_XML)
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
