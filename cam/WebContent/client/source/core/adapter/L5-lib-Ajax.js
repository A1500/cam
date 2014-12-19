/**
 * Ajax请求工具类
 * @private
 * @constructor
 */
L5.lib.Ajax=function(){
	
};


/**
 * @private
 */
L5.lib.Ajax.activeX = [ 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP',
		'Microsoft.XMLHTTP' ];

/**
 * @private
 */
L5.lib.Ajax.defaultHeaders = {'X-Requested-With':'XMLHttpRequest'};

/**
 * @private
 */
L5.lib.Ajax.defaultPostHeader = 'application/x-www-form-urlencoded; charset=UTF-8';

/**
 * 保存轮询处理的内部变量
 * 
 * @private
 */
L5.lib.Ajax.poll = {};

/**
 * 保存超时处理的内部变量
 * @private
 */
L5.lib.Ajax.timeout = {};

/**
 * 保存轮询间隔的内部变量
 * @private
 */
L5.lib.Ajax.pollInterval = 50;

/**
 * 用于请求编号的计数器的内部变量
 * @private
 */
L5.lib.Ajax.transactionId = 0;
/**
 * 发出一个ajax请求
 * <p>如果参数"options"里定义了"sync"属性那就使用同步ajax调用，否则使用异步ajax调用
 * <p>可以通过参数"data"设置提交的数据，也可以通过参数"options"设置提交的数据
 * @param {String} method 请求的方法：GET/POST
 * @param {String} uri 请求的uri
 * @param {Object} cb 回调选项
 * 				success: 处理成功情况的函数
 *              failure: 处理失败情况的函数
 *              timeout : 超时设置
 *              argument：
 * @param {Object} data 提交的数据
 * @param {Object} options 请求选项 
 * 				options.headers:请求头信息;
 * 				options.sync:同步请求;
 * 				options.xmlData:提交的xml格式数据;
 * 				options.jsonData:提交的json数据
 * @public
 */
L5.lib.Ajax.request = function(method, uri, cb, data, options) {
	var headers={};
	
	if (options) {
		if (options.headers) {
			for ( var h in options.headers) {
				if (options.headers.hasOwnProperty(h)) {
					this.addHeader(headers,h, options.headers[h]);
				}
			}
		}
		if (options.xmlData) {
			if (!headers || !headers['Content-Type']) {
				this.addHeader(headers,'Content-Type', 'text/xml');
			}
			method = (method ? method : (options.method ? options.method
					: 'POST'));
			data = options.xmlData;
		} else if (options.jsonData) {
			if (!headers || !headers['Content-Type']) {
				this.addHeader(headers,'Content-Type', 'application/json');
			}
			method = (method ? method : (options.method ? options.method
					: 'POST'));
			data = typeof options.jsonData == 'object' ? L5
					.encode(options.jsonData) : options.jsonData;
		}
	}
	
	if (data && !headers['Content-Type']) {
		this.addHeader(headers, 'Content-Type', this.defaultPostHeader);
	}
	
	return this["sync" in options ? "syncRequest" : "asyncRequest"](method,
			uri, cb, data, headers);
};
/**
 * @public
 */
L5.lib.Ajax.serializeForm = function(form) {
	if (typeof form == 'string') {
		form = (document.getElementById(form) || document.forms[form]);
	}

	var el, name, val, disabled, data = '', hasSubmit = false;
	for ( var i = 0; i < form.elements.length; i++) {
		el = form.elements[i];
		disabled = form.elements[i].disabled;
		name = form.elements[i].name;
		val = form.elements[i].value;

		if (!disabled && name) {
			switch (el.type) {
			case 'select-one':
			case 'select-multiple':
				for ( var j = 0; j < el.options.length; j++) {
					if (el.options[j].selected) {
						if (L5.isIE) {
							data += encodeURIComponent(name)
									+ '='
									+ encodeURIComponent(el.options[j].attributes['value'].specified ? el.options[j].value
											: el.options[j].text) + '&';
						} else {
							data += encodeURIComponent(name)
									+ '='
									+ encodeURIComponent(el.options[j]
											.hasAttribute('value') ? el.options[j].value
											: el.options[j].text) + '&';
						}
					}
				}
				break;
			case 'radio':
			case 'checkbox':
				if (el.checked) {
					data += encodeURIComponent(name) + '='
							+ encodeURIComponent(val) + '&';
				}
				break;
			case 'file':

			case undefined:

			case 'reset':

			case 'button':

				break;
			case 'submit':
				if (hasSubmit == false) {
					data += encodeURIComponent(name) + '='
							+ encodeURIComponent(val) + '&';
					hasSubmit = true;
				}
				break;
			default:
				data += encodeURIComponent(name) + '='
						+ encodeURIComponent(val) + '&';
				break;
			}
		}
	}
	data = data.substr(0, data.length - 1);
	return data;
};

/**
 * @private
 */
L5.lib.Ajax.setPollingInterval = function(i) {
	if (typeof i == 'number' && isFinite(i)) {
		L5.lib.Ajax.pollInterval = i;
	}
};

/**
 * 根据浏览器类型创建一个XMLHttpRequest对象
 * @param {Number} transactionId 请求编号
 * @returns {Object} 一个包含请求对象和请求编号(tId属性)的对象(conn属性)
 * @private
 */
L5.lib.Ajax.createXhrObject = function(transactionId) {
	var obj, http;
	try {
		http = new XMLHttpRequest();
		obj = {
			conn : http,
			tId : transactionId
		};
	} catch (e) {
		for ( var i = 0; i < this.activeX.length; ++i) {
			try {
				http = new ActiveXObject(this.activeX[i]);
				obj = {
					conn : http,
					tId : transactionId
				};
				break;
			} catch (e) {
			}
		}
	} finally {
		return obj;
	}
};
/**
 * 根据浏览器类型创建一个XMLHttpRequest对象
 * @returns {Object} 一个包含请求对象和请求编号(tId属性)的对象(conn属性)
 * @private
 */
L5.lib.Ajax.getConnectionObject = function() {
	var o;
	var tId = this.transactionId;
	try {
		o = this.createXhrObject(tId);
		if (o) {
			this.transactionId++;
		}
	} catch (e) {
	} finally {
		return o;
	}
};
/**
 * 发出异步ajax请求
 * @param {String} method
 * @param {String} uri
 * @param {Function} callback
 * @param {Object} postData 提交的数据
 * @returns
 * @private
 */
L5.lib.Ajax.asyncRequest = function(method, uri, callback, postData, headers) {
	var o = this.getConnectionObject();

	if (!o) {
		return null;
	} else {
		o.conn.open(method, uri, true);

		this.setHeader(headers, o);

		this.handleReadyState(o, callback);
		try {
			o.conn.send(postData || null);
		} catch (e) {
			throw new L5.Exception(550,
					L5.connectionError ? L5.connectionError
							: "connect to server failed");
		}
		return o;
	}
};

/**
 * 
 * @param method
 * @param uri
 * @param callback
 * @param postData
 * @param headers
 * @returns
 */
L5.lib.Ajax.syncRequest = function(method, uri, callback, postData, headers) {
	var o = this.getConnectionObject();

	if (!o) {
		return null;
	} else {
		o.conn.open(method, uri, false);

		this.setHeader(headers,o);
		
		try {
			o.conn.send(postData || null);
		} catch (e) {
			throw new L5.Exception(550,
					L5.connectionError ? L5.connectionError
							: "connect to server failed");
		}
		this.handleTransactionResponse(o, callback);
		return o;
	}
};
/**
 * 
 * @param o
 * @param {Object} callback 回调选项
 * 				success: 处理成功情况的函数
 *              failure: 处理失败情况的函数
 *              timeout : 超时设置
 *              argument：
 * @private
 */
L5.lib.Ajax.handleReadyState = function(o, callback) {
	var oConn = this;
	//设置超时、超时后会从客户端主动终端请求
	if (callback && callback.timeout) {
		this.timeout[o.tId] = window.setTimeout(function() {
			oConn.abort(o, callback, true);
		}, callback.timeout);
	}
	//设置轮询周期：会多次尝试处理响应内容
	this.poll[o.tId] = window.setInterval(function() {
		if (o.conn && o.conn.readyState == 4) {
			//请求结束了，可以处理响应内容了，需要先清理相关请求的定时和轮询设置
			window.clearInterval(oConn.poll[o.tId]);
			delete oConn.poll[o.tId];

			if (callback && callback.timeout) {
				window.clearTimeout(oConn.timeout[o.tId]);
				delete oConn.timeout[o.tId];
			}

			oConn.handleTransactionResponse(o, callback);
		}
		//请求没有完成，等待下次轮询再处理
	}, this.pollInterval);
};
/**
 * 处理响应内容
 * @param o
 * @param callback 回调选项
 * 				success: 处理成功情况的函数
 *              failure: 处理失败情况的函数
 *              timeout : 超时设置
 *              argument：
 * @param isAbort
 */
L5.lib.Ajax.handleTransactionResponse = function(o, callback, isAbort) {

	if (!callback) {
		this.releaseObject(o);
		return;
	}

	var httpStatus, responseObject;

	try {
		if (o.conn.status !== undefined && o.conn.status != 0) {
			httpStatus = o.conn.status;
		} else {
			httpStatus = 13030;
		}
	} catch (e) {

		httpStatus = 13030;
	}

	if ((httpStatus >= 200 && httpStatus < 300)
			|| (L5.isIE && httpStatus == 1223)) {
		responseObject = this.createResponseObject(o, callback.argument);
		if (callback.success) {
			if (!callback.scope) {
				callback.success(responseObject);
			} else {

				callback.success.apply(callback.scope, [ responseObject ]);
			}
		}
	} else {
		switch (httpStatus) {

		case 12002:
		case 12029:
		case 12030:
		case 12031:
		case 12152:
		case 13030:
			responseObject = this.createExceptionObject(o.tId,
					callback.argument, (isAbort ? isAbort : false));
			if (callback.failure) {
				if (!callback.scope) {
					callback.failure(responseObject);
				} else {
					callback.failure.apply(callback.scope,
							[ responseObject ]);
				}
			}
			break;
		default:
			responseObject = this
					.createResponseObject(o, callback.argument);
			if (callback.failure) {
				if (!callback.scope) {
					callback.failure(responseObject);
				} else {
					callback.failure.apply(callback.scope,
							[ responseObject ]);
				}
			}
		}
	}

	this.releaseObject(o);
	responseObject = null;
};
/**
 * 
 */
L5.lib.Ajax.createResponseObject = function(o, callbackArg) {
	var obj = {};
	var headerObj = {};

	try {
		var headerStr = o.conn.getAllResponseHeaders();
		var header = headerStr.split('\n');
		for ( var i = 0; i < header.length; i++) {
			var delimitPos = header[i].indexOf(':');
			if (delimitPos != -1) {
				headerObj[header[i].substring(0, delimitPos)] = header[i]
						.substring(delimitPos + 2);
			}
		}
	} catch (e) {
	}

	obj.tId = o.tId;
	obj.status = o.conn.status;
	obj.statusText = o.conn.statusText;
	obj.getResponseHeader = headerObj;
	obj.getAllResponseHeaders = headerStr;
	obj.responseText = o.conn.responseText;
	obj.responseXML = o.conn.responseXML;

	if (typeof callbackArg !== undefined) {
		obj.argument = callbackArg;
	}

	return obj;
};

L5.lib.Ajax.createExceptionObject = function(tId, callbackArg, isAbort) {
	var COMM_CODE = 0;
	var COMM_ERROR = L5.connectionError ? L5.connectionError
			: 'communication failure';
	var ABORT_CODE = -1;
	var ABORT_ERROR = 'transaction aborted';

	var obj = {};

	obj.tId = tId;
	if (isAbort) {
		obj.status = ABORT_CODE;
		obj.statusText = ABORT_ERROR;
	} else {
		obj.status = COMM_CODE;
		obj.statusText = COMM_ERROR;
	}

	if (callbackArg) {
		obj.argument = callbackArg;
	}

	return obj;
};
/**
 * 
 * @param headers
 * @param label
 * @param value
 * @private
 */
L5.lib.Ajax.addHeader = function(headers, label, value) {
	var headerObj = headers;

	if (headerObj[label] === undefined) {
		headerObj[label] = value;
	} else {
		headerObj[label] = value + "," + headerObj[label];
	}
};

/**
 * 将请求头信息赋给xmlhttprequest对象
 * @param {Object} o 对象，包含一个xmlhttprequest对象
 * @private
 */
L5.lib.Ajax.setHeader = function(h, o) {
	for (var prop in this.defaultHeaders) {
		if (this.defaultHeaders.hasOwnProperty(prop)) {
			o.conn.setRequestHeader(prop, this.defaultHeaders[prop]);
		}
	}
	for (var prop in h) {
		if (h.hasOwnProperty(prop)) {
			o.conn.setRequestHeader(prop, h[prop]);
		}
	}
};

/**
 * 终端请求
 * @public
 */
L5.lib.Ajax.abort = function(o, callback, isTimeout) {
	if (this.isCallInProgress(o)) {
		o.conn.abort();
		window.clearInterval(this.poll[o.tId]);
		delete this.poll[o.tId];
		if (isTimeout) {
			delete this.timeout[o.tId];
		}

		this.handleTransactionResponse(o, callback, true);

		return true;
	} else {
		return false;
	}
},
/**
 * 
 * @public
 */
L5.lib.Ajax.isCallInProgress = function(o) {
	if (o.conn) {
		return o.conn.readyState != 4 && o.conn.readyState != 0;
	} else {
		return false;
	}
};

/**
 * 释放连接
 * @param o
 */
L5.lib.Ajax.releaseObject = function(o) {
	o.conn = null;
	o = null;
};