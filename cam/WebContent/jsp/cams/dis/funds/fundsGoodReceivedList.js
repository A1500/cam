var date = L5.server.getSysDate();
function init() {
	year = date.getYear() + "";
	document.getElementById("qDisYear").value = year;
	query();
};

function query() {
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	disDetailSourceDs.setParameter("ALLOCATION_TYPE", "2");
	disDetailSourceDs.setParameter("FILL_ORGAN_CODE", organCode);
	
	disDetailSourceDs.setParameter("DIS_YEAR", getParam("qDisYear"));
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
// 新本级拨付
function addAllo() {
	var url = "fundsGoodReceivedEdit.jsp?method=insert";
	var width = 800;
    var height = 600;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		query();
	}
}
//修改
function editAllo() {
	var rec = selectedCue("修改");
	if (rec != undefined) {
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisDetailBatchCmd");
		command.setParameter('detailId',rec.get("detailId"));
		command.execute('queryIfUpdateGoodReceived');
		var msg = command.getReturn("msg");
		if(msg!=null) {
			L5.Msg.alert('提示', "捐赠物资已经使用，不可修改!");
			return false;
		}
		
		var url = "fundsGoodReceivedEdit.jsp?method=update&detailId="+rec.get("detailId");
		var width = 800;
	    var height = 600;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue) {
			query();
		}
	}
}

//删除
function delAllo() {
	var rec = selectedCue("删除");
	if (rec != undefined) {
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisDetailBatchCmd");
		command.setParameter('detailId',rec.get("detailId"));
		command.execute('queryIfUpdateGoodReceived');
		var msg = command.getReturn("msg");
		if(msg!=null) {
			L5.Msg.alert('提示', "捐赠物资已经使用，不可删除!");
			return false;
		}
		
		L5.Msg.confirm("提示", "是否删除捐赠物资？", function(isOk) {
					if (isOk == 'yes') {
						L5.Msg.wait("正在更新数据，请等待...", "更新数据");
						var cmd = new L5.Command('com.inspur.cams.dis.base.cmd.DisDetailBatchCmd');
						cmd.setParameter('detailId',rec.get("detailId"));
						cmd.execute('deleteGoodReceived');
						if(!cmd.error){
							L5.Msg.alert("提示", "捐赠物资删除成功！");
							query();
						}else{
							L5.Msg.alert("提示", "捐赠物资删除失败！");
						}
					}
				});
	}
}
//明细
function detailAllo() {
	var allocationGridPanel = L5.getCmp("allocationGridPanel");
	var selected = allocationGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = 'fundsGoodReceivedDetails.jsp?method=detail&detailId='+selected[0].get("detailId");
    var width = 800;
	var height = 600;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
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