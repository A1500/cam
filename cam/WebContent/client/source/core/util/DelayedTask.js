/**
 * 函数延迟执行工具类，和setTimeout和setInterval的区别在于能实现将旧的、还在延迟的调用删除
 * 
 * @constructor
 * 
 * @class L5.util.DelayedTask
 * 
 * @param {Function}
 *            fn (optional) 默认的要延迟执行的函数
 * @param {Object}
 *            scope (optional) 默认的执行函数时的scope
 * @param {Array}
 *            args (optional) 默认的执行函数时使用的参数
 */
L5.util.DelayedTask = function(fn, scope, args) {
	var id = null;// 任务标志
	var t;// 任务创建时间
	var d;// 延迟的毫秒数
	var call = function() {
		var now = new Date().getTime();
		if (now - t >= d) {// 过了延迟时间了，可以执行了
			// 清除任务信息
			clearInterval(id);
			id = null;
			// 执行任务
			fn.apply(scope, args || []);
		}
	};
	
	/**
	 * 取消已有的任务，并增加一个新任务。
	 * 
	 * @param {Number}
	 *            delay 延迟的毫秒数
	 * @param {Function}
	 *            newFn (optional) 用于覆盖已有函数的新函数
	 * @param {Object}
	 *            newScope (optional) 用于覆盖已有scope的新scope
	 * @param {Array}
	 *            newArgs (optional) 用于覆盖已有参数的新参数
	 */
	this.delay = function(delay, newFn, newScope, newArgs) {
		if (id && delay != d) {// 如果已经有等待执行的那么先取消掉，这样防止重复执行
			this.cancel();
		}
		d = delay;
		t = new Date().getTime();
		// 替换函数、scope、参数
		fn = newFn || fn;
		scope = newScope || scope;
		args = newArgs || args;
		// 加入任务队列
		if (!id) {
			id = setInterval(call, d);
		}
	};

	/**
	 * 取消已有任务
	 */
	this.cancel = function() {
		if (id) {
			clearInterval(id);
			id = null;
		}
	};
};