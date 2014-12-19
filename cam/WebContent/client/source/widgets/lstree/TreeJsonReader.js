/**
 * @class L5.model.JsonReader
 * @extends L5.model.DataReader
 * Data reader class to create an Array of {@link L5.model.Record} objects from a JSON response
 * based on mappings in a provided {@link L5.model.Record} constructor.<br>
 * <p>
 * Example code:
 * <pre><code>
var Employee = L5.model.Record.create({
	name : 'employee',
	idField : 'empId',
	fields :[
    {name: 'firstname'},                  // Map the Record's "firstname" field to the row object's key of the same name
    {name: 'job', mapping: 'occupation'}  // Map the "job" field to the row object's "occupation" key
]});
var myReader = new L5.model.JsonReader({
    totalProperty: "results",             // The property which contains the total dataset size (optional)
    root: "rows",                         // The property which contains an Array of row objects
    id: "id"                              // The property within each row object that provides an ID for the record (optional)
}, Employee);
</code></pre>
 * <p>
 * This would consume a JSON object of the form:
 * <pre><code>
{
    results: 2,
    rows: [
        { id: 1, firstname: 'Bill', occupation: 'Gardener' },         // a row object
        { id: 2, firstname: 'Ben' , occupation: 'Horticulturalist' }  // another row object
    ]
}
</code></pre>
 * <p>It is possible to change a JsonReader's metadata at any time by including a
 * <b><tt>metaData</tt></b> property in the data object. If this is detected in the
 * object, a {@link L5.model.Dataset Dataset} object using this Reader will reconfigure
 * itself to use the newly provided field definition and fire its
 * {@link L5.model.Dataset#metachange metachange} event. In
 * undergoing this change, the Dataset sets its {@link L5.model.Dataset#sortInfo sortInfo} property
 * from the <tt>sortInfo</tt> property in the new metadata. Note that reconfiguring a Dataset
 * potentially invalidates objects which may refer to Fields or Records which no longer exist.</p>
 *
 * <p>The <b><tt>metaData</tt></b> property may contain any of the configuration
 * options for this class. Additionally, it may contain a <b><tt>fields</tt></b>
 * property which the JsonReader will use as an argument to {@link L5.model.Record#create}
 * to configure the layout of the Records which it will produce.<p>
 * Using the <b><tt>metaData</tt></b> property, and the Dataset's {@link L5.model.Dataset#metachange metachange} event,
 * it is possible to have a Dataset-driven control initialize itself. The metachange
 * event handler may interrogate the <b><tt>metaData</tt></b> property (which
 * may contain any user-defined properties needed) and the <b><tt>metaData.fields</tt></b>
 * property to perform any configuration required.</p>
 *
 * <p>To use this facility to send the same data as the above example without
 * having to code the creation of the Record constructor, you would create the
 * JsonReader like this:</p><pre><code>
var myReader = new L5.model.JsonReader();
</code></pre>
 * <p>The first data packet from the server would configure the reader by
 * containing a metaData property as well as the data:</p><pre><code>
{
    metaData: {
        totalProperty: 'results',
        root: 'rows',
        id: 'id',
        recordType : {
	        name:'stru',
	        idField : 'struId',
	        fields: [
	            {name: 'name'},
	            {name: 'occupation'}
	        ]
        }
    },
    results: 2,
    rows: [
        { 'id': 1, 'name': 'Bill', occupation: 'Gardener' },
        { 'id': 2, 'name': 'Ben', occupation: 'Horticulturalist' }
    ]
}
可以有如下的配置
{
    metaData: {
        totalProperty: 'results',
        root: 'rows',
        id: 'id',
        recordType : 'stru',
    },
    results: 2,
    rows: [
        { 'id': 1, 'name': 'Bill', occupation: 'Gardener' },
        { 'id': 2, 'name': 'Ben', occupation: 'Horticulturalist' }
    ]
}
</code></pre>
 * 
 * 为了方便处理加载后的record处理子节点,添加了record解析时的回调函数
 * 
 * @cfg {String} totalProperty Name of the property from which to retrieve the total number of records
 * in the dataset. This is only needed if the whole dataset is not passed in one go, but is being
 * paged from the remote server.
 * @cfg {String} successProperty Name of the property from which to retrieve the success attribute used by forms.
 * @cfg {String} root name of the property which contains the Array of row objects.
 * @cfg {String} id Name of the property within a row object that contains a record identifier value.
 * @constructor
 * Create a new JsonReader
 * @param {Object} meta Metadata configuration options.
 * @param {Object} recordType Either an Array of field definition objects as passed to
 * {@link L5.model.Record#create}, or a {@link L5.model.Record Record} constructor created using {@link L5.model.Record#create}.
 */
L5.tree.JsonReader = function(meta,recordType,filt,responseKey){//filt用于过滤数据,形如function filter(record){return true}
    meta = meta || {root:'rows',totalProperty:'total',successProperty:'success',id:'id'};
	recordType = recordType || meta.recordType;
	if(typeof recordType == 'string'){
		recordType = L5.tree.TreeRecord.recordTypes[recordType];
	}
	recordType = recordType.getField ? recordType : L5.tree.TreeRecord.create(recordType);
	
	this.idKey = recordType.idField;
	this.filter = this.getFilterFun(filt||L5.emptyFn);
	
	this.responseKey = false;
	if(responseKey){//一个cmd返回多个dataset时使用此键获取值
		this.responseKey = responseKey;
	} 
    L5.tree.JsonReader.superclass.constructor.call(this, meta, recordType);
};
L5.extend(L5.tree.JsonReader, L5.model.DataReader, {
    /**
     * 为了方便处理加载后的record处理子节点，添加了record解析时的回调函数
     * 
     * This JsonReader's metadata as passed to the constructor, or as passed in
     * the last data packet's <b><tt>metaData</tt></b> property.
     * @type Mixed
     * @property meta
     */
    /**
     * This method is only used by a DataProxy which has retrieved data from a remote server.
     * @param {Object} response The XHR object which contains the JSON data in its responseText.
     * @return {Object} data A data block which is used by an L5.model.Dataset object as
     * a cache of L5.model.Records.
     */
    read : function(response,recordcallback,scope,opt){
        var json = response.responseText;
        var o = eval("("+json+")");
        if(!o) {
            throw {message: "JsonReader.read: Json object not found"};
        }
        if(o.error){//判断是否有后台SystemException异常
			var e=new L5.Exception(o.error.code, o.error.msg,o.error.trace);
			if(o.error.title){//如果有自定义title，则复制给exception
				e.title=o.error.title;
			}
			throw e;	
		}
		if(this.responseKey){
			o = o.map[this.responseKey];
		}
        return this.readRecords(o,recordcallback,scope,opt);
    },

    // private function a dataset will implement
    onMetaChange : function(meta, recordType, o){

    },

	/**
	 * 生成reader的过滤函数
	 * 解析record时使用此函数过滤数据
	 * @param {Object} filt
	 */
	getFilterFun : function(filt){
		filt = filt || L5.emptyFn;
		if(typeof filt == 'string'){
			var filtKey = filt.split(':');
			filt = function(record){
				var key = this.filtKey[0];
				var vls = this.filtKey[1];
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
		}
		return filt;
	},
	
    /**
	 * @ignore
	 */
    simpleAccess: function(obj, subsc) {
    	return obj[subsc];
    },

	/**
	 * @ignore
	 */
    getJsonAccessor: function(){
        var re = /[\[\.]/;
        return function(expr) {
            try {
                return(re.test(expr))
                    ? new Function("obj", "return obj." + expr)
                    : function(obj){
                        return obj[expr];
                    };
            } catch(e){}
            return L5.emptyFn;
        };
    }(),

    /**
     * 为了方便处理加载后的record处理子节点，添加了record解析时的回调函数
     * 
     * Create a data block containing L5.model.Records from a JSON object.
     * @param {Object} o An object which contains an Array of row objects in the property specified
     * in the config as 'root, and optionally a property, specified in the config as 'totalProperty'
     * which contains the total size of the dataset.
     * @return {Object} data A data block which is used by an L5.model.Dataset object as
     * a cache of L5.model.Records.
     */
    readRecords : function(o,recordcallback,scope,opt){
        /**
         * After any data loads, the raw JSON data is available for further custom processing.  If no data is
         * loaded or there is a load exception this property will be undefined.
         * @type Object
         */
        this.jsonData = o;
        if(o.metaData){
            delete this.ef;
            this.meta = o.metaData;
            if(this.recordType==null&&o.metaData.fields){//caoxm
            	this.recordType = L5.tree.TreeRecord.create(o.metaData.name,o.metaData.fields);
            	this.onMetaChange(this.meta, this.recordType, o);
            }            
        }
        var s = this.meta, Record = this.recordType,
            f = Record.prototype.fields, fi = f.items, fl = f.length;

//      Generate extraction functions for the totalProperty, the root, the id, and for each field
        if (!this.ef) {
            if(s.totalProperty) {
	            this.getTotal = this.getJsonAccessor(s.totalProperty);
	        }
	        if(s.successProperty) {
	            this.getSuccess = this.getJsonAccessor(s.successProperty);
	        }
	        this.getRoot = s.root ? this.getJsonAccessor(s.root) : function(p){return p;};
	        if (s.id) {
	        	var g = this.getJsonAccessor(s.id);
	        	this.getId = function(rec) {
					if(this.idKey){
						return rec[this.idKey];
					}
	        		var r = g(rec);
		        	return (r === undefined || r === "") ? null : r;
	        	};
	        } else {
	        	this.getId = function(rec){
					if(this.idKey){
						return rec[this.idKey];
					}
					return null;
				};
	        }
            this.ef = [];
            for(var i = 0; i < fl; i++){
                f = fi[i];
                var map = (f.mapping !== undefined && f.mapping !== null) ? f.mapping : f.name;
                this.ef[i] = this.getJsonAccessor(map);
            }
        }

    	var root = this.getRoot(o), c = root.length, totalRecords = c, success = true;
    	if(s.totalProperty){
            var v = parseInt(this.getTotal(o), 10);
            if(!isNaN(v)){
                totalRecords = v;
            }
        }
        if(s.successProperty){
            var v = this.getSuccess(o);
            if(v === false || v === 'false'){
                success = false;
            }
        }
		var ignore = 0;
        var records = [];
		
	    for(var i = 0; i < c; i++){
		    var n = root[i];
	        var values = {};
	        var id = this.getId(n);
	        for(var j = 0; j < fl; j++){
	            f = fi[j];
                var v = this.ef[j](n);
                values[f.name] = f.convert((v !== undefined) ? v : f.defaultValue, n);
	        }
	        var record = new Record(values, id);
			if(this.filter(record)===true){//过滤数据
				ignore++;
				continue;
			}
	        records[i] = record;
			//回调
			if(recordcallback){
				if(scope){
					recordcallback.call(scope,record,n,s,opt);
				}else{
					recordcallback(record,n,s,opt);
				}
			}
	    }
	    return {
	        success : success,
	        records : records,
	        totalRecords : totalRecords,
			filterNum : ignore
	    };
    },
    parseRecords : function(collection,recordcallback,scope,opt){
        var Record = this.recordType,
            f = Record.prototype.fields, fi = f.items, fl = f.length;
    	var root = collection, c = root.getCount(), totalRecords = c, success = true;
        var records = [];
		
	    for(var i = 0; i < c; i++){
		    var n = root.get(i);
	        var values = {};
	        var id = this.idKey?n.get(this.idKey):undefinded;
	        for(var j = 0; j < fl; j++){
	        	f = fi[j];
                var map = (f.mapping !== undefined && f.mapping !== null) ? f.mapping : f.name;
                var v = n.get(map);
                values[f.name] = f.convert((v !== undefined) ? v : f.defaultValue, n);
	        }
	        var record = new Record(values, id);
	        records[i] = record;
			//回调
			if(recordcallback){
				if(scope){
					recordcallback.call(scope,record,n,this.meta,opt);
				}else{
					recordcallback(record,n,this.meta,opt);
				}
			}
	    }
	    return {
	        success : success,
	        records : records,
	        totalRecords : totalRecords,
			filterNum : 0
	    };
    }
});