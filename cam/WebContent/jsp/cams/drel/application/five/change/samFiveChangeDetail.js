var familyId='';
var applyDate='';
var applyReason='';
var photoId='';
//初始化
function init(){
	var peoplePanel=L5.getCmp("peoplePanel");
	//将人员panel合并
	peoplePanel.collapse();
	//打开人员panel时候加载数据
	peoplePanel.on('beforeexpand',loadPanel1);
	var panel2=L5.getCmp("panel2");
	//将入户调查panel合并
	panel2.collapse();
	
	applyDataSet.setParameter("APPLY_ID",applyId);
	applyDataSet.load();
	applyDataSet.on("load",function(){
		if(applyDataSet.getCount() == 1){
			applyDate=applyDataSet.get('applyDate');
			applyReason=applyDataSet.get('applyReason');
			setChangeItemText(applyDataSet.get('changeItem'));
			familyId=applyDataSet.get('familyId');
			
			var supportWay=applyDataSet.get('supportWay');
			$('supportWay').innerHTML=getDicText(supportWayDataset,supportWay);//供养方式
			if(supportWay=='06'){//集中供养
				var supportOrg=applyDataSet.get('supportOrg'); 	
				$('supportOrg').innerHTML=getDicText(supportOrgDataset,supportOrg);//供养机构
			}
			setChangeItemText(applyDataSet.get('changeItem'));
			//加载家庭
			loadFamilyDs();
			var auditId=applyDataSet.get('auditOpinionId');
			//办理进入的页面
			if(method=="handle"){
				var tab=L5.getCmp("tab");
				//是审核环节
				if(applyName=="check"){
					//不是审批退回了
					if(auditId == ''){
						var auditDetailPanel=L5.getCmp("auditDetailPanel");
						tab.remove(auditDetailPanel);
					}else {
						var auditDetailPanel=L5.getCmp("auditDetailPanel");
						auditDetailPanel.collapse();
						auditDetailPanel.on('beforeexpand',loadAudit);
					}
					var auditEditPanel=L5.getCmp("auditEditPanel");
					tab.remove(auditEditPanel);
					var checkDetailPanel=L5.getCmp("checkDetailPanel");
					tab.remove(checkDetailPanel);
					
					loadCheck();
					
				//是审批环节
				}else if(applyName=="audit"){
					var auditDetailPanel=L5.getCmp("auditDetailPanel");
					tab.remove(auditDetailPanel);
					var checkEditPanel=L5.getCmp("checkEditPanel");
					tab.remove(checkEditPanel);
					
					loadAudit();
					var checkDetailPanel=L5.getCmp("checkDetailPanel");
					checkDetailPanel.collapse();
					checkDetailPanel.on('beforeexpand',loadCheck);
				}
			//查看明细进入的页面
			}else if(method=="detail"){
				//把救助相关的4项改成不可编辑
				var tab=L5.getCmp("tab");
				var checkEditPanel=L5.getCmp("checkEditPanel");
				tab.remove(checkEditPanel);
				var auditEditPanel=L5.getCmp("auditEditPanel");
				tab.remove(auditEditPanel);
				
				var auditDetailPanel=L5.getCmp("auditDetailPanel");
				auditDetailPanel.collapse();
				auditDetailPanel.on('beforeexpand',loadAudit);
				var checkDetailPanel=L5.getCmp("checkDetailPanel");
				checkDetailPanel.collapse();
				checkDetailPanel.on('beforeexpand',loadCheck);
				//审批同意
				if(auditId == '1'){
					document.getElementById("beginDateSLD").style.display="block";
					document.getElementById("beginDateLD").style.display="none";
				}else if(auditId == '0'){
					document.getElementById("beginDateSLD").style.display="none";
					document.getElementById("beginDateLD").style.display="block";
				}
			}
		}
		
	});
	//家庭加载的时候加载照片
	familyDataSet.on('load',function(){
		if(familyDataSet.getCount() == 1){
			familyDataSet.set('applyReason',applyReason);
			familyDataSet.set('applyDate',applyDate);
			photoId=familyDataSet.get("photoId");
			//加载照片
			showPhotoAbleEdit(photoId);
		}
	});
	checkSurveyDataset.on('load',function(){
		if(checkSurveyDataset.getCount() == 0){
			checkSurveyDataset.newRecord({"activityId":"check"});
		}
	});
	checkNoticeDataset.on('load',function(){
		if(checkNoticeDataset.getCount() == 0){
			checkNoticeDataset.newRecord({"activityId":"check"});
		}
	});
	auditSurveyDataset.on('load',function(){
		if(auditSurveyDataset.getCount() == 0){
			auditSurveyDataset.newRecord({"activityId":"audit"});
		}
	});
	auditNoticeDataset.on('load',function(){
		if(auditNoticeDataset.getCount() == 0){
			auditNoticeDataset.newRecord({"activityId":"audit"});
		}
	});
}
//加载家庭信息
function loadFamilyDs(){
    familyDataSet.setParameter("FAMILY_ID",familyId);
    familyDataSet.load();
    familyDataSet.on("load",loadBank);
}
function loadBank(ds){
	ds.un("load",loadBank);
  	bankAccountDS.setParameter("FAMILY_ID",familyId);
    bankAccountDS.on("load",loadPanel2);
    bankAccountDS.load();
}
//加载人员列表
function loadPanel1(){
	peopleListDataSet.setParameter("FAMILY_ID",familyId);
	peopleListDataSet.load();
}
//打开入户调查页面时加载受理时的信息
function loadPanel2(ds){
	ds.un("load",loadPanel2);
	acceptSurveyDataset.load();
    acceptSurveyDataset.on("load",loadAcceptDiscussionDs);
}
//加载评议结果
function loadAcceptDiscussionDs(ds){
	ds.un("load",loadAcceptDiscussionDs);
	acceptDiscussionDataset.load();
    acceptDiscussionDataset.on("load",loadAcceptNoticeDs);
}
//加载公告
function loadAcceptNoticeDs(ds){
	ds.un("load",loadAcceptNoticeDs);
	acceptNoticeDataset.load();
}
//审核页面加载
function loadCheck(){
	checkSurveyDataset.load();
	checkSurveyDataset.on("load",loadCheckSurveyNoticeDs);
	
}
//加载审核公告
function loadCheckSurveyNoticeDs(ds){
	ds.un("load",loadCheckSurveyNoticeDs);
	checkNoticeDataset.load();
}
//审批页面加载
function loadAudit(){
	auditSurveyDataset.load();
	auditSurveyDataset.on('load',loadAuditNoticeDs);
	auditNoticeDataset.on('load',loadAuditNotice);
}
function loadAuditNotice(ds){
	ds.un("load",loadAuditNotice);
	if(method=="detail"){
		//审批同意
		var changeItem=applyDataSet.get("changeItem");
		if(changeItem == '03'){
			document.getElementById("beginDateSLD").style.display="none";
			document.getElementById("beginDateLD").style.display="block";
		}else { 
			document.getElementById("beginDateSLD").style.display="block";
			document.getElementById("beginDateLD").style.display="none";
		}
	}
}			
//加载审批公告
function loadAuditNoticeDs(ds){
	ds.un("load",loadAuditNoticeDs);
	auditNoticeDataset.load();
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("submitId").setDisabled(true);
	L5.getCmp("saveId").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("submitId").setDisabled(false);
	L5.getCmp("saveId").setDisabled(false);
}
//保存
function save(){
	buttonDisable();
	if(!saveCheck()){
	   buttonEnabled();
	   return ;
	}
	var familyRecord=familyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveChangeCmd");
	applyDataSet.getCurrent().set("assignmentId",assignmentId);
	//维护照片信息
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	if(applyName=="check"){
		var checkSurveyRecord=checkSurveyDataset.getCurrent();
		var checkNoticeRecord=checkNoticeDataset.getCurrent();
		
		command.setParameter("surveyRecord",checkSurveyRecord);
		command.setParameter("noticeRecord",checkNoticeRecord);
	}else if(applyName=="audit"){
		var auditSurveyRecord=auditSurveyDataset.getCurrent();
		var auditNoticeRecord=auditNoticeDataset.getCurrent();
		command.setParameter("surveyRecord",auditSurveyRecord);
		command.setParameter("noticeRecord",auditNoticeRecord);
	}
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			 buttonEnabled();
		
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		 buttonEnabled();
	}
	
}
//保存校验
function saveCheck(){
	var familyIsValidate = familyDataSet.isValidate();
	if(familyIsValidate != true){
		L5.Msg.alert("提示",familyIsValidate);
		return false;
	}
	if(applyName=="check"){
		if(applyDataSet.get("checkOpinionId") == '' ){
			L5.Msg.alert("提示","校验未通过：审核结果不能为空！");
			return false;
		}
		var checkSurveyDatasetIsValidate = checkSurveyDataset.isValidate();
		if(checkSurveyDatasetIsValidate != true){
			L5.Msg.alert("提示",checkSurveyDatasetIsValidate);
			return false;
		}
		var checkNoticeDatasetIsValidate = checkNoticeDataset.isValidate();
		if(checkNoticeDatasetIsValidate != true){
			L5.Msg.alert("提示",checkNoticeDatasetIsValidate);
			return false;
		}
	}else if(applyName=="audit"){
		if(applyDataSet.get("auditOpinionId") == '' ){
			L5.Msg.alert("提示","校验未通过：审批结果不能为空！");
			return false;
		}
		
		var auditSurveyDatasetIsValidate = auditSurveyDataset.isValidate();
		if(auditSurveyDatasetIsValidate != true){
			L5.Msg.alert("提示",auditSurveyDatasetIsValidate);
			return false;
		}
		var auditNoticeDatasetIsValidate = auditNoticeDataset.isValidate();
		if(auditNoticeDatasetIsValidate != true){
			L5.Msg.alert("提示",auditNoticeDatasetIsValidate);
			return false;
		}
		//校验开始日期不小于当前月份
		if(auditNoticeDataset.get('noticeResult')=='1' && _$('beginDateS')!='' && applyDataSet.get("auditOpinionId") == '1' && applyDataSet.get("changeItem") != '06' ){
			applyDataSet.set("beginDate",_$('beginDateS'));
			 
		}
		if(auditNoticeDataset.get('noticeResult')=='1'&&  _$('beginDate')!='' && applyDataSet.get("auditOpinionId") == '1'&& applyDataSet.get("changeItem") == '06' ){
			applyDataSet.set("beginDate",_$('beginDate'));
		}
	}
	return true
}

//提交
function submitApply(){
	buttonDisable();
	if(!submitApplyCheck()){
	   buttonEnabled();
	   return ;
	}
	var familyRecord=familyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveChangeCmd");
	applyDataSet.getCurrent().set("assignmentId",assignmentId);
	//维护照片信息
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	if(applyName=="check"){
		var checkSurveyRecord=checkSurveyDataset.getCurrent();
		var checkNoticeRecord=checkNoticeDataset.getCurrent();
		
		command.setParameter("surveyRecord",checkSurveyRecord);
		command.setParameter("noticeRecord",checkNoticeRecord);
	}else if(applyName=="audit"){
		var auditSurveyRecord=auditSurveyDataset.getCurrent();
		var auditNoticeRecord=auditNoticeDataset.getCurrent();
		command.setParameter("surveyRecord",auditSurveyRecord);
		command.setParameter("noticeRecord",auditNoticeRecord);
		if(applyDataSet.get("auditOpinionId") == '1' && applyDataSet.get("changeItem") == '06'  ){
			L5.MessageBox.confirm('确定', "你的审批意见为《同意变更》，\r\n救助截止月份为："
				+applyDataSet.get("beginDate") +"\r\n"+applyDataSet.get("beginDate")+"仍然在保，下一月份停保！"
				+"\r\n\r\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp确定此月份选‘是’，重新选择选‘否’！",function(sta){
					if(sta=="yes"){
						command.execute("sendApply");
						if (!command.error) {
							L5.Msg.alert("提示","提交成功！",function(){
								var applyRecord= applyDataSet.getCurrent();
								if(applyName == "check" && applyRecord.get('changeItem')== '04' &&  applyRecord.get("checkOpinionId") == '1' ){
									L5.Msg.alert('提示',"审批完成之后请注意维护该低保户的银行账户！",function(){
										 buttonEnabled();
										 returnBack();
									});
								}else{
									 buttonEnabled();
									 returnBack();
								}
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
		if(applyDataSet.get("auditOpinionId") == '0'   ){
			L5.MessageBox.confirm('确定', "你的审批意见为《不同意变更》， "
			+"\r\n"+"\r\n"+"户主为"+applyDataSet.get("familyName")+"的家庭待遇信息将维持原样！"
				+"\r\n\r\n&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp确定选‘是’，重新选择选‘否’！",function(sta){
					if(sta=="yes"){
						command.execute("sendApply");
						if (!command.error) {
							L5.Msg.alert("提示","提交成功！",function(){
								var applyRecord= applyDataSet.getCurrent();
								if(applyName == "check" && applyRecord.get('changeItem')== '04' &&  applyRecord.get("checkOpinionId") == '1' ){
									L5.Msg.alert('提示',"审批完成之后请注意维护该低保户的银行账户！",function(){
										 buttonEnabled();
										 returnBack();
									});
								}else{
									 buttonEnabled();
									 returnBack();
								}
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
	}
	command.execute("sendApply");
	if (!command.error) {
		L5.Msg.alert("提示","提交成功！",function(){
			var applyRecord= applyDataSet.getCurrent();
			 if(applyName == "check" && applyRecord.get('changeItem')== '04' &&  applyRecord.get("checkOpinionId") == '1' ){
				L5.Msg.alert('提示',"审批完成之后请注意维护该低保户的银行账户！",function(){
					 buttonEnabled();
					 returnBack();
				});
			}else{
				 buttonEnabled();
				 returnBack();
			}
		});		
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		 buttonEnabled();
	}
}
//校验家庭成员状态
function checkPersonStatus(){
	var records=peopleListDataSet.getAllRecords();
	for(var i = 0;i<peopleListDataSet.getTotalCount();i++){
		if(records[i].get("PERSONAL_STATS_TAG") == '03'){
			return false;
		}
	}
	return true;
}
//提交校验
function submitApplyCheck(){

	var checkPersonStatusVal = checkPersonStatus();// 这里是判断是不是死亡状态
	if(!checkPersonStatusVal){
		var familyIsValidate = familyDataSet.isValidate();
		if(familyIsValidate != true){
			L5.Msg.alert("提示",familyIsValidate);
			return false;
		}
		if(applyName=="check"){
			if(applyDataSet.get("checkOpinionId") == '' ){
				L5.Msg.alert("提示","校验未通过：审核结果不能为空！");
				return false;
			}
			//如果是退回 不进行校验
			if(applyDataSet.get("checkOpinionId") == '3'){
				return true;
			}
		}else if(applyName=="audit"){
			if(applyDataSet.get("auditOpinionId") == '' ){
				L5.Msg.alert("提示","校验未通过：审批结果不能为空！");
				return false;
			}
			//如果是退回 不进行校验
			if(applyDataSet.get("auditOpinionId") == '3'){
				return true;
			}
			if( _$('beginDateS')=='' && applyDataSet.get("auditOpinionId") == '1' && applyDataSet.get("changeItem") != '06'){
				L5.Msg.alert("提示","校验未通过：救助开始月份不能为空！");
				return false;
			}
			//校验开始日期不小于当前月份
			if( _$('beginDateS')!='' && applyDataSet.get("auditOpinionId") == '1' && applyDataSet.get("changeItem") != '06' ){
				 
				var beginDate=document.getElementById('beginDateS').value;
				applyDataSet.set('beginDate',beginDate);
				
			}
			if( _$('beginDate')=='' && applyDataSet.get("auditOpinionId") == '1'  && applyDataSet.get("changeItem") == '06'){
				L5.Msg.alert("提示","校验未通过：救助截止月份不能为空！");
				return false;
			}
			if(_$('beginDate')!='' && applyDataSet.get("auditOpinionId") == '0' && applyDataSet.get("changeItem") == '06'){
				var beginDate=document.getElementById('beginDate').value;
				applyDataSet.set('beginDate',beginDate);
			}
			
			if(applyDataSet.get("changeItem") == '06'){
				applyDataSet.set('beginDate',_$('beginDate'));
			}else{
				applyDataSet.set('beginDate',_$('beginDateS'));
			}
		}
		return true;
	}else{
		var familyIsValidate = familyDataSet.isValidate();
		if(familyIsValidate != true){
			L5.Msg.alert("提示",familyIsValidate);
			return false;
		}
		if(applyName=="check"){
			if(applyDataSet.get("checkOpinionId") == '' ){
				L5.Msg.alert("提示","校验未通过：审核结果不能为空！");
				return false;
			}
			if(applyDataSet.get("checkPrincipal") == '' ){
				L5.Msg.alert("提示","校验未通过：审核负责人不能为空！");
				return false;
			}
			if(applyDataSet.get("checkDate") == '' ){
				L5.Msg.alert("提示","校验未通过：审核日期不能为空！");
				return false;
			}
			if(applyDataSet.get("checkAgent") == '' ){
				L5.Msg.alert("提示","校验未通过：审核经办人不能为空！");
				return false;
			}
			var checkSurveyDatasetIsValidate = checkSurveyDataset.isValidate();
			if(checkSurveyDatasetIsValidate != true){
				L5.Msg.alert("提示",checkSurveyDatasetIsValidate);
				return false;
			}
			var checkNoticeDatasetIsValidate = checkNoticeDataset.isValidate();
			if(checkNoticeDatasetIsValidate != true){
				L5.Msg.alert("提示",checkNoticeDatasetIsValidate);
				return false;
			}
			//如果是退回 不进行校验
			if(applyDataSet.get("checkOpinionId") == '3'){
				return true;
			}
			if(checkSurveyDataset.get('surveyResult') != '' ){
				if(checkSurveyDataset.get("surveyDate") == '' ){
					L5.Msg.alert("提示","校验未通过：调查日期不能为空！");
					return false;
				}
				if(checkSurveyDataset.get("surveyPeople") == '' ){
					L5.Msg.alert("提示","校验未通过：调查负责人不能为空！");
					return false;
				}
				if(checkSurveyDataset.get('surveyResult') == '0' &&checkSurveyDataset.get('surveyContents')== ''){
					L5.Msg.alert("提示","校验未通过：备注不能为空！");
					return false;
				}
			}
			if(checkNoticeDataset.get('noticeResult') != '' ){
				if(checkNoticeDataset.get("beginDate") == '' ){
					L5.Msg.alert("提示","校验未通过：公示开始日期不能为空！");
					return false;
				}
				if(checkNoticeDataset.get("endDate") == '' ){
					L5.Msg.alert("提示","校验未通过：公示结束日期不能为空！");
					return false;
				}
				if(checkNoticeDataset.get("principal") == '' ){
					L5.Msg.alert("提示","校验未通过：公示经办人不能为空！");
					return false;
				}
				
			}
		}else if(applyName=="audit"){
			if(applyDataSet.get("auditOpinionId") == '' ){
				L5.Msg.alert("提示","校验未通过：审批结果不能为空！");
				return false;
			}
				if(applyDataSet.get("auditPrincipal") == '' ){
				L5.Msg.alert("提示","校验未通过：民政局负责人不能为空！");
				return false;
			}
			if(applyDataSet.get("auditDate") == '' ){
				L5.Msg.alert("提示","校验未通过：审批日期不能为空！");
				return false;
			}
			if(applyDataSet.get("auditAgent") == '' ){
				L5.Msg.alert("提示","校验未通过：审批经办人不能为空！");
				return false;
			}
			//如果是退回 不进行校验
			if(applyDataSet.get("auditOpinionId") == '3'){
				return true;
			}
			var auditSurveyDatasetIsValidate = auditSurveyDataset.isValidate();
			if(auditSurveyDatasetIsValidate != true){
				L5.Msg.alert("提示",auditSurveyDatasetIsValidate);
				return false;
			}
			var auditNoticeDatasetIsValidate = auditNoticeDataset.isValidate();
			if(auditNoticeDatasetIsValidate != true){
				L5.Msg.alert("提示",auditNoticeDatasetIsValidate);
				return false;
			}
			
			if(applyDataSet.get("auditOpinionId") == '1' && auditNoticeDataset.get('noticeResult') == '' ){
				L5.Msg.alert("提示","校验未通过：公示结果不能为空！");
				return false;
			}
			if(auditSurveyDataset.get('surveyResult') != '' ){
				if(auditSurveyDataset.get("surveyDate") == '' ){
					L5.Msg.alert("提示","校验未通过：调查日期不能为空！");
					return false;
				}
				if(auditSurveyDataset.get("surveyPeople") == '' ){
					L5.Msg.alert("提示","校验未通过：调查负责人不能为空！");
					return false;
				}
				if(auditSurveyDataset.get('surveyResult') == '0' &&auditSurveyDataset.get('surveyContents')== ''){
					L5.Msg.alert("提示","校验未通过：备注不能为空！");
					return false;
				}
			}
			if(auditNoticeDataset.get('noticeResult') != '' ){
				if(auditNoticeDataset.get('noticeResult') == '0' ){
					L5.Msg.alert("提示","校验未通过：公示结果不能为“有异议”！");
					return false;
				}
				if(auditNoticeDataset.get("beginDate") == '' ){
					L5.Msg.alert("提示","校验未通过：公示开始日期不能为空！");
					return false;
				}
				if(auditNoticeDataset.get("endDate") == '' ){
					L5.Msg.alert("提示","校验未通过：公示结束日期不能为空！");
					return false;
				}
				if(auditNoticeDataset.get("principal") == '' ){
					L5.Msg.alert("提示","校验未通过：公示经办人不能为空！");
					return false;
				}
				if(auditNoticeDataset.get('noticeResult')=='1'&& _$('beginDateS')=='' && applyDataSet.get("auditOpinionId") == '1' && applyDataSet.get("changeItem") != '06'){
					L5.Msg.alert("提示","校验未通过：救助开始月份不能为空！");
					return false;
				}
				//校验开始日期不小于当前月份
				if(auditNoticeDataset.get('noticeResult')=='1' && _$('beginDateS')!='' && applyDataSet.get("auditOpinionId") == '1' && applyDataSet.get("changeItem") != '06' ){
					 
					var beginDate=document.getElementById('beginDateS').value;
					applyDataSet.set('beginDate',beginDate);
					
				}
				if(auditNoticeDataset.get('noticeResult')=='1'&&  _$('beginDate')=='' && applyDataSet.get("auditOpinionId") == '1'  && applyDataSet.get("changeItem") == '06'){
					L5.Msg.alert("提示","校验未通过：救助截止月份不能为空！");
					return false;
				}
				if(auditNoticeDataset.get('noticeResult')=='1'&&  _$('beginDate')!='' && applyDataSet.get("auditOpinionId") == '0' && applyDataSet.get("changeItem") == '06'){
					var beginDate=document.getElementById('beginDate').value;
					applyDataSet.set('beginDate',beginDate);
				}
				
				if(applyDataSet.get("changeItem") == '06'){
					applyDataSet.set('beginDate',_$('beginDate'));
				}else{
					applyDataSet.set('beginDate',_$('beginDateS'));
				}
			}
		}
		return true;
	}
	
}
//关闭
function returnBack(){
	var parent=window.dialogArguments;
	var applyDataSet=parent.applyDataSet;
	var mysetwhere="DOMICILE_CODE:"+organArea;
	applyDataSet.setParameter("mysetwhere",mysetwhere);	
	applyDataSet.load();
	window.close();
}
//加载照片
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
}
//加载明细页面
function detailexpand(){
		var width = screen.width-100;
	    var height = screen.height-340;
		var url='../apply/samFiveExpandDetail.jsp?familyId='+familyId+'&applyId='+applyId+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//加载人员明细页面
//加载人员明细页面
function peopleDetail(peopleId){
	var width = 1000;
    var height = 423;
	var url="../apply/samBasePeopleDetail.jsp?peopleId="+peopleId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
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
		if (revalue=='1' && applyDataSet.get("changeItem") != '06'){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyDataSet.get("beginDate");
		}else if(revalue=='1' && applyDataSet.get("changeItem") == '06'){
			document.getElementById('beginDateL').style.display="block";
			document.getElementById('beginDate').style.display="block";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
			document.getElementById('beginDate').value=applyDataSet.get("beginDate");
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
		if(applyDataSet.get("changeItem") != '06'){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyDataSet.get("beginDate");
		}else if(applyDataSet.get("changeItem") == '06'){
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

//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}		
//明细
function getName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href=# onclick="peopleDetail(\''+record.get("PEOPLE_ID")+'\')">'+value+'</a>';
}
//明细页面显示变更事项
function setChangeItemText(changeItems){
	var itemText="";
	for (var i=0;i<samChangeItemDs.getTotalCount();i++){
		var record = samChangeItemDs.getAt(i);
		if(changeItems.indexOf(samChangeItemDs.getAt(i).get('value'))>-1){
			if(""==itemText){
				itemText=samChangeItemDs.getAt(i).get('text');
			} else {
				itemText=itemText+","+samChangeItemDs.getAt(i).get('text');
			}
		}
	}
	document.getElementById("changeItemText").innerText=itemText;
}
//审核调查结果为不属实，填写备注录入
function checkOpinionCheck(value){
	if(value == '0'){
		document.getElementById('beizhuhang').style.display="block";
	}else{
		document.getElementById('beizhuhang').style.display="none";
		checkSurveyDataset.set('surveyContents','');
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