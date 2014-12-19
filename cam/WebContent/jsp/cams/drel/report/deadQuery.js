//初始化
function init(){
	L5.Ajax.timeout=300000;
	var deadDrelObject = L5.DatasetMgr.lookup("deadDrelObject");
	deadDrelObject.setParameter("organCode",organCode);
	deadDrelObject.setParameter("objectType",objectType);
	deadDrelObject.setParameter("queryType",queryType);
	deadDrelObject.setParameter("time",time);
	deadDrelObject.load();
}

//查看低保对象信息
function drelDetail(){
	var basicInfoGrid;
	var objectType = '';
	basicInfoGrid=L5.getCmp('baseGridPanel');
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var applyId = selected[0].get('APPLY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	var	assistanceType = selected[0].get('ASSISTANCE_TYPE');
	//var url=L5.webPath+'/jsp/cams/bpt/basicInfoView/basicInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
	//var width = screen.width-60;
	//var height = 580;
	//var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	//if (win==null) {
	//	return;
	//}
	getPeopleInfo(peopleId,applyId,assistanceType);
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
	var url=L5.webPath+'/jsp/cams/drel/report/drelDeathInfo.jsp?deadId='+deadId;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
//导出Excel
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("deadDrelObject");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset, "/jsp/cams/drel/report/Excel.jsp");
	//dataset.baseParams["excelType"]="reset"; //重置导出类型
}
