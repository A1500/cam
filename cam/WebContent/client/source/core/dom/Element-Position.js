(function() {
	var D = L5.lib.Dom;
	var A = L5.lib.Anim;
	/**
	 * 获取元素的基于页面坐标的当前X位置.
	 * Element 必须为拥有页面坐标的DOM树的一部分
	 * (display:none 或者 没有添加的元素 return false).
	 * 
	 * @return {Number} 元素的X位置
	 */
	L5.Element.prototype.getX = function() {
		return D.getX(this.dom);
	};

	/**
	 * 获取元素的基于页面坐标的当前Y位置.
	 * Element 必须为拥有页面坐标的DOM树的一部分
	 * (display:none 或者 没有添加的元素 return false).
	 * 
	 * @return {Number} 元素的Y位置
	 */
	L5.Element.prototype.getY = function() {
		return D.getY(this.dom);
	};

	/**
	 * 获取元素的基于页面坐标的当前位置.
	 * Element 必须为拥有页面坐标的DOM树的一部分
	 * (display:none 或者 没有添加的元素 return false).
	 * 
	 * @return {Array} 元素的X，Y位置
	 */
	L5.Element.prototype.getXY = function() {
		return D.getXY(this.dom);
	};

	/**
	 * 获取元素对于传递的参数元素的偏移量. 两个元素都必须为DOM 树的一部分， display:none 没有页面坐标.
	 * 
	 * @param {Mixed}
	 *            element 获取偏移量的来源元素.
	 * @return {Array} XY 页面偏移量 (e.g. [100, -200])
	 */
	L5.Element.prototype.getOffsetsTo = function(el) {
		var o = this.getXY();
		var e = L5.fly(el, '_internal').getXY();
		return [ o[0] - e[0], o[1] - e[1] ];
	};

	/**
	 * 设置元素的基于页面坐标的X位置. 元素必须为拥有页面坐标的DOM树的一部分 (display:none 或者
	 * 没有添加的元素 return false).
	 * 
	 * @param {Number} x
	 *             元素的X位置
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者 一个标准元素动画的配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setX = function(x, animate) {
		if (!animate || !A) {
			D.setX(this.dom, x);
		} else {
			this.setXY([ x, this.getY() ], this.preanim(arguments, 1));
		}
		return this;
	};

	/**
	 * 设置元素的基于页面坐标的Y位置. 元素
	 * 必须为拥有页面坐标的DOM树的一部分 (display:none 或者
	 * 没有添加的元素 return false).
	 * 
	 * @param {Number} y
	 *            元素的Y位置
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者 一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setY = function(y, animate) {
		if (!animate || !A) {
			D.setY(this.dom, y);
		} else {
			this.setXY([ this.getX(), y ], this.preanim(arguments, 1));
		}
		return this;
	};

	/**
	 * 直接使用 CSS 样式来设置元素的左侧位置(代替
	 * {@link #setX}).
	 * 
	 * @param {String}
	 *            left 左侧CSS 属性值
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setLeft = function(left) {
		this.setStyle("left", this.addUnits(left));
		return this;
	};

	/**
	 * 直接使用 CSS 样式来设置元素的顶部位置 (代替
	 * {@link #setY}).
	 * 
	 * @param {String}
	 *            top 顶部 CSS 属性值
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setTop = function(top) {
		this.setStyle("top", this.addUnits(top));
		return this;
	};

	/**
	 * 设置元素的右侧CSS 样式.
	 * 
	 * @param {String}
	 *            right 右侧CSS 属性
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setRight = function(right) {
		this.setStyle("right", this.addUnits(right));
		return this;
	};

	/**
	 * 设置元素的底部 CSS 样式.
	 * 
	 * @param {String}
	 *            bottom 底部 CSS 样式
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setBottom = function(bottom) {
		this.setStyle("bottom", this.addUnits(bottom));
		return this;
	};

	/**
	 * 设置元素在页面坐标中的位置,不管元素处于什么位置. 元素必须为拥有页面坐标的DOM树的一部分 (display:none 或者 没有添加元素 return
	 * false).
	 * 
	 * @param {Array}
	 *            pos 包含 X & Y [x, y] 的新的位置(坐标都是基于页面的)
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setXY = function(pos, animate) {
		if (!animate || !A) {
			D.setXY(this.dom, pos);
		} else {
			this.anim({
				points : {
					to : pos
				}
			}, this.preanim(arguments, 1), 'motion');
		}
		return this;
	};

	/**
	 * 设置元素在页面坐标中的位置,不管元素处于什么位置. 元素必须为拥有页面坐标的DOM树的一部分 (display:none 或者 没有添加元素 return
	 * false).
	 * 
	 * @param {Number}
	 *            x 新位置的X值 (基于页面的坐标)
	 * @param {Number}
	 *            y 新位置的Y值 (基于页面的坐标)
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setLocation = function(x, y, animate) {
		this.setXY([ x, y ], this.preanim(arguments, 2));
		return this;
	};

	/**
	 * 获取左侧X的坐标
	 * 
	 * @param {Boolean}
	 *            local 值为True表示获取局部css位置，而不是页面坐标
	 * @return {Number}
	 */
	L5.Element.prototype.getLeft = function(local) {
		if (!local) {
			return this.getX();
		} else {
			return parseInt(this.getStyle("left"), 10) || 0;
		}
	};

	/**
	 * 获取元素的右侧X坐标 (元素的 X 位置 + 元素的
	 * 宽度)
	 * 
	 * @param {Boolean}
	 *            local 值为True表示获取局部css位置，而不是页面坐标
	 * @return {Number}
	 */
	L5.Element.prototype.getRight = function(local) {
		if (!local) {
			return this.getX() + this.getWidth();
		} else {
			return (this.getLeft(true) + this.getWidth()) || 0;
		}
	};

	/**
	 * 获取顶部Y坐标
	 * 
	 * @param {Boolean}
	 *            local 值为True表示获取局部css位置，而不是页面坐标
	 * @return {Number}
	 */
	L5.Element.prototype.getTop = function(local) {
		if (!local) {
			return this.getY();
		} else {
			return parseInt(this.getStyle("top"), 10) || 0;
		}
	};

	/**
	 * 获取元素的底部Y坐标 (元素的 Y 位置 + 元素的
	 * 高度)
	 * 
	 * @param {Boolean}
	 *            local 值为True表示获取局部css位置，而不是页面坐标
	 * @return {Number}
	 */
	L5.Element.prototype.getBottom = function(local) {
		if (!local) {
			return this.getY() + this.getHeight();
		} else {
			return (this.getTop(true) + this.getHeight()) || 0;
		}
	};

	/**
	 * 初始化元素的定位. 若预设的位置没有作为参数传递, 则使用relative .
	 * 
	 * @param {String}
	 *            pos (可选) 定位 "relative", "absolute" 或者
	 *            "fixed"
	 * @param {Number}
	 *            zIndex (可选) 应用的 zIndex 
	 * @param {Number}
	 *            x (可选) 设置页面的 X 位置
	 * @param {Number}
	 *            y (可选) 设置页面的 Y 位置
	 */
	L5.Element.prototype.position = function(pos, zIndex, x, y) {
		if (!pos) {
			if (this.getStyle('position') == 'static') {
				this.setStyle('position', 'relative');
			}
		} else {
			this.setStyle("position", pos);
		}
		if (zIndex) {
			this.setStyle("z-index", zIndex);
		}
		if (x !== undefined && y !== undefined) {
			this.setXY([ x, y ]);
		} else if (x !== undefined) {
			this.setX(x);
		} else if (y !== undefined) {
			this.setY(y);
		}
	};

	/**
	 * 在document 被加载时还原位置为默认值
	 * 
	 * @param {String}
	 *            value (可选) 值可以为
	 *            left,right,top,bottom, 默认为 '' (空字符串). 
	 *            也可为 'auto'.
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.clearPositioning = function(value) {
		value = value || '';
		this.setStyle({
			"left" : value,
			"right" : value,
			"top" : value,
			"bottom" : value,
			"z-index" : "",
			"position" : "static"
		});
		return this;
	};

	/**
	 * 获得具有所有 CSS 位置属性的对象. 与
	 * setPostioning 一起使用可以在执行更新操作之前获得 snapshot ,然后还原属性.
	 * 
	 * @return {Object}
	 */
	L5.Element.prototype.getPositioning = function() {
		var l = this.getStyle("left");
		var t = this.getStyle("top");
		return {
			"position" : this.getStyle("position"),
			"left" : l,
			"right" : l ? "" : this.getStyle("right"),
			"top" : t,
			"bottom" : t ? "" : this.getStyle("bottom"),
			"z-index" : this.getStyle("z-index")
		};
	};

	/**
	 * 设置元素在页面坐标中的位置,不管元素处于什么位置. 元素必须为拥有页面坐标的DOM树的一部分 (display:none 或者 没有添加元素 return
	 * false).
	 * 
	 * @param {Number}
	 *            x 新位置的X 值(基于页面的坐标)
	 * @param {Number}
	 *            y 新位置的Y 值 (基于页面的坐标)
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.moveTo = function(x, y, animate) {
		this.setXY([ x, y ], this.preanim(arguments, 2));
		return this;
	};

	/**
	 * 转换传入的页面坐标为 left/top css 值
	 * 
	 * @param {Number/Array}
	 *            x 页面 x 或者 包含 [x, y]的数组
	 * @param {Number}
	 *            y (可选) 页面 y, 不是数组时该值是必须的
	 * @return {Object} 具有左侧和顶部属性的对象. 例如. {left:
	 *         (value), top: (value)}
	 */
	L5.Element.prototype.translatePoints = function(x, y) {
		if (typeof x == 'object' || L5.isArray(x)) {
			y = x[1];
			x = x[0];
		}
		var p = this.getStyle('position');
		var o = this.getXY();

		var l = parseInt(this.getStyle('left'), 10);
		var t = parseInt(this.getStyle('top'), 10);

		if (isNaN(l)) {
			l = (p == "relative") ? 0 : this.dom.offsetLeft;
		}
		if (isNaN(t)) {
			t = (p == "relative") ? 0 : this.dom.offsetTop;
		}

		return {
			left : (x - o[0] + l),
			top : (y - o[1] + t)
		};
	};
	/**
	 * 快速设置左侧和顶部， 增加默认的单元
	 * 
	 * @param {String}
	 *            left 左侧 CSS 属性值
	 * @param {String}
	 *            top 顶部 CSS 属性值
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setLeftTop = function(left, top) {
		this.dom.style.left = this.addUnits(left);
		this.dom.style.top = this.addUnits(top);
		return this;
	};

	/**
	 * 获取 {x, y, width, height}的盒子模型 ，可以被用于设置另一个
	 * 元素的 大小/位置.
	 * 
	 * @param {Boolean}
	 *            contentBox (可选) 值为true表示元素的内容箱被返回.
	 * @param {Boolean}
	 *            local (可选) 值为true表示元素的左侧和顶部值被返回，而不是页面的 x/y.
	 * @return {Object} box 格式为 {x, y, width, height}的对象
	 */
	L5.Element.prototype.getBox = function(contentBox, local) {
		var xy;
		if (!local) {
			xy = this.getXY();
		} else {
			var left = parseInt(this.getStyle("left"), 10) || 0;
			var top = parseInt(this.getStyle("top"), 10) || 0;
			xy = [ left, top ];
		}
		var el = this.dom, w = el.offsetWidth, h = el.offsetHeight, bx;
		if (!contentBox) {
			bx = {
				x : xy[0],
				y : xy[1],
				0 : xy[0],
				1 : xy[1],
				width : w,
				height : h
			};
		} else {
			var l = this.getBorderWidth("l") + this.getPadding("l");
			var r = this.getBorderWidth("r") + this.getPadding("r");
			var t = this.getBorderWidth("t") + this.getPadding("t");
			var b = this.getBorderWidth("b") + this.getPadding("b");
			bx = {
				x : xy[0] + l,
				y : xy[1] + t,
				0 : xy[0] + l,
				1 : xy[1] + t,
				width : w - (l + r),
				height : h - (t + b)
			};
		}
		bx.right = bx.x + bx.width;
		bx.bottom = bx.y + bx.height;
		return bx;
	};

	/**
	 * 设置元素的盒子模型对象. 在其他元素上使用 getBox() 可以获得盒子模型对象.
	 * 若animate 值为true 则 width, height, x 和 y 将同时产生动画.
	 * 
	 * @param {Object}
	 *            box 盒子模型 {x, y, width, height}
	 * @param {Boolean}
	 *            adjust (可选) 是否自动调整盒子模型
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setBox = function(box, adjust, animate) {
		var w = box.width, h = box.height;
		if ((adjust && !this.autoBoxAdjust) && !this.isBorderBox()) {
			w -= (this.getBorderWidth("lr") + this.getPadding("lr"));
			h -= (this.getBorderWidth("tb") + this.getPadding("tb"));
		}
		this.setBounds(box.x, box.y, w, h, this.preanim(arguments, 2));
		return this;
	};

	/**
	 * 获取给定元素的区域.元素必须为拥有区域的DOM树的一部分 (display:none 或者没有添加元素 return
	 * false).
	 * 
	 * @return {Region} 一个 L5.lib.Region对象包含 "top, left, bottom, right"
	 *         成员数据.
	 */
	L5.Element.prototype.getRegion = function() {
		return D.getRegion(this.dom);
	};

	/**
	 * 设置元素的位置和大小.若animation值为true
	 * 则 width, height, x 和 y 将同时产生动画.
	 * 
	 * @param {Number}
	 *            x 新位置的X 值 (基于页面的坐标)
	 * @param {Number}
	 *            y 新位置的Y值 (基于页面的坐标)
	 * @param {Number}
	 *            width 新的宽度值
	 * @param {Number}
	 *            height 新的高度值
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setBounds = function(x, y, width, height, animate) {
		if (!animate || !A) {
			this.setSize(width, height);
			this.setLocation(x, y);
		} else {
			width = this.adjustWidth(width);
			height = this.adjustHeight(height);
			this.anim({
				points : {
					to : [ x, y ]
				},
				width : {
					to : width
				},
				height : {
					to : height
				}
			}, this.preanim(arguments, 4), 'motion');
		}
		return this;
	};

	/**
	 * 设置由getPositioning()返回对象的定位.
	 * 
	 * @param {Object}
	 *            posCfg
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setPositioning = function(pc) {
		this.applyStyles(pc);
		if (pc.right == "auto") {
			this.dom.style.right = "";
		}
		if (pc.bottom == "auto") {
			this.dom.style.bottom = "";
		}
		return this;
	};
	/**
	 * 设置指定区域的元素的位置和大小.若animation
	 * 值为true 则 width, height, x 和 y 将同时产生动画.
	 * 
	 * @param {L5.lib.Region}
	 *            region 填充的区域
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setRegion = function(region, animate) {
		this.setBounds(region.left, region.top, region.right - region.left,
				region.bottom - region.top, this.preanim(arguments, 1));
		return this;
	};

	/**
	 * 相对于其当前位置来移动元素.
	 * 
	 * @param {String}
	 *            direction 可用的值为: "l" (or "left"), "r" (or
	 *            "right"), "t" (or "top", or "up"), "b" (or "bottom", or
	 *            "down").
	 * @param {Number}
	 *            distance 移动元素的像素数
	 * @param {Boolean/Object}
	 *            animate (可选) 值为True 表示默认动画, 或者一个标准元素动画配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.move = function(direction, distance, animate) {
		var xy = this.getXY();
		direction = direction.toLowerCase();
		switch (direction) {
		case "l":
		case "left":
			this.moveTo(xy[0] - distance, xy[1], this.preanim(arguments, 2));
			break;
		case "r":
		case "right":
			this.moveTo(xy[0] + distance, xy[1], this.preanim(arguments, 2));
			break;
		case "t":
		case "top":
		case "up":
			this.moveTo(xy[0], xy[1] - distance, this.preanim(arguments, 2));
			break;
		case "b":
		case "bottom":
		case "down":
			this.moveTo(xy[0], xy[1] + distance, this.preanim(arguments, 2));
			break;
		}
		return this;
	};
})();