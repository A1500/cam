//正则表达式验证
var $regexs = {
	require : /.+/,
	email : /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
	phone : /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/,
	mobile : /^((\(\d{2,3}\))|(\d{3}\-))?0{0,1}1[3|5|6|8][0-9]{9}$/,
	url : new RegExp("^((https|http|ftp|rtsp|mms)?://)" 
		  + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@ 
	        + "(([0-9]{1,3}.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184 
	        + "|" // 允许IP和DOMAIN（域名）
	        + "([0-9a-z_!~*'()-]+.)*" // 域名- www. 
	        + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]." // 二级域名 
	        + "[a-z]{2,6})" // first level domain- .com or .museum 
	        + "(:[0-9]{1,4})?" // 端口- :80 
	        + "((/?)|" // a slash isn't required if there is no file name 
	        + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$"),
	ip : /^(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])$/,
	currency : /^(-)?\d+(\.\d+)?$/,
	number : /^\d+$/,
	zip : /^[1-9]\d{5}$/,
	qq : /^[1-9]\d{4,9}$/,
	english : /^\w+$/,
	chinese :  /^[\u0391-\uFFE5]+$/,
	username : /^[a-z]\w{3,19}$/i,
	integer : /^[-\+]?\d+$/,
	'double' : /^[-\+]?\d+(\.\d+)?$/
};

/**
 * 验证身份证格式（比较严格）
 * @method L5.isIdCard
 * @param {String} card 身份证
 * @return {Boolean} 如果正确返回true
 */
L5.isIdCard = {
	vcity : { 11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
            21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",
            33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",
            42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",
            51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",
            63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"
     },

    checkIdCard : function(card){
	    //是否为空
	    if(card === ''){
	        return "身份证号码不能为空!";
	    }
	    //校验长度，类型
	    if(this.isCardNo(card) === false){
        	return "身份证号码长度或类型错误!";
	    }
	    //检查省份
	    if(this.checkProvince(card) === false){
	        return "身份证号码错误!";
	    }
	    //校验生日
	    if(this.checkBirthday(card) === false){
	        return "身份证号码错误!";
	    }
	    //检验位的检测
	    if(this.checkParity(card) === false){
	        return "身份证号码错误!";
	    }
	    return true;
     },


	//检查号码是否符合规范，包括长度，类型
	isCardNo : function(id){
	    //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
	    var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/;
	    if(reg.test(id) === false){
	        return false;
	    }
	    return true;
	},

	//取身份证前两位,校验省份
	checkProvince : function(card){
	    var province = card.substr(0,2);
	    if(this.vcity[province] == undefined){
	        return false;
	    }
	    return true;
	},

	//检查生日是否正确
	checkBirthday : function(card){
	    var len = card.length;
	    //身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
	    if(len == 15){
	        var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/; 
	        var arr_data = card.match(re_fifteen);
	        var year = arr_data[2];
	        var month = arr_data[3];
	        var day = arr_data[4];
	        var birthday = new Date('19'+year+'/'+month+'/'+day);
	        return this.verifyBirthday('19'+year,month,day,birthday);
	    }
	    //身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
	    if(len == 18){
	        var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/;
	        var arr_data = card.match(re_eighteen);
	        var year = arr_data[2];
	        var month = arr_data[3];
	        var day = arr_data[4];
	        var birthday = new Date(year+'/'+month+'/'+day);
	        return this.verifyBirthday(year,month,day,birthday);
	    }
	    return false;
	},

	//校验日期
	verifyBirthday : function(year,month,day,birthday){
	    var now = new Date();
	    var now_year = now.getFullYear();
	    //年月日是否合理
	    if(birthday.getFullYear() == year && (birthday.getMonth() + 1) == month && birthday.getDate() == day){
	        //判断年份的范围（3岁到100岁之间)
	        var time = now_year - year;
	        if(time >= 3 && time <= 100){
	            return true;
	        }
	        return false;
	    }
	    return false;
	},

	//校验位的检测
	checkParity : function(card){
	    //15位转18位
	    card = this.changeFivteenToEighteen(card);
	    var len = card.length;
	    if(len == 18){
	        var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
	        var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
	        var cardTemp = 0, i, valnum; 
	        for(i = 0; i < 17; i ++){ 
	            cardTemp += card.substr(i, 1) * arrInt[i]; 
	        } 
	        valnum = arrCh[cardTemp % 11]; 
	        if (valnum == card.substr(17, 1)){
	            return true;
	        }
	        return false;
	    }
	    return false;
	},

	//15位转18位身份证号
	changeFivteenToEighteen : function(card){
	    if(card.length == '15'){
	        var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
	        var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
	        var cardTemp = 0, i;   
	        card = card.substr(0, 6) + '19' + card.substr(6, card.length - 6);
	        for(i = 0; i < 17; i ++){ 
	            cardTemp += card.substr(i, 1) * arrInt[i]; 
	        } 
	        card += arrCh[cardTemp % 11]; 
	        return card;
	    }
	    return card;
	}
};
/**
 * 验证身份证格式（比较严格）
 * @method L5.isIdCard
 * @param {String} card 身份证
 * @return {Boolean/String} 如果正确返回true,否则返回错误信息
 */
L5.checkIdCard = function(idCard){
	return L5.isIdCard.checkIdCard(idCard);
};
/**
 * 验证日期时间:如果reObj为true，返回Date类型日期时间；否则判断是否为日期时间
 * @method L5.isDateTime
 * @param {String} format 日期的格式
 * @param {Object} reObj 判断的对象
 * @return {Boolean} 是否是指定格式的日期
 */
L5.isDateTime = function(format, reObj){
	format = format || 'yyyy-MM-dd';
	var input = this, o = {}, d = new Date();
	if (L5.isDate(input) && !reObj)
		return true;
	var f1 = format.split(/[^a-z]+/gi), f2 = input.split(/\D+/g), f3 = format
			.split(/[a-z]+/gi), f4 = input.split(/\d+/g);
	var len = f1.length, len1 = f3.length;
	if (len != f2.length || len1 != f4.length)
		return false;
	for (var i = 0; i < len1; i++)
		if (f3[i] != f4[i])
			return false;
	for (var i = 0; i < len; i++)
		o[f1[i]] = f2[i];
	if(!o.Y)
		o.Y = o.y;
	o.yyyy = s(o.yyyy, o.Y, d.getFullYear(), 9999, 4);
	o.MM = s(o.MM, o.m, d.getMonth() + 1, 12);
	o.dd = s(o.dd, o.d, d.getDate(), 31);
	o.hh = s(o.hh, o.h, d.getHours(), 24);
	o.mm = s(o.mm, o.m, d.getMinutes());
	o.ss = s(o.ss, o.s, d.getSeconds());
	o.ms = s(o.ms, o.ms, d.getMilliseconds(), 999, 3);
	if (o.yyyy + o.MM + o.dd + o.hh + o.mm + o.ss + o.ms < 0)
		return false;
	if (o.yyyy < 100)
		o.yyyy += (o.yyyy > 30 ? 1900 : 2000);
	d = new Date(o.yyyy, o.MM - 1, o.dd, o.hh, o.mm, o.ss, o.ms);
	var reVal = d.getFullYear() == o.yyyy && d.getMonth() + 1 == o.MM
			&& d.getDate() == o.dd && d.getHours() == o.hh
			&& d.getMinutes() == o.mm && d.getSeconds() == o.ss
			&& d.getMilliseconds() == o.ms;
	return reVal && reObj ? d : reVal;
	function s(s1, s2, s3, s4, s5) {
		s4 = s4 || 60, s5 = s5 || 2;
		var reVal = s3;
		if (s1 != undefined && s1 != '' || !isNaN(s1)) {
			if (s1.length == 1) {
				s1 = "0" + s1;
			}
			reVal = s1 * 1;
		}
		if (s2 != undefined && s2 != '' && !isNaN(s2)) {
			if (s2.length == 1) {
				s2 = "0" + s2;
			}
			reVal = s2 * 1;
		}
		return (reVal == s1 && s1.length != s5 || reVal > s4) ? -10000 : reVal;
	}
};

/**
 * 前台校验类
 * @class L5.Validator
 */
L5.Validator = {
	/**
	 * 校验record对象中指定的域是否合法
	 * @method validate
	 * @private
	 * @param {L5.model.Record} record record对象
	 * @param {String} name 域名称
	 * @param {String} value 域的值
	 * @return {Array} 校验信息
	 */
	validate : function(record, name, value) {
		var isValidate = true;
		var result = new Array();
		for (var i = 0; i < record.fields.items.length; i++) {
			// 查找对应的field
			if (record.fields.items[i].name === name
					&& record.fields.items[i].rule != null) {
				var rules = record.fields.items[i].rule.split("|");
				// 循环校验该field域的所有规则，只要有一个不通过的，就认为校验失败
				for (var j = 0; j < rules.length; j++) {
					var rule = rules[j];
					var ruleName = rule.substring(0, rule.indexOf("{"));
					var ruleParm = rule.substring(rule.indexOf("{") + 1, rule
									.lastIndexOf("}"));
					if (rule.indexOf("{") < 0) {
						ruleName = rule;
						ruleParm = "";
					}
					isValidate = L5.Validator.ruleValidate(ruleName, value,
							record, ruleParm);
					if (ruleName == "equal" && record.get(ruleParm) != null) {
						L5.Validator.reflectValidate(record, ruleParm, record
										.get(ruleParm));
						result.push(ruleParm);
					} else if (rule == "compare") {
						var parms = ruleParm.split(",");
						var min, max;
						for (var i = 0; i < parms.length; i++) {
							if (parms[i].indexOf("min") >= 0) {
								min = parms[i].substring(parms[i].indexOf(":")
										+ 1);
							}
							if (parms[i].indexOf("max") >= 0) {
								max = parms[i].substring(parms[i].indexOf(":")
										+ 1);
							}
						}
						if (record.get(min) != null) {
							L5.Validator.reflectValidate(record, min, record
											.get(min));
							result.push(min);
						}
						if (record.get(max) != null) {
							L5.Validator.reflectValidate(record, max, record
											.get(max));
							result.push(max);;
						}
					}
					if (isValidate !== true) {
						// record.fields.items[i].msg = isValidate;
						record.msg[name] = isValidate;
						break;
					}
				}
				L5.Validator.setValidate(name, record, isValidate);
				break;
			}
		}
		return result;
	},
	// 重新校验相关联的域
	reflectValidate : function(record, name, value) {
		var result = true;
		for (var i = 0; i < record.fields.items.length; i++) {
			// 查找对应的field
			if (record.fields.items[i].name === name
					&& record.fields.items[i].rule != null) {
				var rules = record.fields.items[i].rule.split("|");
				// 循环校验该field域的所有规则，只要有一个不通过的，就认为校验失败
				for (var j = 0; j < rules.length; j++) {
					var rule = rules[j];
					var ruleName = rule.substring(0, rule.indexOf("{"));
					var ruleParm = rule.substring(rule.indexOf("{") + 1, rule
									.lastIndexOf("}"));
					if (rule.indexOf("{") < 0) {
						ruleName = rule;
						ruleParm = "";
					}
					result = L5.Validator.ruleValidate(ruleName, value, record,
							ruleParm);
					if (result !== true) {
						// record.fields.items[i].msg = result;
						record.msg[name] = result;
						break;
					}
				}
				L5.Validator.setValidate(name, record, result);
				break;
			}
		}
	},
	// 根据rule调用对应的校验方法
	ruleValidate : function(ruleName, value, record, ruleParm) {
		var result = true;
		switch (ruleName) {
			case null :
				result = L5.Validator["empty"]();
				break;
			case "require" :
				result = L5.Validator["require"](value, record);
				break;
			case "date" :
				result = L5.Validator["date"](value, record, ruleParm);
				break;
			case "equal" :
				result = L5.Validator["equal"](value, record, ruleParm);
				break;
			case "regex" :
				result = L5.Validator["regex"](value, record, ruleParm);
				break;
			case "compare" :
				result = L5.Validator["compare"](value, record, ruleParm);
				break;
			case "unique" :
				result = L5.Validator["unique"](value, record, ruleParm);
				break;
			case "length" :
				result = L5.Validator["length"](value, record, ruleParm);
				break;
			case "lengthUTF8" ://中文字符按照UTF-8规范解释，即一个中文字符按照三个引文字符解释
				result = L5.Validator["lengthUTF8"](value, record, ruleParm);
				break;
			case "lengthGBK" ://中文字符按照UTF-8规范解释，即一个中文字符按照两个引文字符解释,与length是一样的，这里是为了命名风格统一
				result = L5.Validator["lengthGBK"](value, record, ruleParm);
				break;
			case "custom" :
				result = L5.Validator["custom"](value, record, ruleParm);
				break;
			default :
				result = L5.Validator["regex"](value, record, ruleName);
				break;
		}
		return result;
	},
	
	empty : function() {
		return true;
	},
	
	require : function(value, record) {
		if (value === null || value === "") {
			return "不能为空";
		} else {
			if (typeof value == 'string' && value.trim() === "")
				return "不能为空";
			return true;
		}
	},
	
	date : function(value, record, dateFormat) {
		if (value === null || value === "")
			return true;

		var isValidate =(value===undefined)?false:L5.isDateTime.call(value, dateFormat);

		if (isValidate == false) {
			var msg = "不是正确的日期格式";
			if (dateFormat !== null)
				msg = msg + "(" + dateFormat + ")";
			return msg;
		} else {
			return true;
		}
	},
	
	regex : function(value, record, regex) {
		if (value === null || value === "")
			return true;
		var pattern = $regexs[regex] || new RegExp(regex);
		if (pattern === null)
			return true;

		var isValidate = pattern.test(value);
		if (isValidate == false) {
			var msg = "格式不正确";
			/*if (regex !== null)
				msg = msg + "(" + regex + ")";*/
			return msg;
		} else {
			return true;
		}
	},
	
	equal : function(value, record, target) {
		if (value === null || value === "")
			return true;

		var targetVal = record.get(target) || target;
		if (value == targetVal) {
			return true;
		} else {
			var msg;
			if (record.get(target) !== null) {
				msg = "不等于" + target + "域的值";
			} else {
				msg = "不等于" + target;
			}
			return msg;
		}
	},
	
	compare : function(value, record, ruleParm) {
		if (value === null || value === "")
			return true;

		// var type=record.fields["fieldName"].type;
		var parms = ruleParm.split(",");
		var min, max, type;
		for (var i = 0; i < parms.length; i++) {
			if (parms[i].indexOf("min") >= 0) {
				min = parms[i].substring(parms[i].indexOf(":") + 1);
			}
			if (parms[i].indexOf("max") >= 0) {
				max = parms[i].substring(parms[i].indexOf(":") + 1);
			}
			if (parms[i].indexOf("type") >= 0) {
				type = parms[i].substring(parms[i].indexOf(":") + 1);
			} else {
				type = "string";
			}
		}
		var minVal = record.get(min) || min;
		var maxVal = record.get(max) || max;
		var result = true;
		switch (type) {
			case "number" :
				if (minVal !== null) {
					result = result && (value * 1 >= minVal * 1);
				}
				if (maxVal !== null) {
					result = result && (value * 1 <= maxVal * 1);
				}
				break;
			case "string" :
				if (minVal !== null) {
					result = result && (value.localeCompare(minVal) >= 0);
				}
				if (maxVal !== null) {
					result = result && (value.localeCompare(maxVal) <= 0);
				}
				break;
			default :
				// TODO: 其它类型数据
		}

		if (result == false) {
			var msg="必须";
			if (minVal !== null) {
				msg = msg + "大于" + minVal;
			}
			if (maxVal !== null) {
				msg = msg + "小于" + maxVal;
			}
			return msg;
		} else {
			return true;
		}

	},
	
	unique : function(value, record, union) {
		if (value === null || value === "")
			return true;

		var unions = union.split(",");
		var index = record.dataset.indexOf(record);
		for (var i = 0; i < unions.length; i++) {
			var val = record.get(unions[i]);
			for (var j = 0; j < record.dataset.getCount(); j++) {
				if (j == index)
					continue;
				if (val == record.dataset.getAt(j).get(unions[i])) {
					return "违反唯一性约束";
				}
			}
		}

		return true;
	},
	
	length : function(value, record, len) {
		if (value === null || value === "")
			return true;
		var len = len * 1;
		var strVal = value.toString()+"";
		var curLen = strVal.length;
		var chiArr=strVal.match(/[\u4E00-\u9FA5\uF900-\uFA2D]|[\uFF00-\uFFFF]/g);//匹配中文和全角
		if(chiArr!=null)curLen+=chiArr.length;
		if (curLen <= len) {
			return true;
		} else {
			if(chiArr!=null){
				return ("英文(中文)长度不能超过" + len+"("+Math.floor(len/2)+")个字符");
			}else{
				return ("长度不能超过" + len+"个字符");
			}
		}
	},
	/**
	 * 中文字符按照UTF-8规范解释，即一个中文字符按照三个引文字符解释
	 */
	lengthUTF8 : function(value, record, len) {
		if (value === null || value === "")
			return true;
		var len = len * 1;
		var strVal = value.toString()+"";
		var curLen = strVal.length;
		var chiArr=strVal.match(/[\u4E00-\u9FA5\uF900-\uFA2D]|[\uFF00-\uFFFF]/g);//匹配中文和全角
		if(chiArr!=null)curLen+=(chiArr.length*2);//将中文字符的长度再加两次这样就相当于乘以3
		if (curLen <= len) {
			return true;
		} else {
			if(chiArr!=null){
				return ("英文(中文)长度不能超过" + len+"("+Math.floor(len/3)+")个字符");
			}else{
				return ("长度不能超过" + len+"个字符");
			}
		}
	},
	/**
	 * 中文字符按照UTF-8规范解释，即一个中文字符按照两个引文字符解释,与length是一样的，这里是为了命名风格统一
	 */
	lengthGBK : function(value, record, len) {
		if (value === null || value === "")
			return true;
		var len = len * 1;
		var strVal = value.toString()+"";
		var curLen = strVal.length;
		var chiArr=strVal.match(/[\u4E00-\u9FA5\uF900-\uFA2D]|[\uFF00-\uFFFF]/g);//匹配中文和全角
		if(chiArr!=null)curLen+=chiArr.length;//将中文字符的长度再加一次这样就相当于乘以2
		if (curLen <= len) {
			return true;
		} else {
			if(chiArr!=null){
				return ("英文(中文)长度不能超过" + len+"("+Math.floor(len/2)+")个字符");
			}else{
				return ("长度不能超过" + len+"个字符");
			}
		}
	},
	
	custom : function(value, record, fn) {

		var parms = fn.split(",");
		var fnName;
		var args = new Array();
		args.push(value);
		args.push(record);
		if (parms.length > 0) {
			fnName = parms[0].substring(parms[0].indexOf(":") + 1);
			for (var i = 1; i < parms.length; i++) {
				argname = parms[i].substring(0, parms[i].indexOf(":"));
				argvalue = parms[i].substring(parms[i].indexOf(":") + 1);
				args.push(argvalue);
			}
			return (new Function("return " + fnName)())(args);

		}
		return true;

	},
	
	// 设置record和dataset的校验结果
	setValidate : function(name, record, result) {
		if (result === true) {
			if (record.validate[name] != null) {
				delete record.validate[name];
				var val = true;
				for (var v in record.validate) {
					if (record.validate[v] === false) {
						val = false;
						break;
					}
				}
				if (val === true){
					/**
					 * 问题描述：validated存放dataset相应位置的record的错误状态（false/true)，修改之前是按照索引号存储的
					 * 这样当删除这个record前面的记录的时候索引并未随之改变，当取错误信息的时候会发生位置错误
					 * 修改办法：将索引号变为record的id
					 * @author lipf
					 * @version 2011-01-12
					 */
					delete record.dataset.validated[record.id];
				}
			}
		} else {
			record.validate[name] = false;
			if(record.msgLable[name]==null)
			record.msgLable[name] = name;
			/**
			 * 问题描述：validated存放dataset相应位置的record的错误状态（false/true)，修改之前是按照索引号存储的
			 * 这样当删除这个record前面的记录的时候索引并未随之改变，当取错误信息的时候会发生位置错误
			 * 修改办法：将索引号变为record的id
			 * @author lipf
			 * @version 2011-01-12
			 */
			record.dataset.validated[record.id] = false;
		}
	}

};

