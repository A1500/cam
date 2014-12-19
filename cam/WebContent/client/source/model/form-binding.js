/**
 * @private 绑定当前页面的所有html元素
 * @method L5.bindingdata
 * @param {Object}
 *            root
 * @constructor
 */
L5.bindingdata = function(root) {
	if (!root)
		root = document.body;

	// 先处理下拉框的选项绑定
	var optionList = L5.DomQuery.select("option[@dataset]", root);
	for ( var i = 0; i < optionList.length; i++) {
		var selectNode = L5.get(optionList[i]).findParent("select");
		if (selectNode == null) {
			return;
		}
		var id = optionList[i].getAttribute("dataset");
		var ds = L5.DatasetMgr.lookup(id);
		if (selectNode.L5_Binded != true) {
			var options = new L5.databind.Options(selectNode);
			options.bind(ds);
		}
	}
	// 处理单选、复选框group绑定
	var radio_checkboxList = L5.DomQuery.select("input[@dataset]", root);
	for ( var i = 0; i < radio_checkboxList.length; i++) {
		if (radio_checkboxList[i].L5_Binded != true) {
			var type = radio_checkboxList[i].getAttribute("type");
			if (!type || (type != "radio" && type != "checkbox")) {
				continue;
			}
			var id = radio_checkboxList[i].getAttribute("dataset");
			var ds = L5.DatasetMgr.lookup(id);
			var radio_checkbox = new L5.databind.Radio_Checkbox(
					radio_checkboxList[i]);
			radio_checkbox.bind(ds);
		}
	}
	// 处理其他绑定
	var formList = L5.DomQuery.select("*[@dataset]", root);
	for ( var i = 0; i < formList.length; i++) {
		var simpleTable = true;
		var id = formList[i].getAttribute("dataset");
		var ds = L5.DatasetMgr.lookup(id);
		if (formList[i].nodeName.toLowerCase() == "option") {// 前面已经处理
			continue;
		} else if (formList[i].nodeName.toLowerCase() == "input") {
			var type = formList[i].getAttribute("type");
			if (type && (type == "radio" || type == "checkbox")) {// 前面已经处理
				continue;
			}
		} else if (formList[i].nodeName.toLowerCase() == "label") {
			var parent = L5.get(formList[i]).findParentNode("[@dataset]");
			var property = formList[i].getAttribute("field");
			var dataset = L5.DatasetMgr.lookup(parent.getAttribute("dataset"));
			if (dataset.getCount() > 0) {
				var val = dataset.getCurrent().get(property);
				L5.databind.setValueOfLabelElement(formList[i], val);
			}
		} else if (formList[i].nodeName.toLowerCase() == "table") {
			if (L5.DomQuery.select("*[@repeat]", formList[i]).length > 0) {
				simpleTable = false;// 多行绑定
			}
		}
		if (formList[i].L5_Binded != true) {
			if (simpleTable) {
				if (formList[i].nodeName.toLowerCase() == "label")
					continue;
				var form = new L5.databind.Form(formList[i]);
				form.bind(ds);
			} else {
				var table = new L5.databind.Table(formList[i]);
				table.bind(ds);
			}
		}
	}
	/**
	 * 处理第一次绑定后的情况，即使没有参与绑定，但是有valueTip的element也应该参与到这里面
	 */
	var valueTipList = L5.DomQuery.select("*[@valueTip]", root);
	for ( var i = 0; i < valueTipList.length; i++) {
		var ele = valueTipList[i];
		var valtip = ele.getAttribute("valueTip");
		if (valtip == true || valtip == "true" || valtip == "TRUE") {
			ele.setAttribute("title", L5.databind.getShowTextOfElement(ele));
			L5.get(ele).on(
					"change",
					function() {
						ele.setAttribute("title", L5.databind
								.getShowTextOfElement(ele));
					});
		}
	}
}

/**
 * 为了在outline中显示js方法
 * 
 * @constructor
 */
L5.databind = function() {

}

/**
 * dataset绑定列表框的option，自动添加选项
 * 
 * @class L5.databind.Options
 * @private
 */
L5.databind.Options = function(ele) {
	this.ele = ele;
	// 设置已经binding过，防止重复binding。
	this.ele.L5_Binded = true;
	this.ele.setAttribute("optionload", false);

	/**
	 * @private 根据dataset的数据创建下拉框的选项
	 * @method L5.databind.Options.build
	 * @param {L5.model.Dataset}
	 *            dataset
	 */
	this.build = function(dataset) {
		// 清空旧选项
		this.ele.options.length = 0;
		// 增加“请选择”选项
		if (dataset.getCount() > 0) {
			var noPlease = this.ele.getAttribute("noPlease");
			if (!noPlease)
				this.ele.options.add(new Option("请选择……", ""));
		}
		// 增加其他option
		for ( var i = 0; i < dataset.getCount(); i++) {
			var record = dataset.getAt(i);
			var text = record.get("text");
			var value = record.get("value");
			this.ele.options.add(new Option(text, value));
		}
		this.ele.setAttribute("optionload", true);
		// 如果对应的select有值(比如执行过form的绑定),需要设置对应的option为选中状态
		var val = this.ele.getAttribute("value1");// 在ie下,如果没有options,value只能为空串
		var saveVal = this.ele.getAttribute("saveVal");
		var onchange1 = ele.getAttribute("onchange1");
		// value1是设置的默认value值，而saveVal是record里面的值。
		if (saveVal && saveVal != "") {
			L5.databind.selectOptions(this.ele, saveVal);
			if (onchange1 != null) {
				L5.databind.change1(ele, "change1");
			} else {
				L5.fireEvent(ele, "change");
			}
		} else if (val && val != "") {
			L5.databind.selectOptions(this.ele, val);
			if (saveVal != null) {
				if (onchange1 != null) {
					L5.databind.change1(ele, "change1");
				} else {
					L5.fireEvent(ele, "change");
				}
			}
		} else {
			if (this.ele.options.length > 0) {
				this.ele.options[0].selected = true;
				if (this.ele.options[0].value != "") {
					if (saveVal != null) {
						if (onchange1 != null) {
							L5.databind.change1(ele, "change1");
						} else {
							L5.fireEvent(ele, "change");
						}
					}
				}
			}
		}
	};

	/**
	 * @private 和一个dataset绑定：监听该dataset的load事件
	 * @method L5.databind.Options.bind
	 * @param {L5.model.Dataset}
	 *            dataset
	 */
	this.bind = function(dataset) {
		dataset.on("datachanged", this.build, this);
		dataset.on("load", this.build, this);
		// dataset可能已经提前加载了:
		this.build(dataset);
	};
}

/**
 * 单选框、复选框组(group),根据一个单选框、复选框复制成多个,形成一个组
 * 
 * @class L5.databind.Radio_Checkbox
 * @private
 */
L5.databind.Radio_Checkbox = function(ele) {
	this.ele = ele;
	this.ele.style.display = "none";// 把原有的隐藏
	// 设置已经binding过，防止重复binding。
	this.ele.L5_Binded = true;

	/**
	 * @private 根据dataset的数据创建单选/多选框
	 * @method L5.databind.Radio_Checkbox.build
	 * @param {L5.model.Dataset}
	 *            dataset
	 */
	this.build = function(dataset) {
		var parent = this.ele.parentNode;
		// 先清空旧的(先把要删除的找出来，再挨个删，因为removechild方法会实时影响数组childenodes)
		var removeList = new Array();
		var childList = parent.childNodes;
		for (i = 0; i < childList.length; i++) {
			var node = childList[i];
			if (node.L5_Created == true) {
				removeList.push(node);
			}
		}
		for (i = 0; i < removeList.length; i++) {
			parent.removeChild(removeList[i]);
		}
		// 再创建新的
		var str = this.ele.id;
		if (str == "")
			str = this.ele.name;

		var checkObj;
		for ( var i = 0; i < dataset.getCount(); i++) {
			var record = dataset.getAt(i);
			var newRadio_Checkbox = this.ele.cloneNode(true);
			newRadio_Checkbox.id += str + "_" + i;
			newRadio_Checkbox.L5_Created = true;
			newRadio_Checkbox.removeAttribute("dataset");
			newRadio_Checkbox.setAttribute("value", record.get("value"));
			newRadio_Checkbox.style.display = "";
			parent.appendChild(newRadio_Checkbox);

			if (this.ele.getAttribute("checked") == "checked"
					|| this.ele.getAttribute("checked") == "true"
					|| this.ele.getAttribute("checked") == true) {
				if (i == 0) {
					checkObj = newRadio_Checkbox;
				}
				if (this.ele.value === record.get("value")) {
					checkObj = newRadio_Checkbox;
				} else {
					newRadio_Checkbox.checked = false;
				}
			} else {
				newRadio_Checkbox.checked = false;
			}
			// 复选框、单选框的文字
			var spanNode = document.createElement("span");
			spanNode.L5_Created = true;
			var textNode = document.createTextNode(record.get("text"));
			spanNode.appendChild(textNode);
			parent.appendChild(spanNode);
		}
		if (checkObj) {
			checkObj.checked = true;
		}
	};

	/**
	 * @private 和一个dataset绑定：监听该dataset的load事件
	 * @method L5.databind.Radio_Checkbox.bind
	 * @param {L5.model.Dataset}
	 *            dataset
	 */
	this.bind = function(dataset) {
		dataset.on("datachanged", this.build, this);
		dataset.on("update", this.build, this);
		// dataset.on("add", this.build, this);
		// dataset.on("remove", this.build, this);
		// dataset可能已经提前加载了:
		this.build(dataset);
	};
}

/**
 * dataset绑定form
 * 
 * @class L5.databind.Form
 * @private
 */
L5.databind.Form = function(ele) {
	this.ele = ele;
	// 设置已经binding过，防止重复binding。
	this.ele.L5_Binded = true;
	this.onbind;

	/**
	 * @private 取record的值，给form元素赋值
	 * @method L5.databind.Form.setValue
	 * @param {L5.model.Dataset}
	 *            dataset
	 * @param {L5.model.Record}
	 *            record
	 * @param edit
	 * @param dom元素
	 *            srcElement
	 * @param {String}
	 *            field 指定需要绑定域名称
	 */
	this.setValue = function(dataset, record, edit, srcElement, field) {
		/**
		 * 当由element_value_change方法调用record的set方法的时候不需要再一次设置值
		 * 因为是由ele触发的record.set方法，不在这里返回的时候就会死循环 这时候会有一个srcElement属性
		 */
		if (srcElement && srcElement == this.ele) {
			return;
		}
		var fieldList = L5.DomQuery.select("*[@field]", this.ele);

		if (this.ele.getAttribute("field") != null) {// 一个元素同时具有dataset和field属性
			fieldList.push(ele);
		}
		if (dataset.getCount() <= 0) {// 没有数据:隐藏form
			ele.style.visibility = "hidden";
			return;
		}
		ele.style.visibility = "";
		// 获取不在获取当前的record，而是根据查询条件来获取record
		var record = null;
		var param = this.ele.getAttribute("filter");
		if (param != null && param != "") {
			var params = param.split("=");
			var i = dataset.find(params[0], params[1]);
			if (i != -1) {
				record = dataset.getAt(i);
			} else {
				ele.style.visibility = "hidden";
				return;
			}
		} else {
			record = dataset.getCurrent();
		}
		for ( var j = 0; j < fieldList.length; j++) {
			if (!record) {
				break;
			}
			L5.databind.setupElementAccordtoRecord(fieldList[j], record, field);
		}
		// onbind
		if (this.onbind) {
			this.onbind();
		}
	};

	/**
	 * 加onchange、onblur事件，把输入框的值写到dataset
	 * 
	 * @method L5.databind.Form.addEventListenerOnElement
	 * @private
	 * @param dom元素
	 *            ele
	 */
	this.addEventListenerOnElement = function(ele) {
		var fieldList = L5.DomQuery.select("*[@field]", ele);
		// dataset和porperty在同一个element中
		if (ele.getAttribute("field") != null) {
			var type = ele.getAttribute("type");
			if (type && type != "radio" && type != "checkbox") {
				fieldList.push(ele);
			}
		}
		for ( var j = 0; j < fieldList.length; j++) {
			L5.databind.addEventListenerOnElement(fieldList[j], this.ele);
		}
	}

	/**
	 * @private 绑定：设置dataset的监听事件，从dataset中取数据设置form域的值
	 * @method L5.databind.Form.bind
	 * @param {L5.model.Dataset}
	 *            dataset
	 */
	this.bind = function(dataset) {
		var str = this.ele.getAttribute("onbind");
		if (str != null && str != "") {
			this.onbind = window[str];
		}
		this.addEventListenerOnElement(this.ele);
		dataset.on("datachanged", this.setValue, this);
		dataset.on("move", this.setValue, this);
		dataset.on("add", this.setValue, this);
		dataset.on("remove", this.setValue, this);
		// 待改进：不是修改当前行,不需要重新绑定
		// 稍作了改进，精确到哪个域修改了，然后绑定该域
		dataset.on("update", this.setValue, this);
		dataset.on("validateFailed", this.uniteFalseStyle, this);
		// dataset可能已经提前加载了:
		this.setValue(dataset);
	};

	/**
	 * @private 统一错误域的样式
	 * @method L5.databind.Form.uniteFalseStyle
	 */
	this.uniteFalseStyle = function() {
		L5.databind.uniteFalseStyle();
	};
}

/**
 * dataset绑定table
 * 
 * @class L5.databind.Table
 * @private
 */
L5.databind.Table = function(ele) {
	this.ele = ele;
	// 设置已经binding过，防止重复binding。
	this.ele.L5_Binded = true;

	/**
	 * @private 取dataset的值，给Table元素赋值
	 * @method L5.databind.Table.setvalue
	 * @param {L5.model.Dataset}
	 *            dataset
	 * @param {L5.model.Record}
	 *            rec
	 * @param edit
	 * @param dom元素
	 *            srcElement
	 * @param {String}
	 *            field 指定需要绑定域名称
	 */
	this.setvalue = function(dataset, rec, edit, srcElement, field) {
		// 参照form的注释
		if (srcElement || srcElement == this.ele) {
			return;
		}
		this.bindingTableForm(this.ele, dataset, rec, edit, srcElement, field);
	};

	/**
	 * @private 绑定：设置dataset的监听事件，从dataset中取数据设置table的值
	 * @method L5.databind.Table.bind
	 * @param {L5.model.Dataset}
	 *            dataset
	 */
	this.bind = function(dataset) {
		dataset.on("datachanged", this.setvalue, this);
		dataset.on("move", this.setvalue, this);
		dataset.on("add", this.setvalue, this);
		dataset.on("remove", this.setvalue, this);
		dataset.on("update", this.setvalue, this);
		dataset.on("validateFailed", this.uniteFalseStyle, this);
		if (dataset.getCount() > 0) {
			this.setvalue(dataset);
		}
	};

	/**
	 * @private 统一错误域的样式
	 * @method L5.databind.Table.uniteFalseStyle
	 */
	this.uniteFalseStyle = function() {
		L5.databind.uniteFalseStyle();
	};

	/**
	 * @private dataset绑定table，html页面写出一行模板后自动创建完整的table
	 * @method L5.databind.Table.bindingTableForm
	 * @param dom元素
	 *            ele
	 * @param {L5.model.Dataset}
	 *            dataset
	 * @param {L5.model.Record}
	 *            rec
	 * @param edit
	 * @param dom元素
	 *            srcElement
	 * @param {String}
	 *            field 指定需要绑定域名称
	 */
	this.bindingTableForm = function(ele, dataset, rec, edit, srcElement, field) {
		if (ele == null || dataset == null) {
			return;
		}

		// 浏览器会自动为table添加tbody元素
		var eTBody = ele.getElementsByTagName("tbody");
		var trRepeats = L5.DomQuery.select("*[@repeat]", eTBody[0]);

		// table标签不考虑翻页问题，列示dataset中全部元素
		// 写html页面时，需要自动加载的列表数据行，在tr中添加repeat属性，
		// 复制该行html代码后删除repeat属性，避免刷新页面时重复添加行
		// 在重复行的tr中添加record属性，记录对应dataset中那条记录
		var colLine = dataset.getCount();

		var repeatCount = trRepeats.length;
		for ( var i = 0; i < trRepeats.length; i++) {
			trRepeats[i].style.display = "none";
		}

		var docFragment = document.createDocumentFragment();
		var trRecords = L5.DomQuery.select("*[record]", eTBody[0]);
		var repeatNow = trRecords.length / repeatCount;
		for ( var i = colLine * repeatCount; i < trRecords.length; i++) {
			// 删除table中的多余记录
			var fieldList = L5.DomQuery.select("*[@field]", trRecords[i]);
			for ( var j = 0; j < fieldList.length; j++) {
				L5.EventManager.un(fieldList[j], "blur",
						L5.databind.element_value_change);
				L5.EventManager.un(fieldList[j], "change",
						L5.databind.element_value_change);
			}
			eTBody[0].removeChild(trRecords[i]);
			L5.get(trRecords[i]).remove();
		}
		// 创建新增的重复行
		for ( var i = repeatNow; i < colLine; i++) {
			for ( var j = 0; j < trRepeats.length; j++) {
				var newTr = trRepeats[j].cloneNode(true);
				newTr.setAttribute("record", i);
				newTr.removeAttribute("repeat");
				newTr.style.display = "none";
				var fieldList = L5.DomQuery.select("*[@id]", newTr);
				// 自动生成ID
				for ( var k = 0; k < fieldList.length; k++) {
					var id = fieldList[k].getAttribute("id").concat(i);
					fieldList[k].setAttribute("id", id);
				}
				docFragment.appendChild(newTr);
			}
		}
		eTBody[0].appendChild(docFragment);

		// 设置表中数据，添加change value事件
		var trs = L5.DomQuery.select("tr[record]", eTBody[0]);
		for ( var i = 0; i < trs.length; i++) {
			var record = trs[i].getAttribute("record");
			var recordNode = dataset.getAt(record);
			if (rec && field && recordNode && rec.id != recordNode.id) {
				continue;
			}
			trs[i].style.display = "";
			var fieldList = L5.DomQuery.select("*[@field]", trs[i]);
			for ( var j = 0; j < fieldList.length; j++) {
				L5.databind.setupElementAccordtoRecord(fieldList[j],
						recordNode, field);
				L5.databind.addEventListenerOnElement(fieldList[j], ele);
			}
		}
	}
}
/**
 * @private 根据record的信息设置element的内容
 * @method L5.databind.addEventListenerOnElement
 * @param dom元素
 *            ele
 * @param 需绑定的table
 *            table
 */
L5.databind.setupElementAccordtoRecord = function(ele, record, field) {
	var property = ele.getAttribute("field");
	if (record && record.msgIndex[property] == undefined) {
		record.msgIndex["msg_index_"] = record.msgIndex["msg_index_"] != undefined ? record.msgIndex["msg_index_"] + 1
				: 0;
		record.msgIndex[property] = record.msgIndex["msg_index_"];
		record.msgIndex[record.msgIndex["msg_index_"]] = property;
	}
	var name = ele.getAttribute("label") || ele.getAttribute("title")
			|| ele.getAttribute("name");
	if (record && record.msgLable) {
		record.msgLable[property] = name ? name : property;
	}

	if (record == null) {
		L5.databind.setValueOfElement(ele, "");
	} else {
		if (field) {
			if (property == field) {
				L5.databind.setValueOfElement(ele, record.get(property));
				L5.Validator.validate(record, property, record.get(property));
				L5.databind.setValidateInfoOnElement(ele, record, true);
			}
		} else {
			var htmlValue = /\<|\>/;
			var dataValue = record.get(property);
			if (htmlValue.test(dataValue)) {
				dataValue = L5.util.Format.htmlEncode(dataValue);
			}
			L5.databind.setValueOfElement(ele, dataValue);
			L5.Validator.validate(record, property, record.get(property));
			L5.databind.setValidateInfoOnElement(ele, record, true);
		}
	}
}
/**
 * @private 给html元素加事件,从而实现把修改过的值写到dataset中
 * @method L5.databind.addEventListenerOnElement
 * @param dom元素
 *            ele
 * @param 需绑定的table
 *            table
 */
L5.databind.addEventListenerOnElement = function(ele, table) {
	var type = ele.nodeName.toLowerCase();
	if (type == "select" || ele.getAttribute("systype") == "itemselector") {
		L5.get(ele).un("change", L5.databind.element_value_change, table);
		L5.get(ele).on("change", L5.databind.element_value_change, table);
		return;
	}
	// 其他
	L5.get(ele).un("blur", L5.databind.element_value_change, table);
	L5.get(ele).on("blur", L5.databind.element_value_change, table);
}

/**
 * @private 根据页面element获取绑定的record
 * @method L5.databind.getRecord
 * @param dom元素
 *            ele
 * @param 所属form
 *            form
 * @return {L5.model.Record} record
 */
L5.databind.getRecord = function(ele, form) {
	var dataset;
	if (ele.getAttribute("dataset") != null) {
		dataset = L5.DatasetMgr.lookup(ele.getAttribute("dataset"));
	} else {
		if (form != null) {
			dataset = L5.DatasetMgr.lookup(form.getAttribute("dataset"));
		} else {
			var eDataset = L5.get(ele).findParent("[@dataset]");
			dataset = L5.DatasetMgr.lookup(eDataset.getAttribute("dataset"));
		}
	}
	var tRow = L5.get(ele).findParent("tr");
	var record;
	var param = form.getAttribute("filter");
	if (tRow != null && tRow.getAttribute("repeat") != null) {
		return null;
	} else if (tRow != null && tRow.getAttribute("record") != null) {
		record = dataset.getAt(tRow.getAttribute("record"));
	} else if (form && param != null && param != "") {
		var params = param.split("=");
		var i = dataset.find(params[0], params[1]);
		var record = null;
		if (i != -1) {
			record = dataset.getAt(i);
		}
	} else {
		record = dataset.getCurrent();
	}
	return record;
}

/**
 * @private 表单域失去焦点时触发的事件：设置record的值、执行校验
 * @method L5.databind.element_value_change
 * @param dom元素
 *            e
 */
L5.databind.element_value_change = function(e) {
	var ele = e.getTarget();
	var property = ele.getAttribute("field");
	if (!property) {// render情况，被复制的那个ele触发的无意义，直接返回
		return;
	}
	var record;
	try {
		record = L5.databind.getRecord(ele, this);
	} catch (exp) {
		// 获取不到record的异常处理
		return;
	}
	if (!record)
		return;
	var val = L5.databind.getValueOfElement(ele);
	// ie6下，下拉框跳动问题，以后如果换下拉框实现，可以去掉。暂时移到L5.gridview的onUpdate方法中处理
	// var result = record.set.defer(1,record,[property,val]);
	var result = record.set(property, val, this);// 设置值(包括校验)

	L5.databind.setValidateInfoOnElement(ele, record);
	L5.HtmlExt.isValidateElement(ele);
	if (ele.getAttribute("renderer")) {
		var renEl = ele.previousSibling;
		L5.databind.setValidateInfoOnElement(renEl, record, false, property);
	}

	if (result instanceof Array) {
		for ( var i = 0; i < result.length; i++) {
			L5.databind.reflect_element(ele, result[i], record);
		}
	}
}

/**
 * @private 把校验结果设置到绑定元素
 * @method L5.databind.reflect_element
 * @param dom元素
 *            ele
 * @param {String}
 *            field域名称
 * @param {L5.model.Record}
 *            record
 */
L5.databind.reflect_element = function(ele, field, record) {
	var eDataset = L5.get(ele).findParent(
			"[@dataset=" + record.dataset.ds + "]");
	var tRow = L5.get(ele).findParent("tr");
	var e;
	if (tRow != null && tRow.getAttribute("record") != null) {
		e = L5.DomQuery.select("*[@field=" + field + "]", tRow);
	} else {
		e = L5.DomQuery.select("*[@field=" + field + "]", eDataset);
	}
	for ( var i = 0; i < e.length; i++) {
		L5.databind.setValidateInfoOnElement(e[i], record);
	}
}

/**
 * @private 将校验结果设置在element的属性上,便于ext的tooltip显示
 * @method L5.databind.setValidateInfoOnElement
 * @param dom元素
 *            ele
 * @param {L5.model.Record}
 *            record
 * @param {boolean|Object}
 *            nored是否有绑定的记录
 */
L5.databind.setValidateInfoOnElement = function(ele, record, nored, fieldp) {
	var extEle = L5.get(ele);
	var msg = "";
	var property = fieldp ? fieldp : ele.getAttribute("field");

	if (record.validate[property] != null) {
		if (ele.getAttribute("msg") != null) {
			msg = ele.getAttribute("msg");
		} else {
			var name = ele.getAttribute("label") || ele.getAttribute("title")
					|| ele.getAttribute("name");
			if (record.msg[property] != null) {
				if (name) {
					record.msgLable[property] = name;
				} else {
					record.msgLable[property] = property;
				}
				msg = record.msgLable[property] + record.msg[property];
			}
		}
		if (ele.nodeName.toLowerCase() == "input") {
			if (ele.type == "radio" || ele.type == "checkbox") {
				ele = ele.parentNode;
				extEle = L5.get(ele);
			}
		}
		if (nored) {// 没有record的时候不设置
			extEle.setStyle("border-color", "");
		} else {
			extEle.setStyle("border-color", "#FA8072");
			ele.setAttribute("L5:qtitle", "校验错误");
			ele.setAttribute("L5:qtip", msg);
		}
	} else {
		if (ele.nodeName.toLowerCase() == "input") {
			if (ele.type == "radio" || ele.type == "checkbox") {
				ele = ele.parentNode;
				extEle = L5.get(ele);
			}
		}
		extEle.setStyle("border-color", "");
		ele.removeAttribute("L5:qtitle");
		ele.removeAttribute("L5:qtip");
	}
}
L5.databind.dealWidthRender = function(ele, val, render) {
	var eleCopy = ele.cloneNode(true);
	ele.parentNode.insertBefore(eleCopy, ele);
	ele.style.display = "none";
	eleCopy.removeAttribute("field");
	eleCopy.removeAttribute("renderer");
	ele.setAttribute("rendererDealed", true);
	eleCopy.id = ele.id + "_copy";

	L5.get(eleCopy).on("focus", function() {
		eleCopy.style.display = "none";
		ele.style.display = "";
		L5.get(ele).focus();
	});

	L5.get(ele).on("blur", function() {
		ele.style.display = "none";
		eleCopy.style.display = "";
		L5.databind.dealWidthRender.changeCopyEl(eleCopy, ele, render);
	});

	L5.get(ele).on(
			"change",
			L5.databind.dealWidthRender.changeCopyEl.createCallback(eleCopy,
					ele, render));
}
L5.databind.dealWidthRender.changeCopyEl = function(eleCopy, ele, render) {
	var renVal = "";
	var eleValue = L5.databind.getValueOfElement(ele);
	if (typeof render == "function") {
		renVal = render(eleValue, eleCopy);
	} else {
		renVal = window[render] ? window[render](eleValue, eleCopy) : eleValue;
	}
	L5.databind.setValueOfElement(eleCopy, renVal);
}
/**
 * @private 给一个html元素赋值,文本框、下拉框、单选框、复选框,其他...
 * @method L5.databind.setValueOfElement
 * @param dom元素
 *            ele
 * @param {Object}
 *            val
 */
L5.databind.setValueOfElement = function(ele, val) {
	var render = ele.getAttribute("renderer");
	if (render && !ele.getAttribute("rendererDealed")) {// 增加form的render
		L5.databind.dealWidthRender(ele, val, render);
	}

	if (ele == null) {
		return;
	}
	if (val == null) {
		val = "";
	}
	if (ele.nodeName.toLowerCase() == "select") {
		L5.databind.setValueOfSelectElement(ele, val);
		ele.setAttribute("saveVal", val);
		return;
	}

	if (ele.nodeName.toLowerCase() == "input") {
		if (ele.type == "radio" || ele.type == "checkbox") {
			L5.databind.setValueOfChkRadElement(ele, val);
			return;
		} else if (ele.getAttribute("systype") == "itemselector") {// 双栏边框组件
			var cmp = L5.getCmp(ele.getAttribute("id"));
			if (cmp) {
				cmp.setSelectedValues(val);
			}
		} else {
			ele.value = val;
		}
		try {
			L5.databind.change1(ele, "change1");
		} catch (e) {
		}
		return;
	}
	if (ele.nodeName.toLowerCase() == "label"
			&& ele.getAttribute("dataset") != null) {
		L5.databind.setValueOfLabelElement(ele, val);
		try {
			if (render) {
				L5.databind.dealWidthRender.changeCopyEl(ele.previousSibling,
						ele, render);
			}
		} catch (e) {

		}
		return;
	}

	if (ele.nodeName.toLowerCase() == "textarea") {
		ele.value = val;
		try {
			L5.databind.change1(ele, "change1");
		} catch (e) {
		}
		return;
	}

	if (ele.textContent) {
		ele.textContent = val;
	} else if (ele.innerText) {
		ele.innerText = val;
	} else {
		ele.innerHTML = val;
	}
	try {
		if (render) {
			L5.databind.dealWidthRender.changeCopyEl(ele.previousSibling, ele,
					render);
		}
	} catch (e) {

	}
}

/**
 * @private 设置枚举的label
 * @method L5.databind.setValueOfLabelElement
 * @param dom元素
 *            ele
 * @param {Object}
 *            val
 */
L5.databind.setValueOfLabelElement = function(ele, val) {
	if (val === "") {
		ele.value = "";
	} else {
		var ds = L5.DatasetMgr.lookup(ele.getAttribute("dataset"));
		ele.innerHTML = val;
		for ( var i = 0; i < ds.getCount(); i++) {
			var record = ds.getAt(i);
			var labelKey = ele.getAttribute("labelKey");
			if (!labelKey)
				labelKey = "value";

			var labelValue = ele.getAttribute("labelValue");
			if (!labelValue)
				labelValue = "text";

			var key = record.get(labelKey);
			if (key == val) {
				ele.innerHTML = record.get(labelValue);
				break;
			} else
				continue;
		}
	}
	// label不支持onchange
	// L5.fireEvent(ele,"change");
}

/**
 * @private 设置下拉框的值,如果值是个数组,多选
 * @method L5.databind.setValueOfSelectElement
 * @param dom元素
 *            ele
 * @param {Object}
 *            val
 */
L5.databind.setValueOfSelectElement = function(ele, val) {
	var onchange1 = ele.getAttribute("onchange1");
	if (ele.optionload === false)
		return;
	if (val === "") {
		if (ele.value1 && ele.value1 != "" && ele.options.length > 0) {
			// 设置默认的value1的值。
			L5.databind.selectOptions(ele, ele.value1);
			try {
				if (onchange1 != null) {
					L5.databind.change1(ele, "change1");
				} else {
					L5.fireEvent(ele, "change");
				}
			} catch (e) {

			}
		} else if (ele.options.length > 0) {
			ele.options[0].selected = true;
			if (ele.options[0].value !== "") {
				try {
					if (onchange1 != null) {
						L5.databind.change1(ele, "change1");
					} else {
						L5.fireEvent(ele, "change");
					}
				} catch (e) {

				}
			}
		}

	} else {
		var flag = L5.databind.selectOptions(ele, val);
		try {
			if (onchange1 != null) {
				L5.databind.change1(ele, "change1");
			} else {
				L5.fireEvent(ele, "change");
			}
		} catch (e) {

		}
	}
}

/**
 * @private 根据记录值设置下拉框的选中状态
 * @method L5.databind.selectOptions
 * @param dom元素
 *            ele
 * @param {Object}
 *            val
 * @return {boolean} 是否选中
 */
L5.databind.selectOptions = function(ele, val) {
	var flag = false;
	if (!L5.isArray(val))
		val = [ val ];
	var i;
	var j;
	for (i = 0; i < ele.options.length; i++) {
		ele.options[i].selected = false;
		for (j = 0; j < val.length; j++) {
			var sss = "" + val[j];// string
			if (ele.options[i].value == sss) {
				ele.options[i].selected = true;
				flag = true;
			}
		}
	}
	return flag;
}

/**
 * @private 设置单选、复选框的值
 * @method L5.databind.setValueOfChkRadElement
 * @param dom元素
 *            ele
 * @param {Object}
 *            val
 */
L5.databind.setValueOfChkRadElement = function(ele, val) {
	var valArray;
	if (typeof val == 'string')
		valArray = val.split(",");
	else
		valArray = [ val ];

	if (ele.value == "") {
		ele.value = val;
		L5.databind.change1(ele, "change1");
		return;
	}
	for ( var j = 0; j < valArray.length; j++) {
		var sss = "" + valArray[j];// string
		if (sss == ele.value) {
			ele.checked = true;
			L5.databind.change1(ele, "change1");
			return;
		} else {
			ele.checked = false;
		}
	}
	ele.checked = false;
}

/**
 * @private 从一个html元素中获取值,文本框、下拉框、单选框、复选框、其他.
 * @method L5.databind.getValueOfElement
 * @param dom元素
 *            ele
 * @return {Object} val
 */
L5.databind.getValueOfElement = function(ele) {
	if (ele == null) {
		return "";
	}

	if (ele.nodeName.toLowerCase() == "select") {
		return L5.databind.getValueOfSelectElement(ele);
	}

	if (ele.nodeName.toLowerCase() == "input") {
		if (ele.type == "radio" || ele.type == "checkbox") {
			return L5.databind.getValueOfChkRadElement(ele);
		}
		return ele.value;
	}

	if (ele.nodeName.toLowerCase() == "textarea") {
		return ele.value;
	}

	if (ele.textContent)
		return ele.textContent;
	else if (ele.innerText)
		return ele.innerText;
	else
		return ele.innerHTML;

}

/**
 * @private 从一个html元素中获取显示的值（枚举显示textField而不是valueField）,文本框、下拉框、单选框、复选框、其他...
 * @method L5.databind.getShowTextOfElement
 * @param dom元素
 *            ele
 * @return {Object} val
 */
L5.databind.getShowTextOfElement = function(ele) {
	if (ele == null) {
		return "";
	}

	if (ele.nodeName.toLowerCase() == "select") {
		var ret = null;
		if (ele.type == "select-multiple") {
			ret = "";
			for ( var i = 0; i < ele.options.length; i++) {
				var item = ele.options[i];
				if (item.selected) {
					ret = ret + item.text + " ";
				}
			}
		} else {
			var sel = ele.selectedIndex;
			if (sel != -1) {
				var item = ele.options[sel];
				var valueAttr = item.getAttributeNode("value");
				ret = item.text;
			} else {
				ret = "";
			}
		}
		return ret;
	}

	if (ele.nodeName.toLowerCase() == "input") {
		if (ele.type == "radio" || ele.type == "checkbox") {
			return L5.databind.getValueOfChkRadElement(ele);
		}
		return ele.value;
	}

	if (ele.nodeName.toLowerCase() == "textarea") {
		return ele.value;
	}

	if (ele.textContent)
		return ele.textContent;
	else if (ele.innerText)
		return ele.innerText;
	else
		return ele.innerHTML;
}

/**
 * @private 获取下拉框元素的值
 * @method L5.databind.getValueOfSelectElement
 * @param dom元素
 *            ele
 * @return {Object} val
 */
L5.databind.getValueOfSelectElement = function(ele) {
	var ret = null;
	if (ele.type == "select-multiple") {
		ret = new Array();
		for ( var i = 0; i < ele.options.length; i++) {
			var item = ele.options[i];
			if (item.selected) {
				var valueAttr = item.getAttributeNode("value");
				if (valueAttr && valueAttr.specified) {
					ret.push(item.value);
				} else {
					ret.push(item.text);
				}
			}
		}
	} else {
		var sel = ele.selectedIndex;
		if (sel != -1) {
			var item = ele.options[sel];
			var valueAttr = item.getAttributeNode("value");
			if (valueAttr && valueAttr.specified) {
				ret = item.value;
			} else {
				ret = item.text;
			}
		} else {
			ret = "";
		}
	}
	ele.setAttribute("saveVal", ret);
	return ret;
}

/**
 * @private 获取单选框、复选框元素的值
 * @method L5.databind.getValueOfChkRadElement
 * @param dom元素
 *            ele
 * @return {Object} 复选框返回","拼接后的选中值，单选框返回选中状态
 */
L5.databind.getValueOfChkRadElement = function(ele) {
	if (ele.type == "radio") {
		if (ele.checked)
			return ele.value;
		//duanqp 添加 判断
		else {
			var name = ele.getAttribute("name");
			var parent = ele.parentNode;
			var nodes = L5.DomQuery.select("input[@name=]" + name + "]", parent);
			var revalue="";
			if (nodes && nodes.length >= 1) {
				for ( var i = 0; i < nodes.length; i++) {
					var node = nodes[i];
					var type = ele.getAttribute("type");
					if (type != "radio")
						continue;
					if (node.checked) {
						revalue=node.value;
						break;
					}
				}
			}
			return revalue;
		}
		return ele.checked;
	}
	if (ele.type == "checkbox") {
		var property = ele.getAttribute("field");
		var selector = "input[@field=" + property + "]";
		var parent = ele.parentNode;
		var nodes = L5.DomQuery.select(selector, parent);
		if (nodes && nodes.length >= 1) {
			var reply = "";
			for ( var i = 0; i < nodes.length; i++) {
				var node = nodes[i];
				var type = ele.getAttribute("type");
				if (type != "checkbox")
					continue;
				if (node.checked) {
					if (reply != null && reply != "")
						reply = reply + "," + node.value;
					else
						reply = reply + node.value;
					// reply.push(node.value);
				}
			}
			return reply;
		}
		return ele.checked;
	}
}

/**
 * @private 统一错误域的样式
 * @method L5.databind.uniteFalseStyle
 * @param {Object}
 *            root
 */
L5.databind.uniteFalseStyle = function(root) {
	if (!root) {
		root = document.body;
	}

	// 先找出所有的被绑定的record
	var recObj = new Object();
	var formList = L5.DomQuery.select("*[@dataset]", root);
	for ( var p = 0; p < formList.length; p++) {
		var dsId = formList[p].getAttribute("dataset");
		var dataset = L5.DatasetMgr.lookup(dsId);
		var param = formList[p].getAttribute("filter");
		if (param != null && param != "") {
			var params = param.split("=");
			var i = dataset.find(params[0], params[1]);
			if (i != -1) {
				recObj[dsId] = dataset.getAt(i);
			}
		} else {
			recObj[dsId] = dataset.getCurrent();
		}
	}

	// var formList = L5.DomQuery.select("*[@dataset]", root);
	for ( var i = 0; i < formList.length; i++) {
		var datasetId = formList[i].getAttribute("dataset");
		var fieldList = L5.DomQuery.select("*[@field]", formList[i]);
		for ( var j = 0; j < fieldList.length; j++) {
			var property = fieldList[j].getAttribute("field");
			if (recObj[datasetId]
					&& recObj[datasetId].validate[property] == false) {
				L5.get(fieldList[j]).setElFalseStyle(
						"校验错误",
						recObj[datasetId].msgLable[property]
								+ recObj[datasetId].msg[property]);
			}
		}
	}
};

/**
 * @private 返回第一个错误域的dom
 * @method L5.databind.getFirstFalseDom
 * @param {Object}
 *            root
 * @return {L5.CompositeElement} element元素对象
 */
L5.databind.getFirstFalseDom = function(root) {
	if (!root) {
		root = document.body;
	}
	var firstFalseEle = null;
	var formList = L5.DomQuery.select("*[@dataset]", root);
	for ( var i = 0; i < formList.length; i++) {
		var datasetId = formList[i].getAttribute("dataset");
		var dataset = L5.DatasetMgr.lookup(datasetId);
		var param = formList[i].getAttribute("filter");
		var record;
		if (param != null && param != "") {
			var params = param.split("=");
			var k = dataset.find(params[0], params[1]);
			if (k != -1) {
				record = dataset.getAt(k);
			}
		} else {
			record = dataset.getCurrent();
		}

		var fieldList = L5.DomQuery.select("*[@field]", formList[i]);
		for ( var j = 0; j < fieldList.length; j++) {
			var property = fieldList[j].getAttribute("field");
			if (record && record.validate[property] == false) {
				if (!L5.get(fieldList[j]).isVisible()
						|| fieldList[j].getAttribute("type") == "hidden") {
					continue;
				}
				firstFalseEle = fieldList[j];
				return firstFalseEle;
			}
		}
	}
	return firstFalseEle;
}

/**
 * @private 表单方式获取所有错误域的信息
 * @method L5.databind.getAllErrorMsg
 * @param {Object}
 *            root
 * @return {String} 错误信息
 */
L5.databind.getAllErrorMsg = function(root) {
	if (!root) {
		root = document.body;
	}
	var msg = "";
	// 先找出所有的被绑定的record
	var recObj = new Object();
	var formList = L5.DomQuery.select("*[@dataset]", root);
	for ( var p = 0; p < formList.length; p++) {
		var dsId = formList[p].getAttribute("dataset");
		var dataset = L5.DatasetMgr.lookup(dsId);
		var param = formList[p].getAttribute("filter");
		if (param != null && param != "") {
			var params = param.split("=");
			var i = dataset.find(params[0], params[1]);
			if (i != -1) {
				recObj[dsId] = dataset.getAt(i);
			}
		} else {
			recObj[dsId] = dataset.getCurrent();
		}
	}

	// var formList = L5.DomQuery.select("*[@dataset]", root);
	for ( var i = 0; i < formList.length; i++) {
		var datasetId = formList[i].getAttribute("dataset");
		var fieldList = L5.DomQuery.select("*[@field]", formList[i]);
		for ( var j = 0; j < fieldList.length; j++) {
			if (!L5.get(fieldList[j]).isVisible()
					|| fieldList[j].getAttribute("type") == "hidden") {
				continue;
			}
			var property = fieldList[j].getAttribute("field");
			if (recObj[datasetId]
					&& recObj[datasetId].validate[property] == false
					&& recObj[datasetId + "~" + property] != true) {
				msg += recObj[datasetId].msgLable[property]
						+ recObj[datasetId].msg[property] + "!\n";
				recObj[datasetId + "~" + property] = true;
			}
		}
	}
	return msg;
}
/*******************************************************************************
 * 处理页面onchange1属性，绑定时不再使用fireEvent捕获时间onchange
 ******************************************************************************/
L5.databind.change1 = function(ele, eventName) {
	var ele;
	if (typeof ele == "string") {
		ele = document.getElementById(ele);
	} else {
		ele = ele;
	}
	var onchange1 = ele.getAttribute("onchange1");
	eval(onchange1);
}