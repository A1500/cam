//doc
/**
 * @ignore
 * dataset相当于前台的数据库
 * 
 * 一般来说,dataset有如下的作用
 * 	加载数据
 * 		1可以从一个xml中加载,也可以从json中加载
 * 		2可以从前台加载,也可以从后台加载
 * 	管理数据
 * 		用户可以根据id获取到record
 * 		收集用户对record的修改信息,便于用户恢复数据并且减少提交后台数据量
 * 		record排序
 * 		树遍历
 * 由于树的特殊性,加载数据时必须制定是加载哪个record子节点,因此treedataset只有管理数据的功能,
 * 加载功能交由treerecord完成
 * 
 * 为了方便dataset的共享,比如两棵树共用一个dataset,dataset提供了事件分发功能,用户可以给dataset注册
 * 监听器,当用户操作dataset时,能够将消息分发出去
 * 本来用户也可以在dataset中分别为每一个事件注册监听器,但是销毁这些监听器时需要挨个儿remove,提供事件分发器,
 * 销毁时只需要移除事件分发器就可以了
 * 
 * TreeDataSet必须存在一个根record
 * 
 * 需要dataset共享的例子:组织机构选择父机构,弹出通用帮助里显示的数据一样,只是多了checkbox
 * dataset如果被几棵树共享的话,就不能存在currentRecord这个概念。比如选择父机构示例中,用户选择一个节点,
 * 当前节点为record;弹出通用帮助,用户再次选择一个节点,此时当前节点为recordb,显然,用于显示机构明细的form
 * 应当显示recorda的信息,而不是recordb.因此,我们不提供currentRecord,转而提供currentNode,用户根据
 * currentNode获得一个record
 * 
 * dataset使用loader去加载数据,每个loader都有一个触发条件,每个节点都由唯一一个loader加载而来
 * 触发条件是指当前节点满足条件时使用此loader加载子节点.在所有的配置过的loader中检查是否有触发的loader
 * 需要添加对批量执行loader的支持,批量加载的各个loader的请求参数需要一致，比如都配置了分页信息
 * 
 * 树与别的组件联合,操作record的场景:
 * 	form,用于显示明细
 * 		监听tree的click,然后将node.record传递给form
 * 			TreePanel新加一个属性formbinding
 * 		form修改数据：
 * 			修改form-->修改record-->record收集修改情况,并通知dataset修改,dataset记录下修改过的记录
 * 								-->触发treenode对record的监听器
 * 		用户切换树节点-->回滚dataset数据
 * 	grid,用在批量修改记录时用
 * 		监听trees的click事件,然后griddataset.clear();griddataset.loadRecord(node.record.children)
 * 			node.record监听griddataset的add/delete等事件
 * 			TreePanel新加一个属性bangdings,废弃formbinding属性
 * 				bindings:{
 * 					form:formbinding,
 * 					grid:gridbinding
 * 				}
 * 			注意:loadRecord的数据不能被grid进行再加工
 * 		grid修改：
 * 			增加:
 * 				griddataset.add-->触发record.add-->触发node.appand
 * 												-->treedataset收集修改记录
 * 			删除:
 * 				griddataset.delRecord-->触发record.remove-->触发node.remove
 * 												-->treedataset收集修改记录
 * 			修改:
 * 				griddataset.update-->触发record.update-->触发node.updates
 * 		用户切换树节点-->回滚dataset数据
 * 	tree,两颗树联动,与grid类似处理
 * treedataset收集修改记录
 * 	修改了record时,treedataset记录record被修改
 * 	record添加记录时,treedataset记录record被修改
 * 	record删除记录时,treedataset记录record被修改
 * 	treedataset不重复记录被修改的record
 * 	treedataset使用record的回滚与提交
 * 	record回滚与提交不会级联回滚与提交
 * 
 * dataset配置示例
 * var stru = L5.tree.TreeRecord.create('stru',[]);
 * var dataset = new L5.tree.TreeDataSet({
 * 	id : 'stru',
 * 	root : rootrecord,
 * 	loaders : [{
 * 		cmd:'org.loushang.demo.tree.StruDataCommand',
 * 		reader:new L5.model.JsonReader({
 *			"root" : "rows",
 *			"totalProperty" : "total",
 *			"successProperty" : "success"
 *		}, Co),
 *		trigger : 'leaf',
 *		recordType : 'stru'
 * 	},{
 * 		trigger:'struType:"6"',
 * 		url:'test.json',
 * 		baseParams:{
 * 			type:'struType',
 * 			address:'1',
 * 		},
 * 		recordType : 'role'
 * 	},{
 * 		trigger:'userId',
 * 		url:'res.cmd',
 * 		recordType : 'user'
 * 	}]
 * });
 * 
 * var dataset = new new L5.tree.TreeDataSet({
 * 	loaders:[],
 * 	batchUrl : '',
 * 	batchLoad:true,
 * 	isSupportBatchLoad:function(loader){},
 * 	listeners:{
 * 		beforebatchload : function(){},
 * 		batchload : function(){},
 * 		batchloadexception : function(){}
 * 	},
 * 	root:root,
 * 	id : ''
 * });
 * 
 * @cfg string id
 * @cfg string pathSeparator
 * @cfg TreeRecord root
 * @cfg array[TreeLoader||TreeLoaderConfig] loaders
 * @cfg L5.tree.TreeLoaderProxy proxyLoader
 * @cfg object listeners 监听器
 */
//暂不暴露，以后统一由加载策略控制，用户直接配置加载策略
// * @cfg boolean batchLoad 是否支持一次性批量打包提交url
// * @cfg string batchUrl
// * @cfg function(record,reqloaders,params,queryall){} getBatchJsonData 组装批量加载的参数
// * @cfg function(loader){} isSupportBatchLoad  判断某个loader是否需要添加进批量加载,比batchLoad提供更细致的服务
/**
 * @class L5.tree.TreeDataSet
 * @extends L5.util.Observable
 */
L5.tree.TreeDataSet = function(config){
	config = config || {};
	this.pathSeparator = '/';
	this.root = false;
	this.loaders = [];
	this.batchLoad = false;
	this.eventDispacher = {};//事件分发器
	L5.apply(this,config);
	this.addEvents(
		/**
		 * @ignore
		 * oldrecord
		 * newrecord
		 */
		'rootchange',
		/**
		 * @ignore 
		 * parent record
		 * add record
		 * index
		 * total insert num
		 */
		'add',
		/**
		 * @ignore
		 * update record
		 * modify
		 * status
		 */		
		'update',
		/**
		 * @ignore
		 * parent record
		 * remove record
		 * remove recs number
		 */
		'remove',
		/**
		 * parent record
		 * sort records 排序完毕的记录
		 * index
		 */
		"sort",
		/**
		 * @ignore
		 * array allLoaders 当前record所有需要执行的加载器
		 * array loaders 需要批量加载数据的loader
		 * record
		 */
		'beforebatchload',
		/**
		 * @ignore
		 * array allLoaders
		 * array curloaders
		 * record
		 * response
		 */
		'batchload',
		/**
		 * @ignore
		 * array allLoaders
		 * array loaders 当前加载过数据的loader
		 * record
		 * response
		 * e 错误信息
		 */
		'batchloadexception',
		/**
		 * @ignore
		 * this loader
		 * parent record
		 */
		'beforeload',
		/**
		 * @ignore
		 * this loader
		 * parent record
		 * response
		 */		
		'load',
		/**
		 * @ignore
		 * this loader
		 * parent record
		 * response
		 * e
		 */
		'loadexception'
	);
	L5.tree.TreeDataSet.superclass.constructor.call(this);
	
	this.initDataSet();
}

L5.extend(L5.tree.TreeDataSet, L5.util.Observable,{
	/**
	 * @ignore
	 * 初始化
	 * @param {Object} config
	 */
	initDataSet : function() {
	    this.modified = {};//保存修改记录
	    this.deleted = {};//保存删除的记录
	    this.validated = {};//记录校验失败的record的id
		this.recordHash = {};
		//最先初始化loadermgr,以防用户在treeloader中配置了需要构建的recordtype
		this.loaderMgr = new L5.tree.TreeLoaderMgr(this.loaders);
		delete this.loaders;
		this.initProxyLoader(this.loaderMgr);
		
		var root = this.root;
		if(L5.type(root)=="function"){
			root=root();
		}
		if(root){
			this.setRoot(root);
		}
		if(this.id){
			L5.DatasetMgr.register(this);
		}
	},
	
	/**
	 * @ignore
	 * 初始化proxyLoader
	 * proxyLoader用来屏蔽各个loader的差异,为record提供统一的加载入口
	 * @param {Object} mgr 当前treeloadermgr
	 */
	initProxyLoader : function(loadermgr){
		var proxyloader = this.proxyLoader;
		if(!proxyloader){
			if(this.batchLoad){
				var cfg = {};
				if(this.batchUrl){
					cfg.batchUrl = this.batchUrl;
				}
				if(this.getBatchJsonData){
					cfg.getBatchJsonData = this.getBatchJsonData;
				}
				if(this.isSupportBatchLoad){
					cfg.isSupportBatchLoad = this.isSupportBatchLoad;
				}
				cfg.loaderMgr = loadermgr;
				proxyloader = new L5.tree.BatchTreeLoaderProxy(cfg);
			} else {
				proxyloader = new L5.tree.TreeLoaderProxy({
					loaderMgr : loadermgr
				});
			}
			delete this.batchLoad;
			delete this.batchUrl;
			delete this.getBatchJsonData;
			delete this.isSupportBatchLoad;
		}
		this.setProxyLoader(proxyloader);
	},
	/**
	 * @ignore
	 * 使用proxyLoader去代理treeloader加载数据,屏蔽加载细节
	 * @param {Object} proxyloader
	 */
	setProxyLoader : function(proxyloader){
		var old = this.proxyLoader;
		if(proxyloader == old){
			proxyloader.dataset = this;
		} else {
			this.proxyLoader = proxyloader;
			this.loaderMgr = proxyloader.getLoaderMgr();
			proxyloader.dataset = this;
			if(old){
				old.dataset = false;
			}
		}
	},
	
	/**
	 * 设置根
	 * @param {Object} root
	 */ 
	setRoot : function(root){
		if(!root){
			return;
		}
		var rootrecord = root;
		if(!root.load){//不是treerecord对象,需要创建出treerecord
			rootrecord = L5.tree.TreeRecord.createRecord(root.recordType,root);
		}
		var old = this.root;
		if(rootrecord.equals(old)){
			if(!this.getById(rootrecord.id)){//如果用户第一次初始化传递的就是一个record
				rootrecord.isRoot = true;
				rootrecord.setDataSet(this);
				this.fireEvent('rootchange',false,rootrecord);
			}
			return;
		}
		if(old&&old.load){
			old.isRoot = false;
			old.setDataSet(false);
		}
		this.recordHash = {};
		rootrecord.isRoot = true;
		rootrecord.setDataSet(this);
		this.root = rootrecord;
		this.fireEvent('rootchange',old,rootrecord);
	},
	
	/**
	 * @private
	 * 将record用hash方式缓存起来
	 * 如果存在脏数据,添加到修改记录
	 * @param {Object} record
	 */
	registRecord : function(record){
		if(record.dirty){
        	if(record.state != L5.model.Record.STATE_NEW){
        		record.state = L5.model.Record.STATE_MODIFIED;
        	}
            this.modified[record.id] = record;
		}
		this.recordHash[record.id] = record;
	},
	
	/**
	 * @private
	 * 解除注册,将record从缓存中清除
	 * @param {Object} record
	 */
	unregisterRecord : function(record){
		var id = record.id;
		if (record.dirty) {
			delete this.modified[id];
		}
		delete this.recordHash[id];
	},
	
	/**
	 * 根据节点id获取record
	 * @param {string} id
	 * @param {string} recordType
	 */
	getById : function(id,recordType){
		if(!this.root){
			return false;
		}
		var newid = this.root.wrapId(id,recordType);
		return this.recordHash[newid];
	},
	
	/**
	 * 根据节点的路径获取record
	 * getByPath([0,0,0]);//根-child0-child0-child0
	 * getByPath([3,1,9]);//根-child4-child2-child10
	 * getByPath('0/0/0');
	 * @param {Object} path
	 * @param {string} sep 指明path的分割符号
	 */
	getByPath : function(path,sep){
		var patharray = path;
		if(typeof path =='string'){
			var separator = sep || this.pathSeparator;
			patharray = path.split(separator);
		}
		var rec = this.getRoot();
		for(var i=0,len=patharray.length;i<len;i++){
			var ph = patharray[i];
			rec = rec.getAt(ph);
			if(!rec){
				return ;
			}
		}
		return rec;
	},
	/**
	 * 返回根节点
	 * @return Root 根节点
	 */
	getRoot : function(){
		return this.root;
	},
	
	/**
	 * @ignore
	 * 注册一个事件分发器
	 * 事件分发器是一个L5.util.Observable,或者存在fireEvent方法的对象
	 * 另外需要提供closed属性,当期为false时,说明还可以继续使用,为true时,会清除掉分发器
	 * @param {Object} id
	 * @param {Object} dispacher
	 */
	registDispacher : function(id,dispacher){
		this.eventDispacher[id] = dispacher;
		
	},
	
	/**
	 * @ignore
	 * 移除
	 * @param {Object} dis
	 */
	removeDispacher : function(dis){
		var id = this.getDispacherId(dis);
		this.removeDispacherById(id);
	},
	
	/**
	 * @ignore
	 * 根据id移除
	 * @param {Object} id
	 */
	removeDispacherById : function(id){
		if(id)
			delete this.eventDispacher[id];
	},
	
	/**
	 * @ignore
	 * 获取分发器的id
	 * @param {Object} dispacher
	 */
	getDispacherId : function(dispacher){
		var id = false;
		for(var key in this.eventDispacher){
			var dis = this.eventDispacher[key];
			if(dis == dispacher){
				id = key;
			}
		}
		return id;
	},
	
	getDispacherById : function(id){
		return this.eventDispacher[id];
	},
	
	/**
	 * @ignore
	 * 分发事件
	 */
	dispacherEvent : function(evtName){
		var dels = [];
		for(var key in this.eventDispacher){
			var dis = this.eventDispacher[key];
			if(dis.closed){
				dels.push(key);
				continue;
			}
			dis.fireEvent.apply(dis,arguments);
		}
		for(var i=0,len=dels.length;i<len;i++){
			this.removeDispacherById(dels[i]);
		}
	},
	
	/**
	 * @ignore
	 * 全排序
	 */
	sort : function(sortinfo,intervalkey){
		var record = this.getRoot();
		return record.sort(sortinfo,true,intervalkey);
	},
	
	sortBy : function(func,intervalkey){
		var record = this.getRoot();
		return record.sortBy(func,true,intervalkey);
	},
	
	/**
	 * @ignore
	 * 全局遍历树,回调函数返回false,停止遍历
	 * @param {Object} func
	 * @param {Object} scope
	 */
	each : function(func,scope){
		var rec = this.getRoot();
		var rtn = func.call(scope||this,root);
		if(rtn === true){
			return true;
		}
		return rec.each(func,true,scope);
	},
	
	/**
	 * @ignore
	 * 查询树数据,
	 * 会遍历整棵树查询数据
	 * 返回一个数组,包括全部查询到的数据
	 * @param {Object} property
	 * @param {Object} value
	 * @param {Object} anyMatch 是否模糊匹配
	 * @param {Object} caseSensitive 是否忽略大小写
	 */
	query : function(property, value, anyMatch, caseSensitive){
		var root = this.getRoot();
		var fn = root.createChooseFn(property,value,anyMatch,caseSensitive);
		if(!fn){
			fn = function (rec){
				return true;
			}
		}
		return this.queryBy(fn);
	},
	
	/**
	 * @ignore
	 * 树数据查询,
	 * 会遍历整棵树查询数据
	 * 返回一个数组,包括全部查询到的数据
	 * @param {Object} func 函数,形如function(record){return true;}
	 * 							返回true说明record符合查询条件,会被收集到返回结果中
	 * 							false说明不是我们想要的结果
	 * @param {Object} scope
	 */
	queryBy : function(func, scope){
		var root = this.getRoot();
		var result = root.queryBy(func,true,scope);
		
		var rtn = func.call(scope||this,root);
		if(rtn ===true){
			result = [root].concat(result);
		}
		return result;
	},
	
	/**
	 * @ignore
	 * 查询记录,一找到符合条件的记录就返回
	 * 因此只有可能返回一个record或是什么都没有返回
	 * @param {Object} property
	 * @param {Object} value
	 * @param {Object} anyMatch
	 * @param {Object} caseSensitive
	 */
	find : function(property, value, anyMatch, caseSensitive){
		var root = this.getRoot();
		var fn = root.createChooseFn(property,value,anyMatch,caseSensitive);
		return fn?this.findBy(fn):null;
	},
	
	/**
	 * @ignore
	 * 在根开始查询符合条件的记录,一找到符合条件的记录就返回
	 * @param {Object} func
	 * @param {Object} scope
	 */
	findBy : function(func,scope){
		var root = this.getRoot();
		var rtn = func.call(scope||this,root);
		if(rtn===true){
			return root;
		}

		return root.findBy(func,true,scope);
	},
	
	
	commit : function(){
		for(var key in this.modified){
			var record = this.modified[key];
			record.commit(true);
			record.state = L5.model.Record.NONE;
		}
		this.modified = {};
	},
	
	reject : function(){
		for(var key in this.modified){
			var record = this.modified[key];
			record.reject(true);
			record.state = L5.model.Record.NONE;
		}
		this.modified = {};
	},
	
	/**
	 * @ignore
	 * record如果被编辑了,需要收集修改信息
	 * 还未考虑record.children
	 * @param {Object} record
	 */
	afterEdit : function(record){
		var id = record.id;
		if(this.modified[id]){
        	if(record.state != L5.model.Record.STATE_NEW){
        		record.state = L5.model.Record.STATE_MODIFIED;
        	}
		} else {
	        this.modified[id] = record;
		}
	},
	
	/**
	 * @ignore
	 * 还未考虑record.children
	 * @param {Object} record
	 */
	afterReject : function(record){
		record.state = L5.model.Record.NONE;
		delete this.modified[record.id];
	},
	
	/**
	 * @ignore
	 * 还未考虑record.children
	 * @param {Object} record
	 */
	afterCommit : function(record){
    	record.state = L5.model.Record.NONE;
		delete this.modified[record.id];
	},
	
    destroy : function(){
        if(this.id){
            L5.DatasetMgr.unregister(this);
        }
        this.root = null;
		this.loaderMgr = null;
		this.purgeListeners();
		this.eventDispacher = {};
    },
	
	fireEvent : function(evtName){
		this.dispacherEvent.apply(this,arguments);
		L5.tree.TreeDataSet.superclass.fireEvent.apply(this,arguments);
	},
	
	/**
	 * @ignore
	 * 仅仅是为了兼容form-binding
	 */
	//private
	getCount : function(){
		return 0;
	}
});