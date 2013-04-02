package com.stoopsartsunlimited.auction;

import java.util.ArrayList;
import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import com.stoopsartsunlimited.atom.Link;

@XmlRootElement(name = "payment")
public class Payment {
	public static final String CC = "CC";
	public static final String CHECK = "Check";
	public static final String CASH = "Cash";
	
	private int id = 0;
	private int account = 0;
	private double amount = 0;
	private String instrument = null;
	private String comments = null;
	private Date received = null;
	private Date modified = null;
	private ArrayList<Link> link = null;
	private Lots forLots = null;
	
	public Payment() {
	}
	
	public Payment(int id) {
		this.id = id;
	}
	
	public Payment(int id, int account, double amount, String instrument, String comments, Date received, Date modified) {
		this.id = id;
		this.account = account;
		this.amount = amount;
		this.instrument = instrument;
		this.comments = comments;
		this.received = received;
		this.modified = modified;
	}
	
	public Payment(int id, int account, double amount, String instrument, String comments) {
		this(id, account, amount, instrument, comments, new Date(), new Date());
	}
	
	@Override
	public String toString() {
		return String.format("$%.2f:%d", amount, id);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAccount() {
		return account;
	}
	public void setAccount(int account) {
		this.account = account;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getInstrument() {
		return instrument;
	}
	public void setInstrument(String instrument) {
		this.instrument = instrument;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Date getReceived() {
		return received;
	}
	public void setReceived(Date received) {
		this.received = received;
	}
	public Date getModified() {
		return modified;
	}
	public void setModified(Date modified) {
		this.modified = modified;
	}

	public ArrayList<Link> getLink() {
		return link;
	}

	public void setLink(ArrayList<Link> link) {
		this.link = link;
	}

	public Lots getForLots() {
		return forLots;
	}

	public void setForLots(Lots forLots) {
		this.forLots = forLots;
	}
	
}
