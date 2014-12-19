function init() {
	if(method=="INSERT"){
		if(sorgType== '1'){
			somOrganDataSet.newRecord({"cnName":userId,"ifBranch":'0',"morgName":userId,"morgArea":morgArea});
		}else if(sorgType== '2'){
			somOrganDataSet.newRecord({"ifBranch":'1',"sorgKind":'1',"morgName":userId,"morgArea":morgArea});
		}else if(sorgType== '3'){
			somOrganDataSet.newRecord({"ifBranch":'1',"sorgKind":'2',"morgName":userId,"morgArea":morgArea});
		}
		somApplyDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId, "curActivity":"受理", "curOpinionId":"1","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId});
		aspChiefDataset.newRecord({"taskCode":taskCode,"sorgDuties":"00012","sorgId":sorgId});
		somElectronicDataSet_load();
	}else if(method=="UPDATE"){
		somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);

		somOrganDataSet.on("load",function(){
			//页面显示业务主管单位信息
			var borgName = somOrganDataSet.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		});
	}else{
		somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
	}
	if(method =="INSERT"){
		if(sorgType== '1' ){
			document.getElementById('nameTD').style.display='block';
		}else{
			document.getElementById('branchNameTD').style.display='block';
		}
	}else if(method =="UPDATE"){
		document.getElementById('nameTD').style.display='block';
	}
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
}

function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	taskCode=somApplyDataSet.get('taskCode');

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
	if(sorgType != '1'){
		return true;
	}
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

	}
	return true;
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
	if(method=="INSERT" || method=="UPDATE"){
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
		var somHeldPeopleRecords=somHeldPeopleDataSet.getAllChangedRecords();
		for(var i=0;i<somHeldPeopleRecords.length;i++){
			var idCard=somHeldPeopleRecords[i].get("idCard");
			if(idCard!="" && validIDCard(idCard)!=true){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
				L5.getCmp("tab").setActiveTab("1");
				return;
			}
		}
		if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
		//将修改后的业务主管单位维护进organ
		somOrganRecord.set('borgName',document.getElementById("borgName").value);
	}

	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	somOrganRecord.set("sorgId",sorgId);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	command.setParameter("aspChief", aspChiefDataset.getCurrent());

	command.execute("saveNameApproval");
	if(!command.error){
		L5.Msg.alert('提示','保存成功！');
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