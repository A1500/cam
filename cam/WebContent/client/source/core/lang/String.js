
/**
 * 给String类增加静态方法
 * 
 * @class String
 */
L5.applyIf(String, {
	/**
	 * 转换 ' 和 \
	 * 
	 * @param {String}
	 *            string 需要转换的字符串
	 * @return {String} 转换完的字符串
	 * @static
	 */
	escape : function(string) {
		return string.replace(/('|\\)/g, "\\$1");
	},

	/**
	 * 在字符串左边填补某种字符. 比如在凑齐5位长度字符串，在数字前面填充0：
	 * 
	 * <pre><code>
	 * var s = String.leftPad('123', 5, '0');
	 * // s now contains the string: '00123'
	 * </code></pre>
	 * 
	 * @param {String}
	 *            string 原始的字符串
	 * @param {Number}
	 *            size 最终字符串长度
	 * @param {String}
	 *            char 填补的字符，比如0或空格(默认是空格)
	 * @return {String} 填充后的字符串
	 * @static
	 */
	leftPad : function(val, size, ch) {
		var result = new String(val);
		if (!ch) {
			ch = " ";
		}
		while (result.length < size) {
			result = ch + result;
		}
		return result.toString();
	},

	/**
	 * 给"参数化的字符"串填值，常用于字符串组装：在组装字符串的时候，字符串的某些部分是动态的，可以使用占位符，然后通过该format方法给这些占位符赋值。
	 * 例子如下:
	 * 
	 * <pre><code>
	 * var cls = 'my-class', text = 'Some text';
	 * var s = String.format('&lt;div class=&quot;{0}&quot;&gt;{1}&lt;/div&gt;', cls, text);
	 * // s 的值为: '&lt;div class=&quot;my-class&quot;&gt;Some text&lt;/div&gt;'
	 * </code></pre>
	 * 
	 * @param {String}
	 *            string 需要格式化并带有占位符的字符串
	 * @param {String}
	 *            value1 需要替换 {0}的值
	 * @param {String}
	 *            value2 等等...
	 * @return {String} 格式化好的字符串
	 * @static
	 */
	format : function(format) {
		var args = Array.prototype.slice.call(arguments, 1);
		return format.replace(/\{(\d+)\}/g, function(m, i) {
			return args[i];
		});
	}
});
/**
 * 给字符串类型增加方法，toggle(开关)
 * 如果当前字符串等于第一个参数的值(value)，就返回第二个参数的值(other)，否则就返回第一个参数的值(value) 例如：
 * 
 * <pre><code>
 * // 改变排序方向
 * sort = sort.toggle('ASC', 'DESC');
 * 
 * // 如果不用toggle方法，必须这么做
 * sort = (sort == 'ASC' ? 'DESC' : 'ASC');
 * </code></pre>
 * 
 * @private
 * @param {String}
 *            value 用来和当前字符串比较的字符串
 * @param {String}
 *            other
 * @return {String} 新的值
 */
String.prototype.toggle = function(value, other) {
	return this == value ? other : value;
};

/**
 * 去掉字符串头和尾的空白字符 例子如下:
 * 
 * <pre><code>
 * var s = '  foo bar  ';
 * alert('-' + s + '-'); //alerts &quot;- foo bar -&quot;
 * alert('-' + s.trim() + '-'); //alerts &quot;-foo bar-&quot;
 * </code></pre>
 * 
 * @return {String} 已经去掉空格的字符串
 */
String.prototype.trim = function() {
	var re = /^\s+|\s+$/g;// 这个变量可以只创建一次，节省内存
	return function() {
		return this.replace(re, "");
	};
}();
