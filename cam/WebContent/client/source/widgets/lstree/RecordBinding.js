/**
 * 让record绑定到一个form
 * @param {Object} formid
 */
L5.tree.RecordForm = function(formid){
	this.elId = formid;
	this.record = false;
	this.initForm = false;
};

L5.tree.RecordForm.prototype = {
	nodeTypeMap : {
		"select-one" : 'singleSelect',
		"select-multiple" : "mulSelect",
		text : 'text',
		password : 'text',
		hidden: 'text',
		checkbox : 'checkbox',
		radio : 'radio'
	},
	
	initListeners : function(){
		var el = this.getEl();
		var fieldList = L5.DomQuery.select("*[@field]",el);
		if (el.getAttribute("field") != null) {
			fieldList.push(ele);
		}
		for ( var j = 0; j < fieldList.length; j++) {
			var field = fieldList[j];
			var type = field.type.toLowerCase();
			var funcName = this.getFuncBaseNameByType(type);
			L5.fly(field).on("change", this['on'+funcName+"Blur"],this);
			L5.fly(field).on("blur", this['on'+funcName+"ValueChange"],this);
		}
	},
	
	init : function(rec){
		if(this.record !== rec&&rec);//先赋值,然后初始化事件
			this.refresh(rec);
		if(!this.initForm){
			this.initListeners();
			this.initForm = true;
		}
	},
	
	refresh : function(rec){
		this.record = rec;
		var el = this.getEl();
		
		var fieldList = L5.DomQuery.select("*[@field]",el);
		if (el.getAttribute("field") != null) {
			fieldList.push(ele);
		}
		for ( var j = 0; j < fieldList.length; j++) {
			var field = fieldList[j];
			var type = field.type.toLowerCase();
			var basefuncName = this.getFuncBaseNameByType(type);
			
			var funcname = 'set'+basefuncName+'Value';
			var property = field.getAttribute("field");
			var val = rec.get(property);
			
			this[funcname](field, rec.get(property));
			
			L5.Validator.validate(rec, property, rec.get(property));
			var qtipel = field;
			if(field.type == "radio" || field.type == "checkbox") {
				qtipel = field.parentNode;
			}
			this.dealQtip(qtipel,field,property);
		}
	},
	
	update : function(property,value){
		var el = this.getEl();
		
		var selection = "*[@field="+property+"]";
		var fieldList = L5.DomQuery.select(selection,el);
		if (el.getAttribute("field") == property) {
			fieldList.push(el);
		}
		
		for(var j = 0; j < fieldList.length; j++){
			var field = fieldList[j];
			var type = field.type.toLowerCase();
			var basefuncName = this.getFuncBaseNameByType(type);
			var funcname = 'set'+basefuncName+'Value';
			this[funcname](field, value);
			
			L5.Validator.validate(this.record, property, value);
			var qtipel = field;
			if(field.type == "radio" || field.type == "checkbox") {
				qtipel = field.parentNode;
			}
			this.dealQtip(qtipel,field,property);
		}
		
	},
	
	getEl : function(){
		return document.getElementById(this.elId);
	},
	
	getRecord : function(){
		return this.record;
	},
	
	getFuncBaseNameByType : function(type){
		if(this.nodeTypeMap[type]){
			return this.nodeTypeMap[type];
		}
		return 'base';
	},
	
	ontextBlur : function(e){
		var rec = this.record;
		if(!rec){
			return;
		}
		var ele = e.getTarget();
		var val = ele.value;
		var property = ele.getAttribute("field");
		this.setRecordValue(property,val,ele,ele);
	},
	
	ontextValueChange : function(e){
		return;
	},
	
	settextValue:function(field,val){
		if (val == null) {
			val = "";
		}
		field.value = val;
	},
	
	onradioBlur : function(e){
		this.onradioValueChange(e);
	},
	
	onradioValueChange : function(e){
		var rec = this.record;
		if(!rec){
			return;
		}
		
		var ele = e.getTarget();
		var val = ele.checked?ele.value:ele.checked;
		var property = ele.getAttribute("field");
		this.setRecordValue(property,val,ele,ele.parentNode);
	},
	
	setradioValue : function(field,val){
		if (val == null) {
			val = "";
		}
		var valArray = val.split(",");
		for (var j = 0; j < valArray.length; j++) {
			var sss = "" + valArray[j];//string
			if (sss == field.value) {
				field.checked = true;
				return;
			} else {
				field.checked = false;
			}
		}
		field.checked = false;
	},
	
	oncheckboxBlur : function(e){
		tihs.oncheckboxValueChange(e);
	},
	
	oncheckboxValueChange : function(e){
		var rec = this.record;
		if(!rec){
			return;
		}
		var ele = e.getTarget();
		var property = ele.getAttribute("field");
		var selector = "input[@field=" + property + "]";
		var parent = ele.parentNode;
		var nodes = L5.DomQuery.select(selector, parent);
		var val = "";
		if (nodes && nodes.length >= 1) {
			for ( var i = 0; i < nodes.length; i++) {
				var node = nodes[i];
				var type = ele.getAttribute("type");
				if (type != "checkbox")
					continue;
				if (node.checked){
					if(val!=null && val != "")
						val = val + "," + node.value;
					else
						val = val + node.value;
				}
				
			}
		} else {
			val = ele.checked;
		}
		this.setRecordValue(property,val,ele,ele.parentNode);
	},
	
	setcheckboxValue : function(field,val){
		this.setradioValue(field,val);
	},
	
	onsingleSelectBlur : function(e){
		this.onsingleSelectValueChange(e);
	},
	
	onsingleSelectValueChange : function(e){
		var rec = this.record;
		if(!rec){
			return;
		}
		var ele = e.getTarget();
		var property = ele.getAttribute("field");
		var val;
		var sel = ele.selectedIndex;
		if (sel != -1) {
			var item = ele.options[sel];
			var valueAttr = item.getAttributeNode("value");
			if (valueAttr && valueAttr.specified) {
				val = item.value;
			}else{
				val = item.text;
			}
		}
		this.setRecordValue(property,val,ele,ele);
	},
	
	setsingleSelectValue : function(field,val){
		if (val == null) {
			val = "";
		}
		
		for (var i = 0; i < field.options.length; i++) {
			if(val == field.options[i].value){
				field.options[i].selected = true;
				break;
			}
		}
		field.setAttribute("loaded", "true");
		field.style.display = "";
	},
	
	onmulSelectBlur : function(e){
		this.onmulSelectValueChange(e);
	},
	
	onmulSelectValueChange : function(e){
		var rec = this.record;
		if(!rec){
			return;
		}
		var ele = e.getTarget();
		var property = ele.getAttribute("field");
		var val = new Array();
		for ( var i = 0; i < ele.options.length; i++) {
			var item = ele.options[i];
			if (item.selected) {
				var valueAttr = item.getAttributeNode("value");
				if (valueAttr && valueAttr.specified) {
					val.push(item.value);
				} else {
					val.push(item.text);
				}
			}
		}
		this.setRecordValue(property,val,ele,ele);
	},
	
	setmulSelectValue : function(field,val){
		if (val == null) {
			val = "";
		}
		if(val==""){
			field.options[0].selected = true;
		}
		if (!L5.isArray(val))
			val = [val];
		for (var i = 0; i < field.options.length; i++) {
			field.options[i].selected = false;
			for (var j = 0; j < val.length; j++) {
				var sss = "" + val[j];//string
				if (field.options[i].value == sss) {
					field.options[i].selected = true;
				}
			}
		}
		field.setAttribute("loaded", "true");
		field.style.display = "";
	},
	
	onbaseBlur : function(e){
		var rec = this.record;
		if(!rec){
			return;
		}
		var ele = e.getTarget();
		var property = ele.getAttribute("field");
		var val;
		
		if (ele.textContent)
			val = ele.textContent;
		else if (ele.innerText)
			val = ele.innerText;
		else
			val = ele.innerHTML;
		
		this.setRecordValue(property,val,ele,ele);
	},
	
	onbaseValueChange : function(e){
		return;
	},
	
	setbaseValue : function(field,val){
		if (field.textContent)
			field.textContent = val;
		else if (ele.innerText)
			field.innerText = val;
		else
			field.innerHTML = val;
	},
	
	setRecordValue : function(property,val,ele,qtipele){
		var rec = this.record;
		if(!rec){
			return;
		}
		qtipele = qtipele || ele;
		var rtn = rec.set(property, val);
		this.dealQtip(qtipele,ele,property);
		
		if(L5.isArray(rtn)){
			for(var i = 0; i < rtn.length; i++){
				this.reflect_element(ele, rtn[i], rec);
			}
		}
	},
	
	reflect_element : function(ele, field, record){
		var ds = L5.get(this.getEl);
		var tRow = L5.get(ele).findParent("tr");
		var e;
		if (tRow != null && tRow.getAttribute("record") != null) {
			e = L5.DomQuery.select("*[@field=" + field + "]", tRow);
		}else{
			e = L5.DomQuery.select("*[@field=" + field + "]", ds);
		}
		for(var i = 0; i < e.length; i++){
			var property = e[i].getAttribute("field");
			var qtipel = e[i];
			if(e[i].type == "radio" || e[i].type == "checkbox") {
				qtipel = e[i].parentNode;
			}
			this.dealQtip(qtipel,e[i], property);
		}
	},
	
	dealQtip : function(qtipele,ele,property){
		var rec = this.record;
		if (rec.validate[property] != null) {
			this.showQtipMsg(qtipele, this.getQtipMsg(ele,property));
		} else {
			this.clearQtipInfo(qtipele);
		}
	},
	
	getQtipMsg : function(ele,property){
		var msg = "";
		
		if(ele.getAttribute("msg") != null){
			msg = ele.getAttribute("msg");
		}else{
			var name = ele.getAttribute("title") || ele.getAttribute("name");
			if(this.record.msg[property]!=null){
				if(name != null){
					this.record.msgTitle[property] = name;
				}
				msg = this.record.msgTitle[property] + this.record.msg[property];
			}
		}
		return msg;
	},
	
	showQtipMsg : function(qtipele,msg){
		var extEle = L5.get(qtipele);
		extEle.setStyle("border-color", "#DA0000");
		qtipele.setAttribute("L5:qtitle", "校验错误"); 
		qtipele.setAttribute("L5:qtip", msg);
	},
	
	/**
	 * @param {Object} ele 配置提示信息节点对象
	 */
	clearQtipInfo : function(qtipele){
		var extEle = L5.get(qtipele);
		extEle.setStyle("border-color", "#008000");
		qtipele.removeAttribute("L5:qtitle"); 
		qtipele.removeAttribute("L5:qtip");
	}
};

(function(){
	var formMap = {};
	var onRecordSelect = function(record){
		this.init(record);
	};
	var onRecordUpdate = function(record,property){
		if(record!==this.record){
			return;
		}
		if(status==L5.model.Record.COMMIT){//如果是提交,由于以前已经更新过节点,因此直接返回
			return;
		}
		this.update(property,record.get(property));
	};
	
	L5.tree.FormBinding = function(nodemodel,formid){
		var form;
		if(formid.showQtipMsg){
			form = formid;
		} else {
			form =  new L5.tree.RecordForm(formid);
		}
		formMap[form.elId] = form;
		nodemodel.on('selected',onRecordSelect,form);
		nodemodel.on('update',onRecordUpdate,form);
	};
	
	L5.tree.FormUnBinding = function(formid){
		var form = formMap[formid];
		if(!form){
			return;
		}
		nodemodel.un('selected',onRecordSelect,form);
		nodemodel.un('selected',onRecordUpdate,form);
		delete formMap[formid];
	};
	
})();
