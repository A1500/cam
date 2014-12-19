var sumTotal=0.0; //总金额-部分
function init() {
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	disFundsSourceDs.setParameter("sourceId", sourceId);
	disFundsSourceDs.setParameter("currentSourceId", currentSourceId);
	disFundsSourceDs.setParameter("batchId", batchId);
	disFundsSourceDs.setParameter("inRef", inRef);
	disFundsSourceDs.events['load'] = true;
	disFundsSourceDs.on('load',function(){
		if(disFundsSourceDs.getCount()>0) {
//			alert(disFundsSourceDs.getAt(0).get("meterialExtTotal"))
			document.getElementById("amountExtTotal").innerHTML = formatNum(disFundsSourceDs.getAt(0).get("amountExtTotal"));
			document.getElementById("amountExtReal").value = formatNum(disFundsSourceDs.getAt(0).get("amountExtReal"));
			document.getElementById("amountTotalOld").innerHTML = formatNum(disFundsSourceDs.getAt(0).get("amountExtTotal")+0+disFundsSourceDs.getAt(0).get("meterialExtTotal"));
			document.getElementById("amountTotalNew").innerHTML = formatNum(disFundsSourceDs.getAt(0).get("amountExtReal")+0+disFundsSourceDs.getAt(0).get("meterialExtReal"));
		}
	});
	disFundsSourceDs.load();
	
	var disFundsSourceDetailDs = L5.DatasetMgr.lookup("disFundsSourceDetailDs");
	disFundsSourceDetailDs.setParameter("organType", organType);
	disFundsSourceDetailDs.setParameter("sourceId", sourceId);
	disFundsSourceDetailDs.setParameter("currentSourceId", currentSourceId);
	disFundsSourceDetailDs.setParameter("batchId", batchId);
	disFundsSourceDetailDs.setParameter("fundsType", fundsType);
	disFundsSourceDetailDs.setParameter("actionFundsType", actionFundsType);//actionFundsType：标志拨付款项的等级(仅县级)：市款为2，县款为3
	disFundsSourceDetailDs.setParameter("inRef", inRef);
	disFundsSourceDetailDs.load();
	
	var singleCityGrid = L5.getCmp("singleCityGrid");
	singleCityGrid.on("afteredit",computeSum);//事件:每填写完都自动计算合计
}
//保存
function onSave() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var disFundsSourceDetailDs = L5.DatasetMgr.lookup("disFundsSourceDetailDs");
	
	var isAllZero = true;
	//验证主记录
	var aer = 0.0;
	try{
		aer = parseFloat(document.getElementById("amountExtReal").value);
	}catch(e){}
	
	var at = 0.0;
	try{
		at = parseFloat(document.getElementById("amountExtTotal").innerHTML);
	}catch(e){}
	
	if(aer+0.0>0.0) {
		if(aer+0.0>at) {
			L5.Msg.alert("提示", "拨付资金不能超过原资金金额！");
			return false;
		}
		isAllZero = false;
	}
	//验证明细
	for(var i=0;i<disFundsSourceDetailDs.getCount();i++) {
		var rec = disFundsSourceDetailDs.getAt(i);
		if(isNaN(rec.get("realMeterialAccount")) || isNaN(rec.get("realMeterialNum"))) {
			L5.Msg.alert("提示", "物资明细中第"+(i+1)+"行的数量和总价必须为数字！");
			return false;
		}
		if(rec.get("realMeterialNum")=="") {
			rec.set("realMeterialNum", 0.0);
		}
		if(rec.get("realMeterialAccount")=="") {
			rec.set("realMeterialAccount", 0.0);
		}
		if((rec.get("realMeterialNum")+0.0)==0.0 && (rec.get("realMeterialAccount")+0.0)>0.0){
			L5.Msg.alert("提示", "物资明细中第"+(i+1)+"行的数量为零，总价也必须为零！");
			return false;
		}
		if((rec.get("realMeterialNum")+0.0)>0.0 && (rec.get("realMeterialAccount")+0.0)==0.0){
			L5.Msg.alert("提示", "物资明细中第"+(i+1)+"行的总价为零，数量也必须为零！");
			return false;
		}
		if((rec.get("realMeterialNum")+0.0)>(rec.get("meterialNumBalance")+0.0)) {
			L5.Msg.alert("提示", "物资明细中第"+(i+1)+"行的数量不能大于原数量！");
			return false;
		}
		if((rec.get("realMeterialAccount")+0.0)>(rec.get("meterialAccountBalance")+0.0)) {
			L5.Msg.alert("提示", "物资明细中第"+(i+1)+"行的总价不能大于原总价！");
			return false;
		}
		if((rec.get("realMeterialNum")+0.0)==(rec.get("meterialNumBalance")+0.0)) {
			if((rec.get("realMeterialAccount")+0.0)!=(rec.get("meterialAccountBalance")+0.0)) {
				L5.Msg.alert("提示", "物资明细中第"+(i+1)+"行的数量已为结余，总价必须为总价结余！");
				return false;
			}
		}
		if((rec.get("realMeterialAccount")+0.0)==(rec.get("meterialAccountBalance")+0.0)) {
			if((rec.get("realMeterialNum")+0.0)!=(rec.get("meterialNumBalance")+0.0)) {
				L5.Msg.alert("提示", "物资明细中第"+(i+1)+"行的总价已为结余，数量必须为数量结余！");
				return false;
			}
		}
		if(isAllZero && (rec.get("realMeterialNum")+0.0)>0 &&　(rec.get("realMeterialAccount")+0.0)>0) {
			isAllZero = false;
		}
	}
	
	if(isAllZero) {
		L5.Msg.alert("提示", "没有进行拨付，请仔细核对！");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceBatchCmd");
	command.setParameter("currentSourceId", currentSourceId);
	command.setParameter("batchId", batchId);
	command.setParameter("actionFundsType", actionFundsType);  //标志拨付款项的等级(仅县级)：市款为2，县款为3
	command.setParameter("oldDisFundsSource", disFundsSourceDs.getCurrent());
	command.setParameter("oldDisFundsSourceDetailDs", disFundsSourceDetailDs.getAllRecords());
	command.execute("allocationSingle");
	if (!command.error) {
		L5.Msg.alert("提示", "拨付成功", function(){
			window.returnValue = "T";
			window.close();
		});
	} else {
		L5.Msg.alert("提示", "拨付失败：" + command.error);
	}
}
//返回
function onCancel() {
	window.close();
}

//渲染实际下拨物资数量
function realMeterialAccountRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if((record.get("realMeterialNum")+0.0)==(record.get("realMeterialNumTotal")+0.0)) {
		value = record.get("realMeterialNumTotal");
	}else {
		var meterialUnitprice = record.get("meterialAccount")/record.get("meterialNum");
		value = meterialUnitprice * record.get("realMeterialNum");
		if(value>(record.get("realMeterialAccountTotal")+0.0)) {
			value = record.get("realMeterialAccountTotal");
		}
	}
	record.set("realMeterialAccount", value);
	computeSum();
	value = formatNum(value);
	return value;
}
//计算和值
function computeSumEvent(_id) {
	var aer = 0.0;
	try{
		aer = parseFloat(document.getElementById("amountExtReal").value);
	}catch(e){}
	
	var at = 0.0;
	try{
		at = parseFloat(document.getElementById("amountExtTotal").innerHTML);
	}catch(e){}
	
	if(aer+0.0>0.0) {
		if(aer+0.0>at) {
			L5.Msg.alert("提示", "拨付资金不能超过原资金金额！");
			document.getElementById("amountExtReal").value = "0.00";
			return false;
		}
	}
	
	computeSum();
	checkAssMon(_id);
}
//计算和值
function computeSum() {
	sumTotal = 0.0;
	var disFundsSourceDetailDs = L5.DatasetMgr.lookup("disFundsSourceDetailDs");
	for(var i=0;i<disFundsSourceDetailDs.getCount();i++) {
		var rec = disFundsSourceDetailDs.getAt(i);
		if(!isNaN(rec.get("realMeterialAccount")) && rec.get("realMeterialAccount")!="") {
			sumTotal += (rec.get("realMeterialAccount")+0.0);
		}
	}
	var cd = document.getElementById("amountExtReal").value;
	if(!isNaN(cd) && cd!='') {
		var at = 0;
		try{
			at = parseFloat(cd);
		}catch(e){}
		document.getElementById("amountTotalNew").innerHTML = formatNum(sumTotal+at);
	}else {
		document.getElementById("amountTotalNew").innerHTML = formatNum(sumTotal+"");
	}
}