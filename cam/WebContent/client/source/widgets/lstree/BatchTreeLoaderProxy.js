/**
 * 将多个treeloader的请求打包,统一向后台提交,一次性执行了若干个treeloader,需要后台支持
 * 批量请求使用POST方式发送参数和数据
 * @cfg string batchUrl
 * @cfg function getBatchJsonData 组装后台请求参数
 * 	function(record,reqloaders,params,queryall)
 * @cfg function isSupportBatchLoad
 * 	function(loader){
 * 		return true;
 * 	}
 * @param {Object} config
 */
L5.tree.BatchTreeLoaderProxy = function(config){
	var paths = document.location.pathname.split("/");
	this.batchUrl = "/"+paths[1]+"/COMMAND";
	/**
	 * allloaders
	 * curloaders 加载数据的loader
	 * record
	 */
	//"beforebatchload",
	/**
	 * allLoaders
	 * loaders 加载数据的loader
	 * record
	 * response
	 */
	//"batchload",
	/**
	 * allloaders 当前需要处理的loader
	 * curloaders 正在加载数据的loader
	 * record
	 * response 获得的返回值
	 */
	//"batchloadexception"
	L5.tree.BatchTreeLoaderProxy.superclass.constructor.apply(this,arguments);
};

L5.extend(L5.tree.BatchTreeLoaderProxy,L5.tree.TreeLoaderProxy,{
	/**
	 * 打包请求参数,将cmd的值拼装在一起;其他变量如果名称相同,后面的覆盖前面
	 */
	getRequestOption : function(record,loaders,reqloaders,params,queryall,callback){
		var url = this.batchUrl;
		var obj = {
			method:'POST',
			url: url,
			success: this.handleResponse,
			failure: this.handleFailure,
			scope: this,
			jsonData:this.getBatchJsonData(record,reqloaders,params,queryall),
			argument: {
				record: record,
				allLoaders:loaders,
				reqLoaders:reqloaders,
				callback:callback
			}
		};
		return obj;
	},
	
	/**
	 * 拼装L5请求数据
	 * 拼装结果:
	 * {
	 * 	'_L5_batchRequest':true,
	 * 	'_l5_components':'L5_Tree',
	 * 	batchParams:[{
	 * 		'id':'org.demo.stru.StruDataCommand',
	 * 		params:{
	 * 			'pageSize':10,
	 * 			'start':25,
	 * 			'struType':6
	 * 		}
	 * 	},{
	 * 		'id':'org.demo.user.UserDataCommand',
	 * 		params:{
	 * 			'pageSize':20
	 * 			'start':3,
	 * 			'organId':'O23123',
	 * 			'date':2222
	 * 		}
	 * 	}]
	 * }
	 * @param {Object} record
	 * @param {Object} reqloaders
	 * @param {Object} params
	 * @param {Object} queryall
	 */
	getBatchJsonData : function(record,reqloaders,params,queryall){
		var buf = {
			batchParams:[]
		};
		for(var i=0,len=reqloaders.length;i<len;i++){
			var loader = reqloaders[i];
			var loadjson = reqloaders[i].getJsonData(record,params,queryall);
			buf.batchParams.push(loadjson);
		}
		buf['_L5_batchRequest'] = true;
		buf['_l5_components'] = 'L5_Tree';
		
		var json=L5.encode(buf);
        return json;
	},
	
	/**
	 * @param {Object} record
	 * @param {Object} loader
	 */
	load : function(record,options,callback){
		var loaders;
		if(options.loaderId){
			var curloader = this.loaderMgr.getLoaderById(options.loaderId);
			curloader.load(record,options,callback);
			return;
		} else{
			loaders = this.loaderMgr.getRecordLoaders(record);
		}
		
		var params = options.params || {};
		var queryall = options.queryall || false;
		var i=0;
		var len=loaders.length;
		var batchproxyloader = this;
		var loadercallback = function(){
			if(i>=len){
				callback();
				return;
			}
			var batchloaders = [];//计算需要批量请求的treeloader
			for(;i<len;){
				var lder = loaders[i];
				i++;
				if(batchproxyloader.isSupportBatchLoad(lder)&&lder.isNeedSyn(record)){//考虑是否已经加载完毕
					batchloaders.push(lder);
				} else {
					break;
				}
			}
			if(batchloaders.length==1){
				batchloaders[0].load(record,options,loadercallback);
			} else {
				if(batchproxyloader.fireEvent("beforebatchload",loaders,batchloaders,record) !== false){
					var options = this.getRequestOption(record,loaders,batchloaders,params,queryall,loadercallback);//打包参数
					this.transId = L5.Ajax.request(options);
				} else {
					loadercallback();
				}
			}
		}
		loadercallback();
	},
	
	/**
	 * response.responseText格式:
	 * 	[{total:'',row:[]},{},{}]
	 * 对所有的loade进行遍历
	 * 	如果loader能够预加载,则预加载处理
	 * 	如果不能,则从response中后去后台加载数据
	 * 		使用loader.reader加载数据
	 * 		
	 * @param {Object} response
	 */
	handleResponse : function (response){
		var a = response.argument;
		var reqLoaders = a.reqLoaders;
		var allLoaders = a.allLoaders;
		var record = a.record;
		var callback = a.callback;
		try{
			var rtn = eval("("+response.responseText+")");
			if(rtn.length!=reqLoaders.length){
				throw "请求的loader与返回的数据不能对应";
			}
			for(var i=0,len=reqLoaders.length;i<len;i++){
				var curload = reqLoaders[i];
				curload.processJson(record,rtn[i]);
			}
			this.fireEvent("batchload",allLoaders,reqLoaders,record,response);
		}catch(e){
			this.fireEvent("batchloadexception",allLoaders,reqLoaders,record,response,e);
        }
		if(callback){
			callback();
		}
	},
	
	handleFailure : function (response) {
		this.transId = false;
		var a = response.argument;
		var reqLoaders = a.reqLoaders;
		var allLoaders = a.allLoaders;
		var callback = a.callback;
		var record = a.record;
		this.fireEvent("batchloadexception",allLoaders,reqLoaders,record,response);
		if(callback){
			callback();
		}
	},
	
	isLoading : function(){
		return !!this.transId;
	},
	
	abort : function(){
		if(this.isLoading()){
			L5.Ajax.abort(this.transId);
		}
	},
	
	/**
	 * 判断某个加载器是否适用批量加载
	 * 如果存在cmd说明适用批量加载
	 */
	isSupportBatchLoad : function (loader){
		if(!loader.cmd){
			return false;
		}
		return true;
	},
	
	//private
	fireEvent : function(evtName){
		if(this.dataset){
			return this.dataset.fireEvent.apply(this.dataset,arguments);
		}
		return true;
	}
});