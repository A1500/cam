function init() {
	var date = L5.server.getSysDate();
	year = date.getYear() + "";
	document.getElementById("qDisYear").value = year;
	query();
};

function query() {
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	disDetailBatchDs.setParameter("SOURCE_TYPE", "3");
	disDetailBatchDs.setParameter("FILL_ORGAN_CODE", organCode);
	disDetailBatchDs.setParameter("DIS_YEAR", getParam("qDisYear"));
	disDetailBatchDs.setParameter("IN_CONFIRM", getParam("qInConfirm"));
	disDetailBatchDs.load();
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

//确认采购
function confirmAllo() {
	var rec = selectedCue("确认");
	if (rec != undefined) {
		if(rec.get("inConfirm")!="0") {
			L5.Msg.alert('提示', "本次采购已经确认，不可修改!");
			return false;
		}
		//先判断是否已使用
		var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisDetailBatchCmd");
		cmd.setParameter("batchId", rec.get("batchId"));
		cmd.execute("queryIfUpdateGoodSwap");
		var msg = cmd.getReturn("msg");	
		if(msg!=null) {
			L5.Msg.alert('提示', "采购物资已经确认并使用，不可修改!");
			return false;
		}
	
		var url = 'fundsGoodSwapEdit.jsp?method=confirm&batchId='+rec.get("batchId");
		var width = screen.availWidth;
	    var height = screen.availHeight;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue){
			query();
		}
	}
}
// 新增
function addAllo() {
	var url = 'fundsGoodSwapEdit.jsp?method=insert';
	var width = screen.width;
    var height = screen.height;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue){
		query();
	}
}
//修改
function editAllo() {
	var rec = selectedCue("修改");
	if (rec != undefined) {
		if(rec.get("inConfirm")!="0") {
			L5.Msg.alert('提示', "本次采购已经确认，不可修改!");
			return false;
		}
		//先判断是否已使用
		var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisDetailBatchCmd");
		cmd.setParameter("batchId", rec.get("batchId"));
		cmd.execute("queryIfUpdateGoodSwap");
		var msg = cmd.getReturn("msg");	
		if(msg!=null) {
			L5.Msg.alert('提示', "采购物资已经确认并使用，不可修改!");
			return false;
		}
	
		var url = 'fundsGoodSwapEdit.jsp?method=update&batchId='+rec.get("batchId");
		var width = screen.availWidth;
	    var height = screen.availHeight;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue){
			query();
		}
	}
}
//删除
function delAllo() {
	var rec = selectedCue("删除");
	if (rec != undefined) {
		if(rec.get("inConfirm")!="0") {
			L5.Msg.alert('提示', "本次采购已确认，不可删除!");
			return false;
		}
		//先判断是否已使用
		var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisDetailBatchCmd");
		cmd.setParameter("batchId", rec.get("batchId"));
		cmd.execute("queryIfUpdateGoodSwap");
		var msg = cmd.getReturn("msg");	
		if(msg!=null) {
			L5.Msg.alert('提示', "采购物资已经使用，不可删除!");
			return false;
		}
		
		L5.Msg.confirm("提示", "是否删除本次采购？", function(isOk) {
					if (isOk == 'yes') {
						L5.Msg.wait("正在更新数据，请等待...", "更新数据");
						var cmd = new L5.Command('com.inspur.cams.dis.base.cmd.DisDetailBatchCmd');
						cmd.setParameter('batchId',rec.get("batchId"));
						cmd.execute('deleteSwap');
						if(!cmd.error){
							L5.Msg.alert("提示", "采购删除成功！");
							query();
						}else{
							L5.Msg.alert("提示", "采购删除失败！");
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
		L5.Msg.alert('提示', "请选择一条记录进行查看明细!");
		return false;
	}
	
	var url = 'fundsGoodSwapDetails.jsp?batchId='+selected[0].get("batchId")+"&organNameTitleCode=";
	var width = screen.width-100;
  var height = screen.height-140;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}
//进度追踪
function followAllo() {
	var allocationGridPanel = L5.getCmp("allocationGridPanel");
	var selected = allocationGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录进行追踪!");
		return false;
	}
	L5.Msg.alert('提示', "正在研发，请等待!");
	
//	var url = 'fundsGoodSwapDetails.jsp?batchId='+selected[0].get("batchId");
//	var width = screen.width-100;
//  	var height = screen.height-140;
//	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
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