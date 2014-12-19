/**
 * 
 * 提供了一系列的操作dom元素的方法包括对高度，宽度，位置等的操作
 * 
 * @constructor
 * 
 */
L5.lib.Dom = function() {

};

(function() {
	var libFlyweight;

	L5.lib.Dom.fly = function(el) {
		if (!libFlyweight) {
			libFlyweight = new L5.Element.Flyweight();
		}
		libFlyweight.dom = el;
		return libFlyweight;
	};
})();

L5.lib.Dom.getViewWidth = function(full) {
	return full ? this.getDocumentWidth() : this.getViewportWidth();
};

L5.lib.Dom.getViewHeight = function(full) {
	return full ? this.getDocumentHeight() : this.getViewportHeight();
};

L5.lib.Dom.getDocumentHeight = function() {
	var scrollHeight = (document.compatMode != "CSS1Compat") ? document.body.scrollHeight
			: document.documentElement.scrollHeight;
	return Math.max(scrollHeight, this.getViewportHeight());
};

L5.lib.Dom.getDocumentWidth = function() {
	var scrollWidth = (document.compatMode != "CSS1Compat") ? document.body.scrollWidth
			: document.documentElement.scrollWidth;
	return Math.max(scrollWidth, this.getViewportWidth());
};

L5.lib.Dom.getViewportHeight = function() {
	if (L5.isIE) {
		return L5.isStrict ? document.documentElement.clientHeight
				: document.body.clientHeight;
	} else {
		return self.innerHeight;
	}
};

L5.lib.Dom.getViewportWidth = function() {
	if (L5.isIE) {
		return L5.isStrict ? document.documentElement.clientWidth
				: document.body.clientWidth;
	} else {
		return self.innerWidth;
	}
};

L5.lib.Dom.isAncestor = function(p, c) {
	p = L5.getDom(p);
	c = L5.getDom(c);
	if (!p || !c) {
		return false;
	}

	if (p.contains && !L5.isSafari) {
		return p.contains(c);
	} else if (p.compareDocumentPosition) {
		return !!(p.compareDocumentPosition(c) & 16);
	} else {
		var parent = c.parentNode;
		while (parent) {
			if (parent == p) {
				return true;
			} else if (!parent.tagName
					|| parent.tagName.toUpperCase() == "HTML") {
				return false;
			}
			parent = parent.parentNode;
		}
		return false;
	}
};

L5.lib.Dom.getRegion = function(el) {
	return L5.lib.Region.getRegion(el);
};

L5.lib.Dom.getY = function(el) {
	return this.getXY(el)[1];
};

L5.lib.Dom.getX = function(el) {
	return this.getXY(el)[0];
};
/**
 * 
 * @param {Mixed} el 可以是id也可以是包装的{@link L5.Element}元素
 */
L5.lib.Dom.getXY = function(el) {
	var p, pe, b, scroll, bd = (document.body || document.documentElement);
	el = L5.getDom(el);

	if (el == bd) {
		return [ 0, 0 ];
	}

	if (el.getBoundingClientRect) {
		b = el.getBoundingClientRect();
		scroll = this.fly(document).getScroll();
		return [ b.left + scroll.left, b.top + scroll.top ];
	}
	var x = 0, y = 0;

	p = el;

	var hasAbsolute = this.fly(el).getStyle("position") == "absolute";

	while (p) {

		x += p.offsetLeft;
		y += p.offsetTop;

		if (!hasAbsolute && this.fly(p).getStyle("position") == "absolute") {
			hasAbsolute = true;
		}

		if (L5.isGecko) {
			pe = this.fly(p);

			var bt = parseInt(pe.getStyle("borderTopWidth"), 10) || 0;
			var bl = parseInt(pe.getStyle("borderLeftWidth"), 10) || 0;

			x += bl;
			y += bt;

			if (p != el && pe.getStyle('overflow') != 'visible') {
				x += bl;
				y += bt;
			}
		}
		p = p.offsetParent;
	}

	if (L5.isSafari && hasAbsolute) {
		x -= bd.offsetLeft;
		y -= bd.offsetTop;
	}

	if (L5.isGecko && !hasAbsolute) {
		var dbd = this.fly(bd);
		x += parseInt(dbd.getStyle("borderLeftWidth"), 10) || 0;
		y += parseInt(dbd.getStyle("borderTopWidth"), 10) || 0;
	}

	p = el.parentNode;
	while (p && p != bd) {
		if (!L5.isOpera
				|| (p.tagName != 'TR' && this.fly(p).getStyle("display") != "inline")) {
			x -= p.scrollLeft;
			y -= p.scrollTop;
		}
		p = p.parentNode;
	}
	return [ x, y ];
};

L5.lib.Dom.setXY = function(el, xy) {
	el = L5.fly(el, '_setXY');
	el.position();
	var pts = el.translatePoints(xy);
	if (xy[0] !== false) {
		el.dom.style.left = pts.left + "px";
	}
	if (xy[1] !== false) {
		el.dom.style.top = pts.top + "px";
	}
};

L5.lib.Dom.setX = function(el, x) {
	this.setXY(el, [ x, false ]);
};

L5.lib.Dom.setY = function(el, y) {
	this.setXY(el, [ false, y ]);
};
