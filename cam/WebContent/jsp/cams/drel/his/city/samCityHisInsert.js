var familyId='';
var beginDate='';
var assistance_cardNo='';
var photoId='';
var familySex='';
var assistanceMode='';
var assistanceMoney='';
var assistanceClassMoney='';
var organCode='';
var fullName='';
var idCard="";
function init(){
	var acceptEditPanel=L5.getCmp("acceptEditPanel");
	acceptEditPanel.collapse();
	var checkEditPanel=L5.getCmp("checkEditPanel");
	checkEditPanel.collapse();
	var auditEditPanel=L5.getCmp("auditEditPanel");
	auditEditPanel.collapse();
	if(method=="insert"){
		//加载分类施保类别字典
		var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
	    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='01' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//城市低保
	    asisstanceClassDataset.load();
		prepareForInsert();//新增页面的加载页面
	}else{
		L5.getCmp("saveId").setDisabled(true);
		loadInfo();//修改时加载页面	
		//loadAcceptSurveyDs();
		//loadCheck();
		//loadAudit();
	}
	surveyResultDataSet.filterBy(function(record, id){
		if("1" ==record.get('value') ){
			return record;
		}
	});
	discussionResultDataSet.filterBy(function(record, id){
		if("1" ==record.get('value') ){
			return record;
		}
	});
	noticeResultDataSet.filterBy(function(record, id){
		if("1" ==record.get('value') ){
			return record;
		}
	});
	opinionDataSet.filterBy(function(record, id){
		if("1" ==record.get('value') ){
			return record;
		}
	});	
	if(hideFlag=='true'){
		document.getElementById('familyName').readOnly =true;
		document.getElementById('familyCardNo').readOnly =true;
	}
	//窗口关闭的时候，执行一下存储过程。
	window.onbeforeunload=function(){  
		//if( applyId != '' ){
			//var command = new L5.Command("com.inspur.cams.drel.his.city.cmd.SamCityHisCmd");
			//command.setParameter("applyRecord",applyDataSet.getCurrent());
			//command.execute("toDuplicateRecord");
			var parent=window.dialogArguments;
			parent.query();
		//}
	} 
}
//新增页面的加载页面
function prepareForInsert(){
	applyDataSet.newRecord({"isFinish":"1","acceptOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
	
	if( organArea.substring(organArea.length-3,organArea.length) == '000'){
		familyDataSet.newRecord({"assistanceMode":"10",belonging:"04","address":address,"apanageName":organName,"apanageCode":organArea});
	}else{
		familyDataSet.newRecord({"domicileName":organName,"domicileCode":organArea,"assistanceMode":"10",belonging:"04","address":address,"apanageName":organName,"apanageCode":organArea});
	}
	
	acceptSurveyDataset.newRecord({"activityId":"accept","surveyResult":"1"});
	acceptDiscussionDataset.newRecord({"activityId":"accept","discussionResult":"1"});
	acceptNoticeDataset.newRecord({"activityId":"accept","noticeResult":"1"});
	checkSurveyDataset.newRecord({"activityId":"check","surveyResult":"1"});
	checkNoticeDataset.newRecord({"activityId":"check","noticeResult":"1"});
	auditSurveyDataset.newRecord({"activityId":"audit","surveyResult":"1"});
	auditNoticeDataset.newRecord({"activityId":"audit","noticeResult":"1"});
	bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"01"});
	buttonDisable();
}
//按钮禁用
function buttonDisable(){
	//L5.getCmp("peopleAdd").setDisabled(true);
	L5.getCmp("houseAdd").setDisabled(true);
	L5.getCmp("estateAdd").setDisabled(true);
	L5.getCmp("supportAdd").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	//L5.getCmp("peopleAdd").setDisabled(false);
	L5.getCmp("houseAdd").setDisabled(false);
	L5.getCmp("estateAdd").setDisabled(false);
	L5.getCmp("supportAdd").setDisabled(false);
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
		familyId=ds.get('familyId');
		familyQueryDataSet.setParameter("applyId",applyId);
		familyQueryDataSet.setParameter("domicileCode",organArea);
		familyQueryDataSet.setParameter("queryDate",getCurYM());
		familyQueryDataSet.load();
		familyQueryDataSet.on("load",loadFamilyQuery);
	}
}
//获得当前日期 2011-05
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
}

function loadFamilyQuery(ds){
	ds.un("load",loadFamilyQuery);
	if(ds.getCount() > 0){
		beginDate=ds.get('BEGIN_DATE');
		endDate = ds.get('END_DATE');
		if(endDate == '3000-12'){
			endDate = '' ;
		}
		assistance_cardNo=ds.get('CARD_NO');
		assistanceMode=ds.get('ASSISTANCE_MODE');
		assistanceMoney=ds.get('ASSISTANCE_MONEY');
		assistanceClassMoney=ds.get('ASSISTANCE_CLASS_MONEY');
		loadAsisstanceClass();//加载分类施保类别字典
	}
}
//加载分类施保类别字典
function loadAsisstanceClass(){
	//加载分类施保类别字典
	var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
	asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='01' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//城市低保
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
	ds.un("load",loadBank);
	if(ds.getCount() == 1){
		ds.set('beginDate',beginDate);
		ds.set('endDate',endDate);
		ds.set('cardNo',assistance_cardNo);
		ds.set('assistanceMode',assistanceMode);
		ds.set('assistanceMoney',assistanceMoney);
		ds.set('assistanceClassMoney',assistanceClassMoney);
		idCard=ds.get('familyCardNo');
		photoId=ds.get("photoId");
		showPhotoAbleEdit(photoId);//加载照片
		if( organArea.substring(organArea.length-3,organArea.length) != '000'){
			ds.set("domicileCode",organArea);
			ds.set("domicileName",organName);
		}
	}
	bankAccountDS.setParameter("FAMILY_ID",familyId);
    bankAccountDS.on("load",loadPeopleListDs);
    bankAccountDS.load();
}
//加载家庭成员基本信息
function loadPeopleListDs(ds){
	
	if(ds.getCount() == 0 ){
		bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"01"});
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
	supportListDataset.on("load",loadAcceptSurveyDs);
}
//加载入户调查信息
function loadAcceptSurveyDs(ds){
  	ds.un("load",loadAcceptSurveyDs);
 	acceptSurveyDataset.load();
    acceptSurveyDataset.on("load",loadAcceptDiscussionDs);
}
//加载评议结果信息
function loadAcceptDiscussionDs(ds){
    ds.un("load",loadAcceptDiscussionDs);
    if(ds.getCount()<1){
		ds.newRecord({"activityId":"accept","applyId":applyId,"surveyResult":"1"});
    }
 	acceptDiscussionDataset.load();
    acceptDiscussionDataset.on("load",loadAcceptNoticeDs);
}
//加载公告信息
function loadAcceptNoticeDs(ds){
    ds.un("load",loadAcceptNoticeDs);
    if(ds.getCount()<1){
    	ds.newRecord({"activityId":"accept","applyId":applyId,"discussionResult":"1"});
    }
 	acceptNoticeDataset.load();
    acceptNoticeDataset.on("load",loadCheck);
}
/*
function loadAcceptNotice(ds){
    ds.un("load",loadAcceptNotice);
    if(ds.getCount()<1){
    	ds.newRecord({"activityId":"accept","applyId":applyId,"noticeResult":"1"});
    }
}
*/
//加载审核信息
function loadCheck(ds){
	 ds.un("load",loadCheck);
    if(ds.getCount()<1){
    	ds.newRecord({"activityId":"accept","applyId":applyId,"noticeResult":"1"});
    }
	checkSurveyDataset.load();
	checkSurveyDataset.on("load",loadcheckSurveyDs);
}
//加载审核评议结果
function loadcheckSurveyDs(ds){
 	ds.un("load",loadcheckSurveyDs);
 	if(ds.getCount()<1){
 		ds.newRecord({"activityId":"check","applyId":applyId,"surveyResult":"1"});
 	}
	checkNoticeDataset.load();
 	checkNoticeDataset.on('load',loadAudit);
}
/*
function loadcheckNotice(ds){
 	ds.un("load",loadcheckNotice);
 	if(ds.getCount()<1){
 		ds.newRecord({"activityId":"check","applyId":applyId,"noticeResult":"1"});
 	}
}
*/
//加载审批信息
function loadAudit(ds){
	ds.un("load",loadAudit);
 	if(ds.getCount()<1){
 		ds.newRecord({"activityId":"check","applyId":applyId,"noticeResult":"1"});
 	}
	auditSurveyDataset.load();
	auditSurveyDataset.on("load",loadauditNoticeDs);	
}
//加载审批评议结果
function loadauditNoticeDs(ds){
 	ds.un("load",loadauditNoticeDs);
 	if(ds.getCount()<1){
 		ds.newRecord({"activityId":"audit","applyId":applyId,"surveyResult":"1"});
 	}
	auditNoticeDataset.load();
	auditNoticeDataset.on("load",loadauditNotice);	
}
function loadauditNotice(ds){
 	ds.un("load",loadauditNotice);
 	if(ds.getCount()<1){
 		ds.newRecord({"activityId":"audit","applyId":applyId,"noticeResult":"1"});
 	}
 	L5.getCmp("saveId").setDisabled(false);
}
//校验身份证
function checkCradNo(obj){
	var cardNo=obj.value;
	if(cardNo==''){
		return;
	}
	if(checkIDCard(obj) != true && !(cardNo.length==18 && cardNo.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		obj.value='';
		return;
	}else if(idCard != cardNo ){
		cardNo=obj.value;
		//相应操作
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
		command.setParameter("cardNo",cardNo);
		command.execute("checkIDCard");
		var errorFlag=command.getReturn("errorFlag");
		var returnFamilyId=command.getReturn("familyId");
		if(errorFlag != '' && typeof(errorFlag)!="undefined" && errorFlag!=null){//有此人享有其他待遇的提示
			L5.Msg.alert("提示",errorFlag);
			obj.value='';
			return;
		}else{
			if(returnFamilyId != '' && typeof(returnFamilyId)!="undefined" && returnFamilyId!=null){
				familyId=returnFamilyId;
				familyDataSet.setParameter("FAMILY_ID",familyId);
			    familyDataSet.on("load",loadBank);
			    familyDataSet.load();
			    applyId = "null";
			}
		}
	}
}
//保存
function save(){
	familyDataSet.set('domicileCode',document.getElementById('lrdwId').value);
	var obj = document.getElementById("familyCardNo");
	checkCradNo(obj);
	buttonDisable();
	if(!saveCheck()){
	   buttonEnabled();
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
	var command = new L5.Command("com.inspur.cams.drel.his.city.cmd.SamCityHisCmd");
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	familyRecord.set("photoId",photoId);//维护照片信息
	command.setParameter("familyRecord",familyDataSet.getCurrent());
	command.setParameter("AssistanceRecords",AssistanceDataset.getAllRecords());
	command.setParameter("acceptSurveyRecord",acceptSurveyDataset.getCurrent());
	command.setParameter("acceptDiscussionRecord",acceptDiscussionDataset.getCurrent());
	command.setParameter("acceptNoticeRecord",acceptNoticeDataset.getCurrent());
	
	command.setParameter("bankAccount",bankAccountDS.getCurrent());	
	
	command.setParameter("checkSurveyRecord",checkSurveyDataset.getCurrent());
	command.setParameter("checkNoticeRecord",checkNoticeDataset.getCurrent());
	command.setParameter("auditSurveyRecord",auditSurveyDataset.getCurrent());
	command.setParameter("auditNoticeRecord",auditNoticeDataset.getCurrent());
	command.execute("insertInfo");
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
			photoId=command.getReturn("photoId");
			var width = 1000;
		    var height = 600;
			var url="../../application/city/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1&hrefFlg="+getCurrent()+"&applyId="+applyId;
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
			buttonEnabled();
		}else{			
			L5.Msg.alert("提示","保存成功！",function(){			
				photoId=command.getReturn("photoId");
				if(applyId==''){
					applyId=command.getReturn("applyId");
				}
				loadInfo();
				buttonEnabled();
			});
		}
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
	var bankAccountDSIsValidate = bankAccountDS.isValidate();
	if(bankAccountDSIsValidate != true){
		L5.Msg.alert("提示",bankAccountDSIsValidate);
		return false;
	}
	
	
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	
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
//关闭
function returnBack(){
	//var parent=window.dialogArguments;
	//parent.query();
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
	if(!hasSelef){
		var width = 1000;
	    var height = 600;
		var url="../../application/city/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1"+"&hrefFlg="+getCurrent()+"&applyId="+applyId;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		setTimeout('save()',10);
	}else{		
		var width = 1000;
	    var height = 600;
		var url="../../application/city/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&hrefFlg="+getCurrent()+"&applyId="+applyId;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		setTimeout('save()',10);
	}
}
function countTotle(){
}
//修改人员信息
function changePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 1000;
	    var height = 600;
		var url="../../application/city/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&peopleId="+records[0].get('PEOPLE_ID')+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&hideFlag="+hideFlag+"&isChangeUpdate=1";
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		//setTimeout('save()',1);
		setTimeout('save()',10);
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
				var delId=records[0].get("PEOPLE_ID");
				var command=new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
				command.setParameter("delId", delId);
				command.setParameter("familyId", familyId);
				command.execute("deletePeopleInfo");
				var assistancePeopleNum=command.getReturn("assistancePeopleNum");
				var monthIncome=command.getReturn("monthIncome");
				var monthAverageIncome=command.getReturn("monthAverageIncome");
				var peopleNum=command.getReturn("peopleNum");
				var yearIncome=command.getReturn("yearIncome");
				var yearAverageIncome=command.getReturn("yearAverageIncome");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功！",function(){
						peopleListDataSet.remove(records[0]);
						familyDataSet.set("assistancePeopleNum",assistancePeopleNum);
						familyDataSet.set("monthIncome",monthIncome);
						familyDataSet.set("monthAverageIncome",monthAverageIncome);
						familyDataSet.set("peopleNum",peopleNum);
						familyDataSet.set("yearIncome",yearIncome);
						familyDataSet.set("yearAverageIncome",yearAverageIncome);
						setTimeout('save()',10);
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
	var url="../../comm/houseEdit.jsp?familyId="+familyId+"&hrefFlg="+getCurrent();
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
		var url="../../comm/houseEdit.jsp?familyId="+familyId+"&houseId="+records[0].get('houseId')+"&hrefFlg="+getCurrent();
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
	var url="../../comm/estateEdit.jsp?familyId="+familyId+"&hrefFlg="+getCurrent();
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
		var url="../../comm/estateEdit.jsp?familyId="+familyId+"&estateId="+records[0].get('estateId')+"&hrefFlg="+getCurrent();
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
	var width = 850;
    var height = 200;
	var url="../../comm/supportEdit.jsp?familyId="+familyId+"&assistanceType=01"+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//修改赡扶抚养义务人员
function changeSupport(){
	var grid = L5.getCmp('supportPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 850;
	    var height = 200;
		var url="../../comm/supportEdit.jsp?familyId="+familyId+"&supportId="+records[0].get('supportId')+"&assistanceType=01"+"&hrefFlg="+getCurrent();
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
				command.setParameter("assistanceType","01");
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
/**
 * 选择户籍地行政区划窗口
*/
function func_ForApanageSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ cityCode + "&organName="
					+ escape(encodeURIComponent(cityName))+"&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("apanageCode").value = list[0];
		familyDataSet.set('apanageName',list[1]);
		familyDataSet.set('apanageCode',list[0]);
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
//变更户主
function changePeopleRelationshipType(){
	var win=L5.getCmp("changeApplyPeople");
	win.show();
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
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
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
var classMode = '';
var classMoney= 0 ;
//选择分类施保类别之后自动回填分类施保金
function getClassMoney(value){
	var command = new L5.Command("com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassCmd");
	command.setParameter("classCode",value);
	command.setParameter("organArea",organArea.substring(0,6) + "000000");
	command.setParameter("nowTime",nowTime);
	command.setParameter("assistanceType","01");
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