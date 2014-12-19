var _doleType = "2";// 拨付类型标识为资金
function init() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;

	query();
	L5.QuickTips.init();
};
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function resetClick() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;
	document.getElementById("reliefType").value = '';
	document.getElementById("fillState").value = '';
}
function query() {
	reliefDoleds.setParameter("requiredOrganCode",
			getParam("requiredOrganCode"));
	reliefDoleds.setParameter("reliefType", getParam("reliefType"));
	if (getParam("fillState") != undefined) {
		reliefDoleds.setParameter("fillState", getParam("fillState"));
	} else {
		reliefDoleds.setParameter("fillState", "9,E");
	}
	reliefDoleds.setParameter("doleType", _doleType);
	reliefDoleds.load();
}
// 发放
function editDole() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var url = "";
	var width = 1024;
	var height = 768;

	// 先判断是否存在资金发放记录
	var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefDoleCmd");
	cmd.setParameter("batchDetailId", selected[0].get("BATCH_DETAIL_ID"));
	cmd.setParameter("doleType", _doleType);
	cmd.execute("queryIfUseDole");
	var flag = cmd.getReturn("flag");
	flag = "MORE";
	if (flag == null) {
		// 无则进入新增页面
		if (selected[0].get("RELIEF_TYPE") == 'DC') {
			url = "dc/dcDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID");
		} else if (selected[0].get("RELIEF_TYPE") == 'YJ') {
			url = "yj/yjDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID");
		} else if (selected[0].get("RELIEF_TYPE") == 'GD') {
			url = "gd/gdDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID");
		} else if (selected[0].get("RELIEF_TYPE") == 'CJ') {
			url = "cj/cjDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID");
		} else if (selected[0].get("RELIEF_TYPE") == 'SW') {
			url = "sw/swDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID");
		}
	} else if (flag != "MORE") {
		// 一条则返回此条的主键进入修改页面
		if (selected[0].get("RELIEF_TYPE") == 'DC') {
			url = "dc/dcDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID") + "&doleId=" + flag;
		} else if (selected[0].get("RELIEF_TYPE") == 'YJ') {
			url = "yj/yjDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID") + "&doleId=" + flag;
		} else if (selected[0].get("RELIEF_TYPE") == 'GD') {
			url = "gd/gdDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID") + "&doleId=" + flag;
		} else if (selected[0].get("RELIEF_TYPE") == 'CJ') {
			url = "cj/cjDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID") + "&doleId=" + flag;
		} else if (selected[0].get("RELIEF_TYPE") == 'SW') {
			url = "sw/swDoleGoodsRollList.jsp?batchId="
					+ selected[0].get("BATCH_ID") + "&batchDetailId="
					+ selected[0].get("BATCH_DETAIL_ID") + "&doleId=" + flag;
		}
	} else {
		// 多条则进入选择列表
		width = 800;
		height = 600;
		url = "goodsRollDetails.jsp?batchId=" + selected[0].get("BATCH_ID")
				+ "&batchDetailId=" + selected[0].get("BATCH_DETAIL_ID")
				+ "&reliefType=" + selected[0].get("RELIEF_TYPE");
	}
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	query();
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog("../comm/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)) + "&level=3", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("requiredOrganName").value = list[4];
		document.getElementById("requiredOrganCode").value = list[0];
	}
}
// 渲染发放数
function doleNumsRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	return record.get("METES_NUMS") + "/" + value;
}