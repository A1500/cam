//doc
/**
 * @ignore
 * 分析过程
 * 作用:
 * 	保存后台获取过来的数据,然后与NodeModel结合用来构造一个TreeNode
 * 	保持数据模型与loushang5的一致
 * 构建过程
 * 	由TreeLoader加载后台数据,由TreeJsonReader解析出一条条记录的原始数据,然后调用TreeRecord的构造方法,传入原始数据
 * 关键功能
 * 	record需要考虑支持分页,TreeLoader加载数据时需要知道当前record已经加载到第几页了
 * 	一个record下可以有若干种record,组织机构record下可以有组织机构record,也可以有用户record
 * 		假设一个节点存在若干种节点,子节点如何保证插入到正确的顺序
 * 		比如后台原来100条记录,当前获取了10条,然后添加一条记录,如何保证与后台的数据一致
 * 	节点的排列
 * 		原来的记录1/2/5/7,新增一条记录,那么新纪录3要添加到2之后
 * 与别的组件的交互影响
 * 	TreeDataset负责管理record,需要保存所有的记录,因此新增/删除等操作需要通知TreeDataset
 * 	record需要提供一个唯一编号用以标志自己,方便用户获取
 * 	TreeLoader负责加载子节点数据,一个record一旦使用了某些TreeLoader之后就不可以使用别的TreeLoader了,
 * 	因此record需要记录TreeLoader
 * 
 * 数据的回滚与提交
 * 	record自身数据的回滚与提交
 * 	record chilren数据的回滚与提交,交给treeDataset来处理
 * 事件冒泡给TreeDataSet处理
 * 
 * loader保存此节点的加载器,一个节点只能有一个加载器
 * 	loader:loaderid1
 * childLoadInfo保存子节点加载器信息,可以有多个子节点加载器
 * 	childLoadInfo:{
 * 		loaders:[id1,id3],
 * 		id1:{
 * 			index:0
 * 		},
 * 		id3:{
 * 			index:1
 * 		}
 * 	}
 * childLoadInfo.loaders被在加载子节点时使用
 * 
 * loaderMaps缓存一些加载器数据信息,当然不一定是缓存加载器信息,我们也可以把它当做一个缓存使用
 * 	loaderMaps{
 * 		id1:{
 * 			total:400,
 * 			curLoadDataSize:20,
 * 			pageSize:10,
 * 			children:{}
 * 			curNum:200,
 * 			index:[0,200],
 * 		}
 * 	}
 * total表明后台总共的数据量
 * curLoadDataSize表明当前从后台加载的数据,只有加载过数据后此属性才存在
 * curNum表明当前所有的数据量,包括用户手动添加的数据
 * pageSize表明一页数据量
 * index表明了此loader的数据在record.children中的分布情况,从第一个到第201都是此loader加载的数据
 * children用于存放被加载还未解析的json数据,此属性被L5.tree.L5TreeLoader使用,用于缓存后台多传送的数据
 * @param {Object} data
 * @param {Object} id
 */
/**
 * @class L5.tree.TreeRecord
 * @extends L5.tree.BaseRecord
 * @param {Object} data
 * @param {Object} id
 */
L5.tree.TreeRecord = function(data,id){
	this.initRecord(); 
	L5.tree.TreeRecord.superclass.constructor.apply(this,arguments);
}

L5.extend(L5.tree.TreeRecord, L5.tree.BaseRecord,{
	/**
	 * @ignore
	 * 初始化
	 */
	initRecord : function(){
		this.loading = false;//true表示正在加载数据
		this.loader = false;//当前节点的加载器,表明节点由此加载器加载而来
		this.childLoadInfo = {loaders:false};//存放当前节点的子节点加载器信息
		this.loaderMaps = {};
		this.lastParam = {};//存放上次加载时的参数
		
	},
	
	/**
	 * @ignore 
	 * 预加载数据
	 */
	doPreload : function(){
		var chdata = this.data.children;
		delete this.data.children;
		if(!chdata){
			return false;
		}
		if(chdata.rows){
			chdata = chdata.rows;
		}
		var len = chdata.length;
		if(len==0){
			return true;
		}
		var ch = [];
		for(var i=0;i<len;i++){
			ch.push(L5.tree.TreeRecord.createRecord(this.recordType,chdata[i]));
		}
		this.insert(ch,ch[0].recordType);//预先加载的数据统一都已recordType作为其区间id
		return true;
	},
	
	/**
	 * 加载子节点数据
	 * @param {Object} options 加载的参数
	 * 	function callback 回调函数,加载完毕后回调
	 * 	boolean queryall 分页情况下使用,用于加载剩余数据
	 * 	string loaderId 可以单独指定加载器
	 * 	object params 加载参数
	 * 		{
	 * 			userId : '1111',
	 * 			userName : function(record){return ""}
	 * 		}
	 */
	load : function(options){
		if(this.loading){
            var timer;
            var f = function(){
                if(!this.loading){ // done loading
                    clearInterval(timer);
                    this.load(options);
                }
            }.createDelegate(this);
            timer = setInterval(f, 200);
            return;
		}
		this.loading = true;//一开始就设置为true
		options = options || {};
		var loadComplete = this.loadComplete.createDelegate(this,[options]);
		if(this.doPreload()){
			loadComplete();
			return;
		}
		var dataset = this.getDataSet();
		dataset.proxyLoader.load(this,options,loadComplete);
	},
	
	/**
	 * @ignore 
	 * 加载完成后需要清除状态位
	 * @param {Object} o
	 */
	loadComplete : function(o){
		this.loading = false;
		this.lastParam = o.params || {};
		var callback = o.callback;
		if(callback){
			callback();
		}
	},
	
	/**
	 * 加载节点的全部数据,同时会级联触发所有子节点的数据加载,直到树的末级
	 * @param {Object} options 配置参数参看load函数
	 */
	loadCascaded : function(options){
		options = options || {};
		var loadstack = [];
		loadstack.push(this);
//		加载子节点:1弹出节点,2将子节点压栈,3加载节点
		var loadChildren = function(){
			var rec = loadstack.pop();
			var count = rec.getCount();
			for(var i=count-1;i>=0;i--){
				loadstack.push(rec.getAt(i));
			}
			brotherload();
		}
		var oldcallback = options.callback;
		options.callback = loadChildren;
		var loadComplete = this.loadComplete.createDelegate(this,[options]);
//		从栈中取出数据,然后加载数据
		var brotherload = function(){
			var len = loadstack.length;
			if(len>0){
				var rec = loadstack[len-1];
				rec.load(options);
			} else {
				options.callback = oldcallback;//恢复原有的callback
				loadComplete();//回调
				
			}
		}
		brotherload();
	},
	
	/**
	 * 重新节点加载数据
	 * 可以重新加载一页或全部数据
	 * options参数配置参看load方法
	 */
	reload : function(options,cascaded){
		options = options || {};
		this.lastParam = options.params || {};
		this.removeAll();
		this.clearLoaderMap();
		if(!cascaded){
			this.load(options);
		} else {
			this.loadCascaded(options);
		}
	},
	
	/**
	 * @ignore 
	 * 获取当前节点子节点加载器信息
	 */
	getChildLoaders : function(){
		return this.childLoadInfo.loaders;
		
	},
	
	//private
	setChildLoaders : function(loaders){//['','','']
		if(loaders){
			this.childLoadInfo = {};
			this.childLoadInfo.loaders = loaders;
			var len = loaders.length;
			for(var i=0;i<len;i++){
				var curid = loaders[i];
				this.childLoadInfo[curid] = {
					index : i
				};
				this.createLoaderMap(curid);
			}
		}
	},
	
	/**
	 * @ignore
	 * 节点可能使用了多个加载器,可以获取到某个加载器是第几个加载数据的
	 * @param {Object} loaderid
	 */
	getChildLoaderOrder : function(loaderid){
		if(this.childLoadInfo[loaderid]){
			return this.childLoadInfo[loaderid].index;
		}
		return -1;
	},
	
	clearChildLoaders : function(){
		delete this.isNeedSyn;
		
		var loaders = this.getChildLoaders();
		if(!loaders){
			return;
		}
		this.childLoadInfo = {loaders:false};
		this.clearLoaderMap();
	},
	
	createLoaderMap : function (loaderid){
		if(!this.loaderMaps[loaderid]){
			this.loaderMaps[loaderid] = {};
		}
		return this.loaderMaps[loaderid];
	},
	
	getLoaderMap : function(loaderid){
		return this.loaderMaps[loaderid];
	},
	
	removeLoaderMap : function(loaderid){
		var old = this.loaderMaps[loaderid];
		delete this.loaderMaps[loaderid];
		return old;
	},
	
	clearLoaderMap : function(){
		this.loaderMaps = {};
	},
	
	setLoaderProperty : function(loaderid,key,value){
		var ladermap = this.loaderMaps[loaderid];
		if(!ladermap){
			ladermap = this.loaderMaps[loaderid] = {};
		}
		var old = ladermap[key];
		ladermap[key] = value;
		return old;
	},
	
	/**
	 * @ignore 
	 *  获取不到对应的值时返回false
	 * @param {Object} loaderid
	 * @param {Object} key
	 */
	getLoaderProperty : function(loaderid,key){
		var ladermap = this.loaderMaps[loaderid];
		if(!ladermap){
			return false;
		}
		var val = ladermap[key];
		if(typeof(val)=="undefined"){
			return false;
		}
		return val;
	},
	
	/**
	 * @ignore 
	 * 不存在loaderid的缓存数据时返回false
	 * @param {Object} loaderid
	 * @param {Object} key
	 */
	removeLoaderProperty : function(loaderid,key){
		var ladermap = this.loaderMaps[loaderid];
		if(!ladermap){
			return false;
		}
		var val = ladermap[key];
		delete ladermap[key];
		return val;
	},
	
	/**
	 * @ignore 
	 * 判断节点是否需要加载数据
	 * 返回true说明还需要加载,返回false说明不需要
	 */
	hasSynData : function(){
		if(typeof this.isNeedSyn != "undefined"){
			return this.isNeedSyn;
		}
		if(this.data.children){
			return true;
		}
		var ds = this.getDataSet();
		if(ds){
			var loaders = this.getChildLoaders();
			var loaderlength = ds.loaderMgr.getLoaderCount();
			if(!loaders&&loaderlength!=0){//没有加载过数据
				return true;
			} else {
				var mgr = ds.loaderMgr;
				for(var i=0,len=loaders.length;i<len;i++){
					var loadid = loaders[i];
					var load = mgr.getLoaderById(loadid);
					if(load.isNeedSyn(this)){
						return true;
					}
				}
			}
		}
		this.isNeedSyn = false;
		return false;
	},
	/**
	 * 判断节点是否是叶子节点
	 * true表示是叶子节点，false表示是非叶子节点
	 */
	isLeaf : function(){
		var hasdata = this.hasSynData();
		if(hasdata){
			return false;
		}
		if(this.getCount()==0){
			return true;
		}
		return false;
	}
});
L5.tree.TreeRecord.recordTypes = {};
/**
 * 创建TreeRecord
 * @param {Object} meta {idField:'',name:'',fields:[{name:'',mapping:''},{}]}
 */
L5.tree.TreeRecord.create = function(meta){
	var recordtype = meta.name;
	var id = meta.idField;
	var o = meta.fields || [];
	
	var f = L5.extend(L5.tree.TreeRecord, {});
	var p = f.prototype;
	p.fields = new L5.util.MixedCollection(false, function(field){
		return field.name;
	});
	for(var i = 0, len = o.length; i < len; i++){
		p.fields.add(new L5.model.Field(o[i]));
	}
	f.getField = function(name){
		return p.fields.get(name);
	};
	f.prototype.recordType = recordtype||"";
	f.recordType = f.prototype.recordType;
	f.getType = f.prototype.getType = function(){
		return f.recordType;
	};
	f.idField = f.prototype.idField = id;
	f.getIdField = f.prototype.getIdField = function(){
		return id;
	}
	//注册
	L5.tree.TreeRecord.recordTypes[recordtype] = f;
	return f;
};
/**
 * 创建TreeRecord
 * @param {Object} o json对象
 * 形如:
 * {
 * 	recordType : 'stru',
 * 	struId : 's001',
 *  struName : '集团',
 *  sortOrder : 1,
 *  children : [{
 *  	struId : '',
 *  	struName : '',
 *  	children : [{recordType : 'role'}]
 *  },{
 *  	struId : '',
 *  	struName : ''
 *  }]
 * }
 */
L5.tree.TreeRecord.createRecord = function(recordType,o){
	if(o.recordType){//如果有更具体的配置则使用更贴切的配置
		recordType = o.recordType;
		delete o.recordType;
	}
	recordType = recordType || L5.tree.SimpleTreeRecord;
	if(typeof recordType == 'string'){
		recordType = L5.tree.TreeRecord.recordTypes[recordType];
	}
	var primarykey = recordType.idField;
	var record = new recordType(o,o[primarykey]);
	return record;
};

L5.tree.SimpleTreeRecord = L5.tree.TreeRecord.create({
	idField: 'id',
	name: 'L5_tree_SimpleTreeRecord',
	fields: [{
		name: 'id'
	}, {
		name: 'text'
	}, {
		name: 'leaf',
		type: 'boolean'
	}, {
		name: 'expanded',
		type: 'boolean'
	}, {
		name: 'allowDrag',
		type: 'boolean'
	}, {
		name: 'allowDrop',
		type: 'boolean'
	}, {
		name: 'disabled',
		type: 'boolean'
	}, {
		name: 'icon'
	}, {
		name: 'cls'
	}, {
		name: 'iconCls'
	}, {
		name: 'href'
	}, {
		name: 'hrefTarget'
	}, {
		name: 'qtip'
	}, {
		name: 'expandable',
		type: 'boolean'
	}, {
		name: 'qtipCfg'
	}, {
		name: 'singleClickExpand',
		type: 'boolean',
		defaultValue: true
	}, {
		name: 'uiProvider'
	}, {
		name: 'checked',
		defaultValue: undefined
	}, {
		name: 'draggable',
		type: 'boolean'
	}, {
		name: 'isTarget',
		type: 'boolean'
	}, {
		name: 'allowChildren',
		type: 'boolean'
	}, {
		name: 'showType',
		defaultValue: 'text'
	}, {
		name: 'cascadeChecked',
		defaultValue: true
	}]
});
