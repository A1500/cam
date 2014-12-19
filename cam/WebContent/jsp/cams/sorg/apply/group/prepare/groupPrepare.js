var sorgId='';
var applyType="001";
function init() {
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("0");
	if(method == 'INSERT'){
		somOrganDataSet.newRecord();
		somApplyDataSet.newRecord({"taskCode":taskCode,"curActivity":"受理", "curOpinionId":"1"});
		somElectronicDataSet_load();
	}else{
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
	}
	//过滤tab页
	if(method == "yiban"){
		L5.getCmp("tab").remove(6);
	}
	
	//房屋来源意见过滤
	if(act=='accept'&&method=='daiban'){
		resideSourceDataSet.filterBy(function(record, id){
			if("2".indexOf(record.get('value'))>-1){
				return record;
			}
			if("3".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	}
	
	//电子档案上传窗口关闭事件
	if(L5.getCmp("uploadList")){
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
	
	//过滤意见枚举，去掉补齐补正
	if(act == 'examin' || act == 'check' || act == 'audit' ){
	}else{
			opinionDataSet.filterBy(function(record, id){
				if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
					return record;
				}
			});
	}
	if(act=='inform'){//是通知受理人
		var tab = L5.getCmp("tab");
		for(var i = tab.items.length-1;i>=0;i--){
			tab.setActiveTab(i);
		}
		document.getElementById("curOpinionId").disabled="disabled";
	}
	L5.getCmp("aspchiefGrid").on("cellclick",getColCode);
	L5.getCmp("aspchiefGrid").on("afteredit",fillHeldPeople);
}
//当前编辑列
var editColumn;
//当前编辑列的代码值
var code;
function getColCode(grid, rowIndex, columnIndex,e){
	code="";
	editColumn=columnIndex;
	var aspchiefGrid=L5.getCmp("aspchiefGrid");
	var cell = aspchiefGrid.getSelections();
	if(cell[0].get("name")){
		code=cell[0].get("name");
	}
}
function fillHeldPeople(e){
	var aspchiefGrid=L5.getCmp("aspchiefGrid");
	var cell = aspchiefGrid.getSelections();
	if(editColumn==4){
		somHeldPeopleDataSet.each(function(record, index){
			if(record.get('name') == cell[0].get("name")){
				var aspRecord =somAspchiefDataSet.getCurrent();
				aspRecord.set('idCard',record.get('idCard'));
				aspRecord.set('sex',record.get('sex'));
				aspRecord.set('birthday',record.get('birthday'));
				aspRecord.set('politics',record.get('politics'));
				aspRecord.set('workName',record.get('workName'));
				aspRecord.set('workDuties',record.get('workDuties'));
				aspRecord.set('name',record.get('name'));
			}
		});
	}
}
function loadInfo(){
	var record=somApplyDataSet.getCurrent();
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	record.set("curActivity", getActDefName());
	record.set("curOpinionId", "1");
	if(act=='inform'){//是通知受理人
		var somFlowQuery=L5.DatasetMgr.lookup("somFlowQuery");
		somFlowQuery.setParameter("TASK_CODE@=",taskCode);
		somFlowQuery.setParameter("ACTIVITY@=","批准");
		somFlowQuery.setParameter("OPINION_ID@=","1");
		somFlowQuery.load();
		somFlowQuery.on('load',function (ds){
			if(ds.getCount()==0){
				somApplyDataSet.getCurrent().set("curOpinionId","0");
				//document.getElementById("curOpinionId").disabled="disabled";
			}else if(ds.getCount()==1){
				somApplyDataSet.getCurrent().set("curOpinionId","1");
				//document.getElementById("curOpinionId").disabled="disabled";
			}
		});
	}		
	//现场勘查
	if(act=='watch'&&method=='daiban'){
		$("watchInfo1").style.display="block";
		$("watchInfo2").style.display="block";
		$("prospectAttendPeople").value=record.get("prospectAttendPeople");
		$("prospectPlace").value=record.get("prospectPlace");
		$("prospectDate").value=record.get("prospectDate");
		record.set("prospectAttendPeople","");
		record.set("prospectPlace","");
		record.set("prospectDate","");
	}
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	//somOrganDataSet.setParameter("TASK_CODE@=", taskCode);
	somOrganDataSet.load();
	somOrganDataSet.on("load",dealBorg);
	
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

function dealBorg(){
	somOrganDataSet.un("load",dealBorg);
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = somOrganDataSet.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}
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
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
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
	}
	var somAspchiefRecords=somAspchiefDataSet.getAllRecords();
	for(var i=0;i<somAspchiefRecords.length;i++){
		var idCard=somAspchiefRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("3");
			return;
		}
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
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	command.setParameter("somAspchiefRecord", somAspchiefDataSet.getAllChangedRecords());
	
	if(method == 'INSERT'){
		command.execute("create");
	}else{	
		command.execute("update");
	}
	if(!command.error){
		var url='jsp/cams/sorg/apply/group/prepare/groupPrepareList.jsp?act='+act;
		L5.Msg.alert('提示','保存成功！',function(){	
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
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
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
	}
	var somAspchiefRecords=somAspchiefDataSet.getAllRecords();
	for(var i=0;i<somAspchiefRecords.length;i++){
		var idCard=somAspchiefRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("3");
			return;
		}
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
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	command.setParameter("somAspchiefRecord", somAspchiefDataSet.getAllChangedRecords());
	if(method == 'INSERT'){
		command.execute("createAndSend");
	}else{	
		command.execute("updateAndSend");
	}
	if(!command.error){
		var url='';
		if(act == 'supply'){
			url='jsp/cams/sorg/apply/group/prepare/groupPrepareFlow.jsp?act='+act;
		}else{
			var url='jsp/cams/sorg/apply/group/prepare/groupPrepareList.jsp?act='+act;
		}
		L5.Msg.alert('提示','成功提交至下一环节！',function(){	
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
		if(act=='inform' ){
			L5.Msg.alert("提示","成功结束流程!",function(){
				if(act == 'audit'){
					if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
						updateOnlineStatusPass(somApplyRecord.get("taskCode"));
					}
					if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
						updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
					}
				}
				returnClick()
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				returnClick()
			});
		}
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
function getActDefName(){
	if(act=='auditReport'){
		return "名称核准";
	}else if(act=='accept'){
		return "受理";
	}else if(act=='watch'){
		return "现场勘查";
	}else if(act=='examin'){
		return "初审";
	}else if(act=='check'){
		return "审核";
	}else if(act=='audit'){
		return "批准";
	}else if(act=='inform'){
		return "通知申请人";
	}else if(act=='supply'){
		return "补齐补正";
	}
}
//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}
//打印名称核准通知书
function printInform(){

}
function fillOrganInfo(name){
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
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("CN_NAME",name);
	somOrganDataSet.setParameter("SORG_STATUS","9");
	somOrganDataSet.setParameter("SORG_TYPE","S");
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() == 0){
			L5.Msg.alert("提示","该社会团体名称尚未成功核准或已经筹备，无法进行筹备登记！");
			somOrganDataSet.newRecord();
			return;
		}else{
			sorgId=somOrganDataSet.get('sorgId');
			somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
			somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
			somHeldPeopleDataSet.load();
			somHeldOrganDataSet.load();
			somAspchiefDataSet.setParameter("SORG_ID@=", sorgId);
			somAspchiefDataSet.load();
			somApplyDataSet.set("borgName",somOrganDataSet.get('borgName'));
			cnName=name;
			somApplyDataSet.getCurrent().set("curOpinion","");
		}
	});
}