/*
 * 操作element的样式属性相关的方法 
 */

(function() {
	var D = L5.lib.Dom;
	var A = L5.lib.Anim;
	var camelRe = /(-[a-z])/gi;
	var camelFn = function(m, a) {
		return a.charAt(1).toUpperCase();
	};
	var view = document.defaultView;

	var borders = {
		l : "border-left-width",
		r : "border-right-width",
		t : "border-top-width",
		b : "border-bottom-width"
	};

	var paddings = {
		l : "padding-left",
		r : "padding-right",
		t : "padding-top",
		b : "padding-bottom"
	};

	var margins = {
		l : "margin-left",
		r : "margin-right",
		t : "margin-top",
		b : "margin-bottom"
	};

	// special markup used throughout L5 when box wrapping elements
	L5.Element.boxMarkup = '<div class="{0}-tl"><div class="{0}-tr"><div class="{0}-tc"></div></div></div><div class="{0}-ml"><div class="{0}-mr"><div class="{0}-mc"></div></div></div><div class="{0}-bl"><div class="{0}-br"><div class="{0}-bc"></div></div></div>';

	var El = L5.Element;

	var propCache = {};// 私有静态变量

	/**
	 * @private
	 */
	L5.Element.prototype.classReCache = {},

	/**
	 * 修改元素的class属性，给元素增加一个或多个class，已经有了就不加了
	 * 
	 * @param {String/Array}
	 *            className
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.addClass = function(className) {
		if (L5.isArray(className)) {
			for ( var i = 0, len = className.length; i < len; i++) {
				this.addClass(className[i]);
			}
		} else {
			if (className && !this.hasClass(className)) {
				this.dom.className = this.dom.className + " " + className;
			}
		}
		return this;
	};

	/**
	 * 给该元素增加class，并删掉兄弟节点的相同class：该class只有这个元素有，别的兄弟节点不能有
	 * 
	 * @param {String/Array}
	 *            className
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.radioClass = function(className) {
		var siblings = this.dom.parentNode.childNodes;
		for ( var i = 0; i < siblings.length; i++) {
			var s = siblings[i];
			if (s.nodeType == 1) {
				L5.get(s).removeClass(className);
			}
		}
		this.addClass(className);
		return this;
	};

	/**
	 * 修改元素的class属性，删除一个或多个class
	 * 
	 * @param {String/Array}
	 *            className
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.removeClass = function(className) {
		if (className === true) {
			this.dom.className = " ";
			return this;
		}
		if (!className || !this.dom.className) {
			return this;
		}
		if (L5.isArray(className)) {
			for ( var i = 0, len = className.length; i < len; i++) {
				this.removeClass(className[i]);
			}
		} else {
			if (this.hasClass(className)) {
				var re = this.classReCache[className];
				if (!re) {
					re = new RegExp('(?:^|\\s+)' + className + '(?:\\s+|$)',
							"g");
					this.classReCache[className] = re;
				}
				this.dom.className = this.dom.className.replace(re, " ");
			}
		}
		return this;
	};

	/**
	 * 对指定class做开关：如果目前有这个class就变成没有(删掉)，如果目前没有就加上
	 * 
	 * @param {String}
	 *            className
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.toggleClass = function(className) {
		if (this.hasClass(className)) {
			this.removeClass(className);
		} else {
			this.addClass(className);
		}
		return this;
	};

	/**
	 * 判断：该元素是否已经有这个class了
	 * 
	 * @param {String}
	 *            className
	 * @return {Boolean}
	 */
	L5.Element.prototype.hasClass = function(className) {
		return className
				&& (' ' + this.dom.className + ' ').indexOf(' ' + className
						+ ' ') != -1;
	};

	/**
	 * 替换：删掉某个class，再加上一个新的class
	 * 
	 * @param {String}
	 *            oldClassName 旧的class
	 * @param {String}
	 *            newClassName 新的class
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.replaceClass = function(oldClassName, newClassName) {
		this.removeClass(oldClassName);
		this.addClass(newClassName);
		return this;
	};

	/**
	 * 获得几个样式属性值，例如
	 * <p>
	 * el.getStyles('color', 'font-size', 'width') might return {'color':
	 * '#FFFFFF', 'font-size': '13px', 'width': '100px'}.
	 * 
	 * @param {String}
	 *            style1 样式属性名称
	 * @param {String}
	 *            style2 样式属性名称
	 * @param {String}
	 *            etc.
	 * @return {Object} 包含样式属性的对象
	 */
	L5.Element.prototype.getStyles = function() {
		var a = arguments, len = a.length, r = {};
		for ( var i = 0; i < len; i++) {
			r[a[i]] = this.getStyle(a[i]);
		}
		return r;
	};

	/**
	 * 获得某个style属性值
	 * 
	 * @param {String}
	 *            property 属性名
	 * @return {String} 属性值
	 */
	L5.Element.prototype.getStyle = function() {
		return view && view.getComputedStyle ? function(prop) {
			var el = this.dom, v, cs, camel;
			if (prop == 'float') {
				prop = "cssFloat";
			}
			if (v = el.style[prop]) {
				return v;
			}
			if (cs = view.getComputedStyle(el, "")) {
				if (!(camel = propCache[prop])) {
					camel = propCache[prop] = prop.replace(camelRe, camelFn);
				}
				return cs[camel];
			}
			return null;
		} : function(prop) {
			var el = this.dom, v, cs, camel;
			if (prop == 'opacity') {
				if (typeof el.style.filter == 'string') {
					var m = el.style.filter.match(/alpha\(opacity=(.*)\)/i);
					if (m) {
						var fv = parseFloat(m[1]);
						if (!isNaN(fv)) {
							return fv ? fv / 100 : 0;
						}
					}
				}
				return 1;
			} else if (prop == 'float') {
				prop = "styleFloat";
			}
			if (!(camel = propCache[prop])) {
				camel = propCache[prop] = prop.replace(camelRe, camelFn);
			}
			if (v = el.style[camel]) {
				return v;
			}
			if (cs = el.currentStyle) {
				return cs[camel];
			}
			return null;
		};
	}();

	/**
	 * 设置一个或多个style属性值
	 * 
	 * @param {String/Object}
	 *            property 属性名，或者是一个包含多个属性名和属性值的对象
	 * @param {String}
	 *            value (optional) 属性值
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setStyle = function(prop, value) {
		if (typeof prop == "string") {
			var camel;
			if (!(camel = propCache[prop])) {
				camel = propCache[prop] = prop.replace(camelRe, camelFn);
			}
			if (camel == 'opacity') {
				this.setOpacity(value);
			} else {
				this.dom.style[camel] = value;
			}
		} else {
			for ( var style in prop) {
				if (typeof prop[style] != "function") {
					this.setStyle(style, prop[style]);
				}
			}
		}
		return this;
	};

	/**
	 * 比 {@link #setStyle} 更灵活的设置样式的方法
	 * 
	 * @param {String/Object/Function}
	 *            styles style字符串, e.g. "width:100px", 或者 style对象
	 *            {width:"100px"}, 或者一个可以返回style的函数.
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.applyStyles = function(style) {
		L5.DomHelper.applyStyles(this.dom, style);
		return this;
	};

	/**
	 * 返回元素的margin(),返回一个对象：{top:margin-top,left:margin-left,bottom:margin-bottom,right:margin-right};
	 * 
	 * @param {String}
	 *            sides (optional) Any combination of l, r, t, b to get the sum
	 *            of those sides
	 * @return {Object/Number}
	 */
	L5.Element.prototype.getMargins = function(side) {
		if (!side) {
			return {
				top : parseInt(this.getStyle("margin-top"), 10) || 0,
				left : parseInt(this.getStyle("margin-left"), 10) || 0,
				bottom : parseInt(this.getStyle("margin-bottom"), 10) || 0,
				right : parseInt(this.getStyle("margin-right"), 10) || 0
			};
		} else {
			return this.addStyles(side, margins);
		}
	};

	// private
	L5.Element.prototype.addStyles = function(sides, styles) {
		var val = 0, v, w;
		for ( var i = 0, len = sides.length; i < len; i++) {
			v = this.getStyle(styles[sides.charAt(i)]);
			if (v) {
				w = parseInt(v, 10);
				if (w) {
					val += (w >= 0 ? w : -1 * w);
				}
			}
		}
		return val;
	};

	/**
	 * 禁止选择该元素的文本
	 * 
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.unselectable = function() {
		this.dom.unselectable = "on";
		this.swallowEvent("selectstart", true);
		this.applyStyles("-moz-user-select:none;-khtml-user-select:none;");
		this.addClass("l-unselectable");
		return this;
	};

	/**
	 * 强制浏览器重绘当前元素
	 * 
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.repaint = function() {
		var dom = this.dom;
		this.addClass("l-repaint");
		setTimeout(function() {
			L5.get(dom).removeClass("l-repaint");
		}, 1);
		return this;
	};

	/**
	 * 获得元素的大小.
	 * 
	 * @param {Boolean}
	 *            contentSize (optional) true to get the width/size minus
	 *            borders and padding
	 * @return {Object} {width: (element width), height: (element height)}
	 */
	L5.Element.prototype.getSize = function(contentSize) {
		return {
			width : this.getWidth(contentSize),
			height : this.getHeight(contentSize)
		};
	};

	/**
	 * 
	 */
	L5.Element.prototype.getStyleSize = function() {
		var w, h, d = this.dom, s = d.style;
		if (s.width && s.width != 'auto') {
			w = parseInt(s.width, 10);
			if (L5.isBorderBox) {
				w -= this.getFrameWidth('lr');
			}
		}
		if (s.height && s.height != 'auto') {
			h = parseInt(s.height, 10);
			if (L5.isBorderBox) {
				h -= this.getFrameWidth('tb');
			}
		}
		return {
			width : w || this.getWidth(true),
			height : h || this.getHeight(true)
		};

	};

	/**
	 * 得到clientHeight和clientWidth信息给成的对象{width,height}
	 * 
	 * @return {Object} {width: clientWidth, height: clientHeight}
	 */
	L5.Element.prototype.getViewSize = function() {
		var d = this.dom, doc = document, aw = 0, ah = 0;
		if (d == doc || d == doc.body) {
			return {
				width : D.getViewWidth(),
				height : D.getViewHeight()
			};
		} else {
			return {
				width : d.clientWidth,
				height : d.clientHeight
			};
		}
	};

	/**
	 * 为鼠标移入移出事件添加和移除css类
	 * 
	 * @param {String}
	 *            className
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.addClassOnOver = function(className) {
		this.hover(function() {
			L5.fly(this, '_internal').addClass(className);
		}, function() {
			L5.fly(this, '_internal').removeClass(className);
		});
		return this;
	};

	/**
	 * 为得到和失去焦点添加和移除css类
	 * 
	 * @param {String}
	 *            className
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.addClassOnFocus = function(className) {
		this.on("focus", function() {
			L5.fly(this, '_internal').addClass(className);
		}, this.dom);
		this.on("blur", function() {
			L5.fly(this, '_internal').removeClass(className);
		}, this.dom);
		return this;
	};
	/**
	 * 为点击事件添加和移除css类 (a click effect)
	 * 
	 * @param {String}
	 *            className
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.addClassOnClick = function(className) {
		var dom = this.dom;
		this.on("mousedown", function() {
			L5.fly(dom, '_internal').addClass(className);
			var d = L5.getDoc();
			var fn = function() {
				L5.fly(dom, '_internal').removeClass(className);
				d.removeListener("mouseup", fn);
			};
			d.on("mouseup", fn);
		});
		return this;
	};
	/**
	 * 得到计算过的高度,得到offsetHeight或css中定义的height值之一,如果使用了padding/borders,也会计算进去
	 * Returns either the offsetHeight or the height of this element based on
	 * CSS height adjusted by padding or borders when needed to simulate
	 * offsetHeight when offsets aren't available. This may not work on
	 * display:none elements if a height has not been set using CSS.
	 * 
	 * @return {Number}
	 */
	L5.Element.prototype.getComputedHeight = function() {
		var h = Math.max(this.dom.offsetHeight, this.dom.clientHeight);
		if (!h) {
			h = parseInt(this.getStyle('height'), 10) || 0;
			if (!this.isBorderBox()) {
				h += this.getFrameWidth('tb');
			}
		}
		return h;
	};

	/**
	 * Returns either the offsetWidth or the width of this element based on CSS
	 * width adjusted by padding or borders when needed to simulate offsetWidth
	 * when offsets aren't available. This may not work on display:none elements
	 * if a width has not been set using CSS.
	 * 
	 * @return {Number}
	 */
	L5.Element.prototype.getComputedWidth = function() {
		var w = Math.max(this.dom.offsetWidth, this.dom.clientWidth);
		if (!w) {
			w = parseInt(this.getStyle('width'), 10) || 0;
			if (!this.isBorderBox()) {
				w += this.getFrameWidth('lr');
			}
		}
		return w;
	};
	/**
	 * Returns the sum width of the padding and borders for the passed "sides".
	 * See getBorderWidth() for more information about the sides.
	 * 
	 * 得到sides定义的border宽度和padding定义的宽度之和
	 * 
	 * @param {String}
	 *            sides
	 * @return {Number}
	 */
	L5.Element.prototype.getFrameWidth = function(sides, onlyContentBox) {
		return onlyContentBox && L5.isBorderBox ? 0
				: (this.getPadding(sides) + this.getBorderWidth(sides));
	};
	/**
	 * 设置元素的大小尺寸。如果动画效果被打开，高度和宽度都会产生动画变化效果。
	 * 
	 * @param {Number}
	 *            width 新宽度
	 * @param {Number}
	 *            height 新高度
	 * @param {Boolean/Object}
	 *            animate (optional) true表示为默认动画，或一个标准元素动画配置的对象。
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setSize = function(width, height, animate) {
		if (typeof width == "object") { // in case of object from getSize()
			height = width.height;
			width = width.width;
		}
		width = this.adjustWidth(width);
		height = this.adjustHeight(height);
		if (!animate || !A) {
			this.dom.style.width = this.addUnits(width);
			this.dom.style.height = this.addUnits(height);
		} else {
			this.anim({
				width : {
					to : width
				},
				height : {
					to : height
				}
			}, this.preanim(arguments, 2));
		}
		return this;
	};
	// private
	L5.Element.prototype.adjustWidth = function(width) {
		if (typeof width == "number") {
			if (this.autoBoxAdjust && !this.isBorderBox()) {
				width -= (this.getBorderWidth("lr") + this.getPadding("lr"));
			}
			if (width < 0) {
				width = 0;
			}
		}
		return width;
	};

	// private
	L5.Element.prototype.adjustHeight = function(height) {
		if (typeof height == "number") {
			if (this.autoBoxAdjust && !this.isBorderBox()) {
				height -= (this.getBorderWidth("tb") + this.getPadding("tb"));
			}
			if (height < 0) {
				height = 0;
			}
		}
		return height;
	};

	/**
	 * 设置元素的宽度
	 * 
	 * @param {Number}
	 *            width 新宽度
	 * @param {Boolean/Object}
	 *            animate (optional) true表示为默认动画，或一个标准元素动画配置的对象。
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setWidth = function(width, animate) {
		width = this.adjustWidth(width);
		if (!animate || !A) {
			this.dom.style.width = this.addUnits(width);
		} else {
			this.anim({
				width : {
					to : width
				}
			}, this.preanim(arguments, 1));
		}
		return this;
	};

	/**
	 * 设置元素的高度
	 * 
	 * @param {Number}
	 *            height 新高度
	 * @param {Boolean/Object}
	 *            animate (optional) true表示为默认动画，或一个标准元素动画配置的对象。
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setHeight = function(height, animate) {
		height = this.adjustHeight(height);
		if (!animate || !A) {
			this.dom.style.height = this.addUnits(height);
		} else {
			this.anim({
				height : {
					to : height
				}
			}, this.preanim(arguments, 1));
		}
		return this;
	};
	/**
	 * Store the current overflow setting and clip overflow on the element - use
	 * {@link #unclip} to remove 裁剪溢出部分,用unclip()恢复
	 * 
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.clip = function() {
		if (!this.isClipped) {
			this.isClipped = true;
			this.originalClip = {
				"o" : this.getStyle("overflow"),
				"x" : this.getStyle("overflow-x"),
				"y" : this.getStyle("overflow-y")
			};
			this.setStyle("overflow", "hidden");
			this.setStyle("overflow-x", "hidden");
			this.setStyle("overflow-y", "hidden");
		}
		return this;
	};
	/**
	 * Return clipping (overflow) to original clipping before clip() was called
	 * 
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.unclip = function() {
		if (this.isClipped) {
			this.isClipped = false;
			var o = this.originalClip;
			if (o.o) {
				this.setStyle("overflow", o.o);
			}
			if (o.x) {
				this.setStyle("overflow-x", o.x);
			}
			if (o.y) {
				this.setStyle("overflow-y", o.y);
			}
		}
		return this;
	};

	/**
	 * Gets the width of the border(s) for the specified side(s)
	 * 得到side指定的边框之和,side可以是t, l, r,
	 * b或他们的任意组合,比如getBorderWidth("lr")就是得到左边框和右边框之和
	 * 
	 * @param {String}
	 *            side Can be t, l, r, b or any combination of those to add
	 *            multiple values. For example, passing lr would get the border
	 *            (l)eft width + the border (r)ight width.
	 * @return {Number} The width of the sides passed added together
	 */
	L5.Element.prototype.getBorderWidth = function(side) {
		return this.addStyles(side, borders);
	};

	/**
	 * Gets the width of the padding(s) for the specified side(s)
	 * 得到由side指定的padding之和
	 * 
	 * @param {String}
	 *            side Can be t, l, r, b or any combination of those to add
	 *            multiple values. For example, passing lr would get the padding
	 *            (l)eft + the padding (r)ight.
	 * @return {Number} The padding of the sides passed added together
	 */
	L5.Element.prototype.getPadding = function(side) {
		return this.addStyles(side, paddings);
	};

	/**
	 * Returns the offset height of the element 返回元素的offsetHeight
	 * 
	 * @param {Boolean}
	 *            contentHeight (optional) true to get the height minus borders
	 *            and padding
	 * @return {Number} The element's height
	 */
	L5.Element.prototype.getHeight = function(contentHeight) {
		var h = this.dom.offsetHeight || 0;
		h = contentHeight !== true ? h : h - this.getBorderWidth("tb")
				- this.getPadding("tb");
		return h < 0 ? 0 : h;
	};

	/**
	 * Returns the offset width of the element
	 * 
	 * @param {Boolean}
	 *            contentWidth (optional) true to get the width minus borders
	 *            and padding
	 * @return {Number} The element's width
	 */
	L5.Element.prototype.getWidth = function(contentWidth) {
		var w = this.dom.offsetWidth || 0;
		w = contentWidth !== true ? w : w - this.getBorderWidth("lr")
				- this.getPadding("lr");
		return w < 0 ? 0 : w;
	};
	/**
	 * Clears any opacity settings from this element. Required in some cases for
	 * IE. 清除当前元素样式中不通用元素,清除ie中的filter,清除FF中的opacity/-moz-opacity/-khtml-opacity
	 * 
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.clearOpacity = function() {
		if (window.ActiveXObject) {
			if (typeof this.dom.style.filter == 'string'
					&& (/alpha/i).test(this.dom.style.filter)) {
				this.dom.style.filter = "";
			}
		} else {
			this.dom.style.opacity = "";
			this.dom.style["-moz-opacity"] = "";
			this.dom.style["-khtml-opacity"] = "";
		}
		return this;
	};
	/**
	 * Set the opacity of the element 设置透明度，opacity为1完全不透明,0完全透明
	 * 
	 * @param {Float}
	 *            opacity The new opacity. 0 = transparent, .5 = 50% visibile, 1 =
	 *            fully visible, etc
	 * @param {Boolean/Object}
	 *            animate (optional) true for the default animation or a
	 *            standard Element animation config object
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setOpacity = function(opacity, animate) {
		if (!animate || !A) {
			var s = this.dom.style;
			if (L5.isIE) {
				s.zoom = 1;
				s.filter = (s.filter || '').replace(/alpha\([^\)]*\)/gi, "")
						+ (opacity == 1 ? "" : " alpha(opacity=" + opacity
								* 100 + ")");
			} else {
				s.opacity = opacity;
			}
		} else {
			this.anim({
				opacity : {
					to : opacity
				}
			}, this.preanim(arguments, 1), null, .35, 'easeIn');
		}
		return this;
	};
	/**
	 * Return the CSS color for the specified CSS attribute. rgb, 3 digit (like
	 * #fff) and valid values are convert to standard 6 digit hex color.
	 * 得到当前元素指定attr的颜色值,如果没指定,返回defualtValue,比较郁闷的是明明不是void为什么api中批示是一个void?应该是个字符串
	 * 
	 * @param {String}
	 *            attr The css attribute
	 * @param {String}
	 *            defaultValue The default value to use when a valid color isn't
	 *            found
	 * @param {String}
	 *            prefix (optional) defaults to #. Use an empty string when
	 *            working with color anims.
	 */
	L5.Element.prototype.getColor = function(attr, defaultValue, prefix) {
		var v = this.getStyle(attr);
		if (!v || v == "transparent" || v == "inherit") {
			return defaultValue;
		}
		var color = typeof prefix == "undefined" ? "#" : prefix;
		if (v.substr(0, 4) == "rgb(") {
			var rvs = v.slice(4, v.length - 1).split(",");
			for ( var i = 0; i < 3; i++) {
				var h = parseInt(rvs[i]);
				var s = h.toString(16);
				if (h < 16) {
					s = "0" + s;
				}
				color += s;
			}
		} else {
			if (v.substr(0, 1) == "#") {
				if (v.length == 4) {
					for ( var i = 1; i < 4; i++) {
						var c = v.charAt(i);
						color += c + c;
					}
				} else if (v.length == 7) {
					color += v.substr(1);
				}
			}
		}
		return (color.length > 5 ? color.toLowerCase() : defaultValue);
	};

	/**
	 * 用一个指定样式class的div将当前元素包含起来,class默认值为x-box Wraps the specified element with
	 * a special markup/CSS block that renders by default as a gray container
	 * with a gradient background, rounded corners and a 4-way shadow. Example
	 * usage:
	 * 
	 * <pre><code>
	 * // Basic box wrap
	 * L5.get(&quot;foo&quot;).boxWrap();
	 * 
	 * // You can also add a custom class and use CSS inheritance rules to customize the box look.
	 * // 'l-box-blue' is a built-in alternative -- look at the related CSS definitions as an example
	 * // for how to create a custom box wrap style.
	 * L5.get(&quot;foo&quot;).boxWrap().addClass(&quot;l-box-blue&quot;);
	 * </pre></code>
	 * 
	 * @param {String}
	 *            class (optional) A base CSS class to apply to the containing
	 *            wrapper element (defaults to 'l-box'). Note that there are a
	 *            number of CSS rules that are dependent on this name to make
	 *            the overall effect work, so if you supply an alternate base
	 *            class, make sure you also supply all of the necessary rules.
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.boxWrap = function(cls) {
		cls = cls || 'l-box';
		var el = L5.get(this.insertHtml('beforeBegin', String.format(
				'<div class="{0}">' + El.boxMarkup + '</div>', cls)));
		el.child('.' + cls + '-mc').dom.appendChild(this.dom);
		return el;
	};

	/**
	 * 自适应高度,参数都是老相识了,惟一需要注意的是这个方法使用了setTimeout,高度不会马上变更
	 * <p>
	 * Measures the element's content height and updates height to match. Note:
	 * this function uses setTimeout so the new height may not be available
	 * immediately.
	 * 
	 * @param {Boolean}
	 *            animate (optional) Animate the transition (defaults to false)
	 * @param {Float}
	 *            duration (optional) Length of the animation in seconds
	 *            (defaults to .35)
	 * @param {Function}
	 *            onComplete (optional) Function to call when animation
	 *            completes
	 * @param {String}
	 *            easing (optional) Easing method to use (defaults to easeOut)
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.autoHeight = function(animate, duration, onComplete,
			easing) {
		var oldHeight = this.getHeight();
		this.clip();
		this.setHeight(1); // force clipping
		setTimeout(function() {
			var height = parseInt(this.dom.scrollHeight, 10); // parseInt
			// for
			// Safari
			if (!animate) {
				this.setHeight(height);
				this.unclip();
				if (typeof onComplete == "function") {
					onComplete();
				}
			} else {
				this.setHeight(oldHeight); // restore original height
				this.setHeight(height, animate, duration, function() {
					this.unclip();
					if (typeof onComplete == "function")
						onComplete();
				}.createDelegate(this), easing);
			}
		}.createDelegate(this), 0);
		return this;
	};

	/**
	 * 强制设定某个El对象是false，为它增加红色边框（主要应用在input标签，也可以用到table和grid中）
	 * 
	 * @param{String} qtitle 设置quickTips的title
	 * @param{String} qtip 设置quickTips的错误内容体
	 */
	L5.Element.prototype.setElFalseStyle = function(qtitle, qtip) {
		if (this.dom.nodeName == "TD" || this.dom.nodeName == "td") {
			this.setStyle("border", "1px solid #FA8072");// grid中边界变宽且增加红色
		} else {
			this.setStyle("border-color", "#FA8072");// 正常情况只是增加红色（对select下拉框无效）
		}
		this.dom.setAttribute("L5:qtitle", qtitle);// 设置quicktipsde title
		this.dom.setAttribute("L5:qtip", qtip);// 设置quicktipsde错误内容体
	};

	/**
	 * 强制设定某个El对象是true，将红色边框去掉，同时移除quickTips提示
	 */
	L5.Element.prototype.setElTrueStyle = function() {
		if (this.dom.nodeName == "TD" || this.dom.nodeName == "td") {
			this.setStyle("border", "");// 针对grid的
		} else {
			this.setStyle("border-color", "");// 普通的标签
		}
		this.dom.removeAttribute("L5:qtitle");// 移除quicktipsde title
		this.dom.removeAttribute("L5:qtip");// 移除quicktipsde错误内容体
	};

	/**
	 * 设置样式属性：overflow
	 * 
	 * @param {String}
	 *            v
	 */
	L5.Element.prototype.setOverflow = function(v) {
		if (v == 'auto' && L5.isMac && L5.isGecko2) { // work around
			// stupid FF 2.0/Mac
			// scroll bar bug
			this.dom.style.overflow = 'hidden';
			(function() {
				this.dom.style.overflow = 'auto';
			}).defer(1, this);
		} else {
			this.dom.style.overflow = v;
		}
	};
})();