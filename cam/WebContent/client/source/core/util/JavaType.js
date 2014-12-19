/**
 * 模拟后台的DataBean
 * @class L5.DataBean
 * @constructor
 */
L5.DataBean = function(classname) {
	this.javaClass = classname;
};

/**
 * 文件上传
 * @class L5.UploadFile
 * @constructor
 * @param {String} filename 上传文件
 */
L5.UploadFile = function(filename) {
	this.javaClass = "org.loushang.next.upload.UploadFile";
	this.filename = filename;
};

/**
 * 把上传类和文件名称转换为Json字符串
 * @method toJsonString
 * @private
 * @return {String} Json字符串
 */
L5.UploadFile.prototype.toJsonString = function() {
	var obj = new Object();
	// obj.javaClass="java.sql.Date";
	obj.javaClass = this.javaClass; // short name
	obj.filename = this.filename;
	return L5.encode(obj);
};

/**
 * 模拟后台的Map，可构造前台Map对象 示例： 
 * <p>
 * <code><pre>
 * var data = new L5.Map();
 * data.put(&quot;name&quot;, &quot;Jane&quot;);
 * </code></pre>
 * 
 * @class L5.Map
 * @constructor 构建Map对象
 */
L5.Map = function(classname, data) {
	this.javaClass = classname ? classname : "HashMap";// short name
	this.map = data ? data : new Object();
	this.length = this.size();
};

L5.Map.prototype = {

	length : null,
	/**
	 * 把值放入map对象中，比如：data.put(key,value);
	 * 
	 * @method put
	 * @param {String}
	 *            key 键值
	 * @param {Oject}
	 *            value 值
	 */
	put : function(key, value) {
		this.map[key] = value;
		this.length++;
	},
	/**
	 * 根据键值从map对象中取值，比如：var val = data.get(key);
	 * 
	 * @method get
	 * @param {String}
	 *            key 键值
	 * @return {Oject} 值
	 */
	get : function(key) {
		var val = this.map[key];
		return L5.serializer.unmarshall(val);
	},
	/**
	 * 从map对象中移除指定键值的值，比如：data.remove(key);
	 * 
	 * @method remove
	 * @param {String}
	 *            key 键值
	 * @return {Oject} 移除的对象
	 */
	remove : function(key) {
		var ret = this.map[key];
		this.map[key] = null;
		this.length--;
		return ret;
	},
	/**
	 * 获得map对象中值的个数
	 * 
	 * @method size
	 * @return {Int} 长度
	 */
	size : function() {
		if (this.length !== null)
			return this.length;
		this.length = 0;
		for ( var i in this.map) {
			this.length++;
		}
		return this.length;
	},
	/**
	 * 将map对象中所有的值组装为字符串返回
	 * 
	 * @method toString
	 * @return {String} 数据
	 */
	toString : function() {
		var ret = "{";
		var j = 0;
		for ( var i in this.map) {
			ret += i.toString() + ":" + this.get(i).toString();
			if (j++ < this.size() - 1)
				ret += ",";
		}
		ret += "}";
		return ret;
	}
};

/**
 * 模拟后台的List，可构造前台List对象 示例：
 * 
 * <pre><code>
 * var data = new L5.List();
 * var obj = new L5.Map();
 * obj.put(&quot;name&quot;, &quot;Jane&quot;);
 * data.add(obj);
 * </code></pre>
 * 
 * @class L5.List
 * @constructor 构建List对象
 */
L5.List = function(classname, data) {
	this.javaClass = classname ? classname : "ArrayList";// short name
	this.list = data ? data : new Array();
};

L5.List.prototype = {
	/**
	 * 把对象添加到list对象中
	 * 
	 * @method add
	 * @param {Oject}
	 *            obj 对象
	 */
	add : function(obj) {
		this.list.push(obj);
	},
	/**
	 * 根据索引得到对象
	 * 
	 * @method get
	 * @param {String}
	 *            index 索引
	 * @return {Oject} 对象
	 */
	get : function(index) {
		var val = this.list[index];
		return L5.serializer.unmarshall(val);
	},
	/**
	 * 得到list对象的长度
	 * 
	 * @method size
	 * @return {Int} 长度
	 */
	size : function() {
		return this.list.length
	},
	/**
	 * 将list对象中的数据转换组装成字符串返回
	 * 
	 * @method toString
	 * @return {String} 数据
	 */
	toString : function() {
		var ret = "[";
		for ( var i = 0; i < this.size(); i++) {
			ret += this.get(i).toString();
			if (i < this.size() - 1)
				ret += ",";
		}
		ret += "]";
		return ret;
	}
};

//将json转成对象，lazy
L5.serializer = {};
L5.serializer.converters = {};
L5.serializer.shortnames = {
	"Date" : "java.sql.Date",
	"HashMap" : "java.util.HashMap",
	"ArrayList" : "java.util.ArrayList",
	"Record" : "org.loushang.next.data.Record",
	"ParameterSet" : "org.loushang.next.data.ParameterSet"
// "LinedList":"java.util.LinedList",
// "Vector":"java.util.Vector",
// "TreeMap":"java.util.TreeMap",
// "LinkedHashMap":"java.util.LinkedHashMap",
// "WeakHashMap":"java.util.WeakHashMap",
};
/**
 * 转换对象
 * @method unmarshall
 * @param {Object} val 待转换的对象
 * @return {Object} 转换后的值
 */
L5.serializer.unmarshall = function(val) {
	if (!val) {
		return val;
	}
	if (!val.javaClass) {
		return val;
	}
	var fullname = L5.serializer.shortnames[val.javaClass];
	if (fullname) {
		val.javaClass = fullname;
	}
	var converter = L5.serializer.converters[val.javaClass];
	if (converter) {
		return converter(val);
	}
	return val;
};


(function() {
	// 转换函数
	function list_convert(o) {
		return new L5.List(o.javaClass, o.list);
	}
	L5.serializer.converters["java.util.ArrayList"] = list_convert;
	L5.serializer.converters["java.util.LinkedList"] = list_convert;
	L5.serializer.converters["java.util.Vector"] = list_convert;

	function date_convert(o) {
		return new Date(o.time);
	}
	L5.serializer.converters["java.util.Date"] = date_convert;
	L5.serializer.converters["java.sql.Date"] = date_convert;

	// 转换函数
	function map_convert(o) {
		return new L5.Map(o.javaClass, o.map);
	}

	L5.serializer.converters["java.util.HashMap"] = map_convert;
	L5.serializer.converters["java.util.TreeMap"] = map_convert;
	L5.serializer.converters["java.util.LinkedHashMap"] = map_convert;
	L5.serializer.converters["java.util.WeakHashMap"] = map_convert;
	L5.serializer.converters["org.loushang.next.data.ParameterSet"] = map_convert;
	
})();
