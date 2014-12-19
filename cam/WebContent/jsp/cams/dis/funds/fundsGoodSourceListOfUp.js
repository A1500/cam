function init() {
	var date = L5.server.getSysDate();
	year = date.getYear() + "";
	document.getElementById("qDisYear").value = year;
	query();
}
function query() {
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	disDetailSourceDs.setParameter("ALLOCATION_TYPE", "0");
	disDetailSourceDs.setParameter("RECEIVE_ORGAN_CODE", organCode);
	
	disDetailSourceDs.setParameter("DIS_YEAR", getParam("qDisYear"));
	disDetailSourceDs.setParameter("UP_ALLOCATION_NUM@like", getParam("qUpAllocationNum"));
	disDetailSourceDs.setParameter("UP_ALLOCATION_PURPOSE@like", getParam("qUpAllocationPurpose"));
	disDetailSourceDs.load();
}

//提示
function selectedCue(cue) {
	var allocationGridPanel = L5.getCmp("allocationGridPanel");
	var selected = allocationGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录进行"+cue+"!");
		return undefined;
	}
	
	return selected[0];
}
//明细
function detailAllo() {
	var allocationGridPanel = L5.getCmp("allocationGridPanel");
	var selected = allocationGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	disDetailBatchSourceDs.setParameter("DETAIL_ID", selected[0].get("detailId"));
	disDetailBatchSourceDs.load();
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.show();
}
function onCloseDetails() {
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.hide();
}
// 渲染资金用途
function upAllocationPurposeRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = " ";
	for (var i = 0; i < disAllocationPurposeDs.getCount(); i++) {
		if (value.indexOf(disAllocationPurposeDs.getAt(i).get("value")) != -1) {
			str += disAllocationPurposeDs.getAt(i).get("text") + ",";
		}
	}
	return str.substring(0, str.length - 1);
}

// 渲染物资合计
function meterialAccountRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (isFloat(record.get("meterialUnitprice"))
			|| _isNum(record.get("meterialUnitprice"))) {
		if (isFloat(record.get("meterialNum"))
				|| _isNum(record.get("meterialNum"))) {
			var total = parseFloat(record.get("meterialUnitprice"))
					* parseFloat(record.get("meterialNum"));
			return formatMoneyForDis(total);
		}
	}
	return "0.00";
}

// 渲染金额结余
function amountBalanceRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (record.get("inUse") == "0")
		return "---";
	else
		return formatMoneyForDis(value);
}

// 渲染物资类型
function meterialTypeRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pos = dmDisMaterialTypeDs.find("code", value, 0);
	if (pos != -1) {
		var rec = dmDisMaterialTypeDs.getAt(pos);
		record.set("meterialUnit", rec.get("unit"));
		return rec.get("name");
	}
	return "";
}
//渲染是否确认
function inConfirmRenderer(value, cellmeta, record,
		rowindex, colindex, dataset) {
	if(value=="1")
		return "是";
	else if(value=="0")
		return "<font color=red>否</font>";
	
	return value;
}