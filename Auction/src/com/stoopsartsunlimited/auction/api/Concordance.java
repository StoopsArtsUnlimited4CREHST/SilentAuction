package com.stoopsartsunlimited.auction.api;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.tuple.Pair;


public class Concordance {
	protected HashMap<String, Integer> map = new HashMap<String, Integer>();
	
	public Collection<String> getWords() {
		return map.keySet();
	}
	
	public int getCount(String word) {
		if (map.containsKey(word)){
			return map.get(word);
		} else {
			return 0;
		}
	}
	
	public void addWord(String word) {
		map.put(word, getCount(word) + 1);
	}
	
	public List<Pair<Integer, String>> search(String fragment) {
		ArrayList<Pair<Integer, String>> r = new ArrayList<Pair<Integer, String>>();
		for (String word : map.keySet()) {
			if (word.contains(fragment)) {
				r.add(Pair.of(map.get(word), word));
			}
		}
		Collections.sort(r, Collections.reverseOrder());
		return r;
	}
}
