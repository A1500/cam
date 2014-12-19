function init() {
	if(method=="INSERT"){
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.newRecord();
		aspChiefDataset.newRecord({"taskCode":taskCode,"sorgDuties":"00012","sorgId":sorgId});
		var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
		var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"taskCode":taskCode, "curActivity":"申请名称核准", "curOpinionId":"1"});
		somElectronicDataSet_load();
	}else if(method=="UPDATE"){
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
		hiddenCnNamePrefixSuffix();
	}
	opinionDataSet.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
}

function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	taskCode=somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldPeopleDataSet.load();
	somHeldOrganDataSet.load();
	somElectronicDataSet_load();
	
	aspChiefDataset.setParameter("SORG_ID@=", sorgId);
	aspChiefDataset.load();
}
// 增加筹备人（自然人）
function addHeldPeople(){
	somHeldPeopleDataSet.newRecord();
}
// 删除筹备人（自然人）
function delHelpPeople(){
	var record=somHeldPeopleDataSet.getCurrent();
	if(record!=null)
		somHeldPeopleDataSet.remove(record);
}
// 增加筹备人（单位）
function addHeldOrgan(){
	somHeldOrganDataSet.newRecord();
}
// 删除筹备人（单位）
function delHeldOrgan(){
	var record=somHeldOrganDataSet.getCurrent();
	if(record!=null)
		somHeldOrganDataSet.remove(record);
}

//将前后缀及中间部分组装给基金会名称并赋值给record
function assembleCnName(somOrganRecord){
	var cnNamePrefix=document.getElementById("cnNamePrefix");
	var cnNameSuffix=document.getElementById("cnNameSuffix").innerHTML;
	var cnName=document.getElementById("cnName");
	//处理异常情况，如果已经组装过的不在进行组装
	var cnNamePrefixLenth = cnNamePrefix.value.length;
	if(cnNamePrefix.value!=""&&cnNamePrefix.value==cnName.value.substring(0,cnNamePrefixLenth)){
		return true;
	}
	//组装
	if(cnNamePrefix.value!=""&&cnNameSuffix!=""){
		somOrganRecord.set("cnName", cnNamePrefix.value+cnName.value+cnNameSuffix);
		return true;
	}else{
		L5.Msg.alert("请选择申请立项社团（分支、代表机构）名称前缀及后缀！");
		return false;
	}
	return true;
}
//隐藏基金会名称前缀和后缀方法
function hiddenCnNamePrefixSuffix(){
		var cnNamePrefix=document.getElementById("cnNamePrefix");
		var cnNameSuffix=document.getElementById("cnNameSuffix");
		var cnName=document.getElementById("cnName");
		//var butCheckCnName=document.getElementById("butCheckCnName");
		cnNamePrefix.style.display = "none";
		cnNameSuffix.style.display = "none";
		cnName.style.width = "95%";
		//butCheckCnName.style.display = "none";
}
//保存
function save(){
	//名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的基金会名称已存在");
		return;
	}	
	if(checkCnNameNum != 0){
		L5.MessageBox.confirm('确定', '存在'+checkCnNameNum+'个类似名称的基金会！你确定要保存吗？',function(sta){
			if(sta=="yes"){
				saveInfo();
				return;
			}else{
				return;
			}
		});
	}else{
		saveInfo();
	}
}
function saveInfo(){
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganRecord=somOrganDataSet.getCurrent();
	
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	
	var somPrepareValidate = somOrganDataSet.isValidate();
	var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
	var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somPrepareValidate != true){
		L5.Msg.alert("提示",somPrepareValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	if(somHeldPeopleValidate != true){
		L5.Msg.alert("提示",somHeldPeopleValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}
	if(somHeldOrganValidate != true){
		L5.Msg.alert("提示",somHeldOrganValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	var aspValidate=aspChiefDataset.isValidate();
	if(aspValidate != true){
		L5.Msg.alert("提示",aspValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		var idCard=somHeldPeopleRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}
	//将前后缀及中间部分组装给基金会名称并赋值给record
	if(method=="INSERT"){
		if(!assembleCnName(somOrganRecord)){
			return false;
		}		
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	somOrganRecord.set("sorgId",sorgId);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	
	command.setParameter("aspChief", aspChiefDataset.getCurrent());
	if(method=="INSERT"){
		command.execute("insertReportInfo");
	}else if(method=="UPDATE"){
		command.execute("updateReportInfo");
	}
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function submit() {
	//名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的基金会名称已存在");
		return;
	}	
	if(checkCnNameNum != 0){
		L5.MessageBox.confirm('确定', '存在'+checkCnNameNum+'个类似名称的基金会！你确定要提交吗？',function(sta){
			if(sta=="yes"){
				submitInfo();
				return;
			}else{
				return;
			}
		});
	}else{
		submitInfo();
	}
}
function submitInfo(){	
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganRecord=somOrganDataSet.getCurrent();
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	
	var somPrepareValidate = somOrganDataSet.isValidate();
	var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
	var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
	var somApplyValidate= somApplyDataSet.isValidate();
	if(somPrepareValidate != true){
		L5.Msg.alert("提示",somPrepareValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	if(somHeldPeopleValidate != true){
		L5.Msg.alert("提示",somHeldPeopleValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}
	if(somHeldOrganValidate != true){
		L5.Msg.alert("提示",somHeldOrganValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	var aspValidate=aspChiefDataset.isValidate();
	if(aspValidate != true){
		L5.Msg.alert("提示",aspValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		var idCard=somHeldPeopleRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}
	//将前后缀及中间部分组装给基金会名称并赋值给record
	if(method=="INSERT"){
		if(!assembleCnName(somOrganRecord)){
			return false;
		}
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	if(method=="INSERT"){
		somOrganRecord.set("sorgId",sorgId);
	}
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	command.setParameter("aspChief", aspChiefDataset.getCurrent());
	if(method=="INSERT"){
		command.execute("saveAndSendReport");
	}else if(method=="UPDATE"){
		command.execute("updateForSendReport");
	}
	if(!command.error){
		L5.Msg.alert('提示','成功提交至下一环节!',function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//返回
function returnClick(){
	history.go(-1);
}
//向dataset中增加数据
function addRecordToDataset(dataset,record){
	var methodName=window.dialogArguments.methodName;
	var ret=window.dialogArguments.activityList;
	dataset.removeAll();
	dataset.add(record);
}
function getValue() {
	//如果起先数据为空，则直接调用增加方法
	if(somOrganDataSet.getCount()==0){
		somOrganDataSet.newRecord();
		return;
	}
	somHeldPeopleDataSet.baseParams["SORG_ID@="] = idField;
	somHeldPeopleDataSet.load();
	somHeldOrganDataSet.baseParams["SORG_ID@="] = idField;
	somHeldOrganDataSet.load();
}
function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("somOrganDataSet");
	if(dataset.movePrev()){	
	  	somHeldPeopleDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somHeldPeopleDataSet.load();		
	  	somHeldOrganDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somHeldOrganDataSet.load();		
		if(e)e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("somOrganDataSet");
	if(dataset.moveNext()){
		somHeldPeopleDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somHeldPeopleDataSet.load();
		somHeldOrganDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somHeldOrganDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;
}

//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		command.setParameter("sorgId",sorgId);
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
}

function validateIdcard(){
	if(_$("idCard") != ""){
		if(checkIDCard($("idCard")) == true){
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}
}
//----------------------------------
//检验输入社团名称的唯一性
var cnNameNum = "";
var checkCnNameNum = "";
function checkSole(){
	var cnName=document.getElementById("cnName").value;
	var cnNamePrefix=document.getElementById("cnNamePrefix").value;
	var cnNameSuffix=document.getElementById("cnNameSuffix").innerHTML;
	if(method=="INSERT"){
		if(cnName == ""||cnNamePrefix == ""||cnNameSuffix == ""){
			return;
		}
		cnName = cnNamePrefix+cnName+cnNameSuffix;
	}else{
		if(cnName == ""){
			return;
		}
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",cnName);
	command.setParameter("sorgId",sorgId);
	command.execute("cnNameUK");
	cnNameNum = command.getReturn("cnNameNum");
	if(cnNameNum != 0){
		L5.Msg.alert("提示","申请设立基金会名称已经存在，请重新输入！");
		return;
	}else{
		if(method=="INSERT"){
			checkCnName();
		}
	}
}
function checkCnName(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",_$("cnName"));
	command.setParameter("sorgType","J");
	command.setParameter("ifBranch","0");
	command.setParameter("morgArea",morgArea);
	command.execute("cnNameSame");
	checkCnNameNum = command.getReturn("cnNameSameNum");
	if(checkCnNameNum>0){
		L5.Msg.alert("提示","存在"+checkCnNameNum+"个类似名称的基金会！",function(){
			var OrganDataSetForQuery=L5.DatasetMgr.lookup("OrganDataSetForQuery");
			OrganDataSetForQuery.setParameter("CN_NAME@like",_$("cnName"));
			OrganDataSetForQuery.setParameter("SORG_TYPE@=","J");
			OrganDataSetForQuery.setParameter("IF_BRANCH@=","0");
			OrganDataSetForQuery.setParameter("MORG_AREA@=",morgArea);
			OrganDataSetForQuery.load();	
			var win=L5.getCmp('winCheckCnName');
			win.show();
		});
	}
}
function closeCheckCnName(){
	var win=L5.getCmp('winCheckCnName');
	win.hide();
}
//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
//校验身份证号
function validIDCard(o){
	if(o=="") return true;
	if(o=="000000000000000000") return true;
	var val=o.toUpperCase();
	if(val.length==15){
		if(!is15IDCard(val)){
			return false;
		}
	}else if(val.length==18){
		if(!is18IDCard(val)){
			return false;
		}
	}else{
		return false;
	}
	return true;
}