/**
 * @class Date
 * 
 * 
 * <pre>
 *  格式   描述                                                               		例如
 *  ------  -----------------------------------------------------------------------   -----------------------
 *  d     月份中的第几天，有前导零的2位数字                             				01 到 31
 *  D     星期中的第几天，文本表示3个字母，和国际化有关  								Mon 到 Sun
 *  j     月份中的第几天，没有前导零                                    				1 到 31
 *  l     星期几，完整的文本格式                      								星期天到星期六
 *  N     ISO-8601格式数字表示的星期中的第几天                   						1 (星期一) 到 7 (星期天)
 *  S     每月天数后面的英文后缀,2个字符             									st, nd, rd or th. 可以和j一起使用
 *  w     星期中的第几天，数字表示                             						0 (星期天) 到 6 (for 星期六)
 *  z     年份中的第几天                                     						0 到 364 (365，闰年)
 *  W     ISO-8601格式年份中的第几周，每周从星期一开始                   				01 到 53
 *  F     月份，完整的文本格式，例如英文环境下： January 或者 March，和国际化有关     	一月 到 十二月
 *  m     数字表示的月份，有前导零                     								01 到 12
 *  M     月份名称缩写，如英文环境下：Jan或者Mar，和国际化有关                         一月 到 十二月
 *  n     数字表示的月份，没有前导零                  								1 到 12
 *  t     给定月份所应有的天数                                         				28 到 31
 *  L     是否为闰年                                                  				1(是闰年) 或 0.
 *  o     ISO-8601格式年份数字。这和Y的值相同，差别在于如果ISO的W的值属于前一年或下一年，则用那一年。    例如: 1998 or 2004 belongs to the previous or next year, that year is used instead)
 *  Y     4位数字完整表示的年份                         								例如: 1999 、 2003
 *  y     2位数字表示的年份                                      					例如: 99 、 03
 *  a     小写的上午和下午值                                 							am 或 pm
 *  A     大写的上午和下午值                                 							AM 或 PM
 *  g     小时，12 小时格式，没有前导零                           					1 到 12
 *  G     小时，24 小时格式，没有前导零                           					0 到 23
 *  h     小时，12 小时格式，有前导零                              					01 到 12
 *  H     小时，24 小时格式，有前导零                              					00 到 23
 *  i     有前导零的分钟数                                               			00 到 59
 *  s     秒数，有前导零                                               				00 到 59
 *  u     Decimal fraction of a second                                              例如:001 (i.e. 0.001s) 或 100 (i.e. 0.100s)或 999 (i.e. 0.999s) 999876543210 (i.e. 0.999876543210s)
 *  O     与格林威治时间相差的小时数                   								例如: +1030
 *  P     与格林威治时间（GMT）的差别，小时和分钟之间有冒号分隔   						例如: -08:00
 *  T     本机所在的时区                     										例如: EST, MDT, PDT ...
 *  Z     时差偏移量的秒数。UTC西边的时区偏移量总是负的，UTC东边的时区偏移量总是正的。	-43200 to 50400
 *  c     ISO 8601 格式的日期,      													例如:2007-04-17T15:19:21+08:00 或 2008-03-16T16:18:22Z或2009-02-15T17:17:23.9+01:00或2010-01-14T18:16:24,999876543-07:00 
 *  U     从 Unix 纪元(January 1 1970 00:00:00 GMT)开始至今的秒数                		1193432466 或 -2138434463
 * </pre>
 * 
 * 例如 ( 注意,格式中如果出现特殊字符，使用双斜杠转义 ):
 * 
 * <pre><code>
 * var dt = new Date('1/10/2007 03:05:01 PM GMT-0600');
 * document.write(dt.format('Y-m-d')); // 2007-01-10
 * document.write(dt.format('F j, Y, g:i a')); // January 10, 2007, 3:05 pm
 * //下面这个例子中，&quot;the&quot;这单次中的&quot;t&quot;和&quot;h&quot;都是特殊字符，所有使用转义字符后是&quot;\\t\\he&quot;，&quot;of&quot;的&quot;o&quot;也是特殊字符。
 * document.write(dt.format('l, \\t\\he jS \\of F Y h:i:s A')); // Wednesday, the 10th of January 2007 03:05:01 PM
 * </code></pre>
 */

(function() {

	// create private copy of L5's String.format() method
	// - to remove unnecessary dependency
	// - to resolve namespace conflict with M$-Ajax's implementation
	function xf(format) {
		var args = Array.prototype.slice.call(arguments, 1);
		return format.replace(/\{(\d+)\}/g, function(m, i) {
			return args[i];
		});
	}

	/**
	 * 解析代码
	 */
	Date.parseCodes = {
		/*
		 * Notes: g = {Number} calculation group (0 or 1. only group 1
		 * contributes to date calculations.) c = {String} calculation method
		 * (required for group 1. null for group 0. {0} = currentGroup -
		 * position in regex result array) s = {String} regex pattern. all
		 * matches are stored in results[], and are accessible by the
		 * calculation mapped to 'c'
		 */
		d : {
			g : 1,
			c : "d = parseInt(results[{0}], 10);\n",
			s : "(\\d{2})" // day of month with leading zeroes (01 - 31)
		},
		j : {
			g : 1,
			c : "d = parseInt(results[{0}], 10);\n",
			s : "(\\d{1,2})" // day of month without leading zeroes (1 - 31)
		},
		D : function() {
			for ( var a = [], i = 0; i < 7; a.push(Date.getShortDayName(i)), ++i)
				; // get localised short day names
			return {
				g : 0,
				c : null,
				s : "(?:" + a.join("|") + ")"
			}
		},
		l : function() {
			return {
				g : 0,
				c : null,
				s : "(?:" + Date.dayNames.join("|") + ")"
			}
		},
		N : {
			g : 0,
			c : null,
			s : "[1-7]" // ISO-8601 day number (1 (monday) - 7 (sunday))
		},
		S : {
			g : 0,
			c : null,
			s : "(?:st|nd|rd|th)"
		},
		w : {
			g : 0,
			c : null,
			s : "[0-6]" // javascript day number (0 (sunday) - 6 (saturday))
		},
		z : {
			g : 0,
			c : null,
			s : "(?:\\d{1,3})" // day of the year (0 - 364 (365 in leap years))
		},
		W : {
			g : 0,
			c : null,
			s : "(?:\\d{2})" // ISO-8601 week number (with leading zero)
		},
		F : function() {
			return {
				g : 1,
				c : "m = parseInt(Date.getMonthNumber(results[{0}]), 10);\n", // get
				// localised
				// month
				// number
				s : "(" + Date.monthNames.join("|") + ")"
			}
		},
		M : function() {
			for ( var a = [], i = 0; i < 12; a.push(Date.getShortMonthName(i)), ++i)
				; // get localised short month names
			return L5.applyIf({
				s : "(" + a.join("|") + ")"
			}, $f("F"));
		},
		m : {
			g : 1,
			c : "m = parseInt(results[{0}], 10) - 1;\n",
			s : "(\\d{2})" // month number with leading zeros (01 - 12)
		},
		n : {
			g : 1,
			c : "m = parseInt(results[{0}], 10) - 1;\n",
			s : "(\\d{1,2})" // month number without leading zeros (1 - 12)
		},
		t : {
			g : 0,
			c : null,
			s : "(?:\\d{2})" // no. of days in the month (28 - 31)
		},
		L : {
			g : 0,
			c : null,
			s : "(?:1|0)"
		},
		o : function() {
			return $f("Y");
		},
		Y : {
			g : 1,
			c : "y = parseInt(results[{0}], 10);\n",
			s : "(\\d{4})" // 4-digit year
		},
		y : {
			g : 1,
			c : "var ty = parseInt(results[{0}], 10);\n"
					+ "y = ty > Date.y2kYear ? 1900 + ty : 2000 + ty;\n", // 2-digit
			// year
			s : "(\\d{1,2})"
		},
		a : {
			g : 1,
			c : "if (results[{0}] == 'am') {\n" + "if (h == 12) { h = 0; }\n"
					+ "} else { if (h < 12) { h += 12; }}",
			s : "(am|pm)"
		},
		A : {
			g : 1,
			c : "if (results[{0}] == 'AM') {\n" + "if (h == 12) { h = 0; }\n"
					+ "} else { if (h < 12) { h += 12; }}",
			s : "(AM|PM)"
		},
		g : function() {
			return $f("G");
		},
		G : {
			g : 1,
			c : "h = parseInt(results[{0}], 10);\n",
			s : "(\\d{1,2})" // 24-hr format of an hour without leading
		// zeroes (0 - 23)
		},
		h : function() {
			return $f("H");
		},
		H : {
			g : 1,
			c : "h = parseInt(results[{0}], 10);\n",
			s : "(\\d{2})" // 24-hr format of an hour with leading zeroes (00 -
		// 23)
		},
		i : {
			g : 1,
			c : "i = parseInt(results[{0}], 10);\n",
			s : "(\\d{2})" // minutes with leading zeros (00 - 59)
		},
		s : {
			g : 1,
			c : "s = parseInt(results[{0}], 10);\n",
			s : "(\\d{2})" // seconds with leading zeros (00 - 59)
		},
		u : {
			g : 1,
			c : "ms = results[{0}]; ms = parseInt(ms, 10)/Math.pow(10, ms.length - 3);\n",
			s : "(\\d+)" // decimal fraction of a second (minimum = 1 digit,
		// maximum = unlimited)
		},
		O : {
			g : 1,
			c : [
					"o = results[{0}];",
					"var sn = o.substring(0,1);", // get + / - sign
					"var hr = o.substring(1,3)*1 + Math.floor(o.substring(3,5) / 60);", // get
					// hours (performs minutes-to-hour conversion also, just in
					// case)
					"var mn = o.substring(3,5) % 60;", // get minutes
					"o = ((-12 <= (hr*60 + mn)/60) && ((hr*60 + mn)/60 <= 14))? (sn + String.leftPad(hr, 2, '0') + String.leftPad(mn, 2, '0')) : null;\n" // -12hrs
			// <= GMT offset <= 14hrs
			].join("\n"),
			s : "([+\-]\\d{4})" // GMT offset in hrs and mins
		},
		P : {
			g : 1,
			c : [
					"o = results[{0}];",
					"var sn = o.substring(0,1);", // get + / - sign
					"var hr = o.substring(1,3)*1 + Math.floor(o.substring(4,6) / 60);", // get
					// hours (performs minutes-to-hour conversion also, just in
					// case)
					"var mn = o.substring(4,6) % 60;", // get minutes
					"o = ((-12 <= (hr*60 + mn)/60) && ((hr*60 + mn)/60 <= 14))? (sn + String.leftPad(hr, 2, '0') + String.leftPad(mn, 2, '0')) : null;\n" // -12hrs
			// <= GMT offset <= 14hrs
			].join("\n"),
			s : "([+\-]\\d{2}:\\d{2})" // GMT offset in hrs and mins (with
		// colon separator)
		},
		T : {
			g : 0,
			c : null,
			s : "[A-Z]{1,4}" // timezone abbrev. may be between 1 - 4 chars
		},
		Z : {
			g : 1,
			c : "z = results[{0}] * 1;\n" // -43200 <= UTC offset <= 50400
					+ "z = (-43200 <= z && z <= 50400)? z : null;\n",
			s : "([+\-]?\\d{1,5})" // leading '+' sign is optional for UTC
		// offset
		},
		c : function() {
			var calc = [], arr = [
					$f("Y", 1), // year
					$f("m", 2), // month
					$f("d", 3), // day
					$f("h", 4), // hour
					$f("i", 5), // minute
					$f("s", 6), // second
					{
						c : "ms = (results[7] || '.0').substring(1); ms = parseInt(ms, 10)/Math.pow(10, ms.length - 3);\n"
					}, // decimal fraction of a second (minimum = 1 digit,
					// maximum = unlimited)
					{
						c : [ // allow both "Z" (i.e. UTC) and "+08:00" (i.e.
						// UTC offset) time zone delimiters
						"if(results[9] == 'Z'){", "z = 0;", "}else{",
								$f("P", 9).c, "}" ].join('\n')
					} ];

			for ( var i = 0, l = arr.length; i < l; ++i) {
				calc.push(arr[i].c);
			}

			return {
				g : 1,
				c : calc.join(""),
				s : arr[0].s + "-" + arr[1].s + "-" + arr[2].s + "T" + arr[3].s
						+ ":" + arr[4].s + ":" + arr[5].s + "((\.|,)\\d+)?" // decimal
						// fraction of a second (e.g. ",998465" or ".998465")
						+ "(Z|([+\-]\\d{2}:\\d{2}))" // "Z" (UTC) or "+08:00"
						// (UTC offset)
			}
		},
		U : {
			g : 1,
			c : "u = parseInt(results[{0}], 10);\n",
			s : "(-?\\d+)" // leading minus sign indicates seconds before UNIX
		// epoch
		}
	};

	/**
	 * @private
	 */
	Date.formatCodeToRegex = function(character, currentGroup) {
		// Note: currentGroup - position in regex result array (see notes for
		// Date.parseCodes below)
		var p = Date.parseCodes[character];

		if (p) {
			p = L5.type(p) == 'function' ? p() : p;
			Date.parseCodes[character] = p; // reassign function result to
			// prevent repeated execution
		}

		return p ? L5.applyIf({
			c : p.c ? xf(p.c, currentGroup || "{0}") : p.c
		}, p) : {
			g : 0,
			c : null,
			s : L5.escapeRe(character)
		// treat unrecognised characters as literals
		}
	}

	// private shorthand for Date.formatCodeToRegex since we'll be using it
	// fairly often
	var $f = Date.formatCodeToRegex;

	/**
	 * 解析函数
	 */
	Date.parseFunctions = {
		count : 0
	};

	/**
	 * 创建、生成新的解析函数
	 */
	Date.createParser = function() {
		var code = [
				"Date.{0} = function(input){",
				"var y, m, d, h = 0, i = 0, s = 0, ms = 0, o, z, u, v;",
				"input = String(input);",
				"d = new Date();",
				"y = d.getFullYear();",
				"m = d.getMonth();",
				"d = d.getDate();",
				"var results = input.match(Date.parseRegexes[{1}]);",
				"if(results && results.length > 0){",
				"{2}",
				"if(u){",
				"v = new Date(u * 1000);", // give top priority to UNIX time
				"}else if (y >= 0 && m >= 0 && d > 0 && h >= 0 && i >= 0 && s >= 0 && ms >= 0){",
				"v = new Date(y, m, d, h, i, s, ms);",
				"}else if (y >= 0 && m >= 0 && d > 0 && h >= 0 && i >= 0 && s >= 0){",
				"v = new Date(y, m, d, h, i, s);",
				"}else if (y >= 0 && m >= 0 && d > 0 && h >= 0 && i >= 0){",
				"v = new Date(y, m, d, h, i);",
				"}else if (y >= 0 && m >= 0 && d > 0 && h >= 0){",
				"v = new Date(y, m, d, h);",
				"}else if (y >= 0 && m >= 0 && d > 0){",
				"v = new Date(y, m, d);",
				"}else if (y >= 0 && m >= 0){",
				"v = new Date(y, m);",
				"}else if (y >= 0){",
				"v = new Date(y);",
				"}",
				"}",
				"return (v && (z != null || o != null))?" // favour UTC offset
				// over GMT offset
						+ " (L5.type(z) == 'number' ? v.add(Date.SECOND, -v.getTimezoneOffset() * 60 - z) :" // reset
						// to UTC, then add offset
						+ " v.add(Date.MINUTE, -v.getTimezoneOffset() + (sn == '+'? -1 : 1) * (hr * 60 + mn))) : v;", // reset
				// to GMT, then add offset
				"}" ].join('\n');

		return function(format) {
			var funcName = "parse" + Date.parseFunctions.count++, regexNum = Date.parseRegexes.length, currentGroup = 1, calc = "", regex = "", special = false, ch = "";

			Date.parseFunctions[format] = funcName;

			for ( var i = 0; i < format.length; ++i) {
				ch = format.charAt(i);
				if (!special && ch == "\\") {
					special = true;
				} else if (special) {
					special = false;
					regex += String.escape(ch);
				} else {
					var obj = $f(ch, currentGroup);
					currentGroup += obj.g;
					regex += obj.s;
					if (obj.g && obj.c) {
						calc += obj.c;
					}
				}
			}

			Date.parseRegexes[regexNum] = new RegExp("^" + regex + "$", "i");
			eval(xf(code, funcName, regexNum, calc));
		}
	}();

	/**
	 * 将一个字符串转化成一个日期对象。例如:
	 * 
	 * <pre><code>
	 * //dt = Fri May 25 2007 (current date)
	 * var dt = new Date();
	 * 
	 * //dt = Thu May 25 2006 (today's month/day in 2006)
	 * dt = Date.parseDate(&quot;2006&quot;, &quot;Y&quot;);
	 * 
	 * //dt = Sun Jan 15 2006 (all date parts specified)
	 * dt = Date.parseDate(&quot;2006-01-15&quot;, &quot;Y-m-d&quot;);
	 * 
	 * //dt = Sun Jan 15 2006 15:20:01 GMT-0600 (CST)
	 * dt = Date.parseDate(&quot;2006-01-15 3:20:01 PM&quot;, &quot;Y-m-d h:i:s A&quot;);
	 * </code></pre>
	 * 
	 * @param {String}
	 *            input
	 * 
	 * @param {String}
	 *            format
	 * 
	 * @return {Date}
	 * 
	 * @static
	 */
	Date.parseDate = function(input, format) {
		var p = Date.parseFunctions;
		if (p[format] == null) {
			Date.createParser(format);
		}
		var func = p[format];
		var o = Date[func](input);
		if (o)
			o.formatstr = format;
		return o;
	};

	L5.apply(Date, {

		parseRegexes : [],

		y2kYear : 50

	});

}());

/**
 * 
 */
Date.daysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

/**
 * 星期名称数组. 做js国际化的时候需要重置这个属性. 例如:
 * 
 * <pre><code>
 *  Date.dayNames = [
 *  'SundayInYourLang',
 *  'MondayInYourLang',
 *  ...
 *  ];
 * </code></pre>
 * 
 * @type Array
 * @static
 */
Date.dayNames = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
		"Friday", "Saturday" ];

/**
 * 月份名称数组.做js国际化的时候需要重置这个属性. 例如:
 * 
 * <pre><code>
 *  Date.monthNames = [
 *  'JanInYourLang',
 *  'FebInYourLang',
 *  ...
 *  ];
 * </code></pre>
 * 
 * @type Array
 * @static
 */
Date.monthNames = [ "January", "February", "March", "April", "May", "June",
		"July", "August", "September", "October", "November", "December" ];

/**
 * 月份名称缩写和月份序号的对应关系，用于方法{#getMonthNumber}；键值是大小写敏感的)。做js国际化的时候需要重置这个属性. 例如:
 * 
 * <pre><code>
 *  Date.monthNumbers = {
 *  'ShortJanNameInYourLang':0,
 *  'ShortFebNameInYourLang':1,
 *  ...
 *  };
 * </code></pre>
 * 
 * @type Object
 * 
 * @static
 */
Date.monthNumbers = {
	Jan : 0,
	Feb : 1,
	Mar : 2,
	Apr : 3,
	May : 4,
	Jun : 5,
	Jul : 6,
	Aug : 7,
	Sep : 8,
	Oct : 9,
	Nov : 10,
	Dec : 11
};

/**
 * 获取月份名称简写：比如英文环境下，输入参数值为1时，返回February的简写Feb；做js国际化的时候需要重载这个方法。
 * 
 * @param {Number}
 *            month 月份数字，从0开始.
 * @return {String}
 * @static
 */
Date.getShortMonthName = function(month) {
	return Date.monthNames[month].substring(0, 3);
};

/**
 * 获取星期简写：比如英文环境下，输入参数值为1时，返回Monday的简写Mon；做js国际化的时候需要重载这个方法。
 * 
 * @param {Number}
 *            day 数字，从0开始
 * @return {String}
 * @static
 */
Date.getShortDayName = function(day) {
	return Date.dayNames[day].substring(0, 3);
};

/**
 * 根据一个月份名称或月份名称缩写返回这个月份名称对应的是第几个月，比如输入Jan或January返回0；做js国际化的时候需要重载这个方法。
 * 
 * @param {String}
 *            name 月份名称或月份名称的缩写
 * @return {Number}
 * @static
 */
Date.getMonthNumber = function(name) {
	// handle camel casing for english month names (since the keys for the
	// Date.monthNumbers hash are case sensitive)
	return Date.monthNumbers[name.substring(0, 1).toUpperCase()
			+ name.substring(1, 3).toLowerCase()];
};

/**
 * 格式对应的处理代码。可以通过修改这个属性的值来修改日期的个性化。 例如:
 * 
 * <pre><code>
 * Date.formatCodes.x = &quot;String.leftPad(this.getDate(), 2, '0')&quot;;
 * (new Date()).format(&quot;X&quot;); // 返回当前日期中的天(补齐两位数)
 * </code></pre>
 * 
 * @type Object
 * 
 * @static
 */
Date.formatCodes = {
	d : "String.leftPad(this.getDate(), 2, '0')",
	D : "Date.getShortDayName(this.getDay())", // get localised short day name
	j : "this.getDate()",
	l : "Date.dayNames[this.getDay()]",
	N : "(this.getDay() ? this.getDay() : 7)",
	S : "this.getSuffix()",
	w : "this.getDay()",
	z : "this.getDayOfYear()",
	W : "String.leftPad(this.getWeekOfYear(), 2, '0')",
	F : "Date.monthNames[this.getMonth()]",
	m : "String.leftPad(this.getMonth() + 1, 2, '0')",
	M : "Date.getShortMonthName(this.getMonth())", // get localised short month
	// name
	n : "(this.getMonth() + 1)",
	t : "this.getDaysInMonth()",
	L : "(this.isLeapYear() ? 1 : 0)",
	o : "(this.getFullYear() + (this.getWeekOfYear() == 1 && this.getMonth() > 0 ? +1 : (this.getWeekOfYear() >= 52 && this.getMonth() < 11 ? -1 : 0)))",
	Y : "this.getFullYear()",
	y : "('' + this.getFullYear()).substring(2, 4)",
	a : "(this.getHours() < 12 ? 'am' : 'pm')",
	A : "(this.getHours() < 12 ? 'AM' : 'PM')",
	g : "((this.getHours() % 12) ? this.getHours() % 12 : 12)",
	G : "this.getHours()",
	h : "String.leftPad((this.getHours() % 12) ? this.getHours() % 12 : 12, 2, '0')",
	H : "String.leftPad(this.getHours(), 2, '0')",
	i : "String.leftPad(this.getMinutes(), 2, '0')",
	s : "String.leftPad(this.getSeconds(), 2, '0')",
	u : "String.leftPad(this.getMilliseconds(), 3, '0')",
	O : "this.getGMTOffset()",
	P : "this.getGMTOffset(true)",
	T : "this.getTimezone()",
	Z : "(this.getTimezoneOffset() * -60)",
	c : function() { // ISO-8601 -- GMT format
		for ( var c = "Y-m-dTH:i:sP", code = [], i = 0, l = c.length; i < l; ++i) {
			var e = c.charAt(i);
			code.push(e == "T" ? "'T'" : Date.getFormatCode(e)); // treat T
			// as a
			// character
			// literal
		}
		return code.join(" + ");
	},
	U : "Math.round(this.getTime() / 1000)"
};

/**
 * 获取格式对应的处理代码，用来生成格式化处理函数{@link #createNewFormat}
 * 
 * @private
 * @param {String}
 *            character 格式名称
 */
Date.getFormatCode = function(character) {
	var f = Date.formatCodes[character];

	if (f) {
		f = L5.type(f) == 'function' ? f() : f;
		Date.formatCodes[character] = f; // reassign function result to
		// prevent repeated execution
	}

	// note: unknown characters are treated as literals
	return f || ("'" + String.escape(character) + "'");
};

/**
 * 各种格式处理函数
 * 
 * @private
 */
Date.formatFunctions = {
	count : 0
};

/**
 * 创建、生成新的格式处理函数
 * 
 * @private
 */
Date.createNewFormat = function(format) {
	var funcName = "format" + Date.formatFunctions.count++, code = "Date.prototype."
			+ funcName + " = function(){return ", special = false, ch = '';

	Date.formatFunctions[format] = funcName;

	for ( var i = 0; i < format.length; ++i) {
		ch = format.charAt(i);
		if (!special && ch == "\\") {
			special = true;
		} else if (special) {
			special = false;
			code += "'" + String.escape(ch) + "' + ";
		} else {
			code += Date.getFormatCode(ch) + " + ";
		}
	}
	eval(code.substring(0, code.length - 3) + ";}");
};

/**
 * 将日期按指定日期格式转成字符串
 * 
 * @private
 */
Date.prototype.dateFormat = function(format) {
	if (Date.formatFunctions[format] == null) {
		Date.createNewFormat(format);
	}
	var func = Date.formatFunctions[format];
	return this[func]();
};

/**
 * 返回今天是一年中的第几天
 * 
 * @return {Number} 0 到 364 (闰年到365).
 */
Date.prototype.getDayOfYear = function() {
	var num = 0;
	Date.daysInMonth[1] = this.isLeapYear() ? 29 : 28;
	for ( var i = 0; i < this.getMonth(); ++i) {
		num += Date.daysInMonth[i];
	}
	return num + this.getDate() - 1;
};

/**
 * 返回这周是一年中的第几周
 * 
 * @return {Number} 1 到 53
 */
Date.prototype.getWeekOfYear = function() {
	// adapted from http://www.merlyn.demon.co.uk/weekcalc.htm
	var ms1d = 864e5, // milliseconds in a day
	ms7d = 7 * ms1d; // milliseconds in a week

	return function() { // return a closure so constants get calculated only
		// once
		var DC3 = Date.UTC(this.getFullYear(), this.getMonth(),
				this.getDate() + 3)
				/ ms1d, // an Absolute Day Number
		AWN = Math.floor(DC3 / 7), // an Absolute Week Number
		Wyr = new Date(AWN * ms7d).getUTCFullYear();

		return AWN - Math.floor(Date.UTC(Wyr, 0, 7) / ms7d) + 1;
	}
}();

/**
 * 判断是不是闰年
 * 
 * @return {Boolean}
 */
Date.prototype.isLeapYear = function() {
	var year = this.getFullYear();
	return !!((year & 3) == 0 && (year % 100 || (year % 400 == 0 && year)));
};

/**
 * 返回这个月的第一天(1号)是星期几，但是该方法返回的是对应的数字，比如，如果是星期天返回的是0。例如:
 * 
 * <pre><code>
 * var dt = new Date('1/10/2007');
 * document.write(Date.dayNames[dt.getFirstDayOfMonth()]); //返回: 'Monday'
 * </code></pre>
 * 
 * @return {Number} (0-6).
 */
Date.prototype.getFirstDayOfMonth = function() {
	var day = (this.getDay() - (this.getDate() - 1)) % 7;
	return (day < 0) ? (day + 7) : day;
};

/**
 * 返回这个月的最后一天(1号)是星期几，但是该方法返回的是对应的数字，比如，如果是星期天返回的是0。例如:
 * 
 * <pre><code>
 * var dt = new Date('1/10/2007');
 * document.write(Date.dayNames[dt.getLastDayOfMonth()]); //output: 'Wednesday'
 * </code></pre>
 * 
 * @return {Number} (0-6).
 */
Date.prototype.getLastDayOfMonth = function() {
	var day = (this.getDay() + (Date.daysInMonth[this.getMonth()] - this
			.getDate())) % 7;
	return (day < 0) ? (day + 7) : day;
};

/**
 * 返回这个月的第一天对应的日期对象.
 * 
 * @return {Date}
 */
Date.prototype.getFirstDateOfMonth = function() {
	return new Date(this.getFullYear(), this.getMonth(), 1);
};

/**
 * 返回这个月的最后一天对应的日期对象.
 * 
 * @return {Date}
 */
Date.prototype.getLastDateOfMonth = function() {
	return new Date(this.getFullYear(), this.getMonth(), this.getDaysInMonth());
};

/**
 * 返回这个月有多少天.
 * 
 * @return {Number}
 */
Date.prototype.getDaysInMonth = function() {
	Date.daysInMonth[1] = this.isLeapYear() ? 29 : 28;
	return Date.daysInMonth[this.getMonth()];
};

/**
 * 获取本机所在的时区。
 * 
 * @return {String} (e.g. 'CST', 'PDT', 'EDT', 'MPST' ...).
 */
Date.prototype.getTimezone = function() {
	/**
	 * <pre>
	 * 通过日期的toString方法返回的字符串来计算(这要求我们不能随便改toString方法的实现！！)，举例说明：
	 * 1、调用toString获得Thu Oct 25 2007 22:55:35 GMT+0800 (Malay Peninsula Standard Time)
	 * 2、取出括号里的字符串：Malay Peninsula Standard Time
	 * 3、取出每个单词的大写首字母：MPST
	 * </pre>
	 */
	return this.toString().replace(
			/^.* (?:\((.*)\)|([A-Z]{1,4})(?:[\-+][0-9]{4})?(?: -?\d+)?)$/,
			"$1$2").replace(/[^A-Z]/g, "");
};

/**
 * 获得与格林威治时间相差的小时数，小时和分钟各两位数字，中间可能有冒号分隔，前面用带加号或减号。
 * 
 * @param {Boolean}
 *            colon true表示小时和分钟之间有冒号分隔(默认是false).
 * @return {String}
 */
Date.prototype.getGMTOffset = function(colon) {
	return (this.getTimezoneOffset() > 0 ? "-" : "+")
			+ String.leftPad(Math
					.floor(Math.abs(this.getTimezoneOffset()) / 60), 2, "0")
			+ (colon ? ":" : "")
			+ String.leftPad(Math.abs(this.getTimezoneOffset() % 60), 2, "0");
};

/**
 * 主要在英文环境下使用。英文中表示一个月的第几天，通常在数字后面带个后缀，比如Wednesday, the 10<strong>th</strong> of January 2007 03:05:01 PM
 * 
 * @return {String} 'st, 'nd', 'rd' or 'th'.
 */
Date.prototype.getSuffix = function() {
	switch (this.getDate()) {
	case 1:
	case 21:
	case 31:
		return "st";
	case 2:
	case 22:
		return "nd";
	case 3:
	case 23:
		return "rd";
	default:
		return "th";
	}
};

/**
 * 克隆一个日期对象。
 * 
 * 例如:
 * 
 * <pre><code>
 * //引用的方式:
 * var orig = new Date('10/1/2006');
 * var copy = orig;
 * copy.setDate(5);
 * document.write(orig); //返回 'Thu Oct 05 2006'!
 * 
 * //克隆的方式:
 * var orig = new Date('10/1/2006');
 * var copy = orig.clone();
 * copy.setDate(5);
 * document.write(orig); //返回 'Thu Oct 01 2006'
 * </code></pre>
 * 
 * @return {Date} 新的日期对象
 */
Date.prototype.clone = function() {
	return new Date(this.getTime());
};

/**
 * 把日期对象所有域的值设为0
 * 
 * @return {Date} this
 */
Date.prototype.clearTime = function() {
	this.setHours(0);
	this.setMinutes(0);
	this.setSeconds(0);
	this.setMilliseconds(0);
	return this;
};

/**
 * 日期域--毫秒
 * 
 * @static
 * @type String
 */
Date.MILLI = "ms";

/**
 * 日期域--秒
 * 
 * @static
 * @type String
 */
Date.SECOND = "s";

/**
 * 日期域--分
 * 
 * @static
 * @type String
 */
Date.MINUTE = "mi";

/**
 * 日期域--时
 * 
 * @static
 * @type String
 */
Date.HOUR = "h";

/**
 * 日期域--日
 * 
 * @static
 * @type String
 */
Date.DAY = "d";

/**
 * 日期域--月
 * 
 * @static
 * @type String
 */
Date.MONTH = "mo";

/**
 * 日期域--年
 * 
 * @static
 * @type String
 */
Date.YEAR = "y";

/**
 * 修改日期对象，对某个域(毫秒、秒、分、时、天、月、年)做加或减；不改变原来的Date对象，修改结果通过返回新对象体现。
 * 
 * 例如:
 * 
 * <pre><code>
 * //基本用法:
 * var dt = new Date('10/29/2006').add(Date.DAY, 5);
 * document.write(dt); //返回 'Fri Oct 06 2006 00:00:00'
 * 
 * //负数:
 * var dt2 = new Date('10/1/2006').add(Date.DAY, -5);
 * document.write(dt2); //返回 'Tue Sep 26 2006 00:00:00'
 * 
 * //链式调用：
 * var dt3 = new Date('10/1/2006').add(Date.DAY, 5).add(Date.HOUR, 8).add(
 * 		Date.MINUTE, -30);
 * document.write(dt3); //返回 'Fri Oct 06 2006 07:30:00'
 * </code></pre>
 * 
 * @param {String}
 *            interval 要修改的域。{@link Date.MILLI} {@link Date.SECOND}{@link Date.MINUTE}{@link Date.HOUR}{@link Date.DAY}{@link Date.MONTH}{@link Date.YEAR}
 * @param {Number}
 *            value 修改量，正数表示加、负数表示减
 * 
 * @return {Date} 新日期对象
 */
Date.prototype.add = function(interval, value) {
	var d = this.clone();
	if (!interval || value === 0)
		return d;

	switch (interval.toLowerCase()) {
	case Date.MILLI:
		d.setMilliseconds(this.getMilliseconds() + value);
		break;
	case Date.SECOND:
		d.setSeconds(this.getSeconds() + value);
		break;
	case Date.MINUTE:
		d.setMinutes(this.getMinutes() + value);
		break;
	case Date.HOUR:
		d.setHours(this.getHours() + value);
		break;
	case Date.DAY:
		d.setDate(this.getDate() + value);
		break;
	case Date.MONTH:
		var day = this.getDate();
		if (day > 28) {
			day = Math.min(day, this.getFirstDateOfMonth().add('mo', value)
					.getLastDateOfMonth().getDate());
		}
		d.setDate(day);
		d.setMonth(this.getMonth() + value);
		break;
	case Date.YEAR:
		d.setFullYear(this.getFullYear() + value);
		break;
	}
	return d;
};

/**
 * 判断当前日期是否在某个日期区间
 * 
 * @param {Date}
 *            start 起始日期
 * @param {Date}
 *            end 结束日期
 * @return {Boolean}
 */
Date.prototype.between = function(start, end) {
	var t = this.getTime();
	return start.getTime() <= t && t <= end.getTime();
};

/**
 * 将这个日期对象按指定日期格式转成字符串
 * 
 * @param {String}
 *            format 格式
 * 
 * @return {String}
 * 
 * @method format
 */
Date.prototype.format = Date.prototype.dateFormat;

/**
 * 返回当前日期和指定日期之间的时间差(毫秒数)。(距离指定的日期已经过了多长时间了)
 * 
 * @param {Date}
 *            date 指定日期
 * @return {Number} 时间差，毫秒数
 */
Date.prototype.getElapsed = function(date) {
	return Math.abs((date || new Date()).getTime() - this.getTime());
};

/**
 * 自定义toString方法
 * 
 * @private
 */
Date.prototype.toString = function() {
	if (this.formatstr) {
		return this.format(this.formatstr);
	} else {
		return this.format('Y-m-d');
	}
};

/**
 * 自定义json格式
 * 
 * @private
 */
Date.prototype.toJsonString = function() {
	var obj = new Object();
	// obj.javaClass="java.sql.Date";
	obj.javaClass = "Date"; // short name
	obj.time = this.valueOf();
	return L5.encode(obj);
};

// private safari setMonth is broken
if (L5.isSafari) {
	Date.brokenSetMonth = Date.prototype.setMonth;
	Date.prototype.setMonth = function(num) {
		if (num <= -1) {
			var n = Math.ceil(-num);
			var back_year = Math.ceil(n / 12);
			var month = (n % 12) ? 12 - n % 12 : 0;
			this.setFullYear(this.getFullYear() - back_year);
			return Date.brokenSetMonth.call(this, month);
		} else {
			return Date.brokenSetMonth.apply(this, arguments);
		}
	};
}