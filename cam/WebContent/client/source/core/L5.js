/**
 * 定义L5对象
 */

L5 = {
	version : '5.0'
};

(function() {
	var paths = document.location.pathname.split("/");
	if (paths[0] == '') {// ie下面有时候paths[0]是空
		L5.webPath = "/" + paths[1];
	} else {
		L5.webPath = "/" + paths[0];
	}
})();

/**
 * 完成数据绑定和一些初始化的工作
 */
if (L5.initObj == null) {
	L5.initObj = {};
	if (L5.loadData == null) {
		L5.loadData = {};
	}
}

// for old browsers
window["undefined"] = window["undefined"];

(function() {
	var idSeed = 0;
	var ua = navigator.userAgent.toLowerCase();

	var isStrict = document.compatMode == "CSS1Compat", // 此类型的渲染模式是w3c的标准模式
	isOpera = ua.indexOf("opera") > -1, isChrome = ua.indexOf("chrome") > -1, isSafari = !isChrome
			&& (/webkit|khtml/).test(ua), isSafari3 = isSafari
			&& ua.indexOf('webkit/5') != -1, isIE = !isOpera
			&& ua.indexOf("msie") > -1, isIE7 = !isOpera
			&& ua.indexOf("msie 7") > -1, isIE8 = !isOpera
			&& ua.indexOf("msie 8") > -1, isGecko = !isSafari && !isChrome
			&& ua.indexOf("gecko") > -1, isGecko3 = isGecko
			&& ua.indexOf("rv:1.9") > -1, isBorderBox = isIE && !isStrict, isWindows = (ua
			.indexOf("windows") != -1 || ua.indexOf("win32") != -1), isMac = (ua
			.indexOf("macintosh") != -1 || ua.indexOf("mac os x") != -1), isAir = (ua
			.indexOf("adobeair") != -1), isLinux = (ua.indexOf("linux") != -1), isSecure = window.location.href
			.toLowerCase().indexOf("https") === 0;

	// remove css image flicker
	if (isIE && !isIE7) {
		try {
			// IE6下默认不缓存背景图片，CSS里每次更改图片的位置时都会重新发起请求，用这个方法告诉IE6缓存背景图片
			// 如果不缓存，图片作为背景时，有鼠标操作时会请求，则可能产生抖动现象
			// 现实中解决方案，比较常见的就是将很多图标集中到一张图片上，然后定位的方式，L5多处应用该方法。
			document.execCommand("BackgroundImageCache", false, true);
		} catch (e) {
		}
	}

	/**
	 * True if the browser is in strict (standards-compliant) mode, as opposed
	 * to quirks mode
	 * 
	 * @private
	 * @type Boolean
	 */
	L5.isStrict = isStrict;
	/**
	 * 是否正使用SSL访问
	 * 
	 * @private
	 * @type Boolean
	 */
	L5.isSecure = isSecure;
	/**
	 * 界面的初始化是否完成
	 * 
	 * @private
	 * @type Boolean
	 */
	L5.isReady = false;

	/**
	 * 是否自动垃圾回收
	 * 
	 * @private
	 * @type Boolean
	 */
	L5.enableGarbageCollector = true;

	/**
	 * 垃圾回收的时候是否理元素对应的收集事件监听器.该属性只在enableGarbageCollector属性为true的时候启作用。
	 * 
	 * @private
	 * @type Boolean
	 */
	L5.enableListenerCollection = false;

	/**
	 * 空url，防止安全模式下ie内容警告
	 * 
	 * @private
	 */
	L5.SSL_SECURE_URL = "javascript:false";

	/**
	 * URL to a 1x1 transparent gif image used by L5 to create inline icons with
	 * CSS background images. (Defaults to "http://loushang.com/s.gif" and you
	 * should change this to a URL on your server).
	 * 
	 * @private
	 */
	L5.BLANK_IMAGE_URL = "http:/" + "/loushang.com/s.gif";

	/**
	 * 空函数，为了重用
	 * 
	 * @private
	 */
	L5.emptyFn = function() {
	};

	/**
	 * 如果浏览器是Opera则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isOpera = isOpera;
	/**
	 * 如果浏览器是Chrome则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isChrome = isChrome;
	/**
	 * 如果浏览器是Safari则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isSafari = isSafari;
	/**
	 * 如果浏览器是Safari 3.x则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isSafari3 = isSafari3;
	/**
	 * 如果浏览器是Safari 2.x则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isSafari2 = isSafari && !isSafari3;
	/**
	 * 如果浏览器是Internet Explorer则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isIE = isIE;
	/**
	 * 如果浏览器是Internet Explorer 6.x则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isIE6 = isIE && !isIE7 && !isIE8;
	/**
	 * 如果浏览器是Internet Explorer 7.x则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isIE7 = isIE7;
	/**
	 * 如果浏览器是Internet Explorer 8.x则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isIE8 = isIE8;
	/**
	 * 如果浏览器使用的是Gecko引擎则值是true (例如Mozilla, Firefox).
	 * 
	 * @type Boolean
	 */
	L5.isGecko = isGecko;
	/**
	 * 如果浏览器使用的是pre-Gecko 1.9引擎则值是true(例如：Firefox 2.x).
	 * 
	 * @type Boolean
	 */
	L5.isGecko2 = isGecko && !isGecko3;
	/**
	 * 如果浏览器使用的是Gecko 1.9+引擎则值是true(例如： Firefox 3.x).
	 * 
	 * @type Boolean
	 */
	L5.isGecko3 = isGecko3;
	/**
	 * 如果浏览器是Internet Explorer并且运行在non-strict模式下则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isBorderBox = isBorderBox;
	/**
	 * 如果操作系统是Linux则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isLinux = isLinux;
	/**
	 * 如果操作系统是Windows则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isWindows = isWindows;
	/**
	 * 如果操作系统是Mac OS则值是true.
	 * 
	 * @type Boolean
	 */
	L5.isMac = isMac;
	/**
	 * 是否adobe平台.
	 * 
	 * @ignore
	 * @type Boolean
	 */
	L5.isAir = isAir;

	/**
	 * By default, L5 intelligently decides whether floating elements should be
	 * shimmed. If you are using flash, you may want to set this to true.
	 * 
	 * @ignore
	 * @type Boolean
	 */
	L5.useShims = ((isIE && !isIE7) || (isMac && isGecko && !isGecko3));

	/**
	 * 为元素生成唯一id，如果元素已经有id,则不会改变。
	 * 
	 * @param {Mixed}
	 *            el (可选)要生成唯一id的元素
	 * @param {String}
	 *            prefix (可选) Id 前缀(默认是 "L5-gen")
	 * @return {String} 生成的Id.
	 */
	L5.id = function(el, prefix) {
		return (el = L5.getDom(el) || {}).id = el.id || (prefix || "L5-gen")
				+ (++idSeed);
	};

	/**
	 * 删除一个dom节点，如果参数是body对象，则被忽略。
	 * 
	 * @param {HTMLElement}
	 *            node 要被删除的节点。
	 * @private
	 * @return
	 */
	L5.removeNode = isIE ? function() {
		var d;
		return function(n) {
			if (n && n.tagName != 'BODY') {
				d = d || document.createElement('div');
				d.appendChild(n);
				d.innerHTML = '';
			}
		}
	}() : function(n) {
		if (n && n.parentNode && n.tagName != 'BODY') {
			n.parentNode.removeChild(n);
		}
	};

})();

/**
 * 给一个对象的属性赋值：把配置中的所有属性都拷贝给该对象
 * 
 * @param {Object}
 *            o 需要赋值的对象
 * @param {Object}
 *            c 配置
 * @param {Object}
 *            defaults 默认值
 * @return {Object} 目标对象
 * @member L5 apply
 */
L5.apply = function(o, c, defaults) {
	if (defaults) {
		// no "this" reference for friendly out of scope calls
		L5.apply(o, defaults);
	}
	if (o && c && typeof c == 'object') {
		for ( var p in c) {
			o[p] = c[p];
		}
	}
	return o;
};
/**
 * 同方法apply，但只对目前值为undefined的属性赋值
 * 
 * @method applyIf
 * @private
 * @param {Object}
 *            obj 需要赋值的对象
 * @param {Object}
 *            config 配置
 * @return {Object} returns obj
 */
L5.applyIf = function(o, c) {
	if (o && c) {
		for ( var p in c) {
			if (typeof o[p] == "undefined") {
				o[p] = c[p];
			}// 假如不存在就复制，否则跳过
		}
	}
	return o;
};

/**
 * 把对象转换成URL的格式.例如 L5.urlEncode({foo: 1, bar: 2});将会返回 "foo=1&bar=2".
 * 
 * @param {Object}
 *            o 需要转换的对象
 * @return {String} 转换成的URL字符串
 */
L5.urlEncode = function(o) {
	if (!o) {
		return "";
	}
	var buf = [];
	for ( var key in o) {
		var ov = o[key], k = encodeURIComponent(key);
		var type = typeof ov;
		if (type == 'undefined') {
			buf.push(k, "=&");
		} else if (type != "function" && type != "object") {
			buf.push(k, "=", encodeURIComponent(ov), "&");
		} else if (L5.isDate(ov)) {
			var s = L5.encode(ov).replace(/"/g, '');
			buf.push(k, "=", s, "&");
		} else if (L5.isArray(ov)) {
			if (ov.length) {
				for ( var i = 0, len = ov.length; i < len; i++) {
					buf
							.push(k, "=",
									encodeURIComponent(ov[i] === undefined ? ''
											: ov[i]), "&");
				}
			} else {
				buf.push(k, "=&");
			}
		}
	}
	buf.pop();
	return buf.join("");
};

/**
 * 把URL类型的编码转换为对象.例如： L5.urlDecode("foo=1&bar=2");将会返回对象 {foo: "1", bar: "2"} 或者
 * L5.urlDecode("foo=1&bar=2&bar=3&bar=4", false);将会返回 {foo: "1", bar: ["2",
 * "3", "4"]}.
 * 
 * @param {String}
 *            string
 * @param {Boolean}
 *            overwrite (可选)(默认是false).
 * @return {Object} 对象
 */
L5.urlDecode = function(string, overwrite) {
	if (!string || !string.length) {
		return {};
	}
	var obj = {};
	var pairs = string.split('&');
	var pair, name, value;
	for ( var i = 0, len = pairs.length; i < len; i++) {
		pair = pairs[i].split('=');
		name = decodeURIComponent(pair[0]);
		value = decodeURIComponent(pair[1]);
		if (overwrite !== true) {
			if (typeof obj[name] == "undefined") {
				obj[name] = value;
			} else if (typeof obj[name] == "string") {
				obj[name] = [ obj[name] ];
				obj[name].push(value);
			} else {
				obj[name].push(value);
			}
		} else {
			obj[name] = value;
		}
	}
	return obj;
};

/**
 * 创建名称空间，例如L5.data、L5.grid等。
 * 
 * <pre><code>
 *  L5.namespace('Company', 'Company.data');
 *  Company.Widget = function() { ... }
 *  Company.data.CustomDataset = function(config) { ... }
 * </code></pre>
 * 
 * @private
 * @param {String}
 *            namespace1
 * @param {String}
 *            namespace2
 * @param {String}
 *            etc
 * @method namespace
 */
L5.ns = L5.namespace = function() {
	var a = arguments, o = null, i, j, d, rt;
	for (i = 0; i < a.length; ++i) {
		// 实际上就是一个对象一个对象的去创建
		d = a[i].split(".");// 每个点前后都是一个对象
		rt = d[0];
		eval('if (typeof ' + rt + ' == "undefined"){' + rt + ' = {};} o = '
				+ rt + ';');
		for (j = 1; j < d.length; ++j) {
			o[d[j]] = o[d[j]] || {};// 如果不存在就创建
			o = o[d[j]];
		}
	}
};
/**
 * 根据传进来的参数返回dom元素。
 * 
 * @param {Mixed}
 *            el 可以是id也可以是包装的{@link L5.Element}元素
 * @return HTMLElement
 */
L5.getDom = function(el) {
	if (!el || !document) {
		return null;
	}
	return el.dom ? el.dom : (typeof el == 'string' ? document
			.getElementById(el) : el);
};

/**
 * 返回document元素，类型是{@link L5.Element}.
 * 
 * @return {L5.Element} document
 */
L5.getDoc = function() {
	return L5.get(document);
};

/**
 * 返回body元素 类型是{@link L5.Element}.
 * 
 * @return {L5.Element} document
 */
L5.getBody = function() {
	return L5.get(document.body || document.documentElement);
};

/**
 * 简化的别名 {@link L5.ComponentMgr#get}
 * 
 * @param {String}
 *            id 组件id
 * 
 * @return {L5.Component}
 */
L5.getCmp = function(id) {
	return L5.ComponentMgr.get(id);
};

/**
 * 
 * 
 * @private
 * @param {String}
 *            str
 * @return {String}
 */
L5.escapeRe = function(s) {
	return s.replace(/([.*+?^${}()|[\]\/\\])/g, "\\$1");
};

/**
 * @private
 */
L5.callback = function(cb, scope, args, delay) {
	if (typeof cb == "function") {
		if (delay) {
			cb.defer(delay, scope, args || []);
		} else {
			cb.apply(scope, args || []);
		}
	}
};

/**
 * 测试是否为数字，如果不是则返回默认值.
 * 
 * @param {Mixed}
 *            value 应为数字，如果不是也会有默认值
 * @param {Number}
 *            defaultValue 如果值不是数字，返回的默认值
 * @public
 * @return {Number} 数字
 */
L5.num = function(v, defaultValue) {
	if (typeof v != 'number' || isNaN(v)) {
		return defaultValue;
	}
	return v;
};

/**
 * Attempts to destroy any objects passed to it by removing all event listeners,
 * removing them from the DOM (if applicable) and calling their destroy
 * functions (if available). This method is primarily intended for arguments of
 * type {@link L5.Element} and {@link L5.Component}, but any subclass of
 * {@link L5.util.Observable} can be passed in. Any number of elements and/or
 * components can be passed into this function in a single call as separate
 * arguments.
 * 
 * @private
 * @param {Mixed}
 *            arg1 An {@link L5.Element} or {@link L5.Component} to destroy
 * @param {Mixed}
 *            arg2 (optional)
 * @param {Mixed}
 *            etc... (optional)
 */
L5.destroy = function() {
	for ( var i = 0, a = arguments, len = a.length; i < len; i++) {
		var as = a[i];
		if (as) {
			if (typeof as.destroy == 'function') {
				as.destroy();
			} else if (as.dom) {
				as.removeAllListeners();// 移除所有的监听器否则将会造成对象不能彻底销毁内存泄露
				as.remove();
			}
		}
	}
};

/**
 * 
 * 对数组的每个对象都执行一遍某个方法:
 * 
 * @private
 * 
 * @param {Array/NodeList/Mixed}
 *            array
 * @param {Function}
 *            fn 要执行的函数
 * @param {Object}
 *            scope 执行函数的scope
 */
L5.each = function(array, fn, scope) {
	if (typeof array.length == "undefined" || typeof array == "string") {
		array = [ array ];
	}
	for ( var i = 0, len = array.length; i < len; i++) {
		if (fn.call(scope || array[i], array[i], i, array) === false) {
			return i;
		}
	}
};

/**
 * 数组合并
 * 
 * @deprecated
 * @private
 */
L5.combine = function() {
	var as = arguments, l = as.length, r = [];
	for ( var i = 0; i < l; i++) {
		var a = as[i];
		if (L5.isArray(a)) {
			r = r.concat(a);
		} else if (a.length !== undefined && !a.substr) {
			r = r.concat(Array.prototype.slice.call(a, 0));
		} else {
			r.push(a);
		}
	}
	return r;
};

/**
 * 获取浏览器滚动条宽度.
 * 
 * @param {Boolean}
 *            force (optional) 是否重新计算(默认只计算一次).
 * 
 * @return {Number}
 */
L5.getScrollBarWidth = function(force) {
	if (!L5.isReady) {
		return 0;
	}
	var scrollWidth = null;
	if (force === true || scrollWidth === null) {
		// Append our div, do our calculation and then remove it
		var div = L5
				.getBody()
				.createChild(
						'<div class="l-hide-offsets" style="width:100px;height:50px;overflow:hidden;"><div style="height:200px;"></div></div>'), child = div
				.child('div', true);
		var w1 = child.offsetWidth;
		div.setStyle('overflow', (L5.isWebKit || L5.isGecko) ? 'auto'
				: 'scroll');
		var w2 = child.offsetWidth;
		div.remove();
		// Need to add 2 to ensure we leave enough space
		scrollWidth = w1 - w2 + 2;
	}
	return scrollWidth;
};

/**
 * 返回传入对象的类型. 如果对象是 null 或者 undefined 将会 返回 false 否则返回以下其中一个:
 * <ul>
 * <li><b>string</b>: 如果传入的对象是string</li>
 * <li><b>number</b>: 如果传入的对象是number</li>
 * <li><b>boolean</b>: 如果传入的对象是boolean值</li>
 * <li><b>date</b>: 如果传入的对象是Date对象</li>
 * <li><b>function</b>: 如果传入的对象是function引用</li>
 * <li><b>object</b>: 如果传入的对象是object</li>
 * <li><b>array</b>: 如果传入的对象是array</li>
 * <li><b>regexp</b>: 如果传入的对象是正则表达式</li>
 * <li><b>element</b>: 如果传入的对象是 DOM元素</li>
 * <li><b>nodelist</b>: 如果传入的对象是 DOM数组</li>
 * <li><b>textnode</b>: 如果传入的对象是 DOM文本节点 并且包含了非空格文本</li>
 * <li><b>whitespace</b>: 如果传入的对象是 DOM 文本节点 并且只包含空格文本</li>
 * 
 * @param {Mixed}
 *            object
 * @return {String}
 */
L5.type = function(o) {
	if (o === undefined || o === null) {
		return false;
	}
	if (o.htmlElement) {
		return 'element';
	}
	var t = typeof o;
	if (t == 'object' && o.nodeName) {
		switch (o.nodeType) {
		case 1:
			return 'element';
		case 3:
			return (/\S/).test(o.nodeValue) ? 'textnode' : 'whitespace';
		}
	}
	if (t == 'object' || t == 'function') {
		switch (o.constructor) {
		case Array:
			return 'array';
		case RegExp:
			return 'regexp';
		case Date:
			return 'date';
		}
		if (typeof o.length == 'number' && typeof o.item == 'function') {
			return 'nodelist';
		}
	}
	return t;
};

/**
 * 判断一个变量是不是undefined，如果不是undefined，返回true，否则返回false
 * 
 * @param {Mixed}
 *            v
 * 
 * @returns {Boolean}
 * 
 */
L5.isDefined = function(v) {
	return typeof v !== 'undefined';
};
/**
 * 如果传入的对象是null, undefined 或者一个空字符串则返回true.
 * 
 * @param {Mixed}
 *            value 需要测试的对象
 * @param {Boolean}
 *            allowBlank (可选) 如果允许空字符串则设置true(默认是false)
 * @return {Boolean}
 */
L5.isEmpty = function(v, allowBlank) {
	return v === null || v === undefined || (!allowBlank ? v === '' : false);
};

/**
 * 如果指定变量是空就返回指定默认值，否则返回原变量的值
 * 
 * @private
 * 
 * @param {Mixed}
 *            value 指定变量
 * @param {Mixed}
 *            defaultValue 指定默认值
 * @param {Boolean}
 *            allowBlank (optional) 是否运行空字符串 (默认是false)
 * @return {Mixed} value
 */
L5.value = function(v, defaultValue, allowBlank) {
	return L5.isEmpty(v, allowBlank) ? defaultValue : v;
};

/**
 * 如果传入的参数是数组，就返回true，否则返回false.
 * 
 * @param {Object}
 *            object 需要测试的对象
 * @return {Boolean}
 */
L5.isArray = function(v) {
	return v && typeof v.length == 'number' && typeof v.splice == 'function';
};

/**
 * 如果传入的参数是日期类型，就返回true，否则返回false.
 * 
 * @param {Object}
 *            object 需要测试的对象
 * @return {Boolean}
 */
L5.isDate = function(v) {
	return v && typeof v.getFullYear == 'function';
};

/**
 * @constructor
 */
L5.Exception = function(code, message, javaStack) {
	this.code = code;
	this.message = message;
	var name;
	if (javaStack) {
		this.javaStack = javaStack;
	}
};
L5.Exception.prototype = new Error();

L5.Exception.prototype.toString = function() {
	return this.message;
};

L5.ns("L5", "L5.util", "L5.grid", "L5.dd", "L5.tree", "L5.model", "L5.form",
		"L5.menu", "L5.state", "L5.lib", "L5.layout", "L5.app", "L5.ux");

/**
 * 删除某对象的所有iframe子对象
 * 
 * @param {Object}
 *            obj 删除iframe对象的父对象
 */
L5.releaseIframe = function(obj) {
	if (obj == null)
		obj = document.body;
	if (L5.fly(obj)) {
		var iframes = L5.fly(obj).query('iframe');
		if (iframes) {
			for ( var i = 0; i < iframes.length; i++) {
				if (iframes[i].src) {
					try {
						iframes[i].src = false;
						iframes[i].contentWindow.document.write('');
						L5.removeNode(iframes[i]);
						delete iframes[i];
					} catch (e) {
						// ignore
					}
				}
			}
		}
	}
	if (L5.isIE) {
		setTimeout(CollectGarbage, 1);
		setTimeout(CollectGarbage, 10);
	}
}

/**
 * IE 或 Nescape浏览器中触发事件
 * 
 * @param {String/HTMLElement}
 *            control dom元素或者dom元素的id
 * @param {String}
 *            eventName 事件名称
 */
L5.fireEvent = function(control, eventName) {
	var ele;
	if (typeof control == "string") {
		ele = document.getElementById(control);
	} else {
		ele = control;
	}
	if (document.all) // For IE.
	{
		eval("ele.fireEvent('on" + eventName + "');");
	} else // For Nescape
	{
		var e = document.createEvent('HTMLEvents');
		e.initEvent(eventName, true, true);
		ele.dispatchEvent(e);
	}
};
