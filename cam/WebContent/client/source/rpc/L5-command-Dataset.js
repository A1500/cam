/**
 * @ignore
 * 以Command的格式发送数据,交由后台的Command处理
 * @class L5.CommandProxy
 * @extends L5.model.DataProxy
 * @constructor
 * @param {String} clazz 执行的后台command类的完整类名
 * @param {String} method 执行的command中的方法名
 * @param {String} url 提交到后台的servlet url
 */
L5.CommandProxy = function(clazz, method, url) {
	this.clazz = clazz;
	if (method)
		this.method = method;
	if (url)
		this.url = url;
	else
		this.url = L5.webPath + "/command/ajax";//
	L5.model.HttpProxy.superclass.constructor.call(this);
};

L5.extend(L5.CommandProxy, L5.model.DataProxy, {
	/**
	 * 加载数据
	 * @method load
	 * @param {Object} params 提交到后台的参数对象
	 * @param {Oject} reader 读取数据的reader对象
	 * @param {Function} callback 回调函数
	 * @param {String} scope 回调函数的作用域
	 * @param {Object} arg 参数
	 */
			load : function(params, reader, callback, scope, arg) {
				if (this.fireEvent("beforeload", this, params) !== false) {
					var paramset = new L5.Map("org.loushang.next.data.ParameterSet");
					if (params) {
						for (name in params) {
							if(name!='sync'){//同步加载数据的属性不要传递给后台
								paramset.put(name, params[name]);
							}
						}
					}
					var data = {
						"params" : paramset,
						"context" : L5.Command.context
					};
					var json = L5.encode(data);
					var url = this.url + "/" + this.clazz;
					if (this.method) {
						url = url + "/" + this.method;
					}
					var o = {
						url : url,
						jsonData : json,
						request : {
							callback : callback,
							scope : scope,
							arg : arg
						},
						reader : reader,
						callback : this.loadResponse,
						scope : this
					};
					if(params.sync){
		            	o.sync=true;
		            }
					try {
						L5.Ajax.request(o);
					} catch (e) {
						this.fireEvent("loadexception", this, o, null);
						o.request.callback.call(o.request.scope, null,
								o.request.arg, false);
						return;
					}
				} else {
					callback.call(scope || this, null, arg, false);
				}
			},

			 /**
		     * 读取信息创建dataset记录集
		     * @method loadResponse
		     * @private
		     * @param {Object} o          请求参数对象
		     * @param {Boolean} success   加载数据是否成功
		     * @param {Object} response   包含数据信息的对象
		     */
			loadResponse : function(o, success, response) {
				delete this.activeRequest;
				if (!success) {
					this.fireEvent("loadexception", this, o, response);
					o.request.callback.call(o.request.scope, null,
							o.request.arg, false);
					return;
				}
				var result;
				try {
					result = o.reader.read(response);
				} catch (e) {
					this.fireEvent("loadexception", this, o, response, e);
					o.request.callback.call(o.request.scope, null,
							o.request.arg, false);
					return;
				}
				this.fireEvent("load", this, o, o.request.arg);
				o.request.callback.call(o.request.scope, result, o.request.arg,
						true);
			}
		});
/**
 * 通过command方式加载数据构造dataset集合
 * @class L5.CmdDataset
 * @extends L5.model.Dataset
 * @constructor
 * @ignore
 * @param {Object} c 配置参数对象
 */
L5.CmdDataset = function(c) {
	if (!c.proxy)
		c.proxy = new L5.CommandProxy(c.clazz);
	if (!c.reader)
		c.reader = new L5.model.JsonReader(c, c.fields);
	L5.CmdDataset.superclass.constructor.call(this, c);
};

L5.extend(L5.CmdDataset, L5.model.Dataset);

/**
 * 获取枚举数据的proxy
 * @class L5.EnumProxy
 * @extends L5.CommandProxy
 * @constructor
 * @ignore
 * @param {String} enumName 枚举项名称
 */
L5.EnumProxy = function(enumName) {
	this.enumName = enumName;
	var clazz = "org.loushang.next.commons.nenum.EnumQueryCommand";
	L5.EnumProxy.superclass.constructor.call(this, clazz);
}

L5.extend(L5.EnumProxy, L5.CommandProxy, {
	        /**
	          * 加载数据
	          * @method load
	          * @param {Object} params 提交到后台的参数对象
	          * @param {Oject} reader 读取数据的reader对象
	          * @param {Function} callback 回调函数
	          * @param {String} scope 回调函数的作用域
	          * @param {Object} arg 参数
	       */
			load : function(params, reader, callback, scope, arg) {
				params["enumName"] = this.enumName;
				L5.EnumProxy.superclass.load.call(this, params, reader,
						callback, scope, arg);
			}
		});
/**
 * 加载枚举类型的数据
 * @class L5.EnumDataset
 * @extends L5.CmdDataset
 * @constructor
 * @ignore
 * @param {String} a1 枚举名称
 * @param {String} a2 dataset对象
 */
L5.EnumDataset = function(a1, a2) {
	var c;
	if (a1.enumName) {
		c = a1;
	} else {
		c = {};
		c.enumName = a1;
		if (a2) {
			c.ds = a2;
		} else {
			c.ds = a1;
		}
		c.autoLoad = true;
	}

	c.clazz = "org.loushang.next.commons.nenum.EnumQueryCommand";
	L5.EnumDataset.superclass.constructor.call(this, c);
	this.baseParams["enumName"] = c.enumName;
};

L5.extend(L5.EnumDataset, L5.CmdDataset);