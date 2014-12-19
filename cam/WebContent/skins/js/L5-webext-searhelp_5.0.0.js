L5.ns("L5.WebExt");

/**
 * 组装通用帮助域
 */
L5.WebExt.SearchHelpInput = function(config) {
	var helpId = config.helpId;
	var sInput = config.sInput;
	var sLabel = config.sInput + '_TEXT';
	var sImg = config.sInput + '_IMG';
	window[sInput + '_S'] = this;
	
	//1.获取通用帮助配置
	function getHelpInfo() {
		var cmd = new L5.Command("com.inspur.cams.comm.help.cmd.CommHelpCmd");
		cmd.setParameter("helpId", helpId);
		cmd.execute("getCommHelp");
		var re = cmd.getReturn("commHelp");
		re.sField = re.showField.split(",");
		re.sName = re.showName.split(",");
		return re;
	}
	
	function getDsFeildConfig(sField) {
		var feConfig = new Array([sField.length]);
		var feInfo;
		for(var i = 0; i < sField.length; i++){
			feConfig[i] = {name:sField[i], type:'string'};
		}
		return feConfig;
	}
	
	//2.生成通用帮助查询Dataset
	function getHelpDs(helpInfo) {
		var dsFeConfig = getDsFeildConfig(helpInfo.sField);
		var helpDs = new L5.model.Dataset({
			proxy : new L5.CommandProxy('com.inspur.cams.comm.help.cmd.CommHelpQueryCmd', 'forhelp'),
			reader : new L5.model.JsonReader({fields: dsFeConfig}),
			ds : sInput + '_HDS',
			pageSize : parseInt(helpInfo.pageSize),
			id : sInput + '_HDS',
			remoteSort : true,
			sortInfo : {}
		});
		helpDs.baseParams["helpId"] = helpId;
		helpDs.baseParams["helpPrefix"] = sInput;
		return helpDs;
	}
	
	//3.设置通用帮助窗口
	function getHelpWin(sInput, helpInfo, helpDs) {
		var helpConf = {};
		helpConf.id = sInput + "_help";
		helpConf.dataset = helpDs;
		helpConf.title = helpInfo.helpTitle;
		helpConf.gridPanelHeight = 240;
		helpConf.height = 360;
		helpConf.width = 480;
		var coConfig = new Array([helpInfo.sField.length]);
		var search = new L5.SearchArea();
		for(var i = 0; i < helpInfo.sField.length; i++){
			coConfig[i] = {header:helpInfo.sName[i], sortable:true, field:helpInfo.sField[i]};
			search.addTextField(sInput+"."+helpInfo.sField[i], helpInfo.sName[i]);
		}
		helpConf.gridColumns = coConfig;
		// 初始化窗口
		var helpWin;
		var isMulti=helpInfo.isMulti;
		if(isMulti==0){
			helpWin = new L5.GridHelpWindow(helpConf, search);
		}else{
			helpWin = new L5.MultiGridHelpWindow(helpConf, search);
		}
		// 查询后执行回填方法
		helpWin.afterExecute = function() {
			var result = this.getReturn();
			if (result != null) {
				if(isMulti==0){
					window[config.sInput+'_S'].setValue(result);
				}else{
					window[config.sInput+'_S'].setMultValue(result);
				}
			}
		}
		return helpWin;
	}
	
	this.helpInfo = getHelpInfo();
	this.helpDs = getHelpDs(this.helpInfo);
	this.helpWin = getHelpWin(sInput, this.helpInfo, this.helpDs);

	this.doQuery = function(val) {
		if (val == "") {
			this.setValueText("", "", false);
		} else {
			var con = {name:sInput+"."+this.helpInfo.idField, value:val};
			this.helpWin.searchCfg.clearSearchValue;
			this.helpWin.query(con);
		}
	}

	this.inputField = L5.fly(sInput).dom;
	this.el = L5.Element(this.inputField);
	this.el.wrap();
	this.el.hide();
	
	// 通用帮助为文本域赋值，并触发事件
	this.setValue = function(record) {
		L5.fly(sInput).dom.value = record.get(this.helpInfo.idField);
		L5.fly(sLabel).dom.value = record.get(this.helpInfo.nameField);
		L5.fireEvent(sInput, "blur");
		L5.fireEvent(sInput, "change");
	}
	
	this.setMultValue = function(records) {
		var text='';
		var val='';
		for(var i=0;i<records.length;i++){
			if(i!=0){
				text+=",";
				val+=",";
			}
			text+=records[i].get(this.helpInfo.idField);
			val+=records[i].get(this.helpInfo.nameField);
		}
		L5.fly(sInput).dom.value = text;
		L5.fly(sLabel).dom.value = val;
		L5.fireEvent(sInput, "blur");
		L5.fireEvent(sInput, "change");
	}
	
	this.setValueText = function(vIn,vTe,fB) {
		L5.fly(sInput).dom.value = vIn;
		L5.fly(sLabel).dom.value = vTe;
		if(fB){
			L5.fireEvent(sLabel, "blur");
			L5.fireEvent(sInput, "change");
			L5.fireEvent(sInput, "blur");
		}
	}
	
	// 名称域
	this.textField = this.el.insertSibling({
			tag : 'input',
			type: 'text',
			name : sLabel,
			id : sLabel
		}, 'before', true);
	
	// 通用帮助查询图片
	this.imgField = this.el.insertSibling({
			tag : 'img',
			name : sImg,
			id : sImg,
			src: L5.webPath + "/skins/images/default/toolbar/query.png",
			style: "POSITION: relative; CURSOR: hand; TOP: 5px; LEFT: -20px",
			height: 18,
			width: 18
		}, 'before', true);
	
	this.textField.ondblclick = function() {
		window[sInput+'_S'].setValueText("", "", true);
	}
	
	this.textField.onchange = function() {
		window[sInput+'_S'].doQuery(this.value);
	}
	
	this.KeyHelp = function() {
		var ev = window.event;
		var target = window.event.srcElement;
		if (ev.keyCode == L5.EventObject.ENTER && target.value.trim().length > 0) {
			window[sInput+'_S'].forHelp(ev, target, true);
		}
	}
	this.textField.onkeypress = this.KeyHelp;
	
	this.forHelp = function(ev, target, key) {
		if (key) {
			window[sInput+'_S'].doQuery(target.value.trim());
		} else {
			window[sInput+'_S'].helpWin.searchCfg.clearSearchValue;
			window[sInput+'_S'].helpWin.show(ev, null, null, {});
		}
	}
	
	this.imgField.onclick = this.forHelp;
	var iniValue = this.inputField.value;
	if (iniValue != "") {
		this.doQuery(iniValue);
	}
}

/**
 * 明细通用帮助
 */
L5.WebExt.SearchHelpLabel = function(config) {
	this.helpId = config.helpId;
	this.sInput = config.sInput;
	this.sLabel = config.sInput + '_TEXT';
	window[this.sInput + '_L'] = this;
	
	this.getHelpText = function(key) {
		var cmd = new L5.Command("com.inspur.cams.comm.help.cmd.CommHelpCmd");
		cmd.setParameter("helpId", this.helpId);
		cmd.setParameter("key", key);
		cmd.execute("getDicValue");
		return cmd.getReturn("value");
	}
	this.inputField = L5.fly(this.sInput).dom;
	this.el = L5.Element(this.inputField);
	this.el.wrap();
	this.el.hide();
	
	// 名称域
	this.labelField = this.el.insertSibling({
			tag : 'label',
			name : this.sLabel,
			id : this.sLabel
		}, 'before', true);
	
	this.doQuery = function(val) {
		if (val != "") {
			this.inputField.value = val;
			var re = this.getHelpText(val);
			this.labelField.value = re;
			this.labelField.innerHTML = re;
		}
	}
	var iniValue = this.inputField.value;
	if(this.inputField.nodeName.toLowerCase()=="label"){
		iniValue = this.inputField.innerHTML;
	}
	if (iniValue != "") {
		this.doQuery(iniValue);
	}
}

/**
 * 下列列表通用帮助
 */
L5.WebExt.SearchHelpSelect = function(config) {
	var helpId = config.helpId;
	var sInput = config.sInput;
		
	this.getHelp = function() {
		var helpDs = new L5.model.Dataset({
			proxy : new L5.CommandProxy('com.inspur.cams.comm.help.cmd.CommHelpQueryCmd', 'forselect'),
			reader : new L5.model.JsonReader({fields: [{name:'value'},{name:'text'}]}),
			ds : sInput + '_HDS',
			pageSize : 1,
			id : sInput + '_HDS',
			remoteSort : true,
			sortInfo : {}
		});
		helpDs.baseParams["helpId"] = helpId;
		helpDs.load();
		helpDs.on("load", this.setValue);
	}
	
	this.setValue = function(helpDs) {
		var inputField = L5.fly(sInput).dom;
		var options = new L5.databind.Options(inputField);
		options.bind(helpDs);
	}
	
	this.getHelp();
}

/**
 * 初始化页面通用帮助
 */
L5.WebExt.ShowHelpTag = function() {
	var els = L5.DomQuery.select("*[@searchHelp]", document.body);
	for (var i = 0; i < els.length; i++) {
		var helpId = els[i].getAttribute("searchHelp");
		var sName = els[i].getAttribute("name");
		var nodeName = els[i].nodeName.toLowerCase();
		if (nodeName == "input") {
			var type = els[i].getAttribute("type");
			if (type == "text") {
				new L5.WebExt.SearchHelpInput({sInput:sName, helpId:helpId});
			}
			if (type == "hidden") {
				new L5.WebExt.SearchHelpLabel({sInput:sName, helpId:helpId});
			}
		} else if (nodeName == "label") {
			new L5.WebExt.SearchHelpLabel({sInput:sName, helpId:helpId});
		} else if (nodeName == "select") {
			new L5.WebExt.SearchHelpSelect({sInput:sName, helpId:helpId});
		}
	}
}
