var familyId='';
var applyDate='';
var applyReason='';
var photoId='';
var familySex='';

var organCode='';
var fullName='';

function init(){
	
	peopleListDataSet.on("datachanged",getAverageUserArea);
	houseListDataset.on("datachanged",getAverageUserArea);
	if(method=="insert"){
		document.getElementById("assistanceModeID").value='10';
		prepareForInsert();//新增页面的加载页面
	}else{
		loadInfo();//修改时加载页面
	}
	
}	

//新增页面的加载页面
function prepareForInsert(){
	//移除审核审批意见的panel
	
	applyDataSet.newRecord({"isFinish":"0"});
	if(ActivityName == "check"){
		familyDataSet.newRecord({"assistanceMode":"10","applyDate":nowTime,"address":address,
		"regId":regId,"regOrg":regOrg,"regOrgName":regOrgName,"regPeople":regPeople,"regTime":regTime,"regOrgType":regOrgType,"apanageName":organName,"apanageCode":organArea});
		
	}else{	
		familyDataSet.newRecord({"domicileName":organName,"domicileCode":organArea,"assistanceMode":"10","applyDate":nowTime,"address":address,
		"regId":regId,"regOrg":regOrg,"regOrgName":regOrgName,"regPeople":regPeople,"regTime":regTime,"regOrgType":regOrgType,"apanageName":organName,"apanageCode":organArea});
	}
	
	buttonDisable();
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("submitId").setDisabled(true);
	L5.getCmp("peopleAdd").setDisabled(true);
	L5.getCmp("houseAdd").setDisabled(true);
	L5.getCmp("estateAdd").setDisabled(true);
	L5.getCmp("supportAdd").setDisabled(true);
	L5.getCmp("filesAdd").setDisabled(true);
	L5.getCmp("filesUpload").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("submitId").setDisabled(false);
	L5.getCmp("peopleAdd").setDisabled(false);
	L5.getCmp("houseAdd").setDisabled(false);
	L5.getCmp("estateAdd").setDisabled(false);
	L5.getCmp("supportAdd").setDisabled(false);
	L5.getCmp("filesAdd").setDisabled(false);
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
		
		familyId=ds.get('familyId');
		loadFamilyDs();
	}
}

//加载家庭信息
function loadFamilyDs(){
	
    familyDataSet.setParameter("FAMILY_ID",familyId);
    familyDataSet.on("load",loadPeopleListDs);
    familyDataSet.load();
}
//加载家庭成员基本信息
function loadPeopleListDs(ds){
	if(ds.getCount() == 1){
		ds.set('applyReason',applyReason);
		ds.set('applyDate',applyDate);
		
		if(ActivityName != "check"){
			ds.set("domicileCode",organArea);
			ds.set("domicileName",organName);
		}
		photoId=ds.get("photoId");
		showPhotoAbleEdit(photoId);//加载照片
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
   // ds.on("load",getAverageUserArea);
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
    //supportListDataset.on("load",loadFromCheck);
}
//加载申请材料信息
function loadFilesListDs(ds){
    ds.un("load",loadFilesListDs);
    if(applyId != ''){
    	filesListDataset.setParameter("APPLY_ID",applyId);
    	filesListDataset.setParameter("FILE_TYPE@IN","101,102,201,202,203,204,205,206,207,208,209,210,301,001,000");
		filesListDataset.load();	 
    }
}
function countTotle(){}
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
		
		averageArea = (HouseArea/familyNo).toFixed(2);
		
	}
	if(!isNaN(averageArea)){
		$("averageArea").innerHTML=averageArea;
	}else{
		$("averageArea").innerHTML=0;
	}
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
	}else if(!checkIDifStrange(cardNo,organArea)){
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
	
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	applyRecord.set("assignmentId",assignmentId);
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	familyRecord.set("photoId",photoId);//维护照片信息
	command.setParameter("familyRecord",familyDataSet.getCurrent());
	
	if(ActivityName == "check"){
		command.setParameter("acceptDiscussionRecord",acceptDiscussionRecord.getCurrent());
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
			var url="samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1&hrefFlg="+getCurrent()+"&applyId="+applyId+"&assistanceModeValue="+assistanceModeValue;
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
			buttonEnabled();
		}else{			
			L5.Msg.alert("提示","保存成功！",function(){			
				photoId=command.getReturn("photoId");
				if(applyId==''){
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
		 L5.getCmp("submitId").setDisabled(true);
	}
}
//保存校验
function saveCheck(){
	var familyIsValidate = familyDataSet.isValidate();
	if(familyIsValidate != true){
		L5.Msg.alert("提示",familyIsValidate);
		return false;
	}
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	
	if(familyRecord.get("applyReason") == '' ){
		L5.Msg.alert("提示","校验未通过："+"申请理由不能为空!");
		return false;
	}
	if(familyRecord.get("domicileCode") == '' || familyRecord.get("domicileName") == ''){
		L5.Msg.alert("提示","校验未通过："+"地区不能为空!");
		return false;
	}
	
	//邮编
	var familyPostcode=familyRecord.get('familyPostcode');
	if(familyPostcode!= '' && _isPostCode(familyPostcode) != true){
		L5.Msg.alert("提示","校验未通过："+"家庭基本信息中居住地邮编格式不正确");
		return false;
	}
	
	return true;
}
//提交
function submitApply(){
	buttonDisable();
	L5.getCmp("saveId").setDisabled(true);
	if(!submitApplyCheck()){
	   	L5.getCmp("saveId").setDisabled(false);
	   return ;
	}
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	applyRecord.set("assignmentId",assignmentId);
	if(ActivityName == "check"){
		applyDataSet.getCurrent().set("curActivityId","check");
	}
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	familyRecord.set("photoId",photoId);//维护照片信息
	command.setParameter("familyRecord",familyDataSet.getCurrent());
	command.setParameter("assignmentId",assignmentId);
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
			L5.getCmp("submitId").setDisabled(false);
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
	//校验上传文件，必须上传户口本101，申请书201
	var fileDs = L5.DatasetMgr.lookup("filesListDataset");
	if(fileDs.find("fileType","101",0)==-1&&fileDs.find("fileType","201",0)==-1){
		if(fileDs.find("fileType","101",0)==-1){
			L5.Msg.alert("提示","上传文件材料必须包含户口本信息文件");
		}
		if(fileDs.find("fileType","201",0)==-1){
			L5.Msg.alert("提示","上传文件材料必须包含申请书信息文件");
		}
		return false;
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
				var delId=records[0].get("PEOPLE_ID");
				//获取救助金计算方式,以此判断后台是否需要计算户月保障金
				var assistanceModeValue =document.getElementById("assistanceModeID").value;
				
				var command=new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
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
	var width = 850;
    var height = 200;
    //获取救助金计算方式,以此判断后台是否需要计算户月保障金
	var assistanceModeValue =document.getElementById("assistanceModeID").value;
	
	var url="../../../comm/supportEdit.jsp?familyId="+familyId+"&assistanceType=01"+"&applyId="+applyId+"&hrefFlg="+getCurrent()+"&assistanceModeValue="+assistanceModeValue;
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
	    //获取救助金计算方式,以此判断后台是否需要计算户月保障金
		var assistanceModeValue =document.getElementById("assistanceModeID").value;
	
		var url="../../../comm/supportEdit.jsp?familyId="+familyId+"&supportId="+records[0].get('supportId')+"&assistanceType=01"+"&applyId="+applyId+"&hrefFlg="+getCurrent()+"&assistanceModeValue="+assistanceModeValue;
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
	var width = screen.width-100;
    var height = screen.height-100;
	var url="../../../comm/scanFile.jsp?applyId="+applyId+"&hrefFlg="+getCurrent();
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
