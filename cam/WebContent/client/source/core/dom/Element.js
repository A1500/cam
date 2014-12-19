/**
 * 代表一个DOM元素.<br>
 * L5.Element的构造器，可以直接使用，直接使用的情况比较少，一般都是通过L5.get创建一个L5.Element对象并进行缓存
 * 
 * @param {String/dom}
 *            element dom元素或者dom的id值
 * @param {boolean}
 *            forceNew 是否强制新建一个对象(以前可能缓存了一个dom的id相同的对象)
 * @constructor
 */
L5.Element = function(element, forceNew) {
	var dom = typeof element == "string" ? document.getElementById(element)
			: element;
	if (!dom) { // invalid id/element
		return null;
	}
	var id = dom.id;
	// 假如不是强制创建新的对象，并且已经缓存了，就直接返回缓存的对象
	if (forceNew !== true && id && L5.Element.cache[id]) {
		return L5.Element.cache[id];
	}

	/**
	 * 对应的、被代表的dom元素
	 * 
	 * @type HTMLElement
	 */
	this.dom = dom;

	/**
	 * id
	 * 
	 * @type String
	 */
	this.id = id || L5.id(dom);
};

(function() {
	var D = L5.lib.Dom;
	var E = L5.lib.Event;
	var A = L5.lib.Anim;

	// speedy lookup for elements never to box adjust
	var noBoxAdjust = L5.isStrict ? {
		select : 1
	} : {
		input : 1,
		select : 1,
		textarea : 1
	};

	if (L5.isIE || L5.isGecko) {
		noBoxAdjust['button'] = 1;
	}

	var El = L5.Element;

	/**
	 * 长度的单位
	 * 
	 * @private
	 */
	var unitPattern = /\d+(px|em|%|en|ex|pt|in|cm|mm|pc)$/i;

	L5.Element.prototype = {

		/**
		 * 当前元素使用的默认单位(default to px)
		 * 
		 * @type String
		 */
		defaultUnit : "px",

		/**
		 * 是否为"盒子模型"自动调整长度和宽度设置 (default to true)
		 * 
		 * @type Boolean
		 */
		autoBoxAdjust : true,

		/**
		 * 当前元素是否匹配某个过滤器
		 * 
		 * @param {String}
		 *            selector
		 * @return {Boolean}
		 */
		is : function(simpleSelector) {
			return L5.DomQuery.is(this.dom, simpleSelector);
		},

		/**
		 * 清除无意义的文本节点。
		 * <p>
		 * 默认情况下，清理过一次后就没要必要再清理了。
		 * <p>
		 * 可以通过forceReclean参数指定不管以前是否清理过都要再清理一次。
		 * 
		 * @param {Boolean}
		 *            forceReclean (optional)
		 */
		clean : function(forceReclean) {
			if (this.isCleaned && forceReclean !== true) {
				return this;
			}
			var ns = /\S/;
			var d = this.dom, n = d.firstChild, ni = -1;
			while (n) {
				var nx = n.nextSibling;
				if (n.nodeType == 3 && !ns.test(n.nodeValue)) {
					d.removeChild(n);
				} else {
					n.nodeIndex = ++ni;
				}
				n = nx;
			}
			this.isCleaned = true;// 已清理过.
			return this;
		},

		/**
		 * 判断当前元素是不是某个指定元素的祖先节点。
		 * 
		 * @param {HTMLElement/String}
		 *            el
		 * @return {Boolean}
		 */
		contains : function(el) {
			try {
				return !el ? false : L5.lib.Dom.isAncestor(this.dom,
						el.dom ? el.dom : el);
			} catch (e) {
				return false;
			}
		},

		/**
		 * 返回满足条件的子节点，以CompositeElement的形式返回。
		 * 
		 * @param {String}
		 *            样式过滤器
		 * @param {Boolean}
		 *            unique (optional) true，每个节点都创建唯一的Element对象，否则使用共享对象
		 * @return {CompositeElement/CompositeElementLite}
		 */
		select : function(selector, unique) {
			return El.select(selector, unique, this.dom);
		},

		/**
		 * 使当前元素获得焦点
		 * 
		 * @return {L5.Element} this
		 */
		focus : function() {
			try {
				this.dom.focus();
			} catch (e) {
			}
			return this;
		},

		/**
		 * 使该元素失去焦点
		 * 
		 * @return {L5.Element} this
		 */
		blur : function() {
			try {
				this.dom.blur();
			} catch (e) {
			}
			return this;
		},

		/**
		 * 获取当前元素对应的dom的value属性，可以返回数字类型
		 * 
		 * @param {Boolean}
		 *            asNumber 是否返回数字类型
		 * @return {String/Number}
		 */
		getValue : function(asNumber) {
			return asNumber ? parseInt(this.dom.value, 10) : this.dom.value;
		},

		/**
		 * 设置当前元素对应dom的value属性
		 */
		setValue : function(value) {
			if (!value) {
				return;
			}
			this.dom.value = value;
		},

		/**
		 * 增加一个事件监听函数
		 * 
		 * @param {String}
		 *            事件名称
		 * @param {Function}
		 *            fn 事件处理函数，该函数可以接收下列参数：
		 *            <ul>
		 *            <li>evt : 事件对象：L5.EventObject或者浏览器事件对象</li>
		 *            <li>t : 事件目标 target </li>
		 *            <li>delegate: 调用addListener方法的opetions参数对象的delegate属性</li>
		 *            <li>o : 调用addListener方法的opetions参数.</li>
		 *            </ul>
		 * @param {Object}
		 *            事件处理函数执行时的scope(执行的时候this关键字指向谁),默认是当前Element.
		 * @param {Object}
		 *            options (optional) :
		 *            <ul>
		 *            <li>scope {Object} : 事件监听函数的执行scope.</li>
		 *            <li>delegate {String} : 一个简单选择器(过滤目标或寻找目标的子孙节点)</li>
		 *            <li>stopEvent {Boolean} : True 阻止默认活动、阻止事件冒泡.</li>
		 *            <li>preventDefault {Boolean} : True 阻止默认活动</li>
		 *            <li>stopPropagation {Boolean} : True 阻止事件冒泡</li>
		 *            <li>normalized {Boolean} :
		 *            设为flase将将浏览器事件替代Ext.EventObject传递给事件处理函数</li>
		 *            <li>delay {Number} : 延时多少毫秒后发生.</li>
		 *            <li>single {Boolean} : 只运行一次.</li>
		 *            <li>buffer {Number} : 在Ext.util.DelayedTask中预定事件.</li>
		 *            </ul>
		 *            <br>
		 *            <p>
		 *            例如:
		 * 
		 * <pre><code>
		 * el.on('click', this.onClick, this, {
		 * 	single : true,
		 * 	delay : 100,
		 * 	stopEvent : true,
		 * 	forumId : 4
		 * });
		 * </code></pre>
		 * 
		 * </p>
		 * 
		 * <p>
		 * Code:
		 * 
		 * <pre><code></p>
		 * el.on({
		 * 	'click' : {
		 * 		fn : this.onClick,
		 * 		scope : this,
		 * 		delay : 100
		 * 	},
		 * 	'mouseover' : {
		 * 		fn : this.onMouseOver,
		 * 		scope : this
		 * 	},
		 * 	'mouseout' : {
		 * 		fn : this.onMouseOut,
		 * 		scope : this
		 * 	}
		 * });
		 * </code></pre>
		 * 
		 * <p>
		 * 
		 * <pre><code></p>
		 * el.on({
		 * 	'click' : this.onClick,
		 * 	'mouseover' : this.onMouseOver,
		 * 	'mouseout' : this.onMouseOut,
		 * 	scope : this
		 * });
		 * </code></pre>
		 */
		addListener : function(eventName, fn, scope, options) {
			L5.EventManager.on(this.dom, eventName, fn, scope || this, options);
		},

		/**
		 * 删除某个事件监听函数. 该方法有个缩写版：{@link #un} .
		 * <p>
		 * 例如:
		 * 
		 * <pre><code>
		 * el.removeListener('click', this.handlerFn);
		 * // or
		 * el.un('click', this.handlerFn);
		 * </code></pre>
		 * 
		 * @param {String}
		 *            eventName 事件名称
		 * 
		 * @param {Function}
		 *            fn 事件监听函数
		 * 
		 * @param {Object}
		 *            scope (optional) 事件监听函数的执行范围，默认是当前元素
		 * 
		 * @return {L5.Element} this
		 */
		removeListener : function(eventName, fn, scope) {
			L5.EventManager.removeListener(this.dom, eventName, fn, scope
					|| this);
			return this;
		},

		/**
		 * 删除该元素的所有事件监听函数
		 * 
		 * @return {L5.Element} this
		 */
		removeAllListeners : function() {
			L5.EventManager.removeAll(this.dom);
			return this;
		},

		/**
		 * 事件串联。实现这么一个功能：当这个元素发出某个事件后，指定的某个事件源跟着发出同一个事件。
		 * 
		 * @param {String}
		 *            eventName 事件名称
		 * @param {Object}
		 *            observable 某个事件源
		 */
		relayEvent : function(eventName, observable) {
			this.on(eventName, function(e) {
				observable.fireEvent(eventName, e);
			});
		},

		/**
		 * 给长度或宽度值加上单位(默认单位)
		 * 
		 * @private
		 */
		addUnits : function(v) {
			if (v === "" || v == "auto") {
				return v;
			}
			if (v === undefined) {
				return '';
			}
			if (typeof v == "number" || !unitPattern.test(v)) {
				return v + (this.defaultUnit || 'px');
			}
			return v;
		},

		/**
		 * 修改元素的innerHTML, 捎带可以执行里面的脚本。
		 * 
		 * @param {String}
		 *            html 新的HTML
		 * @param {Boolean}
		 *            loadScripts (optional) True 是否执行html里面带的脚本 (defaults to
		 *            false)
		 * @param {Function}
		 *            callback (optional) 修改完后执行的回调函数
		 * 
		 * @return {L5.Element} this
		 * 
		 * @public
		 */
		update : function(html, loadScripts, callback) {
			if (typeof html == "undefined") {
				html = "";
			}
			if (loadScripts !== true) {
				this.dom.innerHTML = html;
				if (typeof callback == "function") {
					callback();
				}
				return this;
			}
			var id = L5.id();
			var dom = this.dom;
			html += '<span id="' + id + '"></span>';
			E.onAvailable(id, function() {
				var hd = document.getElementsByTagName("head")[0];
				var re = /(?:<script([^>]*)?>)((\n|\r|.)*?)(?:<\/script>)/ig;
				var srcRe = /\ssrc=([\'\"])(.*?)\1/i;
				var typeRe = /\stype=([\'\"])(.*?)\1/i;

				var match;
				var scriptstring = "";
				while (match = re.exec(html)) {
					var attrs = match[1];
					var srcMatch = attrs ? attrs.match(srcRe) : false;
					if (srcMatch && srcMatch[2]) {
						if (typeof callback == "object") {
							L5.Ajax.request({
								url : srcMatch[2],
								sync : true,
								success : function(rep) {
									scriptstring += rep.responseText;
								}
							});
						} else {
							var s = document.createElement("script");
							s.src = srcMatch[2];
							var typeMatch = attrs.match(typeRe);
							if (typeMatch && typeMatch[2]) {
								s.type = typeMatch[2];
							}
							hd.appendChild(s);
						}
					} else if (match[2] && match[2].length > 0) {
						scriptstring += match[2];
					}

				}
				if (scriptstring.length > 0)
					if (window.execScript) {
						if (typeof callback == "object") {// 如果传进来的第三参数是对象
							try {
								var f = Function(scriptstring);
								f.apply(callback);// 则以此对象为作用域调用对应的js，可以在对应的js里使用this---该对象
							} catch (e) {
								// donothing;
								if (L5.widgetDebug) {
									var exp = "";
									if (callback.header != null) {
										exp = "Erring widget:"
												+ callback.header.dom.innerText
												+ "\n";
									}
									alert(exp + "Error type:  " + e.name
											+ "\nMessage:  " + e.message);
								}
							}
						} else {
							window.execScript(scriptstring);
						}
					} else {
						if (typeof callback == "object") {// 如果传进来的第三参数是对象
							try {
								var f = Function(scriptstring);
								f.apply(callback);// 则以此对象为作用域调用对应的js，可以在对应的js里使用this---该对象
							} catch (e) {
								if (L5.widgetDebug) {
									var exp = "";
									if (callback.header != null) {
										exp = "Erring widget:"
												+ callback.header.dom.innerText
												+ "\n";
									}
									alert(exp + "Error type:  " + e.name
											+ "\nMessage:  " + e.message);
								}
							}
						} else {
							window.eval(scriptstring);
						}
					}
				var el = document.getElementById(id);
				if (el) {
					L5.removeNode(el);
				}
				if (typeof callback == "function") {
					callback();
				}
			});
			dom.innerHTML = html.replace(
					/(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)/ig, "");
			return this;
		},

		/**
		 * 直接应用当前updater的{@link L5.Updater#update}该方法参数{@link L5.Updater#update}一样
		 * 
		 * @return {L5.Element} this
		 */
		load : function() {
			var um = this.getUpdater();
			um.update.apply(um, arguments);
			return this;
		},

		/**
		 * 得到当前元素的Updater对象
		 * 
		 * @return {L5.Updater}
		 */
		getUpdater : function() {
			if (!this.updateManager) {
				this.updateManager = new L5.Updater(this);
			}
			return this.updateManager;
		},

		/**
		 * 当前元素是否使用一个有边框的盒子
		 * 
		 * @return {Boolean}
		 */
		isBorderBox : function() {
			return noBoxAdjust[this.dom.tagName.toLowerCase()]
					|| L5.isBorderBox;
		},

		/**
		 * 创建一个代理元素
		 * 
		 * @param {String/Object}
		 *            config The class name of the proxy element or a DomHelper
		 *            config object 代理元素的类名或DomHelper config对象
		 * @param {String/HTMLElement}
		 *            renderTo (optional) The element or element id to render
		 *            the proxy to (defaults to document.body)将要绘制代理元素的html
		 *            element或id
		 * @param {Boolean}
		 *            matchBox (optional) True to align and size the proxy to
		 *            this element now (defaults to false)是否对齐
		 * @return {L5.Element} The new proxy element
		 */
		createProxy : function(config, renderTo, matchBox) {
			config = typeof config == "object" ? config : {
				tag : "div",
				cls : config
			};

			var proxy;
			if (renderTo) {
				proxy = L5.DomHelper.append(renderTo, config, true);
			} else {
				proxy = L5.DomHelper.insertBefore(this.dom, config, true);
			}
			if (matchBox) {
				proxy.setBox(this.getBox());
			}
			return proxy;
		},

		/**
		 * 删除该元素，同时删除缓存中的该元素
		 */
		remove : function() {
			L5.removeNode(this.dom);
			delete El.cache[this.dom.id];
		},

		/**
		 * 设置鼠标移入移出事件
		 * 
		 * @param {Function}
		 *            overFn 移入事件
		 * @param {Function}
		 *            outFn 移除事件
		 * @param {Object}
		 *            scope (optional)
		 * @return {L5.Element} this
		 */
		hover : function(overFn, outFn, scope) {
			var preOverFn = function(e) {
				if (!e.within(this, true)) {
					overFn.apply(scope || this, arguments);
				}
			};
			var preOutFn = function(e) {
				if (!e.within(this, true)) {
					outFn.apply(scope || this, arguments);
				}
			};
			this.on("mouseover", preOverFn, this.dom);
			this.on("mouseout", preOutFn, this.dom);
			return this;
		},

		/**
		 * 阻止eventName事件冒泡，并视preventDefault阻断默认行为
		 * 
		 * @param {String/Array}
		 *            eventName 事件名称、可以用数组包含多个事件
		 * @param {Boolean}
		 *            preventDefault (optional) true 阻止默认行为
		 * 
		 * @return {L5.Element} this
		 */
		swallowEvent : function(eventName, preventDefault) {
			var fn = function(e) {
				e.stopPropagation();
				if (preventDefault) {
					e.preventDefault();
				}
			};
			if (L5.isArray(eventName)) {
				for ( var i = 0, len = eventName.length; i < len; i++) {
					this.on(eventName[i], fn);
				}
				return this;
			}
			this.on(eventName, fn);
			return this;
		},

		/**
		 * 设置属性，从另一个对象拷贝属性。
		 * 
		 * @param {Object}
		 *            o 包含新属性值的对象
		 * @param {Boolean}
		 *            useSet (optional)
		 * 
		 * @return {L5.Element} this
		 */
		set : function(o, useSet) {
			var el = this.dom;
			useSet = typeof useSet == 'undefined' ? (el.setAttribute ? true
					: false) : useSet;
			for ( var attr in o) {
				if (attr == "style" || typeof o[attr] == "function")
					continue;
				if (attr == "cls") {
					el.className = o["cls"];
				} else if (o.hasOwnProperty(attr)) {
					if (useSet)
						el.setAttribute(attr, o[attr]);
					else
						el[attr] = o[attr];
				}
			}
			if (o.style) {
				L5.DomHelper.applyStyles(el, o.style);
			}
			return this;
		},

		/**
		 * 获得该元素的某个属性
		 * 
		 * @param {String}
		 *            namespace 属性名空间
		 * 
		 * @param {String}
		 *            name 属性名称
		 * 
		 * @return {String} 属性值
		 */
		getAttributeNS : L5.isIE ? function(ns, name) {
			var d = this.dom;
			var type = typeof d[ns + ":" + name];
			if (type != 'undefined' && type != 'unknown') {
				return d[ns + ":" + name];
			}
			return d[name];
		} : function(ns, name) {
			var d = this.dom;
			return d.getAttributeNS(ns, name)
					|| d.getAttribute(ns + ":" + name) || d.getAttribute(name)
					|| d[name];
		},

		/**
		 * Returns the width in pixels of the passed text, or the width of the
		 * text in this Element.
		 * 
		 * @param {String}
		 *            text The text to measure. Defaults to the innerHTML of the
		 *            element.
		 * @param {Number}
		 *            min (Optional) The minumum value to return.
		 * @param {Number}
		 *            max (Optional) The maximum value to return.
		 * @return {Number} The text width in pixels.
		 */
		getTextWidth : function(text, min, max) {
			return (L5.util.TextMetrics.measure(this.dom, L5.value(text,
					this.dom.innerHTML, true)).width).constrain(min || 0,
					max || 1000000);
		}

	};

})();

L5.Element.prototype.on = L5.Element.prototype.addListener;

L5.Element.prototype.un = L5.Element.prototype.removeListener;
