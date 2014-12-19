var familyId='';
var applyDate = nowTime;
var applyReason='';
var photoId='';
var familySex='';
var assistanceMode='';
var assistanceMoney='';
var assistanceClassMoney='';
var assistanceClass='';
var organCode='';
var fullName='';
//初始化
function init(){
	if(method=="insert"){
		//加载分类施保类别字典
		var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
	    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='02' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//农村低保
	    asisstanceClassDataset.load();
		//新增页面的加载页面
		prepareForInsert();
	}else{
		//修改时加载页面
		loadInfo();
	}
	//过滤人员状态的 正常
	samPersonalCancelStatsDataSet.filterBy(function(record, id){
		if(record.get('value') != '01' ){
			return record;
		}
	});
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
	applyDataSet.newRecord({"isFinish":"0"});
	familyDataSet.newRecord({"applyDate":nowTime});
	bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"02"});
	acceptSurveyDataset.newRecord({"activityId":"accept"});
	acceptDiscussionDataset.newRecord({"activityId":"accept"});
	acceptNoticeDataset.newRecord({"activityId":"accept"});
	//移除审核审批意见的panel
	var tab=L5.getCmp("tab");
	var checkDetailPanel=L5.getCmp("checkDetailPanel");
	tab.remove(checkDetailPanel);
	var auditDetailPanel=L5.getCmp("auditDetailPanel");
	tab.remove(auditDetailPanel);
	if(ActivityName == "check"){
		checkNoticeDataset.newRecord({"activityId":"check"});
		checkSurveyDataset.newRecord({"activityId":"check"});
	}else{
		var checkEditPanel=L5.getCmp("checkEditPanel");
		tab.remove(checkEditPanel);
	}
	//按钮禁用
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
	L5.getCmp("peopleChange").setDisabled(true);
	L5.getCmp("changePeopleID").setDisabled(true);
	L5.getCmp("cancelPeopleID").setDisabled(true);
	L5.getCmp("removePeopleID").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("submitId").setDisabled(false);
	L5.getCmp("peopleAdd").setDisabled(false);
	L5.getCmp("houseAdd").setDisabled(false);
	L5.getCmp("estateAdd").setDisabled(false);
	L5.getCmp("supportAdd").setDisabled(false);
	L5.getCmp("filesUpload").setDisabled(false);
	L5.getCmp("peopleChange").setDisabled(false);
	L5.getCmp("changePeopleID").setDisabled(false);
	L5.getCmp("cancelPeopleID").setDisabled(false);
	L5.getCmp("removePeopleID").setDisabled(false);
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
	ds.un("load",loadApplyInfo);
	if(ds.getCount() == 1){
		applyDate=ds.get('applyDate');
		applyReason=ds.get('applyReason');
		assistanceMode=ds.get('assistanceMode');
		assistanceMoney=ds.get('assistanceMoney');
		assistanceClassMoney=ds.get('assistanceClassMoney');
		assistanceClass=ds.get('asisstanceClass');
		setChangeItems(ds.get('changeItem'));// 设置变更事项
		familyId=ds.get('familyId');
		//判断环节相应显示审核审批意见
		decideDef(ds);
		//启用按钮
		buttonEnabled();
		//加载分类施保类别字典
		loadAsisstanceClass();
	}
}
//校验户主姓名
function checkFamilyName(obj){
	var familyName=obj.value;
	if(familyName==''){
		return;
	}
	familyQueryDataSet.setParameter("familyName",familyName);
	familyQueryDataSet.setParameter("domicileCode",organArea);
	familyQueryDataSet.setParameter("queryDate",nowTime.substring(0, 7));
	familyQueryDataSet.load();
	familyQueryDataSet.on("load",loadFamilyQuery);
}
//加载查询用家庭
function loadFamilyQuery(ds){
	ds.un("load",loadFamilyQuery);
	if(ds.getCount()<1){
		L5.Msg.alert("提示","不存在该姓名的人员！");
		$('familyName').value='';
		return;
	}else if(ds.getCount()==1){
		familyId=ds.get('FAMILY_ID');
		assistanceMode=ds.get('ASSISTANCE_MODE');
		assistanceMoney=ds.get('ASSISTANCE_MONEY');
		assistanceClassMoney=ds.get('ASSISTANCE_CLASS_MONEY');
		assistanceClass=ds.get('ASSISTANCE_CLASS');
		
		applyQueryDataSet.setParameter("FAMILY_ID",familyId);
		applyQueryDataSet.setParameter("IS_FINISH","0");
		applyQueryDataSet.load();
		applyQueryDataSet.on('load',loadExistApply);
	}else{	
		var win=L5.getCmp("familyQueryWin");
		win.show();
	}
}		
//获取户主性别
function getFamilySex(value,cellmeta,record,rowindex,colindex,dataset){
	var familyCardNo = record.get("FAMILY_CARD_NO");
	var familySex=getSexByCode(familyCardNo);
	if(familySex=='1'){
		return '男';
	}else{
		return '女';
	}
}	
function loadExistApply(ds){
	ds.un("load",loadExistApply);
	if( ds.getCount() > 0 ){
		L5.Msg.alert("提示","该姓名的户主存在正在办理的业务！");
		$('familyName').value='';
		return;
	}else{
		//加载分类施保类别字典
		loadAsisstanceClass();
	}
}	
//获取户主年龄
function getFamilyAge(value,cellmeta,record,rowindex,colindex,dataset){
	var familyCardNo = record.get("FAMILY_CARD_NO");
	var familyAge=getAgeByCode(familyCardNo);
	if(familyAge!=''){
		return familyAge;
	}else{
		return '';
	}
}
//家庭查询确定
function confirmFamilyQueryWin(){	
	var grid = L5.getCmp("familyQueryGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}else{
		var win = L5.getCmp("familyQueryWin");
		win.hide();	
		familyId=record.get('FAMILY_ID');
		assistanceMode=record.get('ASSISTANCE_MODE');
		assistanceMoney=record.get('ASSISTANCE_MONEY');
		assistanceClassMoney=record.get('ASSISTANCE_CLASS_MONEY');
		assistanceClass=record.get('ASSISTANCE_CLASS');
		//加载分类施保类别字典
		loadAsisstanceClass();
	}		
}
//家庭查询关闭
function closeFamilyQueryWin(){
	var win = L5.getCmp("familyQueryWin");
	win.hide();	
	$('familyName').value='';
}
//判断环节相应显示审核审批意见
function decideDef(ds){
	var tab=L5.getCmp("tab");
	var checkId=ds.get('checkOpinionId'); 
	var auditId=ds.get('auditOpinionId'); 
	if(auditId == ''){
		//正常的进入修改页面
		if(checkId == ''){
			var checkDetailPanel=L5.getCmp("checkDetailPanel");
			tab.remove(checkDetailPanel);
			var auditDetailPanel=L5.getCmp("auditDetailPanel");
			tab.remove(auditDetailPanel);
			if(ActivityName != "check"){
				var checkEditPanel=L5.getCmp("checkEditPanel");
				tab.remove(checkEditPanel);
			}
		//审核回退
		}else{
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
	//审批回退
	}else{
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
	familyDataSet.removeAll();
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
		photoId=ds.get("photoId");
		//加载照片
		showPhotoAbleEdit(photoId);
		document.getElementById('familyCardNo').disabled=true;
		document.getElementById('familyName').disabled=true;
		countTotle();
	}
	ds.un("load",loadBank);
	bankAccountDS.removeAll();
  	bankAccountDS.setParameter("FAMILY_ID",familyId);
    bankAccountDS.on("load",loadPeopleListDs);
    bankAccountDS.load();
}
//加载家庭成员基本信息
function loadPeopleListDs(ds){
	ds.un("load",loadPeopleListDs);
	if(ds.getCount() == 0 ){
		bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"02"});
	}
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
    	ArchCatalogDS.setParameter("applyType","021");
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
 	checkSurveyDataset.setParameter("APPLY_ID",applyId);
	checkSurveyDataset.load();
	checkSurveyDataset.on("load",loadcheckSurveyDs);
}
//加载审核评议结果
function loadcheckSurveyDs(ds){
 	ds.un("load",loadcheckSurveyDs);
	checkNoticeDataset.setParameter("APPLY_ID",applyId);
	checkNoticeDataset.load();
}
//加载审批信息
function loadAudit(){
	auditSurveyDataset.setParameter("APPLY_ID",applyId);
	auditSurveyDataset.load();
	auditSurveyDataset.on("load",loadauditNoticeDs);
	
}
//加载审批评议结果
function loadauditNoticeDs(ds){
 	ds.un("load",loadauditNoticeDs);
 	auditNoticeDataset.setParameter("APPLY_ID",applyId);
	auditNoticeDataset.load();
}
//保存
function save(){
	familyDataSet.set('domicileCode',document.getElementById('lrdwId').value);
	buttonDisable();
	L5.getCmp("saveId").setDisabled(true);
	if(!saveCheck()){
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
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryChangeCmd");
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	applyRecord.set("assignmentId",assignmentId);
	command.setParameter("applyRecord",applyRecord);
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	//维护照片信息
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);
	familyRecord.set("photoId",photoId);
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("AssistanceRecords",AssistanceDataset.getAllRecords());
	command.setParameter("acceptSurveyRecord",acceptSurveyDataset.getAllRecords());
	command.setParameter("acceptDiscussionRecord",acceptDiscussionDataset.getAllRecords());
	command.setParameter("acceptNoticeRecord",acceptNoticeDataset.getAllRecords());
	command.setParameter("bankAccount",bankAccountDS.getCurrent());	
	if(ActivityName == "check"){
		command.setParameter("surveyRecord",checkSurveyDataset.getCurrent());
		command.setParameter("noticeRecord",checkNoticeDataset.getCurrent());
		if( applyRecord.get("applyId") == '' || applyRecord.get("applyId") == 'null'){
			command.execute("insertInfoFromCheck");
		}else{
			command.execute("updateInfoFromCheck");
		}
	}else{
		command.execute("insertInfo");
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			familyId=command.getReturn("familyId");
			applyId=command.getReturn("applyId");
			applyDataSet.removeAll();
			applyDataSet.setParameter("APPLY_ID",applyId);
			applyDataSet.load();
			if(command.getReturn("assignmentId") != ''){
				assignmentId=command.getReturn("assignmentId");
			}
			photoId=command.getReturn("photoId");
			//启用按钮
			buttonEnabled();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		//启用按钮
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
	var bankAccountDSIsValidate = bankAccountDS.isValidate();
	if(bankAccountDSIsValidate != true){
		L5.Msg.alert("提示",bankAccountDSIsValidate);
		return false;
	}
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	var changeItem=getChangeItems();
	if(""==changeItem){
		L5.Msg.alert("提示","校验未通过："+"未选择变更事项");
		return false;
	} else {
	    applyRecord.set("changeItem",changeItem);
	}
	if(familyRecord.get("applyReason") == '' ){
		L5.Msg.alert("提示","校验未通过："+"变更原因不能为空");
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
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryChangeCmd");
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	applyRecord.set("assignmentId",assignmentId);
	command.setParameter("applyRecord",applyRecord);
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	//维护照片信息
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	familyRecord.set("photoId",photoId);
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
			if(ActivityName == "check" && applyRecord.get('changeItem')== '04' &&  applyRecord.get("checkOpinionId") == '1' ){
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
	var checkPersonStatusVal = checkPersonStatus();// 这里是判断是不是死亡状态
	if(checkPersonStatusVal){//
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
		 if(acceptDiscussionDataset.get("discussionResult") == '' ){
			L5.Msg.alert("提示","校验未通过："+"评议意见不能为空");
			return false;
		}
		var acceptNoticeIsValidate = acceptNoticeDataset.isValidate();
		if(acceptNoticeIsValidate != true){
			L5.Msg.alert("提示",acceptNoticeIsValidate);
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
		}
	}
	
	
		var applyRecord=applyDataSet.getCurrent();
		var familyRecord=familyDataSet.getCurrent();
		var changeItem=getChangeItems();
		if(""==changeItem){
			L5.Msg.alert("提示","校验未通过："+"未选择变更事项");
			return false;
		} else {
		    applyRecord.set("changeItem",changeItem);
		}
		if(familyRecord.get("applyReason") == '' ){
			L5.Msg.alert("提示","校验未通过："+"变更原因不能为空");
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
	 if(acceptDiscussionDataset.get("discussionResult") == '' ){
			L5.Msg.alert("提示","校验未通过："+"评议意见不能为空");
			return false;
		}
	if(ActivityName == "check"){
		if(applyDataSet.get("checkOpinionId") == '' ){
			L5.Msg.alert("提示","校验未通过：审核结果不能为空！");
			return false;
		}
	}
	
	return true;
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
	
	var hasSelef=false;
	peopleListDataSet.each(function(record, index){
		if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
			hasSelef=true;			
			return false;
		}
	});
	//获取救助金计算方式,以此判断后台是否需要计算户月保障金
	var assistanceModeValue =document.getElementById("assistanceModeID").value;
	if(!hasSelef){
		var width = 1000;
	    var height = 600;
		var url="../apply/samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1"+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{		
		var width = 1000;
	    var height = 600;
		var url="../apply/samBasePeopleInsert.jsp?familyId="+familyId+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
}
//修改人员信息
function changePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var personalStatsTag=records[0].get('PERSONAL_STATS_TAG');
		if( personalStatsTag!='01'){
			L5.Msg.alert("提示","请确认人员状态！");
			return;
		}
		//获取救助金计算方式,以此判断后台是否需要计算户月保障金
		var assistanceModeValue =document.getElementById("assistanceModeID").value;
		var width = 1000;
	    var height = 600;
		var url="../apply/samBasePeopleInsert.jsp?familyId="+familyId+"&peopleId="+records[0].get('PEOPLE_ID')+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue+"&isChangeUpdate=1";
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
		var command1=new L5.Command("com.inspur.cams.drel.archive.baseinfopeoplearchive.cmd.BaseinfoPeopleArchiveCmd");
		command1.setParameter("peopleId",records[0].get("PEOPLE_ID"));
		command1.execute("queryExistPeople");
		if (!command1.error) {
			 var flag = command1.getReturn("flag");	
			 if(flag == '1'){
			 	L5.Msg.alert('提示',"不能删除正在享受救助的人员！请使用注销功能！");
				return;
			 }else if(flag == '0'){
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
						var yearIncome=command.getReturn("yearIncome");
						var yearAverageIncome=command.getReturn("yearAverageIncome");
						var peopleNum=command.getReturn("peopleNum");
						var monthIncome=command.getReturn("monthIncome");
						var monthAverageIncome=command.getReturn("monthAverageIncome");
						var assistanceMoney=command.getReturn("assistanceMoney");
						if (!command.error) {
							L5.Msg.alert("提示","删除成功！",function(){
								peopleListDataSet.remove(records[0]);
								familyDataSet.set("assistancePeopleNum",assistancePeopleNum);
								familyDataSet.set("yearIncome",yearIncome);
								familyDataSet.set("yearAverageIncome",yearAverageIncome);
								familyDataSet.set("peopleNum",peopleNum);
								familyDataSet.set("monthIncome",monthIncome);
								familyDataSet.set("monthAverageIncome",monthAverageIncome);
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
			 	L5.Msg.alert("提示","获取返回值出错！");
			 }
		}else{
			L5.Msg.alert('提示',"查询时出现错误！"+command1.error);
		}
		
		
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
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilySupportCmd");
				//获取救助金计算方式,以此判断后台是否需要计算户月保障金
				var assistanceModeValue =document.getElementById("assistanceModeID").value;
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
    
    var url="../../../../../comm/arch/archUploadfile.jsp?applyId="+applyId+"&sysType=sam&applyType=021&hrefFlg="+getCurrent();
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
		document.getElementById('img').src=src;
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
//变更户主
function changePeopleRelationshipType(){
	var win=L5.getCmp("changeApplyPeople");
	win.show();
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
//获取人员状态
function getPersonalStatsTag(value,cellmeta,record,rowindex,colindex,dataset){
	var personalStatsTag = record.get("PERSONAL_STATS_TAG");
	if(personalStatsTag=='01'){
		return '正常';
	}else if(personalStatsTag!=''){
		var stats=getDicText(samPersonalStatsDataSet,personalStatsTag);
		return stats+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=javascript:recoverPeople() >'+'恢复'+'</a>';
	}else{
		return '';
	}
}
//变更户主点保存按钮
function changeRelationshipType(){
	var flag = 0;
	peopleListDataSet.each(function(record,index){
		if(record.get('RELATIONSHIP_TYPE') == '01' ){
			flag++;
		}
	});
	if(flag > 1){
		L5.Msg.alert("提示","不可以存在多个户主！");
		peopleListDataSet.rejectChanges();
		return;
	}
	if(flag == 0){
		L5.Msg.alert("提示","至少存在一个户主！");
		peopleListDataSet.rejectChanges();
		return;
	}
	if(peopleListDataSet.getAllChangedRecords().length == 0){
		return;
	}
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryChangeCmd");
	command.setParameter("peoples",peopleListDataSet.getAllChangedRecords());
	command.execute("updatePeopleRelationshipType");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			peopleListDataSet.commitChanges();
			peopleListDataSet.each(function(record,index){
				if(record.get('RELATIONSHIP_TYPE') == '01' ){
					familyDataSet.set('familyName',record.get('NAME'));
					familyDataSet.set('familyCardNo',record.get('ID_CARD'));
				}
			});
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//关闭变更户主窗口
function closeWin(){
	var win=L5.getCmp("changeApplyPeople");
	win.hide();
}
//注销人员
function cancelPeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){	
		var relationshipType=records[0].get('RELATIONSHIP_TYPE');
		var personalStatsTag=records[0].get('PERSONAL_STATS_TAG');
		if( relationshipType=='01' && peopleListDataSet.getCount() > 1){//本人	
			L5.Msg.alert("提示","请先把家庭中的某个成员修改为户主后，再注销原户主！");				
		}else{
			if( personalStatsTag=='01'){
				var win = L5.getCmp("cancelPeopleWin");
				win.show();
				$('personalStatsTag').value='';
			}else{				
				L5.Msg.alert("提示","请确认人员状态！");
			}
		}
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//人员注销确定
function confirmCancelPeopleWin(){		
	if( _$('personalStatsTag')==''){
		L5.Msg.alert("提示","请选择注销原因！");
		return;
	}
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	var peopleId=records[0].get('PEOPLE_ID');
	var familyId=records[0].get('FAMILY_ID');
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryChangeCmd");
	command.setParameter("peopleId", peopleId);
	command.setParameter("familyId", familyId);
	command.setParameter("personalStatsTag", _$('personalStatsTag'));
	
	//获取救助金计算方式,以此判断后台是否需要计算户月保障金
	var assistanceModeValue =document.getElementById("assistanceModeID").value;
	command.setParameter("assistanceModeValue",assistanceModeValue);
	command.setParameter("applyId", applyId);
	command.execute("updatePeopleStats");	
	var assistancePeopleNum=command.getReturn("assistancePeopleNum");
	var yearIncome=command.getReturn("yearIncome");
	var yearAverageIncome=command.getReturn("yearAverageIncome");
	var peopleNum=command.getReturn("peopleNum");
	var monthIncome=command.getReturn("monthIncome");
	var monthAverageIncome=command.getReturn("monthAverageIncome");
	var assistanceMoney=command.getReturn("assistanceMoney");
	if (!command.error) {
		var win = L5.getCmp("cancelPeopleWin");
		win.hide();		
		//家庭成员列表
		peopleListDataSet.removeAll();
		peopleListDataSet.setParameter("FAMILY_ID",familyId);
		peopleListDataSet.load();
		//家庭基本信息
		familyDataSet.set('assistancePeopleNum',assistancePeopleNum);
		familyDataSet.set('yearIncome',yearIncome);
		familyDataSet.set('yearAverageIncome',yearAverageIncome);
		familyDataSet.set('peopleNum',peopleNum);
		familyDataSet.set('monthIncome',monthIncome);
		familyDataSet.set('monthAverageIncome',monthAverageIncome);
		if(assistanceMoney != "null"){
			familyDataSet.set("assistanceMoney",assistanceMoney);
		}
		countTotle();
		L5.Msg.alert('提示',"注销成功后请注意修改户月保障金！");
	}else{
		L5.Msg.alert('提示',"注销时出现错误！"+command.error);
	}			
}
//人员注销关闭
function closeCancelPeopleWin(){
	var win = L5.getCmp("cancelPeopleWin");
	win.hide();	
}
//恢复人员
function recoverPeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	var peopleId=records[0].get('PEOPLE_ID');
	var familyId=records[0].get('FAMILY_ID');
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryChangeCmd");
	command.setParameter("peopleId", peopleId);
	command.setParameter("familyId", familyId);
	command.setParameter("personalStatsTag",'01');//正常
	
	//获取救助金计算方式,以此判断后台是否需要计算户月保障金
	var assistanceModeValue =document.getElementById("assistanceModeID").value;
	command.setParameter("assistanceModeValue",assistanceModeValue);
	command.setParameter("applyId", applyId);
	command.execute("updatePeopleStats");	
	var assistancePeopleNum=command.getReturn("assistancePeopleNum");
	var yearIncome=command.getReturn("yearIncome");
	var yearAverageIncome=command.getReturn("yearAverageIncome");
	var peopleNum=command.getReturn("peopleNum");
	var monthIncome=command.getReturn("monthIncome");
	var monthAverageIncome=command.getReturn("monthAverageIncome");
	var assistanceMoney=command.getReturn("assistanceMoney");
	if (!command.error) {		
		//家庭成员列表
		peopleListDataSet.removeAll();
		peopleListDataSet.setParameter("FAMILY_ID",familyId);
		peopleListDataSet.load();
		//家庭基本信息
		familyDataSet.set('assistancePeopleNum',assistancePeopleNum);
		familyDataSet.set('yearIncome',yearIncome);
		familyDataSet.set('yearAverageIncome',yearAverageIncome);
		familyDataSet.set('peopleNum',peopleNum);
		familyDataSet.set('monthIncome',monthIncome);
		familyDataSet.set('monthAverageIncome',monthAverageIncome);
		if(assistanceMoney != "null"){
			familyDataSet.set("assistanceMoney",assistanceMoney);
		}
		countTotle();
	}else{
		L5.Msg.alert('提示',"恢复时出现错误！"+command.error);
	}			
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
//组装变更事项编码字符串
function getChangeItems(){
	var changeItems="";
	var changItemObjs=document.getElementsByName("changeItem");
	for(var i=0;i<changItemObjs.length;i++){
	    if(changItemObjs[i].checked){
		    if(""==changeItems){
		        changeItems=changeItems+changItemObjs[i].value;
		    } else {
			    changeItems=changeItems+","+changItemObjs[i].value;
		    }
	    }
	} 
	return changeItems;
}
//修改页面，设置变更事项checkbox选中状态
function setChangeItems(changeItems){
	var itemArr=changeItems.split(",");
	for(var i=0;i<itemArr.length;i++){
		document.getElementById("changeItem"+itemArr[i]).checked=true;
	} 
}
//变更事项checkbox点击事件，只允许选中一个
function changeItemClick(src){
	var changItemObjs=document.getElementsByName("changeItem");
	for(var i=0;i<changItemObjs.length;i++){
	    if(src.id!=changItemObjs[i].id){
	    	changItemObjs[i].checked=false;
	    }
	} 
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