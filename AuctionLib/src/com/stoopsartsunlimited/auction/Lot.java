package com.stoopsartsunlimited.auction;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "lot")
public class Lot {
	private int id = 0;
	private String title = null;
	private String description = null;
	private BiddingStatus status = BiddingStatus.NONE;
	private double declaredValue = 0;
	private double finalValue = 0;
	/**
	 * Account ID of the person who made the winning bid for this lot.
	 */
	private int winner = 0;
	/**
	 * Account ID of the person who gave the lot to the auction.
	 */
	private int contributor = 0;
	private Date created = null;
	private Date modified = null;
	
	public enum BiddingStatus {
		NONE,
		BIDDING,
		CLOSED,
		PAID,
	}
	
	public Lot() {
	}
	
	public Lot(int id, String title, String description, BiddingStatus status, double declaredValue, double finalValue, int winner, int contributor, Date created, Date modified) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.status = status;
		this.declaredValue = declaredValue;
		this.finalValue = finalValue;
		this.winner = winner;
		this.contributor = contributor;
		this.created = created;
		this.modified = modified;
	}
	
	public Lot(int id, String title, double declaredValue, int contributor) {
		this(id, title, title, BiddingStatus.NONE, declaredValue, 0, 0, contributor, new Date(), new Date());
	}

	@Override
	public String toString() {
		return String.format("%s:%d", title, id);
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BiddingStatus getStatus() {
		return status;
	}

	public void setStatus(BiddingStatus status) {
		this.status = status;
	}

	public double getDeclaredValue() {
		return declaredValue;
	}

	public void setDeclaredValue(double declaredValue) {
		this.declaredValue = declaredValue;
	}

	public double getFinalValue() {
		return finalValue;
	}

	public void setFinalValue(double finalValue) {
		this.finalValue = finalValue;
	}

	public int getWinner() {
		return winner;
	}

	public void setWinner(int winner) {
		this.winner = winner;
	}

	public int getContributor() {
		return contributor;
	}

	public void setContributor(int contributor) {
		this.contributor = contributor;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}
}
