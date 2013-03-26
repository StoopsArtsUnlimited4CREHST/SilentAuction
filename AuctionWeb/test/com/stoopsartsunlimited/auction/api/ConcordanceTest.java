package com.stoopsartsunlimited.auction.api;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;

import java.util.List;

import org.apache.commons.lang3.tuple.Pair;
import org.junit.Test;


public class ConcordanceTest {

	@Test
	public void testGetWords() {
		Concordance o = new Concordance();
		o.addWord("weasel");
		o.addWord("mongoose");
		o.addWord("ferret");
		o.addWord("ferret");
		for (int i = 0; i < 1000; i++) {
			o.addWord("squirrel");
		}
		//Object[] a = o.getWords().toArray();
		assertArrayEquals("weasel,mongoose,squirrel,ferret".split(","), o.getWords().toArray());
	}

	@Test
	public void testAddWordAndGetCount() {
		Concordance o = new Concordance();
		assertEquals(o.getCount("weasel"), 0);
		assertEquals(o.getCount("ferret"), 0);
		assertEquals(o.getCount("mongoose"), 0);
		assertEquals(o.getCount("squirrel"), 0);
		o.addWord("ferret");
		assertEquals(o.getCount("weasel"), 0);
		assertEquals(o.getCount("ferret"), 1);
		assertEquals(o.getCount("mongoose"), 0);
		assertEquals(o.getCount("squirrel"), 0);
		o.addWord("mongoose");
		assertEquals(o.getCount("weasel"), 0);
		assertEquals(o.getCount("ferret"), 1);
		assertEquals(o.getCount("mongoose"), 1);
		assertEquals(o.getCount("squirrel"), 0);
		o.addWord("ferret");
		assertEquals(o.getCount("weasel"), 0);
		assertEquals(o.getCount("ferret"), 2);
		assertEquals(o.getCount("mongoose"), 1);
		assertEquals(o.getCount("squirrel"), 0);
		for (int i = 0; i < 1000; i++) {
			o.addWord("squirrel");
		}
		assertEquals(o.getCount("weasel"), 0);
		assertEquals(o.getCount("ferret"), 2);
		assertEquals(o.getCount("mongoose"), 1);
		assertEquals(o.getCount("squirrel"), 1000);
		
	}

	@Test
	public void testSearch() {
		String text = "Phasellus quis odio vel eros ultrices sollicitudin eu a tellus. Ut molestie arcu non enim pulvinar id molestie tortor pharetra. Nam dapibus placerat justo vitae tristique. Duis lobortis auctor posuere. In imperdiet velit et augue ullamcorper id tincidunt est eleifend. Mauris lorem tortor, iaculis eu lobortis nec, pharetra eget nisl. Quisque convallis facilisis dui, eget pulvinar ligula sollicitudin quis. Donec sit amet sem quis mauris vulputate posuere. Nulla mollis aliquet massa, posuere posuere nunc tincidunt nec. Nulla ut nisl risus, porttitor eleifend turpis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla viverra ultricies vulputate. Proin porttitor, tortor sed mollis imperdiet, orci arcu gravida sem, eu adipiscing nulla lectus vel enim. Nulla ultricies, est sit amet ultrices ultricies, lectus sapien lobortis erat, sit amet egestas eros lectus at orci. In viverra aliquet sapien et ultricies. Morbi sed est odio, non dignissim tellus. Fusce scelerisque neque pellentesque sem ultrices facilisis. Nam ornare laoreet felis in mattis. In consequat ipsum quis leo ornare feugiat. Cras pretium hendrerit egestas. Nullam sit amet metus erat. Quisque tincidunt faucibus arcu porttitor aliquam. Nulla cursus mauris vitae felis lacinia ultricies. Nulla feugiat scelerisque neque vitae dapibus. Etiam arcu massa, interdum eu luctus eu, scelerisque in libero. Suspendisse potenti. Fusce dapibus vehicula felis, sit amet sollicitudin felis posuere ac. Nunc vulputate tempor venenatis. Curabitur a nisi risus. Quisque lobortis porttitor velit et blandit. Vivamus dictum pharetra urna, at ornare velit porta quis. In ornare justo nec risus vehicula a porta nisi mattis. Suspendisse posuere leo eu libero malesuada ullamcorper. Maecenas eget felis quis lacus aliquam venenatis sit amet non dui. Proin ac orci mi, ut hendrerit ipsum. In ac elit quam, imperdiet mollis dolor. Fusce et libero eros, sed lobortis augue. Praesent quis commodo ante. Proin ac tortor magna, et vehicula odio. Praesent ut vehicula tellus. Nulla interdum eleifend varius. Vivamus a massa dolor. Integer eget tortor eu elit interdum facilisis. Morbi porta arcu ac nisl luctus iaculis. Curabitur tincidunt eros id diam interdum vitae interdum est porta. Praesent felis odio, dictum id placerat nec, gravida vitae tellus. Pellentesque tincidunt, velit nec auctor lobortis, neque nulla varius nisi, at commodo erat odio ac magna. Etiam sed lectus dolor. Nulla facilisi. Morbi cursus consequat dui, vel laoreet quam dapibus at. Sed vel velit eros, sed laoreet enim. Nullam commodo facilisis facilisis. In hac habitasse platea dictumst. Mauris eget ullamcorper ligula. Nulla euismod tempor lacus, non cursus felis suscipit id. Donec sollicitudin leo eget felis feugiat malesuada. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis libero at nulla sagittis aliquet. Sed sed lacinia mi. Sed sit amet ante eu elit vulputate luctus faucibus ut nunc. Integer eu augue sem, nec interdum velit. In justo leo, tempus et rutrum sit amet, bibendum at arcu. Suspendisse a massa id odio dapibus tincidunt. Maecenas a tempor augue. Ut venenatis quam sed magna sagittis ornare. Nulla pharetra aliquam elementum. Sed auctor lobortis tincidunt. Nam eu est nisi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum ac lacus eget turpis consectetur dapibus. Vivamus felis est, rhoncus nec pellentesque in, euismod at elit. Praesent consequat vulputate ligula, ut congue purus facilisis quis. Etiam tincidunt feugiat urna, id euismod magna blandit non. Suspendisse porttitor ullamcorper erat, eget malesuada purus tempus vitae. In ac ligula lectus. Sed tempor massa id est placerat varius. Praesent ut velit erat. Proin ut nunc ut diam elementum condimentum quis quis turpis. Etiam ut lacus eget elit blandit porttitor sit amet ac risus. Cras a elit ante, nec pulvinar nulla. Vestibulum diam augue, auctor vel suscipit in, hendrerit a enim. Donec urna metus, varius sit amet lacinia at, mattis nec diam. Nulla feugiat varius pulvinar. In hac habitasse platea dictumst. Morbi eget porta erat. Suspendisse id diam nec erat pellentesque ullamcorper id vel diam. Donec a orci sit amet odio suscipit molestie. Suspendisse vel risus in lorem viverra adipiscing. Nullam massa lacus, ullamcorper eget commodo a, vehicula sit amet augue. Proin augue purus, convallis et cursus eu, imperdiet sed purus. Vivamus posuere ultricies mi, ac dapibus purus iaculis non. Proin bibendum magna quis nibh viverra gravida iaculis vitae leo. Etiam felis libero, ultrices eget fermentum in, sagittis rhoncus lacus. Nullam et augue lectus, eget imperdiet sapien. Curabitur vel est magna. Maecenas sed sapien ac nibh gravida mattis sed venenatis mauris. Cras sed mi diam, id vehicula dolor. Donec in ante leo. Fusce sed nisl neque, sed porta libero. Vestibulum arcu dui, lacinia sit amet gravida vel, malesuada ut felis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec molestie interdum cursus. Duis sagittis faucibus magna in tristique. Suspendisse gravida, justo quis varius feugiat, eros augue aliquet massa, vel volutpat turpis est id felis. Integer pellentesque metus sollicitudin mi placerat quis eleifend elit mollis. Etiam nibh mauris, gravida vitae tempor ac, pulvinar at libero. Quisque commodo, nisl quis placerat ultrices, nunc lacus interdum mi, sed tincidunt eros felis in tortor. Sed ac dapibus purus. Nulla tristique mauris ac erat laoreet id aliquam sapien posuere. Ut eu lacus tortor. Donec elit mauris, consequat sit amet tempor in, dictum eget orci. Nulla varius arcu at elit vestibulum ac pulvinar est accumsan. Integer laoreet nisi sed nulla ultricies vel laoreet ipsum vestibulum. Etiam ipsum est, auctor id laoreet ac, dictum vitae dolor. Etiam non sapien ac mauris elementum condimentum. Maecenas feugiat consectetur augue, eu scelerisque elit commodo eget. Mauris rhoncus blandit orci a molestie. Aliquam erat volutpat. Praesent commodo pharetra velit, ac varius velit blandit sit amet. Duis eget quam nisi. Praesent feugiat quam ut turpis aliquet varius fermentum nisl fringilla. Aliquam erat volutpat. Ut nec orci nec mi pretium venenatis ac non augue. Nulla facilisi. Nullam scelerisque malesuada volutpat. Proin vel justo sit amet eros tempor ultrices ac ac magna. Praesent sed nunc sit amet mauris gravida dictum vitae id enim. Suspendisse at libero elit, a vulputate purus. Fusce velit purus, tincidunt eu rhoncus in, rutrum vitae neque. Aliquam dapibus, urna nec aliquet varius, mi erat semper risus.";
		Concordance o = new Concordance();
		for (String word : text.split("\\W+")) {
			o.addWord(word);
		}
		
		/*
		for (String word : o.getWords()) {
			System.out.println(word + ": " + o.getCount(word));
		}
		*/

		/*
		erat: 11
		posuere: 8
		libero: 8
		interdum: 8
		eros: 8
		ullamcorper: 6
		scelerisque: 5
		placerat: 5
		imperdiet: 5
		viverra: 4
		per: 4
		Integer: 4
		hendrerit: 3
		fermentum: 2
		semper: 1
		*/
		List<Pair<Integer, String>> pairs = o.search("er");
		assertEquals(Pair.of(11, "erat"), pairs.get(0));
		assertEquals(Pair.of(8, "posuere"), pairs.get(1));
		assertEquals(Pair.of(8, "libero"), pairs.get(2));
		assertEquals(Pair.of(8, "interdum"), pairs.get(3));
		assertEquals(Pair.of(8, "eros"), pairs.get(4));
		assertEquals(Pair.of(6, "ullamcorper"), pairs.get(5));
		assertEquals(Pair.of(5, "scelerisque"), pairs.get(6));
		assertEquals(Pair.of(5, "placerat"), pairs.get(7));
		assertEquals(Pair.of(5, "imperdiet"), pairs.get(8));
		assertEquals(Pair.of(4, "viverra"), pairs.get(9));
		assertEquals(Pair.of(4, "per"), pairs.get(10));
		assertEquals(Pair.of(4, "Integer"), pairs.get(11));
		assertEquals(Pair.of(3, "hendrerit"), pairs.get(12));
		assertEquals(Pair.of(2, "fermentum"), pairs.get(13));
		assertEquals(Pair.of(1, "semper"), pairs.get(14));
	}

}
