/**
 * @constructor
 */
L5.lib.Event = function() {

};
(function() {
	// 内部变量
	var loadComplete = false;
	/**
	 * 所有的事件处理函数,包括监听的DOM元素、事件名称、处理函数
	 * 
	 * @private
	 */
	var listeners = [];
	var unloadListeners = [];
	var retryCount = 0;
	var onAvailStack = [];
	var counter = 0;
	var lastError = null;

	L5.lib.Event.POLL_RETRYS = 200;
	L5.lib.Event.POLL_INTERVAL = 20;
	L5.lib.Event.EL = 0;
	L5.lib.Event.TYPE = 1;
	L5.lib.Event.FN = 2;
	L5.lib.Event.WFN = 3;
	L5.lib.Event.OBJ = 3;
	L5.lib.Event.ADJ_SCOPE = 4;
	L5.lib.Event._interval = null;
	L5.lib.Event.elCache = {};
	L5.lib.Event.clearCache = function() {
	};
	/**
	 * 设置Interval不断运行_tryPreloadAttach方法。
	 * _tryPreloadAttach不断检测onAvailStack数组中的每个对象对应的dom是否可用，可用就行行对应方法，不可用继续循环执行，最后清除
	 */
	L5.lib.Event.startInterval = function() {
		if (!this._interval) {
			var self = this;
			var callback = function() {
				self._tryPreloadAttach();
			};
			this._interval = setInterval(callback, this.POLL_INTERVAL);

		}
	};

	/**
	 * 设置节点到onAvailStack包含一系列信息，供_tryPreloadAttach去检测执行
	 */
	L5.lib.Event.onAvailable = function(p_id, p_fn, p_obj, p_override) {
		onAvailStack.push({
			id : p_id,
			fn : p_fn,
			obj : p_obj,
			override : p_override,
			checkReady : false
		});

		retryCount = this.POLL_RETRYS;
		// 设置好以后就开始执行间歇检测
		this.startInterval();
	};
	/**
	 * 为dom注册事件
	 * 
	 * @param {L5.Element/String/dom}
	 *            el 要注册事件的对象
	 * @param {String}
	 *            eventName事件名称
	 * @fn {Function} fn 事件触发后调用的回调
	 */
	L5.lib.Event.addListener = function(el, eventName, fn) {
		el = L5.getDom(el);
		if (!el || !fn) {
			return false;
		}

		if ("unload" == eventName) {
			unloadListeners[unloadListeners.length] = [ el, eventName, fn ];
			return true;
		}

		// prevent unload errors with simple check
		var wrappedFn = function(e) {
			return typeof L5 != 'undefined' ? fn(L5.lib.Event.getEvent(e))
					: false;
		};

		var li = [ el, eventName, fn, wrappedFn ];

		var index = listeners.length;
		listeners[index] = li;

		this.doAdd(el, eventName, wrappedFn, false);
		return true;
	};

	/**
	 * 为dom移除事件
	 * 
	 * @param {L5.Element/String/dom}
	 *            el 要移除事件的对象
	 * @param {String}
	 *            eventName 事件名称
	 * @fn {Function} fn 事件触发后调用的回调
	 */
	L5.lib.Event.removeListener = function(el, eventName, fn) {
		var i, len;

		el = L5.getDom(el);

		if (!fn) {
			return this.purgeElement(el, false, eventName);
		}

		if ("unload" == eventName) {

			for (i = 0, len = unloadListeners.length; i < len; i++) {
				var li = unloadListeners[i];
				if (li && li[0] == el && li[1] == eventName && li[2] == fn) {
					unloadListeners.splice(i, 1);
					return true;
				}
			}

			return false;
		}

		var cacheItem = null;

		var index = arguments[3];

		if ("undefined" == typeof index) {
			index = this._getCacheIndex(el, eventName, fn);
		}

		if (index >= 0) {
			cacheItem = listeners[index];
		}

		if (!el || !cacheItem) {
			return false;
		}

		this.doRemove(el, eventName, cacheItem[this.WFN], false);

		delete listeners[index][this.WFN];
		delete listeners[index][this.FN];
		listeners.splice(index, 1);

		return true;

	};

	/**
	 * 获取事件对应绑定的节点
	 */
	L5.lib.Event.getTarget = function(ev, resolveTextNode) {
		ev = ev.browserEvent || ev;
		var t = ev.target || ev.srcElement;
		return this.resolveTextNode(t);
	};

	L5.lib.Event.resolveTextNode = function(node) {
		if (L5.isSafari && node && 3 == node.nodeType) {
			return node.parentNode;
		} else {
			return node;
		}
	};

	L5.lib.Event.getPageX = function(ev) {
		ev = ev.browserEvent || ev;
		var x = ev.pageX;
		if (!x && 0 !== x) {
			x = ev.clientX || 0;

			if (L5.isIE) {
				x += this.getScroll()[1];
			}
		}

		return x;
	};

	L5.lib.Event.getPageY = function(ev) {
		ev = ev.browserEvent || ev;
		var y = ev.pageY;
		if (!y && 0 !== y) {
			y = ev.clientY || 0;

			if (L5.isIE) {
				y += this.getScroll()[0];
			}
		}

		return y;
	};

	L5.lib.Event.getXY = function(ev) {
		ev = ev.browserEvent || ev;
		return [ this.getPageX(ev), this.getPageY(ev) ];
	};

	/**
	 * 返回与事件的目标节点相关的节点。
	 * 
	 * 对于 mouseover 事件来说，该属性是鼠标指针移到目标节点上时所离开的那个节点。
	 * 
	 * 对于 mouseout 事件来说，该属性是离开目标时，鼠标指针进入的节点。
	 * 
	 * 对于其他类型的事件来说，这个属性没有用。
	 * 
	 */
	L5.lib.Event.getRelatedTarget = function(ev) {
		ev = ev.browserEvent || ev;
		var t = ev.relatedTarget;
		if (!t) {
			if (ev.type == "mouseout") {
				t = ev.toElement;
			} else if (ev.type == "mouseover") {
				t = ev.fromElement;
			}
		}

		return this.resolveTextNode(t);
	};

	/**
	 * 返回事件的发生时间
	 * 
	 * @param ev
	 */
	L5.lib.Event.getTime = function(ev) {
		ev = ev.browserEvent || ev;
		if (!ev.time) {
			var t = new Date().getTime();
			try {
				ev.time = t;
			} catch (ex) {
				lastError = ex;
				return t;
			}
		}

		return ev.time;
	};

	/**
	 * 停止事件，包括停止传播，阻止事件触发调用方法
	 * 
	 * @param {Event}
	 *            ev 要停止的事件
	 */
	L5.lib.Event.stopEvent = function(ev) {
		this.stopPropagation(ev);
		this.preventDefault(ev);
	};

	/**
	 * 终止事件在传播过程的捕获、目标处理或起泡阶段进一步传播。
	 * <p>
	 * 调用该方法后，该节点上处理该事件的处理程序将被调用，事件不再被分派到其他节点
	 * 
	 * @param ev
	 *            要终止传播的事件
	 */
	L5.lib.Event.stopPropagation = function(ev) {
		ev = ev.browserEvent || ev;
		if (ev.stopPropagation) {
			ev.stopPropagation();
		} else {
			ev.cancelBubble = true;
		}
	};

	/**
	 * 阻止某个事件触发默认动作
	 * 
	 * @param ev
	 *            要阻止的某个事件
	 */
	L5.lib.Event.preventDefault = function(ev) {
		ev = ev.browserEvent || ev;
		if (ev.preventDefault) {
			ev.preventDefault();
		} else {
			ev.returnValue = false;
		}
	};

	/**
	 * 获取event事件
	 * 
	 * @param {Event}
	 *            e 事件
	 */
	L5.lib.Event.getEvent = function(e) {
		var ev = e || window.event;
		if (!ev) {// 假如没找到就不断的递归向上找
			var c = this.getEvent.caller;
			while (c) {
				ev = c.arguments[0];
				if (ev && Event == ev.constructor) {// 直到在某个地方找到事件就break
					break;
				}
				c = c.caller;
			}
		}
		return ev;
	};

	L5.lib.Event.getCharCode = function(ev) {
		ev = ev.browserEvent || ev;
		return ev.charCode || ev.keyCode || 0;
	};

	L5.lib.Event._getCacheIndex = function(el, eventName, fn) {
		for ( var i = 0, len = listeners.length; i < len; ++i) {
			var li = listeners[i];
			if (li && li[this.FN] == fn && li[this.EL] == el
					&& li[this.TYPE] == eventName) {
				return i;
			}
		}

		return -1;
	};

	L5.lib.Event.getEl = function(id) {
		return document.getElementById(id);
	};

	L5.lib.Event._load = function(e) {
		loadComplete = true;
		var EU = L5.lib.Event;

		if (L5.isIE) {
			EU.doRemove(window, "load", EU._load);
		}
	};

	/**
	 * 反复检测onAvailStack中的每个对象id对应的元素是否可以用，如果可用，那就执行对应的方法，否则放到不可用队列继续等待检测
	 * 每隔一段时间检测一次
	 */
	L5.lib.Event._tryPreloadAttach = function() {

		if (this.locked) {
			return false;
		}

		this.locked = true;

		var tryAgain = !loadComplete;
		if (!tryAgain) {
			tryAgain = (retryCount > 0);
		}

		var notAvail = [];

		for ( var i = 0, len = onAvailStack.length; i < len; ++i) {
			var item = onAvailStack[i];
			if (item) {
				var el = this.getEl(item.id);

				if (el) {
					if (!item.checkReady || loadComplete || el.nextSibling
							|| (document && document.body)) {

						var scope = el;
						if (item.override) {
							if (item.override === true) {
								scope = item.obj;
							} else {
								scope = item.override;
							}
						}
						item.fn.call(scope, item.obj);
						onAvailStack[i] = null;
					}
				} else {
					notAvail.push(item);
				}
			}
		}

		retryCount = (notAvail.length === 0) ? 0 : retryCount - 1;

		if (tryAgain) {

			this.startInterval();
		} else {
			clearInterval(this._interval);
			this._interval = null;
		}

		this.locked = false;

		return true;

	};

	/**
	 * 将元素上所有的事件全都清除
	 * 
	 * @param {L5.Element}
	 *            el 要清除事件的元素
	 * @param {Boolean}
	 *            recurse (可选）是否递归清除事件，默认否
	 * @param {String}
	 *            eventName (可选）假如有eventName只是清除这个事件，否则清除全部事件， 默认全部
	 */
	L5.lib.Event.purgeElement = function(el, recurse, eventName) {
		var elListeners = this.getListeners(el, eventName);
		if (elListeners) {
			for ( var i = 0, len = elListeners.length; i < len; ++i) {
				var l = elListeners[i];
				this.removeListener(el, l.type, l.fn);
			}
		}

		if (recurse && el && el.childNodes) {
			for (i = 0, len = el.childNodes.length; i < len; ++i) {
				this.purgeElement(el.childNodes[i], recurse, eventName);
			}
		}
	};

	/**
	 * 通过el对象获取该对象上的事件
	 * 
	 * @param {dom}
	 *            el 要获取事件的dom对象
	 * @param {String}
	 *            eventName （可选）要获取的事件名，如果没有就获取该dom上所有的事件
	 */
	L5.lib.Event.getListeners = function(el, eventName) {
		var results = [], searchLists;
		if (!eventName) {
			searchLists = [ listeners, unloadListeners ];
		} else if (eventName == "unload") {
			searchLists = [ unloadListeners ];
		} else {
			searchLists = [ listeners ];
		}

		for ( var j = 0; j < searchLists.length; ++j) {
			var searchList = searchLists[j];
			if (searchList && searchList.length > 0) {
				for ( var i = 0, len = searchList.length; i < len; ++i) {
					var l = searchList[i];
					if (l && l[this.EL] === el
							&& (!eventName || eventName === l[this.TYPE])) {
						results.push({
							type : l[this.TYPE],
							fn : l[this.FN],
							obj : l[this.OBJ],
							adjust : l[this.ADJ_SCOPE],
							index : i
						});
					}
				}
			}
		}

		return (results.length) ? results : null;
	};

	L5.lib.Event._unload = function(e) {

		var EU = L5.lib.Event, i, j, l, len, index;

		for (i = 0, len = unloadListeners.length; i < len; ++i) {
			l = unloadListeners[i];
			if (l) {
				var scope = window;
				if (l[EU.ADJ_SCOPE]) {
					if (l[EU.ADJ_SCOPE] === true) {
						scope = l[EU.OBJ];
					} else {
						scope = l[EU.ADJ_SCOPE];
					}
				}
				l[EU.FN].call(scope, EU.getEvent(e), l[EU.OBJ]);
				unloadListeners[i] = null;
				l = null;
				scope = null;
			}
		}

		unloadListeners = null;

		if (listeners && listeners.length > 0) {
			j = listeners.length;
			while (j) {
				index = j - 1;
				l = listeners[index];
				if (l) {
					EU.removeListener(l[EU.EL], l[EU.TYPE], l[EU.FN], index);
				}
				j = j - 1;
			}
			l = null;

			EU.clearCache();
		}

		EU.doRemove(window, "unload", EU._unload);

	}

	L5.lib.Event.getScroll = function() {
		var dd = document.documentElement, db = document.body;
		if (dd && (dd.scrollTop || dd.scrollLeft)) {
			return [ dd.scrollTop, dd.scrollLeft ];
		} else if (db) {
			return [ db.scrollTop, db.scrollLeft ];
		} else {
			return [ 0, 0 ];
		}
	};

	/**
	 * 为DOM元素增加事件，处理了跨浏览器问题
	 */
	L5.lib.Event.doAdd = function() {
		if (window.addEventListener) {
			return function(el, eventName, fn, capture) {
				el.addEventListener(eventName, fn, (capture));
			};
		} else if (window.attachEvent) {
			return function(el, eventName, fn, capture) {
				el.attachEvent("on" + eventName, fn);
			};
		} else {
			return function() {
			};
		}
	}();

	/**
	 * 为元素移除事件
	 */
	L5.lib.Event.doRemove = function() {
		if (window.removeEventListener) {
			return function(el, eventName, fn, capture) {
				el.removeEventListener(eventName, fn, (capture));
			};
		} else if (window.detachEvent) {
			return function(el, eventName, fn) {
				el.detachEvent("on" + eventName, fn);
			};
		} else {
			return function() {
			};
		}
	}();
})();

(function() {
	var E = L5.lib.Event;
	E.on = E.addListener;
	E.un = E.removeListener;
	if (document && document.body) {
		E._load();
	} else {
		E.doAdd(window, "load", E._load);
	}
	E.doAdd(window, "unload", E._unload);
	E._tryPreloadAttach();// 开始的时候运行一下
})();