var sumTotal=0.0; //总金额
function init() {
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	disFundsSourceDs.setParameter("SOURCE_ID", sourceId);
	disFundsSourceDs.on('load',function(){
		if(disFundsSourceDs.getCount()>0) {
			document.getElementById("amountLbl").innerHTML = formatNum(disFundsSourceDs.getAt(0).get("amount"));
		}
	});
	disFundsSourceDs.load();
	
	var disFundsSourceCentralDs = L5.DatasetMgr.lookup("disFundsSourceCentralDs");
	disFundsSourceCentralDs.setParameter("receiveOrganCode", organCode);
	disFundsSourceCentralDs.setParameter("sourceId", sourceId);
	disFundsSourceCentralDs.setParameter("fundsType", "0");
	disFundsSourceCentralDs.setParameter("sourceType", "0");
	disFundsSourceCentralDs.load();
	
	var disFundsSourceDepartmentDs = L5.DatasetMgr.lookup("disFundsSourceDepartmentDs");
	disFundsSourceDepartmentDs.setParameter("receiveOrganCode", organCode);
	disFundsSourceDepartmentDs.setParameter("sourceId", sourceId);
	disFundsSourceDepartmentDs.setParameter("fundsType", "1");
	disFundsSourceDepartmentDs.setParameter("sourceType", "1,2");
	disFundsSourceDepartmentDs.load();
	
	var centralGrid = L5.getCmp("centralGrid");
	centralGrid.on("afteredit",computeSum);//事件:每填写完都自动计算合计
	var departmentGrid = L5.getCmp("departmentGrid");
	departmentGrid.on("afteredit",computeSum);//事件:每填写完都自动计算合计
}
//保存
function onSave() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var disFundsSourceCentralDs = L5.DatasetMgr.lookup("disFundsSourceCentralDs");
	var disFundsSourceDepartmentDs = L5.DatasetMgr.lookup("disFundsSourceDepartmentDs");
	
	var isAllZero = true;
	for(var i=0;i<disFundsSourceCentralDs.getCount();i++) {
		var rec = disFundsSourceCentralDs.getAt(i);
		if(isNaN(rec.get("amountExtReal"))) {
			L5.Msg.alert("提示", "中央级拨款资金明细中第"+(i+1)+"行必须为数字！");
			return false;
		}else if(rec.get("amountExtReal")=="") {
			rec.set("amountExtReal", 0.0);
		}else if((rec.get("amountExtReal")+0.0)>(rec.get("amountExtTotal")+0.0)) {
			L5.Msg.alert("提示", "中央级拨款资金明细中第"+(i+1)+"行的值不能大于原结余！");
			return false;
		}
		if(isAllZero && (rec.get("amountExtReal")+0.0)>0) {
			isAllZero = false;
		}
	}
	for(var i=0;i<disFundsSourceDepartmentDs.getCount();i++) {
		var rec = disFundsSourceDepartmentDs.getAt(i);
		if(isNaN(rec.get("amountExtReal"))) {
			L5.Msg.alert("提示", "省级拨款资金明细中第"+(i+1)+"行必须为数字！");
			return false;
		}else if(rec.get("amountExtReal")=="") {
			rec.set("amountExtReal", 0.0);
		}else if((rec.get("amountExtReal")+0.0)>(rec.get("amountExtTotal")+0.0)) {
			L5.Msg.alert("提示", "省级拨款资金明细中第"+(i+1)+"行的值不能大于原结余！");
			return false;
		}
		if(isAllZero && (rec.get("amountExtReal")+0.0)>0) {
			isAllZero = false;
		}
	}
	if(isAllZero) {
		L5.Msg.alert("提示", "没有进行拨付，请仔细核对！");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceBatchCmd");
	command.setParameter("disFundsSource", disFundsSourceDs.getCurrent());
	command.setParameter("disFundsSourceOfCentrals", disFundsSourceCentralDs.getAllRecords());
	command.setParameter("disFundsSourceOfDepartments", disFundsSourceDepartmentDs.getAllRecords());
	command.execute("allocation");
	if (!command.error) {
		L5.Msg.alert("提示", "拨付成功");
		window.returnValue = "T";
		window.close();
	} else {
		L5.Msg.alert("提示", "拨付失败：" + command.error);
	}
}
//返回
function onCancel() {
	window.close();
}
//计算和值
function computeSum() {
	sumTotal = 0.0;
	var disFundsSourceCentralDs = L5.DatasetMgr.lookup("disFundsSourceCentralDs");
	var disFundsSourceDepartmentDs = L5.DatasetMgr.lookup("disFundsSourceDepartmentDs");
	for(var i=0;i<disFundsSourceCentralDs.getCount();i++) {
		var rec = disFundsSourceCentralDs.getAt(i);
		if(!isNaN(rec.get("amountExtReal")) && rec.get("amountExtReal")!="") {
			sumTotal += (rec.get("amountExtReal")+0.0);
		}
	}
	for(var i=0;i<disFundsSourceDepartmentDs.getCount();i++) {
		var rec = disFundsSourceDepartmentDs.getAt(i);
		if(!isNaN(rec.get("amountExtReal")) && rec.get("amountExtReal")!="") {
			sumTotal += (rec.get("amountExtReal")+0.0);
		}
	}
	document.getElementById("amountLbl").innerHTML = formatNum(sumTotal+"");
}