var userInfo;
function init() {
	userInfo = initArea();
	document.getElementById("areaLevelId").value = userInfo.cantCode;
	document.getElementById("deptName").value = userInfo.shortName;

	query();
	L5.QuickTips.init();
};

function resetQuery() {
	document.getElementById("areaLevelId").value = userInfo.cantCode;
	document.getElementById("deptName").value = userInfo.shortName;
	document.getElementById("manaLevelId").value = "";
	document.getElementById("manaLevel").value = "";
	document.getElementById("cemeID").value = "";
	document.getElementById("year").value = "2013";
	document.getElementById("result").value = "";
	document.getElementById("cemeProp").value = "";
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

// 导出为excel
function exportExcel() {
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"] = "1"; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	ds.baseParams["limitExcel"] = total; // 导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds, "/jsp/cams/fis/ep/query/forCemeQueryExcel.jsp");
	ds.baseParams["excelType"] = "reset"; // 重置导出类型
}

// 年检查询
function query() {
	ds.setParameter("CEME_ID", getParam("cemeID"));
	ds.setParameter("CHECK_YEAR", getParam("year"));
	ds.setParameter("MANA_LEVEL_ID", getParam("manaLevelId"));
	ds.setParameter("AREA_LEVEL_ID", getParam("areaLevelId"));
	ds.setParameter("CHECK_RESULT", getParam("result"));
	ds.setParameter("PROP", getParam("cemeProp"));
	ds.on("load", function() {
				var cemeTitle = L5.getCmp("cemeTitle");
				if (ds.getCount() > 0)
					cemeTitle.setText("公墓年检信息列表(" + ds.getTotalCount() + "条)");
				else
					cemeTitle.setText("公墓年检信息列表");
			});
	ds.load();
}
// 明细
function detail() {
	var editGridPanel = L5.getCmp('editGridPanel');
	var selected = editGridPanel.getSelectionModel().getSelections();
	var detailDS = L5.DatasetMgr.lookup("detailDS");
	var fisCemeApplyInfoDataSet = L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	
//	alert(selected[0].get("RECORD_ID"));
	if(selected[0].get("APPLY_ID")!="00"){
		var win = L5.getCmp("CheckDetailWin");
		win.show();
		fisCemeApplyInfoDataSet.setParameter("CEME_APPLY_ID", selected[0].get("APPLY_ID"));
		fisCemeApplyInfoDataSet.load(true);
		detailDS.setParameter("RECORD_ID", selected[0].get("RECORD_ID"));
		detailDS.load(true);
		
	}else{
		var win = L5.getCmp("CemeDetailWin");
		win.show();
		detailDS.setParameter("RECORD_ID", selected[0].get("RECORD_ID"));
		detailDS.load(true);
		
	}
}
function undoWin() {
	var editGridPanel = L5.getCmp('editGridPanel');
	var selected = editGridPanel.getSelectionModel().getSelections();
	var detailDS = L5.DatasetMgr.lookup("detailDS");
	if(selected[0].get("APPLY_ID")!="00"){
		var win = L5.getCmp("CheckDetailWin");
		win.hide();
	}else{
		var win = L5.getCmp("CemeDetailWin");
		detailDS.removeAll();
		win.hide();
	}
	
}
function forjyDetail() {
	var editGrid = L5.getCmp('jingyingGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条查看的记录!");
		return false;
	}
	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");
	scoreDataSet.setParameter("CEME_APPLY_ID", selected[0].get('cemeApplyId'));
	scoreDataSet.load(true);

	var cemeApplyId = selected[0].get('cemeApplyId');
	var recordId = selected[0].get('recordId');
	var scoreId =scoreDataSet.get('scoreId');
	var url = "../../ep/query/fisCemeYearlyCheckDetail.jsp?recordId="
			+ recordId + "&cemeApplyId=" + cemeApplyId
			+ "&scoreId=" + scoreId + "&method=" +"DETAIL";
	var win = window
			.showModalDialog(url, window,
					"dialogHeight:800px;dialogWidth:900px;resizable:yes;scroll:yes;status:no");
}
// 修改
function update() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条要修改的记录!");
		return false;
	}

	var data = new L5.Map();
	data.put("method", "UPDATE");
	data.put("idField", selected[0].get('APPLY_ID'));
	data.put("checkNum", selected[0].get('CHECK_NUM'));
	data.put("resultId", selected[0].get('RESULT_ID'));
	var text = '修改公墓年检信息';
	var url = "jsp/cams/fis/ep/query/common/cemeAcceptedInspectionEdit.jsp"
	L5.forward(url, text, data);
}

function selectUser(flag) {
	L5.informSession = {};
	L5.informSession.getUserInfo = function() {
		if (sameDomain && top.userInfo != null)
			return top.userInfo;
		var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
		command.execute("getUserInfo");
		if (!command.error) {
			var info = command.getReturn("userInfo");
			if (sameDomain) {
				top.userInfo = info;
			}
			return info;
		} else {
			alert("用户没有登录！");
		}
	}
	var userInfo = L5.informSession.getUserInfo();
	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;

	var url = "../comm/approvalOrganTreeCheckBox.jsp?cantCode=" + cantCode
			+ "&cantName=" + escape(encodeURIComponent(cantName));
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}

	var id = "";
	var name = "";
	var id_name = "";

	// 如果是点击的是【确定】
	if (win[0].length > 0) {

		// 第一个值前面没有逗号
		id = win[0][0];// id1,id2,id3......
		name = win[1][0];// name1,name2,name3......
		id_name = id + "[" + name + "]";// id1[name1],id2[name2],id3[name3].......

		// 其余值之间用逗号分隔
		if (win[0].length > 1) {
			for (var i = 1; i < win[0].length; i++) {
				id = id + "," + win[0][i];
				name = name + "," + win[1][i];
				id_name = id_name + "," + win[0][i] + "[" + win[1][i] + "]";
			}
		}
	}
	document.getElementById("manaLevel").value = name;
	document.getElementById("manaLevelId").value = id;

	// var record=ds.getCurrent();
	// record.set("manaLevel", name);
	// record.set("manaLevelId", id);
	// document.getElementById("organCode").value=id;
}
// 渲染经营性公墓年检次数
function proCheckNumRendener(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (value == "1")
		return "县级检查";
	else if (value == "2")
		return "市级年检";
	else if (value == "3")
		return "县级复查";
	else if (value == "4")
		return "市级复检";
	return value;
}

// 渲染公益性公墓年检次数
function noproCheckNumRendener(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (value == "1")
		return "县级年检";
	else if (value == "2")
		return "县级复检";
	return value;
}
