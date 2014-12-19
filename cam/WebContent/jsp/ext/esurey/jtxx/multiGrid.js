L5.MultiGridHelpWindow1=function(config,searchCfg){
	config.layout='border';
	config.selectFirst=false;
	config.gridCfg={
		region:'center'
	} ;
	searchCfg.region='north';
	this.isClear=false;
	this.id=config.id;
	this.sm=new L5.grid.CheckboxSelectionModel();
	this.dataset=config.dataset;
	this.dataset.on('datachanged',this.selectValues,this);
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
	L5.MultiGridHelpWindow1.superclass.constructor.call(this,config,searchCfg);
	this.sm.on('rowselect',this.selectRow,this);
	this.sm.on('rowdeselect',this.deselectRow,this);
	this.on('beforeshow',this.helpObjInit,this);
} ;
L5.extend(L5.MultiGridHelpWindow1,L5.GridHelpWindow,{
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
		} 
		this.returns=records;
		this.isClear=false;
		this.hide();
		if(this.afterExecute){
			this.afterExecute();
		}
	} ,
	_clear:function(e){
		this.returns=[this.initRecord];
		this.isClear=true;
		this.hide();
		if(this.afterExecute){
			this.afterExecute();
		} 
	} 
} );