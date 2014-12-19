function init() {
	L5.QuickTips.init();
	var editGrid = L5.getCmp('editGridPanel');
	editGrid.on("celldblclick",sure);
	query();
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {

	/*batchds.setParameter("CREATE_ORGAN_CODE@=",
			getParam("areacode"));*/
	batchds.setParameter("RELIEF_TYPE@=",
			reliefType);
	batchds.setParameter("YEAR@=",
			getParam("ssnf"));
	batchds.setParameter("FILL_STATE@=",
			'5');
	batchds.load();
}

function sure() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	if(selected[0].get("batchDetailId") !=""){
	     window.returnValue=selected[0].get("batchDetailId")+";"+selected[0].get("batchName");
	     window.close();
	}else{
		L5.Msg.alert("提示","请选一天记录!");
	    return false;
	}
}
function closew(){
	//return false;
	window.returnValue="";
	window.close();
}

function clears(){
  //window.returnValue=""+";"+""+";"+""+";"+""+";"+""+";"+""+";"+"";
   window.returnValue=";"
	window.close();

}
/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("areacode").value = list[0];
		document.getElementById("areaname").value = list[4];
	}
}
