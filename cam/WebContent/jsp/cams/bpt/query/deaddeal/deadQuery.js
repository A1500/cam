//初始化
function init(){
	L5.Ajax.timeout=300000;
	var deadBptObject = L5.DatasetMgr.lookup("deadBptObject");
	deadBptObject.setParameter("organCode",organCode);
	deadBptObject.setParameter("objectType",objectType);
	deadBptObject.setParameter("queryType",queryType);
	deadBptObject.setParameter("time",time);
	deadBptObject.load();
	deadBptObjectExcel.setParameter("organCode",organCode);
	deadBptObjectExcel.setParameter("objectType",objectType);
	deadBptObjectExcel.setParameter("queryType",queryType);
	deadBptObjectExcel.setParameter("time",time);
	deadBptObjectExcel.load();
}

//查看优抚对象信息
function bptDetail(){
	var basicInfoGrid;
	var objectType = '';
	basicInfoGrid=L5.getCmp('baseGridPanel');
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	var objectState = selected[0].get('OBJECT_STATE');
	if(objectType == ''){
		objectType = selected[0].get('OBJECT_TYPE');
	}
	var url=L5.webPath+'/jsp/cams/bpt/basicInfoView/basicInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}

//殡葬信息
function deathDetail(){
	var grid=L5.getCmp("baseGridPanel");
	var selected=grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var deadId=selected[0].get("DEAD_ID");
	var url=L5.webPath+'/jsp/cams/bpt/query/deaddeal/deathInfo.jsp?deadId='+deadId;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("deadBptObjectExcel");
	
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	
	L5.dataset2excel(dataset, "/jsp/cams/bpt/query/deaddeal/BookExcel.jsp");
}