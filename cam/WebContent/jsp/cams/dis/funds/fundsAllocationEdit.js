var tDate = L5.server.getSysDate();
var year = nowYear;
var isInit = false;
var alloGrage="1"; //拨付按钮类型（市级专用）：1为上级，2为本级
function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	disFundsBatchSourceDs.on('load', function() {
				updateFunds();
				var sourceUpWin = L5.getCmp("sourceUpWin");
				if (sourceUpWin.isVisible()) {
					setTimeout(defSelected, 1000);
				}
			});
	
	if(method=="insert") {
		isInit = true;
		batchId = uu32;
		disFundsBatchDs.newRecord({
					"batchId" : batchId,
					"disYear" : year,
					"sourceType" : "0",
					"fillOrganCode" : organCode,
					"fillOrganName" : organName,
					"upAllocationType" : "0",
					"allocationTime" : formatDateToString(tDate),
					"amount" : 0,
					"amountReal" : 0,
					"amountBalance" : 0,
					"amountCentral" : 0,
					"amountDepartment" : 0,
					"amountCity" : 0,
					"amountCounty" : 0,
					"inConfirm" : "0"
				});
		
		var disDirectManageUnitDs = L5.DatasetMgr.lookup("disDirectManageUnitDs");
		disDirectManageUnitDs.setParameter("organCode", organCode);
		disDirectManageUnitDs.setParameter("organType", organType);
		disDirectManageUnitDs.events['load'] = true; 
		disDirectManageUnitDs.on('load',function(){
			var disDirectManageUnitDs = L5.DatasetMgr.lookup("disDirectManageUnitDs");
			var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
			if(disDirectManageUnitDs.getCount() > 0) {
				for(var i=0; i<disDirectManageUnitDs.getCount(); i++) {
					var rec = disDirectManageUnitDs.getAt(i);
					disFundsSourceDs.newRecord({
										"sourceId" : rec.get("SOURCE_ID"),
										"batchId" : batchId,
										"disYear" : year,
										"sourceType" : "0",
										"receiveOrganCode" : rec.get("ID"),
										"receiveOrganName" : rec.get("NAME"),
										"fillOrganCode" : organCode,
										"fillOrganName" : organName,
										"fundsType" : rec.get("FT"),
										"inRef" : "0",
										"inUse" : "9"
									});
				}
			}
			
			onEditBase();
		});
		disDirectManageUnitDs.load();
	}else if(method=="update") {
		disFundsBatchDs.events['load'] = true; 
		disFundsBatchDs.on('load',function(){
			if(disFundsBatchDs.getCount()>0) {
				initGrid(disFundsBatchDs.getAt(0).get("upAllocationType")); //初始化表格
				if(!isInit) {
					loadUseFunds(disFundsBatchDs.getAt(0).get("upAllocationType"));//加载数据
				}
			}
		});
		disFundsBatchDs.setParameter("BATCH_ID", batchId);
		disFundsBatchDs.load();
		disFundsSourceDs.setParameter("BATCH_ID", batchId);
		disFundsSourceDs.load();
		var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
		disAccessoriesDs.setParameter("ITEM_ID", batchId);
		disAccessoriesDs.load();
	
		L5.Msg.hide();
	}else if(method=="confirm") {
		disFundsBatchDs.events['load'] = true; 
		disFundsBatchDs.on('load',function(){
			if(disFundsBatchDs.getCount()>0) {
				initGrid(disFundsBatchDs.getAt(0).get("upAllocationType")); //初始化表格
				if(!isInit) {
					loadUseFunds(disFundsBatchDs.getAt(0).get("upAllocationType"));//加载数据
				}
			}
		});
		disFundsBatchDs.setParameter("BATCH_ID", batchId);
		disFundsBatchDs.load();
		disFundsSourceDs.setParameter("BATCH_ID", batchId);
		disFundsSourceDs.load();
		var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
		disAccessoriesDs.setParameter("ITEM_ID", batchId);
		disAccessoriesDs.load();
		document.getElementById("btnAllo").style.display='none';
		L5.Msg.hide();
	}
	
	if (organType != "11" && organType != "12" && organType != "13" && organType != "14") {
		L5.Msg.alert("提示", "未知等级，不能进入此页面！", function() {
					onCancel();
				});
	}
}
//选中效果
function defSelected() {
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	var winGrid = L5.getCmp("winGrid");
	for(var i=0;i<disFundsBatchSourceDs.getCount();i++) {
		var rec = disFundsBatchSourceDs.getAt(i);
		if(rec.get("amountPay")>0.0) {
			winGrid.getSelectionModel().selectRow(i, true);
		}
	}
	L5.Msg.hide();
}
// 初始化表格
function initGrid(upAllocationType) {
	var allocationAllGrid = L5.getCmp("allocationAllGrid");
	if (upAllocationType == "0") {
		// 财政资金
		allocationAllGrid.getColumnModel().setHidden(9, true);
		if (organType == "11") {
			// 省
		} else if (organType == "12") {
			// 市
			allocationAllGrid.getColumnModel().setHidden(7, false);
		} else if (organType == "13") {
			// 县区市
			allocationAllGrid.getColumnModel().setHidden(5, true);
			allocationAllGrid.getColumnModel().setHidden(6, true);
			allocationAllGrid.getColumnModel().setHidden(7, false);
			allocationAllGrid.getColumnModel().setHidden(8, false);
		}
	} else if (upAllocationType == "1") {
		// 捐赠资金
		allocationAllGrid.getColumnModel().setHidden(5, true);
		allocationAllGrid.getColumnModel().setHidden(6, true);
		allocationAllGrid.getColumnModel().setHidden(7, true);
		allocationAllGrid.getColumnModel().setHidden(8, true);
		allocationAllGrid.getColumnModel().setHidden(9, false);
	}
}
//更新各级资金
function updateFunds() {
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	var upA = 0.0;
	var selfA = 0.0;
	var conA = 0.0;
	for(var i=0;i<disFundsBatchSourceDs.getCount();i++) {
		var rec = disFundsBatchSourceDs.getAt(i);
		if(rec.get("amountPay")>0.0) {
			if(rec.get("sourceType")=="0") {
				upA += parseFloat(rec.get("amountPay"));
			}else if(rec.get("sourceType")=="1") {
				selfA += parseFloat(rec.get("amountPay"));
			}else if(rec.get("sourceType")=="2") {
				conA += parseFloat(rec.get("amountPay"));
			}
		}
	}
	document.getElementById("amountUp").innerHTML = formatMoneyForDis(upA);
	document.getElementById("amountSelf").innerHTML = formatMoneyForDis(selfA);
	document.getElementById("amountCon").innerHTML = formatMoneyForDis(conA);
}
//返回
function onCancel() {
	window.returnValue="T";
	window.close();
}
//编辑基本信息
function onEditBase() {
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.show();
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	if(method=="insert") {
		document.getElementById("btnCancel").style.display='none';
		document.getElementById("btnReturn").style.display='';
	}else {
		document.getElementById("btnCancel").style.display='';
		document.getElementById("btnReturn").style.display = 'none';
		document.getElementById("disYearE").disabled = 'disabled';
		document.getElementById("upAllocationTypeE").disabled = 'disabled';
		var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
		loadUseFunds(disFundsBatchDs.getAt(0).get("upAllocationType"));//修改，每次打开均加载新数据
	}
}
//当拨款类型改变时，加载不同的资金源数据
function onAlloTypeChange(items) {
	if(method=="insert") {
		loadUseFunds(items.value);
	}
}
function loadUseFunds(_alloType) {
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	if (_alloType == "0") {
		disFundsBatchSourceDs.setParameter("receiveOrganCode", organCode);
		disFundsBatchSourceDs.setParameter("batchId", batchId);
		disFundsBatchSourceDs.setParameter("upAllocationType", "0");
	} else if (_alloType == "1") {
		disFundsBatchSourceDs.setParameter("receiveOrganCode", organCode);
		disFundsBatchSourceDs.setParameter("batchId", batchId);
		disFundsBatchSourceDs.setParameter("upAllocationType", "1");
	} else {
		disFundsBatchSourceDs.setParameter("receiveOrganCode", "0");
		disFundsBatchSourceDs.setParameter("batchId", batchId);
	}
	disFundsBatchSourceDs.load();
}
//保存基本信息
function confirmSaveBase(){
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	//校验
	var valid = disFundsBatchDs.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		return false;
	}	
	if(disFundsBatchDs.getCurrent().get("amount")<=0) {
		L5.Msg.alert('提示',"拨付金额不能小于零!");
		return false;
	}
	
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
	if(formatMoneyForDis(disFundsBatchDs.getCurrent().get("amount")) != formatMoneyForDis(sums)) {
		L5.Msg.alert('提示',"拨付金额必须等于选中明细支出金额总和!");
		return false;
	}
	//因计算上级/本级/捐赠，未选中的记录金额清零
	var flag = false;
	for (var i = 0; i < disFundsBatchSourceDs.getCount(); i++) {
		var rec = disFundsBatchSourceDs.getAt(i);
		flag = false;
		for (var j = 0; j < selected.length; j++) {
			if(rec.get("sourceId")==selected[j].get("sourceId")) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			rec.set("amountPay", 0.0);
		}
	}
	
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsBatchCmd");
	command.setParameter("disFundsBatch", disFundsBatchDs.getCurrent());
	command.setParameter("disFundsBatchSource", selected);
	
	if (isInit && method == "insert") {
		command.setParameter("disFundsSource", disFundsSourceDs.getAllRecords());
		command.execute("insertInit");
	}else if(method=="update"){
		command.execute("updateInit");
	}
	if (!command.error) {
		if(isInit && method == "insert") {
			L5.Msg.alert("提示", "基本信息保存成功", function() {
				method = "update";
				var sourceUpWin = L5.getCmp("sourceUpWin");
				sourceUpWin.hide();
				init();
			});
		}else {
			method="update";
			isInit = false;
			var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
			disFundsBatchDs.commitChanges();
			var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
			for(var i=0;i<disFundsSourceDs.getCount(); i++) {
				var rec = disFundsSourceDs.getAt(i);
				rec.set("disYear", disFundsBatchDs.getCurrent().get("disYear"));
				rec.set("upAllocationNum", disFundsBatchDs.getCurrent().get("upAllocationNum"));
				rec.set("upAllocationType", disFundsBatchDs.getCurrent().get("upAllocationType"));
				rec.set("upAllocationPurpose", disFundsBatchDs.getCurrent().get("upAllocationPurpose"));
				rec.set("allocationTime", disFundsBatchDs.getCurrent().get("allocationTime"));
			}
			
			var sourceUpWin = L5.getCmp("sourceUpWin");
			sourceUpWin.hide();
			L5.Msg.alert("提示", "基本信息保存成功");
		}
		updateFunds();
	} else {
		L5.Msg.alert("提示", "基本信息保存失败：" + command.error);
		return false;
	}
}
//取消保存基本信息
function cancelSaveBase(){
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.hide();
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
	disFundsBatchDs.rejectChanges();
}
//保存
function onSave() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	exeCmd(false);
}
//确认
function onConfirm(){
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	saveAfterBack(true);
}

function saveAfterBack(ifBack) {
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var sums = 0.0;
	var centralSums = 0.0;
	var departmentSums = 0.0;
	var citySums = 0.0;
	var countySums = 0.0;
	var donativeSums = 0.0;
	for(var i=0;i<disFundsSourceDs.getCount();i++) {
		var rec = disFundsSourceDs.getAt(i);
		if(!isNaN(parseFloat(rec.get("amount"))))
			sums = FloatAdd(formatMoneyForDis(sums),formatMoneyForDis(rec.get("amount")));
		if(!isNaN(parseFloat(rec.get("amountCentral"))))
			centralSums = FloatAdd(formatMoneyForDis(centralSums),formatMoneyForDis(rec.get("amountCentral")));
		if(!isNaN(parseFloat(rec.get("amountDepartment"))))
			departmentSums = FloatAdd(formatMoneyForDis(departmentSums),formatMoneyForDis(rec.get("amountDepartment")));
		if(!isNaN(parseFloat(rec.get("amountCity"))))
			citySums = FloatAdd(formatMoneyForDis(citySums),formatMoneyForDis(rec.get("amountCity")));
		if(!isNaN(parseFloat(rec.get("amountCounty"))))
			countySums = FloatAdd(formatMoneyForDis(countySums),formatMoneyForDis(rec.get("amountCounty")));
		if(!isNaN(parseFloat(rec.get("amountDonative"))))
			donativeSums = FloatAdd(donativeSums,formatMoneyForDis(rec.get("amountDonative")));
	}
	
	var upA = parseFloat(document.getElementById("amountUp").innerHTML);
	var selfA = parseFloat(document.getElementById("amountSelf").innerHTML);
	var conA = parseFloat(document.getElementById("amountCon").innerHTML);
	if(formatMoneyForDis(sums)!=formatMoneyForDis(disFundsBatchDs.getCurrent().get("amount"))) {
		L5.Msg.alert("提示", "拨款金额与明细支出总和不同！");
		return false;
	}
	if(disFundsBatchDs.getCurrent().get("upAllocationType")=="1") {
		//如果拨款类型为捐赠资金，则只比较捐赠资金
		if(formatMoneyForDis(donativeSums)!=FloatAdd(formatMoneyForDis(upA),FloatAdd(formatMoneyForDis(selfA),formatMoneyForDis(conA)))) {
			L5.Msg.alert("提示", "社会捐赠金额与明细捐赠资金支出总和不同！");
			return false;
		}
	}
	else {
	if(organType=="11") {
		//省，判断上级下拨=中央，本级投入=省
		if(formatMoneyForDis(centralSums)!=formatMoneyForDis(upA)) {
			L5.Msg.alert("提示", "上级下拨金额与明细中央财政支出总和不同！");
			return false;
		}
		if(formatMoneyForDis(departmentSums)!=formatMoneyForDis(selfA)) {
			L5.Msg.alert("提示", "本级投入金额与明细省财政支出总和不同！");
			return false;
		}
	}else if(organType=="12") {
		//市，判断上级下拨=省+中央，本级投入=市
		if(FloatAdd(formatMoneyForDis(centralSums),formatMoneyForDis(departmentSums))!=formatMoneyForDis(upA)) {
			L5.Msg.alert("提示", "上级下拨金额与明细中央财政加省财政支出总和不同！");
			return false;
		}
		if(formatMoneyForDis(citySums)!=formatMoneyForDis(selfA)) {
			L5.Msg.alert("提示", "本级投入金额与明细市财政支出总和不同！");
			return false;
		}
	}else if(organType=="13") {
		//县，判断上级下拨=市，本级投入=县
		if(formatMoneyForDis(citySums)!=formatMoneyForDis(upA)) {
			L5.Msg.alert("提示", "上级下拨金额与明细市财政支出总和不同！");
			return false;
		}
		if(formatMoneyForDis(countySums)!=formatMoneyForDis(selfA)) {
			L5.Msg.alert("提示", "本级投入金额与明细县财政支出总和不同！");
			return false;
		}
	}
	}
	disFundsBatchDs.getCurrent().set("amountReal", sums);
	if (ifBack) {
		//先判断是否满足拨付条件
		var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsBatchCmd");
		cmd.setParameter("batchId", rec.get("batchId"));
		cmd.execute("queryIfUseAllocation");
		var msg = cmd.getReturn("msg");	
		if(msg!=null) {
			L5.Msg.alert('提示', msg);
			return false;
		}
		L5.Msg.confirm("提示", "确认后不能修改/删除，是否确认？", function(isOk) {
					if (isOk == 'yes') {
						disFundsBatchDs.getCurrent().set("inConfirm", "1");
						exeCmd(ifBack);
					}else {
						return false;
					}
				});
	}else {
		exeCmd(ifBack);
	}
}
function exeCmd(ifBack) {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsBatchCmd");
	command.setParameter("disFundsBatch", disFundsBatchDs.getCurrent());
	command.setParameter("disFundsSource", disFundsSourceDs.getAllRecords());
	command.execute("allocation");
	if (!command.error) {
		L5.Msg.alert("提示", "拨付成功", function(){
			if(ifBack) {
				window.returnValue = "T";
				window.close();
			}else {
				var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
				disFundsBatchDs.commitChanges();
				var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
				disFundsSourceDs.commitChanges();
			}
		});
	} else {
		L5.Msg.alert("提示", "拨付失败：" + command.error);
	}
}
//附件管理
function onStuffer(){
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.show();
}
//关闭附件
function onCloseStuffer(){
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.hide();
}
// 增加上传附件
function addUploadFile() {
	var win = L5.getCmp("uploadWin");
	win.show();
}
//上传附件
function click_upload() {
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisAccessoriesCmd");
	command.setParameter("itemId", batchId);
	command.setParameter("note", document.getElementById("fileMess").value);
	command.setForm("form_content");
	command.execute("uploadSave");
	// 包含有大字段的异常判断
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("提示", "上传附件成功!", function() {
						var win = L5.getCmp("uploadWin");
						document.forms["form_content"].reset();
						win.hide();
						var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
						disAccessoriesDs.setParameter("ITEM_ID",batchId);
						disAccessoriesDs.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}
//渲染删除附件
function delUploadFile(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:clickDelete(\''
			+ disAccessoriesDs.indexOf(record) + '\')">' + '删除' + '</a>';
}
//删除附件
function clickDelete(index) {
	var record = disAccessoriesDs.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？', function(sure) {
		if (sure == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisAccessoriesCmd");
			command.setParameter("accessoriesId", record.get("accessoriesId"));
			command.execute("delete");
			if (!command.error) {
				disAccessoriesDs.reload();
				L5.Msg.alert('提示', '删除成功！');
			} else {
				L5.Msg.alert("错误", command.error);
			}
		} else
			return;
	});
}
// 渲染下载
function downloadUploadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ disAccessoriesDs.indexOf(record) + '\')">' + value + '</a>';
}
// 点击下载
function clickDownload(index) {
	var record = disAccessoriesDs.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=DIS_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}
//渲染源资金总额
function amountTotalRenderer(value, cellmeta, record,
		rowindex, colindex,
		dataset) {
	//var totals = record.get("amountCentral")+record.get("amountDepartment")+record.get("amountCity")+record.get("amountCounty");
	var totals = 0.0;
	if(!isNaN(parseFloat(record.get("amountCentral"))))
		totals += parseFloat(record.get("amountCentral"));
	if(!isNaN(parseFloat(record.get("amountDepartment"))))
		totals += parseFloat(record.get("amountDepartment"));
	if(!isNaN(parseFloat(record.get("amountCity"))))
		totals += parseFloat(record.get("amountCity"));
	if(!isNaN(parseFloat(record.get("amountCounty"))))
		totals += parseFloat(record.get("amountCounty"));
	if(!isNaN(parseFloat(record.get("amountDonative"))))
		totals += parseFloat(record.get("amountDonative"));
	record.set("amount", totals);	
	return formatMoneyForDis(value);
}
//渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("ifCarry")=="1")
		return "【已结转】"+value;
	return value;
}
function amountTotalRenderer2(value, cellmeta, record,
		rowindex, colindex,
		dataset) {
	var totals = record.get("amountCentral")+record.get("amountDepartment")+record.get("amountCity")+record.get("amountCounty");		
	record.set("amount", formatMoneyForDis(totals));	
	return formatMoneyForDis(value);
}
