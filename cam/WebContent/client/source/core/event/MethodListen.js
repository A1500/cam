/**
 * 监听对象的方法调用
 */

/**
 * 为对象的某个方法增加前置监听函数：在这个方法被调用前，调用这个监听方法； 监听函数如果返回false，将会终止方法调用。
 * 
 * @public
 */
L5.util.Observable.prototype.beforeMethod = function(method, fn, scope) {
	var e = this.getMethodEvent(method);
	e.before.push({
		fn : fn,
		scope : scope
	});
};

/**
 * 为对象的某个方法增加后置监听函数：当该方法被调用后，调用这个监听函数
 * 
 * @public
 */
L5.util.Observable.prototype.afterMethod = function(method, fn, scope) {
	var e = this.getMethodEvent(method);
	e.after.push({
		fn : fn,
		scope : scope
	});
};

/**
 * @private
 */
L5.util.Observable.prototype.getMethodEvent = function(method) {
	if (!this.methodEvents) {
		this.methodEvents = {};
	}
	var e = this.methodEvents[method];
	if (!e) {
		e = {};
		this.methodEvents[method] = e;

		e.originalFn = this[method];
		e.methodName = method;
		e.before = [];
		e.after = [];

		var returnValue, v, cancel;
		var obj = this;

		var makeCall = function(fn, scope, args) {
			if ((v = fn.apply(scope || obj, args)) !== undefined) {
				if (typeof v === 'object') {
					if (v.returnValue !== undefined) {
						returnValue = v.returnValue;
					} else {
						returnValue = v;
					}
					if (v.cancel === true) {
						cancel = true;
					}
				} else if (v === false) {
					cancel = true;
				} else {
					returnValue = v;
				}
			}
		}

		this[method] = function() {
			returnValue = v = undefined;
			cancel = false;
			var args = Array.prototype.slice.call(arguments, 0);
			for ( var i = 0, len = e.before.length; i < len; i++) {
				makeCall(e.before[i].fn, e.before[i].scope, args);
				if (cancel) {
					return returnValue;
				}
			}

			if ((v = e.originalFn.apply(obj, args)) !== undefined) {
				returnValue = v;
			}

			for ( var i = 0, len = e.after.length; i < len; i++) {
				makeCall(e.after[i].fn, e.after[i].scope, args);
				if (cancel) {
					return returnValue;
				}
			}
			return returnValue;
		};
	}
	return e;
};

/**
 * 移除所有的方法监听器
 */
L5.util.Observable.prototype.removeMethodListener = function(method, fn, scope) {
	var e = this.getMethodEvent(method);
	for ( var i = 0, len = e.before.length; i < len; i++) {
		if (e.before[i].fn == fn && e.before[i].scope == scope) {
			e.before.splice(i, 1);
			return;
		}
	}

	for ( var i = 0, len = e.after.length; i < len; i++) {
		if (e.after[i].fn == fn && e.after[i].scope == scope) {
			e.after.splice(i, 1);
			return;
		}
	}
};