var familyId='';
var applyDate='';
var applyReason='';
var photoId='';
function init(){
	var peoplePanel=L5.getCmp("peoplePanel");
	peoplePanel.collapse();
	peoplePanel.on('beforeexpand',loadPanel1);//打开人员panel时候加载数据
	var panel2=L5.getCmp("panel2");
	panel2.collapse();
	
	applyDataSet.setParameter("APPLY_ID",applyId);
	applyDataSet.load();
	applyDataSet.on("load",function(){
		if(applyDataSet.getCount() == 1){
			applyDate=applyDataSet.get('applyDate');
			applyReason=applyDataSet.get('applyReason');
			familyId=applyDataSet.get('familyId');
			
			var supportWay=applyDataSet.get('supportWay');
			$('supportWay').innerHTML=getDicText(supportWayDataset,supportWay);//供养方式
			if(supportWay=='03'){//集中供养
				var supportOrg=applyDataSet.get('supportOrg'); 	
				$('supportOrg').innerHTML=getDicText(supportOrgDataset,supportOrg);//供养机构
			}
			loadFamilyDs();//加载家庭
			var auditId=applyDataSet.get('auditOpinionId');
			if(method=="handle"){
				var tab=L5.getCmp("tab");
				if(applyName=="check"){
					if(auditId == ''){//不是审批退回
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
			}else if(method=="detail"){
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
			}
			
		}
		
	});
	//家庭加载的时候把业务表的相关字段放入家庭表里
	familyDataSet.on('load',function(){
		if(familyDataSet.getCount() == 1){
			familyDataSet.set('applyReason',applyReason);
			familyDataSet.set('applyDate',applyDate);
			
			photoId=familyDataSet.get("photoId");
			showPhotoAbleEdit(photoId);//加载照片
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

//发起核对
function addCheck(){
	buttonDisable();
	L5.MessageBox.confirm('提示', '该家庭将在经济核对业务中被核对，是否确认发起核对？',function(state){
		if(state=="yes"){
			if(applyDataSet.get("ifCheck")=='1'){
				L5.Msg.alert('提示',"该业务已经转核对！");
				 buttonEnabled();
				return;
			}
			var curActivity="";
			var checkOrgArea=organArea;
			if(needCountyCenter=="false"){//不需要市核对中心，直接提交至县核对中心。
				curActivity="03";
			} else {
				curActivity="02";
				checkOrgArea=organArea.substring(0,4)+"00000000";
			}
			var familyRecord=familyDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.drel.application.comm.cmd.SamApplyFromEnsureyCmd");
			command.setParameter("applyId",applyId);
			command.setParameter("familyId",familyId);
			command.setParameter("checkOrgArea",checkOrgArea);
			command.setParameter("curActivity",curActivity);
			command.execute("addCheck");
			if (!command.error) {
				L5.Msg.alert("提示","发起核对成功，请在待办列表中查看核对结果！",function(){
					applyDataSet.set("ifCheck",'1');
					 buttonEnabled();
				});		
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				 buttonEnabled();
			}
		}else{
				 buttonEnabled();
			return false;
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
function loadCheck(){
	checkSurveyDataset.load();
	checkSurveyDataset.on("load",loadCheckSurveyNoticeDs);
	
}
//加载审核公告
function loadCheckSurveyNoticeDs(ds){
	ds.un("load",loadCheckSurveyNoticeDs);
	checkNoticeDataset.load();
}
function loadAudit(){
	auditSurveyDataset.load();
	auditSurveyDataset.on('load',loadAuditNoticeDs);
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
	if( applyName == 'audit'){
		L5.getCmp("checkId").setDisabled(true);
	}
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("submitId").setDisabled(false);
	L5.getCmp("saveId").setDisabled(false);
	if( applyName == 'audit'){
		L5.getCmp("checkId").setDisabled(false);
	}
}
//保存
function save(){
	buttonDisable();
	if(!saveCheck()){
	   buttonEnabled();
	   return ;
	}
	var familyRecord=familyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveApplyCmd");
	applyDataSet.getCurrent().set("assignmentId",assignmentId);
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
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
		if(auditNoticeDataset.get('noticeResult')=='1' && _$('beginDate')!='' ){
			applyDataSet.set("beginDate",_$('beginDate'));
		}
	}
	return true;
}
//提交
function submitApply(){
	buttonDisable();
	if(!submitCheck()){
	   buttonEnabled();
	   return ;
	}
	var familyRecord=familyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveApplyCmd");
	applyDataSet.getCurrent().set("assignmentId",assignmentId);
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
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
if( applyDataSet.get("auditOpinionId") == '1' ){
		var beginDate = applyDataSet.get("beginDate");
		L5.MessageBox.confirm('确定', "你确定救助开始月份为"+beginDate+"？",function(sta){
			if(sta=="yes"){
				command.execute("sendApply");
				if (!command.error) {
					L5.Msg.alert("提示","提交成功！",function(){
						buttonEnabled();
						 returnBack();
					});		
				}else{
					L5.Msg.alert('提示',"提交时出现错误！"+command.error);
					buttonEnabled();
				}
			}else{
				buttonEnabled();
				return;
			}
		});
	}else{
		command.execute("sendApply");
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
}
//提交校验
function submitCheck(){
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
		if(checkSurveyDataset.get('surveyResult') == ''){
			L5.Msg.alert("提示","校验未通过：调查结果不能为空！");
			return false;
		}
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
		
		//如果是退回 不进行校验
		if(applyDataSet.get("auditOpinionId") == '3'){
			return true;
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
			if(applyDataSet.get("auditOpinionId") == '1'  && _$("beginDate") == ''){
				L5.Msg.alert("提示","校验未通过：救助开始月份不能为空！");
				return false;
			} else if(applyDataSet.get("auditOpinionId") == '1'  && _$("beginDate")!=''){
				applyDataSet.set("beginDate",_$('beginDate')); 
			}
		}
	}
	return true;
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
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
}
function detailexpand(){
		var width = screen.width-100;
	    var height = screen.height-340;
		var url='samFiveExpandDetail.jsp?familyId='+familyId+'&applyId='+applyId+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
function peopleDetail(peopleId){
	var width = 1000;
    var height = 423;
	var url="samBasePeopleDetail.jsp?peopleId="+peopleId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//审批结果为同意的时候，显示低保证号填写
function checkOpinion(value){
	if(value == '1'){
		document.getElementById('card1').style.display="block";
		document.getElementById('card2').style.display="block";
		document.getElementById('noCard1').style.display="none";
		document.getElementById('noCard2').style.display="none";
		document.getElementById('beginDate').value=applyDataSet.get("beginDate");
	}else{
		document.getElementById('card1').style.display="none";
		document.getElementById('card2').style.display="none";
		document.getElementById('noCard1').style.display="block";
		document.getElementById('noCard2').style.display="block";
		applyDataSet.set('beginDate','');
		applyDataSet.set('cardNo','');
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