package com.stoopsartsunlimited.auction;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.junit.Test;

public class ObjectAsXMLTest {

	@Test
	public void test() throws JAXBException {
		JAXBContext context;
		Marshaller marshaller;
		
		Account account = new Account(101, "Buddy Stoops", "101 Dog Ln\nPasco, WA 99301", "555.123.4567", "buddy@michaelstoops.com", null);
		context = JAXBContext.newInstance(Account.class);
		marshaller = context.createMarshaller();
		marshaller.marshal(account, System.out);
		System.out.println();
		
		Lot lot = new Lot(201, "Chewed Plush Hedgehog", 0.05, 101);
		context = JAXBContext.newInstance(Lot.class);
		marshaller = context.createMarshaller();
		marshaller.marshal(lot, System.out);
		System.out.println();

		Payment payment = new Payment(301, 101, 0.05, "CC", "ohai");
		context = JAXBContext.newInstance(Payment.class);
		marshaller = context.createMarshaller();
		marshaller.marshal(payment, System.out);
		System.out.println();
		
		Payments payments = new Payments();
		payments.getList().add(new Payment(301, 101, 0.05, "CC", "ohai"));
		payments.getList().add(new Payment(302, 101, 0.04, "CC", "ohai"));
		payments.getList().add(new Payment(303, 101, 0.03, "CC", "ohai"));
		payments.getList().add(new Payment(304, 101, 0.02, "CC", "ohai"));
		payments.getList().add(new Payment(305, 101, 0.01, "cash", "lsat"));
		context = JAXBContext.newInstance(Payments.class);
		marshaller = context.createMarshaller();
		marshaller.marshal(payments, System.out);
		System.out.println();
	}

}
