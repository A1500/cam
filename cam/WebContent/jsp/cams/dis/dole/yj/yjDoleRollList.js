var _doleType = "1";// 拨付类型标识为资金
var tDate = L5.server.getSysDate();
function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	initDetail();
	infoDs.on('load', function() {
		setTimeout(defSelected, 1500);
	});
	if (doleId != "" && doleId != null && doleId != 'null') {
		//如果存在流水ID，则获取此流水信息
		doleDs.on('load', function() {
			hideYh(doleDs.getAt(0).get("allocationType"));
		});
		doleDs.setParameter("DOLE_ID", doleId);
		doleDs.load();
		
		infoDs.setParameter("batchDetailId", batchDetailId);
		infoDs.setParameter("doleId", doleId);
		infoDs.setParameter("doleType", _doleType);
		infoDs.load();
	}else {
		doleId = uu32;
		batchds.on('load', function() {
					hideYh(batchds.getAt(0).get("allocationType"));
					doleDs.newRecord({
								"doleId" : doleId,
								"batchId" : batchId,
								"batchDetailId" : batchDetailId,
								"fillOrganCode" : organCode,
								"fillOrganName" : organName,
								"fillTime" : formatDateToString(tDate),
								"doleType" : _doleType,
								"amount" : 0,
								"meterial" : 0,
								"allocationType" : batchds.getAt(0).get("allocationType"),
								"grantType" : batchds.getAt(0).get("grantType")
							});

				});
		batchds.setParameter("BATCH_ID", batchId);
		batchds.load(true);
		
		infoDs.setParameter("batchDetailId", batchDetailId);
		infoDs.setParameter("doleType", _doleType);
		infoDs.load();
	}
}
// 隐藏银行信息
function hideYh(at) {
	if (at == "0") {
		var yjGrid = L5.getCmp("yjGrid");
		yjGrid.getColumnModel().setHidden(5, true);
		yjGrid.getColumnModel().setHidden(6, true);
	}
}
//当标识为明细页面，进行初始化
function initDetail() {
	if (ifDetail == "T") {
		document.getElementById("fillPeopleName").disabled="disabled";
		document.getElementById("fillTime").disabled="disabled";
		document.getElementById("note").disabled="disabled";
		document.getElementById("timeImg").style.display = 'none';
		
		document.getElementById("btnSave").style.display = 'none';
		document.getElementById("btnConfirm").style.display = 'none';
		var yjGrid = L5.getCmp("yjGrid");
		yjGrid.getColumnModel().setEditable(8, false);
	}
}
//保存后列表选择效果
function defSelected() {
	var winGrid = L5.getCmp("yjGrid");
	for(var i=0;i<infoDs.getCount();i++) {
		var rec = infoDs.getAt(i);
		if(rec.get("AMOUNT")>0.0) {
			winGrid.getSelectionModel().selectRow(i, true);
		}
	}
	L5.Msg.hide();
}
// 保存
function save() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	//校验
	var valid = doleDs.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		return false;
	}	
	
	var yjGrid = L5.getCmp("yjGrid");
	var selected = yjGrid.getSelectionModel().getSelections();
	if (selected.length <= 0) {
		L5.Msg.alert('提示', "请选中需要发放的记录!");
		return false;
	}
	
	for (var i = 0; i < selected.length; i++) {
		var amount = selected[i].get("AMOUNT");
		if(!isNaN(parseFloat(amount))) {
			if(parseFloat(amount)<=0.0) {
				L5.Msg.alert('提示',"选中发放记录的实际发放金额必须大于零!");
				return false;
			}
		}else {
			L5.Msg.alert('提示',"选中发放记录的实际发放金额必须大于零!");
			return false;
		}
	}
	
	L5.MessageBox.confirm('确定', '确定要保存选中记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
			doleDs.getCurrent().set("inConfirm","0");
			command.setParameter("doleRec", doleDs.getCurrent());// 发放流水
			command.setParameter("infoRecs", selected); // 选择发放的档案信息
			command.execute("saveDoleInfo");
			if (!command.error) {
				L5.Msg.alert('提示', "保存成功！", function() {
							L5.Msg.wait("正在加载数据，请等待...", "加载数据");
							doleDs.setParameter("DOLE_ID", doleId);
							doleDs.load();

							infoDs.setParameter("batchDetailId", batchDetailId);
							infoDs.setParameter("doleId", doleId);
							infoDs.setParameter("doleType", _doleType);
							infoDs.load();
						});
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}

// 确认前
var doleMoney = 0.0; // 发放总金额
var doleNums = 0;	//发放记录数
function inConfirm() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	doleMoney = 0.0; // 重置总金额
	doleNums = 0;	//重置记录数
	
	//校验
	var valid = doleDs.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		return false;
	}	
	
	var yjGrid = L5.getCmp("yjGrid");
	var selected = yjGrid.getSelectionModel().getSelections();
	if (selected.length <= 0) {
		L5.Msg.alert('提示', "请选中需要发放的记录!");
		return false;
	}
	
	for (var i = 0; i < selected.length; i++) {
		var amount = selected[i].get("AMOUNT");
		if(!isNaN(parseFloat(amount))) {
			if(parseFloat(amount)<=0.0) {
				L5.Msg.alert('提示',"选中发放记录的实际发放金额必须大于零!");
				return false;
			}
			doleMoney += parseFloat(amount);
		}else {
			L5.Msg.alert('提示',"选中发放记录的实际发放金额必须大于零!");
			return false;
		}
	}
	doleNums = selected.length;

	// 显示资金
	var fundsWin = L5.getCmp("fundsWin");
	fundsWin.show();

	// 加载资金信息
	disFundsBatchSourceDs.setParameter("receiveOrganCode", organCode);
	disFundsBatchSourceDs.setParameter("batchId", batchId);
	disFundsBatchSourceDs.load();

	// 显示发放总金额
	doleDs.getCurrent().set("amount",formatMoneyForDis(doleMoney));
	doleMoney = doleMoney / 10000.00;
	document.getElementById("doleMoney").innerHTML = formatMoneyForDis(doleMoney) + "万元";
	document.getElementById("doleNums").innerHTML = doleNums + "条";
	L5.Msg.hide();
}
// 取消
function onCancel() {
	var fundsWin = L5.getCmp("fundsWin");
	fundsWin.hide();
}
// 保存确认
function onSaveConfirm() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	var panel = L5.getCmp('winGrid');
	var selected = panel.getSelectionModel().getSelections();
	var sums = 0.0;
	for (var i = 0; i < selected.length; i++) {
		var amountPay = selected[i].get("amountPay");
		if (!isNaN(parseFloat(amountPay))) {
			if (parseFloat(amountPay) <= 0.0) {
				L5.Msg.alert('提示', "选中明细的支出金额必须大于零!");
				return false;
			}
			sums = FloatAdd(sums,amountPay);
		} else {
			L5.Msg.alert('提示', "选中明细的支出金额必须大于零!");
			return false;
		}
		if (selected[i].get("ifCarry") == "1") {
			L5.Msg.alert('提示', "拨付资金明细里，选中数据的第" + (i + 1)
							+ "行为结转数据(参看备注)，不能使用，请选择别的记录!");
			return false;
		}
	}
	if (formatMoneyForDis(doleMoney) != formatMoneyForDis(sums)) {
		L5.Msg.alert('提示', "选中明细的支出金额之和必须等于发放金额!");
		return false;
	}

	var yjGrid = L5.getCmp("yjGrid");
	var infoSelected = yjGrid.getSelectionModel().getSelections();
	L5.MessageBox.confirm('确定', '是否确认资金发放?确认后不可修改！', function(state) {
		if (state == "yes") {
			L5.Msg.alert('提示', "OK!");
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
			doleDs.getCurrent().set("inConfirm","1");
			command.setParameter("doleRec", doleDs.getCurrent());// 发放流水
			command.setParameter("infoRecs", infoSelected); // 选择发放的档案信息
			command.setParameter("fundRecs", selected);// 使用资金信息
			command.execute("saveDoleInfo");
			if (!command.error) {
				L5.Msg.alert('提示', "确认成功！", function() {
					ifDetail = "T";
					initDetail();
					onCancel();
				});
			} else {
				L5.Msg.alert('提示', "确认时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
//导出表格
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("infoDs");
	var allocationType = dataset.get("ALLOCATION_TYPE");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/dole/yj/yjExcel.jsp?allocationType="+allocationType);
}
// 打印救助卡
function printCard() {
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
// 渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	if (record.get("ifCarry") == "1")
		return "【已结转】" + value;
	return value;
}