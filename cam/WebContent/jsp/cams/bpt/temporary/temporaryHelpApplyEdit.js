function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		//ds.setParameter("peopleId",peopleId);
		//ds.load();
		ds.setParameter("applyId",applyId);
		ds.load();
	}else if (method=="ADD"){
		ds.setParameter("peopleId",peopleId);
		ds.load();
	}else if(method =="DETAIL"){
	    dsUpdateTemporaryHelp.setParameter("applyId",applyId);
		dsUpdateTemporaryHelp.load();
	 
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	ds.on("load",setDefultValue);
	L5.QuickTips.init(); 
	if(organType=='14'){//街道
		L5.getCmp("submitButton").hide();
	}
}
		//发起单个流程
function createSend(){
	L5.getCmp("submitButton").setDisabled(true);
	window.returnValue="createSend";
	window.close();
	
}
function save(){
	if(!checkSave()){
		return;
	}
	var dsUpdateTemporaryHelp  = L5.DatasetMgr.lookup("ds");
	var record = dsUpdateTemporaryHelp.getCurrent();
    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpCommand"); 
	command.setParameter("records",record);
	command.execute("update");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function checkSave(){
	var dsUpdateTemporaryHelp  = L5.DatasetMgr.lookup("ds");
	var record = dsUpdateTemporaryHelp.getCurrent();
	
	var checkIncharge = record.get("checkIncharge");
	if(checkIncharge==''){
		L5.Msg.alert("提示","村（居）负责人不能为空！");
		return false;
	}
	var checkDate = record.get("checkDate");
	if(checkDate==''){
		L5.Msg.alert("提示","村(居)审核时间不能为空！");
		return false;
	}
	var checkAdvice = record.get("checkAdvice");
	if(checkAdvice==''){
		L5.Msg.alert("提示","村(居)审核意见不能为空！");
		return false;
	}
	
	var auditIncharge = record.get("auditIncharge");
	if(auditIncharge==''){
		L5.Msg.alert("提示","乡镇（街道）负责人不能为空！");
		return false;
	}
	var auditDate = record.get("auditDate");
	if(auditDate==''){
		L5.Msg.alert("提示","乡镇（街道）审核时间不能为空！");
		return false;
	}
	var auditAdvice = record.get("auditAdvice");
	if(auditAdvice==''){
		L5.Msg.alert("提示","乡镇（街道）审核意见不能为空！");
		return false;
	}
	
	var verifyIncharge = record.get("verifyIncharge");
	if(verifyIncharge==''){
		L5.Msg.alert("提示","县民政部门负责人不能为空！");
		return false;
	}
	var verifyDate = record.get("verifyDate");
	if(verifyDate==''){
		L5.Msg.alert("提示","县民政部门审核时间不能为空！");
		return false;
	}
	var verifyAdvice = record.get("verifyAdvice");
	if(verifyAdvice==''){
		L5.Msg.alert("提示","县民政部门审核意见不能为空！");
		return false;
	}
	return true;
}

function setDefultValue(ds){
	var checkDate = ds.get("checkDate");
	var auditDate = ds.get("auditDate");
	var verifyDate = ds.get("verifyDate");
	var verifyIncharge = ds.get("verifyIncharge");
	if(checkDate == null || checkDate == "") {
		ds.set("checkDate",getCurDate());
	}
	if(auditDate == null || auditDate == "") {
		ds.set("auditDate",getCurDate());
	}
	if(verifyDate == null || verifyDate == "") {
		ds.set("verifyDate",getCurDate());
	}
	if(verifyIncharge == null || verifyIncharge == "") {
		ds.set("verifyIncharge",currentUserName);
	}
}

	//获得当前日期 
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}	

