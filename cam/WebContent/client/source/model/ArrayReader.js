/**
 * 数据读取器，通过传入的数组对象构建L5.model.Record对象，数组的每个元素都是域的一行
 * <p>
 * 例子代码：
 * <pre><code>
		var Employee = L5.model.Record.create([
		    {name: 'name', mapping: 1},    
		    {name: 'occupation', mapping: 2}
		]);
		var myReader = new L5.model.ArrayReader({
		    id: 0                     // 唯一标识(可选)
		}, Employee);
   </code></pre>
 * <p>
 * 数组定义格式可能是下面这样：
 * <pre><code>
	[ [1, 'Bill', 'Gardener'], [2, 'Ben', 'Horticulturalist'] ]
	  </code></pre>
 * @class L5.model.ArrayReader
 * @extends L5.model.JsonReader
 * @constructor
 * 创建新的ArrayReader对象
 * @param {Object} meta 配置项元数据
 * @param {Object} recordType 在L5.model.Record的create方法中指定的域对象数组
 */
L5.model.ArrayReader = L5.extend(L5.model.JsonReader, {
    /**
     * 创建数据块，包含由数组创建的Record对象
     * @method readRecords
     * @param {Object} o 数组格式的数据
     * @return {Object} data数据块
     */
    readRecords : function(o){
        var sid = this.meta ? this.meta.id : null;
    	var recordType = this.recordType, fields = recordType.prototype.fields;
    	var records = [];
    	var root = o;
	    for(var i = 0; i < root.length; i++){
		    var n = root[i];
	        var values = {};
	        var id = ((sid || sid === 0) && n[sid] !== undefined && n[sid] !== "" ? n[sid] : null);
	        for(var j = 0, jlen = fields.length; j < jlen; j++){
                var f = fields.items[j];
                var k = f.mapping !== undefined && f.mapping !== null ? f.mapping : j;
                var v = n[k] !== undefined ? n[k] : f.defaultValue;
                v = f.convert(v, n);
                values[f.name] = v;
            }
	        var record = new recordType(values, id);
	        record.json = n;
	        records[records.length] = record;
	    }
	    return {
	        records : records,
	        totalRecords : records.length
	    };
    }
});