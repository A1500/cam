/**
 * 负责加载数据,与原来的L5.tree.TreeLoader定位一样
 * 
 * 加载数据时分三种情况:
 * 	1加载全部数据
 * 	2加载下一页数据
 *  3加载剩余的所有数据
 *  
 * 每个loader都有触发条件
 * 
 * 一般前台节点个数超过后台记录个数时要就不需要从后台加载数据
 * 后台可以多传送子节点的数据,最好与分页情况一致,比如pageSize是10,传送20条可以,如果传送23,我们就无法计算下一页数据的起始位置
 * 	因此我们拒绝接受此数据
 * 后台也可以一次性多传送一些子节点的子节点数据
 * 多传送的数据并不能保证当即生效,为了前台展现的平滑效果,我们可以将其缓存起来供以后解析用
 * 
 * 有时候我们在前台准备好了一些数据,并不希望从后台获取,这一点百分百支持,可以使用data属性指定从js变量、json中加载数据
 * 
 * 有时候我们会希望已经完全加载的节点不要再试图从后台加载数据了,比如后台总共200条记录,已经加载了200条,
 * 这时候就使用isNeedSyn停止无谓的网络带宽消耗吧,
 * 
 * 有时候我们希望后台不用改动,只需要改变前台的加载策略,就可以构造一棵不一样的树.目前我们能够想到的是对加载的数据进行前台过滤,
 * 给TreeLoader配置filter吧
 * 
 * 有时候我们希望能够不使用Loushang5的command请求数据,这时候可以使用paramHandler组装自己的url参数,
 * 但是你要小心处理数据的批量加载
 * 
 * loader配置示例:
 * 1
 * {
 * 		cmd:'org.loushang.demo.tree.StruDataCommand',
 * 		reader:new L5.tree.TreeJsonReader({
 *			"root" : "rows",
 *			"totalProperty" : "total",
 *			"successProperty" : "success",
 * 			id:'id'
 *		}, Co),
 * 	}
 * 2
 * {
 * 		cmd:'org.loushang.demo.tree.StruDataCommand',
 * 		recordType:{fields:['struId','type','organId'],name:'stru',idField :'struId'},
 * 		baseParams : {
 * 			parentId:1,
 * 			struName:function(rec){
 * 				return rec.get('struName');
 * 			}
 * 		},
 * 		trigger : function(record){
 * 		},
 * 		filter : function(record){
 * 			if(record.get('type')=='6'){
 * 				return true;
 * 			}
 * 			return false;
 * 		}
 * }
 * 3
 * {
 * 	url:'data.json',
 * 	paramHandler : function(load,record,params,queryall){
 * 		return "struType=01&type=6";
 * 	},
 * 	trigger : function(record){},//trigger : 'struId' trigger:'leaf#true'
 *  pageRemain : 20,//如果同时多个人编辑树,我们使用此变量估算数据的更新速度,这样我们获取全部数据时尽量能够同步数据
 *  isNeedSyn : function(record){
 *  	return true;
 *  }
 * }
 * 4
 * {
 * 	data:{
 * 		total:'',
 * 		rows:[{children:{rows:[{},{}]},{}]},
 * 		success:true
 * 	}
 * }
 * 往record中缓存了如下数据
 * 	total:400,
 * 	curNum:200,
 * 	curLoadDataSize:20,
 * 	pageSize:10,
 * 	index:[0,100],
 * 	children:{}
 * @param {Object} config
 * 
 * @cfg string||object {name:'stru',fields:[],idField :''} recordType
 * @cfg treejsonreader reader
 * @cfg function(record) filter
 * @cfg json data
 * @cfg string url
 * @cfg string requestMethod 	POST或者GET
 * @cfg object baseParams
 * 		start
 * 		limit
 * 		....
 * @cfg int pageRemain
 * @cfg function(record)||key#value trigger
 * @cfg function(record) isNeedSyn
 * @cfg string intervalKey 标志加载的子节点在父节点中的区间id
 * @cfg string cmd
 * @cfg String method 如果cmd所指定的类继承自MultiCommand，必须声明method参数
 * @cfg string responseKey method可能返回了多个dataset，对应其中的某个dataset
 */
L5.tree.LsTreeLoader = function (config,id){
// * @cfg function(loader,record,params,queryall) paramHandler 返回一个字符串,在get类型的请求中拼接url
	this.id = (id || id === 0) ? id : ++L5.tree.LsTreeLoader.AUTO_ID;//loader唯一标识
	this.jsonModel = false;//jsonModel json模式时command信息在post数据中,否则command信息位于url中
	this.init(config);
	
	this.addEvents(
		/**
		 * this loader
		 * parent record
		 */
		'beforeload',
		/**
		 * this loader
		 * parent record
		 * response
		 */		
		'load',
		/**
		 * this loader
		 * parent record
		 * response
		 */
		'loadexception'
	);
	
	L5.tree.LsTreeLoader.superclass.constructor.call(this);
};

L5.tree.LsTreeLoader.AUTO_ID=1000;

(function(){
L5.extend(L5.tree.LsTreeLoader, L5.util.Observable, {
	init : function (config){
		this.initReader(config);
		if(config.cmd){
			this.cmd = config.cmd;
			this.url = L5.webPath+"/command/ajax";
			if(!this.jsonModel){
				this.url +="/"+this.cmd;
			}
		} else {
			this.url = config.url;
		}
		if(config.data){
			this.data = config.data;//前台json数据
		}
		
		this.baseParams = config.baseParams||{};
		
		if(this.cmd && config.method){		
			this.url +="/"+config.method;
		}
		if(config.pageSize){
			this.pageSize = config.pageSize;
			//用户可以有几种方式修改start/limit,比如提供一个自己的start/limit，或者监听beforeLoad，改变record中
			//childLoadInfo中pageSize与start值
			var scope = this;
			this.baseParams["start"] = this.baseParams["start"] ||
						function(rec){
							return scope.getPageStart(rec);
						};//当前行
			this.baseParams["limit"] = this.baseParams["limit"] ||
						function(rec){
							return scope.getPageSize(rec);
						};//页记录
		}
		
		this.requestMethod = config.requestMethod || 'POST';
		
		var trigger = config.trigger;
		if(typeof trigger == 'string'){
			this.triggerCheckKey = trigger.split("#");
			this.trigger = this.triggerCheckWithString;
		} else if(typeof trigger == 'function'){
			this.trigger = trigger;
		}
		if(config.isNeedSyn){
			this.isNeedSyn = config.isNeedSyn;
		}
		//分页情况下获取剩余数据时使用,用来估算后台数据可能的更新情况
		this.pageRemain = config.pageRemain || 10;
		
		this.intervalKey = config.intervalKey || this.reader.recordType.recordType;
	},
	
	initReader : function(config){
		if(!this.reader){//如果已经存在reader,说明子类已经给reader赋值
			if(config.reader){
				this.reader = config.reader;
			} else {
				var meta = config.meta || {
					root:'rows',
					totalProperty:'total',
					successProperty:'success'
				};
				var filt = config.filter || L5.emptyFn;
				//如果没有配置recordType,则认为使用原始的tree数据结构
				this.reader = new L5.tree.JsonReader(meta,config.recordType||L5.tree.SimpleTreeRecord,filt,config.responseKey);
			}
		}
		if(config.responseKey){//loushang5后台一个cmd可以返回map,里面包含多种数据,使用responseKey指明具体使用哪个值
			this.reader.responseKey=config.responseKey;
			this.responseKey = config.responseKey;
		}
		if(this.reader.recordType){
			this.recordType = this.reader.recordType;
		}
	},

	/**
	 * 拼装GET请求数据
	 * 返回字符串
	 * 如果是command请求,拼装
	 * 如果不是,直接拼装一个url后缀
	 * @param {Object} record
	 * @param {Object} params
	 * @param {Object} queryall
	 */
	getParams : function(record,params,queryall){
		if(this.paramHandler){
			return this.paramHandler(this,record,params,queryall);
		}
		var parammap = this.getParamValue(record,params,queryall);
		if(!this.cmd){
	        var buf = [];
	        for(var key in parammap){
				buf.push(encodeURIComponent(key), "=", encodeURIComponent(parammap[key]), "&");
	        }
			buf.pop();//移除最后一个&
	        return buf.join("");
		}
		
		var paramset=new L5.Map("org.loushang.next.data.ParameterSet");
        for(var key in parammap){
			paramset.put(key,parammap[key]);
        }
		var data={params:paramset};
		if(this.jsonModel){
			data["id"] = this.cmd;
		}
		var json=L5.encode(data);
		return 'jsonData='+encodeURIComponent(json);
	},
	
	
	/**
	 * 返回请求参数的值,不返回字符串,返回一个对象
	 * queryall 是否加载全部数据 拼装分页信息时需要使用
	 * 处理过程
	 * 	如果不需要查询全部数据,参数该怎么拼装还怎么拼装
	 * 	如果没有分页,参数该怎么拼装还怎么拼装
	 * 	如果分页并且需要查询全部数据
	 * 		如果是第一次查询数据
	 * 			忽略分页信息
	 * 		如果不是
	 * 			查询剩下的数据
	 * @param {Object} record
	 * @param {Object} params
	 * @param {Object} queryall
	 */
	getParamValue : function(record,params,queryall){
		params = params ||{};
		queryall = queryall || false;
        var buf = {}, bp = this.baseParams;
        for(var key in bp){
			var vl = bp[key];
            if(typeof vl == "function"){
				vl = vl(record);
            }
			if(vl == undefined){
				continue;
			}
			buf[key] = vl;
        }
        for(var key in params){
			var vl = params[key];
            if(typeof vl == "function"){
				vl = vl(record);
            }
			if(vl == undefined){
				continue;
			}
			buf[key] = vl;
        }
		
		if(queryall&&this.pageSize){
			var firstquery = true;
			var curLoadDataSize = record.getLoaderProperty(this.id,'curLoadDataSize');
			if(curLoadDataSize){
				firstquery = false;
			}
			if(firstquery){
				delete buf['start'];
				delete buf['limit'];
			} else {
				var pgsize = buf['limit'];
				var totalnum = record.getLoaderProperty(this.id,'total')||0;
				buf['limit'] = totalnum+this.pageRemain;//多取一点,如果别的用户添加过记录那就避免了再次获取
			}
		}
        return buf;
	},
	
	/**
	 * 拼装POST请求数据
	 * 如果是command请求，拼装成L5.Map
	 * 如果不是,直接将参数对象返回
	 * @param {Object} record
	 * @param {Object} params
	 * @param {Object} queryall
	 */
	getJsonData : function(record,params,queryall){
		var para = this.getParamValue(record,params,queryall);
		if(this.cmd){
			var paramset=new L5.Map("org.loushang.next.data.ParameterSet");
	        for(var key in para){
				paramset.put(key,para[key]);
	        }
			var data={"params":paramset};
			if(this.jsonModel){
				data["id"] = this.cmd;
			}
			var json=L5.encode(data);
			return json;
		}
        return L5.encode(para);
	},
	
	/**
	 * 获取L5.Ajax.request需要的请求数据
	 * @param {Object} record
	 * @param {Object} params
	 * @param {boolean} queryall 是否加载全部数据 拼装分页信息时需要使用
	 */
	getRequestOption : function(record,params,queryall,callback){
		var url = this.url;
	/*	if(url.indexOf("?")==-1){//将parentId作为参数拼装到末尾,这样做主要是因为loushang5的ParameterSet
								//用户如果使用BaseQueryCommand,会将传递回去的json数据直接出入dao查询数据
								//如果我们将parentId作为json数据的一部分,dao拼装的sql就可能出问题
								//因此将parentId作为url的一部分处理
			url +=('?parentId='+record.id);
		} else {
			url +=('&parentId='+record.id);
		}*///将url里面的parentId去掉
		//如果没有配置自定义参数,则不组装件一个parentId参数
		var obj = {
	        method:this.requestMethod,
	        url: url,
	        success: this.handleResponse,
	        failure: this.handleFailure,
	        scope: this,
	        argument: {record: record,callback:callback}
		};
		if(this.requestMethod=='POST'){
			obj["jsonData"] = this.getJsonData(record,params,queryall);
		} else{
			obj["params"] = this.getParams(record,params,queryall);
		}
		return obj;
	},
	
	/**
	 * 如何判断record存在某个loader加载过的数据
	 * 从record中获取如下属性
	 * 		curLoadDataSize:20,
	 * 		pageSize:10,
	 * 		children:{}
	 * children标志了以前加载却未解析的数据
	 * 当数据解析完毕后需要删除children
	 * 
	 * @param {Object} record
	 */
	doPreLoad : function(record){
		var childrendata = record.getLoaderProperty(this.id,"children");
		if(!childrendata){
			return false;
		}
		record.removeLoaderProperty(this.id,'children');
		
		var result = this.reader.readRecords(childrendata,this.parseChildRecord,this);
		var children = result.records;
		var len = children.length;
		if(len!=0){//不能因为len==0就返回false,不然多个loader加载数据时,某个loader是否存在预先加载数据不好判断
					//我们假定loader对返回的数据格式除了children外一无所知,
			this.loadRecords(record,children,result.totalRecords);
		}
		return true;
	},
	
	/**
	 * 是否有预先加载的数据
	 */
	hasPreData : function(record){
		var data = record.getLoaderProperty(this.id,'children');
		if(!data){
			return false;
		}
		return true;
	},
	
	/**
	 * 单个loader返回的数据是:
	 * 	{
	 * 		total:'',
	 * 		rows:[{children:{rows:[{},{}]},{}]},
	 * 		metaData:{totalProperty:'total',root:'rows',successProperty:'success',id:''},
	 * 		success:true
	 * 	}
	 * 
	 * 处理过程
	 * 	如果以前预先加载过数据，则不需要加载
	 * 	如果没有加载
	 * 		如果不需要同步数据
	 * 			返回
	 * 		触发加载前事件
	 * 		存在分页信息,
	 * 			如果没有指定加载全部数据
	 * 				则加载一页数据
	 * 			如果指定加载全部数据
	 * 				加载剩余的所有数据
	 * 		不存在分页,加载全部数据
	 * 		reader解析数据
	 * 		触发加载结束事件
	 * 
	 * 可以使用load(record,queryall)调用
	 * @param {Object} record
	 * @param {boolean} queryall 是否加载全部数据
	 */
	load : function(record,options,callback){
		options = options || {};
		var params = options.params;
		var queryall = options.queryall;
		if(this.doPreLoad(record)===true || !this.isNeedSyn(record)){//如果不需要加载后台数据,返回
			if(callback){
				callback();
			}
			return ;
		}
		if(!this.data){
			//请求后台
			if(this.url&&this.fireEvent("beforeload",this,record) !== false){
				this.transId = L5.Ajax.request(this.getRequestOption(record,params,queryall,callback));
				return;
			}
		} else {
			//如果是内存中的数据
			if(this.data.constructor==L5.model.Dataset)//如果是dataset对象
				this.processDataSet(record,this.data);
			else if(typeof this.data=='string'){//如果是dataset  id
				this.processDataSet(record,L5.DatasetMgr.lookup(this.data));
			}else//来自于json
				this.processJson(record,this.data);
		}
		if(callback){
			callback();
		}
	},
	
	handleResponse : function(response){
		this.transId = false;
		var a = response["argument"];
		var rec = a.record;
		var callback = a.callback;
		try{
			var rtn = this.processResponse(rec,response);
			//回调TreeLoaderProxy类的load方法，执行回调TreeRecord类的loadComplete方法(修改this.loading值为false)
			if(callback){
				callback();
			}
			return rtn;
		} catch(e){
			this.fireEvent("loadexception", this, rec, response,e);
			if(callback){
				callback();
			}
		}
	},
	
	handleFailure : function(response){
		this.transId = false;
		var a = response.argument;
		var rec = a.record;
		var callback = a.callback;
		this.fireEvent("loadexception", this, rec, response);
		if(callback){
			callback();
		}
	},
	
	/**
	 * 
	 * 使用reader去加载数据
	 * 	使用回调函数处理新创建的record的childLoadInfo
	 * 获取解析数据
	 * 如果加载成功
	 * 	获取加载的record
	 * 	将新的record添加到当前record的子节点中
	 * 如果加载失败
	 * 	处理失败，丢弃此次请求获取的数据
	 * @param {Object} record
	 * @param {Object} response
	 */
	processResponse : function(record,response){
		//reader去处理,返回新建的record
		var result = this.reader.read(response,this.parseChildRecord,this);
		var suc = result.success;
		
		if(suc){
			var children = result.records;
			this.loadRecords(record,children,result.totalRecords);
			this.fireEvent("load", this, record, response);
		}  else {
			this.fireEvent("loadexception", this, record, response);
		}
		return suc;
	},
	
	/**
	 * 解析json数据,processResponse解析的是字符串返回值,这里解析的是字符串eval成的json对象
	 * @param {Object} record
	 * @param {Object} json
	 */
	processJson : function(record,json){
		var result = this.reader.readRecords(json,this.parseChildRecord,this);
		var suc = result.success;
		
		if(suc){
			var children = result.records;
			this.loadRecords(record,children,result.totalRecords);
			this.fireEvent("load", this, record, json);
		} else {
			this.fireEvent("loadexception", this, record, json);
		}
		return suc;
	},
	/**
	 * 解析dataset数据
	 * @param {Object} record
	 * @param {Object} dataset
	 */
	processDataSet : function(record,dataset){
		var nameAndValue=this.parseBaseParams(this.baseParams);
		var collection=dataset.query(nameAndValue[0],nameAndValue[1](record));
		var result = this.reader.parseRecords(collection,this.parseChildRecord,this);
		var suc = result.success;
		
		if(suc){
			var children = result.records;
			this.loadRecords(record,children,result.totalRecords);
			this.fireEvent("load", this, record, dataset);
		} else {
			this.fireEvent("loadexception", this, record, dataset);
		}
		return suc;
	},
	parseBaseParams:function(params){
		var name=null;
		var value=null;
		for(var param in params){
			var names=param.split('@');
			name=names[0];
			value=params[param];
		}
		return [name,value];
	},
	/**
	 * 将子节点record加入父节点
	 * 
	 * 计算当前load的record数据在record.children中的下标
	 * 然后将加载的子节点数据全部添加到此下标的后面,原来的节点顺次后移
	 * 重新计算分页等信息
	 * 
	 * @param {treerecord} record
	 * @param {array} children
	 * @param {int} nums 总记录个数.如果支持分页,就是后台所有的数据个数
	 */
	loadRecords : function(record,children,totalnums) {
		this.initLoaderData(record,totalnums||children.length,children.length);
		record.insert(children,this.intervalKey);//如果record能够回滚呢?这里强制落实信息
	},
	
	/**
	 * 初始化record中loader对应的的属性
	 * 更新record中的total信息
	 * @param {Object} loaddatalen
	 * @param {Object} totalnum
	 */
	initLoaderData : function(record,totalnum,loadsize){
		if(this.pageSize){
			var oldps = record.getLoaderProperty(this.id,'pageSize');
			if(!oldps){
				record.setLoaderProperty(this.id,'pageSize',this.pageSize);
			}
		}
		record.setLoaderProperty(this.id,'total',totalnum);
		var olddatasize = record.getLoaderProperty(this.id,'curLoadDataSize');
		if(olddatasize){
			olddatasize +=loadsize;
		} else {
			olddatasize =loadsize;
		}
		record.setLoaderProperty(this.id,'curLoadDataSize',olddatasize);
	},
	
	/**
	 * 是否需要同步后台数据
	 * 后台节点数据大于当前节点个数时需要从后台获取数据,否则不获取后台数据
	 * @param {Object} record
	 */
	isNeedSyn : function(record){
		var curload = record.getLoaderProperty(this.id,'curLoadDataSize');
		var toatl = record.getLoaderProperty(this.id,'total');
		if(curload===false){
			return true;
		}
		if(curload>=toatl){
			return false;
		}
		return true;
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
	 * 主要是处理record的子节点,将其缓存到record.childLoadInfo[].attributes中
	 * JsonReader解析record时回调用
	 * @param {Object} record 当前record
	 * @param {Object} json 当前record的对应json
	 * @param {Object} meta 当前json的元数据
	 * @param {Object} opt 传入的一些其他参数
	 */
	parseChildRecord : function(record,json,meta,opt){
		record.loader= this.id;
		var children = json.children;
		delete json.children;
		
		if(children){
			json.meta = meta;
			//需要注意,这里存在一个问题
			//如果record的子节点loader中并没有当前loader,那么children数据就会一直存在
			//如果不能接受这点,可以在TreeLoaderMgr中进行检查
			record.setLoaderProperty(this.id,'children',children);
		} else {
			if(this.data!=null){
				record.loaderLeaf = true;
			}
		}
	},
	
	/**
	 * 获取当前load数据在record中的记录行数
	 * 在record中存放了如下数据
	 * 		total:400,
	 * 		curNum:200,
	 * 		curLoadDataSize:200,
	 * 		pageSize:10,
	 * 		index:[0,100],
	 * 		children:{}
	 * start标志了当前record中此loader加载并解析的数据已经存在多少行
	 * 
	 * @param {Object} record
	 */
	getPageStart : function(record){
		var pagestart = record.getLoaderProperty(this.id,'curLoadDataSize');
		return pagestart || 0;
	},
	
	/**
	 * 获取一页记录的个数
	 * @param {Object} record
	 */
	getPageSize : function(record){
		var pageSize = record.getLoaderProperty(this.id,'pageSize');
		return pageSize || this.pageSize;
	},
	
	/**
	 * 获取记录个数
	 * @param {Object} record
	 */
	getRecordNumber : function(record){
		var curNum = record.getLoaderProperty(this.id,'curNum');
		return curNum || 0;
	},
	
	/**
	 * 如果返回true,record使用loader加载数据
	 * 默认处理方式:如果record的类型与treeloaer的节点类型匹配,返回true
	 * @param {Object} record
	 */
	trigger : function(record){
		if(this.recordType){
			return record.recordType === this.recordType.recordType;
		}
		return true;
	},
	
	/**
	 * 与this.trigger 作用一致，用户配置的trigger是string类型时使用此方法判断loader是否可以使用
	 * @param {Object} record
	 */
	triggerCheckWithString : function(record){
		var key = this.triggerCheckKey[0];
		var vls = this.triggerCheckKey[1];
		if(vls){
			if(record.get(key)==vls){
				return true;
			}
		} else {
			if(record.get(key)){
				return true;
			}
		}
		return false;
	}
});
})();
L5.tree.TreeLoaderMgr.loaderType.loader = L5.tree.LsTreeLoader;