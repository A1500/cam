/**
 * L5.model.DataProxy的实现类，数据来源对应的URL可以是跨域的。如果是跨域获得数据，就需要使用该类，而不是HttpProxy。<br>
 * <p>
 * 为了使浏览器能够处理返回的数据，服务器必须在调用callback函数时包装数据对象，callback是作为参数传给ScriptTagProxy的。
 * 下面是Java例子，可以是ScriptTagProxy或者HttpProxy返回的数据，这取决于传入的callback的名称。
 * <p>
 * <pre><code>
	boolean scriptTag = false;
	String cb = request.getParameter("callback");
	if (cb != null) {
	    scriptTag = true;
	    response.setContentType("text/javascript");
	} else {
	    response.setContentType("application/x-json");
	}
	Writer out = response.getWriter();
	if (scriptTag) {
	    out.write(cb + "(");
	}
	out.print(dataBlock.toJsonString());
	if (scriptTag) {
	    out.write(");");
	}
	</code></pre>
 * @class L5.model.ScriptTagProxy
 * @extends L5.model.DataProxy
 * @constructor
 * @param {Object} config 配置信息对象
 */
L5.model.ScriptTagProxy = function(config){
    L5.model.ScriptTagProxy.superclass.constructor.call(this);
	L5.apply(this, config);
	this.head = document.getElementsByTagName("head")[0];
    
   /**
     * @event loadexception
     * 加载数据时Proxy有异常时触发。引起该事件可能有两个原因： 
     * <ul><li><b>load调用超时。</b>  这意味着load回调在timeout方法指定的时间范围内没有执行。这种情况下会触发事件并且第四个参数(error)是null</li>
     * <li><b>load成功但是reader不能获得响应。</b>这意味着服务端返回了数据，但是配置的reader在读取数据时出现错误。
     * 这种情况下会触发事件，并把错误信息放在第四个参数error中抛出。</li></ul>
     * 事件可以直接通过Dataset实例监听。
     * @param {Object} this
     * @param {Object} options load选项参数。如果load调用超时，参数是null
     * @param {Object} arg 传给load函数的callback的arg对象
     * @param {Error} e 如果配置的Reader不能读取数据产生的JavaScript Error对象，如果load返回false，值为null
     */
};

L5.model.ScriptTagProxy.TRANS_ID = 1000;

L5.extend(L5.model.ScriptTagProxy, L5.model.DataProxy, {
    /**
     * @cfg {String} url 请求数据对象的URL
     */
	
    /**
     * @cfg {Number} timeout (可选) 等待响应的毫秒数，默认30秒
     */
    timeout : 30000,
    
    /**
     * @cfg {String} callbackParam (可选) 传送到服务器端的callback函数的名称，默认是"callback"。<p>服务器端必须读取这个参数值，并生成JavaScript输出，传递数据对象调用这个函数
     */
    callbackParam : "callback",
    
    /**
     *  @cfg {Boolean} nocache (可选) 默认true。请求中增加唯一的参数不缓存
     */
    nocache : true,

    /**
     * 从配置的URL加载数据。
     * @method load
     * @param {Object} params 包含参数的对象，其中参数是请求的HTTP参数到服务器端
     * @param {L5.model.DataReader} reader 转换数据为Record对象的read对象
     * @param {Function} callback 回调函数，必须设置该参数
     * <ul>
     * <li>record对象</li>
     * <li>load函数的arg参数</li>
     * <li>boolean类型的是否成功的标识</li>
     * </ul>
     * @param {Object} scope callback的作用域
     * @param {Object} arg (可选) 传给callback的第二个参数
     */
    load : function(params, reader, callback, scope, arg) {
				if (this.fireEvent("beforeload", this, params) !== false) {

					var p = L5.urlEncode(L5.apply(params, this.extraParams));

					var url = this.url;
					url += (url.indexOf("?") != -1 ? "&" : "?") + p;
					if (this.nocache) {
						url += "&_dc=" + (new Date().getTime());
					}
					var transId = ++L5.model.ScriptTagProxy.TRANS_ID;
					var trans = {
						id : transId,
						cb : "stcCallback" + transId,
						scriptId : "stcScript" + transId,
						params : params,
						arg : arg,
						url : url,
						callback : callback,
						scope : scope,
						reader : reader
					};
					var conn = this;

					window[trans.cb] = function(o) {
						conn.handleResponse(o, trans);
					};

					url += String.format("&{0}={1}", this.callbackParam,
							trans.cb);

					if (this.autoAbort !== false) {
						this.abort();
					}

					trans.timeoutId = this.handleFailure.defer(this.timeout,
							this, [trans]);

					var script = document.createElement("script");
					script.setAttribute("src", url);
					script.setAttribute("type", "text/javascript");
					script.setAttribute("id", trans.scriptId);
					this.head.appendChild(script);

					this.trans = trans;
				} else {
					callback.call(scope || this, null, arg, false);
				}
			},

			/**
			 * 取消当前的请求
			 * @method abort
			 */
			abort : function() {
				if (this.isLoading()) {
					this.destroyTrans(this.trans);
				}
			},
			
			/**
			 * 判断是否正在加载数据
			 * @method isLoading
			 * @private
			 */
			isLoading : function() {
				return this.trans ? true : false;
			},

			/**
			 * 销毁对象
			 * @method destroyTrans
			 * @private
			 * @param {Object} trans 包含请求参数的对象
			 * @param {Boolean} isLoaded 是否加载
			 */
			destroyTrans : function(trans, isLoaded) {
				this.head.removeChild(document.getElementById(trans.scriptId));
				clearTimeout(trans.timeoutId);
				if (isLoaded) {
					window[trans.cb] = undefined;
					try {
						delete window[trans.cb];
					} catch (e) {
					}
				} else {
					// if hasn't been loaded, wait for load to remove it to prevent script error
					window[trans.cb] = function() {
						window[trans.cb] = undefined;
						try {
							delete window[trans.cb];
						} catch (e) {
						}
					};
				}
			},

			/**
			 * 处理响应信息对象
			 * @method handleResponse
			 * @private
			 * @param {Object} o 包含数据信息的对象
			 * @param {Object} trans 包含请求参数的对象
			 */
			handleResponse : function(o, trans) {
				this.trans = false;
				this.destroyTrans(trans, true);
				var result;
				try {
					result = trans.reader.readRecords(o);
				} catch (e) {
					this.fireEvent("loadexception", this, o, trans.arg, e);
					trans.callback.call(trans.scope || window, null, trans.arg,
							false);
					return;
				}
				this.fireEvent("load", this, o, trans.arg);
				trans.callback.call(trans.scope || window, result, trans.arg,
						true);
			},

			/**
			 * 处理响应失败信息对象
			 * @method handleFailure
			 * @private
			 * @param {Object} trans 包含请求参数的对象
			 */
			handleFailure : function(trans) {
				this.trans = false;
				this.destroyTrans(trans, false);
				this.fireEvent("loadexception", this, null, trans.arg);
				trans.callback.call(trans.scope || window, null, trans.arg,
						false);
			}
});