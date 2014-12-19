function init() {
	var trainDic=L5.DatasetMgr.lookup("trainDic");
	trainDic.setParameter("filterSql", "CITYID='" + orgCode + "' AND EFFECTIVE ='1' ");
	trainDic.load();
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		}
	else if (method=="INSERT"){
		prssoldierstrainDataset.newRecord();
	}
	else if (method=="UPDATE"){
		prssoldierstrainDataset.baseParams["SOLDIERS_ID"]=idField;
		prssoldierstrainDataset.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	L5.QuickTips.init(); 
}

function save(){
	var prssoldierstrainDataset=L5.DatasetMgr.lookup("prssoldierstrainDataset");
	var records = prssoldierstrainDataset.getCurrent();
	var valid = prssoldierstrainDataset.isValidate();
	var trainingSkillLevel = records.get("trainingSkillLevel");
	var  trainingSkillLevelLenth = trainingSkillLevel.replace(/[^\x00-\xff]/g,"xx").length;
	if(trainingSkillLevelLenth>2){
		L5.Msg.alert('提示!','培训技能等级长度过长！');
		return false;
	}
	if(valid !== true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}
	var trainingStartTime = document.getElementById("trainingStartTime").value;
	if(trainingStartTime == "") {
		 L5.Msg.alert("提示", "培训开始时间不能为空!");
		    return false;
	}
	if(!checkBirthday(trainingStartTime)&&(trainingStartTime!="")){
	    L5.Msg.alert("提示", "培训开始时间格式或者内容不正确!");
	    return false;
	}
	var trainingEndTime = document.getElementById("trainingEndTime").value;
	if(trainingEndTime == "") {
		 L5.Msg.alert("提示", "培训结束时间不能为空!");
		    return false;
	}
	if(!checkBirthday(trainingEndTime)&&(trainingEndTime!="")){
	    L5.Msg.alert("提示", "培训结束时间格式或者内容不正确!");
	    return false;
	}
	var command=new L5.Command("com.inspur.cams.prs.prssoldierstrain.cmd.PrsSoldiersTrainCommand"); 
	command.setParameter("records",records);
	if(method=="INSERT"){
	}else if(method =="UPDATE"){
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	var soldiercommand=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand"); 
	soldiercommand.setParameter("soldierId",records.get("soldiersId"));
	soldiercommand.execute("updateTrainFlag");
}
 function back()
 {	
 	history.go(-1);
 }
 
 function print(){
	var url='../print/reguIdenti_apptable.jsp?soldierId='+idField+'&type=03';
	window.showModalDialog(url,window);
}