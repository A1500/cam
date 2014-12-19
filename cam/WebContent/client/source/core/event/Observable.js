/**
 * 抽象事件接口类.
 * 
 * @class L5.util.Observable
 * 
 * <pre><code>
 * Employee = function(name) {
 * 	this.name = name;
 * 	this.addEvents({
 * 		&quot;fired&quot; : true,
 * 		&quot;quit&quot; : true
 * 	});
 * }
 * L5.extend(Employee, L5.util.Observable);
 * </code></pre>
 * 
 */
L5.util.Observable = function() {

	if (this.listeners) {
		this.on(this.listeners);
		delete this.listeners;
	}
};
L5.util.Observable.prototype = {
	/**
	 * 发出某个事件，通常在子类里调用。
	 * 
	 * @param {String}
	 *            eventName 事件名称
	 * @param {Object...}
	 *            args 一个或多个参数值、传给事件监听函数的参数值。
	 * 
	 * @return {Boolean}
	 */
	fireEvent : function() {
		if (this.eventsSuspended !== true) {
			var ce = this.events[arguments[0].toLowerCase()];
			if (typeof ce == "object") {
				return ce.fire.apply(ce, Array.prototype.slice.call(arguments,
						1));
			}
		}
		return true;
	},

	// private
	filterOptRe : /^(?:scope|delay|buffer|single)$/,

	/**
	 * 增加一个监听函数，该方法有一个简写版{@link #un};
	 * 
	 * @param {String}
	 *            eventName 监听的事件名称
	 * @param {Function}
	 *            handler 监听函数
	 * @param {Object}
	 *            scope (optional) 监听函数的执行scope
	 * @param {Object}
	 *            options (optional) 监听函数配置属性，可能包含下列属性:
	 *            <ul>
	 *            <li><b>scope</b> : Object
	 *            <p class="sub-desc">
	 *            监听函数执行的scope，同scope参数.
	 *            </p>
	 *            </li>
	 *            <li><b>delay</b> : Number
	 *            <p class="sub-desc">
	 *            监听函数延迟执行的毫秒数，事件发生后延迟一定时间才执行监听函数.
	 *            </p>
	 *            </li>
	 *            <li><b>single</b> : Boolean
	 *            <p class="sub-desc">
	 *            该监听函数是否只执行一次(执行一次后就不监听了).
	 *            </p>
	 *            </li>
	 *            <li><b>buffer</b> : Number
	 *            <p class="sub-desc">
	 *            该监听函数是否延迟执行，和delay属性的区别在于，在延迟的这段时间里如果又有新的同类事件发生，旧的未执行的监听函数调用作废。
	 *            比如: 按某个鼠标单击监听函数延迟100毫秒执行，假如用户在100毫秒内连续点鼠标多次，只调用一次监听函数。
	 *            </p>
	 *            </li>
	 *            </ul>
	 * 
	 * <pre><code>
	 * el.on('click', this.onClick, this, {
	 * 	single : true,
	 * 	delay : 100,
	 * 	forumId : 4
	 * });
	 * </code></pre>
	 * 
	 * 
	 * <pre><code>
	 * foo.on({
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
	 * 使用简写版on方法:<br>
	 * 
	 * <pre><code>
	 * foo.on({
	 * 	'click' : this.onClick,
	 * 	'mouseover' : this.onMouseOver,
	 * 	'mouseout' : this.onMouseOut,
	 * 	scope : this
	 * });
	 * </code></pre>
	 */
	addListener : function(eventName, fn, scope, o) {
		if (typeof eventName == "object") {
			o = eventName;
			for ( var e in o) {
				if (this.filterOptRe.test(e)) {
					continue;
				}
				if (typeof o[e] == "function") {
					// shared options
					this.addListener(e, o[e], o.scope, o);
				} else {
					// individual options
					this.addListener(e, o[e].fn, o[e].scope, o[e]);
				}
			}
			return;
		}
		o = (!o || typeof o == "boolean") ? {} : o;
		eventName = eventName.toLowerCase();
		var ce = this.events[eventName] || true;
		if (typeof ce == "boolean") {
			ce = new L5.util.Event(this, eventName);// 根据事件名称创建L5.util.Event对象
			this.events[eventName] = ce;// 将新的对象赋值给this.events[eventName]，fireEvent的时候会用来进行判断
		}
		// 实际上还是通过
		// L5.util.Event的addListener方法进行的当fireEvent的时候也会调用L5.util.Event响应的fire方法
		ce.addListener(fn, scope, o);
	},

	/**
	 * 移除一个监听函数
	 * 
	 * @param {String}
	 *            eventName 事件名称
	 * @param {Function}
	 *            handler 监听函数
	 * @param {Object}
	 *            scope (optional) 监听函数执行scope
	 */
	removeListener : function(eventName, fn, scope) {
		var ce = this.events[eventName.toLowerCase()];
		if (typeof ce == "object") {
			ce.removeListener(fn, scope);
		}
	},

	/**
	 * 移除对象上的所有的监听
	 */
	purgeListeners : function() {
		for ( var evt in this.events) {
			if (typeof this.events[evt] == "object") {
				this.events[evt].clearListeners();
			}
		}
	},

	/**
	 * 利用另一对象(o)的事件来触发本对象的同名事件；当那个对象触发了相应事件后，本对象也触发同名事件。
	 * 
	 * @param {Object}
	 *            o
	 * @param {Array}
	 *            events
	 * 
	 */
	relayEvents : function(o, events) {
		var createHandler = function(ename) {
			return function() {
				return this.fireEvent.apply(this, L5.combine(ename,
						Array.prototype.slice.call(arguments, 0)));
			};
		};
		for ( var i = 0, len = events.length; i < len; i++) {
			var ename = events[i];
			if (!this.events[ename]) {
				this.events[ename] = true;
			}
			o.on(ename, createHandler(ename), this);
		}
	},

	/**
	 * 增加事件类型，增加这个组件可能发出的事件类型，通常在子类里调用。
	 * 
	 * @param {Object}
	 */
	addEvents : function(o) {
		if (!this.events) {
			this.events = {};
		}
		if (typeof o == 'string') {
			for ( var i = 0, a = arguments, v; v = a[i]; i++) {
				if (!this.events[a[i]]) {
					this.events[a[i]] = true;
				}
			}
		} else {
			L5.applyIf(this.events, o);
		}
	},

	/**
	 * 判断是否有某个监听器
	 * 
	 * @ignore
	 * @param {String}
	 *            eventName 事件名称
	 * @return {Boolean}
	 */
	hasListener : function(eventName) {
		var e = this.events[eventName];
		return typeof e == "object" && e.listeners.length > 0;
	},

	/**
	 * 暂停事件的触发
	 * 
	 * @ignore
	 */
	suspendEvents : function() {
		this.eventsSuspended = true;
	},

	/**
	 * 恢复事件的触发
	 * 
	 * @ignore
	 */
	resumeEvents : function() {
		this.eventsSuspended = false;
	}
};
/**
 * 增加一个监听函数 (addListener的缩写版)
 * 
 * @param {String}
 *            eventName 事件名称
 * @param {Function}
 *            handler 要移除的监听函数
 * @param {Object}
 *            scope (optional) 监听函数执行scope
 * @param {Object}
 *            options (optional) 监听函数配置属性
 * @method
 */
L5.util.Observable.prototype.on = L5.util.Observable.prototype.addListener;
/**
 * 移除一个监听器 (removeListener的缩写版)
 * 
 * @param {String}
 *            eventName 事件名称
 * @param {Function}
 *            handler 要移除的监听函数
 * @param {Object}
 *            scope (optional) 监听函数执行scope
 * @method
 */
L5.util.Observable.prototype.un = L5.util.Observable.prototype.removeListener;

(function() {

	/**
	 * 为监听函数创建一个代理函数，该代理函数实现延迟调用监听函数的功能，并且会删除"失效的延迟调用"
	 * <p>
	 * 比如: 按某个鼠标单击监听函数延迟10毫秒执行，假如用户在10毫秒内连续点鼠标多次，只调用一次监听函数
	 * 
	 */
	var createBuffered = function(h, o, scope) {
		var task = new L5.util.DelayedTask();
		return function() {
			task.delay(o.buffer, h, scope, Array.prototype.slice.call(
					arguments, 0));
		};
	};

	/**
	 * 为监听函数创建一个代理函数，在代理函数里调用监听函数，并把监听函数从事件里删除，确保这个监听函数只执行一次
	 */
	var createSingle = function(h, e, fn, scope) {
		return function() {
			e.removeListener(fn, scope);
			return h.apply(scope, arguments);
		};
	};

	/**
	 * 为监听函数创建一个代理函数，在代理函数里调用监听函数、是在延迟了一定时间后才执行对监听函数的调用，从而实现监听函数每次都是在事件触发一段时间后才执行。
	 */
	var createDelayed = function(h, o, scope) {
		return function() {
			var args = Array.prototype.slice.call(arguments, 0);
			setTimeout(function() {
				h.apply(scope, args);
			}, o.delay || 10);
		};
	};

	/**
	 * 事件类型，表示某个组件的可能发生的一种事件类型。
	 * 
	 * @private
	 */
	L5.util.Event = function(obj, name) {
		this.name = name;
		this.obj = obj;
		this.listeners = [];
	};

	L5.util.Event.prototype = {
		/**
		 * 增加监听器
		 */
		addListener : function(fn, scope, options) {
			scope = scope || this.obj;
			if (!this.isListening(fn, scope)) {// 假如已经存在就不注册了
				var l = this.createListener(fn, scope, options);// 如果不存在首先创建一个
				if (!this.firing) {
					this.listeners.push(l);
				} else { // if we are currently firing this event, don't
					// disturb the listener loop
					this.listeners = this.listeners.slice(0);
					this.listeners.push(l);
				}
			}
		},
		/**
		 * 创建监听器
		 */
		createListener : function(fn, scope, o) {
			o = o || {};
			scope = scope || this.obj;
			var l = {
				fn : fn,
				scope : scope,
				options : o
			};
			var h = fn;
			if (o.delay) {
				h = createDelayed(h, o, scope);
			}
			if (o.single) {
				h = createSingle(h, this, fn, scope);
			}
			if (o.buffer) {
				h = createBuffered(h, o, scope);
			}
			l.fireFn = h;
			return l;
		},
		/**
		 * 查找监听器是否存在不存在返回-1存在返回索引
		 */
		findListener : function(fn, scope) {
			scope = scope || this.obj;
			var ls = this.listeners;
			for ( var i = 0, len = ls.length; i < len; i++) {
				var l = ls[i];
				if (l.fn == fn && l.scope == scope) {
					return i;
				}
			}
			return -1;
		},

		isListening : function(fn, scope) {
			return this.findListener(fn, scope) != -1;
		},

		/**
		 * 移除监听器
		 */
		removeListener : function(fn, scope) {
			var index;
			if ((index = this.findListener(fn, scope)) != -1) {
				if (!this.firing) {
					this.listeners.splice(index, 1);
				} else {
					this.listeners = this.listeners.slice(0);
					this.listeners.splice(index, 1);
				}
				return true;
			}
			return false;
		},

		/**
		 * 移除该事件类型所有监听器
		 */
		clearListeners : function() {
			this.listeners = [];
		},

		/**
		 * 触发事件
		 */
		fire : function() {
			var ls = this.listeners, scope, len = ls.length;
			if (len > 0) {
				this.firing = true;
				var args = Array.prototype.slice.call(arguments, 0);
				for ( var i = 0; i < len; i++) {
					var l = ls[i];
					if (l.fireFn
							.apply(l.scope || this.obj || window, arguments) === false) {
						this.firing = false;
						return false;
					}
				}
				this.firing = false;
			}
			return true;
		}
	};
})();

/**
 * 给对象增加一个拦截器，该拦截器通过返回true或false确定是否要发出事件，
 * 
 * @param {Observable}
 *            o 
 * @param {Function}
 *            fn 
 * @param {Object}
 *            scope (optional)
 * @static
 */
L5.util.Observable.capture = function(o, fn, scope) {
	o.fireEvent = o.fireEvent.createInterceptor(fn, scope);
};

/**
 * 移除对象的拦截器
 * 
 * @param {Observable}
 *            o
 * @static
 */
L5.util.Observable.releaseCapture = function(o) {
	o.fireEvent = L5.util.Observable.prototype.fireEvent;
};