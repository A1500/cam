/**
 * <p>Dataset类封装了一个包含L5.model.Record对象的客户端缓存，record对象
 * 提供组件的输入数据，比如L5.grid.GridPanel，L5.form.ComboBox或者L5.DataView DataView</p>
 * <p>Dataset对象使用L5.model.DataProxy的proxy实现来获取数据对象，除非你直接调用loadData方法并传递你的数据</p>
 * <p>Dataset对象并不知道Proxy返回的数据格式，它通过L5.model.DataReader的实现方法reader
 * 从数据对象来创建L5.model.Record实例。这些Records已经缓存，我们可以通过访问函数来操作数据。</p>
 * @class L5.model.Dataset
 * @extends L5.util.Observable
 * @constructor
 * 创建Dataset对象
 * @param {Object} config  config对象，包含dataset访问数据所需要的对象,读取数据到Records对象
 */
L5.model.Dataset = function(config){

    this.data = new L5.util.MixedCollection(false);
    this.data.getKey = function(o){
        return o.id;
    };
    
  	/**
  	 * Record对象在Dataset中的位置
  	 * @private
  	 * @property pos
  	 */
	this.pos = 0;
		
    /**
     * 翻页信息
     * @private
     * @property pageInfo
     */
    this.pageInfo = {
		"pageSize" : -1,
		"pageIndex" : 1,
		"startCursor" : 0
	};  
    
    // 从config对象中读取翻页信息
    if(config && config.pageSize && config.pageSize > 0){
		this.pageInfo.pageSize = config.pageSize;
		delete config.pageSize;
	}

	/**
	 * Proxy是URL方式，需要指定方法名
	 * @property method
	 */
	this.method;
    /**
     * 包含属性的对象，发送HTTP请求时作为传递参数
     * 属性可以在创建Dataset对象后，要发送不同的参数时修改。
     * @private
     * @property baseParams
     */
    this.baseParams = {};
    
    this.loadParams = {};
    /**
     * <p>包含属性的对象，加载数据时需要给远程服务器传递翻页和排序信息。
     * 默认情况下，对象以下面的格式定义:</p><pre><code>
		{
		    start : "start",    // 开始行的参数名称
		    limit : "limit",    // 返回数据记录数的参数名称
		    "defaultSort" :"defaultSort",//默认的排序信息，包括要排序的域和排序顺序
		    sort : "sort",      // 手动排序时，排序列的参数名称
		    dir : "dir"         // 手动排序时，排序方式的参数名称
		}
		</code></pre>
     * <p>服务器端会根据这些参数产生请求数据块。如果需要不同的参数名称，可以用配置属性覆盖这个属性</p>
     * <p>绑定到grid的PagingToolbar会在发送请求时用到这个属性配置</p>
     * @private
     * @property paramNames
     */
    this.paramNames = {
        "start" : "start",
        "limit" : "limit",
        "defaultSort" :"defaultSort",
        "sort" : "sort",
        "dir" : "dir"
    };

    /**
     * 默认排序信息
     * 根据model:field的sortDir属性定义，构建默认排序信息，包括要排序的域和排序顺序
     * 先定义的model:field，排序优先级更高
     * @private
     */
    this.defaultSortInfo=new L5.List();
    if(config.reader){
    	var meta=config.reader.meta;
    	if(meta){
    		var fields=meta.fields;
    		if(fields&&fields.length>0){
    			for(var i=0;i<fields.length;i++){
    				var sortDir=fields[i].sortDir;
    				if(sortDir){
    					var sortObj=new L5.Map();
    					sortObj.put("field",fields[i].name);
    					sortObj.put("dir",sortDir);
    					this.defaultSortInfo.add(sortObj);
    				}
    			}
    		}
    	}
    }
    
    if(config && config.data){
        this.inlineData = config.data;
        delete config.data;
    }

    L5.apply(this, config);

    if(this.url && !this.proxy){
        this.proxy = new L5.model.HttpProxy({url: this.url});
    }	
	
    if(this.reader){ // reader passed
        if(!this.recordType){
            this.recordType = this.reader.recordType;
        }
        if(this.reader.onMetaChange){
            this.reader.onMetaChange = this.onMetaChange.createDelegate(this);
        }
    }

    /**
     * 创建Record对象的类型
     * @private
     * @property recordType
     * @type Function
     */
    if(this.recordType){
        /**
         * 定义L5.model.Field的集合，只读
         * @private
         * @property fields
         * @type L5.util.MixedCollection
         */
        this.fields = this.recordType.prototype.fields;
    }
    this.modified = [];
    
    this.deleted = [];
    
    this.validated = {};

    this.addEvents(
        /**
         * @event datachanged
         * 数据缓存变化时触发，组件的Dataset应该更新它的视图
         * @param {Dataset} this
         */
        'datachanged',
        /**
         * @event metachange
         * 如果dataset的reader对象的元数据更改时触发目前只支持JsonReader
         * @param {Dataset} this
         * @param {Object} meta JSON元数据
         */
        'metachange',
        /**
         * @event add
         * 给Dataset增加数据时触发
         * @param {Dataset} this
         * @param {L5.model.Record[]} records 要增加的record数组
         * @param {Number} index 要增加record的位置
         */
        'add',
        /**
         * @event remove
         * 从Dataset移除数据时触发
         * @param {Dataset} this
         * @param {L5.model.Record} record 要移除的record对象
         * @param {Number} index 要移除的record对象的位置
         */
        'remove',
        /**
         * @event update
         * record对象更新时触发
         * @param {Dataset} this
         * @param {L5.model.Record} record 更新的record对象
         * @param {String} operation 执行的操作，值可以是：
         * <pre><code>
			 L5.model.Record.EDIT
			 L5.model.Record.REJECT
			 L5.model.Record.COMMIT
         * </code></pre>
         */
        'update',
        /**
         * @event clear
         * 清除缓存数据时触发
         * @param {Dataset} this
         */
        'clear',
        /**
         * @event beforeload
         * 请求新的数据对象时触发，如果返回false，load操作取消。
         * @param {Dataset} this
         * @param {Object} options 执行load操作传递的配置参数
         */
        'beforeload',
        /**
         * @event load
         * Record对象加载时触发
         * @param {Dataset} this
         * @param {L5.model.Record[]} records 加载的Record对象数组
         * @param {Object} options 执行load操作传递的配置参数
         */
        'load',
        /**
         * @event loadexception
         * 执行加载操作时出现异常时触发
         */
        'loadexception',
        /**
         * @event move
         * 记录指针移动时触发
         */
        'move',
        /**
         * @event turnPage
         * 翻页时触发
         */
        'turnPage',
        /**
         * @event validateFailed
         * @author lipf
         * @version 2011-02-28
         * 当调用验证方法isValidate并且验证失败后触发
         */
        'validateFailed'
    );

    if(this.proxy){
        this.relayEvents(this.proxy,  ["loadexception"]);
    }

    this.sortToggle = {};
    if(this.sortInfo){
        this.setDefaultSort(this.sortInfo.field, this.sortInfo.direction);
    }

    L5.model.Dataset.superclass.constructor.call(this);

    if(this.ds || this.id){
        L5.DatasetMgr.register(this);
    }
    if(this.inlineData){
        this.loadData(this.inlineData);
        delete this.inlineData;
    }else if(this.autoLoad){
        this.load.defer(10, this, [
            typeof this.autoLoad == 'object' ?
                this.autoLoad : undefined]);
    }
};
L5.extend(L5.model.Dataset, L5.util.Observable, {
    /**
    * @cfg {String} ds dataset的id，DatasetMgr注册使用
    */
    /**
    * @cfg {String} url 如果配置了url，会创建HttpProxy
    */
    /**
    * @cfg {Boolean/Object} autoLoad 是否自动加载数据
    */
    /**
    * @cfg {L5.model.DataProxy} proxy 获取数据的Proxy对象
    */
    /**
    * @cfg {Array} data dataset初始化时需要加载的数据
    */
    /**
    * @cfg {L5.model.DataReader} reader 读取数据并返回L5.model.Record对象的DataReader对象
    */
    /**
    * @cfg {Object} baseParams 发送HTTP请求时，需要传递的参数配置对象
    */
    /**
    * @private
    * @cfg {Object} sortInfo 配置对象格式: {field: "fieldName", direction: "ASC|DESC"} 排序规则信息，大小写敏感 
    */
    /**
    * @private
    * @cfg {boolean} remoteSort 是否远程排序，如果是，点击grid列的header时，会发送请求道服务器端排序，包含两个参数：
    * sort：要排序的列名称，dir：排列顺序，"ASC" or "DESC"
    */
    remoteSort : true,

    /**
    * @cfg {boolean} pruneModifiedRecords 默认是true，如果是true，每次dataset加载或者record移除将会清空所有修改的数据
    */
    pruneModifiedRecords : true,

    /**
     * 包含加载数据最后一次的配置选项
     * @property lastOptions
     */
    lastOptions : null,
    
    /**
     * 设置加载数据时传递的参数名称/值
     * @method setParameter
     * @param {String} name 名称
     * @param {String} value 值
     */
    setParameter : function(name,value){
		if(!this.sortInfo)
			this.sortInfo={};
		if(name=="sort"){
			this.sortInfo.field = value;
		} else if(name=="dir"){
			this.sortInfo.direction = value;
		}else {
			this.loadParams[name] = value;   
		}
    },
    
    /**
     * 对所有设定规则的域校验，如果全部合法，返回true，否则返回错误信息
     * @param ifgrid 是否获取grid对应的错误消息格式（第X行XXX不能为空），默认form类型。
     * @param ifall 是否把所有的错误信息一次性返回。
     * @method isValidate
     * @return {Boolean} 校验是否通过
     */
    isValidate : function(ifgrid,ifall) {
    	for(var i=0;i<this.getCount();i++){
    		var record = this.getAt(i);
    		for(var j=0;j<this.fields.items.length;j++){
    			if(this.fields.items[j].rule!=null){
    				var name = this.fields.items[j].name;
    				L5.Validator.validate(record, name, record.get(name));
    			}
    		}
    	}
		for(var v in this.validated){
			if(this.validated[v] != null){
				//按照record的id删除，以前是按照索引，但是索引可能会变化
				var record = this.getById(v);
				var recordErrMsg = record.getErrMsg(ifgrid,ifall);
				/**
				 * @author lipf
				 * @version 2011-02-28
				 * 当调用验证方法isValidate触发,form绑定会监听该事件，然后根据参数信息，设置显示样式以及提示信息
				 */
				this.fireEvent("validateFailed", this, record,recordErrMsg);
				return recordErrMsg;
			}
		}
		return true;
	},

    /**
     * 移动到第一条记录
     * @method moveFirst
     */
    moveFirst : function() {
		this.pos = 0;
		this.fireEvent("move", this, this.pos);
	},
	/**
	 * 移动到下一条记录
	 * @method moveNext
	 * @return {Boolean} 移动成功则返回true，否则返回false
	 */
	moveNext : function() {
		if (this.pos >= this.getCount() - 1)
			return false;
		this.pos++;
		this.fireEvent("move", this, this.pos);
		return true;
	},

	/**
	 * 移动到前一条记录
	 * @method movePrev
	 * @return {Boolean} 移动成功则返回true，否则返回false
	 */
	movePrev : function() {
		if (this.pos == 0)
			return false;
		this.pos--;
		this.fireEvent("move", this, this.pos);
		return true;
	},

	/**
	 * 移动到指定的记录
	 * @method moveTo
	 * @param {int} npos 记录的位置
	 */
	moveTo : function($_npos) {
		if ($_npos > this.getCount() - 1 || $_npos < 0||this.pos == $_npos) {
			return;
		}
		this.pos = $_npos;
		this.fireEvent("move", this, this.pos);
	},
	/**
	 * 移动到指定的记录，专用于EditGrid
	 * @method moveTo2
	 * @param {int} npos 记录的位置 
	 */
	moveTo2 : function($_npos) {
		if ($_npos > this.data.length - 1 || $_npos < 0) {
			return;
		}
		this.pos = $_npos;
	},
	/**
	 * 移动到最后一条记录
	 * @method moveLast
	 */
	moveLast : function() {		
		var npos= this.getCount() - 1 ;
		if(this.pos==npos)return;
		this.pos = npos
		this.fireEvent("move", this, this.pos);
	},

	/**
	 * 得到当前位置的Record对象
	 * @method getCurrent
	 * @return {L5.model.Record} 返回record对象
	 */
	getCurrent : function() {
		return this.getAt(this.pos);
	},

	/**
	 * 根据域名称得到当前Record对象域的值
	 * @method get
	 * @param {String} name 域的名称
	 * @return {Object} 域的值
	 */
	get : function(name) {
		return this.getCurrent().get(name);
	},
	
	/**
	 * 给当前Record对象指定域赋值
	 * @method set
	 * @param {String} name 要赋值的域的名称
	 * @param {String} value 域的值
	 */
	set : function(name, value) {
		return this.getCurrent().set(name, value);
	},
	
	/**
	 * 检查当前的Record对象是否是第一条记录
	 * @method isFirst
	 * @return {Boolean} 
	 */
	isFirst : function(){
		if(this.pos == 0)
			return true;
		else 
			return false;
	},
	
	/**
	 * 检查当前的Record对象是否是最后一条记录
	 * @method isLast
	 * @return {Boolean} 
	 */
	isLast : function(){
		if(this.pos == this.getCount() - 1)
			return true;
		else 
			return false;
	},
	
	/**
	 * 销毁Dataset对象时的清理工作
	 * @method destroy
	 * @private
	 */
    destroy : function(){
        if(this.ds || this.id){
            L5.DatasetMgr.unregister(this);
        }
        this.data = null;
        this.purgeListeners();
    },

    /**
     * 添加Records对象数组到Dataset并且触发add事件
     * @method add
     * @param {L5.model.Record[]} records 包含L5.model.Record对象的数组，添加到缓存
     */
    add : function(records){
        records = [].concat(records);
        if(records.length < 1){
            return;
        }
        var has =[];
        for(var i = 0, len = records.length; i < len; i++){
        	if(this.deleted.indexOf(records[i]) != -1){
        		records[i].state = L5.model.Record.NONE;
				this.deleted.remove(records[i]);
        	}else if(this.data.indexOf(records[i])!=-1){
        		has[has.length] = i;
        		continue;
        	}else{
        		if (this.modified.indexOf(records[i]) == -1) {
    				records[i].state = L5.model.Record.STATE_NEW;
    				this.modified.push(records[i]);
    			}
        	}
            records[i].join(this);
        }
        if(has.length!=0){
        	for(var h=has.length-1;h>=0;h--){
        		records.remove(records[has[h]]);
        	}
        }
        if(records.length==0)
        	return;
        var l = this.data.length;
        this.data.addAll(records);
        if(this.snapshot){
            this.snapshot.addAll(records);
        }
        this.fireEvent("add", this, records, l);
    },

    /**
     * (本地排序) 按照当前的排序规则将Record对象插入到Dataset对象既定的位置
     * @method addSorted
     * @param {L5.model.Record} record record对象
     */
    addSorted : function(record){
        var i = this.findInsertIndex(record);
        this.insert(i, record);
    },

    /**
     * 从Dataset对象中移除Record对象并触发remove事件
     * @method remove 
     * @param {L5.model.Record} record 要从缓存中移除的L5.model.Record对象
     */
    remove : function(record){
    	var rid=record.id;
        var i = this.data.indexOf(record);         
        this.data.removeAt(i);
        if(this.pruneModifiedRecords){
            this.modified.remove(record);
            this.deleted.remove(record);
        }
        if(this.validated){
        	//按照record的id删除，以前是按照索引，但是索引可能会变化
        	delete this.validated[rid];
        }
        if(this.snapshot){
            this.snapshot.remove(record);
        }       
         if(this.deleted.indexOf(record) == -1){
         	if(record.state == L5.model.Record.STATE_NEW){
         		this.modified.remove(record);
         	}else if(record.state == L5.model.Record.STATE_MODIFIED){
         		record.reject(true);
         		this.modified.remove(record);
         		record.state = L5.model.Record.STATE_DELETED;
         		this.deleted.push(record);
         		
         	}else if(record.state == L5.model.Record.NONE){
         		record.state = L5.model.Record.STATE_DELETED;
         		this.deleted.push(record);
         	}
         }		
         this.fireEvent("remove", this, record, i);         
    },
    
    /**
     * 从Dataset中移除指定位置的Record对象并触发remove事件
     * @method removeAt
     * @param {Number} index 要移除的record对象的索引号
     */
    removeAt : function(index){
        this.remove(this.getAt(index));    
    },

    /**
     * 从Dataset对象移除所有的Record对象并触发clear事件
     * @method removeAll
     */
    removeAll : function(){
        this.data.clear();
        if(this.snapshot){
            this.snapshot.clear();
        }
        if(this.pruneModifiedRecords){
            this.modified = [];
            this.deleted = [];
        }
        this.validated = {};
        this.fireEvent("clear", this);
    },

    /**
     * 从指定的位置开始将Record对象数组插入到Dataset并触发add事件
     * @method insert
     * @param {Number} index 指定插入的起始位置
     * @param {L5.model.Record[]} records 要添加的L5.model.Record对象数组
     */
    insert : function(index, records){  
        records = [].concat(records);
        for(var i = 0, len = records.length; i < len; i++){
        	if(this.deleted.indexOf(records[i]) != -1){
        		records[i].state = L5.model.Record.NONE;
				this.deleted.remove(records[i]);
        	}else{
        		if (this.modified.indexOf(records[i]) == -1) {
    				records[i].state = L5.model.Record.STATE_NEW;
    				this.modified.push(records[i]);
    			}
        	}
        	this.data.insert(index, records[i]);
            records[i].join(this);
        }
        this.fireEvent("add", this, records, index);
    },

    /**
     * 获得Record对象在Dataset中的位置
     * @method indexOf
     * @param {L5.model.Record} record 需要查找的L5.model.Record对象
     * @return {Number} record的位置，如果没有找到则返回-1
     */
    indexOf : function(record){
        return this.data.indexOf(record);
    },

    /**
     * 根据Record对象的id得到它的位置
     * @method indexOfId
     * @param {String} id 需要查找的record的id
     * @return {Number} record的位置，如果没有找到则返回-1
     */
    indexOfId : function(id){
        return this.data.indexOfKey(id);
    },

    /**
     * 根据id获取Record对象
     * @method getById
     * @param {String} id 需要查找的record对象的id
     * @return {L5.model.Record} record对象，如果没有找到则返回undefined
     */
    getById : function(id){
        return this.data.key(id);
    },

    /**
     * 根据索引得到Record对象
     * @method getAt
     * @param {Number} index 需要查找的Record对象的索引
     * @return {L5.model.Record} 根据索引得到的Record对象，如果没有找到则返回undefined
     */
    getAt : function(index){
        return this.data.itemAt(index);
    },

    /**
     * 返回指定索引区间的Records集合
     * @method getRange
     * @param {Number} startIndex (可选) 起始位置(默认是0)
     * @param {Number} endIndex (可选) 结束位置(默认是Dataset最后一个Record对象的位置)
     * @return {L5.model.Record[]} Record对象数组
     */
    getRange : function(start, end){
        return this.data.getRange(start, end);
    },

  	/**
  	 * @method storeOptions
  	 * @private
  	 * @param {Object} o
  	 */
    storeOptions : function(o){
        o = L5.apply({}, o);
        delete o.callback;
        delete o.scope;
        this.lastOptions = o;
    },

    /**
     * 根据指定的Reader和Proxy加载Record数据
     * <p>如果是远程翻页，第一次加载时必须指定options对象中的<tt>start</tt>
     * 和<tt>limit</tt>属性。</p>
     * <p>获取远程数据源，加载是异步的。对数据的处理可以通过回调函数或者"load"事件</p>
     * @method load
     * @param {Object} options 包含控制加载的属性配置对象
     * <li><b>params</b> :<p>Object 包含获取远程数据源需要传输的HTTP参数对象</li></p>
     * <li><b>callback</b> : Function<p>数据加载后调用的回调函数，下面是回调函数需要的参数：<ul>
     * <li>r : L5.model.Record[]</li>
     * <li>options: Options object from the load call</li>
     * <li>success: Boolean 是否成功的标志</li></ul></p></li>
     * <li><b>scope</b> : Object<p>调用回调函数的范围(默认是Dataset对象)</p></li>
     * <li><b>add</b> : Boolean<p>标明是添加到records而不是覆盖缓存中的数据</p></li>
     * </ul>
     * @return {Boolean} load事件是否被触发(如果beforeload失败).
     */
    load : function(options){
    	this.pageInfo.pageIndex = 1;// reset pageindex
		this.pageInfo.startCursor = 0;
		if(options===true){
			options={sync:true};
		}
		options = options || {};
		options.params = L5.apply(options.params || {}, this.loadParams);// 合并参数
		this.loadParams = {};// 清空参数
		this.loadPage(options);
    },
    /**
     * 加载数据
     * @method loadPage
     * @private
     * @param {Object} options 包含加载数据控制参数的对象
     * @return {Boolean}
     */
    loadPage : function(options){
    	this.pos = 0; // reset pageindex
		var pn = this.paramNames;
		options = options || {};
		if (this.fireEvent("beforeload", this, options) !== false) {
			var p = L5.apply(options.params || {}, this.baseParams);
			this.storeOptions(options);
			// params has not default param,give the default page params
			if (this.pageInfo.pageSize > 0) {
				if (!p[pn["start"]]) {
					p[pn["start"]] = 0;
					p[pn["limit"]] = this.pageInfo.pageSize;
				}
			}
			//传递默认排序参数
			if (this.defaultSortInfo){
				p[pn["defaultSort"]] = this.defaultSortInfo;
			}
			// 传递手动排序参数
			if (this.sortInfo && this.remoteSort) {
				p[pn["sort"]] = this.sortInfo.field;
				p[pn["dir"]] = this.sortInfo.direction;
			}
			if(options.sync){
				p.sync=true;
			}
			this.proxy.load(p, this.reader, this.loadRecords, this, options);
			return true;
		} else {
			return false;
		}
    },

    /**
	 * 根据前一次加载的配置重新加载数据
	 * @method reload
	 * @param {Object}
	 *            options (可选) 加载选项，可能会取前一次加载数据时的配置。
	 *            可参考load方法(如果是用的最近一次加载的配置，默认是null)
	 */
    reload : function(options){
        this.loadPage(L5.applyIf(options||{}, this.lastOptions));
    },

    /**
     * 根据key获得开发人员自定义数据
     * @param {String} key 在后台放入数据时的key值
     * @return {Object} 如果是Dataset，返回的是对象，需要加载后数据后才能调用Dataset对象的接口操作数据。如果是其他的类型，比如Map，则直接返回Map对象。
     */
    getCustomData : function(key){
    	if(this.customDatas){
    		var obj = this.customDatas[key];
    		if(obj.javaClass == "DataSet") 
    			return obj;
    		else 
    			return L5.serializer.unmarshall(obj);
    	}
    	else {
    		return undefined;
    	}
    },
    /**
     * 加载数据时取得开发人员自定义数据
     * @private
     * @param {Object} o 响应数据对象
     */
    loadCustomDatas : function(o){
    	//将开发人员自定义的数据保存到customDatas变量中
        if(o.customDatas){
        	this.customDatas = L5.serializer.unmarshall(o.customDatas.map);
        }else{
        	return;
        }
    },
    
    /**
     * 在加载过程中被Reader回调
     * @method loadRecords
     * @private
     * @param {Object} o
     * @param {Object} options  加载控制参数，可能会取最近一次加载的值
     * @param {Boolean} success		
     */
    loadRecords : function(o, options, success){
        if(!o || success === false){
            if(success !== false){
                this.fireEvent("load", this, [], options);
            }
            if(options.callback){
                options.callback.call(options.scope || this, [], options, false);
            }
            return;
        }
        var r = o.records, t = o.totalRecords || r.length;
        this.loadCustomDatas(o);
        if(!options || options.add !== true){
            if(this.pruneModifiedRecords){
                this.modified = [];
                this.deleted = [];
                this.validated = {};
            }
            for(var i = 0, len = r.length; i < len; i++){
                r[i].join(this);
            }
            if(this.snapshot){
                this.data = this.snapshot;
                delete this.snapshot;
            }
            this.data.clear();
            this.data.addAll(r);
            this.totalLength = t;
            this.applySort();
            this.fireEvent("datachanged", this);
        }else{
            this.totalLength = Math.max(t, this.data.length+r.length);
            this.add(r);
        }
        this.fireEvent("load", this, r, options);
        if(options.callback){
            options.callback.call(options.scope || this, r, options, true);
        }
    },

    /**
     * 加载数据块并触发load事件
     * @method loadData
     * @private
     * @param {Object} data 读取Records的数据来源，数据格式取决于Reader的类型并且与Reader的readRecords参数一致
     * @param {Boolean} append (可选的) 如果是true，追加新的记录而不是覆盖现在的数据，否则会清空Dataset中的数据再增加
     * <b>需要注意的是，增加的Record的id必须是唯一的，否则会覆盖原来有相同id的Record对象</b>
     */
    loadData : function(o, append){
    	if(o.error){
			var e=new L5.Exception(o.error.code, o.error.msg,o.error.trace);
			if(o.error.title){//如果有自定义title，则复制给exception
				e.title=o.error.title;
			}
			this.fireEvent("loadexception", e);
			return;	
		}
		this.lastOptions={};
        var r = this.reader.readRecords(o);
        this.loadRecords(r, {add: append}, true);
    },

    /**
     * 得到Dataset缓存的记录数，如果是翻页，这可能不是dataset所有的记录
     * @method getCount
     * @return {Number} 缓存的Dataset对象包含的Record记录数
     */
    getCount : function(){
        return this.data.length || 0;
    },

    /**
     * 返回从服务器端获得的dataset对象所有的记录数,如果改变了本地的dataset对象，这个值是不会更新的。
     * @method getTotalCount
     * @return {Number} 记录总数
     */
    getTotalCount : function(){
        return this.totalLength || 0;
    },
	
	/**
	 * 翻到指定页
	 * @method turnPage
	 * @param {Number} pageIndex 页号
	 */
	turnPage : function(pageIndex){
		var pageTotal = this.getTotalPage();
		if (pageIndex < 1) {
			L5.Msg.alert("提示",L5.turnPageFirst ? L5.turnPageFirst : "page num too small");
			return false;
		}
		if(pageIndex > pageTotal){
			L5.Msg.alert("提示",L5.turnPageLast ? L5.turnPageLast : "page num too large");
			return false;
		}
		this.pageInfo.pageIndex = pageIndex;
		this.pageInfo.startCursor = this.pageInfo.pageSize * (this.pageInfo.pageIndex - 1);

		var p = {}, pn = this.paramNames;
		p[pn.start] = this.pageInfo.startCursor;
		p[pn.limit] = this.pageInfo.pageSize;

		if (this.lastOptions && this.lastOptions.params) {
			p = L5.applyIf(p, this.lastOptions.params);
		}
		if (this.lastOptions) {
			var options = L5.applyIf({
						params : p
					}, this.lastOptions);
		}
		this.loadPage(options);
		this.fireEvent("turnPage");
	},
	
	/**
	 * 翻到下一页
	 * @method turnNext
	 */
	turnNext : function(){
		this.turnPage(this.pageInfo.pageIndex + 1);    		
	},
		
	/**
	 * 翻到最后一页
	 * @method turnLast
	 */
	turnLast : function(){
		var total = this.getTotalCount();
		var pageTotal = Math.ceil(total / this.pageInfo.pageSize);
		this.turnPage(pageTotal);  		
	},
	
	/**
	 * 翻到前一页
	 * @method turnPrev
	 */	
	turnPrev : function(){
		this.turnPage(this.pageInfo.pageIndex - 1); 		
	},	
	
	/**
	 * 翻到第一页
	 * @method turnFirst
	 */
	turnFirst : function(){
		this.turnPage(1);    		
	},
	
	/**
	 * 得到当前的页号
	 * @method getPageIndex
	 * @private
	 * @return {Number} pageIndex 页号
	 */
	getPageIndex : function(){
		return this.pageInfo.pageIndex;
	},
	
	/**
	 * 得到每页的记录数
	 * @method getPageSize
	 * @private
	 * @return {Number} pageSize 记录数
	 */
	getPageSize : function(){
		return this.pageInfo.pageSize;
	},
	
	/**
	 * 得到记录的起始记录序号
	 * @method getStartCursor
	 * @private
	 * @return {Number} startCursor 起始记录
	 */
	getStartCursor : function(){
		return this.pageInfo.startCursor;
	},
	
	/**
	 * 获取总页数
	 * @method getTotalPage
	 * @private
	 * @return {Number} 总页数
	 */
	getTotalPage : function(){
		if (this.pageInfo.pageSize <= 0) {
			return 1;
		}
		return Math.ceil(this.getTotalCount() / this.pageInfo.pageSize);	
	},
	
	/**
	 * 是否是最后一页
	 * @method isLastPage
	 * @private
	 * @return {Boolean}
	 */
	isLastPage : function(){
		return this.getPageIndex() >= this.getTotalPage();	
	},
	
	/**
	 * 是否是第一页
	 * @method isFirstPage
	 * @private
	 * @return {Boolean}
	 */
	isFirstPage : function(){
		return this.getPageIndex() == 1;
	},
    /**
     * 返回描述Dataset当前排序状态的对象
     * @method getSortState
     * @private
     * @return {Object} 排序状态，包含2个属性的对象：：<ul>
     * <li><b>field : String<p>Records排序的域名称</p></li>
     * <li><b>direction : String<p>排列顺序，"ASC" or "DESC" (大小写敏感)</p></li>
     * </ul>
     */
    getSortState : function(){
        return this.sortInfo;
    },

    /**
     * 根据当前的排序规则排序
     * @method applySort
     * @private
     */
    applySort : function(){
        if(this.sortInfo && !this.remoteSort){
            var s = this.sortInfo, f = s.field;
            this.sortData(f, s.direction);
        }
    },

    /**
     * 根据排序规则排序
     * @method sortData
     * @private
     * @param {String} field 排序的域名称
     * @param {String} direction 排列顺序
     */
    sortData : function(f, direction){
        direction = direction || 'ASC';
        var st = this.fields.get(f).sortType;
        var fn = function(r1, r2){
            var v1 = st(r1.data[f]), v2 = st(r2.data[f]);
            return v1 > v2 ? 1 : (v1 < v2 ? -1 : 0);
        };
        this.data.sort(direction, fn);
        if(this.snapshot && this.snapshot != this.data){
            this.snapshot.sort(direction, fn);
        }
    },

    /**
     * 设置默认排序列和排列顺序，给下一次加载操作使用
     * @method setDefaultSort
     * @private
     * @param {String} field 排序的域名称
     * @param {String} dir (可选) 排列顺序，"ASC" or "DESC" (大小写敏感，默认"ASC")
     */
    setDefaultSort : function(field, dir){
        dir = dir ? dir.toUpperCase() : "ASC";
        this.sortInfo = {field: field, direction: dir};
        this.sortToggle[field] = dir;
    },
	
    /**
     * 给缓存的数据排序，如果是远程排序，那么将在服务器端操作，并重新加载缓存数据。
     * 如果是本地排序，则在本地排序。
     * @method sort
     * @private sort
     * @param {String} fieldName 排序的域名称
     * @param {String} dir (可选) 排列顺序"ASC" or "DESC" (大小写敏感，默认是"ASC")
     */
    sort : function(fieldName, dir){
        var f = this.fields.get(fieldName);
        if(!f){
            return false;
        }
        if(!dir){            
             dir = (this.sortToggle[f.name] || "ASC").toggle("ASC", "DESC");
        }
        var st = (this.sortToggle) ? this.sortToggle[f.name] : null;

        this.sortToggle[f.name] = dir;
        this.sortInfo = {field: f.name, direction: dir};
        var si = (this.sortInfo) ? this.sortInfo : null;
        if(!this.remoteSort){
            this.applySort();
            this.fireEvent("datachanged", this);
        }else{
            if (!this.load(this.lastOptions)) {
                if (si) {
                    this.sortInfo = si;
                }
            }
        }
    },

    /**
     * 缓存的Records对象依次调用指定的函数
     * @method each
     * @param {Function} fn 要调用的函数，第一个参数是传入的Record对象，如果取消并退出本次迭代则返回false
     * @param {Object} scope (可选) 调用函数的作用域(默认是Record).
     */
    each : function(fn, scope){
        this.data.each(fn, scope);
    },

    /**
     * 获得最后一次提交后所修改的record对象集合
     * @method getModifiedRecords
     * @return {L5.model.Record[]} record对象数组
     */
    getModifiedRecords : function(){
        return this.modified;
    },

    /**
     * 获得最后一次提交后删除的record对象集合
     * @method getDeletedRecords
     * @return {L5.model.Record[]} record对象数组
     */
    getDeletedRecords : function(){
    	return this.deleted;
    },
    
    /**
     * 获得最后一次提交后删除和修改的record对象集合
     * @method getAllChangedRecords
     * @return {L5.model.Record[]} record对象数组
     */
    getAllChangedRecords : function(){
    	return this.modified.concat(this.deleted);
    },
    
    /**
     * 获得缓存的所有record对象
     * @method getAllRecords
     * @return {L5.model.Record[]} record对象数组
     */
    getAllRecords : function(){
    	return this.data.items;
    },
    
    /**
     * 创建过滤规则函数
     * @method createFilterFn
     * @private
	 * @param {String} field record中的一个域
     * @param {String/RegExp} value 或者是域的开始部分，或者是一个正则表达式
     * @param {Boolean} anyMatch (可选) 如果是true，则匹配任意位置，而不只是开始
     * @param {Boolean} caseSensitive (可选) 如果是true，则大小写敏感比较
     * @return {Boolean}
     */
    createFilterFn : function(property, value, anyMatch, caseSensitive){
        if(L5.isEmpty(value, false)){
            return false;
        }
        value = this.data.createValueMatcher(value, anyMatch, caseSensitive);
        return function(r){
            return value.test(r.data[property]);
        };
    },

    /**
     * 计算指定范围内的所有record对象中某个域的和
     * @method sum
     * @param {String} property Record对象中的某个域
     * @param {Number} start 起始位置(默认是0)
     * @param {Number} end 终止位置(默认是dataset的长度- 1)
     * @return {Number} 结果值
     */
    sum : function(property, start, end){
        var rs = this.data.items, v = 0;
        start = start || 0;
        end = (end || end === 0) ? end : rs.length-1;

        for(var i = start; i <= end; i++){
            v += (rs[i].data[property] || 0);
        }
        return v;
    },

    /**
     * 按照指定的属性过滤records集合
     * @method filter
     * @param {String} field record中的一个域
     * @param {String/RegExp} value 或者是域的开始部分，或者是一个正则表达式
     * @param {Boolean} anyMatch (可选) 如果是true，则匹配任意位置，而不只是开始
     * @param {Boolean} caseSensitive (可选) 如果是true，则大小写敏感比较
     */
	filter : function(property, value, anyMatch, caseSensitive) {
		var fn = this.createFilterFn(property, value, anyMatch, caseSensitive);
		return fn ? this.filterBy(fn) : this.clearFilter();
	},
    /**
	 * 根据函数过滤，指定的函数会被Dataset中的所有Record对象调用。
	 * 如果函数返回true，说明包含该Record对象，否则过滤掉。
	 * @method filterBy
	 * @param {Function}
	 *            fn 要调用的函数，需要以下几个参数：
	 *            <ul>
	 *            <li><b>record</b> : L5.model.Record
	 *            <p>
	 *            需要过滤的record对象，L5.model.Record的get方法访问域的值
	 *            </p>
	 *            </li>
	 *            <li><b>id</b> : Object
	 *            <p>
	 *            Record传入的ID
	 *            </p>
	 *            </li>
	 *            </ul>
	 * @param {Object}
	 *            scope (可选) 函数的作用域(默认this)
	 */
    filterBy : function(fn, scope){
        this.snapshot = this.snapshot || this.data;
        this.data = this.queryBy(fn, scope||this);
        this.fireEvent("datachanged", this);
    },

    /**
     * 根据指定的域查询records
     * @method query
	 * @param {String} field record中的一个域
     * @param {String/RegExp} value 或者是域的开始部分，或者是一个正则表达式
     * @param {Boolean} anyMatch (可选) 如果是true，则匹配任意位置，而不只是开始
     * @param {Boolean} caseSensitive (可选) 如果是true，则大小写敏感比较
     * @return {L5.util.MixedCollection} 所有匹配的records集合对象
     */
    query : function(property, value, anyMatch, caseSensitive) {
		var fn = this.createFilterFn(property, value, anyMatch, caseSensitive);
		return fn ? this.queryBy(fn) : this.data.clone();
	},

    /**
	 * 通过过滤函数查询缓存的record数据，指定的函数被dataset中的所有record对象调用。
	 * 如果函数返回true，这个record对象将包含在返回的结果集中
	 * @method queryBy
	 * @param {Function}
	 *            fn 要调用的函数，需要传递下面几个参数：
	 *            <ul>
	 *            <li><b>record</b> : L5.model.Record
	 *            <p>
	 *            要过滤的record对象，通过L5.model.Record的get方法获取域的值
	 *            </p>
	 *            </li>
	 *            <li><b>id</b> : Object
	 *            <p>
	 *            Record传入的ID
	 *            </p>
	 *            </li>
	 *            </ul>
	 * @param {Object}
	 *            scope (可选) 函数的作用域(默认是this)
	 * @return {L5.util.MixedCollection} 返回的匹配的records对象集合
	 */
    queryBy : function(fn, scope){
        var d = this.snapshot || this.data;
        return d.filterBy(fn, scope||this);
    },

    /**
     * 根据指定的域/值查找第一个在dataset中匹配的record对象的索引
     * @method find
	 * @param {String} property record中的一个域
     * @param {String/RegExp} value 或者是域的开始部分，或者是一个正则表达式
     * @param {Number} start 要查找的起始位置
     * @param {Boolean} anyMatch (可选) 如果是true，则匹配任意位置，而不只是开始
     * @param {Boolean} caseSensitive (可选) 如果是true，则大小写敏感比较
     * @return {Number} 匹配的索引号或者-1
     */
    find : function(property, value, start, anyMatch, caseSensitive){
        var fn = this.createFilterFn(property, value, anyMatch, caseSensitive);
        return fn ? this.data.findIndexBy(fn, null, start) : -1;
    },

    /**
     * 根据函数查找第一个在dataset中匹配的record对象的索引
     * 如果函数返回true，则匹配成功。
     * @method findBy
     * @param {Function} fn 调用的函数。需要两个参数：<ul>
     * <li><b>record</b> : L5.model.Record<p>要过滤的record对象
     * 通过L5.model.Record的get方法获取域的值</p></li>
     * <li><b>id</b> : Object<p>传入的Record对象的ID</p></li>
     * </ul>
     * @param {Object} scope (可选) 函数的作用域(默认是this)
     * @param {Number} startIndex (可选) 开始查找的位置
     * @return {Number} 匹配的索引号或者-1
     */
    
    findBy : function(fn, scope, start){
        return this.data.findIndexBy(fn, scope, start);
    },
    
    /**
     * 从dataset中搜索指定索引的唯一值
     * @method collect
     * @param {String} dataIndex 要搜索的属性
     * @param {Boolean} allowNull (可选) true，可空，undefined或者空值
     * @param {Boolean} bypassFilter (可选) 如果是true，则搜索所有的record对象
     * @return {Array} 唯一值的数组
     * @private
     **/
    collect : function(dataIndex, allowNull, bypassFilter){
        var d = (bypassFilter === true && this.snapshot) ?
                this.snapshot.items : this.data.items;
        var v, sv, r = [], l = {};
        for(var i = 0, len = d.length; i < len; i++){
            v = d[i].data[dataIndex];
            sv = String(v);
            if((allowNull || !L5.isEmpty(v)) && !l[sv]){
                l[sv] = true;
                r[r.length] = v;
            }
        }
        return r;
    },
    
    /**
     * 取消过滤，恢复原来的缓存数据
     * @method clearFilter
     * @param {Boolean} suppressEvent 如果是true，不会通知监听器，直接清除过滤器
     */
    clearFilter : function(suppressEvent){
        if(this.isFiltered()){
            this.data = this.snapshot;
            delete this.snapshot;
            if(suppressEvent !== true){
                this.fireEvent("datachanged", this);
            }
        }
    },

    /**
     * 判断dataset是否设置了过滤器
     * @method isFiltered
     * @private
     * @return {Boolean}
     */
    isFiltered : function(){
        return this.snapshot && this.snapshot != this.data;
    },

    /**
     * 由L5.model.Record触发
     * @method afterEdit
     * @private
     * @param {L5.model.Record} record record对象
     * @param {HTMLElement} srcElement 域
     */
    afterEdit : function(record,srcElement,field){
        if (this.modified.indexOf(record) == -1) {
			if (record.state != L5.model.Record.STATE_NEW) {
				record.state = L5.model.Record.STATE_MODIFIED;
			}
			this.modified.push(record);
		}
		this.fireEvent("update", this, record, L5.model.Record.EDIT, srcElement,field);
    },
    
    /**
     * 由L5.model.Record Record触发
     * @method afterReject
	 * @private
	 * @param {Record} record record对象
	 */
    afterReject : function(record){
		record.state = L5.model.Record.NONE;
		this.modified.remove(record);
		var i = this.indexOf(record);
		if (i >= 0)
			this.fireEvent("update", this, record, L5.model.Record.REJECT);
    },
    
    /**
     * 由L5.model.Record触发
     * @method afterCommit
     * @private
     * @param {Record} record
     */
    afterCommit : function(record){
    	record.state = L5.model.Record.NONE;
		this.modified.remove(record);
		var i = this.indexOf(record);
		if (i >= 0)
			this.fireEvent("update", this, record, L5.model.Record.COMMIT);
    },

    /**
     * 提交所有的更改，将Record的状态恢复
     * @method commitChanges
     */
    commitChanges : function(){
        var m = this.modified.slice(0);
		this.modified = [];
		this.deleted = [];
		for (var i = 0, len = m.length; i < len; i++) {
			m[i].commit();
		}
    },

    /**
	 * 取消对所有Record对象的修改
	 * @method rejectChanges
	 */
    rejectChanges : function() {
		for (var i = 0, len = this.deleted.length; i < len; i++) {
			this.deleted[i].state = L5.model.Record.NONE;
		}
		this.data.addAll(this.deleted);
		this.deleted = [];

		var m = this.modified.slice(0);
		this.modified = [];
		for (var i = 0, len = m.length; i < len; i++) {
			if (m[i].state == L5.model.Record.STATE_NEW) {
				var index = this.data.indexOf(m[i]);
				this.data.removeAt(index);
			} else {
				m[i].reject();
			}
		}
		this.validated = {};
		this.fireEvent("datachanged", this);
	},

	/**
	 * 处理元数据信息被修改事件
	 * @private
	 * @param {Object} meta 元数据信息对象
	 * @param {Object} rtype record对象
	 * @param {Object} o  包含数据的对象
	 */
    onMetaChange : function(meta, rtype, o){
        this.recordType = rtype;
		this.fields = rtype.prototype.fields;
		delete this.snapshot;
		this.sortInfo = meta.sortInfo;
		this.modified = [];
		this.fireEvent('metachange', this, this.reader.meta);
    },

    /**
     * 查找插入的位置
     * @method findInsertIndex
     * @private
     * @param {Record} record
     * @return {String} index
     */
    findInsertIndex : function(record){
        this.suspendEvents();
		var data = this.data.clone();
		this.data.add(record);
		this.applySort();
		var i = this.data.indexOf(record);
		this.data = data;
		this.resumeEvents();
		return i;
    },
    
    /**
     * 打印当前dataset信息
     * @method print
     * @return {String} dataset数据的字符串
     */
    print : function() {
		var count = this.data.items.length;
		var jsonStr = "{totalCount:" + count + ",result:[";
		this.each(function(record, index) {
					jsonStr += "{state :" + record.state + ",";
					L5.each(record.fields.items, function(item, index) {
								if (index != record.fields.items.length - 1)
									jsonStr += item.name + ":"
											+ record.get(item.name) + ",";
								else
									jsonStr += item.name + ":"
											+ record.get(item.name);
							});
					if (index != count - 1)
						jsonStr += "},";
					else
						jsonStr += "}";
				});
		jsonStr += "]}";
		return jsonStr;
	},
	/**
	 * 为某个域增加校验规则
	 * @method addRule
	 * @param {String} name RecordType中的某个域的名称
	 * @param {Boolean} cover 是否需要覆盖原来的rlue
	 */
	addRule : function(name,rules,cover){
		var field = this.fields.get(name);
		field.rule = cover==true ? rules : (field.rule ? field.rule+ "|" +rules : rules);
	},
	/**
	 * 创建Record对象
	 * @method newRecord
	 * @param {Object} object RecordType对象
	 * @return {L5.model.Record} 
	 */
	newRecord : function(obj) {
		if (this.recordType == null) {
			return;
		}
		var record;
		if (obj == null) {
			record = new this.recordType();
			this.add([record]);
		} else {
			record = new (this.recordType)(obj);
			this.add([record]);
		}

		var name = null;
		for (var i = 0; i < record.fields.items.length; i++) {
			if (record.fields.items[i].rule != null) {
				name = record.fields.items[i].name;
				result = L5.Validator.validate(record, name, record.get(name));
			}
		}
		// 为什么不用moveto或movelast,是因为没有fireevent
		this.pos = this.getCount() - 1;
		this.fireEvent("move", this, this.pos);
		return record;
	}
});

/**
 * @ignore
 * 本地分页Dataset
 * @class L5.model.LocalPageDataset
 * @extends L5.model.Dataset
 * @constructor
 * 创建LocalPageDataset对象
 * @param {Object} c config对象，包含dataset访问数据所需要的对象,读取数据到Records对象
 */
L5.model.LocalPageDataset = function(c) {
	L5.model.LocalPageDataset.superclass.constructor.call(this, c);
	this.localPage = true;
};

L5.extend(L5.model.LocalPageDataset, L5.model.Dataset,{   
    
	/**
	 * 增加record对象集合
	 * @method add
	 * @param {L5.model.Record[]} records
	 */
    add : function(records){
        records = [].concat(records);
		if (records.length < 1) {
			return;
		}
		for (var i = 0, len = records.length; i < len; i++) {
			if (this.modified.indexOf(records[i]) == -1) {
				records[i].state = L5.model.Record.STATE_NEW;
				this.modified.push(records[i]);
			}
			records[i].join(this);
		}
		var i = this.data.length;
		this.data.addAll(records);
		if (this.snapshot) {
			this.snapshot.addAll(records);
		}
		this.fireEvent("add", this, records, (i - this.pageInfo.startCursor));// local
																			// page
    },

    /**
     * 在指定位置插入records对象集合
     * @method insert
     * @param {Number} index
     * @param {L5.model.Record[]} records record数组
     */
    insert : function(index, records){  
       	index = index + this.pageInfo.startCursor;// local page
		records = [].concat(records);
		for (var i = 0, len = records.length; i < len; i++) {

			if (this.modified.indexOf(records[i]) == -1) {
				records[i].state = L5.model.Record.STATE_NEW;
				this.modified.push(records[i]);
			}

			this.data.insert(index, records[i]);
			records[i].join(this);
		}
		this.fireEvent("add", this, records,(index - this.pageInfo.startCursor));// local page
    },

    /**
     * 从dataset中移除record对象
     * @method remove
     * @param {L5.model.Record} record record对象
     */
    remove : function(record){
        var index = this.data.indexOf(record);
		this.data.removeAt(index);
		if (this.pruneModifiedRecords) {
			this.modified.remove(record);
			this.deleted.remove(record);
		}
		if (this.snapshot) {
			this.snapshot.remove(record);
		}
		if (this.deleted.indexOf(record) == -1) {
			if (record.state == L5.model.Record.STATE_NEW) {
				this.modified.remove(record);
			} else if (record.state == L5.model.Record.STATE_MODIFIED) {
				record.reject(true);
				this.modified.remove(record);
				record.state = L5.model.Record.STATE_DELETED;
				this.deleted.push(record);

			} else if (record.state == L5.model.Record.NONE) {
				record.state = L5.model.Record.STATE_DELETED;
				this.deleted.push(record);
			}
		}
		this.fireEvent("datachanged", this);// local page
    },
    
    /**
	 * 取消对所有Record对象的修改
	 * @method rejectChanges
	 */
    rejectChanges : function() {
		for (var i = 0, len = this.deleted.length; i < len; i++) {
			this.deleted[i].state = L5.model.Record.NONE;
		}
		this.data.addAll(this.deleted);
		this.deleted = [];

		var m = this.modified.slice(0);
		this.modified = [];
		for (var i = 0, len = m.length; i < len; i++) {
			if (m[i].state == L5.model.Record.STATE_NEW) {
				var index = this.data.indexOf(m[i]);
				this.data.removeAt(index);
			} else {
				m[i].reject();
			}
		}
		this.applySort();
		this.fireEvent("datachanged", this);
	},
	
	/**
     * 获得Record对象在Dataset中的位置
     * @method indexOf
     * @param {L5.model.Record} record 需要查找的L5.model.Record对象
     * @return {Number} record的位置，如果没有找到则返回-1
     */
    indexOf : function(record) {
		return this.data.indexOf(record) - this.pageInfo.startCursor;
	},

    /**
     * 根据Record对象的id得到它的位置
     * @method indexOfId
     * @param {String} id 需要查找的record的id
     * @return {Number} record的位置，如果没有找到则返回-1
     */
    indexOfId : function(id){
        return this.data.indexOfKey(id) - this.pageInfo.startCursor;
    },

    /**
     * 根据索引得到Record对象
     * @method getAt
     * @param {Number} index 需要查找的Record对象的索引
     * @return {L5.model.Record} 根据索引得到的Record对象，如果没有找到则返回undefined
     */
    getAt : function(index){
    	index = this.pageInfo.startCursor + index;
		return this.data.itemAt(index);
    },

    /**
     * 返回指定索引区间的Records集合
     * @method getRange
     * @param {Number} startIndex (可选) 起始位置(默认是0)
     * @param {Number} endIndex (可选) 结束位置(默认是Dataset最后一个Record对象的位置)
     * @return {L5.model.Record[]} Record对象数组
     */
    getRange : function(start, end){
   		start = this.pageInfo.startCursor + start;
		end = this.pageInfo.startCursor + end;
		return this.data.getRange(start, end);
    },

   /**
     * 加载数据
     * @method loadPage
     * @private
     * @param {Object} options 包含加载数据控制参数的对象
     * @return {Boolean}
     */
    loadPage : function(options){
    	this.pos = 0;
		var pn = this.paramNames;
		options = options || {};
		if (this.fireEvent("beforeload", this, options) !== false) {
			this.storeOptions(options);
			var p = L5.apply(options.params || {}, this.baseParams);
			if (this.sortInfo && this.remoteSort) {
				p[pn["sort"]] = this.sortInfo.field;
				p[pn["dir"]] = this.sortInfo.direction;
			}
			this.proxy.load(p, this.reader, this.loadRecords, this, options);
			return true;
		} else {
			return false;
		}
    },

    /**
     * 得到Dataset缓存的记录数，如果是翻页，这可能不是dataset所有的记录
     * @method getCount
     * @return {Number} 缓存的Dataset对象包含的Record记录数
     */
    getCount : function(){
		return Math.min(this.getTotalCount() - this.pageInfo.startCursor, this.pageInfo.pageSize);
    },

    /**
     * 返回从服务器端获得的dataset对象所有的记录数,如果改变了本地的dataset对象，这个值是不会更新的。
     * @method getTotalCount
     * @return {Number} 记录总数
     */
    getTotalCount : function(){
   		return this.data.length;
    },
    
	/**
	 * 翻到指定页
	 * @method turnPage
	 * @param {Number} pageIndex 页号
	 */
	turnPage : function(pageIndex){
		//var pageTotal = this.getTotalPage();
		if (pageIndex < 1) {
			L5.Msg.alert("提示",L5.turnPageFirst ? L5.turnPageFirst : "page num too small");
			return false;
		}
		if(pageIndex > this.getTotalPage()){
			L5.Msg.alert("提示",L5.turnPageLast ? L5.turnPageLast : "page num too large");
			return false;
		}
		this.pageInfo.pageIndex = pageIndex;
		this.pageInfo.startCursor = this.pageInfo.pageSize * (this.pageInfo.pageIndex - 1);
		this.fireEvent("datachanged", this);
		this.fireEvent("turnPage");
	},
	
   /**
     * 查找插入的位置
     * @method findInsertIndex
     * @private
     * @param {Record} record
     * @return {String} index
     */
    findInsertIndex : function(record){
        this.suspendEvents();
		var data = this.data.clone();
		this.data.add(record);
		this.applySort();
		var i = this.data.indexOf(record);
		this.data = data;
		this.resumeEvents();
		i = i - this.pageInfo.startCursor;// local page
		return i;
    }
});