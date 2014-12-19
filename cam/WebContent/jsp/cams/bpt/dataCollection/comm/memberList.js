function init(){
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
	//BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
	BaseinfoPeopleDataSet.load();
	var queryTotalDataset = L5.DatasetMgr.lookup("queryTotalDataset");
	queryTotalDataset.setParameter("familyId",familyId);
	queryTotalDataset.load();
	L5.QuickTips.init();
}

function insert(){
    
	var url='memberInsert.jsp?familyId='+familyId;
	var width = 800;
	var height = 420;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init();
	window.location.reload();
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	
	var peopleId = selected[0].get('peopleId');
	
	var url='memberUpdate.jsp?peopleId='+peopleId;
	var width = 800;
	var height = 430;
	var win = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init();
	window.location.reload();
}

function del(){

}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	
	var peopleId = selected[0].get('peopleId');
	
	var url='memberDetail.jsp?peopleId='+peopleId;
	var width = 800;
	var height = 380;
	var win = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}