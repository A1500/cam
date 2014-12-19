/**
 * 通过rpc请求数据构造dataset
 * @class L5.RpcDataset
 * @extends L5.model.Dataset
 * @constructor
 * @param {Object} c 配置参数
 */
L5.RpcDataset = function(c) {
	if (!c.proxy)
		c.proxy = new L5.RpcProxy(c.path, c.method, c.paramHandler);
	if (!c.reader)
		c.reader = new L5.model.JsonReader(c.meta, c.fields);
	L5.RpcDataset.superclass.constructor.call(this, c);
};

L5.extend(L5.RpcDataset, L5.model.Dataset, {
	        /**
              * 设置处理器函数
              * @method setParamHandler
              * @param {Function} handler 处理器函数
           */
			setParamHandler : function(handler) {
				if (!handler instanceof Function)
					alert("param of setParamHandler is not a Function!");
				this.proxy.setParamHandler(handler);
			}
		});
/**
 * 通过rpc请求数据构造dataset
 * @class L5.RpcProxy
 * @extends L5.model.DataProxy
 * @constructor
 * @param {String} path 请求的路径
 * @param {String} method 请求方法名
 * @param {String} handler 处理函数
 */
L5.RpcProxy = function(path, method, handler) {
	L5.RpcProxy.superclass.constructor.call(this);
	this.method = method;
	this.paramHandler = handler
	this.jsonRpc = new JSONRpcClient();
	this.jsonRpc.url = this.jsonRpc.url + "/" + path
};

L5.extend(L5.RpcProxy, L5.model.DataProxy, {
	        
	        /**
	         * 设置处理器对象
	         * @method setParamHandler
	         * @param {Object} handler 处理器对象
	         */
			setParamHandler : function(handler) {
				this.paramHandler = handler;
			},
			/**
			 * 组织默认处理器对象与参数
			 * @method defaultParamHandler
			 * @private
			 * @param {Array} params 参数集合
			 * @return {L5.Map} 参数集合
			 */
			defaultParamHandler : function(params) {
				var paramset = new L5.Map("org.loushang.next.data.ParameterSet");
				if (params) {
					for (name in params) {
						paramset.put(name, params[name]);
					}
				}
				return paramset;
			},
			/**
			 * 加载数据
			 * @method load
			 * @private
			 * @param {Array} params 参数集合
			 * @param {L5.model.JsonReader} reader 读取数据
			 * @param {Function} callback 回调函数
			 * @param {String} scope callback函数的作用域
			 * @param {Array} arg callback的参数
			 */
			load : function(params, reader, callback, scope, arg) {
				if (this.fireEvent("beforeload", this, params) !== false) {
					if (this.paramHandler == null)
						this.paramHandler = this.defaultParamHandler;
					var args = this.paramHandler(params);
					if (!args instanceof Array)
						args = [args];
					var delegate = this.loadResponse.createDelegate(this, [
									reader, callback, scope, arg], 1);
					this.jsonRpc.invoke(this.method, args, delegate);
				} else {
					callback.call(scope || this, null, arg, false);
				}
			},
			
			/**
			 * 读取信息创建dataset记录集
			 * @method loadResponse
			 * @private
			 * @param {Object} listRange 包含数据信息的对象
			 * @param {L5.model.JsonReader} reader 解析数据的对象
			 * @param {Function} callback 回调函数
			 * @param {String} scope callback函数的作用域
			 * @param {Array} arg callback的参数
			 */
			loadResponse : function(listRange, reader, callback, scope, arg) {
				var result;
				try {

					result = reader.readRecords(listRange);
				} catch (e) {
					this.fireEvent("loadexception", this, null, null, e);
					callback.call(scope, null, arg, false);
					return;
				}
				callback.call(scope, result, arg, true);
			}
		});