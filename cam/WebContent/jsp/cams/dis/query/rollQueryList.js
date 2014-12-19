var num1;
var num2;
var charges1 = [];
var charges2 = [];
function init() {
	if (batchDetailId != "" && batchDetailId != null) {
		infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
		infoDs.load();
		infoDs.on('load', function() {
					if (infoDs.getCount() > 0) {
						hideYh(infoDs.getAt(0).get("allocationType"));
						for (var i = 0; i < infoDs.getCount(); i++) {
							doleDetailDs.setParameter("DOLE_ID", doleId);
							doleDetailDs.setParameter("INFO_ID", infoDs.getAt(i).get("infoId"));
							doleDetailDs.load(true);
							if (doleDetailDs.getCount() > 0) {
								infoDs.getAt(i).set("account", doleDetailDs.get("amount"));
							}else {
								infoDs.getAt(i).set("account", infoDs.getAt(i).get("approvalMoney"));
							}
						}
					}
				});
	}
	
	ifDetail = "1";
	//明细页面不显示操作按钮
	if(ifDetail=="1") {
		document.getElementById("btnSave").style.display='none';
		document.getElementById("btnConfirm").style.display='none';
		document.getElementById("btnDetail").style.display='none';
		document.getElementById("btnPrint").style.display='none';
		var gdGrid = L5.getCmp("dcGrid");
		gdGrid.getColumnModel().setEditable(8,false);
	}else if(ifPrint=="1") {
		document.getElementById("btnSave").style.display='none';
		document.getElementById("btnConfirm").style.display='none';
		var gdGrid = L5.getCmp("dcGrid");
		gdGrid.getColumnModel().setHidden(8,true);
	}else {
		document.getElementById("btnSave").style.display='';
		document.getElementById("btnConfirm").style.display='';
		document.getElementById("btnDetail").style.display='none';
		document.getElementById("btnPrint").style.display='none';
	}
}
//打印救助卡
function printCard(){
	var gdGrid = L5.getCmp("dcGrid");
	var selected = gdGrid.getSelectionModel().getSelections();
	if(selected.length<=0) {
		L5.Msg.alert('提示',"请选中一行!");
		return false;
	}
	var url = "../peoplePrint.jsp?docPath=peoplePrint.doc";
	var text = '名册打印';
	var width = 1024;
	var height = 768;
	var ifPrint = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
}
//查看救助明细
function cardInfo(){
	var gdGrid = L5.getCmp("dcGrid");
	var selected = gdGrid.getSelectionModel().getSelections();
	if(selected.length!=1) {
		L5.Msg.alert('提示',"请选中一行!");
		return false;
	}
	
	url = "../cardDetail.jsp?batchId=" + selected[0].get("batchId")
		+ "&batchDetailId=" + selected[0].get("batchDetailId")
		+ "&infoId=" + selected[0].get("infoId")+"&reliefType="+selected[0].get("reliefType");
	var width = 1024;
	var height = 768;
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}

window.onbeforeunload = function() {
	try{
		var parent = window.dialogArguments;
		var reliefDoleds = parent.reliefDoleds;
		reliefDoleds.reload();
	}catch(e){}
}
function query() {
	L5.Msg.alert('提示', "正在研发，请等待!");
	return false;

	infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
	infoDs.setParameter("NAME@rlike", getParam("qName"));
	infoDs.setParameter("ID_CARD@rlike", getParam("qIdCard"));
	infoDs.setParameter("FAMILY_REGISTER", getParam("qFamilyRegister"));
	infoDs.setParameter("FAMILY_TYPE", getParam("qFamilyType"));

	var qFamilyNumStart = getParam("qFamilyNumStart");
	var qFamilyNumEnd = getParam("qFamilyNumEnd");
	if (_isNum(qFamilyNumStart) && _isNum(qFamilyNumEnd)) {
		infoDs.setParameter("FAMILY_NUM@between", qFamilyNumStart + "~"
						+ qFamilyNumEnd);
	} else if (_isNum(qFamilyNumStart)) {
		infoDs.setParameter("FAMILY_NUM@between", qFamilyNumStart + "~9999");
	} else if (_isNum(qFamilyNumEnd)) {
		infoDs.setParameter("FAMILY_NUM@between", "0~" + qFamilyNumEnd);
	}

	var qApprovalTimesStart = getParam("qApprovalTimesStart");
	var qApprovalTimesEnd = getParam("qApprovalTimesEnd");
	if (_isNum(qApprovalTimesStart) && _isNum(qApprovalTimesEnd)) {
		infoDs.setParameter("APPROVAL_TIMES@between", qApprovalTimesStart + "~"
						+ qApprovalTimesEnd);
	} else if (_isNum(qApprovalTimesStart)) {
		infoDs.setParameter("APPROVAL_TIMES@between", qApprovalTimesStart
						+ "~9999");
	} else if (_isNum(qApprovalTimesEnd)) {
		infoDs.setParameter("APPROVAL_TIMES@between", "0~" + qApprovalTimesEnd);
	}

	infoDs.setParameter("ACCEPT_AREA_CODE", getParam("qAcceptAreaCode"));
	infoDs.load();
}
// 隐藏银行信息
function hideYh(at) {
	if (at == "0") {
		var gdGrid = L5.getCmp("dcGrid");
		gdGrid.getColumnModel().setHidden(4, true);
		gdGrid.getColumnModel().setHidden(5, true);
	}
}
// 保存
function save() {
	var records = infoDs.getAllRecords();
	for (var i = 0; i < records.length; i++) {
		if (records[i].get('account') == ""
				|| records[i].get('account') == null) {
			L5.Msg.alert("提示", "实际发放金额不能为空！");
			return false;
		}
		charges1[i] = records[i].get("account");
	}
	if (num1 < num2) {
		L5.Msg.alert("提示", "实际发放金额不能大于核准发放资金!");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要保存该记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
			command.setParameter("records", infoDs.getAllRecords());// 业务信息
			command.setParameter("inConfirm", "0");// 是否确认
			command.setParameter("doleId", doleId);//
			command.execute("saveDole");
			if (!command.error) {
				L5.Msg.alert('提示', "保存成功！", function() {
							query();
							for (var i = 0; i < infoDs.getCount(); i++) {
								if (doleDetailDs.getCount() > 0) {
									infoDs.getAt(i).set("account", charges1[i]);
								}
							}
						});
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}

// 确认
var doleMoney=0.0; //发放总金额
function confirm() {
	doleMoney=0.0;	//重置总金额
	var records = infoDs.getAllRecords();
	for (var i = 0; i < records.length; i++) {
		if (records[i].get('account') == ""
				|| records[i].get('account') == null) {
			L5.Msg.alert("提示", "实际发放金额不能为空！");
			return false;
		}
		charges2[i] = records[i].get("account");
		doleMoney += parseFloat(records[i].get('account'));
	}
	// 判断是否已确认发放
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefDoleCmd");
	command.setParameter("doleId", doleId);
	command.execute("queryGive");
	var flag = command.getReturn("flag");
	if (flag == '1') {
		L5.Msg.alert("提示", "该记录已确认发放，不能重复确认!");
		return;
	}
	if (num1 < num2) {
		L5.Msg.alert("提示", "实际发放金额不能大于核准发放资金!");
		return;
	}

	//显示资金
	var fundsWin = L5.getCmp("fundsWin");
	fundsWin.show();
	
	//加载资金信息
	disFundsBatchSourceDs.setParameter("receiveOrganCode", organCode);
	disFundsBatchSourceDs.setParameter("batchId", batchId);
	disFundsBatchSourceDs.load();
	
	//显示发放总金额
	doleMoney = doleMoney/10000.00;
	document.getElementById("doleMoney").innerHTML=doleMoney+"万元";
}
// 取消
function onCancel() {
	var fundsWin = L5.getCmp("fundsWin");
	fundsWin.hide();
}
// 保存确认
function onSaveConfirm() {
	var	panel = L5.getCmp('winGrid');
	var selected = panel.getSelectionModel().getSelections();
	var sums = 0.0;
	for(var i=0;i<selected.length;i++) {
		var amountPay = selected[i].get("amountPay");
		if(!isNaN(parseFloat(amountPay))) {
			if(parseFloat(amountPay)<=0.0) {
				L5.Msg.alert('提示',"选中明细的支出金额必须大于零!");
				return false;
			}
			sums += parseFloat(amountPay);
		}else {
			L5.Msg.alert('提示',"选中明细的支出金额必须大于零!");
			return false;
		}
		if(selected[i].get("ifCarry")=="1") {
			L5.Msg.alert('提示',"拨付资金明细里，选中数据的第"+(i+1)+"行为结转数据(参看备注)，不能使用，请选择别的记录!");
			return false;
		}
	}
	if(doleMoney != sums) {
		L5.Msg.alert('提示',"选中明细的支出金额之和必须等于发放金额!");
		return false;
	}
	
	L5.MessageBox.confirm('确定', '是否确认资金发放?确认后不可修改！', function(state) {
		if (state == "yes") {
			L5.Msg.alert('提示',"OK!");
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
			command.setParameter("records", infoDs.getAllRecords());// 业务信息
			command.setParameter("funds", selected);// 使用资金信息
			command.setParameter("inConfirm", "1");// 是否确认
			command.setParameter("doleId", doleId);//
			command.execute("saveDole");
			if (!command.error) {
				L5.Msg.alert('提示', "确认成功！", function() {
							onCancel();
							query();
							document.getElementById("btnSave").style.display='none';
							document.getElementById("btnConfirm").style.display='none';
							var gdGrid = L5.getCmp("dcGrid");
							gdGrid.getColumnModel().setEditable(8,false);
							
							for (var i = 0; i < infoDs.getCount(); i++) {
								doleDetailDs.setParameter("DOLE_ID", doleId);
								doleDetailDs.setParameter("INFO_ID", infoDs.getAt(i).get("infoId"));
								doleDetailDs.load(true);
								if (doleDetailDs.getCount() > 0) {
									infoDs.getAt(i).set("account", charges2[i]);
								}
							}
						});
			} else {
				L5.Msg.alert('提示', "确认时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}


// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qAcceptAreaCode").value = list[0];
		document.getElementById("qAcceptAreaName").value = list[4];
	}
}
function forExcel() {

}

function countNum1(value) {
	num1 = value;
	return value;
}
function countNum2(value) {
	num2 = value;
	return value;
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
//渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("ifCarry")=="1")
		return "【已结转】"+value;
	return value;
}