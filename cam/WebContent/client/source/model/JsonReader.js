/**
 * JsonReader是读取Json格式数据的数据解析器，它根据数据记录对象Record构造函数中传入的字段映射关系解析数据，形成记录集。<br>
 * <p>
 * 示例代码：
 * <pre><code>
	var Employee = L5.model.Record.create([
	    {name: 'firstname'},                
	    {name: 'job', mapping: 'occupation'}
	]);
	var myReader = new L5.model.JsonReader({
	    totalProperty: "results",             // dataset的总记录数 (可选)
	    root: "rows",                         // 数据对象，每项都是row对象
	    id: "id"                              // 每个row对象的id，用来作为record的id(可选)
	}, Employee);
	</code></pre>
 * <p>
 * JsonReader的元数据metadata在任何时候都可以修改，只需要在数据对象中包含metaData属性。
 * 另外，在metaData属性中可以包含fields属性，它将作为Record的create方法的参数创建记录对象的构造函数。
 * 使用metaData属性会触发数据集Dataset的metachange事件。
 * JSON对象的格式如下：
 * <pre><code>
	{
	    results: 2,
	    rows: [
	        { id: 1, firstname: 'Bill', occupation: 'Gardener' },         // 一个row对象
	        { id: 2, firstname: 'Ben' , occupation: 'Horticulturalist' }  // 另外一个row对象
	    ]
	}
	</code></pre>
 * <p>如果不用上面例子中的record构造器组织数据，可以参考下面这种方式：
 * </p><pre><code>
	var myReader = new L5.model.JsonReader();
	</code></pre>
 * <p>可以通过metaData属性配置从服务器端获取的数据：
 * </p><pre><code>
	{
	    metaData: {
	        totalProperty: 'results',
	        root: 'rows',
	        id: 'id',
	        fields: [
	            {name: 'name'},
	            {name: 'occupation'}
	        ]
	    },
	    results: 2,
	    rows: [
	        { 'id': 1, 'name': 'Bill', occupation: 'Gardener' },
	        { 'id': 2, 'name': 'Ben', occupation: 'Horticulturalist' }
	    ]
	}
	</code></pre> 
 * @class L5.model.JsonReader
 * @extends L5.model.DataReader
 * @cfg {String} totalProperty 设置表示记录总数的属性名字，这项配置只在分页加载数据时使用，即一次数据加载不读取全部记录，而是在后台服务器端分页。
 * @cfg {String} successProperty 设置表示数据加载成功的属性名字，默认为success
 * @cfg {String} root 设置包含数据对象数组的名字
 * @cfg {String} id 设置数据对象中主键字段的名字
 * @constructor
 * 创建JsonReader对象
 * @param {Object} meta 元数据信息，可以试构造函数中传入的元数据信息，也可能是最近一次在数据对象中出现的metaData信息
 * @param {Object} recordType 或者是域定义对象的数组，或者是Record的create方法的构造器
 */
L5.model.JsonReader = function(meta, recordType) {
	meta = meta || {};
	L5.model.JsonReader.superclass.constructor.call(this, meta, recordType
					|| meta.fields);
};

L5.extend(L5.model.JsonReader, L5.model.DataReader, {

	/**
	 * 仅用于通过数据代理从远程服务器加载数据
	 * @method read
	 * @param {Object} response XMLHttpRequest对象，它的responseText中包含JSON数据
	 * @return {Object} record数据集合
	 */
	read : function(response) {
		var json = response.responseText;
		var o = eval("(" + json + ")");
		if (!o) {
			throw {
				message : "JsonReader.read: Json object not found"
			};
		}
		if (o.error) {
			var e=new L5.Exception(o.error.code, o.error.msg,o.error.trace);
			if(o.error.title){//如果有自定义title，则复制给exception
				e.title=o.error.title;
			}
			throw e;
		}
		return this.readRecords(o);
	},

	/**
	 * 处理元数据信息被修改事件，需要dataset实现的私有函数
	 * @param {Object} meta 元数据信息对象
	 * @param {Object} recordType  record对象
	 * @param {Object} o  包含数据的对象
	 */
	onMetaChange : function(meta, recordType, o) {

	},

	/**
	 * 获得数据
	 * @method simpleAccess
	 * @private
	 */
	simpleAccess : function(obj, subsc) {
		return obj[subsc];
	},

	/**
	 * 解析JSON
	 * @method getJsonAccessor
	 * @private
	 */
	getJsonAccessor : function() {
		var re = /[\[\.]/;
		return function(expr) {
			try {
				return (re.test(expr)) ? new Function("obj", "return obj."
								+ expr) : function(obj) {
					return obj[expr];
				};
			} catch (e) {
			}
			return L5.emptyFn;
		};
	}(),

	/**
	 * 从JSON对象中读取信息创建记录集
	 * @method readRecords
	 * @param {Object} o 数组对象，数组包括root对应的行对象，可选属性，标明dataset总大小的totalProperty属性
	 * @return {Object} record对象集合
	 */
	readRecords : function(o) {
		
		// 数据记载后，没有处理过的JSON数据需要进一步处理。如果没有数据或者有异常，这个属性就是undefined。
		this.jsonData = o;
		if (o.metaData) {
			delete this.ef;
			this.meta = o.metaData;
			if (this.recordType == null && o.metaData.fields) {//caoxm
				this.recordType = L5.model.Record.create(o.metaData.fields);
				this.onMetaChange(this.meta, this.recordType, o);
			} else if (this.recordType != null && o.metaData.fields) {
				var f1 = L5.model.Record.create(o.metaData.fields).prototype.fields;
				var f2 = this.recordType.prototype.fields;
				f1.addAll(f2.items);
				this.recordType.prototype.fields = f1;
				this.onMetaChange(this.meta, this.recordType, o);
			}
		}
		if (!this.recordType) {
			return {
				success : true,
				records : [],
				totalRecords : 0
			};
		}
		var s = this.meta, Record = this.recordType, f = Record.prototype.fields, fi = f.items, fl = f.length;

		//  给totalProperty、root、id和所有的field生成提取函数
		if (!this.ef) {
			if (s.totalProperty) {
				this.getTotal = this.getJsonAccessor(s.totalProperty);
			}
			if (s.successProperty) {
				this.getSuccess = this.getJsonAccessor(s.successProperty);
			}
			this.getRoot = s.root ? this.getJsonAccessor(s.root) : function(p) {
				return p;
			};
			if (s.id) {
				var g = this.getJsonAccessor(s.id);
				this.getId = function(rec) {
					var r = g(rec);
					return (r === undefined || r === "") ? null : r;
				};
			} else {
				this.getId = function() {
					return null;
				};
			}
			this.ef = [];
			for (var i = 0; i < fl; i++) {
				f = fi[i];
				var map = (f.mapping !== undefined && f.mapping !== null)
						? f.mapping
						: f.name;
				this.ef[i] = this.getJsonAccessor(map);
			}
		}

		var root = this.getRoot(o), c = root.length, totalRecords = c, success = true;
		if (s.totalProperty) {
			var v = parseInt(this.getTotal(o), 10);
			if (!isNaN(v)) {
				totalRecords = v;
			}
		}
		if (s.successProperty) {
			var v = this.getSuccess(o);
			if (v === false || v === 'false') {
				success = false;
			}
		}
		var records = [];
		for (var i = 0; i < c; i++) {
			var n = root[i];
			var values = {};
			var id = this.getId(n);
			for (var j = 0; j < fl; j++) {
				f = fi[j];
				var v = this.ef[j](n);
				values[f.name] = f.convert((v !== undefined)
								? v
								: f.defaultValue, n);
			}
			var record = new Record(values, id);
			record.json = n;
			records[i] = record;
		}
		
		return {
			success : success,
			records : records,
			totalRecords : totalRecords,
			customDatas : o.customDatas
		};
	}
});