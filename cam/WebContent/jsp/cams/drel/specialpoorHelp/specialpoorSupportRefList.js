function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
//分组
function grender(val, unused, rec, rowIndex, colIndex, ds) {
	return rec.get("SUPPORT_UNIT_NAME");
}
function init(){
	query();
}
function query(){
	var specialpoorSupportRefDataSet=L5.DatasetMgr.lookup("specialpoorSupportRefDataSet");
	specialpoorSupportRefDataSet.setParameter("supportUnitCode", getParam("qSupportUnitCode"));
	specialpoorSupportRefDataSet.setParameter("supportUnitName", getParam("qSupportUnitName"));
	specialpoorSupportRefDataSet.load();
}
function update(){
	var grid=L5.getCmp("gridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
//	var data=new L5.Map();
//	data.put("method","update");
//	data.put("supportUnitCode",records[0].get("SUPPORT_UNIT_CODE"));
//	var url="jsp/cams/drel/specialpoorHelp/specialpoorSupportRefEdit.jsp";
//	L5.forward(url,'',data);
	
	var url = "specialpoorSupportRefEdit.jsp?method=update&supportUnitCode=" + records[0].get("SUPPORT_UNIT_CODE");
	var width = 1024;
    var height = 768;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
//	query();
}
/**


<!--isGroup="true" groupField="SUPPORT_UNIT_CODE"-->


<!--
	
	enableHdMenu="true" enableColumnHide="true"
	<next:GroupingView forceFit="true"></next:GroupingView>
	
	
			<next:ExtendConfig>
				groupRenderer:grender,groupName:"帮扶单位"
			</next:ExtendConfig>
	
-->

*/