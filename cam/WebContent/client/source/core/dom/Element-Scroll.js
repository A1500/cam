/**
 * 元素是否可以拖动(scroll)：实际高度/宽度大于可视高度/宽度
 * 
 * @return {Boolean}
 */
L5.Element.prototype.isScrollable = function() {
	var dom = this.dom;
	// scrollHeight:内容实际高度
	// clientHeight:内容可视区域高度
	return dom.scrollHeight > dom.clientHeight
			|| dom.scrollWidth > dom.clientWidth;
};

/**
 * 拖动该元素内容到指定位置. 该方法不会检查边界.要自动检查边界，使用方法scroll().
 * 
 * @param {String}
 *            side left表示左右移动，top表示上下移动
 * @param {Number}
 *            value 新的值
 * @param {Boolean/Object}
 *            animate (optional) true：使用默认拖动动画，也可以用标准的动画配置对象来设置一个个性化动画
 * @return {Element} this
 */
L5.Element.prototype.scrollTo = function(side, value, animate) {
	var prop = side.toLowerCase() == "left" ? "scrollLeft" : "scrollTop";
	if (!animate || !L5.lib.Anim) {
		this.dom[prop] = value;
	} else {
		var to = prop == "scrollLeft" ? [ value, this.dom.scrollTop ] : [
				this.dom.scrollLeft, value ];
		this.anim({
			scroll : {
				"to" : to
			}
		}, this.preanim(arguments, 2), 'scroll');
	}
	return this;
};

/**
 * 往某一方向拖动元素，会检查边界。
 * 
 * @param {String}
 *            direction 合法的值有： "l" (or "left") 表示左边, "r" (or "right") 表示右边, "t"
 *            (or "top", or "up") 表示顶部, "b" (or "bottom", or "down") 表示底部.
 * @param {Number}
 *            distance 拖动距离，单位是像素
 * @param {Boolean/Object}
 *            animate (optional) true：使用默认拖动动画，也可以用标准的动画配置对象来设置一个个性化动画
 * @return {Boolean} true：拖动到指定位置了；false：没有拖动到指定位置(太远了)
 */
L5.Element.prototype.scroll = function(direction, distance, animate) {
	if (!this.isScrollable()) {
		return;
	}
	var el = this.dom;
	var l = el.scrollLeft, t = el.scrollTop;
	var w = el.scrollWidth, h = el.scrollHeight;
	var cw = el.clientWidth, ch = el.clientHeight;
	direction = direction.toLowerCase();
	var scrolled = false;
	var a = this.preanim(arguments, 2);
	switch (direction) {
	case "l":
	case "left":
		if (w - l > cw) {
			var v = Math.min(l + distance, w - cw);
			this.scrollTo("left", v, a);
			scrolled = true;
		}
		break;
	case "r":
	case "right":
		if (l > 0) {
			var v = Math.max(l - distance, 0);
			this.scrollTo("left", v, a);
			scrolled = true;
		}
		break;
	case "t":
	case "top":
	case "up":
		if (t > 0) {
			var v = Math.max(t - distance, 0);
			this.scrollTo("top", v, a);
			scrolled = true;
		}
		break;
	case "b":
	case "bottom":
	case "down":
		if (h - t > ch) {
			var v = Math.min(t + distance, h - ch);
			this.scrollTo("top", v, a);
			scrolled = true;
		}
		break;
	}
	return scrolled;
};

/**
 * 返回该元素的拖动位置：dom的scrollLeft和scrollTop.
 * 
 * @return {Object} 包含拖动位置的对象 {left: (scrollLeft), top: (scrollTop)}
 */
L5.Element.prototype.getScroll = function() {
	var d = this.dom, doc = document;
	if (d == doc || d == doc.body) {
		var l, t;
		if (L5.isIE && L5.isStrict) {
			l = doc.documentElement.scrollLeft || (doc.body.scrollLeft || 0);
			t = doc.documentElement.scrollTop || (doc.body.scrollTop || 0);
		} else {
			l = window.pageXOffset || (doc.body.scrollLeft || 0);
			t = window.pageYOffset || (doc.body.scrollTop || 0);
		}
		return {
			left : l,
			top : t
		};
	} else {
		return {
			left : d.scrollLeft,
			top : d.scrollTop
		};
	}
};

/**
 * 拖动这个元素到某个指定容器内
 * 
 * @param {Mixed}
 *            container (optional) 目标容器元素或id,(默认是document.body).
 * @param {Boolean}
 *            hscroll (optional) False：禁止水平滚动(默认是true)
 * @return {L5.Element} this
 */
L5.Element.prototype.scrollIntoView = function(container, hscroll) {
	var c = L5.getDom(container) || L5.getBody().dom;
	var el = this.dom;

	var o = this.getOffsetsTo(c), l = o[0] + c.scrollLeft, t = o[1]
			+ c.scrollTop, b = t + el.offsetHeight, r = l + el.offsetWidth;

	var ch = c.clientHeight;
	var ct = parseInt(c.scrollTop, 10);
	var cl = parseInt(c.scrollLeft, 10);
	var cb = ct + ch;
	var cr = cl + c.clientWidth;

	if (el.offsetHeight > ch || t < ct) {
		c.scrollTop = t;
	} else if (b > cb) {
		c.scrollTop = b - ch;
	}
	c.scrollTop = c.scrollTop; // corrects IE, other browsers will
	// ignore

	if (hscroll !== false) {
		if (el.offsetWidth > c.clientWidth || l < cl) {
			c.scrollLeft = l;
		} else if (r > cr) {
			c.scrollLeft = r - c.clientWidth;
		}
		c.scrollLeft = c.scrollLeft;
	}
	return this;
};
// private
L5.Element.prototype.scrollChildIntoView = function(child, hscroll) {
	L5.fly(child, '_scrollChildIntoView').scrollIntoView(this, hscroll);
};
