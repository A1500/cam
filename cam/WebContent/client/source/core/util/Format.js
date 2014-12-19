/**
 * @class L5.util.Format Reusable data formatting functions
 * @singleton
 */
L5.util.Format = function() {
	var trimRe = /^\s+|\s+$/g;
	return {
		/**
		 * 截断字符串，把超长部分用省略号('...')代替
		 * 
		 * @param {String}
		 *            value 被处理的字符串
		 * @param {Number}
		 *            length 限制的总长度(包括省略号长度)
		 * @param {Boolean}
		 *            word True to try to find a common work break
		 * 
		 * @return {String} 处理后的字符串
		 */
		ellipsis : function(value, len, word) {
			if (value && value.length > len) {
				if (word) {
					var vs = value.substr(0, len - 2);
					var index = Math.max(vs.lastIndexOf(' '), vs
							.lastIndexOf('.'), vs.lastIndexOf('!'), vs
							.lastIndexOf('?'));
					if (index == -1 || index < (len - 15)) {
						return value.substr(0, len - 3) + "...";
					} else {
						return vs.substr(0, index) + "...";
					}
				} else {
					return value.substr(0, len - 3) + "...";
				}
			}
			return value;
		},

		/**
		 * 如果指定变量是undefined就返回空串
		 * 
		 * @param {Mixed}
		 *            value
		 * @return {Mixed}
		 */
		undef : function(value) {
			return value !== undefined ? value : "";
		},

		/**
		 * Convert certain characters (&, <, >, and ') to their HTML character
		 * equivalents for literal display in web pages.
		 * 
		 * @param {String}
		 *            value The string to encode
		 * @return {String} The encoded text
		 */
		htmlEncode : function(value) {
			return !value ? value : String(value).replace(/&/g, "&amp;")
					.replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g,
							"&quot;");
		},

		/**
		 * Convert certain characters (&, <, >, and ') from their HTML character
		 * equivalents.
		 * 
		 * @param {String}
		 *            value The string to decode
		 * @return {String} The decoded text
		 */
		htmlDecode : function(value) {
			return !value ? value : String(value).replace(/&gt;/g, ">")
					.replace(/&lt;/g, "<").replace(/&quot;/g, '"').replace(
							/&amp;/g, "&");
		},

		// private
		call : function(value, fn) {
			if (arguments.length > 2) {
				var args = Array.prototype.slice.call(arguments, 2);
				args.unshift(value);
				return eval(fn).apply(window, args);
			} else {
				return eval(fn).call(window, value);
			}
		},

		// private
		stripTagsRE : /<\/?[^>]+>/gi,

		/**
		 * 出去所有html元素标签
		 * 
		 * @param {Mixed}
		 *            value 要处理的字符串
		 * 
		 * @return {String} 处理后的字符串
		 */
		stripTags : function(v) {
			return !v ? v : String(v).replace(this.stripTagsRE, "");
		},

		stripScriptsRe : /(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)/ig,

		/**
		 * 除去script标签(<script>和</script>)
		 * 
		 * @param {Mixed}
		 *            value 要处理的字符串
		 * 
		 * @return {String} 处理后的字符串
		 */
		stripScripts : function(v) {
			return !v ? v : String(v).replace(this.stripScriptsRe, "");
		},

		/**
		 * It does simple math for use in a template, for example:
		 * 
		 * <pre><code>
		 * var tpl = new L5.Template('{value} * 10 = {value:math(&quot;* 10&quot;)}');
		 * </code></pre>
		 * 
		 * @return {Function} A function that operates on the passed value.
		 */
		math : function() {
			var fns = {};
			return function(v, a) {
				if (!fns[a]) {
					fns[a] = new Function('v', 'return v ' + a + ';');
				}
				return fns[a](v);
			}
		}(),

		/**
		 * Selectively do a plural form of a word based on a numeric value. For
		 * example, in a template, {commentCount:plural("Comment")} would result
		 * in "1 Comment" if commentCount was 1 or would be "x Comments" if the
		 * value is 0 or greater than 1.
		 * 
		 * @param {Number}
		 *            value The value to compare against
		 * @param {String}
		 *            singular The singular form of the word
		 * @param {String}
		 *            plural (optional) The plural form of the word (defaults to
		 *            the singular with an "s")
		 */
		plural : function(v, s, p) {
			return v + ' ' + (v == 1 ? s : (p ? p : s + 's'));
		}

	}
}();

/**
 * 把一个数字转成美元货币格式
 * 
 * @param {Number/String}
 *            value 要处理的数字
 * 
 * @return {String} 处理后的字符串
 */
L5.util.Format.usMoney = function(v) {
	v = (Math.round((v - 0) * 100)) / 100;
	v = (v == Math.floor(v)) ? v + ".00" : ((v * 10 == Math.floor(v * 10)) ? v
			+ "0" : v);
	v = String(v);
	var ps = v.split('.');
	var whole = ps[0];
	var sub = ps[1] ? '.' + ps[1] : '.00';
	var r = /(\d+)(\d{3})/;
	while (r.test(whole)) {
		whole = whole.replace(r, '$1' + ',' + '$2');
	}
	v = whole + sub;
	if (v.charAt(0) == '-') {
		return '-$' + v.substr(1);
	}
	return "$" + v;
};

/**
 * 最字符串做substring
 * 
 * @param {String}
 *            value 原字符串
 * @param {Number}
 *            start 起点
 * @param {Number}
 *            length 截取长度
 * @return {String} 截取到的字符串
 */
L5.util.Format.substr = function(value, start, length) {
	return String(value).substr(start, length);
};

/**
 * trime一个字符串
 * 
 * @param {String}
 *            value The text to trim
 * @return {String} The trimmed text
 */
L5.util.Format.trim = function(value) {
	return String(value).replace(trimRe, "");
};

/**
 * 格式化对文件大小的描述：加上单位(KB、MB等)
 * 
 * @param {Number/String}
 *            size
 * 
 * @return {String}
 */
L5.util.Format.fileSize = function(size) {
	if (size < 1024) {
		return size + " bytes";
	} else if (size < 1048576) {
		return (Math.round(((size * 10) / 1024)) / 10) + " KB";
	} else {
		return (Math.round(((size * 10) / 1048576)) / 10) + " MB";
	}
};

/**
 * 将一个字符串变成全小写
 * 
 * @param {String}
 *            value 要处理的字符串
 * 
 * @return {String} 转换后的字符串
 */
L5.util.Format.lowercase = function(value) {
	return String(value).toLowerCase();
};

/**
 * 将一个字符串编程全大写
 * 
 * @param {String}
 *            value 要处理的字符串
 * 
 * @return {String} 转换后的字符串
 */
L5.util.Format.uppercase = function(value) {
	return String(value).toUpperCase();
};

/**
 * 转换一个字符串：首字母大写、其他字母全小写
 * 
 * @param {String}
 *            value 要处理的字符串
 * @return {String} 转换后的字符串
 */
L5.util.Format.capitalize = function(value) {
	return !value ? value : value.charAt(0).toUpperCase()
			+ value.substr(1).toLowerCase();
};

/**
 * 如果指定变量是空返回指定默认值，否则返回原变量值
 * 
 * @param {Mixed}
 *            value 指定变量
 * @param {String}
 *            defaultValue 指定默认值 (默认是 "")
 * @return {String}
 */
L5.util.Format.defaultValue = function(value, defaultValue) {
	return value !== undefined && value !== '' ? value : defaultValue;
};

/**
 * 将一个值按指定转换成指定格式的日期字符串；如果要转换的是一个字符串必须能用Date.parse转成一个日期对象；
 * 
 * @param {String/Date}
 *            value
 * @param {String}
 *            format (optional) 日期格式(默认是'm/d/Y')
 * @return {String}
 */
L5.util.Format.date = function(v, format) {
	if (!v) {
		return "";
	}
	if (!L5.isDate(v)) {
		v = new Date(Date.parse(v));
	}
	return v.dateFormat(format || "m/d/Y");
};

/**
 * 为指定格式创建一个render函数
 * 
 * @param {String}
 *            format 日期格式
 * 
 * @return {Function}
 */
L5.util.Format.dateRenderer = function(format) {
	return function(v) {
		return L5.util.Format.date(v, format);
	};
};

/**
 * 格式化一个数字：将一个数字按指定格式转化成数字
 * 
 * <pre>
 * 支持的格式：
 * 0.00 - (123456.78) 一个整数位、两个小数点位
 * <br>
 * 0.0000 - (123456.7890)一个整数位、四个小数点位
 * <br>
 * 0,000 - (123,456) 显示逗号和整数位、没有小数点位
 * <br>
 * 0,000.00 - (123,456.78) 显示逗号和整数位、两个小数点位
 * <br>
 * </pre>
 * 
 * @param {Number}
 *            v 要处理的数字
 * @param {String}
 *            format 数字格式
 * @return {String} .
 */
L5.util.Format.number = function(v, format) {
	if (!format) {
		return v;
	}
	v = L5.num(v, NaN);
	if (isNaN(v)) {
		return '';
	}
	var comma = ',', dec = '.', i18n = false, neg = v < 0;

	v = Math.abs(v);
	if (format.substr(format.length - 2) == '/i') {
		format = format.substr(0, format.length - 2);
		i18n = true;
		comma = '.';
		dec = ',';
	}

	var hasComma = format.indexOf(comma) != -1, psplit = (i18n ? format
			.replace(/[^\d\,]/g, '') : format.replace(/[^\d\.]/g, ''))
			.split(dec);

	if (1 < psplit.length) {
		v = v.toFixed(psplit[1].length);
	} else if (2 < psplit.length) {
		throw ('NumberFormatException: invalid format, formats should have no more than 1 period: ' + format);
	} else {
		v = v.toFixed(0);
	}

	var fnum = v.toString();
	if (hasComma) {
		psplit = fnum.split('.');

		var cnum = psplit[0], parr = [], j = cnum.length, m = Math.floor(j / 3), n = cnum.length % 3 || 3;

		for ( var i = 0; i < j; i += n) {
			if (i != 0) {
				n = 3;
			}
			parr[parr.length] = cnum.substr(i, n);
			m -= 1;
		}
		fnum = parr.join(comma);
		if (psplit[1]) {
			fnum += dec + psplit[1];
		}
	}

	return (neg ? '-' : '') + format.replace(/[\d,?\.?]+/, fnum);
};

/**
 * 为指定格式创建一个数字render函数
 * 
 * @param {String}
 *            format {@link #number}
 * 
 * @return {Function}
 */
L5.util.Format.numberRenderer = function(format) {
	return function(v) {
		return L5.util.Format.number(v, format);
	};
};

/**
 * 将回车换行符替换成HTML的换行符&lt;br/>
 * 
 * @param {String}
 *            需要转换的字符串
 * @return {String}
 */
L5.util.Format.nl2br = function(v) {
	return v === undefined || v === null ? '' : v.replace(/\n/g, '<br/>');
};

/**
 * 四舍五入
 * 
 * @param {Number/String}
 *            value 要处理的数字.
 * @param {Number}
 *            precision 要求的精度.
 * 
 * @return {Number}
 */
L5.util.Format.round = function(value, precision) {
	var result = Number(value);
	if (typeof precision == 'number') {
		precision = Math.pow(10, precision);
		result = Math.round(value * precision) / precision;
	}
	return result;
};