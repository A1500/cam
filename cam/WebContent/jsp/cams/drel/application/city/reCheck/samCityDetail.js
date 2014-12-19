var familyId='';
var applyDate='';
var applyReason='';
var photoId='';
var assistanceMode='';
var assistanceMoney='';
var assistanceClassMoney='';
var assistanceClass='';
//初始化加载
function init(){
	peopleListDataSet.on("datachanged",getAverageUserArea);
	houseListDataset.on("datachanged",getAverageUserArea);
	loadCheckPanelListener();
	loadAuditPanelListener();
	
	var peoplePanel=L5.getCmp("peoplePanel");
	peoplePanel.collapse();
	//peoplePanel.on('beforeexpand',loadPanel1);//打开人员panel时候加载数据

	var estatePanel=L5.getCmp("estatePanel");
	estatePanel.collapse();
	estatePanel.on('beforeexpand',loadEstatePanel);
	
	var housePanel=L5.getCmp("housePanel");
	housePanel.collapse();
	
	/*var housePanel=L5.getCmp("housePanel");
	housePanel.collapse();
	housePanel.on('beforeexpand',loadHousePanel);*/
	
	var supportPanel=L5.getCmp("supportPanel");
	supportPanel.collapse();
	supportPanel.on('beforeexpand',loadSupportPanel);
	
	var filesPanel=L5.getCmp("filesPanel");
	filesPanel.collapse();
	filesPanel.on('beforeexpand',loadFilesPanel);
	
	applyDataSet.setParameter("APPLY_ID",applyId);
	applyDataSet.load();
	applyDataSet.on("load",function(){
		if(applyDataSet.getCount() == 1){
			//判断是否显示变更意见
			showToCheckReason(applyDataSet.get("auditOpinionId"));
			applyDate=applyDataSet.get('applyDate');
			applyReason=applyDataSet.get('applyReason');
			assistanceMode=applyDataSet.get('assistanceMode');
			assistanceMoney=applyDataSet.get('assistanceMoney');
			assistanceClassMoney=applyDataSet.get('assistanceClassMoney');
			assistanceClass=applyDataSet.get('asisstanceClass');
			
			//alert(assistanceMode+"---"+assistanceMoney+"---"+assistanceClassMoney+"---"+assistanceClass);
			
			familyId=applyDataSet.get('familyId');
			loadFamilyDs();//加载家庭
			var auditId=applyDataSet.get('auditOpinionId');
			if(method=="handle"){
				//toChangeEdit();//把救助相关的4项改成可编辑
				//toChangeDetail();//把救助相关的4项改成不可编辑
				/*if(assistanceMode == '10'){//如果是补差，不可以编辑户月保障金
					document.getElementById("assistanceMoney").style.display="none";
					document.getElementById("assistanceMoneyL").style.display="block";
				}*/
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
					
					/*if(assistanceMode == '10'){//如果是补差，不可以编辑户月保障金
						document.getElementById("assistanceMoney").style.display="none";
						document.getElementById("assistanceMoneyL").style.display="block";
					}else{
						document.getElementById("assistanceMoney").style.display="block";
						document.getElementById("assistanceMoneyL").style.display="none";
					}*/
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
				//toChangeDetail();//把救助相关的4项改成不可编辑
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
		countTotle();
		
		
	});
	
	//加载分类施保类别字典
	var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='01' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//城市低保
    asisstanceClassDataset.load();
	//家庭加载的时候把业务表的相关字段放入家庭表里
	familyDataSet.on('load',function(){
		if(familyDataSet.getCount() == 1){
			familyDataSet.set('applyReason',applyReason);
			familyDataSet.set('applyDate',applyDate);
			familyDataSet.set('assistanceMode',assistanceMode);
			familyDataSet.set('assistanceMoney',assistanceMoney);
			familyDataSet.set('assistanceClassMoney',assistanceClassMoney);
			familyDataSet.set('assistanceClass',assistanceClass);
			countTotle();
			photoId=familyDataSet.get("photoId");
			showPhotoAbleEdit(photoId);//加载照片
		}
	});
	checkSurveyDataset.on('load',function(){
		if(checkSurveyDataset.getCount() == 0){
			checkSurveyDataset.newRecord({"activityId":"check"});
		}
	});
	acceptDiscussionDataset.on('load',function(){
		if(acceptDiscussionDataset.getCount() == 0){
			acceptDiscussionDataset.newRecord({"activityId":"check"});
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
			var familyRecord=familyDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.drel.application.comm.cmd.SamApplyFromEnsureyCmd");
			command.setParameter("applyId",applyId);
			command.setParameter("familyId",familyId);
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
    familyDataSet.on("load",loadPanel1);
}

//打开人员列表时加载人员信息
function loadPanel1(ds){
	ds.un("load",loadPanel1);
	peopleListDataSet.setParameter("FAMILY_ID",familyId);
	peopleListDataSet.on("load",loadHousePanel);
	peopleListDataSet.load();
}
//加载房产信息
function loadHousePanel(ds){
	ds.un("load",loadHousePanel);
  	houseListDataset.setParameter("FAMILY_ID",familyId);
  	houseListDataset.load();	
}
//加载财产信息
function loadEstatePanel(){
	 estateListDataset.setParameter("FAMILY_ID",familyId);
	 estateListDataset.load();	 
}
//加载抚养人信息
function loadSupportPanel(){
	supportListDataset.setParameter("FAMILY_ID",familyId);
	supportListDataset.load();
	 
}
//加载申请材料信息
function loadFilesPanel(){
	 if(applyId != ''){
	    	filesListDataset.setParameter("APPLY_ID",applyId);
	    	filesListDataset.setParameter("FILE_TYPE@IN","101,102,201,202,203,204,205,206,207,208,209,210,301,001,000");
			filesListDataset.load();
	  }	 
}
function getAverageUserArea(){
	var familyNo=1;//家庭人口数，用来计算人均项
	var HouseArea=0;//家庭房产面积
	var averageArea = 0;
	var peopleListDs = L5.DatasetMgr.lookup("peopleListDataSet");
	var houseListDs = L5.DatasetMgr.lookup("houseListDataset");
	familyNo = peopleListDs.getTotalCount();
	if(houseListDs.getCount()>0){
		houseListDs.each(function(record,index){
			HouseArea+=parseInt(record.get("useArea"));
		});
		averageArea = HouseArea/familyNo;
		
	}
	if(!isNaN(averageArea)){
		$("averageArea").innerHTML=averageArea;
	}else{
		$("averageArea").innerHTML=0;
	}
}
function loadCheckPanelListener(){
	
	checkSurveyDataset.on("load",loadacceptDiscussionDataset);
	checkSurveyDataset.on("load",loadcheckSurvey);
	
	acceptDiscussionDataset.on("load",loadcheckNoticeDataset);
	acceptDiscussionDataset.on("load",loadacceptDiscussion);
	
	checkNoticeDataset.on("load",loadcheckNotice);		
}
//加载审核信息
function loadCheck(){
	
	checkSurveyDataset.load();
}
//加载审核民主评议
function loadacceptDiscussionDataset(ds){
	ds.un("load",loadacceptDiscussionDataset);
	acceptDiscussionDataset.load();
}
//加载审核公示
function loadcheckNoticeDataset(ds){
	ds.un("load",loadcheckNoticeDataset);
	checkNoticeDataset.load();
}

//加载审核入户调查上传文件
function loadcheckSurvey(ds){
	ds.un("load",loadcheckSurvey);
	checkruhuFileDs.setParameter("APPLY_ID",applyId);
	checkruhuFileDs.setParameter("FILE_TYPE","CRH");
	checkruhuFileDs.on("load",function(ds){
		loadCheckFile(ds,"CRH");
	});
 	checkruhuFileDs.load();
}
//加载审核民主评议上传文件
function loadacceptDiscussion(ds){
	ds.un("load",loadacceptDiscussion);
	checkpingyiFileDs.setParameter("APPLY_ID",applyId);
	checkpingyiFileDs.setParameter("FILE_TYPE","CPY");
	checkpingyiFileDs.on("load",function(ds){
		loadCheckFile(ds,"CPY");
	});
 	checkpingyiFileDs.load();
}
//加载审核公示上传文件
function loadcheckNotice(ds){
	ds.un("load",loadcheckNotice);
	checkDisNoticeFileDs.setParameter("APPLY_ID",applyId);
	checkDisNoticeFileDs.setParameter("FILE_TYPE","CGS");
	checkDisNoticeFileDs.on("load",function(ds){
		loadCheckFile(ds,"CGS");
	});
 	checkDisNoticeFileDs.load();
}
function loadAuditPanelListener(){

	auditSurveyDataset.on("load",loadauditNoticeDs);
	auditSurveyDataset.on("load",loadauditruhuFiles);	
	auditNoticeDataset.on("load",loadAuditDisNoticeFileDs);
	
}
//加载审批信息
function loadAudit(){
	auditSurveyDataset.load();
}

//加载审批公示结果
function loadauditNoticeDs(ds){	
 	ds.un("load",loadauditNoticeDs); 	
	auditNoticeDataset.load();	
}
function loadauditruhuFiles(ds){
	ds.un("load",loadauditruhuFiles);
	auditruhuFileDs.setParameter("APPLY_ID",applyId);
	auditruhuFileDs.setParameter("FILE_TYPE","ARH");
	auditruhuFileDs.on("load",function(ds){
		loadCheckFile(ds,"ARH");
	});
	auditruhuFileDs.load();

}
//加载审批公示异议上传文件
function loadAuditDisNoticeFileDs(ds){
    ds.un("load",loadAuditDisNoticeFileDs);
    
	auditDisNoticeFileDs.setParameter("APPLY_ID",applyId);
	auditDisNoticeFileDs.setParameter("FILE_TYPE","AGS");
	auditDisNoticeFileDs.on("load",function(ds){
		loadCheckFile(ds,"AGS");
	});
 	auditDisNoticeFileDs.load();
}
//审批公示异议文件加载,方法名又取重复了
function loadAuditDisNoticeFileDs_(ds){
 	
}


//按钮禁用
function buttonDisable(){
	L5.getCmp("submitId").setDisabled(true);
	L5.getCmp("saveId").setDisabled(true);
	/*if( applyName == 'audit'){
		L5.getCmp("checkId").setDisabled(true);
	}*/
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("submitId").setDisabled(false);
	L5.getCmp("saveId").setDisabled(false);
	/*if( applyName == 'audit'){
		L5.getCmp("checkId").setDisabled(false);
	}*/
}
//保存
function save(){
	buttonDisable();
	if(!saveCheck()){
	   buttonEnabled();
	   return ;
	}
	
	var familyRecord=familyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
	applyDataSet.getCurrent().set("assignmentId",assignmentId);
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	if(applyName=="check"){
		command.setParameter("acceptDiscussionRecord",acceptDiscussionDataset.getAllRecords());
		command.setParameter("surveyRecord",checkSurveyDataset.getCurrent());
		command.setParameter("noticeRecord",checkNoticeDataset.getCurrent());
	}else if(applyName=="audit"){
		command.setParameter("surveyRecord",auditSurveyDataset.getCurrent());
		command.setParameter("noticeRecord",auditNoticeDataset.getCurrent());
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
	return true;
	var familyIsValidate = familyDataSet.isValidate();
	if(familyIsValidate != true){
		L5.Msg.alert("提示",familyIsValidate);
		return false;
	}
	
	if(applyName=="check"){
		
		var checkSurveyDatasetIsValidate = checkSurveyDataset.isValidate();
		if(checkSurveyDatasetIsValidate != true){
			L5.Msg.alert("提示",checkSurveyDatasetIsValidate);
			return false;
		}
		if(applyDataSet.get("checkOpinionId") == '' ){
			L5.Msg.alert("提示","校验未通过：审核结果不能为空！");
			return false;
		}
	}else if(applyName=="audit"){		
		var auditSurveyDatasetIsValidate = auditSurveyDataset.isValidate();
		if(auditSurveyDatasetIsValidate != true){
			L5.Msg.alert("提示",auditSurveyDatasetIsValidate);
			return false;
		}
		if(applyDataSet.get("auditOpinionId") == '' ){
			L5.Msg.alert("提示","校验未通过：审批结果不能为空！");
			return false;
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
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
	applyDataSet.getCurrent().set("assignmentId",assignmentId);	
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	command.setParameter("assignmentId",assignmentId);
	if(applyName=="check"){
		command.setParameter("surveyRecord",checkSurveyDataset.getCurrent());
	
	}else if(applyName=="audit"){
		command.setParameter("surveyRecord",auditSurveyDataset.getCurrent());
		
	}
	if( applyDataSet.get("auditOpinionId") == '1' ){
			command.execute("submitApplyFromRecheck");
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
		command.execute("submitApplyFromRecheck");
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
	return true;
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
		if(checkSurveyDataset.get('surveyResult') == '0' &&applyDataSet.get("checkOpinionId") == '1' ){
			L5.Msg.alert("提示","入户调查结果不属实,不能通过审核");
			return false;
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
			if(auditSurveyDataset.get('surveyResult') == '0' &&auditSurveyDataset.get('auditOpinionId')== '1'){
				L5.Msg.alert("提示","校验未通过：入户调查不属实，审批不通过！");
				return false;
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
//加载照片
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
}
//查看家庭明细
function detailexpand(){
		var width = screen.width-100;
	    var height = screen.height-340;
		var url='samCityExpandDetail.jsp?familyId='+familyId+'&applyId='+applyId+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//查看特定人员的明细
function peopleDetail(peopleId){
	var width = 1000;
    var height = 600;
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
/*//把救助相关的4项改成不可编辑
function toChangeDetail(){
	document.getElementById("assistanceMoney").style.display="none";
	document.getElementById("asisstanceClass").style.display="none";
	document.getElementById("assistanceClassMoney").style.display="none";
	
	document.getElementById("assistanceMoneyL").style.display="block";
	document.getElementById("asisstanceClassL").style.display="block";
	document.getElementById("assistanceClassMoneyL").style.display="block";
}
//把救助相关的4项改成可编辑
function toChangeEdit(){
	document.getElementById("assistanceMoney").style.display="block";
	document.getElementById("asisstanceClass").style.display="block";
	document.getElementById("assistanceClassMoney").style.display="block";
	
	document.getElementById("assistanceMoneyL").style.display="none";
	document.getElementById("asisstanceClassL").style.display="none";
	document.getElementById("assistanceClassMoneyL").style.display="none";
}*/
//把救助相关的4项改成不可编辑
function toChangeDetail(){
//	if( applyName == 'check'){
	//救助金计算方式
	document.getElementById("assistanceModeName").style.display="none";
	document.getElementById("assistanceMode").style.display="none";
	document.getElementById("assistanceModeL").style.display="none";
	//户月保障金
	document.getElementById("assistanceMoneyName").style.display="none";
	document.getElementById("assistanceMoney").style.display="none";
	document.getElementById("assistanceMoneyL").style.display="none";

	//低保金加发类别
	document.getElementById("asisstanceClassName").style.display="none";
	document.getElementById("asisstanceClass").style.display="none";
	document.getElementById("asisstanceClassL").style.display="none";


	//低保金加发金额
	document.getElementById("assistanceClassMoneyName").style.display="none";
	document.getElementById("assistanceClassMoney").style.display="none";
	document.getElementById("assistanceClassMoneyL").style.display="none";
	
	//总计	
	document.getElementById("totalMoneyName").style.display="none";
	document.getElementById("totalMoneyL").style.display="none";
	document.getElementById("totalMoneyNamenull").style.display="none";
	document.getElementById("totalMoneyLnull").style.display="none";
		
}
//把救助相关的4项改成可编辑
function toChangeEdit(){
	if( applyName == 'check'){
		//救助金计算方式
		document.getElementById("assistanceModeName").style.display="none";
		document.getElementById("assistanceMode").style.display="none";
		document.getElementById("assistanceModeL").style.display="none";
		
		//户月保障金
		document.getElementById("assistanceMoneyName").style.display="none";
		document.getElementById("assistanceMoney").style.display="none";
		document.getElementById("assistanceMoneyL").style.display="none";

		//低保金加发类别
		document.getElementById("asisstanceClassName").style.display="none";
		document.getElementById("asisstanceClass").style.display="none";
		document.getElementById("asisstanceClassL").style.display="none";


		//低保金加发金额
		document.getElementById("assistanceClassMoneyName").style.display="none";
		document.getElementById("assistanceClassMoney").style.display="none";
		document.getElementById("assistanceClassMoneyL").style.display="none";
		
		//总计	
		document.getElementById("totalMoneyName").style.display="none";
		document.getElementById("totalMoneyL").style.display="none";
		document.getElementById("totalMoneyNamenull").style.display="none";
		document.getElementById("totalMoneyLnull").style.display="none";
		
		}else if (applyName == 'audit'){
			//救助金计算方式
			document.getElementById("assistanceModeName").style.display="block";
			document.getElementById("assistanceMode").style.display="block";
			document.getElementById("assistanceModeL").style.display="none";
			//户月保障金
			document.getElementById("assistanceMoneyName").style.display="block";
			document.getElementById("assistanceMoney").style.display="none";
			document.getElementById("assistanceMoneyL").style.display="block";

			//低保金加发类别
			document.getElementById("asisstanceClassName").style.display="block";
			document.getElementById("asisstanceClass").style.display="block";
			document.getElementById("asisstanceClassL").style.display="none";


			//低保金加发金额
			document.getElementById("assistanceClassMoneyName").style.display="block";
			document.getElementById("assistanceClassMoney").style.display="none";
			document.getElementById("assistanceClassMoneyL").style.display="block";
			
			//总计	
			document.getElementById("totalMoneyName").style.display="block";
			document.getElementById("totalMoneyL").style.display="block";
			document.getElementById("totalMoneyNamenull").style.display="block";
			document.getElementById("totalMoneyLnull").style.display="block";
		}
}
//明细
function getName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href=# onclick="peopleDetail(\''+record.get("PEOPLE_ID")+'\')">'+value+'</a>';
}
//计算合计（户月保障金+分类施保金）
function countTotle(){
	var value =document.getElementById("assistanceModeID").innerHTML;
	var assMoney=0;
	var asClassMoney=0;
	if(method=="detail"){
		assMoney=document.getElementById("assistanceMoneyID1").innerHTML;
		asClassMoney=document.getElementById("assistanceClassMoneyID1").innerHTML;
	}else if(method=="handle"){
		if(value == '10'){
			assMoney=document.getElementById("assistanceMoneyID1").innerHTML;
		}else{
			assMoney=document.getElementById("assistanceMoneyID").value;
		}
		asClassMoney=document.getElementById("assistanceClassMoneyID").value;
	}
	var totalnum=parseFloat(nullToZero(assMoney))+parseFloat(nullToZero(asClassMoney));
	document.getElementById("totalMoney").innerHTML=totalnum;
}

//调查结果为不属实，填写备注录入
function checkOpinioncheck(value){
	if(value == '0'){
		showDom('checkbeizhuhang');
	}else{
		hideDom('checkbeizhuhang');
		checkSurveyDataset.set('surveyContents','');
	}
}
//调查结果为不属实，填写备注录入
function checkOpinionaudit(value){
	if(value == '0'){
		showDom('auditbeizhuhang');
	}else{
		hideDom('auditbeizhuhang');
		auditSurveyDataset.set('surveyContents','');
	}
}
//调查结果为不属实，展示备注录入,checkDetailPanel
function showChecknotMsg(ds){
	var surveyResult =ds.get("surveyResult");
	if(surveyResult=='0'){
		showDom('checkbeizhuhang');
	}
	else{	
	}
}
//调查结果为不属实，展示备注录入,auditDetailPanel
function showAuditnotMsg(ds){	
	var surveyResult =ds.get("surveyResult");
	if(surveyResult=='0'){
		showDom('auditbeizhuhang');
	}
	else{
	}
}
function showDom(id){
	document.getElementById(id).style.display="block";
}
function hideDom(id){
	document.getElementById(id).style.display="none";
}
//公示结果为不属实，展示异议详情，checkEditPanel
function checknoticeResult(value){	
	if(value == '0'){
		showDom('yiyihangcheck');
		showDom('wenjianhangcheck');
		
	}else{
		hideDom('yiyihangcheck');
		hideDom('wenjianhangcheck');
		checkNoticeDataset.set('noticeDisDetail','');
	}
}
//公示结果为不属实，展示异议详情，auditEditPanel
function checkAuditnoticeResult(value){
	
	if(value == '0'){
		showDom('yiyihangAudit');
		showDom('wenjianhangAudit');
		
	}else{
		hideDom('yiyihangAudit');
		hideDom('wenjianhangAudit');
		auditNoticeDataset.set('noticeDisDetail','');
	}
}
//公示结果为不属实，展示备注录入,checkDetailPanel
function showCheckGSnotMsg(ds){
	var value =ds.getCurrent().get("noticeResult");
	if(value == '0'){
		showDom('yiyihangcheck');
		showDom('wenjianhangcheck');
		
	}else{
		hideDom('yiyihangcheck');
		hideDom('wenjianhangcheck');
	}
	
}
//公示结果为不属实，展示备注录入,auditDetailPanel
function showAuditGSnotMsg(ds){
	var value =ds.getCurrent().get("noticeResult");
	if(value == '0'){
		showDom('yiyihangAudit');
		showDom('wenjianhangAudit');
		
	}else{
		hideDom('yiyihangAudit');
		hideDom('wenjianhangAudit');
	}
}
//审核、审批结果不同意继续救助时，显示转到变更的理由
function showToCheckReason(value){	
	if(value=='0'){
		document.getElementById('toChangeReasonTr').style.display="block";
			
	}
	else{	
		document.getElementById('toChangeReasonTr').style.display="none";
//		applyDataSet.set("toChangeReason","");	
	}
}
//选择分类施保类别之后自动回填分类施保金
function getClassMoney(value){
	var command = new L5.Command("com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassCmd");
	command.setParameter("classCode",value);
	command.setParameter("organArea",organArea.substring(0,6) + "000000");
	command.setParameter("nowTime",nowTime);
	command.setParameter("assistanceType","01");
	command.execute("getClassMoney");
	var classMoney=command.getReturn('classMoney');
	familyDataSet.set("assistanceClassMoney",classMoney);
	countTotle();
}
function countDiscussionNum(){
	var total=document.getElementById('total').value ;
	var agreeNum= document.getElementById('agreeNum').value ;
	if(total == '' || agreeNum == '' ){
		return;
	}
	if(parseInt(total) - parseInt(agreeNum) < 0){
		L5.Msg.alert("提示","评议总人数不得小于同意人数！");
		acceptDiscussionDataset.set('total','');
		acceptDiscussionDataset.set('agreeNum','');
		acceptDiscussionDataset.set('disagreeNum','');
		return;
	}
	var disagreeNum = parseInt(total) - parseInt(agreeNum);
	acceptDiscussionDataset.set('disagreeNum',disagreeNum);
}
/*
	当救助金计算方式为补差的时候，自动计算户月保障金
*/
function countAssistanceMoney(value){
	
		if(applyName=="check"){
			return;
		}
		
		if(value == '10'){
		if( applyId!='' && familyId!='' ){
			
			document.getElementById("assistanceMoney").style.display="none";
			document.getElementById("assistanceMoneyL").style.display="block";
			
			document.getElementById("assistanceMoneyID").style.display = 'none';
			document.getElementById("assistanceMoneyID1").style.display = 'block';
			
			var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
			command.setParameter("applyId",applyId);
			command.setParameter("familyId",familyId);
			command.execute("getAssistanceMoney");
			var assmon=command.getReturn('assistanceMoney');
			if(assmon < 0){
				assmon=0;
			}
			familyDataSet.set("assistanceMoney",assmon); 
		}

	}else{
		document.getElementById("assistanceMoney").style.display="block";
		document.getElementById("assistanceMoneyL").style.display="none";
		document.getElementById("assistanceMoneyID").style.display = 'block';
		document.getElementById("assistanceMoneyID1").style.display = 'none';
	}
	countTotle();
}
//计算合计（户月保障金+分类施保金）
function countTotle(){
	var value =document.getElementById("assistanceModeID").value;
	var assMoney=0;
	if(value == '10'){
		assMoney=document.getElementById("assistanceMoneyID1").innerHTML;
	}else{
		assMoney=document.getElementById("assistanceMoneyID").value;
	}
	var asClassMoney=document.getElementById("assistanceClassMoneyID").value;
	var totalnum=parseFloat(nullToZero(assMoney))+parseFloat(nullToZero(asClassMoney));
	document.getElementById("totalMoney").innerHTML=totalnum;
}
//选择分类施保类别之后自动回填分类施保金
function getClassMoney(value){
	var command = new L5.Command("com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassCmd");
	command.setParameter("classCode",value);
	command.setParameter("organArea",organArea.substring(0,6) + "000000");
	command.setParameter("nowTime",nowTime);
	command.setParameter("assistanceType","01");
	command.execute("getClassMoney");
	var classMoney=command.getReturn('classMoney');
	familyDataSet.set("assistanceClassMoney",classMoney);
	countTotle();
	
}

//下载申请证明材料
function downloadFile(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("applyFileId");
	if(record.get('fileName')){
	    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+id+"'";
		return '<a id="download"  href='+url0+'>'+record.get('fileName')+'</a>';
	}else{
		return '';
	}
}