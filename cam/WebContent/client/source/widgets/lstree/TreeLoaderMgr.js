/**
 * 用于管理TreeLoader
 * 可以根据id获取加载器
 * 另外,当展开子节点时,需要获取子节点数据加载器,这就需要根据record获取子节点数据加载器
 * 还需要指明加载器是否适用于批量加载
 * 
 * 一颗树可以有多个数据加载器,对于下面的数据
 * 	stru1
 * 		stru2
 * 			stru3
 * 		stru4
 * 			stru5
 * 				user0
 * 			user1
 * 				role1
 * 			user2
 * 				role2
 * 				role3
 * 需要配置三个加载器stru/user/role
 * 对于stru1,使用stru加载器加载数据
 * 对于stru2,需要继续使用stru1的加载器
 * 对于stru4,需要使用stru1的加载器,同时还要使用user加载器
 * 对于user1,需要使用role加载器
 * 这样需要给每个加载器提供一个<strong>触发条件</strong>,指明加载器的使用范围
 * 
 * config形如:
 * [{
 * 		cmd:'org.loushang.demo.tree.StruDataCommand',
 * 		reader:new L5.model.JsonReader({
 *			"root" : "rows",
 *			"totalProperty" : "total",
 *			"successProperty" : "success"
 *		}, Co)
 * 	},{
 * 		trigger:'struType:6',
 * 		url:'test.json',
 * 		baseParams:{
 * 			type:function(record){},
 * 			address:'1'
 * 		}
 * 	},{
 * 		trigger:function(record){},
 * 		url:'res.cmd'
 * 	}]
 * 
 * @array loaders
 */
L5.tree.TreeLoaderMgr = function(config){
	this.loaderIdSort = [];//loader的顺序,加载数据时,排在前面的先加载数据,先解析数据
	this.loaderMap = {};//全体loader的map
	
	var loaders;
	if(L5.isArray(config)){
		loaders = config;
	} else {
		loaders = config.loaders||[];
	}
	for(var i=0,len=loaders.length;i<len;i++){
		var cfg = loaders[i];
		if(!cfg.loadRecords){//如果已经是一个loader
			var loader = this.createLoader(cfg);
			this.regist(loader);
		} else {
			this.regist(cfg);
		}
	}
};
(function (){
var mgr = L5.tree.TreeLoaderMgr.prototype;

/**
 * 根据id获取loader
 * @param {Object} id
 */
mgr.getLoaderById = function(id){
	return this.loaderMap[id];
};

/**
 * 创建TreeLoader
 */
mgr.createLoader = function(config,id){
	var type = config.type||'loader';
	id = id || config.id;
	var lder = L5.tree.TreeLoaderMgr.loaderType[type];
	return new lder(config,id);
};

/**
 * 注册loader
 * @param {Object} loader
 */
mgr.regist = function(loader){
	var id = loader.id;
	this.loaderIdSort.push(id);
	this.loaderMap[id] = loader;
};

/**
 * 	如果以前加载过数据,则使用以前的加载器
 * 	如果没有加载过数据,则解析节点需要的加载器
 * 		如果当前节点的加载器有效
 * 		如果有新的加载器生效
 * 			遍历所有的加载器,判断加载器是否生效,并且与当前节点的加载器不等
 * 	初始化record的加载器信息
 * 返回一个数组，里面包含了加载数据用的loaders
 * @param {Object} record
 */
mgr.getRecordLoaders = function(record){
	var cacheinfo = this.getCacheLoader(record);
	if(cacheinfo){
		return cacheinfo;
	}
	//记录是否需要打包若干个command加载数据
	var fdloader = [];
	var idfdloader = [];
	var idsorts = this.loaderIdSort;
	for(var i=0,len = idsorts.length;i<len;i++){
		var cuId = idsorts[i];
		var curLoad = this.getLoaderById(cuId);
		if(curLoad.trigger(record)){
			fdloader.push(curLoad);
			idfdloader.push(cuId);
		}
	}
	record.setChildLoaders(idfdloader);
	return fdloader;
};

/**
 * 获取record中缓存的加载器信息
 * 如果没有找到，什么也不返回
 * @param {Object} record
 */
mgr.getCacheLoader = function (record){
	var ldindexs = record.getChildLoaders();
	if(ldindexs){
		var indlen = ldindexs.length;
		var fdloader = [];
		for(var i=0;i<indlen;i++){
			fdloader.push(this.getLoaderById(ldindexs[i]));
		}
		return fdloader;
	}
	return false;
};
mgr.getLoaderCount = function(){
	return this.loaderIdSort.length;
}
/**
 * 返回存放loader信息的map,key是loader的id,value是loader
 */
mgr.getLoadersMap = function(){
	return this.loaderMap;
};
})();
L5.tree.TreeLoaderMgr.loaderType = {};
