var NDate = L5.server.getSysDate();
var conFlag = false; //继续标记
function init() {
	document.getElementById("conBtn").style.display='none';
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
//		ds.newRecord({"reliefType":"GD"});
		// document.getElementById("reliefType").value="GD";
		infoDs.newRecord({
					"reliefType" : "GD",
					"batchDetailId" : batchDetailId,
					"acceptDate" :  formatDateToString(NDate)
				});
		document.getElementById("conBtn").style.display='';
		
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchCommand");
		command.setParameter("batchDetailId", batchDetailId);
		command.execute("getGrantAndAlloction");
		var listInfo=command.getReturn("listInfo");
		var lis=listInfo.split(","); 
		document.getElementById("grantType").value = lis[1];
		document.getElementById("allocationType").value = lis[0];
		document.getElementById("grantType").disabled="true";
		document.getElementById("allocationType").disabled="true";
		reliefDs.set("grantType",lis[1]);
		reliefDs.set("allocationType",lis[0]);
	}else if (method=="UPDATE"){
		infoDs.baseParams["INFO_ID@="]=infoId;
		infoDs.load();
		
		document.getElementById("grantType").disabled="true";
		document.getElementById("allocationType").disabled="true";
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}
function saveClickContinue(){
	conFlag = true;
	saveClickAfter();
}
function save() {
	conFlag = false;
	saveClickAfter();
}
function saveClickAfter(){
	var infoRecords = infoDs.getAllChangedRecords();
	if(infoRecords.length < 1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验
	var infoValid = infoDs.isValidate();
	if(infoValid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+infoValid);
		return false;
	}
	var infoRecord = infoDs.getCurrent();
	var requiredForFood = infoRecord.get("requiredForFood");
	var requiredForClothes = infoRecord.get("requiredForClothes");
	var requiredForHeat = infoRecord.get("requiredForHeat");
	var requiredForDisease = infoRecord.get("requiredForDisease");
	var requiredForOthers = infoRecord.get("requiredForOthers");
	
	if(requiredForFood == "" && requiredForClothes == "" && requiredForHeat == "" && requiredForDisease == "" &&requiredForOthers == "") {
		L5.Msg.alert("提示", "必须填写一个");
		return;
	}
	
	
	if(requiredForFood == "" ) {
		infoRecord.set("requiredForFood", 0);
	} 
	
	if(requiredForClothes == "") {
		infoRecord.set("requiredForClothes", 0);
	} 
	
	if(requiredForHeat == "") {
		infoRecord.set("requiredForHeat", 0);
	} 
	
	if(requiredForDisease == "") {
		infoRecord.set("requiredForDisease", 0);
	} 
	
	if(requiredForOthers == "") {
		infoRecord.set("requiredForOthers", 0);
	} 
	
	var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCommand"); 
	
	command.setParameter("infoRecord",infoRecord);
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功!", function() {
				if(conFlag) {
					infoDs.getCurrent().set("requiredForFood", "");
					infoDs.getCurrent().set("requiredForClothes", "");
					infoDs.getCurrent().set("requiredForHeat", "");
					infoDs.getCurrent().set("requiredForDisease", "");
					infoDs.getCurrent().set("requiredForOthers", "");
					infoDs.getCurrent().set("approvalFamilyNum", "");
					infoDs.getCurrent().set("approvalFood", "");
					infoDs.getCurrent().set("approvalClothes", "");
					infoDs.getCurrent().set("approvalMonry", "");
					
					infoDs.getCurrent().set("acceptAreaName", "");
					infoDs.getCurrent().set("acceptAreaCode", "");
					infoDs.getCurrent().set("acceptPeopleName", "");
					infoDs.getCurrent().set("note", "");
				}else {
					window.returnValue = true;
					window.close();
				}
			});
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	if(method == "INSERT") {
		command.execute("save");
	} else if(method == "UPDATE") {
		command.execute("update");
	}
}
//时间
function getTimes(item) {
	LoushangDate(item.previousSibling);
}
//手动输入时间格式 
var temp1 = -1;
function changeDateStyle(obj) {
	var temp = obj.value;
	var arr = temp.split("-");
	if (temp1<obj.value.length) {
		if(temp!=""&&temp.length == 4) {
			obj.value = temp + '-';
		} else if (obj.value.length == 8 && obj.value.split("-").length == 2) {
			obj.value = obj.value.substr(0,7)+'-'+ obj.value.substr(7,1);
		} else if (temp!=""&&temp.length==7) {
			obj.value = temp + '-';
		} else if (obj.value.length == 5 && obj.value.indexOf("-") == -1) {
			obj.value = obj.value.substr(0,4)+'-'+ obj.value.substr(4,1);
		} 
	} 
	temp1 = obj.value.length;
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect(name, code) {
	var revalue = window.showModalDialog(
			L5.webPath+"/jsp/cams/dis/assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById(code).value = list[0];
		document.getElementById(name).value = list[4];
		infoDs.set(name, list[4]);
		infoDs.set(code, list[0]);
	}
}

 function back()
 {	 	var url='jsp/cams/dis/assistance/gd_info/gd_info_list.jsp';
		var text = '救灾明细列表';
		L5.forward(url,text);	 
 }

function formatDateToString(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}
//自动添加核准救助口粮
function appFood(item) {
	document.getElementById("approvalFood").value = item.value;
	infoDs.set("approvalFood", item.value);
}
//自动添加核准衣被救助
function appClothes(item) {
	document.getElementById("approvalClothes").value = item.value;
	infoDs.set("approvalClothes", item.value);
}

//自动添加核准救助金额
function appMon() {
	var requiredForHeat = document.getElementById("requiredForHeat").value;
	var requiredForDisease = document.getElementById("requiredForDisease").value;
	var requiredForOthers = document.getElementById("requiredForOthers").value;
	var res = FloatAdd(requiredForHeat, requiredForDisease);
	res = FloatAdd(res, requiredForOthers);
	document.getElementById("approvalMonry").value = res;
	infoDs.set("approvalMonry", res);
}