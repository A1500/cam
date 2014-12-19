
/**
 * 构建Record的配置信息
 * @method buildRecordConfig
 * @private
 * @param {Object} node dom节点
 * @return {Array} 域配置信息的数组
 */
function buildRecordConfig (node){
	//record config
	var recordNode = L5.DomQuery.selectNode("record", node);	
	if(recordNode){
	var recordConfig = new Array();
	
	var fieldList = L5.DomQuery.select("field", recordNode);	
	for ( var j = 0; j < fieldList.length; j++) {
		var fieldConfig = new Object();
		
		var fieldName = fieldList[j].getAttribute("name");
		if (fieldName && fieldName != null) {
			fieldConfig.name = fieldName;
		}
		
		var type = fieldList[j].getAttribute("type");
		if (type && type != null) {
			fieldConfig.type = type;
		}
		
		var mapping = fieldList[j].getAttribute("mapping");
		if (mapping && mapping != null) {
			fieldConfig.mapping = mapping;
		}
		
		var convert = fieldList[j].getAttribute("convert");
		if (convert && convert != null) {
			fieldConfig.convert = window[convert];
		}
		
		var dateFormat = fieldList[j].getAttribute("dateFormat");
		if (dateFormat && dateFormat != null) {
			fieldConfig.dateFormat = dateFormat;
		}
		
		var defaultValue = fieldList[j].getAttribute("defaultValue");
		if (defaultValue && defaultValue != null) {
			fieldConfig.defaultValue = defaultValue;
		}
		fieldConfig=bulidFieldValidator(fieldList[j],fieldConfig);
		recordConfig[j] = fieldConfig;
	}
	}
	return recordConfig;
}

/**
 * 构建域配置信息中的校验参数
 * @method bulidFieldValidator
 * @private
 * @param {Oject} ele            域对象
 * @param {Oject} fieldConfig    域配置信息
 * @return {Object} fieldConfig  域配置信息
 */
function bulidFieldValidator(ele,fieldConfig){
	var rule=ele.getAttribute("rule");
	fieldConfig.rule = rule;
	
	return fieldConfig;
}

/**
 * 构建排序配置信息
 * @method buidSortConfig
 * @private
 * @param {Object} cfg  排序配置信息
 * @param {Object} node dom节点
 * 
 */
function buidSortConfig(cfg,node){
	var remoteSort=node.getAttribute("remoteSort");	
	if(remoteSort&&remoteSort=="false"){
		cfg.remoteSort=false;
	}
	var sortNode = L5.DomQuery.selectNode("sort", node);
	if (sortNode && sortNode != null) {
		var sortInfo = new Object();
		var sortname = sortNode.getAttribute("field");
		if (sortname && sortname != null) {
			sortInfo.field = sortname;
		}
		var sortdir = sortNode.getAttribute("dir");
		if (sortdir && sortdir != null) {
			sortInfo.direction = sortdir;
		}
		cfg.sortInfo=sortInfo;
	}
}
/**
 * 构建创建解析器的配置项
 * @method buildMetaConfig
 * @private
 * @param {Object} node dom节点
 * @return {Object} 节点对象
 */
function buildMetaConfig(node){
	var metaNode = L5.DomQuery.selectNode("metadata", node);			
	var metaConfig = new Object();
	if(metaNode!=null){
		var metaId = metaNode.getAttribute("id");
		if (metaId && metaId != null) {
			metaConfig.id = metaId;
		}
		
		var metaSuccess = metaNode.getAttribute("success");
		if (metaSuccess && metaSuccess != null) {
			metaConfig.success = metaSuccess;
		}
		
		var metaTotal = metaNode.getAttribute("total");
		if (metaTotal && metaTotal != null) {
			metaConfig.totalRecords = metaTotal;
		}
		
		var metaRecords = metaNode.getAttribute("record");
		if (metaRecords && metaRecords != null) {
			metaConfig.record = metaRecords;
		}
	}
	return metaConfig;
}

/**
 * 构建解析器
 * @method buildReaderConfig
 * @private
 * @param {Object} cfg 解析器配置信息
 * @param {Object} node dom节点对象
 * @param {Object} metaConfig 配置参数元数据对象
 * @param {Object} recordType 域定义数组，或者是L5.model.Record的create方法创建的record构造对象
 * @return {Boolean} true或者false
 */
function buildReaderConfig(cfg,node,metaConfig,recordType){
	//reader config	
	var readerType = node.getAttribute("reader");
	if (!readerType) readerType = "json";
	switch (readerType) {
		case "xml":
			cfg.reader = new L5.model.XmlReader(metaConfig, recordType);
			break;
		case "json":
			cfg.reader = new L5.model.JsonReader(metaConfig, recordType);
			break;
		case "array":
			cfg.reader = new L5.model.ArrayReader(metaConfig, recordType);
			break;
		alert("invalid reader:"+readerType);
		return false;		
	}	
	return true;
}
/**
 * 构建请求代理对象
 * @method buildProxyConfig
 * @private
 * @param {Object} cfg 配置参数对象
 * @param {Object} node dom节点对象
 * @return {Boolean} true或者false
 */
function buildProxyConfig(cfg,node){
	var proxyType=node.getAttribute("proxy");	
	if (!proxyType) proxyType = "url";
	switch(proxyType){
		case "cmd":
			var clazz=L5.DomQuery.selectValue("command", node).trim();
			cfg.proxy=new L5.CommandProxy(clazz);
			break;
		case "enum":
			var enums=L5.DomQuery.selectValue("enum", node);
			cfg.proxy=new L5.EnumProxy(enums);
			break;
		case "rpc":
			var method=L5.DomQuery.selectValue("method", node);
			cfg.proxy=new L5.model.DirectProxy();
			break;
		case "url":
			var url=L5.DomQuery.selectValue("url", node);
			cfg.proxy=new L5.model.HttpProxy({"url":url});
			break;
		case "local":
			var data=L5.DomQuery.selectValue("data", node);
			cfg.proxy=new L5.model.MemoryProxy(window[data]);
			break;
		case "none":
			cfg.proxy=null;
			break;
		alert("invalid proxy:"+proxyType);
		return false;
	}
	return true;
}


/**
 * 创建XML解析器
 * @class L5.XMLParser
 * @constructor
 */
L5.XMLParser=function(){
	this.datasetConfigs=new L5.util.MixedCollection();
	this.recordConfigs=new L5.util.MixedCollection();
	this.inited=false;
	
};
/**
 * 解析XML，创建各种配置对象
 * @method init
 * @private
 */
L5.XMLParser.prototype.init=function() {
	var dsDiv = document.getElementById("datasetDiv");
	var dsList=L5.DomQuery.select("dataset",dsDiv);
	for(var i=0;i<dsList.length;i++){
		var cfg={};
		var node=dsList[i];
		
		//id: necessary
		var id=node.getAttribute("id");
		if(id==null){
			alert("dataset require attribute[id]");
			continue;
		}
		cfg.id=id;
		
		//auto load?
		var autoLoad=node.getAttribute("autoLoad");
		if(autoLoad){
			if(autoLoad=="true")
			cfg.autoLoad=true;
			else
			cfg.autoLoad=false;
		}
		
		//extern xml document
		var src = node.getAttribute("src");
		if (src != null) {
			var xmlobject = L5.loadXml(src);
			node=L5.DomQuery.selectNode("dataset[@id=" + id + "]", xmlobject);
		}
		
		//pageSize
		var pageSize=node.getAttribute("pageSize");	
		if(pageSize){
			cfg.pageSize=parseInt(pageSize);
		}	
					
		//remotePage
		var remotePage=node.getAttribute("remotePage");
		if(remotePage&&remotePage=="false"){
			cfg.remotePage=false;
		}else{
			cfg.remotePage=true;
		}
		//record config
		var recordConfig=buildRecordConfig.call(this,node);
		
		//保存recordConfig，以备后用
		//this.recordConfigs.add(cfg.id,recordConfig);
		if(recordConfig){
		var recordType = L5.model.Record.create(recordConfig);	
		}else{
		var recordType=null;
		}
		//meta config
		var metaConfig=buildMetaConfig.call(this,node);
		
		//reader config
		var success;
		success=buildReaderConfig.call(this,cfg,node,metaConfig,recordType);
		if(!success){
			continue;
		}
		
		//proxy config
		success=buildProxyConfig.call(this,cfg,node);		
		if(!success){
			continue;
		}

		//sort config
		buidSortConfig.call(this,cfg,node);
		this.datasetConfigs.add(cfg.id,cfg)
	}
	//设置标志位，标明已初始化
	this.inited=true;
}


/**
 * 创建Dataset
 * @method newDataset
 * @private 
 * @param {String} or {Object} para 配置信息的id或者配置信息对象
 */
L5.XMLParser.prototype.newDataset=function(para){
	
	if(!this.inited){
		this.init();
	}
	if(typeof para=='string'){
		var config=this.datasetConfigs.get(para);
		if(config.remotePage){
			window[config.id]=new L5.model.Dataset(config);
		}else{
			window[config.id]=new L5.model.LocalPageDataset(config);		
		}
	}else if(typeof para=='object' ){
		for(var i=0;i<para.getCount();i++){
			var config=para.get(i);
			if(config.remotePage){
				window[config.id]=new L5.model.Dataset(config);
			}else{
				window[config.id]=new L5.model.LocalPageDataset(config);		
			}
		}
	}
	
}

/**
 * 获取Record配置信息
 * @method getRecordConfig
 * @private 
 * @param {String} para 配置信息的id
 */
L5.XMLParser.prototype.getRecordConfig=function(para){
	if(typeof para=='string'){
		return this.recordConfigs.get(para);
	}
};

/**
 * 加载xml数据
 * @class L5.loadXml
 * @constructor
 * @param {String} url 加载数据的url地址
 * @return {Object} 加载的xml数据对象
 */
L5.loadXml=function(url) {
	var ret=null;
	var  o = {
		url : url,
	    sync : true,
	    callback : function(options,success,response){
	    	ret=response.responseXML;
	    },
	    scope : this
	};
	L5.Ajax.request(o);
	return ret;
}

/**
 * 创建并初始化XmlParser对象
 * @method  datasetbyxml
 */
L5.initObj.datasetbyxml= function() {
	var xmlparser=new L5.XMLParser();
	xmlparser.init();
	xmlparser.newDataset(xmlparser.datasetConfigs);
};

