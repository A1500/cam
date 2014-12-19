function init() {
	if(method=="INSERT"){
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.newRecord({"currency":"人民币"});
		var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
		var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"taskCode":taskCode, "curActivity":"受理", "curOpinionId":"1"});
		aspChiefDataset.newRecord({"taskCode":taskCode,"sorgId":sorgId});
		somElectronicDataSet_load();
	}else if(method=="UPDATE"){
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
		somElectronicDataSet_load();
	}
	opinionDataSet.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	if(act=='inform'){//是通知受理人
		var tab = L5.getCmp("tab");
		for(var i = tab.items.length-1;i>=0;i--){
			tab.setActiveTab(i);
		}
		document.getElementById("curOpinionId").disabled="disabled";
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

//将前后缀及中间部分组装给民办非企业单位名称并赋值给record
function assembleCnName(somOrganRecord){
	var cnNamePrefix=document.getElementById("cnNamePrefix");
	var cnNameSuffix=document.getElementById("cnNameSuffix");
	var cnName=document.getElementById("cnName");
	//处理异常情况，如果已经组装过的不在进行组装
	var cnNamePrefixLenth = cnNamePrefix.value.length;
	if(cnNamePrefix.value!=""&&cnNamePrefix.value==cnName.value.substring(0,cnNamePrefixLenth)){
		return true;
	}
	//组装
	if(cnNamePrefix.value!=""&&cnNameSuffix.value!=""){
		somOrganRecord.set("cnName", cnNamePrefix.value+cnName.value+cnNameSuffix.value);
		return true;
	}else{
		alert("请选择申请设立民办非企业单位名称前缀及后缀！");
		return false;
	}
	return true;
}
//隐藏民办非企业单位名称前缀和后缀方法
function hiddenCnNamePrefixSuffix(){
		var cnNamePrefix=document.getElementById("cnNamePrefix");
		var cnNameSuffix=document.getElementById("cnNameSuffix");
		var cnName=document.getElementById("cnName");
		cnNamePrefix.style.display = "none";
		cnNameSuffix.style.display = "none";
		cnName.style.width = "97%";
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
	//名称/中文
	if(cnNameNum != 0){
		if(sorgStatus==""||sorgStatus==null){
			L5.Msg.alert("提示","校验未通过："+"输入的民办非企业单位名称已存在");
			return;
		}
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
	
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		somHeldPeopleRecords[i].set("ifChief","0");
	}
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovNameApprovalCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	somOrganRecord.set("sorgId",sorgId);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleRecords);
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	command.setParameter("somAspchiefRecord", aspChiefDataset.getAllRecords());
	if(method=="INSERT"){
		command.execute("create");
	}else if(method=="UPDATE"){
		command.execute("update");
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
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganRecord=somOrganDataSet.getCurrent();
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	
	var somPrepareValidate = somOrganDataSet.isValidate();
	var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
	var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
	if(somPrepareValidate != true){
		L5.Msg.alert("提示",somPrepareValidate);
		return false;
	}
	//名称/中文
	if(cnNameNum != 0){
		if(sorgStatus==""||sorgStatus==null){
			L5.Msg.alert("提示","校验未通过："+"输入的民办非企业单位名称已存在");
			return;
		}
	}	
	if(somHeldPeopleValidate != true){
		L5.Msg.alert("提示",somHeldPeopleValidate);
		return false;
	}
	if(somHeldOrganValidate != true){
		L5.Msg.alert("提示",somHeldOrganValidate);
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
	
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovNameApprovalCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	if(method=="INSERT"){
		somOrganRecord.set("sorgId",sorgId);
	}
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllRecords());
	command.setParameter("somAspchiefRecord", aspChiefDataset.getAllRecords());
	if(method=="INSERT"){
		command.execute("createAndSend");
	}else if(method=="UPDATE" || method=="daiban"){
		command.execute("updateAndSend");
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
var cnNameNum="";
var sorgStatus="";
var saveSorgId="";
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		if(saveSorgId==""||saveSorgId==null){
			command.setParameter("sorgId",sorgId);
		}else{
			command.setParameter("sorgId",saveSorgId);
		}
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		var oldSorgId = command.getReturn("oldSorgId");
		sorgStatus = command.getReturn("sorgStatus");
		if(cnNameNum != 0){
			if(sorgStatus==""||sorgStatus==null){
				L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
				return;
			}else if(sorgStatus=="7"){
				L5.MessageBox.confirm('确定', '存在相同名称的已经名称核准作废的记录，是否加载？',function(state){
					if(state=="yes"){
						var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
						somOrganDataSet.setParameter("SORG_ID@=", oldSorgId);
						//somOrganDataSet.setParameter("TASK_CODE@=", taskCode);
						somOrganDataSet.load();
						somOrganDataSet.on('load',function(){
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
						if(saveSorgId==""||saveSorgId==null){
							saveSorgId=sorgId;
						}
						sorgId=oldSorgId;
					}else{
						return false;
					}
				});
			}
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
function checkSole(){
	var cnName=document.getElementById("cnName").value;
	var cnNamePrefix=document.getElementById("cnNamePrefix").value;
	var cnNameSuffix=document.getElementById("cnNameSuffix").value;
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
	OrganDataSetForQuery.setParameter("CN_NAME@=",cnName);
	OrganDataSetForQuery.load();
	OrganDataSetForQuery.on('load',function(){
		var num=OrganDataSetForQuery.getCount();
		if(num != 0){
			L5.Msg.alert("提示","申请立项社团（分支、代表机构）名称已经存在，请重新输入！");
			return;
		}
	});
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
function validDate(args){
	var val=args[0];
	if(val=="") return true;
	var objRegExp = /^(\d{4})\-(\d{2})$/ 
	if(!objRegExp.test(val)) {
		return "不符合YYYY-mm格式，请检查！"; 
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

