function init() {
	var ContentNumMaintainDataset = L5.DatasetMgr.lookup("ContentNumMaintainDataset");
	//ContentNumMaintainDataset.setParameter("DOMICILE_CODE@=",organCode);
	if (!organCode.substring(0, 2)=="00" && organCode.substring(2, 4)=="00") {
		ContentNumMaintainDataset.setParameter("DOMICILE_CODE@LIKE",organCode.substring(0, 2));
	}else if(!organCode.substring(2, 4)=="00"&&organCode.substring(4, 6)=="00"){
		ContentNumMaintainDataset.setParameter("DOMICILE_CODE@LIKE",organCode.substring(0, 4));//市局
	}else{
		ContentNumMaintainDataset.setParameter("DOMICILE_CODE@LIKE",organCode.substring(0, 6));//区县
	}
	ContentNumMaintainDataset.load();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){		
	ContentNumMaintainDataset.setParameter("BPT_ELECTRONIC_CONTENT_NUM.CONTENT_NUM_NAME@LIKE",getParam("contentNumName"));		
	ContentNumMaintainDataset.setParameter("BPT_ELECTRONIC_CONTENT_NUM.FILE_CABINET_NAME@LIKE",getParam("fileCabinetName"));		
	ContentNumMaintainDataset.setParameter("BPT_ELECTRONIC_CONTENT_NUM.CONTENT_YEAR@LIKE",getParam("contentYear"));		
	ContentNumMaintainDataset.setParameter("BPT_ELECTRONIC_CONTENT_NUM.PLAIT_DATE@LIKE",getParam("plaitDate"));		
	ContentNumMaintainDataset.setParameter("BPT_ELECTRONIC_CONTENT_NUM.COLLATOR@LIKE",getParam("collator"));		
	ContentNumMaintainDataset.setParameter("BPT_ELECTRONIC_CONTENT_NUM.EXAMINER@LIKE",getParam("examiner"));
	if (!organCode.substring(0, 2)=="00" && organCode.substring(2, 4)=="00") {
		ContentNumMaintainDataset.setParameter("DOMICILE_CODE@LIKE",organCode.substring(0, 2));
	}else if(!organCode.substring(2, 4)=="00"&&organCode.substring(4, 6)=="00"){
		ContentNumMaintainDataset.setParameter("DOMICILE_CODE@LIKE",organCode.substring(0, 4));//市局
	}else{
		ContentNumMaintainDataset.setParameter("DOMICILE_CODE@LIKE",organCode.substring(0, 6));//区县
	}
	ContentNumMaintainDataset.load();
	noReclick(ContentNumMaintainDataset,"queryButton");
}

function reset(){
	document.getElementById("contentNumName").value = "";
	document.getElementById("fileCabinetName").value = "";
	document.getElementById("contentYear").value = "";
	document.getElementById("plaitDate").value = "";
	document.getElementById("collator").value = "";
	document.getElementById("examiner").value = "";
}

function  detail(){
	var editGrid=L5.getCmp('gridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	var contentNumId = selected[0].get('contentNumId');
	var url='contentPeople_list.jsp?contentNumId='+contentNumId;
	var width = screen.width-200;
	var height = 520;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/peopleBasicInfo/table/Electronic2.fr3'; 
	var reportName="归档文件目录";
	
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
	var contentNumId = selected[0].get('contentNumId');
	var printDataset=L5.DatasetMgr.lookup("dsProPrint");
	printDataset.setParameter("contentNnmId",contentNumId);
	printDataset.load();
	printDataset.on("load",function(){
		printDataset.events['load'] = true;
		var url = L5.webPath+'/jsp/cams/bpt/edoc/print/dcover1.fr3'; 
		doReportPrint("","","",printDataset ,url);
	})
}


