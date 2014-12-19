function init() {
	var ContentNumMaintainDataset = L5.DatasetMgr.lookup("ContentNumMaintainDataset");
	ContentNumMaintainDataset.setParameter("DOMICILE_CODE@=",organCode);
	ContentNumMaintainDataset.load();
	//L5.DatasetMgr.lookup("ds").load();	
	//L5.QuickTips.init();
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
	ContentNumMaintainDataset.setParameter("DOMICILE_CODE@=",organCode);
	ContentNumMaintainDataset.load();
}

function reset(){
	document.getElementById("contentNumName").value = "";
	document.getElementById("fileCabinetName").value = "";
	document.getElementById("contentYear").value = "";
	document.getElementById("plaitDate").value = "";
	document.getElementById("collator").value = "";
	document.getElementById("examiner").value = "";
}

function  confirmValue(){
	var editGrid=L5.getCmp('gridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	var contentNumName = selected[0].get('contentNumName');
	
	window.returnValue=contentNumName;
	window.close();
}

function closew(){
	window.returnValue="";
	window.close();
}

function clears(){
   window.returnValue=";;;;;;;"
   window.close();
}

