package com.stoopsartsunlimited.auction.api;

import java.util.Collection;
import java.util.LinkedList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "results")
public class SearchResults {
	private LinkedList<SearchResult> list = new LinkedList<SearchResult>();

	public SearchResults() {	
	}

	public SearchResults(Collection<SearchResult> list) {
		this.list = new LinkedList<SearchResult>(list);
	}

	@XmlElement(name = "result")
	public LinkedList<SearchResult> getList() {
		return list;
	}

	public void setList(LinkedList<SearchResult> list) {
		this.list = list;
	}
	
}
