function init() {
	var ContentPeopleDataset = L5.DatasetMgr.lookup("ContentPeopleDataset");
	ContentPeopleDataset.setParameter("contentNumId",contentNumId);
	ContentPeopleDataset.setParameter("organCode",organCode);
	ContentPeopleDataset.load();
	//L5.DatasetMgr.lookup("ds").load();	
	//L5.QuickTips.init();
};


function  detail(){
	var editGrid=L5.getCmp('gridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var serviceType = selected[0].get('SERVICE_TYPE');
	var url='contentPeopleDetail_list.jsp?peopleId='+peopleId+'&serviceType='+serviceType;
	var width = screen.width-200;
	var height = 520;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ContentPeopleDataset");
	var url = L5.webPath+'/jsp/cams/bpt/edoc/print/contListnew.fr3'; 
	var reportName="";
	
	doReportPrint(reportName,"fdfd","dfa",printDataset ,url);
}
 //打印预览调用方法
function printFront(){
	var editGrid=L5.getCmp('gridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var contentNumName = selected[0].get('contentNumName');
	var printDataset=L5.DatasetMgr.lookup("dsProInfo");
	printDataset.setParameter("DOMICILE_CODE@=",organCode);
	printDataset.load();
	var url = L5.webPath+'/jsp/cams/bpt/peopleBasicInfo/table/dcover.fr3'; 
	
	doReportPrint("","","",dsProPrint ,url);
}

