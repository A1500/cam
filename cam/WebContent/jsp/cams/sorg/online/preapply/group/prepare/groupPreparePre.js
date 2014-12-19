var existSorgid='';
function init() {
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("0");
	somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	opinionDataSet.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	//房屋来源意见过滤
	resideSourceDataSet.filterBy(function(record, id){
		if("2".indexOf(record.get('value'))>-1){
			return record;
		}
		if("3".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	
	//电子档案上传窗口关闭事件
	if(L5.getCmp("uploadList")){
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
}
function loadInfo(){
	var record=somApplyDataSet.getCurrent();
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
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
		//根据名称查是否已经名称核准，并进行修改sorgid操作
		checkOrganInfoAndDealSorgId(_$("cnName"));
	});
	
	somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somAspchiefDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldPeopleDataSet.load();
	somHeldOrganDataSet.load();
	somAspchiefDataSet.load();
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
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
// 增加拟任负责人
function addAspchief(){
	somAspchiefDataSet.newRecord();
}
// 删除拟任负责人
function delAspchief(){
	var record=somAspchiefDataSet.getCurrent();
	if(record!=null)
		somAspchiefDataSet.remove(record);
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
	var somAspchiefValidate = somAspchiefDataSet.isValidate();
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
	if(somAspchiefValidate != true){
		L5.Msg.alert("提示",somAspchiefValidate);
		return false;
	}
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		return false;
	}
	//邮编
	if(_$("sorgPost")!=""&&_isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		var idCard=somHeldPeopleRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
		somHeldPeopleRecords[i].state = L5.model.Record.STATE_NEW;
		somHeldPeopleRecords[i].set("sorgId",sorgId);
	}
	var somHeldOrganRecords=somHeldOrganDataSet.getAllRecords();
		for(var i=0;i<somHeldOrganRecords.length;i++){
			somHeldOrganRecords[i].state = L5.model.Record.STATE_NEW;
			somHeldOrganRecords[i].set("sorgId",sorgId);
	}
	var somAspchiefRecords=somAspchiefDataSet.getAllRecords();
	for(var i=0;i<somAspchiefRecords.length;i++){
		var idCard=somAspchiefRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("3");
			return;
		}
		somAspchiefRecords[i].state = L5.model.Record.STATE_NEW;
		somAspchiefRecords[i].set("sorgId",sorgId);
	}
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupPrepareCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleRecords);
	command.setParameter("somHeldOrganRecord", somHeldOrganRecords);
	command.setParameter("somAspchiefRecord", somAspchiefRecords);
	
	command.execute("create");
	if(!command.error){
		var url='jsp/cams/sorg/online/preapply/group/prepare/groupPreparePreList.jsp';
		L5.Msg.alert('提示','保存成功！',function(){	
			updateOnlineStatusAccept();
			L5.forward(url);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function submit() {
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganRecord=somOrganDataSet.getCurrent();
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somPrepareValidate = somOrganDataSet.isValidate();
	var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
	var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
	var somAspchiefValidate = somAspchiefDataSet.isValidate();
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
	if(somAspchiefValidate != true){
		L5.Msg.alert("提示",somAspchiefValidate);
		return false;
	}
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		return false;
	}
	//邮编
	if(_$("sorgPost")!=""&&_isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		var idCard=somHeldPeopleRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
		somHeldPeopleRecords[i].state = L5.model.Record.STATE_NEW;
		somHeldPeopleRecords[i].set("sorgId",sorgId);
	}
	var somHeldOrganRecords=somHeldOrganDataSet.getAllRecords();
		for(var i=0;i<somHeldOrganRecords.length;i++){
			somHeldOrganRecords[i].state = L5.model.Record.STATE_NEW;
			somHeldOrganRecords[i].set("sorgId",sorgId);
	}
	var somAspchiefRecords=somAspchiefDataSet.getAllRecords();
	for(var i=0;i<somAspchiefRecords.length;i++){
		var idCard=somAspchiefRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("3");
			return;
		}
		somAspchiefRecords[i].state = L5.model.Record.STATE_NEW;
		somAspchiefRecords[i].set("sorgId",sorgId);
	}
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupPrepareCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleRecords);
	command.setParameter("somHeldOrganRecord", somHeldOrganRecords);
	command.setParameter("somAspchiefRecord", somAspchiefRecords);
	command.execute("createAndSend");
	if(!command.error){
		var url='jsp/cams/sorg/online/preapply/group/prepare/groupPreparePreList.jsp';
		L5.Msg.alert('提示','成功提交至下一环节！',function(){	
		updateOnlineStatusAccept();
			L5.forward(url);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
function send() {
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganRecord=somOrganDataSet.getCurrent();
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		return false;
	}
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupPrepareCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.execute("updateAndSend");
	if(!command.error){
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				var url='jsp/cams/sorg/online/preapply/group/prepare/groupPreparePreList.jsp';
				L5.forward(url);
			});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印受理通知
function printAccept(){
	cnName=_$('cnName');
	if(cnName==''){
		L5.Msg.alert('提示',"请先录入社团中文名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));	
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	cnName=_$('cnName');
	if(cnName==''){
		L5.Msg.alert('提示',"请先录入社团中文名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回
function returnClick(){
	history.go(-1);
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
	somAspchiefDataSet.baseParams["SORG_ID@="] = idField;
	somAspchiefDataSet.load();
}
function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("somOrganDataSet");
	if(dataset.movePrev()){	
	  	somHeldPeopleDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somHeldPeopleDataSet.load();		
	  	somHeldOrganDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somHeldOrganDataSet.load();		
	  	somAspchiefDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somAspchiefDataSet.load();
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
		somAspchiefDataSet.baseParams["SORG_ID@="] = document.forms[0].sorgId.value;
		somAspchiefDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;
}

//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
		command.setParameter("cnName",_$("cnName"));
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
//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}
//打印名称核准通知书
function printInform(){

}
function checkOrganInfoAndDealSorgId(name){
	if(name.trim() == ''){
		return;
	}
	if(nameChangeFlag=="0"){
		loadOrganInfo(name);
	}else{
		if(name==newName){
			somOrganDataSet.set("cnName",name);
		}else{
			loadOrganInfo(name);
		}
	}
}
function loadOrganInfo(name){
	somOrganDataSetQuery.setParameter("CN_NAME",name);
	somOrganDataSetQuery.setParameter("SORG_STATUS","9");
	somOrganDataSetQuery.setParameter("SORG_TYPE","S");
	somOrganDataSetQuery.load();
	somOrganDataSetQuery.on('load',function(){
		if(somOrganDataSetQuery.getCount() == 0){
			L5.Msg.alert("提示","该社会团体名称尚未成功核准或已经筹备，无法进行筹备登记！");
			somOrganDataSet.newRecord();
			return;
		}else{
			//如果查到的话将这笔预受理业务sorgid更新之前系统已经存在的那条数据的，因为筹备在保存的时候是做的update更新的名称核准的数据，taskcode不用更新
			sorgId=somOrganDataSetQuery.get('sorgId');
			somOrganDataSet.getCurrent().set("sorgId",sorgId);
			somApplyDataSet.getCurrent().set("sorgId",sorgId);
			somApplyDataSet.set("borgName",somOrganDataSetQuery.get('borgName'));
			cnName=name;
		}
		somApplyDataSet.getCurrent().set("curOpinion","");
	});
}
/*******************************以下为名称变更一系列函数******************************/
var nameChangeFlag="0";
var oldName="";
var count=0;
var newName="";
//名称变更
function changeName(){
	cnName=_$('cnName');
	if(cnName==''){
		L5.Msg.alert('提示',"不存在要变更的社团名称，请先录入社团中文名称！");
		return;
	}
	if(count==0){
		oldName=cnName;
	}
	var win=L5.getCmp("changeName");
	win.show();
	document.getElementById('oldName').value=oldName;
	document.getElementById('newName').value="";
}
//名称变更确定
function confirmWin(){
	newName=document.getElementById('newName').value;
	if(oldName==newName){
		L5.Msg.alert('提示',"名称未作更改，请重新填写！");
		document.getElementById('newName').value="";
		return;
	}
	if(checkSorgName(newName)){
		document.getElementById('newName').value="";
	}else{
		var win=L5.getCmp("changeName");
		win.hide();
		nameChangeFlag="1";
		document.getElementById('cnName').value=newName;
		somApplyDataSet.getCurrent().set("curOpinion","社团名称由 "+oldName+" 变更为 "+newName);
		somOrganDataSet.set("cnName",newName);
		count++;
	}
}
//名称变更关闭
function closeWin(){
	var win=L5.getCmp("changeName");
	win.hide();
}
//名称检查是否重复
function checkSorgName(name){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",name);
	command.execute("cnNameUK");
	cnNameNum = command.getReturn("cnNameNum");
	if(cnNameNum != 0){
		L5.Msg.alert("提示","更改的名称已经存在，请重新输入！");
		return true;
	}
	return false;
}
/*******************************名称变更一系列函数结束******************************/