package com.stoopsartsunlimited.auction;

import java.sql.SQLException;
import java.util.Date;

import org.junit.Test;

public class AuctionDataSourceTest {

	@SuppressWarnings("unused")
	@Test
	public void testAuctionDataSource() throws SQLException {
		AuctionDataSource o = new AuctionDataSource();
	}

	@Test
	public void testPutAndGetAccount() throws SQLException {
		AuctionDataSource o = new AuctionDataSource();
		Account a1 = new Account(0, "Buddy Stoops", "101 Dog Ln\nPasco, WA 99301", "555.123.4567", "buddy@michaelstoops.com", null);
		o.put(a1);
		a1.setName("Buddy Turbo Stoops");
		o.put(a1);
		System.out.println(o.getAccount(a1.getId()));
		
		Account a2 = new Account(0, "Ratster Stoops", "101 Rat Ln\nPasco, WA 99301", "555.223.4567", "ratster@michaelstoops.com", null);
		o.put(a2);
		a2.setEmail("ratsterlordofcheese@michaelstoops.com");
		o.put(a2);
		System.out.println(o.getAccount(a2.getId()));
		
		Account a3 = new Account(0, "Birdbrain Stoops", "101 Bird Ln\nPasco, WA 99301", "800.CHX.STIX", "birdbrain@michaelstoops.com", null);
		o.put(a3);
		a3.setTaxId("555-00-1234");
		o.put(a3);
		System.out.println(o.getAccount(a3.getId()));
	}

	@Test
	public void testPutAndGetLot() throws SQLException {
		AuctionDataSource o = new AuctionDataSource();
		Lot l1 = new Lot(0, "Chewed Plush Hedgehog", 0.05, 101);
		o.put(l1);
		l1.setDescription("A fairly wet, plush hedgehog. Smells funny. Used to squeak.");
		o.put(l1);
		System.out.println(o.getLot(l1.getId()));
		
		Lot l2 = new Lot(0, "Block of Cheese", 1.99, 102);
		o.put(l2);
		l2.setDeclaredValue(0.99);
		o.put(l2);
		System.out.println(o.getLot(l2.getId()));

		Lot l3 = new Lot(0, "Whole Roaster Chicken", 5.00, 103);
		o.put(l3);
		l3.setTitle("Chicken Breasts");
		o.put(l3);
		System.out.println(o.getLot(l3.getId()));
		
	}

	@Test
	public void testPutAndGetPayment() throws SQLException {
		AuctionDataSource o = new AuctionDataSource();
		Payment p1 = new Payment(0, 69, 1.0, "Cash", "I'M RIIIIICH BIATCH!");
		o.put(p1);
		p1.setAmount(11.0);
		o.put(p1);
		System.out.println(o.getPayment(p1.getId()));
		
		Payment p2 = new Payment(0, 69, 2.0, "CC", null);
		o.put(p2);
		p2.setComments("OK, maybe I'm actually broke.");
		o.put(p2);
		System.out.println(o.getPayment(p2.getId()));
		
		Payment p3 = new Payment(0, 70, 0.01, "Cedar chips", "Not sure if cedar chips are legal tender");
		o.put(p3);
		p3.setReceived(new Date(new Date().getTime() - 100000000));
		o.put(p3);
		System.out.println(o.getPayment(p3.getId()));
	}

}
