var NDate = L5.server.getSysDate();
var conFlag = false; // 保存后是否继续标记
var tempOrganCode=organCode; //用于显示树
var tempOrganName=organName;

function init() {
	batchDetailDs.on('load', function() {
		if (batchDetailDs.getCount() > 0) {
			if (batchDetailDs.getAt(0).get("requiredOrganCode") != tempOrganCode) {
				tempOrganCode = batchDetailDs.getAt(0).get("requiredOrganCode");
				tempOrganName = batchDetailDs.getAt(0).get("requiredOrganName");
			}
		}
	});
	batchDetailDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
	batchDetailDs.load();
	
	if (method == "insert") {
		batchDs.on('load', function() {
					if (batchDs.getCount() > 0) {
						infoDs.newRecord({
									"batchDetailId" : batchDetailId,
									"batchId" : batchId,
									"reliefType" : batchDs.getAt(0).get("reliefType"),
									"fillType" : "0",
									"acceptDate" : formatDateToString(NDate),
									"grantType" : batchDs.getAt(0).get("grantType"),
									"allocationType" : batchDs.getAt(0).get("allocationType"),
									"familyType" : "3",
									"organCode" : organCode,
									"organName" : organName,
									"familyRegister" : "1"
								});
						hideYh(batchDs.getAt(0).get("allocationType"));
					}
				});
		batchDs.setParameter("BATCH_ID", batchId);
		batchDs.load();
	} else if (method == "update") {
		infoDs.on('load', function() {
			if(infoDs.getCount()>0) {
				hideYh(infoDs.getAt(0).get("allocationType"));
			}
		});
		infoDs.setParameter("INFO_ID", infoId);
		infoDs.load();
		document.getElementById("conBtn").style.display = 'none';
	}
}
// 隐藏银行信息
function hideYh(at) {
	if (at == "0") {
		document.getElementById("yhTr").style.display = 'none';
		document.getElementById("yhTr2").style.display = 'none';
	}
}
function saveClickContinue() {
	conFlag = true;
	saveClickAfter();
}
function saveClick() {
	conFlag = false;
	saveClickAfter();
}
function saveClickAfter() {
	//非空校验
	var valid = infoDs.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		return false;
	}	
	
	//值校验
	if(!(checkCusFloat(infoDs.getCurrent().get("approvalFood")))) {
		L5.Msg.alert('提示',"核准救助口粮必须为数字（支持到小数点后1位）！");
		return false;
	}
	if(!(checkInteger(infoDs.getCurrent().get("approvalClothes")))) {
		L5.Msg.alert('提示',"核准救助衣被必须为整数！");
		return false;
	}
	if(!(checkInteger(infoDs.getCurrent().get("approvalMoney")))) {
		L5.Msg.alert('提示',"核准救助金额必须为整数！");
		return false;
	}
	
	if(infoDs.getCurrent().get("allocationType")=="1") {
		if(infoDs.getCurrent().get("bank")=="") {
			L5.Msg.alert('提示',"开户银行不能为空!");
			return false;
		}
		if(infoDs.getCurrent().get("accountCode")=="") {
			L5.Msg.alert('提示',"开户银行帐号不能为空!");
			return false;
		}
	}
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCmd");
	command.setParameter("record", infoDs.getCurrent());
	if (method == "insert")
		command.execute("insertInfo");
	else if (method == "update")
		command.execute("updateInfo");
		
	if (!command.error) {
		L5.Msg.alert('提示', '保存成功！', function() {
					if (conFlag) {
						infoDs.getCurrent().set("name", "");
						infoDs.getCurrent().set("idCard", "");
						infoDs.getCurrent().set("familyNum", "");
						infoDs.getCurrent().set("familyType", "");
						infoDs.getCurrent().set("requiredForFood", "");
						infoDs.getCurrent().set("requiredForHeat", "");
						infoDs.getCurrent().set("requiredForClothes", "");
						infoDs.getCurrent().set("requiredForDisease", "");
						infoDs.getCurrent().set("requiredForWater", "");
						infoDs.getCurrent().set("requiredForOthers", "");
						infoDs.getCurrent().set("approvalTimes", "");
						infoDs.getCurrent().set("approvalFood", "");
						infoDs.getCurrent().set("approvalClothes", "");
						infoDs.getCurrent().set("approvalMoney", "");
						infoDs.getCurrent().set("accountCode", "");
						infoDs.getCurrent().set("note", "");
						
						infoDs.getCurrent().set("fillType", "0");
						infoDs.getCurrent().set("familyType", "3");
					} else {
						window.returnValue = true;
						window.close();
					}
				});
	} else {
		L5.Msg.alert('提示', '保存出现错误！' + command.error);
	}
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + tempOrganCode
					+ "&organName=" + escape(encodeURIComponent(tempOrganName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("acceptAreaCode").value = list[0];
		document.getElementById("acceptAreaName").value = list[4];
		infoDs.set("acceptAreaCode", list[0]);
		infoDs.set("acceptAreaName", list[4]);
	}
}
// 自动添加核准救助口粮
function appFood(item) {
	document.getElementById("approvalFood").value = item.value;
	infoDs.set("approvalFood", item.value);
}
// 自动添加核准衣被救助
function appClothes(item) {
	document.getElementById("approvalClothes").value = item.value;
	infoDs.set("approvalClothes", item.value);
}

// 自动添加核准救助金额
function appMon() {
	var requiredForHeat = getParamCustom("requiredForHeat");
	var requiredForDisease = getParamCustom("requiredForDisease");
	var requiredForWater = getParamCustom("requiredForWater");
	var requiredForOthers = getParamCustom("requiredForOthers");
	var res = FloatAdd(requiredForHeat, requiredForDisease);
	res = FloatAdd(res, requiredForWater);
	res = FloatAdd(res, requiredForOthers);
	document.getElementById("approvalMoney").value = res;
	infoDs.set("approvalMoney", res);
}
function getParamCustom(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = 0.0; //方便计算，返回0
	return value;
}