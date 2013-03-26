package com.stoopsartsunlimited.auction.api;

import javax.xml.bind.annotation.XmlRootElement;

import com.stoopsartsunlimited.atom.Link;

@XmlRootElement(name = "result")
public class SearchResult {
	private Link link;
	private String type;
	private boolean active;
	private String description;
	public Link getLink() {
		return link;
	}
	public void setLink(Link link) {
		this.link = link;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	/*
	 * <results>
		<account>
			<link rel="self" href="http://localhost:8080/AuctionRestApi/accounts/63"/>
			<active>true</active>
			<name>Buddy Turbo Stoops</name>
		</account>
		<account>
			<link rel="self" href="http://localhost:8080/AuctionRestApi/accounts/64"/>
			<active>true</active>
			<name>Ratster Stoops</name>
		</account>
		<account>
			<link rel="self" href="http://localhost:8080/AuctionRestApi/accounts/65"/>
			<active>false</active>
			<name>Birdbrain Stoops</name>
		</account>
		<lot>
			<link rel="self" href="http://localhost:8080/AuctionRestApi/lots/119"/>
			<status>NONE</status>
			<title>Chewed Plush Hedgehog</title>
		</lot>
		<lot>
			<link rel="self" href="http://localhost:8080/AuctionRestApi/lots/120"/>
			<status>PAID</status>
			<title>Block of Cheese</title>
		</lot>
		<lot>
			<link rel="self" href="http://localhost:8080/AuctionRestApi/lots/121"/>
			<status>NONE</status>
			<title>Chicken Breasts</title>
		</lot>
	</results>
	*/
}
