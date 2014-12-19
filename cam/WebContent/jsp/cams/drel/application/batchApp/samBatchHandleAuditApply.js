function init(){
	applyAuditDataSet.newRecord();
	auditSurveyDataset.newRecord({"activityId":"audit"});
	auditNoticeDataset.newRecord({"activityId":"audit"});
	
	window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		var applyDataSet=parent.applyDataSet;
		applyDataSet.reload();
	} 
}
//审批结果为不同意的时候，显示低保结束日期
function checkOpinion(value){
	if(value == '0'){
		document.getElementById('beginDateL').style.display="none";
		document.getElementById('beginDate').style.display="none";
		document.getElementById('beginDateSL').style.display="none";
		document.getElementById('beginDateS').style.display="none";
	}else if(value == '1'){
		var revalue=document.getElementById('auditResult').value;
		if (revalue=='1'){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyAuditDataSet.get("beginDate");
		}else if(revalue=='0'){
			document.getElementById('beginDateL').style.display="block";
			document.getElementById('beginDate').style.display="block";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
			document.getElementById('beginDate').value=applyAuditDataSet.get("beginDate");
		}else{
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
		}
		
	}else{
		document.getElementById('beginDateL').style.display="none";
		document.getElementById('beginDate').style.display="none";
		document.getElementById('beginDateSL').style.display="none";
		document.getElementById('beginDateS').style.display="none";
	}
}

function checkOpinion1(value){
	if(value == '1'){
		var revalue=document.getElementById('noticeResult').value;
		if(revalue=='1'){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyAuditDataSet.get("beginDate");
		}else{
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
		}
	}else if(value == '0'){
		var revalue=document.getElementById('noticeResult').value;
		if (revalue=='1'){
			document.getElementById('beginDateL').style.display="block";
			document.getElementById('beginDate').style.display="block";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
			document.getElementById('beginDate').value=applyAuditDataSet.get("beginDate");
		}else{
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
		}	
	}else{
		document.getElementById('beginDateL').style.display="none";
		document.getElementById('beginDate').style.display="none";
		document.getElementById('beginDateSL').style.display="none";
		document.getElementById('beginDateS').style.display="none";
	}
}
//审批调查结果为不属实，填写备注录入
function checkOpinionAudit(value){
	if(value == '0'){
		document.getElementById('beizhuhangAudit').style.display="block";
	}else{
		document.getElementById('beizhuhangAudit').style.display="none";
		auditSurveyDataset.set('surveyContents','');
	}
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("saveId").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("saveId").setDisabled(false);
}
//确定提交
function submitApp(){
	buttonDisable();
	var applyAuditDataSetIsValidate = applyAuditDataSet.isValidate();
	if(applyAuditDataSetIsValidate != true){
		L5.Msg.alert("提示",applyAuditDataSetIsValidate);
		//启用按钮
		buttonEnabled();
		return false;
	}
	
	var auditSurveyDatasetIsValidate = auditSurveyDataset.isValidate();
	if(auditSurveyDatasetIsValidate != true){
		L5.Msg.alert("提示",auditSurveyDatasetIsValidate);
		//启用按钮
		buttonEnabled();
		return false;
	}
	
	var auditNoticeDatasetIsValidate = auditNoticeDataset.isValidate();
	if(auditNoticeDatasetIsValidate != true){
		L5.Msg.alert("提示",auditNoticeDatasetIsValidate);
		//启用按钮
		buttonEnabled();
		return false;
	}
	if(auditNoticeDataset.get('noticeResult')=='1'&& _$('beginDateS')=='' && applyAuditDataSet.get("auditOpinionId") == '1'){
		L5.Msg.alert("提示","校验未通过：救助开始月份不能为空！");
		//启用按钮
		buttonEnabled();
		return false;
	}
	if(auditNoticeDataset.get('noticeResult')=='1' && _$('beginDateS')!='' && applyAuditDataSet.get("auditOpinionId") == '1' ){
		var beginDate=document.getElementById('beginDateS').value;
		applyAuditDataSet.set('beginDate',beginDate);
		
	}
	if(auditNoticeDataset.get('noticeResult')=='1'&&  _$('beginDate')=='' && applyAuditDataSet.get("auditOpinionId") == '0'){
		L5.Msg.alert("提示","校验未通过：救助截止月份不能为空！");
		//启用按钮
		buttonEnabled();
		return false;
	}
	if(auditNoticeDataset.get('noticeResult')=='1'&&  _$('beginDate')!='' && applyAuditDataSet.get("auditOpinionId") == '0'){
		var beginDate=document.getElementById('beginDate').value;
		applyAuditDataSet.set('beginDate',beginDate);
	}
	//城市低保批量审批
	if(assistanceType=='01'){
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
		var parent=window.dialogArguments;
		command.setParameter("applyIds",parent.applyIds );
		command.setParameter("assignmentIds",parent.assignmentIds );
		
		command.setParameter("applyRecord",applyAuditDataSet.getCurrent());
		command.setParameter("surveyRecord",auditSurveyDataset.getCurrent());
		command.setParameter("auditRecord",auditNoticeDataset.getCurrent());
		
		if(applyAuditDataSet.get("auditOpinionId") == '0' ){
			L5.MessageBox.confirm('确定', "你选择的意见为《不同意救助》！\r\n救助截止月份为："
				+applyAuditDataSet.get("beginDate") +"\r\n"+applyAuditDataSet.get("beginDate")+"仍然在保，下一月份停保！"
				+"\r\n\r\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp确定此月份选‘是’，重新选择选‘否’！",function(sta){
				if(sta=="yes"){
					command.execute("batchApp");
					if (!command.error) {
						L5.Msg.alert("提示","提交成功！",function(){
							//启用按钮
							buttonEnabled();
							 returnBack();
						});		
					}else{
						L5.Msg.alert('提示',"提交时出现错误！"+command.error);
						//启用按钮
							buttonEnabled();
					}
				}
				else{
					//启用按钮
					buttonEnabled();
					return;
				}
			});	
			return;
		}
		command.execute("batchApp");
		if (!command.error) {
			L5.Msg.alert("提示","提交成功！",function(){
				//启用按钮
				buttonEnabled();
				 returnBack();
			});		
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
			//启用按钮
			buttonEnabled();
		}
	}
	//农村低保批量审批
	if(assistanceType=='02'){
		var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryApplyCmd");
		var parent=window.dialogArguments;
		command.setParameter("applyIds",parent.applyIds );
		command.setParameter("assignmentIds",parent.assignmentIds );
		
		command.setParameter("applyRecord",applyAuditDataSet.getCurrent());
		command.setParameter("surveyRecord",auditSurveyDataset.getCurrent());
		command.setParameter("auditRecord",auditNoticeDataset.getCurrent());
		if(applyAuditDataSet.get("auditOpinionId") == '0' ){
			L5.MessageBox.confirm('确定', "你选择的意见为《不同意救助》！\r\n救助截止月份为："
				+applyAuditDataSet.get("beginDate") +"\r\n"+applyAuditDataSet.get("beginDate")+"仍然在保，下一月份停保！"
				+"\r\n\r\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp确定此月份选‘是’，重新选择选‘否’！",function(sta){
				if(sta=="yes"){
					command.execute("batchApp");
					if (!command.error) {
						L5.Msg.alert("提示","提交成功！",function(){
							 buttonEnabled();
							//启用按钮
		buttonEnabled();
						});		
					}else{
						L5.Msg.alert('提示',"提交时出现错误！"+command.error);
						//启用按钮
		buttonEnabled();
					}
				}
				else{
					//启用按钮
		buttonEnabled();
					return;
				}
			});	
			return;
		}
		command.execute("batchApp");
		if (!command.error) {
			L5.Msg.alert("提示","提交成功！",function(){
				//启用按钮
		buttonEnabled();
				 returnBack();
			});		
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
			//启用按钮
		buttonEnabled();
		}
	}
	//农村五保批量审批
	if(assistanceType=='03'){
		var command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveApplyCmd");
		var parent=window.dialogArguments;
		command.setParameter("applyIds",parent.applyIds );
		command.setParameter("assignmentIds",parent.assignmentIds );
		
		command.setParameter("applyRecord",applyAuditDataSet.getCurrent());
		command.setParameter("surveyRecord",auditSurveyDataset.getCurrent());
		command.setParameter("auditRecord",auditNoticeDataset.getCurrent());
		if(applyAuditDataSet.get("auditOpinionId") == '0' ){
			L5.MessageBox.confirm('确定', "你选择的意见为《不同意救助》！\r\n救助截止月份为："
				+applyAuditDataSet.get("beginDate") +"\r\n"+applyAuditDataSet.get("beginDate")+"仍然在保，下一月份停保！"
				+"\r\n\r\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp确定此月份选‘是’，重新选择选‘否’！",function(sta){
				if(sta=="yes"){
					command.execute("batchApp");
					if (!command.error) {
						L5.Msg.alert("提示","提交成功！",function(){
							//启用按钮
		buttonEnabled();
							 returnBack();
						});		
					}else{
						L5.Msg.alert('提示',"提交时出现错误！"+command.error);
						//启用按钮
		buttonEnabled();
					}
				}
				else{
					//启用按钮
		buttonEnabled();
					return;
				}
			});	
			return;
		}
		command.execute("batchApp");
		if (!command.error) {
			L5.Msg.alert("提示","提交成功！",function(){
				//启用按钮
		buttonEnabled();
				 returnBack();
			});		
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
			//启用按钮
		buttonEnabled();
		}
	}
}
//关闭
function returnBack(){
	window.close();
}
