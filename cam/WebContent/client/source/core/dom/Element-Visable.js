/*
 * 元素的可视化设置
 */
(function() {
	var El = L5.Element;
	/**
	 * 可视性模型常量： - 使用 visibility 属性控制元素是否可见："visible"或"hidden"
	 * 
	 * @static
	 * @type Number
	 */
	L5.Element.VISIBILITY = 1;

	/**
	 * 可视性模型常量 - 使用 display 属性控制元素是否可见："none"或"hidden"
	 * 
	 * @static
	 * @type Number
	 */
	L5.Element.DISPLAY = 2;

	/**
	 * The element's default display mode (defaults to "")
	 * 
	 * @type String
	 */
	L5.Element.prototype.originalDisplay = "";

	/**
	 * 可视性模型，默认是1，采用visibility属性控制可视性
	 * 
	 * @type Number
	 */
	L5.Element.prototype.visibilityMode = 1;

	/**
	 * 设置采用哪一种可视性模型.
	 * 
	 * @param visMode
	 *            L5.Element.VISIBILITY 或者 L5.Element.DISPLAY
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setVisibilityMode = function(visMode) {
		this.visibilityMode = visMode;
		return this;
	};

	/**
	 * 设置元素的可见性
	 * 
	 * @param {Boolean}
	 *            visible 元素是否可见
	 * @param {Boolean/Object}
	 *            animate (optional)
	 * 
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setVisible = function(visible, animate) {
		if (!animate || !A) {
			if (this.visibilityMode == El.DISPLAY) {
				this.setDisplayed(visible);// 使用display
			} else {// 使用visibility
				this.fixDisplay();
				this.dom.style.visibility = visible ? "visible" : "hidden";
			}
		} else {
			// closure for composites
			var dom = this.dom;
			var visMode = this.visibilityMode;
			if (visible) {
				this.setOpacity(.01);
				this.setVisible(true);
			}
			this.anim({
				opacity : {
					to : (visible ? 1 : 0)
				}
			}, this.preanim(arguments, 1), null, .35, 'easeIn', function() {
				if (!visible) {
					if (visMode == El.DISPLAY) {
						dom.style.display = "none";
					} else {
						dom.style.visibility = "hidden";
					}
					L5.get(dom).setOpacity(1);
				}
			});
		}
		return this;
	};

	/**
	 * 元素是否可见；根据deep参数情况可以查看祖先元素是否是不可见的
	 * 
	 * @param {Boolean}
	 *            deep (optional) True 查看祖先节点是不是不可见的(defaults to false)
	 * 
	 * @return {Boolean}
	 */
	L5.Element.prototype.isVisible = function(deep) {
		var vis = !(this.getStyle("visibility") == "hidden" || this
				.getStyle("display") == "none");
		if (deep !== true || !vis) {
			return vis;
		}
		var p = this.dom.parentNode;
		while (p && p.tagName.toLowerCase() != "body") {
			if (!L5.fly(p, '_isVisible').isVisible()) {
				return false;
			}
			p = p.parentNode;
		}
		return true;
	};

	/**
	 * Toggles the element's visibility or display, depending on visibility
	 * mode.
	 * 
	 * @param {Boolean/Object}
	 *            animate (optional) True for the default animation, or a
	 *            standard Element animation config object
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.toggle = function(animate) {
		this.setVisible(!this.isVisible(), this.preanim(arguments, 0));
		return this;
	};

	/**
	 * 设置 display 属性.
	 * 
	 * @param {Mixed}
	 *            value
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.setDisplayed = function(value) {
		if (typeof value == "boolean") {
			value = value ? this.originalDisplay : "none";
		}
		this.setStyle("display", value);
		return this;
	};

	// private
	L5.Element.prototype.fixDisplay = function() {
		if (this.getStyle("display") == "none") {
			this.setStyle("visibility", "hidden");
			this.setStyle("display", this.originalDisplay); // first try
			// reverting to
			// default
			if (this.getStyle("display") == "none") { // if that fails,
				// default to block
				this.setStyle("display", "block");
			}
		}
	};

	/**
	 * 隐藏该元素
	 * 
	 * @param {Boolean/Object}
	 *            animate (optional)
	 * 
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.hide = function(animate) {
		this.setVisible(false, this.preanim(arguments, 0));
		return this;
	};

	/**
	 * 显示该元素
	 * 
	 * @param {Boolean/Object}
	 *            animate (optional)
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.show = function(animate) {
		this.setVisible(true, this.preanim(arguments, 0));
		return this;
	};

	/**
	 * 如果display属性不是none返回true
	 * 
	 * @return {Boolean}
	 */
	L5.Element.prototype.isDisplayed = function() {
		return this.getStyle("display") != "none";
	};

	/**
	 * 相当于： setVisibilityMode(Element.DISPLAY) ；使用display控制可见性
	 * 
	 * @param {String}
	 *            display (optional)
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.enableDisplayMode = function(display) {
		this.setVisibilityMode(El.DISPLAY);
		if (typeof display != "undefined")
			this.originalDisplay = display;
		return this;
	};
	/**
	 * 为当前对象创建蒙片 Puts a mask over this element to disable user interaction.
	 * Requires core.css. This method can only be applied to elements which
	 * accept child nodes.
	 * 
	 * @param {String}
	 *            msg (optional) A message to display in the mask
	 * @param {String}
	 *            msgCls (optional) A css class to apply to the msg element
	 * @return {Element} The mask element
	 */
	L5.Element.prototype.mask = function(msg, msgCls) {
		if (this.getStyle("position") == "static") {
			this.addClass("l-masked-relative");
		}
		if (this._maskMsg) {
			this._maskMsg.remove();
		}
		if (this._mask) {
			this._mask.remove();
		}

		this._mask = L5.DomHelper.append(this.dom, {
			cls : "L5-el-mask"
		}, true);

		this.addClass("l-masked");
		this._mask.setDisplayed(true);
		if (typeof msg == 'string') {
			this._maskMsg = L5.DomHelper.append(this.dom, {
				cls : "L5-el-mask-msg",
				cn : {
					tag : 'div'
				}
			}, true);
			var mm = this._maskMsg;
			mm.dom.className = msgCls ? "L5-el-mask-msg " + msgCls
					: "L5-el-mask-msg";
			mm.dom.firstChild.innerHTML = msg;
			mm.setDisplayed(true);
			mm.center(this);
		}
		if (L5.isIE && !(L5.isIE7 && L5.isStrict)
				&& this.getStyle('height') == 'auto') { // ie will not
			// expand full
			// height
			// automatically
			this._mask.setSize(this.getWidth(), this.getHeight());
		}
		return this._mask;
	};
	/**
	 * 移除蒙片
	 */
	L5.Element.prototype.unmask = function() {
		if (this._mask) {
			if (this._maskMsg) {
				this._maskMsg.remove();
				delete this._maskMsg;
			}
			this._mask.remove();
			delete this._mask;
		}
		this.removeClass([ "l-masked", "l-masked-relative" ]);
	};
	/**
	 * 判断是否有蒙片
	 * 
	 * @return {Boolean}
	 */
	L5.Element.prototype.isMasked = function() {
		return this._mask && this._mask.isVisible();
	};

	/**
	 * 在当前元素之前创建一个classname为ext-shim的iframe
	 * 
	 * @return {L5.Element}
	 */
	L5.Element.prototype.createShim = function() {
		var el = document.createElement('iframe');
		el.frameBorder = '0';
		el.className = 'L5-shim';
		if (L5.isIE && L5.isSecure) {
			el.src = L5.SSL_SECURE_URL;
		}
		var shim = L5.get(this.dom.parentNode.insertBefore(el, this.dom));
		shim.autoBoxAdjust = false;
		return shim;
	};
})();