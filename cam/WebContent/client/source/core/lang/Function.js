/**
 * 扩展标准的函数类型
 * 
 * @ignore
 * @class Function
 */
L5.apply(Function.prototype, {
	/**
	 * 有时候需要"有参数值的函数引用"
	 * <p>
	 * 例如:
	 * 
	 * <pre><code>
	 * var sayHi = function(name) {
	 * 	alert('Hi, ' + name);
	 * }
	 * 
	 * // 点击按钮调用sayHi，下面这种是错误的实现：
	 * new L5.Button({
	 * 	text : 'Say Hi',
	 * 	renderTo : L5.getBody(),
	 * 	handler : sayHi(&quot;Fred&quot;)
	 * //错误的，handler必须是一个函数引用
	 * });
	 * 
	 * //正确的实现：
	 * var sayHi2Fred = function() {
	 * 	sayHi(&quot;Fred&quot;);
	 * }
	 * 
	 * new L5.Button({
	 * 	text : 'Say Hi',
	 * 	renderTo : L5.getBody(),
	 * 	handler : sayHi2Fred
	 * //没有参数值的函数引用
	 * });
	 * 
	 * // 使用callback的实现
	 * new L5.Button({
	 * 	text : 'Say Hi',
	 * 	renderTo : L5.getBody(),
	 * 	handler : sayHi.createCallback('Fred')
	 * });
	 * </code></pre>
	 * 
	 * @return {Function} 新函数
	 */
	createCallback : function(/* args... */) {
		// make args available, in function below
		var args = arguments;
		var method = this;
		return function() {
			return method.apply(window, args);
		};
	},

	/**
	 * 通过创建一个新的函数，达到给一个函数设置执行范围的目的
	 * <p>
	 * 另一种为了实现"有参数值的函数引用"
	 * <p>
	 * 例如:
	 * 
	 * <pre><code>
	 * var sayHi = function(name) {
	 * 	// 注意this.text，这个this到底是谁?，这个this就是函数的执行范围
	 * 	alert('Hi, ' + name + '. You clicked the &quot;' + this.text + '&quot; button.');
	 * }
	 * 
	 * var btn = new L5.Button({
	 * 	text : 'Say Hi',
	 * 	renderTo : L5.getBody()
	 * });
	 * 
	 * // 
	 * btn.on('click', sayHi.createDelegate(btn, [ 'Fred' ]));
	 * </code></pre>
	 * 
	 * @param {Object}
	 *            obj (optional) 执行范围
	 * @param {Array}
	 *            args (optional) 给原始函数的指定的参数值
	 * @param {Boolean/Number}
	 *            appendArgs (optional) 如果是true，那么参数args指定的参数值将补充到调用新函数使用的参数值后面，
	 *            如果是数字，参数args指定的参数值将在指定位置到调用新函数使用的参数值后面；
	 *            如果是undefined，那就使用args指定的参数值*
	 * @return {Function} 新的函数
	 */
	createDelegate : function(obj, args, appendArgs) {
		var method = this;
		return function() {
			var callArgs = args || arguments;
			if (appendArgs === true) {
				callArgs = Array.prototype.slice.call(arguments, 0);
				callArgs = callArgs.concat(args);
			} else if (typeof appendArgs == "number") {
				callArgs = Array.prototype.slice.call(arguments, 0); // copy
																		// arguments
																		// first
				var applyArgs = [ appendArgs, 0 ].concat(args); // create method
																// call params
				Array.prototype.splice.apply(callArgs, applyArgs); // splice
																	// them in
			}
			return method.apply(obj || window, callArgs);
		};
	},

	/**
	 * 方法延迟执行，类似setTimeout 例如:
	 * 
	 * <pre><code>
	 * var sayHi = function(name) {
	 * 	alert('Hi, ' + name);
	 * }
	 * 
	 * // 立刻执行:
	 * sayHi('Fred');
	 * 
	 * // 延迟2秒后执行:
	 * sayHi.defer(2000, this, [ 'Fred' ]);
	 * 
	 * </code></pre>
	 * 
	 * @param {Number}
	 *            millis 延迟的毫秒数
	 * @param {Object}
	 *            obj (optional)
	 * @param {Array}
	 *            args (optional) 要传给原始函数的参数值
	 * @param {Boolean/Number}
	 *            appendArgs (optional) 如果是true，那么参数args指定的参数值将补充到调用新函数使用的参数值后面，
	 *            如果是数字，参数args指定的参数值将在指定位置到调用新函数使用的参数值后面；
	 *            如果是undefined，那就使用args指定的参数值
	 * @return {Number} The timeout id that can be used with clearTimeout
	 */
	defer : function(millis, obj, args, appendArgs) {
		var fn = this.createDelegate(obj, args, appendArgs);
		if (millis) {
			return setTimeout(fn, millis);
		}
		fn();
		return 0;
	},

	/**
	 * 在原始函数的基础上创建一个新函数，实现执行完原始函数后会执行另一个附加的函数 用原始函数的返回值作为新函数的返回值 例如：
	 * 
	 * <pre><code>
	 * var sayHi = function(name) {
	 * 	alert('Hi, ' + name);
	 * }
	 * 
	 * sayHi('Fred'); // alerts &quot;Hi, Fred&quot;
	 * 
	 * var sayGoodbye = sayHi.createSequence(function(name) {
	 * 	alert('Bye, ' + name);
	 * });
	 * 
	 * sayGoodbye('Fred'); // both alerts show
	 * </code></pre>
	 * 
	 * @param {Function}
	 *            fcn 附加的要执行的函数
	 * @param {Object}
	 *            scope (可选) 附加的函数的执行范围 (默认是原始函数的执行范围或当前window)
	 * @return {Function} 新的函数
	 */
	createSequence : function(fcn, scope) {
		if (typeof fcn != "function") {
			return this;
		}
		var method = this;
		return function() {
			var retval = method.apply(this || window, arguments);
			fcn.apply(scope || this || window, arguments);
			return retval;
		};
	},

	/**
	 * 给函数增加一个"拦截器"，实现"只有在满足某个条件的情况下才执行函数"的需求 例如：
	 * 
	 * <pre><code>
	 * //原始函数
	 * var sayHi = function(name) {
	 * 	alert('Hi, ' + name);
	 * }
	 * 
	 * sayHi('Fred'); // alerts &quot;Hi, Fred&quot;
	 * 
	 * // 现在有个需求，要求只有当&quot;name&quot;等于&quot;Brian&quot;时才执行sayHi，那么可以这么实现
	 * var sayHiToFriend = sayHi.createInterceptor(function(name) {
	 * 	return name == 'Brian';
	 * });
	 * 
	 * sayHiToFriend('Fred'); // no alert
	 * sayHiToFriend('Brian'); // alerts &quot;Hi, Brian&quot;
	 * </code></pre>
	 * 
	 * @param {Function}
	 *            用来判断函数是否要执行的拦截函数，该函数必须返回true或false
	 * @param {Object}
	 *            scope (可选) 拦截器函数的执行范围 (默认是原始函数的范围或当前winddow)
	 * @return {Function} 新的加了拦截判断的函数
	 */
	createInterceptor : function(fcn, scope) {
		if (typeof fcn != "function") {
			return this;
		}
		var method = this;
		return function() {
			fcn.target = this;
			fcn.method = method;
			if (fcn.apply(scope || this || window, arguments) === false) {
				return;
			}
			return method.apply(this || window, arguments);
		};
	}
});

(function() {
	if (L5.isIE) {
		function fnCleanUp() {
			var p = Function.prototype;
			delete p.createSequence;
			delete p.defer;
			delete p.createDelegate;
			delete p.createCallback;
			delete p.createInterceptor;

			window.detachEvent("onunload", fnCleanUp);
		}
		window.attachEvent("onunload", fnCleanUp);
	}
})();