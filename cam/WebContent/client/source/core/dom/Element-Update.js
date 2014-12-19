(function() {
	var El = L5.Element;
	/**
	 * 增加传入的元素至该元素
	 * 
	 * @param {String/HTMLElement/Array/Element/CompositeElement}
	 *            el
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.appendChild = function(el) {
		el = L5.get(el);
		el.appendTo(this);
		return this;
	};

	/**
	 * 创建传入的 DomHelper 配置 并且 将其增加至该元素中 或者
	 * 选择将其插入到传入的子元素之前.
	 * 
	 * @param {Object}
	 *            config DomHelper 元素配置对象.若没有指定标签
	 *            (例如., {tag:'input'}) 则会自动产生一个具有指定属性的 div .
	 * @param {HTMLElement}
	 *            insertBefore (可选) 当前元素的子元素
	 * @param {Boolean}
	 *            returnDom (可选) 值为true表示返回dom 节点，而不是创建一个元素
	 * @return {L5.Element} 新的子元素
	 */
	L5.Element.prototype.createChild = function(config, insertBefore, returnDom) {
		config = config || {
			tag : 'div'
		};
		if (insertBefore) {
			return L5.DomHelper.insertBefore(insertBefore, config,
					returnDom !== true);
		}
		return L5.DomHelper[!this.dom.firstChild ? 'overwrite' : 'append'](
				this.dom, config, returnDom !== true);
	};

	/**
	 * 增加元素至传入的元素
	 * 
	 * @param {Mixed}
	 *            el 新的父元素
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.appendTo = function(el) {
		el = L5.getDom(el);
		el.appendChild(this.dom);
		return this;
	};

	/**
	 * 在DOM中在传入元素之前插入该元素
	 * 
	 * @param {Mixed}
	 *            el 在el之前插入当前元素
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.insertBefore = function(el) {
		el = L5.getDom(el);
		el.parentNode.insertBefore(this.dom, el);
		return this;
	};

	/**
	 * 在DOM中，在传入的元素之后插入当前元素
	 * 
	 * @param {Mixed}
	 *            el 在el之后插入当前元素
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.insertAfter = function(el) {
		el = L5.getDom(el);
		el.parentNode.insertBefore(this.dom, el.nextSibling);
		return this;
	};

	/**
	 * 增加 (或 创建) 一个作为当前元素的第一个子元素的元素(或 DomHelper 配置对象) 
	 * 
	 * @param {Mixed/Object}
	 *            el 增加的 id 或者 元素 或 创建和增加的DomHelper 配置对象
	 * @return {L5.Element} 新的子元素
	 */
	L5.Element.prototype.insertFirst = function(el, returnDom) {
		el = el || {};
		if (typeof el == 'object' && !el.nodeType && !el.dom) { // dh config
			return this.createChild(el, this.dom.firstChild, returnDom);
		} else {
			el = L5.getDom(el);
			this.dom.insertBefore(el, this.dom.firstChild);
			return !returnDom ? L5.get(el) : el;
		}
	};

	/**
	 * 增加(或 创建)传入的元素 (或 DomHelper 配置对象) 作为当前元素的兄弟元素
	 * 
	 * @param {Mixed/Object/Array}
	 *            el 增加的id, 元素， 或者创建和增加的 DomHelper 配置对象， 或者包含两者的数组.
	 * @param {String}
	 *            where (可选) 'before' 或者 'after' ，默认为 before
	 * @param {Boolean}
	 *            returnDom (可选) 值为True表示返回原始的 DOM 元素
	 *            而不是L5.Element
	 * @return {L5.Element} 增加的元素
	 */
	L5.Element.prototype.insertSibling = function(el, where, returnDom) {
		var rt;
		if (L5.isArray(el)) {
			for ( var i = 0, len = el.length; i < len; i++) {
				rt = this.insertSibling(el[i], where, returnDom);
			}
			return rt;
		}
		where = where ? where.toLowerCase() : 'before';
		el = el || {};
		var refNode = where == 'before' ? this.dom : this.dom.nextSibling;

		if (typeof el == 'object' && !el.nodeType && !el.dom) { // dh config
			if (where == 'after' && !this.dom.nextSibling) {
				rt = L5.DomHelper.append(this.dom.parentNode, el, !returnDom);
			} else {
				rt = L5.DomHelper[where == 'after' ? 'insertAfter'
						: 'insertBefore'](this.dom, el, !returnDom);
			}

		} else {
			rt = this.dom.parentNode.insertBefore(L5.getDom(el), refNode);
			if (!returnDom) {
				rt = L5.get(rt);
			}
		}
		return rt;
	};

	/**
	 * 用另一个元素来创建和包装当前元素
	 * 
	 * @param {Object}
	 *            config (可选) 包装元素的DomHelper元素配置对象或对空div而言为 null 
	 * @param {Boolean}
	 *            returnDom (可选) 值为True 表示返回原始的 DOM 元素
	 *            而不是 L5.Element
	 * @return {HTMLElement/Element} 新创建的包装元素
	 */
	L5.Element.prototype.wrap = function(config, returnDom) {
		if (!config) {
			config = {
				tag : "div"
			};
		}
		var newEl = L5.DomHelper.insertBefore(this.dom, config, !returnDom);
		newEl.dom ? newEl.dom.appendChild(this.dom) : newEl
				.appendChild(this.dom);
		return newEl;
	};

	/**
	 * 用当前元素来替换传入的元素
	 * 
	 * @param {Mixed}
	 *            el 被替换的元素
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.replace = function(el) {
		el = L5.get(el);
		this.insertBefore(el);
		el.remove();
		return this;
	};

	/**
	 * 用传入的元素来替换当前元素
	 * 
	 * @param {Mixed/Object}
	 *            el 新的元素，或者元素的DomHelper配置对象
	 * @return {L5.Element} this
	 */
	L5.Element.prototype.replaceWith = function(el) {
		if (typeof el == 'object' && !el.nodeType && !el.dom) { // dh config
			el = this.insertSibling(el, 'before');
		} else {
			el = L5.getDom(el);
			this.dom.parentNode.insertBefore(el, this.dom);
		}
		El.uncache(this.id);
		L5.removeNode(this.dom);
		this.dom = el;
		this.id = L5.id(el);
		El.cache[this.id] = this;
		return this;
	};

	/**
	 * 插入 html 片段 到当前元素
	 * 
	 * @param {String}
	 *            where 插入html片段到元素的位置—
	 *            beforeBegin, afterBegin, beforeEnd, afterEnd.
	 * @param {String}
	 *            html  HTML 片段
	 * @param {Boolean}
	 *            returnEl (可选) 值为True表示返回L5.Element (默认为
	 *            false)
	 * @return {HTMLElement/L5.Element} 被插入的节点 (or nearest related if
	 *         more than 1 inserted)
	 */
	L5.Element.prototype.insertHtml = function(where, html, returnEl) {
		var el = L5.DomHelper.insertHtml(where, this.dom, html);
		return returnEl ? L5.get(el) : el;
	};
})();