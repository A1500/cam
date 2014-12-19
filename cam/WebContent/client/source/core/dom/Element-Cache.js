/**
 * 提供获取L5.Element对象的静态方法，同时负责L5.Element对象的缓存
 */
(function() {
	var El = L5.Element;
	/**
	 * 静态变量；缓存L5.Element对象，dom的id做索引。
	 * 
	 * @private
	 */
	L5.Element.cache = {};

	var docEl;

	/**
	 * 静态方法；获取dom元素对应的L5.Element对象；可以通过dom的id属性获取；可以通过dom对象获取；
	 * <p>
	 * 
	 * @param {Mixed}
	 *            el dom节点或dom节点的id
	 * @return {L5.Element}
	 * @static
	 */
	L5.Element.get = function(el) {
		var ex, elm, id;
		if (!el) {
			return null;
		}
		if (typeof el == "string") { // element id
			if (!(elm = document.getElementById(el))) {
				return null;
			}
			if (ex = El.cache[el]) {
				ex.dom = elm;
			} else {
				ex = El.cache[el] = new El(elm);
			}
			return ex;
		} else if (el.tagName) { // dom element
			if (!(id = el.id)) {
				id = L5.id(el);
			}
			if (ex = El.cache[id]) {
				ex.dom = el;
			} else {
				ex = El.cache[id] = new El(el);
			}
			return ex;
		} else if (el instanceof El) {
			if (el != docEl) {
				el.dom = document.getElementById(el.id) || el.dom; // refresh
				El.cache[el.id] = el;
			}
			return el;
		} else if (el.isComposite) {
			return el;
		} else if (L5.isArray(el)) {
			return El.select(el);
		} else if (el == document) {
			// create a bogus element object representing the document object
			if (!docEl) {
				var f = function() {
				};
				f.prototype = El.prototype;
				docEl = new f();
				docEl.dom = document;
			}
			return docEl;
		}
		return null;
	};

	/**
	 * 释放缓存
	 * 
	 * @private
	 */
	L5.Element.uncache = function(el) {
		for ( var i = 0, a = arguments, len = a.length; i < len; i++) {
			if (a[i]) {
				delete El.cache[a[i].id || a[i]];
			}
		}
	};

	/**
	 * 清理缓存对dom元素的引用以及事件监听以便浏览器回收垃圾。
	 */
	var garbageCollect = function() {
		if (!L5.enableGarbageCollector) {
			clearInterval(El.collectorThread);
			return;
		}
		for ( var eid in El.cache) {
			var el = El.cache[eid], d = el.dom;
			if (!d || !d.parentNode
					|| (!d.offsetParent && !document.getElementById(eid))) {
				delete El.cache[eid];
				if (d && L5.enableListenerCollection) {
					L5.EventManager.removeAll(d);
				}
			}
		}
	}
	/**
	 * 每30秒执行一次缓存清理的"线程"
	 */
	L5.Element.collectorThreadId = setInterval(garbageCollect, 30000);

	var flyFn = function() {
	};
	flyFn.prototype = El.prototype;

	var _cls = new flyFn();

	/**
	 * dom is optional
	 * 
	 * @constructor
	 */
	L5.Element.Flyweight = function(dom) {
		this.dom = dom;
	};

	L5.Element.Flyweight.prototype = _cls;

	L5.Element.Flyweight.prototype.isFlyweight = true;

	L5.Element._flyweights = {};

	/**
	 * <p>
	 * 获取对应的共享的L5.Element对象；可以同时有很多个共享的L5.Element对象，用name区分(参考该方法第2个参数)；
	 * <p>
	 * fly与get相比有何不同：
	 * <li>调用get方法会为普通的dom创建一个L5.Element对象，但是fly不会创建新的L5.Element而是共享内存</li>
	 * <li>当页面节点过多，需要调用，或者渲染需要用get方法的时候会造成大量的对象创建的动作，然后还要缓存，性能急剧下降，但是如果用fly只是创建一个对象效率当然很高</li>
	 * <li>由于全局共享，fly变得不是很安全，假如我前面用了对一个对象用了fly，不知道会在某处被改变或者在某处被覆盖了。</li>
	 * 
	 * @param {String/HTMLElement}
	 *            el dom节点或dom节点的id
	 * @param {String}
	 *            name (optional) 共享对象名 ，默认是"_global"
	 * @static
	 * @return {L5.Element} 共享的L5.Element对象
	 */
	L5.Element.fly = function(el, name) {
		named = name || '_global';
		el = L5.getDom(el);
		if (!el) {
			return null;
		}

		if ((El._flyweights != undefined) && !El._flyweights[named]) {
			El._flyweights[named] = new El.Flyweight();
		}
		if ((El._flyweights != undefined)
				&& (El._flyweights[named] != undefined))
			El._flyweights[named].dom = el;
		if ((El._flyweights != undefined)
				&& (El._flyweights[named] != undefined)) {
			return El._flyweights[named];
		} else {
			return null;
		}
	};

	/**
	 * 同(@link #get)
	 */
	L5.get = El.get;

	/**
	 * 同(@link #fly)
	 */
	L5.fly = El.fly;

	// 窗口关闭后清缓存
	L5.EventManager.on(window, 'unload', function() {
		delete El.cache;
		delete El._flyweights;
	});
})();
