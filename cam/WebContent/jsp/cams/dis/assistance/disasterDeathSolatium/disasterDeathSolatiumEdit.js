var NDate = L5.server.getSysDate();

function init(){
	
	
	if(method=="insert"){
		familyDs.newRecord();// 初始化界面
		reliefDs.newRecord({
					"acceptDate" : formatDateToString(NDate)
				});//初始化界面
		document.getElementById("familyRegister").value="1";//初始化为农村
		familyDs.set("familyRegister","1");
		L5.getCmp("reliefInfo").on("activate",func);//当reliefInfo页活动时调用func方法
		
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
	}else if(method=="update"){
		reliefDs.setParameter("INFO_ID",cx_infoId);
		familyDs.setParameter("RECORD_ID",cx_recordId);
		reliefDs.load();
		familyDs.load();
		L5.getCmp("reliefInfo").on("activate",function(){
			document.getElementById("grantType").disabled="true";
			document.getElementById("allocationType").disabled="true";
		});
	}
};
/**
 * 初始化非首tab页
 */
function func(){
	document.getElementById("deadFolk").value="01";//初始化为汉族
	reliefDs.set("deadFolk","01");
	document.getElementById("deadSex").value="1";//初始化为男
	reliefDs.set("deadSex","1");
}
/**
 * 保存按钮
 */
function saveClick(){
	var familyDs = L5.DatasetMgr.lookup("familyDs");//家庭信息
	var reliefDs = L5.DatasetMgr.lookup("reliefDs");//救助信息
	var familyRecord = familyDs.getCurrent();
	var reliefRecord = reliefDs.getCurrent();
	
	var name = document.getElementById("name").value;
	if(name==""||name==null){
		L5.Msg.alert("提示","户主姓名不能为空！");
		return false;
	}
	var idCard = document.getElementById("idCard").value;
	if(!checkIDCard(document.getElementById("idCard"))){
		L5.Msg.alert("提示","身份证号码不正确，请重新填写！");
		return false;
	}
	var familyNum = document.getElementById("familyNum").value;
	if(familyNum==""||familyNum==null){
		L5.Msg.alert("提示","家庭人口不能为空！");
		return false;
	}
	if(!/^[1-9][0-9]{0,1}$/.test(familyNum)){
		L5.Msg.alert("提示","家庭人口必须为大于0的数字！");
		return false;
	}
	var familyType = document.getElementById("familyType").value;
	if(familyType==null||familyType==""){
		L5.Msg.alert("提示","家庭类型不能为空！");
		return false;
	}
	var familyRegister = document.getElementById("familyRegister").value;
	if(familyRegister==null||familyRegister==""){
		L5.Msg.alert("提示","户口所在地不能为空！");
		return false;
	}
	var deadName = reliefDs.get("deadName");
	if(deadName==null||deadName==""){
		L5.Msg.alert("提示","死者姓名不能为空！");
		return false;
	}
	var deadSex = reliefDs.get("deadSex");
	if(deadSex==""||deadSex==null){
		L5.Msg.alert("提示","死者性别不能为空！");
		return false;
	}
	var deadAge = reliefDs.get("deadAge");
	if(deadAge==""||deadAge==null){
		L5.Msg.alert("提示","死者年龄不能为空！");
		return false;
	}
	if(!/^(([1-9][0-9]*)|0)$/.test(deadAge)){
		L5.Msg.alert("提示","死者年龄必须为数字！");
		return false;
	}
	var deadFolk = reliefDs.get("deadFolk");
	if(deadFolk==""||deadFolk==null){
		L5.Msg.alert("提示","死者民族不能为空！");
		return false;
	}
	var deadPopulace = reliefDs.get("deadPopulace");
	if(deadPopulace==""||deadPopulace==null){
		L5.Msg.alert("提示","死者户口所在地不能为空！");
		return false;
	}
	var deadMissingTime = reliefDs.get("deadMissingTime");
	if(deadMissingTime==""||deadMissingTime==null){
		L5.Msg.alert("提示","死亡（失踪）时间不能为空！");
		return false;
	}
	var deadMissingPlace = reliefDs.get("deadMissingPlace");
	if(deadMissingPlace==""||deadMissingPlace==null){
		L5.Msg.alert("提示","死亡（失踪）地点不能为空！");
		return false;
	}
	var deadMissingReason = reliefDs.get("deadMissingReason");
	if(deadMissingReason==""||deadMissingReason==null){
		L5.Msg.alert("提示","死亡（失踪）原因不能为空！");
		return false;
	}
	var disasterType = reliefDs.get("disasterType");
	if(disasterType==""||disasterType==null){
		L5.Msg.alert("提示","灾害种类不能为空！");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.AssistanceCommand");
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("reliefRecord",reliefRecord);
	command.setParameter("organCode", organCode);
	command.setParameter("organName", organName);
	command.setParameter("batchDetailId", batchDetailId);
	command.setParameter("method",method);
	if(familyRecord.length<1||reliefRecord<1){
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	command.execute("save");
	if(!command.error){
		familyDs.commitChanges();
		reliefDs.commitChanges();
		L5.Msg.alert('提示','保存成功！',function(){
			window.returnValue = true;
			window.close();
		});
	}else{
		L5.Msg.alert('提示','保存出现错误！'+command.error);
	}
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(
			L5.webPath+"/jsp/cams/dis/assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("villiageCode").value=list[0];
		document.getElementById("acceptAreaCode").value=list[0];
		document.getElementById("acceptAreaName").value=list[4];
		familyDs.set("villiageCode",list[0]);
		reliefDs.set("acceptAreaCode",list[0]);
		reliefDs.set("acceptAreaName",list[4]);
	}
}

function formatDateToString(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}
