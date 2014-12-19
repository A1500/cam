var item='';
function init(){
	acceptSurveyDataset.newRecord({"activityId":"accept"});
	acceptDiscussionDataset.newRecord({"activityId":"accept","discussionResult":"1"});
	acceptNoticeDataset.newRecord({"activityId":"accept"});
	
	checkNoticeDataset.newRecord({"activityId":"check"});
	checkSurveyDataset.newRecord({"activityId":"check"});
		
	applyDataSet.newRecord();	
	
	var parent=window.dialogArguments;
	var applyids = parent.applyIds.replace(/;/g,",");
	applyListDataSet.setParameter("APPLY_ID@in",applyids.substring(0,(applyids.length-1)));
	applyListDataSet.load();
	window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		var applyDataSetParent=parent.applyDataSet;
		applyDataSetParent.reload();
	} 
}
function saveApp(){
	buttonUnabled();
	
	var applyAuditDataSetIsValidate = acceptNoticeDataset.isValidate();
	if(applyAuditDataSetIsValidate != true){
		L5.Msg.alert("提示",applyAuditDataSetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var auditSurveyDatasetIsValidate = acceptSurveyDataset.isValidate();
	if(auditSurveyDatasetIsValidate != true){
		L5.Msg.alert("提示",auditSurveyDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var auditNoticeDatasetIsValidate = acceptDiscussionDataset.isValidate();
	if(auditNoticeDatasetIsValidate != true){
		L5.Msg.alert("提示",auditNoticeDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var checkSurveyDatasetIsValidate = checkSurveyDataset.isValidate();
	if(checkSurveyDatasetIsValidate != true){
		L5.Msg.alert("提示",checkSurveyDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var checkNoticeDatasetIsValidate = checkNoticeDataset.isValidate();
	if(checkNoticeDatasetIsValidate != true){
		L5.Msg.alert("提示",checkNoticeDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var applyDataSetIsValidate = applyDataSet.isValidate();
	if(applyDataSetIsValidate != true){
		L5.Msg.alert("提示",applyDataSetIsValidate);
		buttonEnabled();
		return false;
	}
	
	
	var command;

/**	//城市低保批量
	if(assistanceType=='01'){
		command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
	}
	//农村低保批量
	if(assistanceType=='02'){
		command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryApplyCmd");
	}
	//农村五保批量
	if(assistanceType=='03'){
		command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveApplyCmd");
		
	}
	**/
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
	var parent=window.dialogArguments;
	command.setParameter("applyIds",parent.applyIds );
	command.setParameter("assignmentIds",parent.assignmentIds );
	
	command.setParameter("acceptNoticeRecord",acceptNoticeDataset.getCurrent());
	command.setParameter("acceptSurveyRecord",acceptSurveyDataset.getCurrent());
	command.setParameter("acceptDiscussionRecord",acceptDiscussionDataset.getCurrent());
	command.setParameter("checkSurveyRecord",checkSurveyDataset.getCurrent());
	command.setParameter("checkNoticeRecord",checkNoticeDataset.getCurrent());
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	command.execute("batchSaveCheck");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			 buttonEnabled();
			 returnBack();
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		 buttonEnabled();
	}
}

//确定提交
function submitApp(){
	buttonUnabled();
	
	var applyAuditDataSetIsValidate = acceptNoticeDataset.isValidate();
	if(applyAuditDataSetIsValidate != true){
		L5.Msg.alert("提示",applyAuditDataSetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var auditSurveyDatasetIsValidate = acceptSurveyDataset.isValidate();
	if(auditSurveyDatasetIsValidate != true){
		L5.Msg.alert("提示",auditSurveyDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var auditNoticeDatasetIsValidate = acceptDiscussionDataset.isValidate();
	if(auditNoticeDatasetIsValidate != true){
		L5.Msg.alert("提示",auditNoticeDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var checkSurveyDatasetIsValidate = checkSurveyDataset.isValidate();
	if(checkSurveyDatasetIsValidate != true){
		L5.Msg.alert("提示",checkSurveyDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var checkNoticeDatasetIsValidate = checkNoticeDataset.isValidate();
	if(checkNoticeDatasetIsValidate != true){
		L5.Msg.alert("提示",checkNoticeDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var applyDataSetIsValidate = applyDataSet.isValidate();
	if(applyDataSetIsValidate != true){
		L5.Msg.alert("提示",applyDataSetIsValidate);
		buttonEnabled();
		return false;
	}
	
	
	var command;

/**	//城市低保批量
	if(assistanceType=='01'){
		command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
	}
	//农村低保批量
	if(assistanceType=='02'){
		command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryApplyCmd");
	}
	//农村五保批量
	if(assistanceType=='03'){
		command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveApplyCmd");
		
	}
	**/
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
	var parent=window.dialogArguments;
	command.setParameter("applyIds",parent.applyIds );
	command.setParameter("assignmentIds",parent.assignmentIds );
	
	command.setParameter("acceptNoticeRecord",acceptNoticeDataset.getCurrent());
	command.setParameter("acceptSurveyRecord",acceptSurveyDataset.getCurrent());
	command.setParameter("acceptDiscussionRecord",acceptDiscussionDataset.getCurrent());
	command.setParameter("checkSurveyRecord",checkSurveyDataset.getCurrent());
	command.setParameter("checkNoticeRecord",checkNoticeDataset.getCurrent());
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	command.execute("batchSubmitCheck");
	if (!command.error) {
		L5.Msg.alert("提示","提交成功！",function(){
			 buttonEnabled();
			 returnBack();
		});		
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		 buttonEnabled();
	}
}
//关闭
function returnBack(){
	window.close();
}
function buttonUnabled(){
	if(organArea.substr(0,4) =='3701'){
		L5.getCmp("saveId").setDisabled(true);
	}else{
		L5.getCmp("submitID").setDisabled(true);
	}
	
}
//启用按钮
function buttonEnabled(){
		if(organArea.substr(0,4) =='3701'){
		L5.getCmp("saveId").setDisabled(false);
	}else{
		L5.getCmp("submitID").setDisabled(false);
	}
}
