/**
 * 树形record使用区间来管理存放的子节点
 * 比如,如下结构的树
 * stru
 * 	stru
 * 	user
 * 对于一个strurecord,如果其有10个节点,0到6存放的是stru,7到9存放的是user
 * 我们可以按照stru与user建立两个区间存放子节点
 * {id:'stru',interval:[0,6]}
 * {id:'user',interval:[7,9]}
 * 注意:当我们移除、增加子节点时需要刷新区间信息
 * 
 * 注意:为了降低性能消耗,请自行保证各个区间标志的子节点位置不交叉,并且有序排列
 */
L5.tree.IntervalCollection = function(){
	this.intervals = new L5.util.MixedCollection(false,function(o){
		return o["id"];
	});//子节点的存放信息,比如user数据存放在11条到33条记录之间
	//存放的对象形如{id:'user',interval:[11,33]}
};
L5.tree.IntervalCollection.prototype = {
	/**
	 * 在指定位置添加一个区间
	 * 如果当前存在三个区间,可以指定在第二个区间之前添加一个新区间
	 * 返回创建位置 如果没有创建,返回-1
	 * @param {Object} index
	 * @param {Object} interval {id : '',interval : [0,1]}
	 */
	create :  function(index,key){
		if(arguments.length==1){
			key = index;
			index = this.getCount();
		}
		if(this.intervals.containsKey(key)){
			return -1;
		}
		var obj = {
			id:key,
			interval : [0,-1]
		};
		this.intervals.insert(index,obj);
		return index;
	},
	
	/**
	 * 删除区间
	 * @param {Object} key
	 */
	remove : function(key){
		var index = this.indexOf(key);
		this.removeAt(index);
	},
	
	/**
	 * 删除index指定的区间,
	 * 如果record有10个区间,我们可以整体删除第二个区间
	 * 同时要前移后面区间的节点起始-总结值
	 * @param {Object} index
	 */
	removeAt : function(index){
		var interval = this.intervals.removeAt(index);
		if(!interval){
			return;
		}
		var start = interval.interval[0];
		var end = interval.interval[1];
		if(start>end){//说明当前区间并没有存放节点,不影响后面的区间
			return;
		}
		var size = end - start + 1;//移调了size大小的子节点
		this.forwardChild(index,size);
	},
	
	/**
	 * 获取一个存放区间
	 * {id : '',interval : [0,1]}
	 * @param {Object} key
	 */
	get : function(key){
		return this.intervals.key(key);
	},
	
	contains : function(key){
		return this.intervals.containsKey(key);
	},
	
	getCount : function(){
		return this.intervals.getCount();
	},
	
	indexOf : function(key){
		return this.intervals.indexOfKey(key);
	},
	
	/**
	 * 获取所有区间的key值,按照区间的顺序返回
	 * ['stru','user']
	 */
	getKeys : function(){
		return this.intervals.keys;
	},
	
	/**
	 * 根据区间位置获取一个区间
	 * 返回 {id : '',interval : [3,10]}
	 */
	getAt : function(index){
		return this.intervals.itemAt(index);
	},
	
	/**
	 * 在指定的位置,创建一个区间
	 * 比如,当前存在两个区间,[0,57] [58,100],我们可以在0-57位置前面插入一个新区间
	 * 返回创建位置
	 * @param {Object} postion
	 * @param {Object} key
	 */
	createByPostion : function(postion,key){
		if(this.intervals.containsKey(key)){
			return;
		}
		var preinter = this.indexOfByPostion(postion);
		if(preinter==-1){
			preinter = this.getCount();
		}
		var obj = {
			id:key,
			interval : [0,-1]
		};
		this.intervals.insert(preinter,obj);
		return preinter;
	},
	
	/**
	 * 根据一个位置获取区间
	 * 
	 * 比如,当前存在两个区间,[0,57] [58,100],此方法用来获取59位于哪个区间
	 * @param {Object} postion
	 */
	getByPostion : function(postion){
		var index = this.indexOfByPostion(postion);
		if(index == -1){
			return false;
		}
		return this.getAt(index);
	},
	
	/**
	 * 根据节点位置获取一个区间,如果没有找到,返回-1
	 * @param {Object} rec
	 */
	indexOfByPostion : function(postion){
		var len = this.getCount();
		if(len==0){
			return -1;
		}
		if(postion<0){
			return -1;
		}
		var start = 0;
		for(var i=0;i<len;i++){
			var curin = this.getAt(i);
			var start = curin.interval[0];
			var end = curin.interval[1];
			if(start>end){
				continue;
			}
			if(postion>=start&&postion<=end){
				return i;
			}
		}
		return -1;
	},
	
	/**
	 * 刷新区间信息
	 * 保证start与原有的start一致,自行保证区间的前端与前一个区间的末尾不交叉
	 * @param {Object} key
	 * @param {Object} start
	 * @param {Object} end
	 */
	refresh : function(key,start,end){
		var index = this.indexOf(key);
		if(index==-1){
			return;
		}
		this.refreshByIndex(index,start,end);
	},
	
	refreshByIndex : function(index,start,end){
		var cur = this.getAt(index);
		var oldstart = cur.interval[0];
		var oldend = cur.interval[1];
		
		cur.interval[0] = start;
		cur.interval[1] = end;
		/**
		 * 如果以前存在数据
		 * 	可能移除了子节点
		 * 	可能增加了子节点
		 * 如果以前没有数据
		 * 	按照增加处理
		 */
		if(oldstart>oldend){//没有数据
			if(start>end){//还是没有数据
				return ;
			} else {//增加处理
				var len = end - start + 1;
				this.backChild(index+1,len);
			}
		} else {//存在数据
			if(start>end){//数据删除光了
				var len = oldend - oldstart + 1;
				this.forwardChild(index+1,len);
			} else {//start == oldstart 必然成立
				if(oldend>end){//删除了数据
					var len = oldend - end;
					this.forwardChild(index+1,len);
				} else {//添加了数据
					var len = end - oldend;
					this.backChild(index+1,len);
				}
			}
		}
	},
	
	/**
	 * 往数组的0下标移动叫做前移
	 * 往数组的后面移动叫做后退
	 * 往前移动从index往后的区间中子节点的位置信息
	 */
	//private
	forwardChild : function(index,size){
		if(size==0){
			return;
		}
		var len = this.getCount();
		for(var i=index;i<len;i++){
			var cur = this.getAt(i);
			var curstart = cur.interval[0];
			var curend = cur.interval[1];
			if(curstart>curend){
				continue;
			}
			cur.interval[0]-=size;//全部前移size位置
			cur.interval[1]-=size;
		}
	},
	
	/**
	 * 往数组的0下标移动叫做前移
	 * 往数组的后面移动叫做后退
	 * 往后移动从index往后的区间中子节点的位置信息
	 * @param {Object} index
	 * @param {Object} size
	 */
	//private
	backChild : function(index,size){
		if(size==0){
			return;
		}
		var len = this.getCount();
		for(var i=index;i<len;i++){
			var cur = this.getAt(i);
			var curstart = cur.interval[0];
			var curend = cur.interval[1];
			if(curstart>curend){
				continue;
			}
			cur.interval[0]+=size;//全部前移size位置
			cur.interval[1]+=size;
		}
	},
	
	/**
	 * 获取某个区间前面存在数据的第一个区间
	 * 返回一个序号
	 * @param {Object} index
	 */
	validBefore : function(index){
		for(var i=index-1;i>=0;i--){
			var interval = this.getAt(i);
			var curstart = interval.interval[0];
			var curend = interval.interval[1];
			if(curstart<=curend){
				return i;
			}
		}
		return -1;
	},
	
	clear : function(){
		this.intervals.clear();
	}
}