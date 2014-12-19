L5.MultiSimpleGridHelp=function(config,searchCfg){
	config.layout='border';
	config.selectFirst=false;
	config.gridCfg={
		region:'center'
	} ;
	searchCfg.region='north';
	this.selectFirst=false;
	this.isClear=false;
	this.id=config.id;
	this.sm=new L5.grid.CheckboxSelectionModel();
	this.dataset=config.dataset;
	//this.dataset.on('datachanged',this.selectValues,this);
	config.sm=this.sm;
	this.notSelectFirstRow=true;
	if(!config.gridColumns){
		config.gridColumns=L5.getGridColumns(config.dataset.fields.items)
	} 
	var allColumns=new Array();
	allColumns.push(config.sm);
	config.gridColumns=allColumns.concat(config.gridColumns);
	this.idField=config.idField;
	if(this.idField==null||typeof this.idField=='undefined'){
		this.idField=config.gridColumns[1].field;
	} 
	this.displayField=config.displayField;
	if(this.displayField==null||typeof this.displayField=='undefined'){
		this.displayField=config.gridColumns[2].field;
	} 
	this.selectedData=new L5.util.MixedCollection();
	this.initedFlag=false;
	this.selectOptions=null;
	L5.MultiSimpleGridHelp.superclass.constructor.call(this,config,searchCfg);
	this.sm.on('rowselect',this.selectRow,this);
	this.sm.on('rowdeselect',this.deselectRow,this);
	this.on('beforeshow',this.helpObjInit,this);
} ;
L5.extend(L5.MultiSimpleGridHelp,L5.GridHelpWindow,{
	//appendToItems:function(){
	//	return[this.selectedPanel];
	//},
	selectRow:function(sm,rowIndex,record){
		this.addItem(record);
		//this.buildOptions(record.get(this.idField),record.get(this.displayField));
	} ,
	deselectRow:function(sm,rowIndex,record){
		this.removeItem(record);
		//this.buildOptions(record.get(this.idField),record.get(this.displayField),true);
	} ,
	addItem:function(record){
		this.selectedData.add(record.get(this.idField),record);
	} ,
	removeItem:function(record){
		this.selectedData.removeKey(record.get(this.idField));
	} ,
	selectValues:function(){
		var records=this.selectedData.items;
		var selectedIndex=this.getRowIndex(this.gridPanel.dataset,records,this.idField);
		for(var n=0;n<selectedIndex.length;n++){
			if(selectedIndex[n]!=-1){
			this.sm.selectRow(selectedIndex[n],true);
			} 
		} 
	} ,
	getRowIndex:function(dataset,records,fieldName){
		var allIndex=new Array();
		var src;
		var target;
		var items;
		if(dataset.localPage){
			var start=dataset.pageInfo.startCursor;
			var end=start+dataset.getCount();
			items=dataset.data.items.slice(start,end);
		} else{
			items=dataset.data.items;
		} 
		for(var i=0;i<records.length;i++){
			var index=-1;
			target=records[i];
			for(var j=0;j<items.length;j++){
				src=items[j];
				if(target.get(fieldName)==src.get(fieldName)){
					index=j;
					break;
				} 
			} 
			allIndex.push(index);
		}
		return allIndex;
	} ,
	helpObjInit:function(){
		L5.getCmp(this.id).getComponent(1).getSelectionModel().clearSelections();	
	} ,
	_innerquery:function(){
		this.searchCfg.search();
	} ,
	query:function(condition){
		this.searchCfg.bgSearch(condition);
	},
	_confirm:function(){
		var records=this.selectedData.items;
		if(records.length==0){
			L5.Msg.alert("提示","请选择记录");
			return;
		} else {
			var reValue="";
			for(var i=0;i<records.length;i++){
				reValue += records[i].get("value");
			}
			if(reValue.indexOf("01")!=-1 && reValue.indexOf("02")!=-1) {
				L5.Msg.alert("提示","‘城市低保’与‘农村低保’不能同选，请重新选择！");
				return;
			}
			if(reValue.indexOf("02")!=-1 && (reValue.indexOf("03")!=-1||reValue.indexOf("04")!=-1)) {
				L5.Msg.alert("提示","'农村低保'和（'集中供养五保户'，'分散供养五保户'）不能同选，请重新选择！");
				return;
			}
			if(reValue.indexOf("03")!=-1 && reValue.indexOf("04")!=-1) {
				L5.Msg.alert("提示","'集中供养五保户'和'分散供养五保户'不能同选，请重新选择！");
				return;
			}
		}
		this.returns=records;
		this.isClear=false;
		this.hide();
		if(this.afterExecute){
			this.afterExecute();
		}
	},
	_clear:function(e){
		this.returns=[this.initRecord];
		this.isClear=true;
		this.hide();
		if(this.afterExecute){
			this.afterExecute();
		} 
	} 
} );
function mutiHelp(ds,displayName,value) {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup(ds);
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchAreaM();
		multiItem_search.addTextField("jzlxdm","编码","DM_JZLX.JZLXDM");
		multiItem_search.addTextField("jzlxmc","内容","DM_JZLX.JZLXMC");
		itemWin = new L5.MultiSimpleGridHelp(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result,displayName,value);
    	} else {
    		displayDbClick(displayName,value);
    	}
	}
}
function setValue(result,displayName,value) {
	var jzlxDisplay = document.getElementById(displayName);
	var jzlxquery = document.getElementById(value);
	jzlxDisplay.value="";
	jzlxquery.value="";
	var reValue = "";
	if(L5.isArray(result)) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlxDisplay.value=="") {
				jzlxDisplay.value += (record.get("text"));
				jzlxquery.value += (record.get("value"));
			} else {
				jzlxDisplay.value += (","+record.get("text"));
				jzlxquery.value += (","+record.get("value"));
			}
		}
	} else {
		jzlxDisplay.value = result.get("text");
		jzlxquery.value = result.get("value");
	}
}
function displayDbClick(displayName,value) {
	document.getElementById(displayName).value="";
	document.getElementById(value).value="";
}
L5.SearchAreaM=function(config){
	this.count=0;
	this.htmls="";
	this.params=new Array();
	this.dataset;
	this.data;
	this.help;
	L5.apply(this,config);
} ;
L5.SearchAreaM.prototype.addTextField=function(name,desc,sqlName){
	this.count++;
	this.htmls+="<td><label>"+desc+":</label></td>";
	this.htmls+="<td><input type=\"text\" id=\""+name+"\" /></td>";
	this.setLayOut();
	if(typeof sqlName=='undefined'||sqlName==null){
	sqlName=name;
} 

this.setParameter(name,sqlName);
} ;

L5.SearchAreaM.prototype.setLayOut=function(){
	if(this.count!=1){
		if(this.count%2==1){
			this.htmls+="<tr>"
		} else{
			this.htmls+="</tr><tr>";
			this.count=0;
		} 
	} 
} 
L5.SearchAreaM.prototype.addDateField=function(name,desc,config,sqlName){
	this.htmls+="<td><label>"+desc+":</label></td>";
	this.htmls+="<td><input id='"+name+"' type='text' onclick='LoushangDate("+config+",this)'></td>";
	this.setLayOut();
	if(typeof sqlName=='undefined'||sqlName==null){
	sqlName=name;
	} 
	this.setParameter(name,sqlName);
} ;

L5.SearchAreaM.prototype.addComboField=function(name,desc,ds,sqlName){
	this.htmls+="<td><label>"+desc+":</label></td>";
	this.htmls+="<td><select id=\""+name+"\" >";
	var options="<option dataset=\""+ds+"\">"+"</option>";
	this.htmls+=options;
	this.htmls+="</select></td>";
	this.setLayOut();
	if(typeof sqlName=='undefined'||sqlName==null){
	sqlName=name;
} 

this.setParameter(name,sqlName);
} ;

L5.SearchAreaM.prototype.setParameter=function(name,sqlName){
	var obj=new Object();
	obj.name=name;
	obj.sqlName=sqlName;
	this.params[this.params.length]=obj;
} 
L5.SearchAreaM.prototype.getFormContent=function(){
	if(this.data){
	var arr=this.data;
	for(var i=0;i<arr.length;i++){
		switch(arr[i].type){
			case null:case'':case undefined:case'text':this.addTextField(arr[i].name,arr[i].desc);
			break;
			case'date':this.addDateField(arr[i].name,arr[i].desc,arr[i].cfg);
			break;
			case'combox':this.addComboField(arr[i].name,arr[i].desc,arr[i].data);
			break;
			} 
		} 
	} 
} ;
L5.SearchAreaM.prototype.setBaseParams=function(){
	var fieldValue;
	var filterSql = "";
	for(var i=0;i<this.params.length;i++){
		fieldValue=L5.fly(this.params[i].name).getValue();
		if(fieldValue!=""){
			if(filterSql=="") {
				filterSql = this.params[i].sqlName+"='"+fieldValue+"'";
			} else {
				filterSql+=(" AND "+this.params[i].sqlName+"='"+fieldValue+"'");
			}
			
		}
	} 
	this.dataset.baseParams["filterSql"]=filterSql;
} ;
L5.SearchAreaM.prototype.search=function(){
	this.setBaseParams();
	this.dataset.load();
} ;
L5.SearchAreaM.prototype.bgSearch=function(condition){
	if(condition){
		this.dataset.baseParams[condition.name]=condition.value;
		this.dataset.load({
			callback:respondSearch,help:this.help,search:condition
		} );
	} 
} 
function respondSearch(records,options,success){
	if(success){
		var length=records.length;
		if(length==1){
			options.help.returns=records[0];
			options.help.isClear=false;
			options.help._dirty=true;
			if(options.help.afterExecute){
				options.help.afterExecute();
			} 
		} else{
			options.help.show(null,null,null,true);
			var condition=options.search;
			L5.fly(condition.name).dom.value=condition.value;
		} 
	} 
} ;
L5.SearchAreaM.prototype.clearSearchValue=function(){
	for(var i=0;i<this.params.length;i++){
		L5.fly(this.params[i].name).dom.value="";
		this.dataset.baseParams[this.params[i].name]=undefined;
	} 
} ;
L5.SearchAreaM.prototype.getHtmls=function(){
	return"<form onsubmit='return false'><table><tr>"+this.htmls+"</tr></table></form>";
} 