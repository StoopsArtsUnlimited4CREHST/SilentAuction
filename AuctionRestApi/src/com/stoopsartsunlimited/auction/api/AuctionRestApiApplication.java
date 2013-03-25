package com.stoopsartsunlimited.auction.api;

import java.util.HashSet;
import java.util.Set;

import javax.ws.rs.core.Application;

public class AuctionRestApiApplication extends Application {
	private Set<Object> singletons = new HashSet<Object>();
	private Set<Class<?>> classes = new HashSet<Class<?>>();
	
	public AuctionRestApiApplication() {
		singletons.add(new AccountsResource());
		singletons.add(new LotsResource());
		singletons.add(new PaymentsResource());
		singletons.add(new SearchResource());
		singletons.add(new CashDonationsResource());
		//classes.add(AccountsResource.class);
		//classes.add(LotsResource.class);
		//classes.add(PaymentsResource.class);
	}
	
	@Override
	public Set<Class<?>> getClasses() {
		return classes;
	}
	
	@Override
	public Set<Object> getSingletons() {
		return singletons;
	}
}
