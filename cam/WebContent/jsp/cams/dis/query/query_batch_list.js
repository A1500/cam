function init() {
	batchds.load();
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {

	batchds.setParameter("CREATE_ORGAN_CODE@=",
			getParam("areacode"));
	batchds.setParameter("RELIEF_TYPE@=",
			getParam("reliefType"));
	batchds.setParameter("YEAR@=",
			getParam("ssnf"));
	batchds.load();
}

function detail() {

	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var url = "jsp/cams/dis/query/query_batch_detail_list.jsp";
	
	var data = new L5.Map();
	data.put("batchId",selected[0].get("batchId"));
	
	var text = "救灾明细信息";
	L5.forward(url,text,data);
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/dic_city/dicCity.jsp?organCode="
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
