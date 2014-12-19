var year = nowYear;
var isInit = false;
var alloGrage="1"; //拨付按钮类型（市级专用）：1为上级，2为本级
var isLoadOnly=false;
function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
	disDetailBatchFundsSourceDs.on('load', onLoadDisDetailBatchFundsSourceDs);

	if(method=="insert") {
		var tDate = L5.server.getSysDate();
		isInit = true;
		batchId = uu32;
		disDetailBatchDs.newRecord({
					"batchId" : batchId,
					"disYear" : year,
					"sourceType" : "3",
					"fillOrganCode" : organCode,
					"fillOrganName" : organName,
					"receiveTime" : formatDateToString(tDate),
					"amount" : 0,
					"inConfirm" : "0"
				});
		disDetailSourceDs.newRecord({
					"detailId" : uu32De,
					"batchId" : batchId,
					"fillOrganCode" : organCode,
					"fillOrganName" : organName,
					"allocationStatus" : "0",
					"inUse" : "9"
				});
		onEditBase();
	}else if(method=="update") {
		disDetailBatchDs.events['load'] = true; 
		disDetailBatchDs.on('load',function(){
			if(disDetailBatchDs.getCount()>0) {
				if(!isLoadOnly) {
					var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
					disDetailBatchFundsSourceDs.setParameter("receiveOrganCode", organCode);
					disDetailBatchFundsSourceDs.setParameter("batchId", batchId);
					disDetailBatchFundsSourceDs.load();
					isLoadOnly=true;
				}
			}
		});
		disDetailBatchDs.setParameter("BATCH_ID", batchId);
		disDetailBatchDs.load();		
		disDetailSourceDs.setParameter("BATCH_ID", batchId);
		disDetailSourceDs.load();		
		disDetailBatchSourceDs.setParameter("batchId", batchId);
		disDetailBatchSourceDs.load();		
		var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
		disAccessoriesDs.setParameter("ITEM_ID", batchId);
		disAccessoriesDs.load();
	
		L5.Msg.hide();
	}else if(method=="confirm") {
		disDetailBatchDs.events['load'] = true; 
		disDetailBatchDs.on('load',function(){
			if(disDetailBatchDs.getCount()>0) {
				if(!isLoadOnly) {
					var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
					disDetailBatchFundsSourceDs.setParameter("receiveOrganCode", organCode);
					disDetailBatchFundsSourceDs.setParameter("batchId", batchId);
					disDetailBatchFundsSourceDs.load();
					isLoadOnly=true;
				}
			}
		});
		disDetailBatchDs.setParameter("BATCH_ID", batchId);
		disDetailBatchDs.load();		
		disDetailSourceDs.setParameter("BATCH_ID", batchId);
		disDetailSourceDs.load();		
		disDetailBatchSourceDs.setParameter("batchId", batchId);
		disDetailBatchSourceDs.load();		
		var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
		disAccessoriesDs.setParameter("ITEM_ID", batchId);
		disAccessoriesDs.load();
		document.getElementById("btnAllo").style.display='none';
		L5.Msg.hide();
	}
	
	if(organType!="11" && organType!="12" && organType!="13" && organType!="14") {
		L5.Msg.alert("提示", "未知等级，不能进入此页面！", function(){
			onCancel();
		});
	}
}
// 加载使用资金后出发
function onLoadDisDetailBatchFundsSourceDs() {
	updateFunds();
	var sourceUpWin = L5.getCmp("sourceUpWin");
	if (sourceUpWin.isVisible()) {
		setTimeout(defSelected, 1000);
	}
}
// 选中效果
function defSelected() {
	var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
	var winGrid = L5.getCmp("winGrid");
	for(var i=0;i<disDetailBatchFundsSourceDs.getCount();i++) {
		var rec = disDetailBatchFundsSourceDs.getAt(i);
		if(rec.get("amountPay")>0.0) {
			winGrid.getSelectionModel().selectRow(i, true);
		}
	}
	L5.Msg.hide();
}
//更新各级资金
function updateFunds() {
	var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
	var upA = 0.0;
	var selfA = 0.0;
	var conA = 0.0;
	for (var i = 0; i < disDetailBatchFundsSourceDs.getCount(); i++) {
		var rec = disDetailBatchFundsSourceDs.getAt(i);
		if (rec.get("amountPay") > 0.0) {
			if (rec.get("sourceType") == "0") {
				upA += parseFloat(rec.get("amountPay"));
			} else if (rec.get("sourceType") == "1") {
				selfA += parseFloat(rec.get("amountPay"));
			} else if (rec.get("sourceType") == "2") {
				conA += parseFloat(rec.get("amountPay"));
			}
		}
	}
	document.getElementById("amountUp").innerHTML = upA;
	document.getElementById("amountSelf").innerHTML = selfA;
	document.getElementById("amountCon").innerHTML = conA;
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
		document.getElementById("btnReturn").style.display='none';
	}
	
	var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
	disDetailBatchFundsSourceDs.setParameter("receiveOrganCode", organCode);
	disDetailBatchFundsSourceDs.setParameter("batchId", batchId);
	disDetailBatchFundsSourceDs.load();
}
//保存基本信息
function confirmSaveBase(){
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
	//校验
	var disDetailBatchRec = disDetailBatchDs.getCurrent();
	if(disDetailBatchRec.get("disYear") == ""){
		L5.Msg.alert('提示',"年度不能为空！");
		return false;
	}
	if(disDetailBatchRec.get("upAllocationType") == ""){
		L5.Msg.alert('提示',"采购方式不能为空！");
		return false;
	}
	if(disDetailBatchRec.get("receiveTime") == ""){
		L5.Msg.alert('提示',"采购日期不能为空！");
		return false;
	}
	if(disDetailBatchRec.get("amount") == ""){
		L5.Msg.alert('提示',"采购金额不能为空！");
		return false;
	}
	if(disDetailBatchDs.getCurrent().get("amount")<=0) {
		L5.Msg.alert('提示',"采购金额不能小于零!");
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
		}
		if(selected[i].get("ifCarry")=="1") {
			L5.Msg.alert('提示',"资金来源明细里，选中数据的第"+(i+1)+"行为结转数据(参看备注)，不能使用，请选择别的记录!");
			return false;
		}
	}
	if(disDetailBatchDs.getCurrent().get("amount") != sums) {
		L5.Msg.alert('提示',"采购金额必须等于选中明细支出金额总和!");
		return false;
	}
	
	//因计算上级/本级/捐赠，未选中的记录金额清零
	var flag = false;
	for (var i = 0; i < disDetailBatchFundsSourceDs.getCount(); i++) {
		var rec = disDetailBatchFundsSourceDs.getAt(i);
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
	
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisDetailBatchCmd");
	command.setParameter("disDetailBatch", disDetailBatchDs.getCurrent());
	command.setParameter("disDetailSource", disDetailSourceDs.getCurrent());
	command.setParameter("disDetailBatchSource", selected);
	if (isInit && method == "insert") {
		command.execute("insertSwapInit");
	}else if(method=="update"){
		command.execute("updateSwapInit");
	}
	if (!command.error) {
		if(isInit && method == "insert") {
			L5.Msg.alert("提示", "基本信息保存成功", function() {
				method="update";
				var sourceUpWin = L5.getCmp("sourceUpWin");
				sourceUpWin.hide();
				init();
			});
		}else {
			method="update";
			isInit = false;
			var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
			disDetailBatchDs.commitChanges();
			var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
			for(var i=0;i<disDetailBatchSourceDs.getCount(); i++) {
				var rec = disDetailBatchSourceDs.getAt(i);
				rec.set("disYear", disDetailBatchDs.getCurrent().get("disYear"));
				rec.set("upAllocationNum", disDetailBatchDs.getCurrent().get("upAllocationNum"));
				rec.set("upAllocationType", disDetailBatchDs.getCurrent().get("upAllocationType"));
				rec.set("upAllocationPurpose", disDetailBatchDs.getCurrent().get("upAllocationPurpose"));
				rec.set("allocationTime", disDetailBatchDs.getCurrent().get("receiveTime"));
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
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	disDetailBatchDs.rejectChanges();
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
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	var sums = 0.0;
	if(disDetailBatchSourceDs.getCount()==0) {
		L5.Msg.alert("提示", "请录入采购物资！");
		return false;
	}
	for(var i=0;i<disDetailBatchSourceDs.getCount();i++) {
		var rec = disDetailBatchSourceDs.getAt(i);
		if(rec.get("meterialType")=="") {
			L5.Msg.alert("提示", "采购物资明细中第"+(i+1)+"条必须选择物资类型！");
			return false;
		}
		if(isNaN(parseFloat(rec.get("meterialNum"))) || isNaN(parseFloat(rec.get("meterialAccount")))) {
			L5.Msg.alert("提示", "采购物资明细中第"+(i+1)+"条存在非整数的物资数量和物资金额合计！");
			return false;
		}
		if(isNaN(parseFloat(rec.get("meterialNum"))) && parseFloat(rec.get("meterialNum"))>0.0) {
			L5.Msg.alert("提示", "采购物资明细中第"+(i+1)+"条物资数量必须大于零！");
			return false;
		}
		if(isNaN(parseFloat(rec.get("meterialAccount"))) && parseFloat(rec.get("meterialAccount"))>0.0) {
			L5.Msg.alert("提示", "采购物资明细中第"+(i+1)+"条物资金额合计必须大于零！");
			return false;
		}
		if(!isNaN(parseFloat(rec.get("meterialAccount"))))
			sums += rec.get("meterialAccount");
	}
	if(sums!=disDetailBatchDs.getCurrent().get("amount")) {
		L5.Msg.alert("提示", "采购金额与采购物资明细总和不同！");
		return false;
	}
	
	disDetailSourceDs.getCurrent().set("meterialAccount", sums);
	if (ifBack) {
		//先判断是否满足采购条件
		L5.Msg.confirm("提示", "确认后不能修改/删除，是否确认？", function(isOk) {
					if (isOk == 'yes') {
						disDetailBatchDs.getCurrent().set("inConfirm", "1");
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
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisDetailBatchCmd");
	command.setParameter("disDetailBatch", disDetailBatchDs.getCurrent());
	command.setParameter("disDetailSource", disDetailSourceDs.getCurrent());
	command.setParameter("disDetailBatchSource", disDetailBatchSourceDs.getAllChangedRecords());
	command.execute("goodswap");
	if (!command.error) {
		L5.Msg.alert("提示", "采购成功", function(){
			if(ifBack) {
				window.returnValue = "T";
				window.close();
			}else {
				var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
				disDetailBatchDs.commitChanges();
				var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
				disDetailBatchSourceDs.commitChanges();
			}
		});
	} else {
		L5.Msg.alert("提示", "采购失败：" + command.error);
	}
}
//增加明细
function addDetails() {
	var command = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var newId = command.getReturn("id");
		
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	disDetailBatchSourceDs.newRecord({
				"recordId" : newId,
				"batchId" : disDetailBatchDs.getCurrent().get("batchId"),
				"detailId" : disDetailSourceDs.getCurrent().get("detailId"),
//				"disYear" : disDetailBatchDs.getCurrent().get("disYear"),
//				"allocationType" : "3",
//				"upAllocationNum" : disDetailBatchDs.getCurrent().get("upAllocationNum"),
//				"upAllocationType" : disDetailBatchDs.getCurrent().get("upAllocationType"),
//				"upAllocationPurpose" : disDetailBatchDs.getCurrent().get("upAllocationPurpose"),
//				"meterialNum" : 0,
//				"meterialAccount" : 0,
//				"fundsType" : fundsType,
//				"inUse" : "0"
				"allocationTime" : disDetailBatchDs.getCurrent().get("receiveTime")
			});
}
//删除明细
function removeDetails() {
	var editGrid = L5.getCmp("allocationAllGrid");
	var selections = editGrid.getSelectionModel().getSelections();
	if(selections.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录");
		return;
	}
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	disDetailBatchSourceDs.remove(disDetailBatchSourceDs.getCurrent());
}
//渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("ifCarry")=="1")
		return "【已结转】"+value;
	return value;
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