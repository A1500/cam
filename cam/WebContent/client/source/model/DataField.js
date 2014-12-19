/**
 * <p>该类封装了域的定义信息，域定义在L5.model.Record的create方法中作为参数使用
 * 开发人员不需要实例化该类，实例由L5.model.Record.create创建并缓存在L5.model.Record的fields属性中</p>
 * @class L5.model.Field
 * @constructor
 * @param {Object} config 参数信息
*/
L5.model.Field = function(config){
    if(typeof config == "string"){
        config = {name: config};
    }
    L5.apply(this, config);
    
    if(!this.type){
        this.type = "auto";
    }
    
    var st = L5.model.SortTypes;
    
    if(typeof this.sortType == "string"){
        this.sortType = st[this.sortType];
    }
    
    // 给string和date类型设置默认的sortType
    if(!this.sortType){
        switch(this.type){
            case "string":
                this.sortType = st.asUCString;
                break;
            case "date":
                this.sortType = st.asDate;
                break;
            default:
                this.sortType = st.none;
        }
    }

    var stripRe = /[\$,%]/g;

    // 预先转换域的函数，而不是每次读取值时都要转换
    if(!this.convert){
        var cv, dateFormat = this.dateFormat;
        switch(this.type){
            case "":
            case "auto":
            case undefined:
                cv = function(v){ return v; };
                break;
            case "string":
                cv = function(v){ return (v === undefined || v === null) ? '' : String(v); };
                break;
            case "int":
                cv = function(v){
                    return v !== undefined && v !== null && v !== '' ?
                           parseInt(String(v).replace(stripRe, ""), 10) : '';
                    };
                break;
            case "file":
                cv = function(v){
                    	return v !== undefined && v !== null && v !== '' ?new L5.UploadFile(v):new L5.UploadFile(this.name);
                    };
                break;
            case "float":
                cv = function(v){
                    return v !== undefined && v !== null && v !== '' ?
                           parseFloat(String(v).replace(stripRe, ""), 10) : ''; 
                    };
                break;
            case "bool":
            case "boolean":
                cv = function(v){ return v === true || v === "true" || v == 1; };
                break;
            case "date":
                cv = function(v){
                    if(!v){
                        return '';
                    }
                    if(L5.isDate(v)){
                    	if(dateFormat&&(!v.formatstr))v.formatstr=dateFormat;
                        return v;
                    }
                    if(v.javaClass&&v.time){
                    	var o=new Date(v.time);
                    	if(dateFormat)o.formatstr=dateFormat;
                    	return o
                    }
                    if(dateFormat){
                        if(dateFormat == "timestamp"){
                        	var o=new Date(v*1000);
                    		if(dateFormat)o.formatstr=dateFormat;
                            return o;
                        }
                        if(dateFormat == "time"){
                       		var o=new Date(parseInt(v, 10));
                    		if(dateFormat)o.formatstr=dateFormat;
                            return o;
                        }
                        return Date.parseDate(v, dateFormat);
                    }
                    var parsed = Date.parse(v);
                    return parsed ? new Date(parsed) : null;
                };
             break;
            
        }
        this.convert = cv;
    }
};

L5.model.Field.prototype = {
    /**
     * @cfg {String} name 在Record对象中会通过name属性引用该域
     */
	
    /**
     * @cfg {String} type (可选) 数据类型，可能的值有：<ul><li>auto (默认)</li><li>string</li><li>int</li><li>float</li><li>boolean</li><li>date</li></ul>
     */
	
    /**
     * @cfg {Function} convert (可选) 转换值为对象的函数。需要的参数：<ul><li><b>v</b> : Mixed<div>Reader读取的数据值</div></li><li><b>rec</b> : Mixed<div>Reader读取的包含行的数据对象，跟Reader的类型有关，可以数组，对象或者XML</div></li></ul>
     */
	
    /**
     * @cfg {String} dateFormat (可选) Date.parseDate函数调用的格式串，如果Reader提供的值是"timestamp"，那么它是一个UNIX timestamp，如果Reader提供的值时"time"，那么它是一个JavaScript的timestamp
     */
    dateFormat: null,
    /**
     * @cfg {Mixed} defaultValue (可选) 默认值，默认是""
     */
    defaultValue: "",
    /**
     * @cfg {String} mapping (可选) 从数据对象中读取值时用的路径。如果是JsonReader，它是一个字符串，如果是XmlReader，它是一个L5.DomQuery路径，如果mapping表达式跟域的名称相同，可以忽略
     */
    mapping: null,
    /**
     * @cfg {Function} sortType (可选) 可将一个域的值转换为一个可比较的值的函数，以保证正确的排序。L5.model.SortTypes中已经有预定义函数。
     */
    sortType : null,
    /**
     * @cfg {String} sortDir (可选)排列顺序的初始值，"ASC" or "DESC"
     * @default "ASC"
     */
    sortDir : "ASC"
};