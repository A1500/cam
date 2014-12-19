var NDate = L5.server.getSysDate();
var conFlag = false; //继续标记
function init() {
	
	
	document.getElementById("conBtn").style.display='none';
	if (method == "insert") {
		document.getElementById("familyRegister").value = "1";// 初始化为农村
		familyDs.newRecord();// 初始化界面
		reliefDs.newRecord({
					"acceptDate" :  formatDateToString(NDate)
				});// 初始化界面
		familyDs.set("familyRegister", "1");
		document.getElementById("conBtn").style.display='';
		
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchCommand");
		command.setParameter("batchDetailId", batchDetailId);
		command.execute("getGrantAndAlloction");
		var listInfo=command.getReturn("listInfo");
		var lis=listInfo.split(","); 
		L5.getCmp("reliefInfo").on("activate",function(){
			document.getElementById("grantType").value = lis[1];
			document.getElementById("allocationType").value = lis[0];
			document.getElementById("grantType").disabled="true";
			document.getElementById("allocationType").disabled="true";
			reliefDs.set("grantType",lis[1]);
			reliefDs.set("allocationType",lis[0]);
		});
	} else if (method == "update") {
		reliefDs.setParameter("INFO_ID", cx_infoId);
		familyDs.setParameter("RECORD_ID", cx_recordId);
		reliefDs.load();
		familyDs.load();
		L5.getCmp("reliefInfo").on("activate",function(){
			document.getElementById("grantType").disabled="true";
			document.getElementById("allocationType").disabled="true";
		});
	}
	
	
}
function saveClickContinue(){
	conFlag = true;
	saveClickAfter();
}
function saveClick() {
	conFlag = false;
	saveClickAfter();
}
function saveClickAfter(){
	var familyDs = L5.DatasetMgr.lookup("familyDs");// 家庭信息
	var reliefDs = L5.DatasetMgr.lookup("reliefDs");// 救助信息
	var familyRecord = familyDs.getCurrent();
	var reliefRecord = reliefDs.getCurrent();

	var name = document.getElementById("name").value;
	if (name == "" || name == null) {
		L5.Msg.alert("提示", "户主姓名不能为空！");
		return false;
	}
	var idCard = document.getElementById("idCard");
	if (!checkIDCard(idCard)) {
		L5.Msg.alert("提示", "身份证号码不正确，请重新填写！");
		return false;
	}
	var familyNum = document.getElementById("familyNum").value;
	if (familyNum == "" || familyNum == null) {
		L5.Msg.alert("提示", "家庭人口不能为空！");
		return false;
	}
	if (!/^[1-9][0-9]{0,1}$/.test(familyNum)) {
		L5.Msg.alert("提示", "家庭人口必须为大于0的数字！");
		return false;
	}
	var familyType = document.getElementById("familyType").value;
	if (familyType == null || familyType == "") {
		L5.Msg.alert("提示", "家庭类型不能为空！");
		return false;
	}
	var familyRegister = document.getElementById("familyRegister").value;
	if (familyRegister == null || familyRegister == "") {
		L5.Msg.alert("提示", "户口所在地不能为空！");
		return false;
	}
	var allocationType = reliefDs.get("allocationType");
	if (allocationType == null || allocationType == "") {
		L5.Msg.alert("提示", "资金发放类型不能为空！");
		return false;
	}
	var requiredForFood = reliefDs.get("requiredForFood");
	var requiredForClothes = reliefDs.get("requiredForClothes");
	var requiredForHeat = reliefDs.get("requiredForHeat");
	var requiredForDisease = reliefDs.get("requiredForDisease");
	var requiredForOthers = reliefDs.get("requiredForOthers");
	if (requiredForFood == "" || requiredForFood == null
			|| requiredForFood == 0) {// 5种救助信息不能同时为空
		if (requiredForClothes == "" || requiredForClothes == null
				|| requiredForClothes == 0) {
			if (requiredForHeat == "" || requiredForHeat == null
					|| requiredForHeat == 0) {
				if (requiredForDisease == "" || requiredForDisease == null
						|| requiredForDisease == 0) {
					if (requiredForOthers == "" || requiredForOthers == null
							|| requiredForOthers == 0) {
						L5.Msg.alert("提示", "请填写需救助信息！");
						return false;
					}
				}
			}
		}
	}
	if (requiredForFood == "" || requiredForFood == null) {
		reliefRecord.set("requiredForFood", 0);
		reliefRecord.set("approvalFood", 0);
	}
	if (requiredForClothes == "" || requiredForClothes == null) {
		reliefRecord.set("requiredForClothes", 0);
		reliefRecord.set("approvalClothes", 0);
	}
	if (requiredForHeat == "" || requiredForHeat == null) {
		reliefRecord.set("requiredForHeat", 0);
	}
	if (requiredForDisease == "" || requiredForDisease == null) {
		reliefRecord.set("requiredForDisease", 0);
	}
	if (requiredForOthers == "" || requiredForOthers == null) {
		reliefRecord.set("requiredForOthers", 0);
	}
	if ((requiredForHeat == "" || requiredForHeat == null)
			&& (requiredForDisease == "" || requiredForDisease == null)
			&& (requiredForOthers == "" || requiredForOthers == null)) {
		reliefRecord.set("approvalMonry", 0);
	}
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.AssistanceCommand");
	command.setParameter("familyRecord", familyRecord);
	command.setParameter("reliefRecord", reliefRecord);
	command.setParameter("organCode", organCode);
	command.setParameter("organName", organName);
	command.setParameter("batchDetailId", batchDetailId);
	command.setParameter("method", method);
	if (familyRecord.length < 1 || reliefRecord < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	command.execute("save");
	if (!command.error) {
		L5.Msg.alert('提示', '保存成功！', function() {
					if(conFlag) {
						var tabPanel = L5.getCmp("tabPanel");
						tabPanel.setActiveTab(0);

						familyDs.getCurrent().set("name", "");
						familyDs.getCurrent().set("idCard", "");
						familyDs.getCurrent().set("familyNum", "");
						familyDs.getCurrent().set("familyType", "");
						
						reliefDs.getCurrent().set("requiredForFood", "");
						reliefDs.getCurrent().set("requiredForHeat", "");
						reliefDs.getCurrent().set("requiredForClothes", "");
						reliefDs.getCurrent().set("requiredForDisease", "");
						reliefDs.getCurrent().set("requiredForOthers", "");
						reliefDs.getCurrent().set("approvalFood", "");
						reliefDs.getCurrent().set("approvalClothes", "");
						reliefDs.getCurrent().set("approvalMonry", "");
						reliefDs.getCurrent().set("accountCode", "");
						reliefDs.getCurrent().set("note", "");
					}else {
						window.returnValue = true;
						window.close();
					}
				});
	} else {
		L5.Msg.alert('提示', '保存出现错误！' + command.error);
	}
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/dis/assistance/dic_city/dicCity.jsp?organCode="
							+ organCode + "&organName="
							+ escape(encodeURIComponent(organName))
							+ "&radioType=radiobox&level=4", "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("villiageCode").value = list[0];
		document.getElementById("acceptAreaCode").value = list[0];
		document.getElementById("acceptAreaName").value = list[4];
		familyDs.set("villiageCode", list[0]);
		reliefDs.set("acceptAreaCode", list[0]);
		reliefDs.set("acceptAreaName", list[4]);
	}
}

//自动添加核准救助口粮
function appFood(item) {
	document.getElementById("approvalFood").value = item.value;
	reliefDs.set("approvalFood", item.value);
}
//自动添加核准衣被救助
function appClothes(item) {
	document.getElementById("approvalClothes").value = item.value;
	reliefDs.set("approvalClothes", item.value);
}

//自动添加核准救助金额
function appMon() {
	var requiredForHeat = document.getElementById("requiredForHeat").value;
	var requiredForDisease = document.getElementById("requiredForDisease").value;
	var requiredForOthers = document.getElementById("requiredForOthers").value;
	var res = FloatAdd(requiredForHeat, requiredForDisease);
	var res = FloatAdd(res, requiredForOthers);
	document.getElementById("approvalMonry").value = res;
	reliefDs.set("approvalMonry", res);
}
// 格式化日期
function formatDateToString(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}
