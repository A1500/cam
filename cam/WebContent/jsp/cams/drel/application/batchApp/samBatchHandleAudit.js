var item='';
function init(){
	applyAuditDataSet.newRecord();
	auditSurveyDataset.newRecord({"activityId":"audit"});
	auditNoticeDataset.newRecord({"activityId":"audit"});
	var parent=window.dialogArguments;
	var applyids = parent.applyIds.replace(/;/g,",");
	applyListDataSet.setParameter("APPLY_ID@in",applyids.substring(0,(applyids.length-1)));
	applyListDataSet.load();
	applyListDataSet.on("load",checkOnlyItem);
	window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		var applyDataSet=parent.applyDataSet;
		applyDataSet.reload();
	} 
}
function checkOnlyItem(ds){
	ds.un('load',checkOnlyItem);
	var records = ds.getAllRecords();
	item = records[0].get('changeItem');
	if(ds.getCount() > 1 ){
		for(var i=0;i<ds.getCount();i++){
			if(item != records[i].get('changeItem')){
				L5.Msg.alert("提示","请确认选定的所有业务的变更事项相同！否则无法进行批量审批！");
				L5.getCmp("saveId").setDisabled(true);
				return;
			}
		}
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
		if (revalue=='1' && (item != '03' && item != '06')){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyAuditDataSet.get("beginDate");
		}else if(revalue=='1' && (item == '03'|| item == '06')){
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
		if(revalue=='1' && (item != '03' && item != '06')){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyAuditDataSet.get("beginDate");
		}else if(revalue=='1' && (item == '03' || item == '06')){
			document.getElementById('beginDateL').style.display="block";
			document.getElementById('beginDate').style.display="block";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
		}else {
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
//确定提交
function submitApp(){
	buttonUnabled();
	var applyAuditDataSetIsValidate = applyAuditDataSet.isValidate();
	if(applyAuditDataSetIsValidate != true){
		L5.Msg.alert("提示",applyAuditDataSetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var auditSurveyDatasetIsValidate = auditSurveyDataset.isValidate();
	if(auditSurveyDatasetIsValidate != true){
		L5.Msg.alert("提示",auditSurveyDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	
	var auditNoticeDatasetIsValidate = auditNoticeDataset.isValidate();
	if(auditNoticeDatasetIsValidate != true){
		L5.Msg.alert("提示",auditNoticeDatasetIsValidate);
		buttonEnabled();
		return false;
	}
	if(auditNoticeDataset.get('noticeResult')=='1'&& _$('beginDateS')=='' && applyAuditDataSet.get("auditOpinionId") == '1' && (item != '03' && item != '06')){
		L5.Msg.alert("提示","校验未通过：救助开始月份不能为空！");
		buttonEnabled();
		return false;
	}
	if(auditNoticeDataset.get('noticeResult')=='1' && _$('beginDateS')!='' && applyAuditDataSet.get("auditOpinionId") == '1' && (item != '03'&& item != '06')){
		var beginDate=document.getElementById('beginDateS').value;
		applyAuditDataSet.set('beginDate',beginDate);
		
	}
	if(auditNoticeDataset.get('noticeResult')=='1'&&  _$('beginDate')=='' && applyAuditDataSet.get("auditOpinionId") == '1' && (item == '03'|| item == '06')){
		L5.Msg.alert("提示","校验未通过：救助截止月份不能为空！");
		buttonEnabled();
		return false;
	}
	if(auditNoticeDataset.get('noticeResult')=='1'&&  _$('beginDate')!='' && applyAuditDataSet.get("auditOpinionId") == '1' && (item == '03'|| item == '06')){
		var beginDate=document.getElementById('beginDate').value;
		applyAuditDataSet.set('beginDate',beginDate);
	}
	var command;
	//城市低保批量审批
	if(assistanceType=='01'){
		command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
	}
	//农村低保批量审批
	if(assistanceType=='02'){
		command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryChangeCmd");
	}
	//农村五保批量审批
	if(assistanceType=='03'){
		command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveChangeCmd");
		
	}
		var parent=window.dialogArguments;
		command.setParameter("applyIds",parent.applyIds );
		command.setParameter("assignmentIds",parent.assignmentIds );
		
		command.setParameter("applyRecord",applyAuditDataSet.getCurrent());
		command.setParameter("surveyRecord",auditSurveyDataset.getCurrent());
		command.setParameter("auditRecord",auditNoticeDataset.getCurrent());
	
		if(applyAuditDataSet.get("auditOpinionId") == '1' && (item == '03'|| item == '06') ){
			L5.MessageBox.confirm('确定', "你的审批意见为《同意变更》停保，\r\n救助截止月份为："
				+applyAuditDataSet.get("beginDate") +"\r\n"+applyAuditDataSet.get("beginDate")+"仍然在保，下一月份停保！"
				+"\r\n\r\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp确定此月份选‘是’，重新选择选‘否’！",function(sta){
					if(sta=="yes"){
						command.execute("batchApp");
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
					else{
						buttonEnabled();
						return;
					}
			});	
			return;
		}
	
		if(applyAuditDataSet.get("auditOpinionId") == '0' ){
			L5.MessageBox.confirm('确定', "你的审批意见为《不同意变更》， "
			+"\r\n"+"\r\n"+"批量选定的家庭的待遇信息将维持原样！"
				+"\r\n\r\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp确定选‘是’，重新选择选‘否’！",function(sta){
				if(sta=="yes"){
					command.execute("batchApp");
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
				else{
					buttonEnabled();
					return;
				}
			});	
			return;
		}
		command.execute("batchApp");
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
	L5.getCmp("saveId").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("saveId").setDisabled(false);
}
