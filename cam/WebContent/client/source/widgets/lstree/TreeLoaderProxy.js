/**
 * 负责屏蔽treeloader之间的差异，为record提供一个统一的加载入口
 * 一个record可以有多个treeloader,客户端自己使用这些loader加载数据会很麻烦,
 * 因此提供TreeLoaderProxy,代理loader加载数据,屏蔽差异
 * 
 * @cfg treeloadermgr loaderMgr
 * @param {Object} cfg
 */
L5.tree.TreeLoaderProxy = function(cfg){
	this.loaderMgr = false;
	L5.apply(this,cfg);
	
	var loadermap = this.loaderMgr.getLoadersMap();
	for(var key in loadermap){
		var loader = loadermap[key];
		loader.on("beforeload",this.onBeforeload,this);
		loader.on("load",this.onLoad,this);
		loader.on("loadexception",this.onLoadexception,this);
	}
};

L5.tree.TreeLoaderProxy.prototype = {
	/**
	 * 加载节点数据
	 * 1根据record从loadermgr中获取合适的加载器
	 * 2依次执行每一个加载器
	 * 3执行回调函数
	 * @param {Object} record
	 * @param {Object} options
	 * 	{loaderId:''}
	 * @param {Object} callback
	 */
	load : function(record,options,callback){
		var loaders;
		if(options.loaderId){
			var curloader = this.loaderMgr.getLoaderById(options.loaderId);
			loaders = [curloader];
		} else{
			loaders = this.loaderMgr.getRecordLoaders(record);
		}
		var i=0;
		var len=loaders.length;
		var loadercallback = function(){//形成一个链条,在前面的loader执行完毕,才触发后面的loader,这个的执行堆栈可能很长
			if(i>=len){
				callback();//回调TreeRecord类的loadComplete方法，修改this.loading值为false;
				return;
			}
			var curloader = loaders[i];
			i++;
			curloader.load(record,options,loadercallback);
		}
		loadercallback();

//		var loading = false;//这种执行方法可能响应不太好
//		var stoploading = function(){
//			loading = false;
//		}
//		var loaddata = function(){
//			if(loading){
//				var timer;
//				var f = function(){
//					if(!loading){ // done loading
//						clearInterval(timer);
//						loaddata();
//					}
//				};
//				timer = setInterval(f, 250);
//				return;
//			}
//			loading = true;
//			if(i>len){
//				var curloader = loaders[i];
//				i++;
//				curloader.load(record,options,stoploading);
//				loaddata();
//			} else {
//				if(callback){
//					callback();
//				}
//			}
//		}
//		loaddata();
	},
	
	//private
	getLoaderMgr : function(){
		return this.loaderMgr;
	},
	
	//private
	onBeforeload : function(){
		if(this.dataset){
			var arg = ['beforeload'];
			var len = arguments.length;
			for(var i=0;i<len;i++){
				arg.push(arguments[i]);
			}
			return this.dataset.fireEvent.apply(this.dataset,arg);
		}
		return true;
	},
	
	//private
	onLoad : function(){
		if(this.dataset) {
			var arg = ['load'];
			var len = arguments.length;
			for(var i=0;i<len;i++){
				arg.push(arguments[i]);
			}
			return this.dataset.fireEvent.apply(this.dataset,arg);
		}
		return true;
	},
	
	//private
	onLoadexception : function(){
		if(this.dataset){
			var arg = ['loadexception'];
			var len = arguments.length;
			for(var i=0;i<len;i++){
				arg.push(arguments[i]);
			}
			return this.dataset.fireEvent.apply(this.dataset,arg);
			
		}
		return true;
	}
};
