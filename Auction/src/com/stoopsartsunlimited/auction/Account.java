package com.stoopsartsunlimited.auction;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "account")
public class Account {
	private int id = 0;
	private String name = null;
	private String address = null;
	private String phone = null;
	private String email = null;
	private String taxId = null;
	private String bidderId = null;
	private boolean active = true;
	private Date created = null;
	private Date modified = null;
	
	public Account() {
	}

	public Account(int id) {
		this.id = id;
	}
	
	public Account(int id, String name, String address, String phone, String email, String taxId, String bidderId, boolean active, Date created, Date modified) {
		this.id = id;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.taxId = taxId;
		this.bidderId = bidderId;
		this.active = active;
		this.created = created;
		this.modified = modified;
	}
	
	public Account(int id, String name, String address, String phone, String email, String taxId) {
		this(id, name, address, phone, email, taxId, null, true, new Date(), new Date());
	}
	
	@Override
	public String toString() {
		return String.format("%s:%d", name, id);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTaxId() {
		return taxId;
	}
	public void setTaxId(String taxId) {
		this.taxId = taxId;
	}
	public String getBidderId() {
		return bidderId;
	}
	public void setBidderId(String bidderId) {
		this.bidderId = bidderId;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
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
