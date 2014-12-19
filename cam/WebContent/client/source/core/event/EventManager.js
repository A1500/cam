/**
 * Registers event handlers that want to receive a normalized EventObject
 * instead of the standard browser event and provides several useful events
 * directly. See {@link L5.EventObject} for more details on normalized event
 * objects.
 * 
 * @constructor
 * 
 */
L5.EventManager = function() {
	// do nothing
};

(function() {

	var E = L5.lib.Event, D = L5.lib.Dom;

	var propRe = /^(?:scope|delay|buffer|single|stopEvent|preventDefault|stopPropagation|normalized|args|delegate)$/;

	/**
	 * 缓存的监听信息
	 * <li>一个dom元素有很多事件</li>
	 * <li>每个事件可以有多个监听函数</li>
	 * 
	 * @private
	 */
	var elHash = {};

	/**
	 * @private
	 */
	var createBuffered = function(h, o) {
		var task = new L5.util.DelayedTask(h);
		return function(e) {
			// create new event object impl so new events don't wipe out
			// properties
			e = new L5.EventObjectImpl(e);
			task.delay(o.buffer, h, null, [ e ]);
		};
	};

	/**
	 * @private
	 */
	var createSingle = function(h, el, ename, fn, scope) {
		return function(e) {
			L5.EventManager.removeListener(el, ename, fn, scope);
			h(e);
		};
	};

	/**
	 * @private
	 */
	var createDelayed = function(h, o) {
		return function(e) {
			// create new event object impl so new events don't wipe out
			// properties
			e = new L5.EventObjectImpl(e);
			setTimeout(function() {
				h(e);
			}, o.delay || 10);
		};
	};

	/**
	 * 为某个元素注册监听信息，信息存储按照既定规则(方法内部有说明)，最后调用L5.lib.Event的addListener注册浏览器事件
	 * 
	 * @param {Mixed}
	 *            el 可以是id也可以是包装的{@link L5.Element}元素
	 * @param {String}
	 *            ename 事件名称
	 * @param {Function}
	 *            fn 事件触发以后调用的回调
	 * @param {Function}
	 *            wrap 事件回调包装
	 * @param {Object}
	 *            scope （可选）作用域
	 * @private
	 */
	var addListener = function(el, ename, fn, wrap, scope) {
		var id = L5.id(el);
		if (!elHash[id]) {
			elHash[id] = {};
		}
		// 相当于缓存el（dom，L5.Element等）每个缓存的元素对应一个json对象，
		// 以eventName命名为索引，值是一个数组，数组是注册的一系列的监听信息
		// 缓存元素对应一个对象，对象以eventName命名为索引，值是一个数组
		var es = elHash[id];
		if (!es[ename]) {
			es[ename] = [];
		}
		var ls = es[ename];
		// 一个事件可以有多个监听函数
		// 数组中每个元素都是注册的监听信息
		ls.push({
			id : id,
			ename : ename,
			fn : fn,
			wrap : wrap,
			scope : scope
		});

		E.on(el, ename, wrap);
		// workaround for jQuery
		if (ename == "mousewheel" && el.addEventListener) {
			el.addEventListener("DOMMouseScroll", wrap, false);
			E.on(window, 'unload', function() {
				el.removeEventListener("DOMMouseScroll", wrap, false);
			});
		}
		// fix stopped mousedowns on the document
		if (ename == "mousedown" && el == document) {
			L5.EventManager.stoppedMouseDownEvent.addListener(wrap);
		}
	};

	/**
	 * 移除元素上的某个监听器
	 * 
	 * @param {Mixed}
	 *            el 可以是id也可以是包装的{@link L5.Element}元素
	 * @param {String}
	 *            ename 事件名称
	 * @param {Function}
	 *            fn 事件触发以后调用的回调
	 * @param {Object}
	 *            scope （可选）作用域
	 */
	var removeListener = function(el, ename, fn, scope) {
		el = L5.getDom(el);

		var id = L5.id(el), es = elHash[id], wrap;
		if (es) {
			var ls = es[ename], l;
			if (ls) {
				for ( var i = 0, len = ls.length; i < len; i++) {
					l = ls[i];
					if (l.fn == fn && (!scope || l.scope == scope)) {
						wrap = l.wrap;
						E.un(el, ename, wrap);
						ls.splice(i, 1);
						break;
					}
				}
			}
		}
		if (ename == "mousewheel" && el.addEventListener && wrap) {
			el.removeEventListener("DOMMouseScroll", wrap, false);
		}
		// fix stopped mousedowns on the document
		if (ename == "mousedown" && el == document && wrap) {
			L5.EventManager.stoppedMouseDownEvent.removeListener(wrap);
		}
	};
	/**
	 * 移除元素上所有的监听器
	 * 
	 * @param {Mixed}
	 *            el 可以是id也可以是包装的{@link L5.Element}元素
	 */
	var removeAll = function(el) {
		el = L5.getDom(el);
		var id = L5.id(el), es = elHash[id], ls;
		if (es) {
			for ( var ename in es) {
				if (es.hasOwnProperty(ename)) {
					ls = es[ename];
					for ( var i = 0, len = ls.length; i < len; i++) {
						E.un(el, ename, ls[i].wrap);
						ls[i] = null;
					}
				}
				es[ename] = null;
			}
			delete elHash[id];
		}
	};
	/**
	 * 移除元素上指定事件名称的所有监听器
	 * 
	 * @param {Mixed}
	 *            el 可以是id也可以是包装的{@link L5.Element}元素
	 * @param {String}
	 *            ename 事件名称
	 */
	var removeAllByEvent = function(el, ename) {
		el = L5.getDom(el);
		var id = L5.id(el), es = elHash[id], ls;
		if (es) {
			if (es.hasOwnProperty(ename)) {
				ls = es[ename];
				for ( var i = 0, len = ls.length; i < len; i++) {
					E.un(el, ename, ls[i].wrap);
					ls[i] = null;
				}
			}
			es[ename] = null;
		}
	};

	/**
	 * 创建监听器
	 * 
	 * @param {Mixed}
	 *            element 可以是id也可以是包装的{@link L5.Element}元素
	 * @param {String}
	 *            ename 事件名称
	 * @param {Object}
	 *            opt 配置项包含 delay stopEvent等等
	 * @param {Function}
	 *            fn 事件触发以后调用的回调
	 * @param {Object}
	 *            scope （可选）作用域
	 */
	var listen = function(element, ename, opt, fn, scope) {
		var o = (!opt || typeof opt == "boolean") ? {} : opt;
		fn = fn || o.fn;
		scope = scope || o.scope;
		var el = L5.getDom(element);
		if (!el) {
			throw "Error listening for \"" + ename + '\". Element "' + element
					+ '" doesn\'t exist.';
		}
		var h = function(e) {
			// prevent errors while unload occurring
			if (!window['L5']) {
				return;
			}
			e = L5.EventObject.setEvent(e);
			var t;
			if (o.delegate) {
				t = e.getTarget(o.delegate, el);
				if (!t) {
					return;
				}
			} else {
				t = e.target;
			}
			if (o.stopEvent === true) {
				e.stopEvent();
			}
			if (o.preventDefault === true) {
				e.preventDefault();
			}
			if (o.stopPropagation === true) {
				e.stopPropagation();
			}

			if (o.normalized === false) {
				e = e.browserEvent;
			}

			fn.call(scope || el, e, t, o);
		};
		if (o.delay) {
			h = createDelayed(h, o);
		}
		if (o.single) {
			h = createSingle(h, el, ename, fn, scope);
		}
		if (o.buffer) {
			h = createBuffered(h, o);
		}

		addListener(el, ename, fn, h, scope);
		return h;
	};

	/**
	 * @private
	 */
	L5.EventManager.stoppedMouseDownEvent = new L5.util.Event();

	/**
	 * 给某个元素增加事件监听函数. 该方法有一个缩写版： {@link #on}
	 * 
	 * @param {String/HTMLElement}
	 *            el 要监听的HTMLElement或者id
	 * @param {String}
	 *            eventName 要监听的事件名称
	 * @param {Function}
	 *            handler 事件监听函数，该函数必须有下面这些参数:
	 *            <ul>
	 *            <li>evt : EventObject<div class="sub-desc">
	 *            {@link L5.EventObject EventObject} 事件对象.</div></li>
	 *            <li>t : Element<div class="sub-desc">
	 *            {@link L5.Element Element} 事件的目标对象. </div></li>
	 *            <li>o : Object<div
	 *            class="sub-desc">选项、事件监听函数的配置属性，通过addListener方法传进来.</div></li>
	 *            </ul>
	 * @param {Object}
	 *            scope (optional) 监听函数的执行范围
	 * @param {Object}
	 *            options (optional) 选项、事件监听函数的配置属性.
	 *            可以包含下列属性(也可以包含其他开发人员自定义的个性化属性):
	 *            <ul>
	 *            <li>scope {Object} : 事件监听函数的scope.</li>
	 *            <li>delegate {String} : 用来确定事件目标对象的选择器</li>
	 *            <li>stopEvent {Boolean} : 是否停止事件：停止事件传递、停止事件的默认动作.</li>
	 *            <li>preventDefault {Boolean} : 是否停止事件默认动作</li>
	 *            <li>stopPropagation {Boolean} : 是否停止事件传递</li>
	 *            <li>normalized {Boolean} : False
	 *            表示传递给事件监听函数的event参数使用浏览器事件对象代替楼上框架包装的事件对象</li>
	 *            <li>delay {Number} : 延迟调用事件监听函数</li>
	 *            <li>single {Boolean} : True .</li>
	 *            <li>buffer {Number} :
	 *            延迟调用事件监听函数，当新的事件触发了旧的还在"延迟"中时，旧的被删掉，新的占据旧的位置.</li>
	 *            </ul>
	 *            <br>
	 *            <p>
	 *            可以通过： {@link L5.Element#addListener} 看相关例子
	 *            </p>
	 */
	L5.EventManager.addListener = function(element, eventName, fn, scope,
			options) {
		if (typeof eventName == "object") {
			var o = eventName;
			for ( var e in o) {
				if (propRe.test(e)) {
					continue;
				}
				if (typeof o[e] == "function") {
					// shared options
					listen(element, e, o, o[e], o.scope);
				} else {
					// individual options
					listen(element, e, o[e]);
				}
			}
			return;
		}
		return listen(element, eventName, options, fn, scope);
	};

	/**
	 * 删除一个事件监听函数，该方法有一个缩写版：
	 * {@link #un} . 通常直接使用L5.Element的removeListener方法更为方便。
	 * 
	 * @param {String/HTMLElement}
	 *            el 元素或元素的id
	 * @param {String}
	 *            eventName 事件名称
	 * @param {Function}
	 *            fn 要删除的事件处理函数
	 */
	L5.EventManager.removeListener = function(element, eventName, fn, scope) {
		return removeListener(element, eventName, fn, scope);
	};

	/**
	 * 删除一个元素的所有监听器.
	 * 
	 * @param {String/HTMLElement}
	 *            el The id or html element from which to remove the event
	 * @public
	 */
	L5.EventManager.removeAll = function(element) {
		return removeAll(element);
	};

	/**
	 * 删除一个事件的所有监听器
	 * 
	 * @public
	 */
	L5.EventManager.removeAllByEvent = function(element, eventName) {
		return removeAllByEvent(element, eventName);
	};

})();

(function() {
	/**
	 * 自定义事件：文档加载完成事件
	 */
	var docReadyEvent;

	/**
	 * 一个定时执行的函数
	 */
	var docReadyProcId;

	/**
	 * 
	 */
	var docReadyFired = false;

	var resizeEvent, resizeTask;

	var E = L5.lib.Event;
	var D = L5.lib.Dom;

	/**
	 * 判断文档是否已经加载完成，ie专用
	 */
	var checkReadyState = function(e) {
		if (L5.isIE && doScrollChk()) {
			return true;
		}

		if (document.readyState == "complete") {
			fireDocReady();
			return true;
		}

		if (!docReadyFired) {
			// 再次调用这个函数
			docReadyProcId = setTimeout(arguments.callee, 0)
		}
		return false;
	}

	/**
	 * 文档没有加载完，scroll会exception，通过这个异常来判断文档是否加载完
	 * 
	 * @private
	 */
	var doScrollChk = function() {
		if (window != top) {
			return false;
		}

		try {
			document.documentElement.doScroll('left');
		} catch (e) {
			return false;
		}

		fireDocReady();
		return true;
	};

	/**
	 * 触发自定义事件：文档加载完成；同时做必要的事件监听清理恢复到初始状态。
	 * 
	 * @private
	 */
	var fireDocReady = function() {
		if (!docReadyFired) {
			docReadyFired = true;
			L5.isReady = true;
			// 清理
			if (docReadyProcId) {
				clearInterval(docReadyProcId);
			}
			if (L5.isGecko || L5.isOpera) {
				document.removeEventListener("DOMContentLoaded", fireDocReady,
						false);
			}
			if (L5.isIE) {
				document.detachEvent('onreadystatechange', checkReadyState);
			}
			// fire
			if (docReadyEvent) {
				docReadyEvent.fire();
				docReadyEvent.clearListeners();
			}
		}
	};

	/**
	 * 初始自定义事件：文档加载完成
	 * 
	 * @private
	 */
	var initDocReadyEvent = function() {
		docReadyEvent = new L5.util.Event();
		// 注册事件
		if (L5.isGecko || L5.isOpera) {
			document.addEventListener("DOMContentLoaded", fireDocReady, false);
		} else if (L5.isIE) {
			if (!checkReadyState()) {
				document.attachEvent('onreadystatechange', checkReadyState);
			}
		} else if (L5.isSafari) {
			docReadyProcId = setInterval(function() {
				var rs = document.readyState;
				if (rs == "complete") {
					fireDocReady();
				}
			}, 10);
		}
		// no matter what, make sure it fires on load
		E.on(window, "load", fireDocReady);
	};

	/**
	 * 触发自定义事件：窗口大小变化
	 */
	var doResizeEvent = function() {
		resizeEvent.fire(D.getViewWidth(), D.getViewHeight());
	};

	// exposed only to allow manual firing
	var fireWindowResize = function() {
		if (resizeEvent) {
			if ((L5.isIE || L5.isAir) && resizeTask) {
				resizeTask.delay(50);
			} else {
				resizeEvent.fire(D.getViewWidth(), D.getViewHeight());
			}
		}
	};

	/**
	 * The frequency, in milliseconds, to check for text resize events (defaults
	 * to 50)
	 */
	L5.EventManager.textResizeInterval = 50;

	/**
	 * 注册一个文档加载完成事件的监听函数. 该方法有个缩写版：L5.onReady().
	 * 
	 * @param {Function}
	 *            fn 监听函数
	 * @param {Object}
	 *            scope (optional) 监听函数的执行范围
	 * @param {boolean}
	 *            options (optional) An object containing standard
	 *            {@link #addListener} options
	 */
	L5.EventManager.onDocumentReady = function(fn, scope, options) {
		if (docReadyFired) { // if it already fired
			docReadyEvent.addListener(fn, scope, options);
			docReadyEvent.fire();
			docReadyEvent.clearListeners();
			return;
		}
		if (!docReadyEvent) {
			initDocReadyEvent();
		}
		options = options || {};
		if (!options.delay) {
			options.delay = 1;
		}

		docReadyEvent.addListener(fn, scope, options);
	};

	/**
	 * Fires when the window is resized and provides resize event buffering (50
	 * milliseconds), passes new viewport width and height to handlers.
	 * 
	 * @param {Function}
	 *            fn The method the event invokes
	 * @param {Object}
	 *            scope An object that becomes the scope of the handler
	 * @param {boolean}
	 *            options
	 */
	L5.EventManager.onWindowResize = function(fn, scope, options) {
		if (!resizeEvent) {
			resizeEvent = new L5.util.Event();
			resizeTask = new L5.util.DelayedTask(doResizeEvent);
			E.on(window, "resize", fireWindowResize, this);
		}
		resizeEvent.addListener(fn, scope, options);
	};

	/**
	 * 删除一个窗口大小变化事件的监听函数
	 * 
	 * @param {Function}
	 *            fn 要删除的监听函数
	 * @param {Object}
	 *            scope 监听函数的执行范围
	 */
	L5.EventManager.removeResizeListener = function(fn, scope) {
		if (resizeEvent) {
			resizeEvent.removeListener(fn, scope);
		}
	};

})();
/**
 * 给某个元素增加事件监听函数. {@link #addListener}.
 * 
 * @param {String/HTMLElement}
 *            el 要增加事件监听函数的元素或元素id
 * @param {String}
 *            eventName 事件名称
 * @param {Function}
 *            handler 要增加的事件监听函数
 * @param {Object}
 *            scope (optional) 监听函数执行时的scope
 * @param {Object}
 *            options (optional) {@link #addListener}
 * @member L5.EventManager
 * @method on
 */
L5.EventManager.on = L5.EventManager.addListener;
/**
 * 删除某个元素的某个事件监听函数
 * {@link #removeListener}.
 * 
 * @param {String/HTMLElement}
 *            el 要删除监听函数的元素或元素的id
 * @param {String}
 *            eventName 事件名称
 * @param {Function}
 *            fn 要删除的事件监听函数
 * @return {Boolean} 
 * @member L5.EventManager
 * @method un
 */
L5.EventManager.un = L5.EventManager.removeListener;

/**
 * Fires when the document is ready (before onload and before images are
 * loaded). {@link L5.EventManager#onDocumentReady}.
 * 
 * @param {Function}
 *            fn The method the event invokes
 * @param {Object}
 *            scope An object that becomes the scope of the handler
 * @param {boolean}
 *            options (optional) An object containing standard
 *            {@link #addListener} options
 * @member L5
 * @method onReady
 */
L5.onReady = L5.EventManager.onDocumentReady;

// Initialize doc classes
(function() {
	var initL5Css = function() {
		// find the body element
		var bd = document.body || document.getElementsByTagName('body')[0];
		if (!bd) {
			return false;
		}
		var cls = [
				' ',
				L5.isIE ? "L5-ie "
						+ (L5.isIE6 ? 'L5-ie6' : (L5.isIE7 ? 'L5-ie7'
								: 'L5-ie8')) : L5.isGecko ? "L5-gecko "
						+ (L5.isGecko2 ? 'L5-gecko2' : 'L5-gecko3')
						: L5.isOpera ? "L5-opera" : L5.isSafari ? "L5-safari"
								: L5.isChrome ? "L5-chrome" : "" ];

		if (L5.isMac) {
			cls.push("L5-mac");
		}
		if (L5.isLinux) {
			cls.push("L5-linux");
		}
		if (L5.isBorderBox) {
			cls.push('L5-border-box');
		}
		if (L5.isStrict) { // add to the parent to allow for selectors like
			// ".L5-strict .L5-ie"
			var p = bd.parentNode;
			if (p) {
				p.className += ' L5-strict';
			}
		}
		bd.className += cls.join(' ');
		return true;
	}

	if (!initL5Css()) {
		L5.onReady(initL5Css);
	}

	// 放在这里释放iframe的原因是要将事件放在Element的缓存的释放之前。
	L5.EventManager.on(window, 'unload', function() {
		L5.releaseIframe();
	});
	
	//
	L5.onReady(function() {		
		if (typeof initData != 'undefined' && initData instanceof Function)
			initData();
		for ( var p in L5.initObj) {
			if (L5.initObj[p] instanceof Function)
				L5.initObj[p]();
		}
		// 执行绑定
		L5.bindingdata();
		for (var m in L5.loadData) {
			if (L5.loadData[m] instanceof Function)
				L5.loadData[m]();
		}
		if (typeof init != 'undefined' && init instanceof Function)
			init(); // 开发人员实现该方法，做初始化操作
	});	
	
})();
