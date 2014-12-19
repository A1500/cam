function init(){
	ds.newRecord({"standardLevel":"03","evaluLevel":getDicText(EvaluLevelDataset,"03")});
	ds.newRecord({"standardLevel":"02","evaluLevel":getDicText(EvaluLevelDataset,"02")});
	ds.newRecord({"standardLevel":"01","evaluLevel":getDicText(EvaluLevelDataset,"01")});
}
function update(){
	var gridPanel=L5.getCmp('gridPanel');
	var selected=gridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data=new L5.Map();
	data.put("standardLevel",selected[0].get("standardLevel"));
	data.put("evaluLevel",encodeURIComponent(encodeURIComponent(selected[0].get("evaluLevel"))));
	var url='jsp/cams/marry/dept/level/mrm_level_setEdit.jsp';
	L5.forward(url,'',data);	
}
function renderEvaluLevel(val,c,rec){
	return '<a href="javascript:detail(\''+rec.get('standardLevel')+'\',\''+rec.get('evaluLevel') +'\')">'+val+'</a>';
}
function detail(standardLevel,evaluLevel){
	var data=new L5.Map();
	data.put("standardLevel",standardLevel);
	data.put("evaluLevel",encodeURIComponent(encodeURIComponent(evaluLevel)));
	var url='jsp/cams/marry/dept/level/mrm_level_setDetail.jsp';
	L5.forward(url,'',data);	
}
//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}	