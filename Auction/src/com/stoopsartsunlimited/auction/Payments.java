package com.stoopsartsunlimited.auction;

import java.util.Collection;
import java.util.LinkedList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "payments")
public class Payments {
	private LinkedList<Payment> list = new LinkedList<Payment>();

	public Payments() {	
	}

	public Payments(Collection<Payment> list) {
		this.list = new LinkedList<Payment>(list);
	}

	@XmlElement(name = "payment")
	public LinkedList<Payment> getList() {
		return list;
	}

	public void setList(LinkedList<Payment> list) {
		this.list = list;
	}
	
}
