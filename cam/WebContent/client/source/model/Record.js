/**
 * <p>该类封装了Record定义信息和值，以及一些访问Dataset对象中缓存的Record数据，供L5.model.Dataset对象使用。</p>
 * <p>该类的构造器通过传递域定义的数组给create方法产生。在处理没有格式化的数据对象时，实例对象通常由L5.model.Reader
 * 的实现类创建。</p>
 * <p>在创建Record对象时，可以不用构造函数，直接用create方法即可，两者的参数是相同的。</p>
 * @class L5.model.Record 
 * @param {Array} data 提供要创建的Record对象的域信息
 * @param {Object} id (可选) Record的id，必须是唯一的，在Dataset中通过id可以操作对应的Record对象，如果没有指定，会自动生成整型的id
 */
L5.model.Record = function(data, id){
    this.id = (id || id === 0) ? id : ++L5.model.Record.AUTO_ID;
    this.data = data;
    this.state = L5.model.Record.NONE;
    //handle default value
    if (this.data == null)
		this.data = {};
	for (var i = 0; i < this.fields.items.length; i++) {
		var item = this.fields.items[i];
		if (this.data[item.name]||this.data[item.name]===0)//value maybe int'0
			continue;
		var dv = item.defaultValue;
		if (!dv)
			dv = "";
		var val = item.convert(dv);
		this.data[item.name] = val;
	}
	this.validate={};
	this.msg = {};
	this.msgLable = {};
	this.msgIndex = {};
};

/**
 * 构造Record对象
 * @method create
 * @param {Array} o 定义域名称，数据类型和mapping，其中mapping是Reader从数据对象中解析域的值时使用
 * @return {function} 根据定义创建Record对象的构造函数
 */
L5.model.Record.create = function(o){
    var f = L5.extend(L5.model.Record, {});
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
    return f;
};
/**
 * record的自动生成id的起始值
 */
L5.model.Record.AUTO_ID = 1000;
/**
 * record的编辑操作
 */
L5.model.Record.EDIT = 'edit';
/**
 * record的取消操作
 */
L5.model.Record.REJECT = 'reject';
/**
 * record的提交操作
 */
L5.model.Record.COMMIT = 'commit';


/**
 * record的编辑状态：无状态
 */
L5.model.Record.NONE = 0;
/**
 * record的编辑状态：新建状态
 */
L5.model.Record.STATE_NEW = 1;
/**
 * record的编辑状态：修改状态
 */
L5.model.Record.STATE_MODIFIED = 3;
/**
 * record的编辑状态：删除状态
 */
L5.model.Record.STATE_DELETED = 2;

L5.model.Record.prototype = {
    /**
     * Record的域信息(L5.model.Field)集合，只读
     * @property fields
     * @type L5.util.MixedCollection
     */
	
    /**
     * 展现Record数据的对象哈希表，定义每一个域的信息，除非你指定域的id，否则不会包含id属性
     * @property data
     * @type {Object}
     */
	
    /**
     * 创建对象时指定的唯一标识
     * @property id
     * @type {Object}
     */
	
    /**
     * 只读标志 - 如果Record更改值为true
     * @property dirty
     * @type Boolean
     */
    dirty : false,
    editing : false,
    error: null,
    /**
     * 存储所有修改的域的键值对，如果没有域被修改，则为null
     * @property modified
     * @type {Object}
     */
    modified: null,
    
    validate : null,
    msg : null,
    msgLable : null,

    /**
     * dataset修改后更新
     * @method join
     * @private
     * @param {Object} ds dataset的id
     */
    join : function(ds){
        this.dataset = ds;
    },
    /**
     * 将record数据转换成指定的JavaBean类型的L5.DataBean对象。
     * 示例代码：var bean = record.toBean("org.loushang.demo.Cust");
     * @method toBean
     * @param {String} clazz 完整的JavaBean类名
     * @return {L5.DataBean} DataBean对象
     */
    toBean : function(clazz){
    	var bean = new L5.DataBean(clazz);
		var data = this.data;
		// 直接用他的data而不是重新赋值是不是要好点?
		for (name in data) {
			if (data[name] == "")
				bean[name] = undefined;
			else
				bean[name] = data[name];
		}
		bean.state = this.state;
		return bean;
    },
    /**
     * 将record对象转换为Json字符串
     * @method toJsonString
     * @return {String} json字符串
     */
    toJsonString : function(){
    	var obj = new Object();
		// obj.javaClass="org.loushang.next.data.Record";
		obj.javaClass = "Record";// short name
		obj.id = this.id;
		obj.state = this.state;
		obj.data = this.data;
		return L5.encode(obj);
    },

    /**
     * 给域赋值
     * @method set
     * @private
     * @param {String} name 域名称
     * @param {Object} value 域的值
     */
    set : function(name, value,srcElement){
    	var result = true;
    	var field = this.fields.get(name);
    	if(field==null){
    		L5.Msg.alert("提示",name+" is undefine in model");
    		return;
    	}
        if(String(this.data[name]) == String(value)){
        	for(var i=0;i<this.fields.items.length;i++){
        		if(this.fields.items[i].rule!=null){
        			return L5.Validator.validate(this, name, value);
        		}
        	}
        	return true;
        } else {
	        value=field.convert(value);//convert value because of formbinding
	        this.dirty = true;
	        if(!this.modified){
	            this.modified = {};
	        }
	        if(typeof this.modified[name] == 'undefined'){
	            this.modified[name] = this.data[name];
	        }
	        this.data[name] = value;
	        if(!this.editing && this.dataset){
	            this.dataset.afterEdit(this,srcElement,name);
	        }
        }
        
        for(var i=0;i<this.fields.items.length;i++){
    		if(this.fields.items[i].rule!=null){
    			result = L5.Validator.validate(this, name, value);
    			break;
    		}
    	}
        
        return result;
    },
    /**
     * 得到域的值
     * @method get
     * @private
     * @param {String} name 域名称
     * @return {Object} 域的值
     */
    get : function(name){
        return this.data[name];
    },

    /**
     * 进入编辑状态
     * @method beginEdit
     * @private
     */
    beginEdit : function(){
        this.editing = true;
        this.modified = {};
    },

    /**
     * 取消当前编辑操作的改变
     * @method cancelEdit
     * @private
     */
    cancelEdit : function(){
        this.editing = false;
        delete this.modified;
    },

    /**
     * 停止编辑，如果任何数据改了，会通知dataset对象
     * @method endEdit
     * @private
     */
    endEdit : function(){
        this.editing = false;
        if(this.dirty && this.dataset){
            this.dataset.afterEdit(this);
        }
    },

    /**
     * 通常由Record所属的Dataset对象调用，撤销所有的修改，修改过的域会还原到原来的值
     * 开发人员应该订阅L5.model.Dataset的update事件，可以执行撤销操作
     * @method reject
     * @private
     * @param {Boolean} silent (可选) 默认是false，如果是true，会忽略它所属的dataset对象的变化
     */
    reject : function(silent){
        var m = this.modified;
        for(var n in m){
            if(typeof m[n] != "function"){
                this.data[n] = m[n];
            }
        }
        this.dirty = false;
        delete this.modified;
        this.editing = false;
        if(this.dataset && silent !== true){
            this.dataset.afterReject(this);
        }
    },

    /**
     * 通常由Record所属的dataset对象调用，提交所有的修改。开发人员应该订阅L5.model.Dataset的update事件，可以执行提交操作
     * @method commit
     * @private
     * @param {Boolean} silent (可选) 默认是false，如果是true，会忽略它所属的dataset对象的变化
     */
    commit : function(silent){
        this.dirty = false;
        delete this.modified;
        this.editing = false;
        if(this.dataset && silent !== true){
            this.dataset.afterCommit(this);
        }
    },

    /**
     * 获得record创建或者提交后所有修改过的域的值集合
     * @method getChanges
     * @private
     * @return {Object} 域的值
     */
    getChanges : function(){
        var m = this.modified, cs = {};
        for(var n in m){
            if(m.hasOwnProperty(n)){
                cs[n] = this.data[n];
            }
        }
        return cs;
    },

    /**
     * 是否有错误信息
     * @method hasError
     * @private
     * @return {Boolean} true或者false
     */
    hasError : function(){
        return this.error != null;
    },

    /**
     * 清除错误信息
     * @method clearError
     * @private
     */
    clearError : function(){
        this.error = null;
    },

    /**
     * 创建并复制Record对象
     * @method copy
     * @param {String} id (可选) 如果你不想用当前Record的id可以提供一个新的id
     * @return {Record} record对象
     */
    copy : function(id) {
        return new this.constructor(L5.apply({}, this.data), id || this.id+'copy');
    },

    /**
     * 如果在dataset加载或者上次提交后域的值改变了则返回true
     * @method isModified
     * @private
     * @param {String} name 域名称
     * @return {Boolean} true或者false
     */
    isModified : function(name){
        return !!(this.modified && this.modified.hasOwnProperty(name));
    },
    
    /**
     * 校验Record是否合法
     * @method validateRecord
     * @param {Boolean} ifdes 是否获取域的描述信息
     * @param {Boolean} ifall 是否一次将record的错误信息返回
     * @return {String/Boolean} 验证通过返回true，否则返回错误信息。
     */
    validateRecord : function(ifdes,ifall){
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
    	var str = this.getErrMsg(ifdes,ifall);
    	if(str){
    		return str;
    	} else {
    		return true;
    	}
    },
    
    /**
     * 获取错误信息
     * @method getErrMsg
     * @private
     * @param {Boolean} ifdes 是否获取域的描述信息
     * @param {Boolean} ifall 是否一次将record的错误信息返回
     * @return {String} 错误信息
     */
    getErrMsg : function(ifdes,ifall){
    	if(ifdes==undefined){
    		ifdes = true;
    	}
    	var allmsgs="";
    	if(this.msgIndex==undefined){
    		this.msgIndex = {};
    	}
    	if(this.msgLable==undefined){
    		this.msgLable = {};
    	}
    	if(this.msg==undefined){
    		this.msg = {};
    	}
    	var msgIndexCount = this.msgIndex["msg_index_"]==undefined ? 0 : this.msgIndex["msg_index_"]+1;
    	var lastItems = new Array();
    	if(msgIndexCount<=this.fields.items.length){
    		for(var i=0; i<this.fields.items.length; i++){
    			var field =  this.fields.items[i].name;
    			var has = false;
    			for(var k=0;k<msgIndexCount;k++){
    				if(this.msgIndex[k] == field){
    					has = true;
    					break;
    				}
    			}
    			if(!has){
    				lastItems[lastItems.length] = field;
    			}
    		}
    	}
    	if(ifall){//如果是全部信息，则不每次遇到不合格的就返回，而是累加起来，一起返回。
//    		for(var v in this.validate){
			//	if(this.validate[v] === false){
					for(var i=0; i<this.fields.items.length; i++){
						var v = this.msgIndex[i] ? this.msgIndex[i] : lastItems.pop();
						if(this.validate[v] === false){
							if(this.msgLable[v] == null){
								this.msgLable[v] = v;
							}
							if(ifdes){//此处grid其实已经将错误信息塞到了record里，只需根据ifgrid取出来
								if(this.cellLable&&this.cellLable[v])//如果是grid-cell校验则取cellLable的值
								   allmsgs+=this.cellLable[v] + this.msg[v]+"!\n";
								else{
									allmsgs+=this.msgLable[v] + this.msg[v]+"!\n";
								}
							}
	                    	else
	                    		   allmsgs+=this.msgLable[v] + this.msg[v]+"!\n";
						}
					}
				//}
			//}
    	}else{
    		//for(var v in this.validate){
			//	if(this.validate[v] === false){
					for(var i=0; i<this.fields.items.length; i++){
						var v = this.msgIndex[i] ? this.msgIndex[i] : lastItems.pop();
						if(this.validate[v] === false){
							if(this.msgLable[v] == null){
								this.msgLable[v] = v;
							}
							if(ifdes){//此处grid其实已经将错误信息塞到了record里，只需根据ifgrid取出来
								if(this.cellLable&&this.cellLable[v]){//如果是grid-cell校验则取cellLable的值
									return this.cellLable[v] + this.msg[v]+"!";
								}
								else{
									return this.msgLable[v] + this.msg[v]+"!";
								}
							}
	                    	else
	                    		return this.msgLable[v] + this.msg[v]+"!";
						}
					}
			//	}
			//}
    	}
//    	if(allmsgs.charAt(allmsgs.length - 1)===","){//去掉最后一个逗号
//    		allmsgs=allmsgs.substring(0,allmsgs.length-1);
//    	}
		return allmsgs;
	}
};