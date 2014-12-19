//doc
/**
 * @ignore
 * L5.tree.BaseRecord实现了基本的树形record,不包含异步加载数据功能
 * 
 * 树的record与grid的record最大的不同是其存在子节点,子节点可能来自于user,
 * 也可能来自于department,很多种类型的子节点,由于存在多个类型的子节点的关系,
 * 子节点record的添加如何实现需要仔细考虑
 * 考虑下面的结构,
 * 1stru
 * 		stru
 *  	user
 * 再考虑如下的结构
 * 2stru
 * 		stru(corp)
 * 		stru(department)
 * 		stru(employee)
 * 		stru(employee)
 * 		user
 * 还有如下的结构
 * 3stru
 * 		rec1
 * 		stru
 * 		rec2
 * 		stru
 * 		rec3
 * 第三种结构可以转换为第二种结构,将rec1/rec2各视作一种类型,因此排除
 * 第一种结构实现简单,现成的分割标志,我们根据recordtype划分子节点,所有相同recordtype的节点再插入时都存放到一个区域
 * 	另外与业务贴近的比较紧密,用户记住一个recordtype
 * 第二种结构需要另外一种分割办法,好比如果是由treeloader加载而来,可以按照loaderid处理,所有相同loaderid的放到一个区域
 * 	这种方法灵活,什么样的情况都能应付
 * 可以这样,如果用户配置的treeloader加载的recordtype不一致,则按照recordtype划分,如果有treeloader加载了
 * 同样的recordtype,则按照loaderid添加
 * 另外一种方法是给treeloader添加一个配置项,作为record中子节点区域的key
 * 
 * 为了管理各种不同的节点,我们提供区间划分功能,每个区间,存放一种子节点
 * 
 * 树的record存在一个dataset,此dataset不具备加载数据的能力,子节点数据的加载应当由record决定
 * 树的record最好不要手动设置treeDataset,系统自动处理treeDataset比较好,否则可能扰乱树的整体结构
 * 一个节点只能属于一个dataset,不允许record在两个dataset之间共享
 * 
 * BaseRecord的状态变迁:
 * 	新建(new):
 * 		此时此记录还没有纳入treedataset的管理,对此record的任何修改都不记录用于回滚
 * 	修改记录 update
 * 		如果一个节点纳入treeDataset管理,则对其的任何修改,都需要记录下来用于回滚
 * 		如果没有纳入treeDataset管理,则不对其进行任何处理
 *  删除 delete 不记录回滚信息
 *  增加 insert 不记录回滚信息
 * 使用了L5.model.Record中的一些状态标志和id序列号
 * @param {Object} data
 * @param {Object} id
 */
/**
 * @class L5.tree.BaseRecord
 * @param {Object} data
 * @param {Object} id
 */
L5.tree.BaseRecord = function(data, id){
    this.srcid = (id || id === 0) ? id : ++L5.model.Record.AUTO_ID;
	this.id = this.wrapId(this.srcid,this.recordType);//添加上类型前缀
    this.data = data;
    this.state = L5.model.Record.NONE;
    //处理默认值
    if (this.data == null)
		this.data = {};
	for (var i = 0; i < this.fields.items.length; i++) {
		var item = this.fields.items[i];
		if (this.data[item.name]!=undefined)
			continue;
		var dv = item.defaultValue;
		if (dv!=undefined){
			var val = item.convert(dv);
			this.data[item.name] = val;
		}
	}
	this.validate={};
	this.msg = {};
	this.msgIndex = {};
	this.msgLable = {};
	this.msgTitle = {};
	this.dirty = false;
	this.editing = false;
	this.error = null;
	
	this.parentRecord = false;
	this.dataset = false;
	this.children = new L5.util.MixedCollection(false,function(o){
		return o["id"];
	});
	this.interval = new L5.tree.IntervalCollection();//按照本来的设想,应该是BaseRecord继承IntervalCollection
													//后台发现,如果这样处理,IntervalCollection中的有些方法名称就太长了
													//有点忍受不了,于是改成属性形式
};

L5.tree.BaseRecord.prototype = {
	/**
	 * @ignore
	 * parent record
	 * insert records
	 * index
	 * insertnums 如果存在id相同的reocrd,并不重复插入,因此,实际插入的record数量可能小于待插入的record数量
	 * add event
	 */
	/**
	 * @ignore
	 * parent record
	 * remove records
	 * length
	 * remove event
	 */
	/**
	 * @ignore
	 * parent record
	 * sort records 需要排序的记录
	 * index
	 * beforeSort event
	 */
	/**
	 * @ignore
	 * parent record
	 * sort records 排序完毕的记录
	 * index
	 * sort event
	 */
	/**
	 * @ignore
	 * record
	 * modify 修改信息 {struId:'test',name:'abcx'}
	 * status L5.model.Record.COMMIT等等
	 * update event
	 */
    set : function(name, value){
    	var result = true;
    	//20100324修改:注释掉if语句部分
    	//(不判断修改的值与原值是否相等，都重新赋值一次.解决tree与form绑定时，修改值却无法触发update事件的问题.)
//        if(String(this.data[name]) == String(value)){
//        	for(var i=0;i<this.fields.items.length;i++){
//        		if(this.fields.items[i].rule!=null){
//        			return L5.Validator.validate(this, name, value);
//        		}
//        	}
//        	return result;
//        } else {
	        value=this.fields.get(name).convert(value);//convert value because of formbinding
	        //如果没有纳入treeDataset管理,不收集修改信息,直接返回
			//如果纳入管理,需要收集修改信息
	        if(!this.getDataSet()){
				this.data[name] = value;
				return result;
			}
			//如果存在之前的修改信息,则刷新修改信息
	        this.dirty = true;
	        if(!this.modified){
	            this.modified = {};
	        }
	        if(typeof this.modified[name] == 'undefined'){
	            this.modified[name] = this.data[name];
	        }
	        this.data[name] = value;
	        if(!this.editing){//如果record没有进入编辑状态,每一次的修改都需要收集修改信息
	        				//如果record处于编辑状态,用户可以一次性修改很多,然后统一进行信息收集
							//目前的想法是treeDataset提供很多事件监听,但是都不由自己触发,而是由record或者dataset触发
							//这样应该可以很好的区分开用户的操作与系统的操作,后面在细说吧
	            this.getDataSet().afterEdit(this);
	        }
			var modf = {};
			modf[name] = value;
			this.fireEvent('update',this,modf,L5.model.Record.EDIT);
//        }
        
        for(var i=0;i<this.fields.items.length;i++){
    		if(this.fields.items[i].rule!=null){
    			result = L5.Validator.validate(this, name, value);
    			break;
    		}
    	}
        
        return result;
    },

    get : function(name){
        return this.data[name];
    },
	
	/**
	 * @ignore
	 * 根据索引获取record,索引标志了子节点在record.children中的位置
	 * @param {Object} index
	 */
	getAt : function(index){
		return this.children.itemAt(index);
	},
	
	getById : function(id,recordType){
		var curid = this.wrapId(id,recordType);
		return this.children.item(curid);
	},
	
	getRange : function(start,end){
		return this.children.getRange(start,end);
	},
	
	indexOf : function(record){
		return this.children.indexOf(record);
	},
	
	/**
	 * @ignore
	 * 传递了recordType,则会重新计算id
	 * 不传递id,则直接使用id查询
	 * @param {Object} id
	 * @param {Object} recordType
	 */
	containsById : function(id,recordType){
		var curid = this.wrapId(id,recordType);
		return this.children.containsKey(curid);
	},
	
	indexOfId : function(id,recordType){
		var rec = this.getById(id,recordType);
		return this.indexOf(rec);
	},
	
	//private
	wrapId : function(id,recordType){
		return recordType?(recordType + "_"+id):id ;
	},
	
	getParent : function(){
		return this['parentRecord'];
	},
	
	/**
	 * @ignore
	 * 返回到指定父节点的深度,
	 * 如果没有指定parent,则计算到根的深度,不存在根,返回-1
	 * @param {Object} parent
	 */
	getDepth : function(parent){
		if(!parent){
			var ds = this.getDataSet();
			if(ds){
				parent = ds.getRoot();
			}
			if(!parent){
				return -1;
			}
		}
		var i=0;
		var cur = this;
		while(cur){
			if(cur==parent){
				return i;
			}
			i++;
			cur = cur.parentRecord;
		}
		return -1;
	},
	
	/**
	 * @ignore
	 * 遍历子节点
	 * 深度优先
	 * @param {Object} func
	 * @param {Object} cascade
	 * @param {Object} scope
	 */
	each : function(func,cascade,scope){
		cascade = cascade || false;
		if(cascade){
			return this.eachInner(func,scope);
		} else {
			var count = this.getCount();
			for(var i=0;i<count;i++){
				var chrec = this.getAt(i);
				if(func.call(scope||chrec,chrec) === true){
					return true;
				}
			}
		}
		return false;
	},
	
	//private 遍历节点子节点
	eachInner : function(func,scope){
		var count = this.getCount();
		for(var i=0;i<count;i++){
			var chrec = this.getAt(i);
			if(func.call(scope||chrec,chrec) === true || chrec.eachInner(func,scope)===true){
				return true;
			}
		}
		return false;
	},
	
	/**
	 * @ignore
	 * 查询子节点数据,返回一个数组
	 * 不对当前指定的record进行判断
	 * @param {Object} property
	 * @param {Object} value
	 * @param {Object} cascade
	 * @param {Object} anyMatch
	 * @param {Object} caseSensitive
	 */
	query : function(property,value,cascade,anyMatch,caseSensitive){
		var fn = this.createChooseFn(property, value, anyMatch, caseSensitive);
		if(!fn){
			fn = function (rec){
				return true;
			}
		}
		return this.queryBy(fn,cascade);
	},
	
	/**
	 * @ignore
	 * 遍历整棵树,中途不会停止
	 * func形如function (rec) {return true},如果返回true,rec被选中,其他返回值都会忽略
	 * @param {Object} func
	 * @param {Object} cascade
	 * @param {Object} scope
	 */
	queryBy : function(func,cascade,scope){
		//这种处理方式也不知道会不会有性能问题
		var result = [];
		var queryfunc = function(rec){//使用包装函数
			if(func.call(scope||rec,rec)===true){
				result.push(rec);
			}
			return false;
		}
		this.each(queryfunc,cascade,scope);
		return result;
	},
	
	/**
	 * @ignore
	 * 查询一条记录
	 * 在指定的位置开始查询符合条件的记录,一找到符合条件的记录就返回
	 * 请注意,不查询ch2这个节点,只查询其子节点,不查询其兄弟节点
	 * @param {Object} property
	 * @param {Object} value
	 * @param {Object} cascade
	 * @param {Object} anyMatch
	 * @param {Object} caseSensitive
	 */
	find : function(property, value, cascade,anyMatch,caseSensitive){
		var fn = this.createChooseFn(property, value, anyMatch, caseSensitive);
		return fn?this.findBy(fn,cascade):null;
	},
	
	/**
	 * @ignore
	 * 查询一条记录
	 * @param {Object} func
	 * @param {Object} cascade
	 * @param {Object} scope
	 */
	findBy : function(func,cascade,scope){
		var result = [];
		var queryfunc = function(record){
			if(func.call(scope||record,record)===true){
				result.push(record);
				return true;
			}
			return false;
		};

		if(this.each(queryfunc,cascade,scope)){
			return result[0];
		}
		return null;
	},
	
	/**
	 * @ignore
	 * 对当前节点已经存在的子节点进行排序,
	 * 切记,排序不会引起数据的加载,如果想全部数据排序,可以使用load方法加载剩余的数据后再排序
	 * 
	 * 服务器端排序,可能会引起树形节点大规模的调整,故不予考虑
	 * 用户可以移除所有的子节点,然后重新加载数据,加载时添加一些参数,这样可以服务器端排序
	 * 
	 * 用户也可以手动调用load方法加载全部的节点数据而后进行排序
	 * 广度优先,先派当前节点,然后一次排序各个子节点
	 * 不能回滚
	 * 再次加载数据时并不会重新排序
	 * 如果不指定intervalkey,则将第一个子节点的recordtype作为intervalkey
	 * @param {Object} sortinfo {field:'',direction:'ASC'}
	 * @param {Object} cascade
	 * @param {Object} interval
	 */
	sort : function(sortinfo,cascade,intervalkey){
		var fdname = sortinfo["field"];
		var direc = sortinfo["direction"] || 'ASC';
		cascade = cascade || false;
		var dsc = String(direc).toUpperCase() == "DESC" ? -1 : 1;
		if(this.children.getCount()==0){
			return;
		}
		
		var start;
		if(intervalkey){
			var interval = this.interval.get(intervalkey);
			if(!interval){//不存在数据
				return ;
			}
			start = interval.interval[0];
		} else {
			start = 0;
		}

		var chrec = this.getAt(start);
		var field = chrec.fields.get(fdname);
		if(!field){//不存在节点,返回
			return false;
		}
		var st = field.sortType;
		var wrapfn = function(r1, r2){
			var v1 = st(r1.data[fdname]), v2 = st(r2.data[fdname]);
            var v = (v1 > v2 ? 1 : (v1 < v2 ? -1 : 0)) * dsc;
            if(v == 0){
                v = -1;
            }
            return v;
        };
		intervalkey = intervalkey || chrec.recordType;
		this.sortInfo = {base:sortinfo,valueConvert:st,direct:dsc};
		if(intervalkey){
			this.sortInfo.intervalkey = intervalkey;
		}
		return this.sortBy(wrapfn,cascade,intervalkey);
	},
	
	/**
	 * @ignore
	 * func返回-1,1两种值指明记录的大于小于比较,大于的排在数组后面,小于的排在前面
	 * @param {Object} func
	 * @param {Object} cascade
	 * @param {Object} loaderid
	 */
	//private
	sortBy : function(func,cascade,intervalkey){
		var start;
		var end;
		var interval = this.interval.get(intervalkey);
		if(!interval){
			start = 0 ;
			end = this.children.getCount() - 1;
		} else {
			start = interval.interval[0];
			end = interval.interval[1];
		}
		if(start>end){
			return;
		}
		var startrec = this.getAt(start);
		intervalkey = intervalkey || startrec.recordType;
		if(start == end){
			if(cascade){
				startrec.sortBy(func,cascade,intervalkey);
			}
			return false;
		}
		var recarr = this.getRange(start,end);
		this.fireEvent('beforeSort',this,recarr,start);
		recarr.sort(func);
		for(var i=start,j=0;i<=end;i++){
			var rec = recarr[j];
			this.children.items[i]=rec;
			j++;
		}
		this.fireEvent('sort',this,recarr,start);
		if(cascade){
			for(var i=start;i<=end;i++){
				var rec = this.getAt(i);
				rec.sortBy(func,cascade,intervalkey);
			}
		}
		return true;
	},
	
	/**
	 * @ignore
	 * 获取排序信息
	 */
	getSortState : function(){
		return this.sortInfo?this.sortInfo.base:null;
	},
	
	/**
	 * @ignore
	 * 给区间中寻找一个合适的位置,用于插入节点,同时保证排序不错乱
	 * @param {Object} rec
	 * @param {Number} interindex
	 */
	//private
	getIndexBySortInfo : function(rec,interindex){
		var sortinfo = this.sortInfo;
		var base = sortinfo.base;
		var fdname = base.field;
		var direct = sortinfo.direct;
		var st = sortinfo.valueConvert;
		
		var interval = this.interval.getAt(interindex);
		var start = interval.interval[0];
		var end = interval.interval[1];
		if(start>end){//不存在节点数据
			var preindex = this.interval.validBefore(interindex);
			if(preindex==-1){
				return 0;
			}
			return preindex.interval[1]+1;
		}
		var v1 = st(rec.data[fdname]);
		var mid;
		while(start<=end){
			mid = parseInt((start + end)/2);
			var midrec = this.getAt(mid);
			var v2 = st(midrec.data[fdname]);
			var v = (v1 > v2 ? 1 : (v1 < v2 ? -1 : 0)) * direct;
			if(v == 1){
				start = mid+1;
			} else if(v==0){
				return mid+1;
			} else {
				end = mid-1;
			}
		}
		if(start>mid){
			return start;
		} else{
			return mid;
		}
	},
	
	/**
	 * @ignore
	 * 获取一个区间的子节点
	 * @param {Object} interkey
	 */
	getChildren : function(interkey){
		if(interkey){
			var iter = this.interval.get(interkey);
			if(iter){
				var start = iter.interval[0];
				var end = iter.interval[1];
				if(start<=end){//存在数据
					return this.getRange(start,end);
				} else {//不存在数据
					return [];
				}
			}
		}
		return this.children.items;
	},
	
	/**
	 * @ignore
	 * 获取一个区间的节点个数
	 * @param {Object} interkey
	 */
	getCount : function(interkey){
		if(interkey){
			var iter = this.interval.get(interkey);
			if(iter){
				var start = iter.interval[0];
				var end = iter.interval[1];
				if(start<=end){//存在数据
					return end - start + 1;
				} else {//不存在数据
					return 0;
				}
			}
		}
		return this.children.getCount();
	},
	
	//private
	wrapRecs : function(recs){
		if(!recs){
			return false;
		}
		if(!L5.isArray(recs)){
			recs = [recs];
		} else if(recs.length==0){
			return false;
		}
		return recs;
	},
	
	/**
	 * 添加记录到某个区间的末尾
	 * 请保证recs都位于同一区间内
	 * 如果不指定参数interkey,则按照recs[0].recordType创建区间
	 * @param {Object} recs
	 * @param {Object} interkey
	 */
	insert : function(recs,interkey){
		recs = this.wrapRecs(recs);
		if(!recs){
			return;
		}
		interkey = interkey || recs[0].recordType;
		var index = this.interval.indexOf(interkey);
		var addpos = this.children.getCount();
		if(index==-1){
			index = this.interval.create(interkey);
		}
		this.insertToInterval(index,this.getAddIndex(index,addpos),recs);
	},
	
	/**
	 * 插入节点到某个位置之前,需要参考区间位置决定实际插入位置,规则如下:
	 * 如果interkey不存在,创建新的区间
	 * 如果interkey存在,获取其区间
	 *  如果index位于区间开始位置与结束位置之间,插入记录
	 *  如果index小于区间开始位置,插入开始位置
	 *  如果index大于区间开始位置,插入末尾
	 * @param {Object} index 小于0,按0计算,大于节点个数,按照最后一个节点计算
	 * @param {Object} recs
	 * @param {Object} interkey
	 */
	insertAt : function(index,recs,interkey){
		recs = this.wrapRecs(recs);
		if(!recs){
			return;
		}
		interkey = interkey || recs[0].recordType;
		var interindex;
		if(!this.interval.contains(interkey)){
			interindex = this.interval.createByPostion(index,interkey);
		} else {
			interindex = this.interval.indexOf(interkey);
		}
		
		this.insertToInterval(interindex,this.getAddIndex(interindex,index),recs);
	},
	
	//计算合适的插入位置
	//private
	getAddIndex : function(interindex,recindex){
		var curinter = this.interval.getAt(interindex);
		var curstart = curinter.interval[0];
		var curend = curinter.interval[1];
		var curindex = recindex;
		
		if(curstart>curend){//区间不存在节点
			var validbeforeindex = this.interval.validBefore(interindex);
			if(validbeforeindex == -1){//前面没有存在节点的区间
				curindex = 0;
			} else {//添加到末尾
				var beforeinte = this.interval.getAt(validbeforeindex);
				curindex = beforeinte.interval[1] + 1;
			}
		} else {//当前区间存在节点
			if(curindex>curend){//添加到末尾
				curindex = curend + 1;
			} else if(curindex<curstart){//添加到开头
				curindex = curstart;
			}
			//其他情况,不处理
		}
		return curindex;
	},
	
	/**
	 * @ignore
	 * 如果之前没有排序过,按照普通的增加处理
	 * 如果之前排过序,则有序增加
	 * @param {Object} recs
	 * @param {Object} interkey
	 */
	insertSort : function (recs,interkey){
		if(!this.sortInfo){
			this.insert(recs,interkey);
			return;
		}
		recs = this.wrapRecs(recs);
		if(!recs){
			return;
		}
		interkey = interkey || recs[0].recordType;
		var oldkey = this.sortInfo.intervalkey;
		if(interkey!=oldkey){//与原有排序不匹配
			this.insert(recs,interkey);
			return;
		}
		var interindex;
		if(!this.interval.contains(interkey)){
			interindex = this.interval.getCount();
			this.interval.create(interkey);
		} else {
			interindex = this.interval.indexOf(interkey);
		}
		for(var i=0,len=recs.length;i<len;i++){
			var index = this.getIndexBySortInfo(recs[i],interindex);
			this.insertToInterval(interindex,index,[recs[i]]);
		}
	},
	
	/**
	 * @private
	 * 往区间的末尾添加记录
	 * @param {Object} interindex 区间位置,比如存在三个区间,插入第一个区间
	 * @param {Object} recs
	 */
	//private
	insertToInterval : function(interindex,recindex,recs){
		var inter = this.interval.getAt(interindex);
		var start = inter.interval[0];
		var end = inter.interval[1];
		if(start>end){//不存在子节点,recindex指明了开始位置
			start = recindex;
			end = recindex - 1;
		} else if(recindex == -1){//存在子节点,recindex位于start与end之间或者-1
			recindex = end + 1;
		}
			
		var len=recs.length;
		var add = [];
		for(var i=0;i<len;i++){
			var rec = recs[i];
			if(!this.children.containsKey(rec.id)){
				var oldparent = rec.parentRecord;//从旧的父节点中移除
				if(oldparent){
					oldparent.remove(rec);
				}
				this.children.insert(recindex+i,rec);
				add.push(rec);
				rec.parentRecord = this;
				rec.state = L5.model.Record.STATE_DELETED;
				var ds = this.getDataSet();
				rec.setDataSet(ds);
			}
		}
		var addlen = add.length;
		if(addlen==0){
			return;
		}
		this.interval.refreshByIndex(interindex,start,end+addlen);
		this.fireEvent('add',this,add,recindex,addlen);
	},
	
	/**
	 * 自动计算区间,然后刷新其数据
	 * 请保证recs都位于同一区间内
	 * @param {Object} recs
	 * @param {Object} interkey
	 */
	remove : function(recs,interkey){
		recs = this.wrapRecs(recs);
		if(!recs){
			return;
		}
		var len = recs.length;
		var removes = [];
		for(var i=0;i<len;i++){
			if(this.children.remove(recs[i])!=false){
				recs[i].parentRecord = false;
				recs[i].setDataSet(false);
				recs[i].state = L5.model.Record.STATE_DELETED;
				removes.push(recs[i]);
			}
		}
		var removelen = removes.length;
		if(removelen == 0){
			return;
		}
		interkey = interkey || removes[0].recordType;
		var interval = this.interval.get(interkey);
		var start = interval.interval[0];
		var end = interval.interval[1];
		if(start<=end){
			end -=removelen;
			this.interval.refresh(interkey,start,end);
		}
		this.fireEvent('remove',this,removes,removelen);
	},
	
	removeAt : function(index,interkey){
		var rec = this.getAt(index);
		if(this.children.removeAt(index)!=false){
			rec.parentRecord = false;
			rec.setDataSet(false);
			rec.state = L5.model.Record.STATE_DELETED;
			interkey = interkey || rec.recordType;
			var interval = this.interval.get(interkey);
			var start = interval.interval[0];
			var end = interval.interval[1];
			if(start<=end){
				end -=1;
				this.interval.refresh(interkey,start,end);
			}
			this.fireEvent('remove',this,[rec],1);
		}
	},
	
	/**
	 * 移除子节点,如果指定区间,则刷新区间信息,并不移除
	 * 不指定区间,则移除所有子节点数据,并且清除所有区间
	 * @param {Object} interkey
	 */
	removeAll : function(interkey){
		if(interkey){
			var start = 0;
			var end = -1;
			var iter = this.interval.get(interkey);
			if(iter){
				start = iter.interval[0];
				end = iter.interval[1];
				this.interval.refresh(interkey,0,-1);
				
				var removes = [] ;
				for(var i=end;i>=start;i--){
					var rec = this.children.removeAt(i);
					rec.parentRecord = false;
					rec.setDataSet(false);
					rec.state = L5.model.Record.STATE_DELETED;
					removes.push(rec);
				}
				var removelen = removes.length;
				if(removelen==0){
					return;
				}
				this.fireEvent('remove',this,removes,removelen);
			}
		} else {
			var removes = this.children.items;
			var removelen = removes.length;
			if(removelen == 0){
				return;
			}
			this.interval.clear();
			this.children.clear();
			for(var i=0;i<removelen;i++){
				var rec = removes[i];
				rec.parentRecord = false;
				rec.setDataSet(false);
				rec.state = L5.model.Record.STATE_DELETED;
			}
			this.fireEvent('remove',this,removes,removelen);
		}
	},
	
	/**
	 * @private
	 * 开始编辑状态:grid与form联动时,form一直是编辑状态,保存时也是编辑状态
	 * 结束编辑状态:grid编辑,点击某一行,此行进入编辑状态,点击其他行时,其他行进入编辑状态,以前的行结束编辑状态,
	 * 	或者按下esc,以前行业结束编辑状态
	 * 退出编辑:翻页
	 * 只要没有翻页,也没有保存,数据都可以回滚
	 */
    beginEdit : function(){
		if(this.editing){
			return ;
		}
        this.editing = true;
		this.dirty = false;//不存在脏数据
		//modified存放以前的修改信息
        this.modified = {};
    },

	/**
	 * @private
	 * 放弃以前的修改信息,相当于commit了,
	 * 不需要通知别的组件,因为别的组件应当使用了当前record的最新信息,与以前的信息没有干扰
	 */
    cancelEdit : function(){
		if(this.editing){
	        this.editing = false;
			this.dirty = false;//不存在脏数据了
	        delete this.modified;
		}
    },

    endEdit : function(){
		if(this.editing){
	        this.editing = false;
	        if(this.dirty){
				if(this.getDataSet())
	            	this.getDataSet().afterEdit(this);
					
				var modf = {};//防止用户对修改信息进行干扰,因此新建一个修改信息传给用户
				L5.apply(modf,this.modified);
				this.fireEvent('update',this,modf,L5.model.Record.EDIT);
	        }
		}
    },

	/**
	 * @private
	 * silent指明了是否需要通知dataset
	 * @param {Object} silent
	 */
    reject : function(silent){
		if(!this.dirty){//不是脏数据,返回
			return;
		}
        var m = this.modified;
        for(var n in m){
            if(typeof m[n] != "function"){
                this.data[n] = m[n];//回滚
            }
        }
        this.dirty = false;
        delete this.modified;
        this.editing = false;
        if(this.getDataSet()){
			if(silent !== true){
	            this.getDataSet().afterReject(this);
			}
        }
		this.fireEvent('update',this,m,L5.model.Record.REJECT);
    },

    commit : function(silent){
		if(!this.dirty){//不是脏数据,返回
			return;
		}
        this.dirty = false;
		var m = this.modified;
        delete this.modified;
        this.editing = false;
        if(this.getDataSet()){
			if(silent !== true){
	            this.getDataSet().afterCommit(this);
			}
        }
		this.fireEvent('update',this,m,L5.model.Record.COMMIT);
    },

    getChanges : function(){
        var m = this.modified, cs = {};
        for(var n in m){
            if(m.hasOwnProperty(n)){
                cs[n] = this.data[n];
            }
        }
        return cs;
    },

    // private
    hasError : function(){
        return this.error != null;
    },

    // private
    clearError : function(){
        this.error = null;
    },

    copy : function(newId) {
        return new this.constructor(L5.apply({}, this.data), newId || this.srcid);
    },
	
    isModified : function(fieldName){
        return !!(this.modified && this.modified.hasOwnProperty(fieldName));
    },
	
	//private
	//这是为了兼容form-binding对record的要求而设置,由于树有自身的一套dataset,因此此方法不做任何操作,这样form-binding
	//就不会干扰树
	join : function(dataset){
	},
	
    //校验该记录是否合法
    validateRecord : function(){
    	var hasRule = false;
    	 
    	for(var i=0;i<this.fields.items.length;i++){
     		if(this.fields.items[i].rule!=null){
     			hasRule = true;
     			break;
     		}
     	}
    	
    	if(hasRule === true){
    		for(var i=0; i<this.fields.items.length; i++){
    			var name = this.fields.items[i].name;
    			var value = this.get(name);
    			L5.Validator.validate(this, name, value);
    		}
    	}
    },
    
    //获取一条错误信息
    getErrMsg : function(){
		for(var v in this.validate){
			if(this.validate[v] === false){
				for(var i=0; i<this.fields.items.length; i++){
					if(this.fields.items[i].name == v){
						if(this.msgTitle[v] == null){
							this.msgTitle[v] = v;
						}
						return this.msgTitle[v] + this.msg[v];
					}
				}
			}
		}
		
		return null;
	},
	
    fireEvent : function(evtName){
		var ds = this.getDataSet();
        if(ds){
            if(ds.fireEvent.apply(ds, arguments) === false){
                return false;
            }
        }
        return true;
    },
	
	/**
	 * 获取record的dataset
	 * @return DataSet
	 */
	getDataSet : function(){
		//如果当前dataset不存在,往上获取父节点的dataset
		if(!this.dataset){
			var p = this.parentRecord;
            while(p){
                if(p.dataset){
                    this.dataset = p.dataset;
                    break;
                }
                p = p.parentRecord;
            }
		}
		return this.dataset;
	},
	
	//private
	setDataSet : function(ds){
		if(ds == this.dataset){
			return;
		}
		if(this.dataset){
			this.dataset.unregisterRecord(this);
		}
		this.dataset = ds;
		if(ds){
			ds.registRecord(this);
		}
		var cs = this.children;
		for(var i = 0, len = cs.getCount(); i < len; i++) {
			cs.itemAt(i).setDataSet(ds);
		}
	},
	
	/**
	 * @private
	 * 比较是否相等
	 * 首先比较类型是否一致
	 * 然后比较id是否一致
	 * 最后依次比较每一个字段值是否相等
	 * @param {Object} rec
	 */
	equals : function(rec){
		if(!rec){
			return false;
		}
		if(rec===this){
			return true;
		}
		if(this.constructor!==rec.constructor){
			return false;
		}
		if(this.id != rec.id){
			return false;
		}
		var fields = this.fields;
		var items = fields.items;
		for (var i = 0,len = items.length; i < len; i++) {
			var item = items[i];
			var name = item.name;
			if (this.data[name]!=rec.data[name]){
				return false;
			}
		}
		return true;
	},
	
	// private 生成一个函数,用于查询数据时判断record是否符合条件
	createChooseFn : function(property, value, anyMatch, caseSensitive){
		if(L5.isEmpty(value, false)){
			return false;
		}
        if(!value.exec){ //不是正则表达式
            value = String(value);
            value = new RegExp((anyMatch === true ? '' : '^') + L5.escapeRe(value), caseSensitive ? '' : 'i');
        }
		return function(r){
			var vl = r.data[property];
			return value.test(r.data[property]);
		};
	},
	
	toBean : function(clazz){
	 	var bean=new L5.DataBean(clazz);
	 	var data=this.data;
	 	//直接用他的data而不是重新赋值是不是要好点?
	 	for(name in data){
	 		if(data[name]=="")
	 			bean[name]=undefined;
	 		else 			
	 			bean[name]=data[name];
	 	}
	 	bean.state=this.state;
	 	return bean;
	},
	
	toJsonString : function(){
		var obj=new Object();
		obj.javaClass="org.loushang.next.data.Record";
		obj.id=this.id;
		obj.state=this.state;
		obj.data=this.data;
		return L5.encode(obj);
	}
};