L5.HtmlExt = {
	/**
	 * 错误信息转换
	 * 
	 * @method L5.errorSwitch
	 * @param {String}
	 *            rule
	 * @return 数组
	 */
	errorSwitch : function(rule) {
		var result = new Array();
		var rules = rule.split("|");
		for (var j = 0; j < rules.length; j++) {
			var rule = rules[j];
			var ruleName = rule.substring(0, rule.indexOf("{"));
			switch (ruleName) {
				case "require" :
					result[j] = "不能为空";
					break;
				case "date" :
					result[j] = "不是正确的日期格式";
					break;
				case "equal" :
					result[j] = "不相等";
					break;
				case "regex" :
					result[j] = "格式不正确";
					break;
				case "compare" :
					result[j] = "不符合校验规则";
					break;
				case "length" :
					result[j] = "长度不正确";
					break;
				case "lengthUTF8" :
					result[j] = "长度不正确";
					break;
				case "lengthGBK" :
					result[j] = "长度不正确";
					break;
				case "custom" :
					result[j] = "不正确";
					break;
				default :
					result[j] = "格式不正确";
					break;
			}

		}
		return result;
	},
isValidateElement : function(ele){
var root = document.body;
var validators = L5.DomQuery.select("*[@validatorform]", root);
		for (var p = 0; p < validators.length; p++) {
			var validator = validators[p];
			var validatorform = validator.getAttribute("validatorform");
		}
		if (validatorform == "false") {
			return true;
		}else{L5.HtmlExt.validateElement(ele);
		}
},
	/**
	 * 单个输入框校验
	 * 
	 * @method L5.HtmlExt.isValidateElement
	 * @param {String}
	 *            ele dom对象
	 * @return {Boolean} 如果正确返回true
	 */

	validateElement : function(ele) {

		var root = document.body;
		var fieldList = L5.DomQuery.select("*[@rule]", root);
		var fieldname = ele.getAttribute("name")||ele.getAttribute("id")||ele.getAttribute("field");
			for (var p = 0; p < fieldList.length; p++) {
				var field = fieldList[p];
				var fieldname1 = field.getAttribute("name")||field.getAttribute("id")||field.getAttribute("field");
				var rule = field.getAttribute("rule");
				var value = field.value;
				var name = field.getAttribute("label")
						|| field.getAttribute("title")
						|| field.getAttribute("name");
				if (fieldname1 == fieldname) {
					var res = new Array();
					var resfalse = new Array();
					var errswitch = new Array();
					res = L5.HtmlExt.validateForm(field, rule, value);

					for (i = 0; i < res.length; i++) {
						if (res[i] != true) {
							resfalse = res;

						}

					}
					var sysmsg = resfalse.join();

					if (sysmsg == null || sysmsg == "") {
						sysmsg = true;

					} else {
						var errswitch = new Array();
						errswitch = L5.HtmlExt.errorSwitch(rule);
						sysmsg = errswitch.join();
					}
					// //
					// var sysmsg = res.join();

					// var sysmsg = L5.HtmlExt.validateForm(rule, value);

					L5.HtmlExt.setValidateInfoOnElement(field, sysmsg, name);
				}

			}
		return sysmsg;
	},
	/**
	 * 表单校验方法
	 * 
	 * @method L5.HtmlExt.isValidateAll
	 * @param
	 * @return {Boolean} 如果正确返回true
	 */
	isValidateAll : function() {
		var root = document.body;
		var res =new Array();
		var resfalse = new Array();
		var fieldList = L5.DomQuery.select("*[@rule]", root);
		for (var p = 0; p < fieldList.length; p++) {
			var field = fieldList[p];
			 res[p] =L5.HtmlExt.validateElement(field);
			
		}
		for (i = 0; i < res.length; i++) {
						if (res[i] != true) {
							resfalse = res;

						}

					}
			var sysmsg = resfalse.join();

					if (sysmsg == null || sysmsg == "") {
						sysmsg = true;

					} 
		if(sysmsg==true){
		return true;
		}else{return false;}
	},
	/**
	 * 规则解析
	 * 
	 * @method L5.HtmlExt.validateForm
	 * @param rule,
	 *            value
	 * @return 数组
	 */
	
	validateForm : function(field, rule, value) {
		var validates = new Array();
		var result = new Array();
		if (rule != null) {
			var rules = rule.split("|");
			for (var j = 0; j < rules.length; j++) {
				var rule = rules[j];
				var ruleName = rule.substring(0, rule.indexOf("{"));
				var ruleParm = rule.substring(rule.indexOf("{") + 1, rule
								.lastIndexOf("}"));
				if (rule.indexOf("{") < 0) {
					ruleName = rule;
					ruleParm = "";
				}
				switch (ruleName) {
					case "compare" :
						isValidate = L5.HtmlExt.compareValidator(value,
								ruleParm);
						validates[j] = isValidate;
						break;
					case "equal" :
						isValidate = L5.HtmlExt.equalValidator(value, ruleParm);
						validates[j] = isValidate;
						break;
					case "custom" :
						isValidate = L5.HtmlExt.customValidator(value, field,
								ruleParm);
						validates[j] = isValidate;
						break;
					case "regex" :
						isValidate = L5.HtmlExt.regexValidator(value, ruleParm);
						validates[j] = isValidate;
						break;
					default :

						isValidate = L5.Validator.ruleValidate(ruleName, value,
								ruleParm);
						validates[j] = isValidate;

						break;
				}

			}

			// L5.Validator.setValidate(name, record, isValidate);
			return validates;
		}
	},

	regexValidator : function(value, ruleParm) {
		if (value === null || value === "")
			return true;
		var pattern = $regexs[ruleParm] || new RegExp(ruleParm);
		if (pattern === null)
			return true;

		var isValidate = pattern.test(value);
		if (isValidate == false) {
			var msg = "格式不正确";
			/*
			 * if (regex !== null) msg = msg + "(" + regex + ")";
			 */
			return msg;
		} else {
			return true;
		}
	},
	customValidator : function(value, field, ruleParm) {
		var parms = ruleParm.split(",");
		var fnName;
		var args = new Array();
		args.push(value);
		args.push(field);
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
	equalValidator : function(value, ruleParm) {
		if (value === null || value === "")
			return true;
		var eles = document.getElementsByName(ruleParm);
		if (eles.length == 1) {
			var val = eles[0].value;
		} 
		else {
			throw exception();
			// alert("表单中配置的equal校验规则输入框名称不存在或者存在多个,请重新配置equal规则");
			return false;

		}

		if (value == val) {
			return true;
		} else {
			var msg;
			if (val !== null) {
				msg = "不等于" + ruleParm + "域的值";
			} else {
				msg = "不等于" + ruleParm;
			}
			return msg;
		}
	},

	compareValidator : function(value, ruleParm) {
		if (value === null || value === "")
			return true;

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
		var minVal = min;
		var maxVal = max;
		var result1 = true;
		switch (type) {
			case "number" :
				if (minVal !== null) {
					result1 = result1 && (value * 1 >= minVal * 1);
				}
				if (maxVal !== null) {
					result1 = result1 && (value * 1 <= maxVal * 1);
				}
				break;
			case "string" :
				if (minVal !== null) {
					result1 = result1 && (value.localeCompare(minVal) >= 0);
				}
				if (maxVal !== null) {
					result1 = result1 && (value.localeCompare(maxVal) <= 0);
				}
				break;
			default :
		}
		if (result1 == false) {
			var msg = "必须";
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
	/**
	 * 校验信息显示
	 * 
	 * @method L5.HtmlExt.setValidateInfoOnElement
	 * @param field,
	 *            sysmsg, name
	 * @return
	 */
	setValidateInfoOnElement : function(field, sysmsg, name) {
		var root = document.body;
		var messagevisibles = L5.DomQuery.select("*[@messagevisible]", root);
		var myDiv = document.createElement("div")
		myDiv.id = field.id + "010A";
		var id = myDiv.id;
		var div = document.getElementById(id);
		var mySpan = document.createElement("span")
		mySpan.id = field.id + "010A";
		var id = mySpan.id;
		var span = document.getElementById(id);
		for (var p = 0; p < messagevisibles.length; p++) {
			var messagevisible = messagevisibles[p];
			var messagevisiblevalue = messagevisible
					.getAttribute("messagevisible");
		}
		var extEle = L5.get(field);
		var msg = field.getAttribute("CustomValidity");
		// var mySpan = document.createElement("span")
		// mySpan.id = field.id + "010A";
		// var id = mySpan.id;
		// var span = document.getElementById(id);
		if (msg == null || msg == "") {
			msg = name + sysmsg;
		}

		switch (messagevisiblevalue) {
			case "right" :
				if (sysmsg != true)

				{

					extEle.setStyle("border-color", "#FA8072");
					// field.setAttribute("L5:qtitle", "校验错误");
					// field.setAttribute("L5:qtip", msg);

					if (span != null) {
						span.parentNode.removeChild(span);
					}
					field.parentNode.appendChild(mySpan);
					mySpan.style.top = 200;
					mySpan.style.left = 200;
					mySpan.style.color = 'red';
					mySpan.style.visibility = 'visible';
					mySpan.innerHTML = msg;
				} else {

					extEle.setStyle("border-color", "");
					// field.removeAttribute("L5:qtitle");
					// field.removeAttribute("L5:qtip");

					if (span != null) {
						span.parentNode.removeChild(span);
					}

				}
				break;
			case "below" :
				if (sysmsg != true)

				{

					extEle.setStyle("border-color", "#FA8072");
					// field.setAttribute("L5:qtitle", "校验错误");
					// field.setAttribute("L5:qtip", msg);

					if (div != null) {
						div.parentNode.removeChild(div);
					}
					field.parentNode.appendChild(myDiv);
					myDiv.style.top = 200;
					myDiv.style.left = 200;
					myDiv.style.color = 'red';
					myDiv.style.visibility = 'visible';
					myDiv.innerHTML = msg;
				} else {
					extEle.setStyle("border-color", "");
					// field.removeAttribute("L5:qtitle");
					// field.removeAttribute("L5:qtip");

					if (div != null) {
						div.parentNode.removeChild(div);
					}

				}
				break;

			default :

				if (sysmsg != true)

				{
					extEle.setStyle("border-color", "#FA8072");
					field.setAttribute("L5:qtitle", "校验错误");
					field.setAttribute("L5:qtip", msg);

				} else {
					extEle.setStyle("border-color", "");
					field.removeAttribute("L5:qtitle");
					field.removeAttribute("L5:qtip");

				}

		}

		// return msg;
	}

}
