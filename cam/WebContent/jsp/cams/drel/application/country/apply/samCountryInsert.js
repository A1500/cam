var familyId='';
var applyDate='';
var applyReason='';
var photoId='';
var familySex='';
var assistanceMode='';
var assistanceMoney='';
var assistanceClassMoney='';
var assistanceClass='';
var organCode='';
var fullName='';
function init(){
	if(method=="insert"){
		//加载分类施保类别字典
		var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
	    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='02' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//农村低保
	    asisstanceClassDataset.load();
		prepareForInsert();//新增页面的加载页面
	}else{
		loadInfo();//修改时加载页面
	}
	if(ActivityName == "check"){
		opinionDataSet.filterBy(function(record, id){
			if("3" !=record.get('value') ){
				return record;
			}
		});
	}
	surveyFileDataset.on("load",loadSurveyFile);
	discussionFileDataset.on("load",loadDiscussionFile);
	noticeFileDataset.on("load",loadNoticeFile);
}
//调查结果文件加载
function loadSurveyFile(ds){
 	loadCheckFile(ds,"DC");
}
//评议文件加载
function loadDiscussionFile(ds){
 	loadCheckFile(ds,"PY");
}
//公示结果文件加载
function loadNoticeFile(ds){
 	loadCheckFile(ds,"GS");
}
//新增页面的加载页面
function prepareForInsert(){
	//移除审核审批意见的panel
	var tab=L5.getCmp("tab");
	applyDataSet.newRecord({"isFinish":"0"});
	if(ActivityName == "check"){
		familyDataSet.newRecord({"assistanceMode":"21","applyDate":nowTime,"address":address,"regId":regId,"regOrg":regOrg,"regOrgName":regOrgName,"regPeople":regPeople,"regTime":regTime,"regOrgType":regOrgType,"apanageName":organName,"apanageCode":organArea});
	
		checkNoticeDataset.newRecord({"activityId":"check"});
		checkSurveyDataset.newRecord({"activityId":"check"});
	}else{
		familyDataSet.newRecord({"domicileName":organName,"domicileCode":organArea,"assistanceMode":"21","applyDate":nowTime,"address":address,"regId":regId,"regOrg":regOrg,"regOrgName":regOrgName,"regPeople":regPeople,"regTime":regTime,"regOrgType":regOrgType,"apanageName":organName,"apanageCode":organArea});
		var checkEditPanel=L5.getCmp("checkEditPanel");
		tab.remove(checkEditPanel);
	}
	bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"02"});
	applyDataSet.newRecord({"isFinish":"0"});
	acceptSurveyDataset.newRecord({"activityId":"accept"});
	acceptDiscussionDataset.newRecord({"activityId":"accept"});
	acceptNoticeDataset.newRecord({"activityId":"accept"});
	var checkDetailPanel=L5.getCmp("checkDetailPanel");
	tab.remove(checkDetailPanel);
	var auditDetailPanel=L5.getCmp("auditDetailPanel");
	tab.remove(auditDetailPanel);
	
	buttonDisable();
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("submitId").setDisabled(true);
	L5.getCmp("peopleAdd").setDisabled(true);
	L5.getCmp("houseAdd").setDisabled(true);
	L5.getCmp("estateAdd").setDisabled(true);
	L5.getCmp("supportAdd").setDisabled(true);
	L5.getCmp("filesUpload").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("submitId").setDisabled(false);
	L5.getCmp("peopleAdd").setDisabled(false);
	L5.getCmp("houseAdd").setDisabled(false);
	L5.getCmp("estateAdd").setDisabled(false);
	L5.getCmp("supportAdd").setDisabled(false);
	L5.getCmp("filesUpload").setDisabled(false);
	L5.getCmp("saveId").setDisabled(false);
}
//修改时加载页面
function loadInfo(){
	applyDataSet.setParameter("APPLY_ID",applyId);
	applyDataSet.load();
	applyDataSet.on("load",loadApplyInfo);
}
//加载业务表完成之后的操作
function loadApplyInfo(ds){
	if(ds.getCount() == 1){
		applyDate=ds.get('applyDate');
		applyReason=ds.get('applyReason');
		assistanceMode=ds.get('assistanceMode');
		assistanceMoney=ds.get('assistanceMoney');
		assistanceClassMoney=ds.get('assistanceClassMoney');
		assistanceClass=ds.get('asisstanceClass');
		familyId=ds.get('familyId');
		loadAsisstanceClass();//加载分类施保类别字典
		decideDef(ds);//判断环节相应显示审核审批意见
	}
}
//判断环节相应显示审核审批意见
function decideDef(ds){
	var tab=L5.getCmp("tab");
	var checkId=ds.get('checkOpinionId'); 
	var auditId=ds.get('auditOpinionId'); 
	if(auditId == ''){
		if(checkId == ''){//正常的进入修改页面
			var checkDetailPanel=L5.getCmp("checkDetailPanel");
			tab.remove(checkDetailPanel);
			var auditDetailPanel=L5.getCmp("auditDetailPanel");
			tab.remove(auditDetailPanel);
			if(ActivityName != "check"){
				var checkEditPanel=L5.getCmp("checkEditPanel");
				tab.remove(checkEditPanel);
			}
		}else{//审核回退
			if(ActivityName == "check"){
				var checkDetailPanel=L5.getCmp("checkDetailPanel");
				tab.remove(checkDetailPanel);
				var auditDetailPanel=L5.getCmp("auditDetailPanel");
				tab.remove(auditDetailPanel);
			}else{
				var auditDetailPanel=L5.getCmp("auditDetailPanel");
				tab.remove(auditDetailPanel);
				var checkDetailPanel=L5.getCmp("checkDetailPanel");
				checkDetailPanel.collapse();
				checkDetailPanel.on('beforeexpand',loadCheck);
				var checkEditPanel=L5.getCmp("checkEditPanel");
				tab.remove(checkEditPanel);
			}
		}
	}else{//审批回退
		if(ActivityName == "check"){
			var checkDetailPanel=L5.getCmp("checkDetailPanel");
			tab.remove(checkDetailPanel);
			var auditDetailPanel=L5.getCmp("auditDetailPanel");
			auditDetailPanel.collapse();
			auditDetailPanel.on('beforeexpand',loadAudit);
		}else{
			var checkDetailPanel=L5.getCmp("checkDetailPanel");
			checkDetailPanel.collapse();
			checkDetailPanel.on('beforeexpand',loadCheck);
			var auditDetailPanel=L5.getCmp("auditDetailPanel");
			auditDetailPanel.collapse();
			auditDetailPanel.on('beforeexpand',loadAudit);
			var checkEditPanel=L5.getCmp("checkEditPanel");
			tab.remove(checkEditPanel);
		}
	}
}
//加载分类施保类别字典
function loadAsisstanceClass(){
	//加载分类施保类别字典
	var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
	asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='02' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//农村低保
	asisstanceClassDataset.load();
	asisstanceClassDataset.on('load',loadFamilyDs);
}
//加载家庭信息
function loadFamilyDs(ds){
	ds.un("load",loadFamilyDs);
    familyDataSet.setParameter("FAMILY_ID",familyId);
  	 familyDataSet.on("load",loadBank);
    familyDataSet.load();
}
function loadBank(ds){
	if(ds.getCount() == 1){
		ds.set('applyReason',applyReason);
		ds.set('applyDate',applyDate);
		ds.set('assistanceMode',assistanceMode);
		ds.set('assistanceMoney',assistanceMoney);
		ds.set('assistanceClassMoney',assistanceClassMoney);
		ds.set('assistanceClass',assistanceClass);
		if(ActivityName != "check"){
			ds.set("domicileCode",organArea);
			ds.set("domicileName",organName);
		}
		photoId=ds.get("photoId");
		showPhotoAbleEdit(photoId);//加载照片
		countTotle();
	}
	countTotle();
	ds.un("load",loadBank);
  	bankAccountDS.setParameter("FAMILY_ID",familyId);
    bankAccountDS.on("load",loadPeopleListDs);
    bankAccountDS.load();
}
//加载家庭成员基本信息
function loadPeopleListDs(ds){
	if(ds.getCount() == 0 ){
		bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"02"});
	}
	ds.un("load",loadPeopleListDs);
  	peopleListDataSet.setParameter("FAMILY_ID",familyId);
	peopleListDataSet.load();
    peopleListDataSet.on("load",loadSupportedPeopleDs);
}
//加载被赡（抚、扶）养人
function loadSupportedPeopleDs(ds){
    ds.un("load",loadSupportedPeopleDs);
    ds.each(function(record, index){
		if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
			familySex=record.get('SEX');			
			return;
		}
	});
	var supportedPeopleDataSet = L5.DatasetMgr.lookup("supportedPeopleDataSet");
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ID='" + familyId + "'");
    supportedPeopleDataSet.load();
    supportedPeopleDataSet.on("load",loadHouseDs);
}
//加载房产信息
function loadHouseDs(ds){
    ds.un("load",loadHouseDs);
  	houseListDataset.setParameter("FAMILY_ID",familyId);
	houseListDataset.load();
    houseListDataset.on("load",loadEstateDs);
}
//加载财产信息
function loadEstateDs(ds){
     ds.un("load",loadEstateDs);
  	estateListDataset.setParameter("FAMILY_ID",familyId);
	estateListDataset.load();
    estateListDataset.on("load",loadSupportDs);
}
//加载赡养人员信息
function loadSupportDs(ds){
    ds.un("load",loadSupportDs);
 	supportListDataset.setParameter("FAMILY_ID",familyId);
	supportListDataset.load();
    supportListDataset.on("load",loadFilesListDs);
}
//加载申请材料信息
function loadFilesListDs(ds){
     ds.un("load",loadFilesListDs);
    if(applyId != ''){
    	ArchCatalogDS.setParameter("applyType","020");
		ArchCatalogDS.setParameter("sysType","sam");
		ArchCatalogDS.setParameter("applyId",applyId);
		ArchCatalogDS.load();
		ArchCatalogDS.on("load",loadAcceptSurveyDs);
    }
}
//加载入户调查信息
function loadAcceptSurveyDs(ds){
    ds.un("load",loadAcceptSurveyDs);
     ds.filterBy(function(record, id){
			//函数内部执行的操作写在这里
			var  pageSize =record.get("PAGE_SIZE");
			if(pageSize!=""&&parseInt(pageSize)!=0){
				return true ;
			}else{
				return false ;
			}
		});
 	acceptSurveyDataset.load();
    acceptSurveyDataset.on("load",loadAcceptDis);
}
function loadAcceptDis(ds){
 	ds.un("load",loadAcceptDis);
    acceptDiscussionDataset.load();
    acceptDiscussionDataset.on("load",loadAcceptNoticeDs);
}
//加载公告信息
function loadAcceptNoticeDs(ds){
    ds.un("load",loadAcceptNoticeDs);
 	acceptNoticeDataset.load();
 	acceptNoticeDataset.on("load",loadFromCheck);
}
//判断是不是审核受理
function loadFromCheck(ds){
    ds.un("load",loadFromCheck);
    
 	if(ActivityName == "check"){
 		loadCheck();
 	}
}
//加载审核信息
function loadCheck(){
	checkSurveyDataset.load();
	checkSurveyDataset.on("load",loadcheckSurveyDs);
}
//加载审核评议结果
function loadcheckSurveyDs(ds){
 	ds.un("load",loadcheckSurveyDs);
	checkNoticeDataset.load();
}
//加载审批信息
function loadAudit(){
	auditSurveyDataset.load();
	auditSurveyDataset.on("load",loadauditNoticeDs);
	
}
//加载审批评议结果
function loadauditNoticeDs(ds){
 	ds.un("load",loadauditNoticeDs);
	auditNoticeDataset.load();
}
//校验身份证
function checkCradNo(obj){
	var cardNo=obj.value;
	if(cardNo==''){
		return false;
	}
	if(checkIDCard(obj) != true && !(cardNo.length==18 && cardNo.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		obj.value='';
		return false;
	}else{
		cardNo=obj.value;
		//相应操作
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
		command.setParameter("cardNo",cardNo);
		command.execute("checkIDCard");
		var errorFlag=command.getReturn("errorFlag");
		var returnFamilyId=command.getReturn("familyId");
		var personalStatsTag=command.getReturn("personalStatsTag");
		var peopleId=command.getReturn("peopleId");
		if(errorFlag != '' && typeof(errorFlag)!="undefined" && errorFlag!=null && errorFlag =='errorFlag'){
			L5.Msg.alert("提示","校验过程中发生异常,请重试!");
				obj.value='';
				return false;
		}else if(errorFlag != '' && typeof(errorFlag)!="undefined" && errorFlag!=null){//有此人享有其他待遇的提示
			if(personalStatsTag=='01'){
				L5.Msg.alert("提示",errorFlag);
				obj.value='';
				return false;
			}else if(personalStatsTag=='03'){//死亡
				L5.Msg.alert("提示","该人员已死亡！");
				obj.value='';
				return false;
			}else if(personalStatsTag=='06'){//分户迁出
			  	peopleListDataSet.setParameter("PEOPLE_ID",peopleId);
				peopleListDataSet.load();
				peopleListDataSet.on('load',loadPeopleListDataSet);
			}else{
			  	L5.MessageBox.confirm('提示', errorFlag.substring(0,2)+'所在家庭'+errorFlag.substring(2)+'，是否把该人员从原来家庭中分离出来？',function(sta){
					if(sta=="yes"){
					  	L5.MessageBox.confirm('提示','该人员状态为'+getDicText(samPersonalStatsDataSet,personalStatsTag)+'，确定要提取该人员信息吗？',function(sta_tq){
							if(sta_tq=="yes"){
							  	peopleListDataSet.setParameter("PEOPLE_ID",peopleId);
								peopleListDataSet.load();
								peopleListDataSet.on('load',loadPeopleListDataSet);
							}else{
								obj.value='';
								return false;
							}
						});	
					}else{
						obj.value='';
						return false;
					}
				});	
			}
		}else{
			if(returnFamilyId != '' && typeof(returnFamilyId)!="undefined" && returnFamilyId!=null){
				familyId=returnFamilyId;
				familyDataSet.setParameter("FAMILY_ID",familyId);
			    familyDataSet.on("load",loadPeopleListDs);
			    familyDataSet.load();
			     applyId="null";
			}
		}
	}
}
//加载人员
function loadPeopleListDataSet(ds){
    ds.un("load",loadPeopleListDataSet);
	familyDataSet.set("familyName",ds.get('NAME'));
}
//保存
function save(){
	familyDataSet.set('domicileCode',document.getElementById('lrdwId').value);
	var obj = document.getElementById("familyCardNo");
	buttonDisable();
	L5.getCmp("saveId").setDisabled(true);
	if(!saveCheck()){
	  	L5.getCmp("saveId").setDisabled(false);
	   return ;
	}
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	//判断是初次保存还是多次保存
	if( applyRecord.get("applyId") == '' ||  applyRecord.get("applyId")== 'null'){
		//初次保存的，校验身份证号合法性、是否在办理业务
		if(checkCradNo(obj)==false){
			return;
		}
	}
	//处理多选
	var inputs=_$("assistanceType").split(','); 
	AssistanceDataset.removeAll();
	if(inputs[0]){
		for(var i=0;i<inputs.length;i++){
		  	AssistanceDataset.newRecord({"assistanceType":inputs[i]});
		}  
	}
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryApplyCmd");
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	applyRecord.set("assignmentId",assignmentId);
	command.setParameter("applyRecord",applyRecord);
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	familyRecord.set("photoId",photoId);//维护照片信息
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("AssistanceRecords",AssistanceDataset.getAllRecords());
	command.setParameter("acceptSurveyRecord",acceptSurveyDataset.getAllRecords());
	command.setParameter("acceptDiscussionRecord",acceptDiscussionDataset.getAllRecords());
	command.setParameter("acceptNoticeRecord",acceptNoticeDataset.getAllRecords());
	command.setParameter("bankAccount",bankAccountDS.getCurrent());	
	if(ActivityName == "check"){
		command.setParameter("surveyRecord",checkSurveyDataset.getCurrent());
		command.setParameter("noticeRecord",checkNoticeDataset.getCurrent());
		if( applyRecord.get("applyId") == '' ||  applyRecord.get("applyId")== 'null'){
			command.execute("insertInfoFromCheck");
		}else{
			command.execute("updateInfoFromCheck");
		}
	}else{
		command.execute("insertInfo");
	}
	var errorLog = command.getReturn("error");
	if( errorLog != 'true' ){
		L5.Msg.alert('提示',errorLog);
		buttonEnabled();
		return;
	}
	
	if (!command.error) {
		var hasSelef=false;
		peopleListDataSet.each(function(record, index){
			if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
				hasSelef=true;			
				return false;
			}
		});
		if(!hasSelef){
			familyId=command.getReturn("familyId");
			applyId=command.getReturn("applyId");
			applyDataSet.removeAll();
			applyDataSet.setParameter("APPLY_ID",applyId);
			applyDataSet.load();
			if(command.getReturn("assignmentId") != ''){
				assignmentId=command.getReturn("assignmentId");
			}
			photoId=command.getReturn("photoId");
			var width = 1000;
		    var height = 600;
		     //获取救助金计算方式,以此判断后台是否需要计算户月保障金
			var assistanceModeValue =document.getElementById("assistanceModeID").value;
			var url="samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1"+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue;
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
			buttonEnabled();
		}else{			
			L5.Msg.alert("提示","保存成功！",function(){			
				photoId=command.getReturn("photoId");
				if(applyId=='' || applyId == 'null'){
					applyId=command.getReturn("applyId");
					applyDataSet.removeAll();
					applyDataSet.setParameter("APPLY_ID",applyId);
					applyDataSet.load();
					if(command.getReturn("assignmentId") != ''){
						assignmentId=command.getReturn("assignmentId");
					}
				}
				buttonEnabled();
			});
		}
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		 buttonEnabled();
	}
}
//保存
function saveCheck(){
	var familyIsValidate = familyDataSet.isValidate();
	if(familyIsValidate != true){
		L5.Msg.alert("提示",familyIsValidate);
		return false;
	}
	var bankAccountDSIsValidate = bankAccountDS.isValidate();
	if(bankAccountDSIsValidate != true){
		L5.Msg.alert("提示",bankAccountDSIsValidate);
		return false;
	}
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	
	if(familyRecord.get("applyReason") == '' ){
		L5.Msg.alert("提示","校验未通过："+"申请理由不能为空");
		return false;
	}
	if(familyRecord.get("domicileCode") == '' || familyRecord.get("domicileName") == ''){
		L5.Msg.alert("提示","校验未通过："+"地区不能为空!");
		return false;
	}
	if(familyRecord.get("assistanceClass") == '' || familyRecord.get("assistanceClassMoney") == '' ){
		if(familyRecord.get("assistanceClass") == '' && familyRecord.get("assistanceClassMoney") == '' ){
		}else{
			if(familyRecord.get("assistanceClass") == ''){
				if(familyRecord.get("assistanceClassMoney") * 1 != 0){
					L5.Msg.alert("提示","校验未通过："+"请选择分类施保类别!");
					return false;
				}
			}else if(familyRecord.get("assistanceClassMoney") == ''){
				L5.Msg.alert("提示","校验未通过："+"请填写分类施保金!");
				return false;
			}
		}
	}
	if(familyRecord.get("assistanceClass") != '' && familyRecord.get("assistanceClassMoney") != ''){
		if(familyRecord.get("assistanceClassMoney") * 1 <= 0){
			L5.Msg.alert("提示","校验未通过："+"分类施保金须大于0!");
			return false;
		}
	}
	//邮编
	var familyPostcode=familyRecord.get('familyPostcode');
	if(familyPostcode!= '' && _isPostCode(familyPostcode) != true){
		L5.Msg.alert("提示","校验未通过："+"家庭基本信息中居住地邮编格式不正确");
		return false;
	}
	if(ActivityName == "check"){
		acceptDiscussionDataset.set("discussionResult",'1');//给评议结果同意，不然无法提交到审核环节
	}
	var acceptDiscussionDatasetIsValidate = acceptDiscussionDataset.isValidate();
	if(acceptDiscussionDatasetIsValidate != true){
		L5.Msg.alert("提示",acceptDiscussionDatasetIsValidate);
		return false;
	}
	//民主评议人数逻辑校验
	var total=acceptDiscussionDataset.get("total") ;
	var agreeNum= acceptDiscussionDataset.get("agreeNum") ;
	var disagreeNum= acceptDiscussionDataset.get("disagreeNum") ;
	if(total == '' ){
		total=0;
	}
	if(agreeNum == '' ){
		agreeNum=0;
	}
	if(disagreeNum == '' ){
		disagreeNum=0;
	}
	if(parseInt(total) !=parseInt(agreeNum) + parseInt(disagreeNum) ){
		L5.Msg.alert("提示","校验未通过："+"民主评议人数逻辑有误！");
		return false;
	}
	var content= acceptDiscussionDataset.get("content") ;
	if(parseInt(disagreeNum)>0&&content==''){
		L5.Msg.alert("提示","校验未通过："+"评议内容不能为空！");
		return false;
	}
	return true;
}
//提交
function submitApply(){
	familyDataSet.set('domicileCode',document.getElementById('lrdwId').value);
	buttonDisable();
	L5.getCmp("saveId").setDisabled(true);
	if(!submitApplyCheck()){
	  	L5.getCmp("saveId").setDisabled(false);
	   return ;
	}
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	//处理多选
	var inputs=_$("assistanceType").split(','); 
	AssistanceDataset.removeAll();
	if(inputs[0]){
		for(var i=0;i<inputs.length;i++){
		  	AssistanceDataset.newRecord({"assistanceType":inputs[i]});
		}  
	}
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryApplyCmd");
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	applyRecord.set("assignmentId",assignmentId);
	command.setParameter("applyRecord",applyRecord);
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	familyRecord.set("photoId",photoId);//维护照片信息
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("AssistanceRecords",AssistanceDataset.getAllRecords());
	command.setParameter("acceptSurveyRecord",acceptSurveyDataset.getAllRecords());
	command.setParameter("acceptDiscussionRecord",acceptDiscussionDataset.getAllRecords());
	command.setParameter("acceptNoticeRecord",acceptNoticeDataset.getAllRecords());
	command.setParameter("assignmentId",assignmentId);
	command.setParameter("bankAccount",bankAccountDS.getCurrent());	
	if(ActivityName == "check"){
		command.setParameter("surveyRecord",checkSurveyDataset.getCurrent());
		command.setParameter("noticeRecord",checkNoticeDataset.getCurrent());
		command.execute("sendApply");
	}else{
		command.execute("submitApply");
	}
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
//提交校验
function submitApplyCheck(){
	var familyIsValidate = familyDataSet.isValidate();
	if(familyIsValidate != true){
		L5.Msg.alert("提示",familyIsValidate);
		return false;
	}
	var bankAccountDSIsValidate = bankAccountDS.isValidate();
	if(bankAccountDSIsValidate != true){
		L5.Msg.alert("提示",bankAccountDSIsValidate);
		return false;
	}
	var acceptSurveyIsValidate = acceptSurveyDataset.isValidate();
	if(acceptSurveyIsValidate != true){
		L5.Msg.alert("提示",acceptSurveyIsValidate);
		return false;
	}
	var acceptDiscussionIsValidate = acceptDiscussionDataset.isValidate();
	if(acceptDiscussionIsValidate != true){
		L5.Msg.alert("提示",acceptDiscussionIsValidate);
		return false;
	}
	if(acceptSurveyDataset.get("surveyDate") == '' ){
		L5.Msg.alert("提示","校验未通过："+"调查日期不能为空");
		return false;
	}
	if(acceptSurveyDataset.get("surveyPeople") == '' ){
		L5.Msg.alert("提示","校验未通过："+"调查负责人不能为空");
		return false;
	}
	if(acceptSurveyDataset.get('surveyResult') == '0' &&acceptSurveyDataset.get('surveyContents')== ''){
		L5.Msg.alert("提示","校验未通过：备注不能为空！");
		return false;
	}
	if(acceptDiscussionDataset.get("principal") == '' ){
		L5.Msg.alert("提示","校验未通过："+"评议负责人不能为空");
		return false;
	}
		if(acceptDiscussionDataset.get("discussionResult") == '' ){
		
		L5.Msg.alert("提示","校验未通过："+"评议意见不能为空");
		return false;
	}
	if(acceptDiscussionDataset.get("discussionDate") == '' ){
		L5.Msg.alert("提示","校验未通过："+"评议日期不能为空");
		return false;
	}
	if(acceptDiscussionDataset.get("total") == '' ){
		L5.Msg.alert("提示","校验未通过："+"评议总人数不能为空");
		return false;
	}
	if(acceptDiscussionDataset.get("agreeNum") == '' ){
		L5.Msg.alert("提示","校验未通过："+"评议同意人数不能为空");
		return false;
	}
	var acceptDiscussionDatasetIsValidate = acceptDiscussionDataset.isValidate();
	if(acceptDiscussionDatasetIsValidate != true){
		L5.Msg.alert("提示",acceptDiscussionDatasetIsValidate);
		return false;
	}
	//民主评议人数逻辑校验
	var total=acceptDiscussionDataset.get("total") ;
	var agreeNum= acceptDiscussionDataset.get("agreeNum") ;
	var disagreeNum= acceptDiscussionDataset.get("disagreeNum") ;
	if(total == '' ){
		total=0;
	}
	if(agreeNum == '' ){
		agreeNum=0;
	}
	if(disagreeNum == '' ){
		disagreeNum=0;
	}
	if(parseInt(total) !=parseInt(agreeNum) + parseInt(disagreeNum) ){
		L5.Msg.alert("提示","校验未通过："+"民主评议人数逻辑有误！");
		return false;
	}
	var content= acceptDiscussionDataset.get("content") ;
	if(parseInt(disagreeNum)>0&&content==''){
		L5.Msg.alert("提示","校验未通过："+"评议内容不能为空！");
		return false;
	}
	
	var acceptNoticeIsValidate = acceptNoticeDataset.isValidate();
	if(acceptNoticeIsValidate != true){
		L5.Msg.alert("提示",acceptNoticeIsValidate);
		return false;
	}	
	
	if(ifFileCheck == "true"){
		/*
		if($("fileName_survey").innerHTML==""){
			L5.Msg.alert("提示","校验未通过："+"入户调查上传文件不能为空");
			return false;
		}
		if($("fileName_discussion").innerHTML==""){
			L5.Msg.alert("提示","校验未通过："+"评议上传文件不能为空");
			return false;
		}
		if($("fileName_notice").innerHTML==""){
			L5.Msg.alert("提示","校验未通过："+"公示结果上传文件不能为空");
			return false;
		}
		*/
	}	
	
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();

	if(familyRecord.get("applyReason") == '' ){
		L5.Msg.alert("提示","校验未通过："+"申请理由不能为空");
		return false;
	}
	if(familyRecord.get("domicileCode") == '' || familyRecord.get("domicileName") == ''){
		L5.Msg.alert("提示","校验未通过："+"地区不能为空!");
		return false;
	}
	if(familyRecord.get("assistanceClass") == '' || familyRecord.get("assistanceClassMoney") == '' ){
		if(familyRecord.get("assistanceClass") == '' && familyRecord.get("assistanceClassMoney") == '' ){
		}else{
			if(familyRecord.get("assistanceClass") == ''){
				if(familyRecord.get("assistanceClassMoney") * 1 != 0){
					L5.Msg.alert("提示","校验未通过："+"请选择分类施保类别!");
					return false;
				}
			}else if(familyRecord.get("assistanceClassMoney") == ''){
				L5.Msg.alert("提示","校验未通过："+"请填写分类施保金!");
				return false;
			}
		}
	}
	if(familyRecord.get("assistanceClass") != '' && familyRecord.get("assistanceClassMoney") != ''){
		if(familyRecord.get("assistanceClassMoney") * 1 <= 0){
			L5.Msg.alert("提示","校验未通过："+"分类施保金须大于0!");
			return false;
		}
	}
	//邮编
	var familyPostcode=familyRecord.get('familyPostcode');
	if(familyPostcode!= '' && _isPostCode(familyPostcode) != true){
		L5.Msg.alert("提示","校验未通过："+"家庭基本信息中居住地邮编格式不正确");
		return false;
	}
	if(peopleListDataSet.getCount() < 1){
		L5.Msg.alert("提示","校验未通过："+"请录入家庭成员信息");
		return false;
	}
	if(ActivityName == "check"){
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
		if(checkSurveyDataset.get('surveyResult') != '' ){
			if(checkSurveyDataset.get("surveyDate") == '' ){
				L5.Msg.alert("提示","校验未通过：调查日期不能为空！");
				return false;
			}
			if(checkSurveyDataset.get("surveyPeople") == '' ){
				L5.Msg.alert("提示","校验未通过：调查负责人不能为空！");
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
//新增人员信息
function addPeople(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息，然后录入家庭成员信息！");
		return;
	}
	//获取救助金计算方式,以此判断后台是否需要计算户月保障金
	var assistanceModeValue =document.getElementById("assistanceModeID").value;
	var hasSelef=false;
	peopleListDataSet.each(function(record, index){
		if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
			hasSelef=true;			
			return false;
		}
	});
	if(!hasSelef){
		var width = 1000;
	    var height = 600;
		var url="samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1"+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{		
		var width = 1000;
	    var height = 600;
		var url="samBasePeopleInsert.jsp?familyId="+familyId+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
}
//修改人员信息
function changePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 1000;
	    var height = 600;
	    //获取救助金计算方式,以此判断后台是否需要计算户月保障金
		var assistanceModeValue =document.getElementById("assistanceModeID").value;
		var url="samBasePeopleInsert.jsp?familyId="+familyId+"&peopleId="+records[0].get('PEOPLE_ID')+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除人员信息
function removePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		if(records[0].get("RELATIONSHIP_TYPE")=='01'){			
			L5.Msg.alert('提示',"不能删除户主信息！");
			return;
		}
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				//获取救助金计算方式,以此判断后台是否需要计算户月保障金
				var assistanceModeValue =document.getElementById("assistanceModeID").value;
				
				var delId=records[0].get("PEOPLE_ID");
				var command=new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryApplyCmd");
				command.setParameter("delId", delId);
				command.setParameter("familyId", familyId);
				command.setParameter("applyId", applyId);
				command.setParameter("assistanceModeValue", assistanceModeValue);
				
				command.execute("deletePeopleInfo");
				var assistancePeopleNum=command.getReturn("assistancePeopleNum");
				var monthIncome=command.getReturn("monthIncome");
				var monthAverageIncome=command.getReturn("monthAverageIncome");
				var peopleNum=command.getReturn("peopleNum");
				var yearIncome=command.getReturn("yearIncome");
				var yearAverageIncome=command.getReturn("yearAverageIncome");
				var assistanceMoney=command.getReturn("assistanceMoney");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功！",function(){
						peopleListDataSet.remove(records[0]);
						familyDataSet.set("assistancePeopleNum",assistancePeopleNum);
						familyDataSet.set("monthIncome",monthIncome);
						familyDataSet.set("monthAverageIncome",monthAverageIncome);
						familyDataSet.set("peopleNum",peopleNum);
						familyDataSet.set("yearIncome",yearIncome);
						familyDataSet.set("yearAverageIncome",yearAverageIncome);
						if(assistanceMoney != "null"){
							familyDataSet.set("assistanceMoney",assistanceMoney);
						}
						countTotle();
					});		
				}else{
					L5.Msg.alert('提示',"删除时出现错误！"+command.error);
				}
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//新增房屋信息
function addHouse(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = 800;
    var height = 123;
	var url="../../../comm/houseEdit.jsp?familyId="+familyId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//修改房屋信息
function changeHouse(){
	var grid = L5.getCmp('housePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 800;
	    var height = 123;
		var url="../../../comm/houseEdit.jsp?familyId="+familyId+"&houseId="+records[0].get('houseId')+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除房屋信息
function removeHouse(){
	var grid = L5.getCmp('housePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyHouseCmd");
				var delId=records[0].get("houseId");
				command.setParameter("delId", delId);
				command.execute("delete");				
				houseListDataset.remove(records[0]);
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//新增财产信息
function addEstate(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = 600;
    var height = 143;
	var url="../../../comm/estateEdit.jsp?familyId="+familyId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//修改财产信息
function changeEstate(){
	var grid = L5.getCmp('estatePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 600;
	    var height = 143;
		var url="../../../comm/estateEdit.jsp?familyId="+familyId+"&estateId="+records[0].get('estateId')+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除财产信息
function removeEstate(){
	var grid = L5.getCmp('estatePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyEstateCmd");
				var delId=records[0].get("estateId");
				command.setParameter("delId", delId);
				command.execute("delete");				
				estateListDataset.remove(records[0]);
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//新增赡扶抚养义务人员
function addSupport(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	 //获取救助金计算方式,以此判断后台是否需要计算户月保障金
	var assistanceModeValue =document.getElementById("assistanceModeID").value;
	var width = 850;
   	var height = 200;
	var url="../../../comm/supportEdit.jsp?familyId="+familyId+"&assistanceType=02"+"&applyId="+applyId+"&hrefFlg="+getCurrent()+"&assistanceModeValue="+assistanceModeValue;
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//修改赡扶抚养义务人员
function changeSupport(){
	var grid = L5.getCmp('supportPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
	 //获取救助金计算方式,以此判断后台是否需要计算户月保障金
		var assistanceModeValue =document.getElementById("assistanceModeID").value;
		var width = 850;
   		 var height = 200;
		var url="../../../comm/supportEdit.jsp?familyId="+familyId+"&supportId="+records[0].get('supportId')+"&assistanceType=02"+"&applyId="+applyId+"&hrefFlg="+getCurrent()+"&assistanceModeValue="+assistanceModeValue;
		window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除赡扶抚养义务人员
function removeSupport(){
	var grid = L5.getCmp('supportPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
			 	//获取救助金计算方式,以此判断后台是否需要计算户月保障金
				var assistanceModeValue =document.getElementById("assistanceModeID").value;
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilySupportCmd");
				//var delId=records[0].get("supportId");
				command.setParameter("delId",records[0]);
				command.setParameter("applyId", applyId);
				command.setParameter("assistanceType",assistanceType);
				command.setParameter("assistanceModeValue", assistanceModeValue);
				command.execute("delete");				
				supportListDataset.remove(records[0]);
				var monthIncome=command.getReturn("monthIncome");
				var monthAverageIncome=command.getReturn("monthAverageIncome");
				var yearIncome=command.getReturn("yearIncome");
				var yearAverageIncome=command.getReturn("yearAverageIncome");
				var assistanceMoney=command.getReturn("assistanceMoney");
				familyDataSet.set("monthIncome",monthIncome);
				familyDataSet.set("monthAverageIncome",monthAverageIncome);
				familyDataSet.set("yearIncome",yearIncome);
				familyDataSet.set("yearAverageIncome",yearAverageIncome);
				if(assistanceMoney != "null"){
					familyDataSet.set("assistanceMoney",assistanceMoney);
				}
				countTotle();
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//增加上传文件
function uploadFiles(){
	if(applyId==''||applyId=='null'){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = 600;
    var height = 177;
	var url="../../../comm/uploadFile.jsp?applyId="+applyId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//增加扫描文件
function scanFiles(){
	if(applyId==''||applyId=='null'){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = screen.width-600;
    var height = screen.height-600;
    
    var url="../../../../../comm/arch/archUploadfile.jsp?applyId="+applyId+"&sysType=sam&applyType=020&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:1;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//删除证明材料
function removeFiles(){
	var grid = L5.getCmp('filesPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyFilesCmd");
				var delId=records[0].get("applyFileId");
				command.setParameter("delId", delId);
				command.execute("delete");				
				filesListDataset.remove(records[0]);
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
/**
 * 选择属地行政区划窗口
*/
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		familyDataSet.set('domicileName',list[1]);
		familyDataSet.set('domicileCode',list[0]);
	}
}
//修改时显示照片
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
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
//计算评议人数
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
	if(value == '10'){
		if( applyId!='' && familyId!='' ){
			var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryApplyCmd");
			command.setParameter("applyId",applyId);
			command.setParameter("familyId",familyId);
			command.execute("getAssistanceMoney");
			var assmon=command.getReturn('assistanceMoney');
			if(assmon < 0){
				assmon=0;
			}
			familyDataSet.set("assistanceMoney",assmon); 
		}
		document.getElementById("assistanceMoneyID").style.display = 'none';
		document.getElementById("assistanceMoneyID1").style.display = 'block';
	}else{
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
	
	if(classMode == '02'){
		familyDataSet.set("assistanceClassMoney",formatNum(
		FloatDiv(FloatMul(nullToZero(familyDataSet.get('assistanceMoney')),classMoney),100))
		);
	}
	
	var asClassMoney=document.getElementById("assistanceClassMoneyID").value;
	var totalnum=parseFloat(nullToZero(assMoney))+parseFloat(nullToZero(asClassMoney));
	document.getElementById("totalMoney").innerHTML=totalnum;
}
//调查结果为不属实，填写备注录入
function checkOpinion(value){
	if(value == '0'){
		document.getElementById('beizhuhang').style.display="block";
	}else{
		document.getElementById('beizhuhang').style.display="none";
		acceptSurveyDataset.set('surveyContents','');
	}
}
var classMode = '';
var classMoney= 0 ;
//选择分类施保类别之后自动回填分类施保金
function getClassMoney(value){
	var command = new L5.Command("com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassCmd");
	command.setParameter("classCode",value);
	command.setParameter("organArea",organArea.substring(0,6) + "000000");
	command.setParameter("nowTime",nowTime);
	command.setParameter("assistanceType","02");
	command.execute("getClassMoney");
	classMoney=command.getReturn('classMoney');
	classMode = command.getReturn('classMode');
	if(classMode == '01'){
		familyDataSet.set("assistanceClassMoney",classMoney);
	}else if(classMode == '02'){
		familyDataSet.set("assistanceClassMoney",formatNum(
		FloatDiv(FloatMul(nullToZero(familyDataSet.get('assistanceMoney')),classMoney),100))
		);
	}
	countTotle();
}
//浮点数乘法运算   
function FloatMul(arg1,arg2)    
{    
 var m=0,s1=arg1.toString(),s2=arg2.toString();    
 try{m+=s1.split(".")[1].length;}catch(e){}    
 try{m+=s2.split(".")[1].length;}catch(e){}    
 return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);    
 }    
  
  
//浮点数除法运算   
function FloatDiv(arg1,arg2){    
	var t1=0,t2=0,r1,r2;    
	try{t1=arg1.toString().split(".")[1].length;}catch(e){}    
	try{t2=arg2.toString().split(".")[1].length;}catch(e){}    
	with(Math){    
	r1=Number(arg1.toString().replace(".",""));    
	r2=Number(arg2.toString().replace(".",""));    
	return (r1/r2)*pow(10,t2-t1);    
	}    
} 