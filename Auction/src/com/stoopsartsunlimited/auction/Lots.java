package com.stoopsartsunlimited.auction;

import java.util.Collection;
import java.util.LinkedList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "lots")
public class Lots {
	private LinkedList<Lot> list = new LinkedList<Lot>();

	public Lots() {	
	}

	public Lots(Collection<Lot> list) {
		this.list = new LinkedList<Lot>(list);
	}

	@XmlElement(name = "lot")
	public LinkedList<Lot> getList() {
		return list;
	}

	public void setList(LinkedList<Lot> list) {
		this.list = list;
	}
	
}
