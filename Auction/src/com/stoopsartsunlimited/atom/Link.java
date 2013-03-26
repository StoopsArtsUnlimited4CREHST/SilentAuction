package com.stoopsartsunlimited.atom;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

/*
 * see http://www.w3schools.com/tags/tag_link.asp
 */
@XmlRootElement(name = "link")
public class Link {
	
	public final static String REL_ALTERNATE = "alternate";
	public final static String REL_ARCHIVES = "archives";
	public final static String REL_AUTHOR = "author";
	public final static String REL_BOOKMARK = "bookmark";
	public final static String REL_EXTERNAL = "external";
	public final static String REL_FIRST = "first";
	public final static String REL_HELP = "help";
	public final static String REL_ICON = "icon";
	public final static String REL_LAST = "last";
	public final static String REL_LICENSE = "license";
	public final static String REL_NEXT = "next";
	public final static String REL_NOFOLLOW = "nofollow";
	public final static String REL_NOREFERRER = "noreferrer";
	public final static String REL_PINGBACK = "pingback";
	public final static String REL_PREFETCH = "prefetch";
	public final static String REL_PREF = "prev";
	public final static String REL_SEARCH = "search";
	public final static String REL_SIDEBAR = "sidebar";
	public final static String REL_STYLESHEET = "stylesheet";
	public final static String REL_TAG = "tag";
	public final static String REL_UP = "up";
	
	private String href;
	private String rel;
	private String target;
	private String type;
	
	public Link() {
		super();
	}
	
	public Link(String rel, String type, String href, String target) {
		super();
		this.rel = rel;
		this.type = type;
		this.href = href;
		this.target = target;
	}
	
	@XmlAttribute(name = "href", required = true)
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}

	@XmlAttribute(name = "rel", required = true)
	public String getRel() {
		return rel;
	}
	public void setRel(String rel) {
		this.rel = rel;
	}

	@XmlAttribute(name = "target")
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}

	@XmlAttribute(name = "type")
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
