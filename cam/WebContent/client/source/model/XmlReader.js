/**
 * 从XML文档创建数组类型的record对象，需要注意的是，HTTP 响应头的Content-Type必须设置为"text/xml" 或者 "application/xml"
 * <p>
	 * 示例代码：
	 * <pre><code>
	var Employee = L5.model.Record.create([
	   {name: 'name', mapping: 'name'},     // 如果跟name属性相同，可以不用设置mapping属性
	   {name: 'occupation'}                 
	]);
	var myReader = new L5.model.XmlReader({
	   totalRecords: "results", // dataset中record记录条数 (可选)
	   record: "row",           // 重复元素名称，包含行信息
	   id: "id"                 // record的id(可选)
	}, Employee);
	</code></pre>
	 * <p>
	 * 返回的XML类似下面：
	 * <pre><code>
	&lt;?xml version="1.0" encoding="UTF-8"?>
	&lt;dataset>
	 &lt;results>2&lt;/results>
	 &lt;row>
	   &lt;id>1&lt;/id>
	   &lt;name>Bill&lt;/name>
	   &lt;occupation>Gardener&lt;/occupation>
	 &lt;/row>
	 &lt;row>
	   &lt;id>2&lt;/id>
	   &lt;name>Ben&lt;/name>
	   &lt;occupation>Horticulturalist&lt;/occupation>
	 &lt;/row>
	&lt;/dataset>
	</code></pre>
 * @class L5.model.XmlReader
 * @extends L5.model.DataReader
 * @cfg {String} totalRecords DomQuery路径，可以通过这个属性得到record总记录数
 * @cfg {String} record DomQuery路径，包含record信息的重复元素名称
 * @cfg {String} success DomQuery路径，success属性
 * @cfg {String} id 包含记录主键元素的DomQuery路径
 * @constructor
 * 创建XmlReader对象
 * @param {Object} meta 配置参数元数据
 * @param {Object} recordType 域定义数组，或者是L5.model.Record的create方法创建的record构造对象
 */
L5.model.XmlReader = function(meta, recordType){
    meta = meta || {};
    L5.model.XmlReader.superclass.constructor.call(this, meta, recordType || meta.fields);
};
L5.extend(L5.model.XmlReader, L5.model.DataReader, {
    /**
     * DataProxy使用这个方法从远程服务器端获得数据
     * @method read
	 * @param {Object} response XMLHttpRequest对象，包含解析的XML文档。该对象需要包含一个名为responseXML的属性，指向XML文档对象
     * @return {Object} records对象
     */
    read : function(response){
        var doc = response.responseXML;
        if(!doc) {
            throw {message: "XmlReader.read: XML Document not available"};
        }
        return this.readRecords(doc);
    },

    /**
     * 从XML文档创建dataset记录集
     * @method readRecords
     * @private
	 * @param {Object} doc 解析的XML文档
     * @return {Object} 构造dataset的Record对象需要的数据
     */
    readRecords : function(doc){
        /**
         * 待处理的XML文档
         * @property xmlData
         * @private   
         * @type XMLDocument
         */
        this.xmlData = doc;
        var root = doc.documentElement || doc;
    	var q = L5.DomQuery;
    	var recordType = this.recordType, fields = recordType.prototype.fields;
    	var sid = this.meta.id;
    	var totalRecords = 0, success = true;
    	if(this.meta.totalRecords){
    	    totalRecords = q.selectNumber(this.meta.totalRecords, root, 0);
    	}

        if(this.meta.success){
            var sv = q.selectValue(this.meta.success, root, true);
            success = sv !== false && sv !== 'false';
    	}
    	var records = [];
    	var ns = q.select(this.meta.record, root);
        for(var i = 0, len = ns.length; i < len; i++) {
	        var n = ns[i];
	        var values = {};
	        var id = sid ? q.selectValue(sid, n) : undefined;
	        for(var j = 0, jlen = fields.length; j < jlen; j++){
	            var f = fields.items[j];
                var v = q.selectValue(f.mapping || f.name, n, f.defaultValue);
	            v = f.convert(v, n);
	            values[f.name] = v;
	        }
	        var record = new recordType(values, id);
	        record.node = n;
	        records[records.length] = record;
	    }

	    return {
	        success : success,
	        records : records,
	        totalRecords : totalRecords || records.length
	    };
    }
});