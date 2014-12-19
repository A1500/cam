/**
 * command处理类
 * @class L5.Command
 * @param {String} id 执行的完整类名
 * @param {String} url 提交的URL，可不设置
 */
L5.Command = function(id,url){
    this.id = id;
	if (url)
		this.url = url;
	else
		this.url = L5.webPath + "/command/ajax";
	this.params = new L5.Map("ParameterSet");
	this.returns = new L5.Map("ParameterSet");
};
/**
 * 请求上下文参数
 */
L5.Command.context=new L5.Map();
/**
 * 设置提交到服务器的请求上下文参数值
 * @method setContextParameter
 * @param {String} name 参数名称
 * @param {String} value 参数值
 */
L5.Command.setContextParameter=function(name,value){
	L5.Command.context.put(name,value);
}
L5.setCP=L5.setContextParameter=L5.Command.setContextParameter;
/**
 * 获取提交到服务器的请求上下文参数值
 * @method getContextParameter
 * @param {String} name 参数名称
 */
L5.Command.getContextParameter=function(name){
	return L5.Command.context.get(name);
}
L5.getCP=L5.getContextParameter=L5.Command.getContextParameter;
L5.Command.prototype = {
	/**
	 * 文件上传需要绑定form
	 * @method setForm
	 * @param {HTMLElement} dom form的dom结构
	 */
	setForm : function(dom) {
		this.form = dom;
	},
	/**
	 * 设置提交到服务器的参数
	 * @method setParameter
	 * @param {String} name 参数名称
	 * @param {String} value 参数值
	 */
	setParameter : function(name, value){
		this.params.put(name,value);
	},
	/**
	 * 获得服务器返回的参数
	 * @method getReturn
	 * @param {String} name 参数名称
	 * @return {String} 参数对应的值
	 */
	getReturn : function(name){
		return this.returns.get(name);
	},	
	/**
	 * 处理响应值
	 * @method loadResponse
	 * @private
	 * @param {Object} optinons 配置信息
	 * @param {Boolean} success 是否加载数据出现异常
	 * @param {Object} response 响应
	 */
	loadResponse : function(options,success,response)
	{
		if (this.error)
			return;
		try {
			// 通讯异常
			if (!success) {
				this.error = {
					"code" : response.status,
					"msg" : response.response.status
				};
				throw new L5.Exception(response.status, response.statusText);
			}
			var obj = L5.decode(response.responseText);
			// 业务异常
			if (obj.error) {
				this.error = obj.error;
				var exception=new L5.Exception(obj.error.code, obj.error.msg,
						obj.error.trace)
				if(obj.error.title){//如果有自定义title，则复制给exception
					exception.title=obj.error.title;
				}
				throw exception;
			}
			// 一切正常
			this.returns = L5.serializer.unmarshall(obj);
		} catch (e) {
			this.error = e;
		}
		var ret = this.returns.map;
		for (name in ret) {
			var obj = ret[name];
			if (obj && obj.javaClass && obj.javaClass == "DataSet") {
				L5.DatasetMgr.lookup(name).loadData(obj);
			}
		}
		if (this.afterExecute)
			this.afterExecute();
	   	
	},
	/**
	 * 执行Command
	 * @method execute
	 * @param {String} method 执行的command中的方法名
	 * @param {Boolean} sync 是否同步执行，默认为true
	 */
	execute : function(method,sync){
		var t_sync = true;
		var t_method = null;
		for (i = 0; i < arguments.length; i++) {
			if (arguments[i] == true || arguments[i] == "true") {
				t_sync = true;
			} else if (arguments[i] == false || arguments[i] == "false") {
				t_sync = false;
			} else {
				t_method = arguments[i];
			}
		}
		var url = this.url + "/" + this.id;
		if (t_method != null) {
			url = url + "/" + t_method;
		}
		var data = {
			"params" : this.params,
			"context" : L5.Command.context
		};
		var json = L5.encode(data);
		var obj = this;
		var o = {
			url : url,
			jsonData : json,
			callback : this.loadResponse,
			scope : this
		};
		if (t_sync)
			o.sync = true;
		if (this.form) {
			o.form = this.form;
			o.isUpload = true;
		};
		try {
			L5.Ajax.request(o);
		} catch (e) {
			this.error = e;
		}
	},
	/**
	 * 清空状态：参数、返回值、错误信息
	 * @method reset
	 * @private
	 */
	reset : function(){
		this.params = new L5.Map("ParameterSet");//short name
		this.returns = new L5.Map("ParameterSet");//short name
		this.error=null;
	}
};

/*
 * 特殊的Command,可以将多个Command打包一起执行
 * @class L5.CommandQueue
 * @constructor
 * @private
 */
/*
L5.CommandQueue = function(url){
	this.id="org.loushang.next.web.cmd.CommandQueue";
	this.queue=new Array();
	if(url) this.url = url;
    else this.url="http://localhost:8080/next/COMMAND";//
};

L5.CommandQueue.prototype = {	
	add : function(command){
		this.queue.push(command);
	},
	
	loadResponse : function(options,success,response)
	{
		if(this.error)return;
		try{
		
		if(!success)throw new L5.Exception(response.status, response.statusText);	
		var obj=L5.decode(response.responseText);
		
		if(obj.error)throw new L5.Exception(obj.error.code, obj.error.msg,obj.error.trace);
	   
		var ret=L5.serializer.unmarshall(obj);
		}catch(e){
	   		this.error=e;
	   	}	
		var returns=ret.get("return_all");
		for(j=0;j<this.queue.length;j++){
			this.queue[j].returns=L5.serializer.unmarshall(returns[j]);		
		}
		
		for(k=0;k<this.queue.length;k++){
			if(this.queue[k].afterExecute){
				this.queue[k].afterExecute();
			}
		}
	},
	execute : function(sync){
		if(sync==null||sync=="undefined")sync=true;
		var obj=this;
		var o = {
			url : this.url,
		    jsonData : this._getJsonData(),
		    callback : this.loadResponse,
		    scope : this
		};
		if(sync)o.sync=true;
		try{
		L5.Ajax.request(o);
		}catch(e){
			this.error=e;
		}
	},
	
	
	_getJsonData : function(){
		
		var clazz_all=new Array();
		var param_all=new Array();
		for(i=0;i<this.queue.length;i++){
			clazz_all[i]=this.queue[i].id;
			param_all[i]=this.queue[i].params;
		}
		var params=new L5.Map("org.loushang.next.data.ParameterSet");
		params.put("clazz_all",clazz_all);
		params.put("param_all",param_all);
		
		var data={"id":this.id,"params":params};
		return L5.encode(data);
	}
};

*/