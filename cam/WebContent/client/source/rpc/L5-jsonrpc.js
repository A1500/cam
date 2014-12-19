/**
 * 处理rpc请求
 * @class JSONRpcClient
 * @constructor
 * @param {String} url 处理rpc请求的servlet的URL
 * @param {String} user 用户名
 * @param {String} pass 密码
 */
JSONRpcClient = function(url, user, pass) {
	this.url = url;
	if (!url) {
		this.url = L5.webPath + "/SCAJSON-RPC";//
	}
	this.user = user;
	this.pass = pass;

	/**
	 * 远程方法调用入口，如果没有callback就是同步调用,否则是异步调用 同步调用直接返回结果,异步调用返回requestId
	 * @method invoke 
	 * @param {String} method 方法名，可以是"服务名.方法名"
	 * @param {Array} args 参数列表，数组，如果只有一个参数可以不用数组
	 * @param {Function} callback 回调函数
	 */
	this.invoke = function(method, args, callback) {
		if (!args)
			args = [];
		else if (args.constructor != Array)
			args = [args];

		var id = L5.Ajax.transactionId;
		var data = {
			"id" : id,
			"method" : method,
			"params" : args
		};
		if (callback) {
			var o = {
				url : this.url,
				cb : callback,
				jsonData : L5.encode(data),
				callback : this.loadResponse,
				scope : this
			};
			L5.Ajax.request(o);
			return id;
		} else {
			var result = [];
			var o = {
				result : result,
				url : this.url,
				sync : true,
				jsonData : L5.encode(data),
				callback : this.loadResponse,
				scope : this
			};
			L5.Ajax.request(o);
			return result[0];
		}
	};

	/**
	 * 处理响应值
	 * @method loadResponse
	 * @private
	 * @param {Object} optinons 配置信息
	 * @param {Boolean} success 是否加载数据出现异常
	 * @param {Object} response 响应
	 */
	this.loadResponse = function(options, success, response) {
		// 通讯异常
		if (!success)
			throw new L5.Exception(response.status, response.statusText);
		var obj = L5.decode(response.responseText);
		// 业务异常
		if (obj.error)
			throw new L5.Exception(obj.error.code, obj.error.msg,
					obj.error.trace);
		// 回调函数
		if (options.cb)
			options.cb(obj.result);
		else
			options.result[0] = obj.result; // 通过options返回结果
	}

   /**
	 * 执行一个批次的rpc调用,都是异步的,返回request id
	 * @method invokeQueue 
	 * @param {Array} queue 方法数组
	 */
	this.invokeQueue = function(queue) {
		var args = [queue.count];
		for (var i = 0; i < queue.count; i++) {
			args[i] = {
				"method" : queue.method[i],
				"params" : queue.params[i]
			};
		}
		var callback = function(result) {
			if (result == null)
				return;
			for (var j = 0; j < queue.count; j++) {
				if (queue.cb[j])
					queue.cb[j](result[j]);
			}
		};
		return this.invoke("SYS.QUEUE", args, callback);
	};
};

/**
 * 将多个rpc请求放在一起统一提交(减少网络通讯次数),都作为异步调用处理
 * @class InvokeQueue
 * @constructor
 */
InvokeQueue = function() {
	this.method = [];
	this.params = [];
	this.cb = [];
	this.count = 0;

	this.add = function(method, args, callback) {
		if (!args)
			args = [];
		else if (args.constructor != Array)
			args = [args];
		this.method[this.count] = method;
		this.params[this.count] = args;
		if (callback)
			this.cb[this.count] = callback;
		this.count++;
	}
};