function init() {
	/*L5.DatasetMgr.lookup("ds").load();
	ds.baseParams["INFO_ID@="]=idField;**/
	query();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	batchDetailds.setParameter("requiredOrganCode",getParam("requiredOrganCode"));	
	batchDetailds.setParameter("organCode",organCode);		
	batchDetailds.setParameter("RELIEF_TYPE@=",getParam("reliefType"));	
	batchDetailds.setParameter("FILL_STATE@=",'5');	
	batchDetailds.load();
}

function deal(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var url="end_info_list.jsp?reliefType="+selected[0].get("RELIEF_TYPE")+"&batchDetailId="+selected[0].get("BATCH_DETAIL_ID");
	var width = 1024;
	var height = 768;
    var reValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
   	query();
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(
			"../assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&level=3", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("requiredOrganName").value=list[4];
		document.getElementById("requiredOrganCode").value=list[0];
	}
}

