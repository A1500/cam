function init() {
	if(method=="INSERT"){
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.newRecord({"cnName":userId,"ifBranch":'0',"morgName":userId,"morgArea":morgArea,"currency":"人民币"});
		var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
		var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"cnName":userId,"curActivity":"受理","taskCode":taskCode,"sorgId":sorgId, "curActivity":"受理", "curOpinionId":"1","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId});
		aspChiefDataset.newRecord({"taskCode":taskCode,"sorgId":sorgId});
		somElectronicDataSet_load();
	}else if(method=="UPDATE"){
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
		somElectronicDataSet_load();
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
	somOrganDataSet.on("load",function(){
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = somOrganDataSet.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}
	});
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldPeopleDataSet.load();
	somHeldOrganDataSet.load();
	aspChiefDataset.setParameter("SORG_ID@=", sorgId);
	aspChiefDataset.load();
	aspChiefDataset.on('load',function(){
			if(aspChiefDataset.getCount()==0){
				aspChiefDataset.newRecord({"taskCode":taskCode,"sorgId":sorgId});
			}
		});
	somElectronicDataSet_load();
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

//保存
function save(){
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
		return false;
	}
	if(somHeldPeopleValidate != true){
		L5.Msg.alert("提示",somHeldPeopleValidate);
		return false;
	}
	if(somHeldOrganValidate != true){
		L5.Msg.alert("提示",somHeldOrganValidate);
		return false;
	}
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		return false;
	}
	var aspValidate=aspChiefDataset.isValidate();
		if(aspValidate != true){
			L5.Msg.alert("提示",aspValidate);
			L5.getCmp("tab").setActiveTab("0");
			return false;
		}
	/**
	//将前后缀及中间部分组装给民办非企业单位名称并赋值给record
	if(method=="INSERT"){
		if(!assembleCnName(somOrganRecord)){
			return false;
		}
	}
	**/

	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllChangedRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		somHeldPeopleRecords[i].set("ifChief","0");
	}
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.ungov.cmd.SomUngovOnlineCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	somOrganRecord.set("sorgId",sorgId);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleRecords);
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	command.setParameter("somAspchiefRecord", aspChiefDataset.getAllRecords());
	command.execute("saveNameApproval");
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			somHeldPeopleDataSet.commitChanges();
			somHeldOrganDataSet.commitChanges();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
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


function validateIdcard(){
	if(_$("idCard") != ""){
		if(checkIDCard($("idCard")) == true){
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}
}
//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}
//校验身份证号
function validIDCard(args){
	var val=args[0].toUpperCase();
	if(val=="") return true;
	if(val=="000000000000000000") return true;

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
//打印受理通知
function printAccept(){
	var printSorgName=somOrganDataSet.get('cnName');
	if(printSorgName==''){
		L5.Msg.alert('提示',"请先录入申请设立民办非企业单位名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(printSorgName));
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	var printSorgName=somOrganDataSet.get('cnName');
	if(printSorgName==''){
		L5.Msg.alert('提示',"请先录入申请设立民办非企业单位名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(printSorgName));
	window.open(url);
}

function checkIdCardAndFillOther(obj){
	if(checkIDCard(obj) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}else{
		var record = aspChiefDataset.getCurrent();
		//回填出生年月
		record.set("birthday",getBirthByCode(obj.value));
	}
}
function validDate(args){
	var val=args[0];
	if(val=="") return true;
	var objRegExp = /^(\d{4})\-(\d{2})$/
	if(!objRegExp.test(val)) {
		return "不符合YYYY-mm格式，请检查！";
	}
	return true;
}