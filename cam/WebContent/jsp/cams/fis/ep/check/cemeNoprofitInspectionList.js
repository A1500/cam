function init() {
	var userInfo = initArea();
	document.getElementById("areaLevelId").value = userInfo.cantCode;
	document.getElementById("areaLevel").value = userInfo.shortName;
	if ((userInfo.cantCode.substr(4, 2) == '00')
			&& (userInfo.cantCode.substr(3, 1) != '0')) {
		document.getElementById("result").value = "3";
		document.getElementById("result").disabled = "disabled";
	}
	// L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function resetQuery() {
	var userInfo = initArea();
	document.getElementById("areaLevelId").value = userInfo.cantCode;
	document.getElementById("areaLevel").value = userInfo.shortName;
	document.getElementById("manaLevelId").value = "";
	document.getElementById("manaLevel").value = "";
	document.getElementById("cemeID").value = "";
	document.getElementById("year").value = "2011";
	document.getElementById("result").value = "";
	document.getElementById("cemeProp").value = "";
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

var regex = /^20\d{2}$/;
// 年检查询
function query() {
	var year = getParam("year");
	if (!regex.test(year)) {
		L5.Msg.alert('提示', "请输入正确年份!");
		return;
	}
	ds.setParameter("CEME_ID", getParam("cemeID"));
	ds.setParameter("CHECK_YEAR", year);
	ds.setParameter("CHECK_RESULT", getParam("result"));
	ds.setParameter("AREA_LEVEL_ID", getParam("areaLevelId"));
	ds.setParameter("MANA_LEVEL_ID", getParam("manaLevelId"));
	ds.setParameter("PROP", getParam("cemeProp"));
	ds.load();
}

// 业务办理
function accepted() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条要年检的记录!");
		return false;
	}
	if ((selected[0].get('CHECK_RESULT') == "1")) {
		L5.Msg.alert('提示', "该公墓年检已结束，不能进行该操作!");
		return false;
	}

	var data = new L5.Map();
	data.put("dataBean", selected[0].get('CEME_ID'));
	data.put("resultId", selected[0].get('RESULT_ID'));
	data.put("applayId", selected[0].get('FIRST_APPLY_ID'));
	data.put("checkYear", selected[0].get('CHECK_YEAR'));
	data.put("checkNum", selected[0].get('CHECK_NUM'));

	if (selected[0].get('CHECK_RESULT') == "0") {
		// 未参检
		data.put("method", "INSERT");
	} else if ((selected[0].get('CHECK_RESULT') == "4")) {
		// 检查不合格
		data.put("method", "INSERT");
	} else if (selected[0].get('CHECK_RESULT') == "3") {
		// 已检查
		data.put("method", "UPDATE");
	} else if (selected[0].get('CHECK_RESULT') == "2") {
		// 不合格
		data.put("method", "INSERT");
	}

	if (selected[0].get('PROP') == "2") {
		var url = 'jsp/cams/fis/ep/check/cemeProfitInspectionEdit.jsp';
		var text = '经营性公墓年检业务办理';
		L5.forward(url, text, data);
	} else {
		var url = 'jsp/cams/fis/ep/check/cemeNoprofitInspectionEdit.jsp';
		var text = '公益性公墓年检业务办理';
		L5.forward(url, text, data);
	}
}
