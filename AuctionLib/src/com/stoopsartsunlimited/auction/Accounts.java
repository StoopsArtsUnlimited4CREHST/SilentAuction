package com.stoopsartsunlimited.auction;

import java.util.Collection;
import java.util.LinkedList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "accounts")
public class Accounts {
	private LinkedList<Account> list = new LinkedList<Account>();

	public Accounts() {	
	}

	public Accounts(Collection<Account> list) {
		this.list = new LinkedList<Account>(list);
	}

	@XmlElement(name = "account")
	public LinkedList<Account> getList() {
		return list;
	}

	public void setList(LinkedList<Account> list) {
		this.list = list;
	}
	
}
