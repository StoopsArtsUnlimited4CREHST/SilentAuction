package com.stoopsartsunlimited.auction.api;

import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
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

import com.stoopsartsunlimited.auction.AuctionDataSource;
import com.stoopsartsunlimited.auction.Lot;
import com.stoopsartsunlimited.auction.Lot.BiddingStatus;
import com.stoopsartsunlimited.auction.Lots;

@Path("/lots")
public class LotsResource {
	// post new lot
	@POST
	@Consumes(MediaType.APPLICATION_XML)
	public Response createLot(@Context UriInfo uriInfo, InputStream is) {
		try {
			JAXBContext context = JAXBContext.newInstance(Lot.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			Lot o = (Lot) unmarshaller.unmarshal(is);
			AuctionDataSource db = new AuctionDataSource();
			db.put(o);
			UriBuilder builder = uriInfo.getAbsolutePathBuilder();
			builder.path(new Integer(o.getId()).toString());
			return Response.created(builder.build()).build();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	// post new lot from an HTML form
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public Response createLot(@Context UriInfo uriInfo, String entity) {
		try {
			Lot o = new Lot();

			List<NameValuePair> nvps = URLEncodedUtils.parse(entity, Charset.forName("US-ASCII"));
			for (NameValuePair nvp : nvps) {
				switch (nvp.getName()) {
				case "title":
					o.setTitle(nvp.getValue());
					break;
				case "description":
					o.setDescription(nvp.getValue());
					break;
				case "status":
					o.setStatus(BiddingStatus.valueOf(nvp.getValue()));
					break;
				case "declaredValue":
					o.setDeclaredValue(Double.valueOf(nvp.getValue()));
					break;
				case "finalValue":
					o.setFinalValue(Double.valueOf(nvp.getValue()));
					break;
				case "winner":
					o.setWinner(Integer.valueOf(nvp.getValue()));
					break;
				case "contributor":
					o.setContributor(Integer.valueOf(nvp.getValue()));
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
			// TODO Auto-generated catch block
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	
	// get all lots
	@GET
	@Produces(MediaType.APPLICATION_XML)
	public Lots readAllLots(
			@QueryParam("contributor") Integer contributor,
			@QueryParam("winner") Integer winner
			) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		if (contributor != null) {
			return new Lots(db.getLotsByContributor(contributor));
		} else if (winner != null) {
			return new Lots(db.getLotsByWinner(winner));
		} else {
			return new Lots(db.getAllLots());
		}
	}
		
	
	// get lot by id
	@GET
	@Path("{id:\\d+}")
	@Produces(MediaType.APPLICATION_XML)
	public Lot readLot(@PathParam("id") int id, InputStream is) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		return db.getLot(id);
	}

	// put Account by id
	@PUT
	@Path("{id:\\d+}")
	@Consumes(MediaType.APPLICATION_XML)
	public Response updateAccount(@PathParam("id") int id, Lot lot) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		Lot base = db.getLot(id);
		if (base == null) {
			throw new WebApplicationException(Status.NOT_FOUND);
		}
		// update base with changes
		base.setContributor(lot.getContributor());
		base.setDeclaredValue(lot.getDeclaredValue());
		base.setDescription(lot.getDescription());
		base.setFinalValue(lot.getFinalValue());
		base.setStatus(lot.getStatus());
		base.setTitle(lot.getTitle());
		base.setWinner(lot.getWinner());
		db.put(base);
		return Response.noContent().build();
	}
	// put Account by id from an HTML form
	@PUT
	@Path("{id:\\d+}")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public Response updateAccount(@PathParam("id") int id, String entity) throws Exception {
		AuctionDataSource db = new AuctionDataSource();
		Lot base = db.getLot(id);
		if (base == null) {
			throw new WebApplicationException(Status.NOT_FOUND);
		}

		// update base with changes
		List<NameValuePair> nvps = URLEncodedUtils.parse(entity, Charset.forName("US-ASCII"));
		for (NameValuePair nvp : nvps) {
			switch (nvp.getName()) {
			case "title":
				base.setTitle(nvp.getValue());
				break;
			case "description":
				base.setDescription(nvp.getValue());
				break;
			case "status":
				base.setStatus(BiddingStatus.valueOf(nvp.getValue()));
				break;
			case "declaredValue":
				base.setDeclaredValue(Double.valueOf(nvp.getValue()));
				break;
			case "finalValue":
				base.setFinalValue(Double.valueOf(nvp.getValue()));
				break;
			case "winner":
				base.setWinner(Integer.valueOf(nvp.getValue()));
				break;
			case "contributor":
				base.setContributor(Integer.valueOf(nvp.getValue()));
				break;

			default:
				throw new WebApplicationException(Status.BAD_REQUEST);
			}
		}
		db.put(base);
		return Response.noContent().build();
	}

}
