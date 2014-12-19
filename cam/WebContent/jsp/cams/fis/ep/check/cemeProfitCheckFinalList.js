function init() {
	var userInfo = initArea();
	document.getElementById("areaLevelId").value = userInfo.cantCode;
	document.getElementById("areaLevel").value = userInfo.shortName;
	document.getElementById("isReportQ").selectedIndex = 1;

	if ((userInfo.cantCode.substr(4, 2) == '00')
			&& (userInfo.cantCode.substr(3, 1) != '0')) {
		// 市级
		// document.getElementById("result").value = "3";
		// document.getElementById("result").disabled = "disabled";
	}
	// L5.DatasetMgr.lookup("ds").load();
	directOrder();
	query();
	L5.QuickTips.init();
};

function resetQuery() {
	var userInfo = initArea();
	document.getElementById("isReportQ").selectedIndex = 1;
	document.getElementById("areaLevelId").value = userInfo.cantCode;
	document.getElementById("areaLevel").value = userInfo.shortName;
	document.getElementById("manaLevelId").value = "";
	document.getElementById("manaLevel").value = "";
	document.getElementById("cemeID").value = "";
	document.getElementById("year").value = "2011";
}

function directOrder() {
	if (getParam("isReportQ") == "0") {
		document.getElementById("a1").style.display = "block";
		document.getElementById("a2").style.display = "none";
	} else {
		document.getElementById("a1").style.display = "none";
		document.getElementById("a2").style.display = "block";
	}
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
	ds.setParameter("AREA_LEVEL_ID", getParam("areaLevelId"));
	ds.setParameter("MANA_LEVEL_ID", getParam("manaLevelId"));
	ds.setParameter("IS_REPORT", getParam("isReportQ"));
	ds.on("load", function() {
				var cemeTitle = L5.getCmp("cemeTitle");
				if (ds.getCount() > 0)
					cemeTitle.setText("需要进行年检的经营性公墓(" + ds.getTotalCount()
							+ "条)");
				else
					cemeTitle.setText("需要进行年检的经营性公墓");
			});
	ds.load();
}

// 整改
function fullChange() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条要上报的记录!");
		return false;
	}

	if (selected[0].get('CHECK_NUM') == "4") {
		L5.Msg.alert('提示', "公墓本年度年检已过两次，不可整改!");
		return false;
	}

	if (selected[0].get('IS_REPORT') == "0") {
		L5.Msg.alert('提示', "公墓未上报，不能整改!");
		return false;
	}

	L5.Msg.confirm('确认整改？', '是否要对公墓进行整改？', function(isOk) {
		if (isOk == 'yes') {
			var cmd = new L5.Command('com.inspur.cams.fis.ep.base.cmd.FisCemeCheckCmd');
			cmd.setParameter('WF_ID', selected[0].get('WF_ID'));
			cmd.execute('fullChangeProfitFinalCheck');
			if (!cmd.error) {
				L5.Msg.alert('提示', "整改成功!");
				query();
			} else {
				L5.Msg.alert('提示', "整改失败!");
			}
		}
	});
}

// 上报
function report() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条要上报的记录!");
		return false;
	}

	if (selected[0].get('IS_REPORT') == "1") {
		L5.Msg.alert('提示', "公墓已上报!");
		return false;
	}

	if (selected[0].get('CHECK_NUM') == "1") {
		L5.Msg.alert('提示', "公墓未年检，不可上报!");
		return false;
	} else if (selected[0].get('CHECK_NUM') == "3") {
		L5.Msg.alert('提示', "公墓本年度年检已过两次，不可上报!");
		return false;
	}

	L5.Msg.confirm('确认上报？', '公墓年检结果上报后不可修改！', function(isOk) {
		if (isOk == 'yes') {
			var cmd = new L5.Command('com.inspur.cams.fis.ep.base.cmd.FisCemeCheckCmd');
			cmd.setParameter('WF_ID', selected[0].get('WF_ID'));
			cmd.execute('reportProfitFinalCheck');
			if (!cmd.error) {
				L5.Msg.alert('提示', "上报成功!");
				query();
			} else {
				L5.Msg.alert('提示', "上报失败!");
			}
		}
	});
}

// 业务办理
function accepted() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条要年检的记录!");
		return false;
	}
	if ((selected[0].get('IS_REPORT') == "1")) {
		L5.Msg.alert('提示', "该公墓年检已上报，不能进行该操作!");
		return false;
	}

	var data = new L5.Map();
	data.put("cemeId", selected[0].get('CEME_ID'));
	data.put("wfId", selected[0].get('WF_ID'));
	data.put("checkYear", selected[0].get('CHECK_YEAR'));
	data.put("checkNum", selected[0].get('CHECK_NUM'));
	data.put("isEdit", selected[0].get('IS_EDIT'));
	data.put("endApplyId", selected[0].get('END_APPLY_ID'));

	var url = 'jsp/cams/fis/ep/check/cemeProfitInspectionFinalEdit.jsp';
	var text = '经营性公墓年检业务办理';
	L5.forward(url, text, data);
}

// 渲染年检结果
function rendenerCheckNum(value, cellmeta, record, rowindex, colindex, dataset) {
	if (value == "1")
		return "已检查";
	else if (value == "2" || value == "4")
		return "已年检";
	else if (value == "3")
		return "整改后年检";
	else
		return "已检查";
}

function print() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条要打印的记录!");
		return false;
	}
	if (selected[0].get('CHECK_RESULT') == "0"
			|| selected[0].get('CHECK_RESULT') == "") {
		L5.Msg.alert('提示', "需要进行年检!");
		return false;
	}
	var cemeId = selected[0].get('CEME_ID');
	var applyId = selected[0].get('END_APPLY_ID');

	var url = "../../comm/print/cemeprofitCheckPrint.jsp?docPath=cemeprofitCheckPrint.doc";
	url += "&cemeId=" + cemeId;
	url += "&applyId=" + applyId;
	var text = '经营性公墓年检报告打印';
	var width = 1024;
	var height = 768;
	window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
					+ width + "px;dialogHeight:" + height
					+ "px;resizable:no;status:no;");
}