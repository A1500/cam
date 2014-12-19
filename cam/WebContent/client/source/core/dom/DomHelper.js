/**
 * 操作DOM和Template的工具类，支持HTML片段或者DOM。<br>
 * 下面的例子是给id为'my-div'的元素添加没有排序的5个子元素:<br>
 * 
 * <pre><code>
 * var dh = L5.DomHelper;
 * var list = dh.append('my-div', {
 * 	id : 'my-ul',
 * 	tag : 'ul',
 * 	cls : 'my-list',
 * 	children : [ {
 * 		tag : 'li',
 * 		id : 'item0',
 * 		html : 'List Item 0'
 * 	}, {
 * 		tag : 'li',
 * 		id : 'item1',
 * 		html : 'List Item 1'
 * 	}, {
 * 		tag : 'li',
 * 		id : 'item2',
 * 		html : 'List Item 2'
 * 	}, {
 * 		tag : 'li',
 * 		id : 'item3',
 * 		html : 'List Item 3'
 * 	}, {
 * 		tag : 'li',
 * 		id : 'item4',
 * 		html : 'List Item 4'
 * 	} ]
 * });
 * </code></pre>
 * 
 * <p>
 * 以上例子中添加的元素也可以作为数组对象作为参数:
 * 
 * <pre><code>
 * dh.append('my-ul', [ {
 * 	tag : 'li',
 * 	id : 'item5',
 * 	html : 'List Item 5'
 * }, {
 * 	tag : 'li',
 * 	id : 'item6',
 * 	html : 'List Item 6'
 * } ]);
 * </code></pre>
 * 
 * </p>
 * 
 * @constructor
 * @class L5.DomHelper
 */
L5.DomHelper = function() {
	// do nothing
};

(function() {
	var tempTableEl = null;
	var emptyTags = /^(?:br|frame|hr|img|input|link|meta|range|spacer|wbr|area|param|col)$/i;
	var tableRe = /^table|tbody|tr|td$/i;
	/**
	 * @private 内部使用 将传入的参数构件成HTML片段（最终结果实际上应该是string串）
	 * @param {String/Array/json对象}o
	 * @returns {String} 最终返回的是string是HTML片段
	 */
	var createHtml = function(o) {
		if (typeof o == 'string') {
			return o;
		}
		var b = "";
		if (L5.isArray(o)) {
			for ( var i = 0, l = o.length; i < l; i++) {
				b += createHtml(o[i]);
			}
			return b;
		}
		// 假如没有tag就当成div创建
		if (!o.tag) {
			o.tag = "div";
		}
		b += "<" + o.tag;
		// 遍历里面的所有属性创建string形式的html片段
		for ( var attr in o) {
			if (attr == "tag" || attr == "children" || attr == "cn"
					|| attr == "html" || typeof o[attr] == "function")
				continue;
			if (attr == "style") {
				var s = o["style"];
				// style可以是一个方法，可扩展性强，动态改变
				if (typeof s == "function") {
					s = s.call();
				}
				if (typeof s == "string") {
					b += ' style="' + s + '"';
				} else if (typeof s == "object") {
					b += ' style="';
					for ( var key in s) {
						if (typeof s[key] != "function") {
							b += key + ":" + s[key] + ";";
						}
					}
					b += '"';
				}
			} else {
				if (attr == "cls") {
					b += ' class="' + o["cls"] + '"';
				} else if (attr == "htmlFor") {
					b += ' for="' + o["htmlFor"] + '"';
				} else {
					b += " " + attr + '="' + o[attr] + '"';
				}
			}
		}
		if (emptyTags.test(o.tag)) {// 这类的标签不会再嵌套其他的标签了直接就加"/"结束
			b += "/>";
		} else {// 嵌套其他的标签
			b += ">";
			var cn = o.children || o.cn;
			if (cn) {
				b += createHtml(cn);
			} else if (o.html) {
				b += o.html;
			}
			b += "</" + o.tag + ">";
		}
		return b;
	};
	/**
	 * @private 内部使用 为某节点创建dom子节点
	 * @param o
	 *            要创建的子节点的信息
	 * @param parentNode
	 *            dom节点，父节点
	 */
	var createDom = function(o, parentNode) {
		var el;
		if (L5.isArray(o)) {
			// 创建document文档片段，为了提高效率，该文档节点会一次将全部文档碎片增加到document中
			el = document.createDocumentFragment(); // in one shot using a
			// DocumentFragment
			for ( var i = 0, l = o.length; i < l; i++) {
				createDom(o[i], el);
			}
		} else if (typeof o == "string") { // Allow a string as a child spec.
			el = document.createTextNode(o);
		} else {
			el = document.createElement(o.tag || 'div');
			var useSet = !!el.setAttribute; // In IE some elements don't have
			// setAttribute
			for ( var attr in o) {
				if (attr == "tag" || attr == "children" || attr == "cn"
						|| attr == "html" || attr == "style"
						|| typeof o[attr] == "function")
					continue;
				if (attr == "cls") {
					el.className = o["cls"];
				} else {
					// 将属性值赋值给新创建的dom节点
					if (useSet)
						el.setAttribute(attr, o[attr]);
					else
						el[attr] = o[attr];
				}
			}
			// 为元素应用指定的样式
			L5.DomHelper.applyStyles(el, o.style);
			var cn = o.children || o.cn;
			if (cn) {
				createDom(cn, el);
			} else if (o.html) {
				el.innerHTML = o.html;
			}
		}
		if (parentNode) {
			parentNode.appendChild(el);
		}
		return el;
	};
	/**
	 * @private 内部使用
	 */
	var ieTable = function(depth, s, h, e) {
		tempTableEl.innerHTML = [ s, h, e ].join('');
		var i = -1, el = tempTableEl;
		while (++i < depth) {
			el = el.firstChild;
		}
		return el;
	};

	// kill repeat to save bytes
	var ts = '<table>', te = '</table>', tbs = ts + '<tbody>', tbe = '</tbody>'
			+ te, trs = tbs + '<tr>', tre = '</tr>' + tbe;

	/**
	 * @private 内部使用 Nasty code for IE's broken table implementation
	 */
	var insertIntoTable = function(tag, where, el, html) {
		if (!tempTableEl) {
			tempTableEl = document.createElement('div');
		}
		var node;
		var before = null;
		if (tag == 'td') {
			if (where == 'afterbegin' || where == 'beforeend') { // INTO a TD
				return;
			}
			if (where == 'beforebegin') {
				before = el;
				el = el.parentNode;
			} else {
				before = el.nextSibling;
				el = el.parentNode;
			}
			node = ieTable(4, trs, html, tre);
		} else if (tag == 'tr') {
			if (where == 'beforebegin') {
				before = el;
				el = el.parentNode;
				node = ieTable(3, tbs, html, tbe);
			} else if (where == 'afterend') {
				before = el.nextSibling;
				el = el.parentNode;
				node = ieTable(3, tbs, html, tbe);
			} else { // INTO a TR
				if (where == 'afterbegin') {
					before = el.firstChild;
				}
				node = ieTable(4, trs, html, tre);
			}
		} else if (tag == 'tbody') {
			if (where == 'beforebegin') {
				before = el;
				el = el.parentNode;
				node = ieTable(2, ts, html, te);
			} else if (where == 'afterend') {
				before = el.nextSibling;
				el = el.parentNode;
				node = ieTable(2, ts, html, te);
			} else {
				if (where == 'afterbegin') {
					before = el.firstChild;
				}
				node = ieTable(3, tbs, html, tbe);
			}
		} else { // TABLE
			if (where == 'beforebegin' || where == 'afterend') { // OUTSIDE
				// the table
				return;
			}
			if (where == 'afterbegin') {
				before = el.firstChild;
			}
			node = ieTable(2, ts, html, te);
		}
		el.insertBefore(node, before);
		return node;
	};

	/**
	 * 如果是true，强制使用DOM而不是html片段
	 * 
	 * @type Boolean
	 */
	L5.DomHelper.useDom = false;

	/**
	 * 为传入的对象返回元素的装饰
	 * 
	 * @param {Object}
	 *            o DOM对象(和子元素)
	 * @return {String}
	 */
	L5.DomHelper.markup = function(o) {
		return createHtml(o);
	};

	/**
	 * 为元素应用指定的样式
	 * 
	 * @param {String/HTMLElement}
	 *            el 要应用样式的元素对象
	 * @param {String/Object/Function}
	 *            styles 样式字符串 例如："width:100px"或者表单中的对象{width:"100px"}或者返回样式的函数
	 */
	L5.DomHelper.applyStyles = function(el, styles) {
		if (styles) {
			el = L5.fly(el);
			if (typeof styles == "string") {
				var re = /\s?([a-z\-]*)\:\s?([^;]*);?/gi;
				var matches;
				while ((matches = re.exec(styles)) != null) {
					el.setStyle(matches[1], matches[2]);
				}
			} else if (typeof styles == "object") {
				for ( var style in styles) {
					el.setStyle(style, styles[style]);
				}
			} else if (typeof styles == "function") {
				L5.DomHelper.applyStyles(el, styles.call());
			}
		}
	};

	/**
	 * 插入HTML片段到DOM对象
	 * 
	 * <li>beforeBegin: 插入到标签开始前</li>
	 * <li>afterBegin:插入到标签开始标记之后</li>
	 * <li>beforeEnd:插入到标签结束标记前</li>
	 * <li>afterEnd:插入到标签结束标记后</li>
	 * 
	 * @param {String}
	 *            where 要插入片段的位置 如：beforeBegin, afterBegin, beforeEnd, afterEnd.
	 * @param {HTMLElement}
	 *            el 上下文元素对象
	 * @param {String}
	 *            html HTML片段
	 * @return {HTMLElement} 新的节点
	 */
	L5.DomHelper.insertHtml = function(where, el, html) {
		where = where.toLowerCase();
		if (el.insertAdjacentHTML) {
			if (tableRe.test(el.tagName)) {
				var rs;
				if (rs = insertIntoTable(el.tagName.toLowerCase(), where, el,
						html)) {
					return rs;
				}
			}
			switch (where) {
			case "beforebegin":
				el.insertAdjacentHTML('BeforeBegin', html);
				return el.previousSibling;
			case "afterbegin":
				el.insertAdjacentHTML('AfterBegin', html);
				return el.firstChild;
			case "beforeend":
				el.insertAdjacentHTML('BeforeEnd', html);
				return el.lastChild;
			case "afterend":
				el.insertAdjacentHTML('AfterEnd', html);
				return el.nextSibling;
			}
			throw 'Illegal insertion point -> "' + where + '"';
		}
		var range = el.ownerDocument.createRange();
		var frag;
		switch (where) {
		case "beforebegin":
			range.setStartBefore(el);
			frag = range.createContextualFragment(html);
			el.parentNode.insertBefore(frag, el);
			return el.previousSibling;
		case "afterbegin":
			if (el.firstChild) {
				range.setStartBefore(el.firstChild);
				frag = range.createContextualFragment(html);
				el.insertBefore(frag, el.firstChild);
				return el.firstChild;
			} else {
				el.innerHTML = html;
				return el.firstChild;
			}
		case "beforeend":
			if (el.lastChild) {
				range.setStartAfter(el.lastChild);
				frag = range.createContextualFragment(html);
				el.appendChild(frag);
				return el.lastChild;
			} else {
				el.innerHTML = html;
				return el.lastChild;
			}
		case "afterend":
			range.setStartAfter(el);
			frag = range.createContextualFragment(html);
			el.parentNode.insertBefore(frag, el.nextSibling);
			return el.nextSibling;
		}
		throw 'Illegal insertion point -> "' + where + '"';
	};

	/**
	 * 将新生成的节点插入到指定节点的前面
	 * 
	 * @param {Mixed}
	 *            el 元素对象
	 * @param {Object/String}
	 *            o 指定的DOM对象(和其子节点)或者纯粹的HTML
	 * @param {Boolean}
	 *            returnElement (可选) 如果为true，返回L5.Element对象
	 * @return {HTMLElement/L5.Element} 新的节点
	 */
	L5.DomHelper.insertBefore = function(el, o, returnElement) {
		return this.doInsert(el, o, returnElement, "beforeBegin");
	};

	/**
	 * 将新生成的节点插入到指定节点的后面
	 * 
	 * @param {Mixed}
	 *            el 元素对象
	 * @param {Object}
	 *            o 指定的DOM对象(和其子节点)
	 * @param {Boolean}
	 *            returnElement (可选) 如果为true，返回L5.Element对象
	 * @return {HTMLElement/L5.Element} 新的节点
	 */
	L5.DomHelper.insertAfter = function(el, o, returnElement) {
		return this.doInsert(el, o, returnElement, "afterEnd", "nextSibling");
	};

	/**
	 * 将新生成的节点作为el的第一个子节点插入
	 * 
	 * @param {Mixed}
	 *            el 元素对象
	 * @param {Object/String}
	 *            o 指定的DOM对象(和其子节点)或者纯粹的HTML
	 * @param {Boolean}
	 *            returnElement (可选) 如果为true，返回L5.Element对象
	 * @return {HTMLElement/L5.Element} 新的节点
	 */
	L5.DomHelper.insertFirst = function(el, o, returnElement) {
		return this.doInsert(el, o, returnElement, "afterBegin", "firstChild");
	};

	// private
	L5.DomHelper.doInsert = function(el, o, returnElement, pos, sibling) {
		el = L5.getDom(el);
		var newNode;
		if (this.useDom) {
			newNode = createDom(o, null);
			(sibling === "firstChild" ? el : el.parentNode).insertBefore(
					newNode, sibling ? el[sibling] : el);
		} else {
			var html = createHtml(o);
			newNode = this.insertHtml(pos, el, html);
		}
		return returnElement ? L5.get(newNode, true) : newNode;
	};

	/**
	 * 将新生成的节点放到指定节点的最后面
	 * 
	 * @param {Mixed}
	 *            el 元素对象
	 * @param {Object/String}
	 *            o 指定的DOM对象(和其子节点)或者纯粹的HTML
	 * @param {Boolean}
	 *            returnElement (可选) 如果为true，返回L5.Element对象
	 * @return {HTMLElement/L5.Element} 新的节点
	 */
	L5.DomHelper.append = function(el, o, returnElement) {
		el = L5.getDom(el);
		var newNode;
		if (this.useDom) {
			newNode = createDom(o, null);
			el.appendChild(newNode);
		} else {
			var html = createHtml(o);
			newNode = this.insertHtml("beforeEnd", el, html);
		}
		return returnElement ? L5.get(newNode, true) : newNode;
	};

	/**
	 * 将新生成的节点覆盖el对象的内容
	 * 
	 * @param {Mixed}
	 *            el 元素对象
	 * @param {Object/String}
	 *            o 指定的DOM对象(和其子节点)或者纯粹的HTML
	 * @param {Boolean}
	 *            returnElement (可选) 如果为true，返回L5.Element对象
	 * @return {HTMLElement/L5.Element} 新的节点
	 */
	L5.DomHelper.overwrite = function(el, o, returnElement) {
		el = L5.getDom(el);
		el.innerHTML = createHtml(o);
		return returnElement ? L5.get(el.firstChild, true) : el.firstChild;
	};

	/**
	 * 根据指定的DOM对象创建新的L5.Template对象
	 * 
	 * @param {Object}
	 *            o DOM对象(和其子节点)
	 * @return {L5.Template} 新的模板
	 */
	L5.DomHelper.createTemplate = function(o) {
		var html = createHtml(o);
		return new L5.Template(html);
	};
})();
