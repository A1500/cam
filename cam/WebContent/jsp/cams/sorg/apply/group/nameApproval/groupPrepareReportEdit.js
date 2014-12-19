function init() {
	if(method=="INSERT"){
		if(sorgType== '1'){
			somOrganDataSet.newRecord({"ifBranch":'0'});
		}else if(sorgType== '2'){
			somOrganDataSet.newRecord({"ifBranch":'1',"sorgKind":'1'});
		}else if(sorgType== '3'){
			somOrganDataSet.newRecord({"ifBranch":'1',"sorgKind":'2'});
		}
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"taskCode":taskCode, "curActivity":"受理", "curOpinionId":"1"});
		somElectronicDataSet_load();
		//过滤意见枚举，去掉补齐补正
		opinionDataSet.filterBy(function(record, id){
			if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
				return record;
			}
		});
	}else if(method=="UPDATE"){
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
		hiddenCnNamePrefixSuffix();
		
		opinionDataSet.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
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
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.load();
		somApplyDataSet.on('load',function(){
			somApplyDataSet.set('curOpinionId','1');
			 loadInfo();
		});
	}
	if(method =="INSERT"){
		if(sorgType== '1' ){
			document.getElementById('nameTD').style.display='block';
		}else{
			document.getElementById('branchNameTD').style.display='block';
		}
	}else if(method =="UPDATE"){
		document.getElementById('branchNameTD').style.display='block';
	}
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
	
	if(method == "yiban" || method == "end"){
		var tab=L5.getCmp("tab");
		var ipinionPanel=L5.getCmp("ipinionPanel");
		tab.remove(ipinionPanel);
	}
}

function loadInfo(){
	somApplyDataSet.set('curOpinionId','1');
	sorgId = somApplyDataSet.get('sorgId');
	taskCode=somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.setParameter("TASK_CODE@=", taskCode);
	somOrganDataSet.load();
	
	somFlowDataSet.setParameter("TASK_CODE", taskCode);
	somFlowDataSet.load();
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldPeopleDataSet.load();
	somHeldOrganDataSet.load();
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

//将前后缀及中间部分组装给社会团体名称并赋值给record
function assembleCnName(somOrganRecord){
	if(sorgType != '1'){
		return true;
	}
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
		
	}
	return true;
}
//隐藏社会团体名称前缀和后缀方法
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
		if(sorgStatus==""||sorgStatus==null){
			L5.Msg.alert("提示","校验未通过："+"输入的社会团体名称已存在");
			return;
		}
	}
	if(checkCnNameNum != 0){
		L5.MessageBox.confirm('确定', '存在'+checkCnNameNum+'个类似名称的社会团体！你确定要保存吗？',function(sta){
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
	
	//将前后缀及中间部分组装给社会团体名称并赋值给record
	if(method=="INSERT"){
		if(!assembleCnName(somOrganRecord)){
			return false;
		}	
	}
	if(method=="INSERT" || method=="UPDATE"){
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
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupNameApprovalCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	somOrganRecord.set("sorgId",sorgId);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	if(method=="INSERT"){
		command.execute("create");
	}else if(method=="UPDATE"){
		command.execute("update");
	}
	if(!command.error){
		var url='';
		if(act == 'supply' || method =='daiban'){
			url='jsp/cams/sorg/apply/group/nameApproval/somGroupNameApprovalList.jsp?act='+act;
		}else{
			url='jsp/cams/sorg/apply/group/nameApproval/groupPrepareAcceptList.jsp';
		}
		L5.Msg.alert('提示','保存成功！',function(){
			L5.forward(url);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function submit() {
	//名称/中文
	if(cnNameNum != 0){
		if(sorgStatus==""||sorgStatus==null){
			L5.Msg.alert("提示","校验未通过："+"输入的社会团体名称已存在");
			return;
		}
	}
	if(checkCnNameNum != 0){
		L5.MessageBox.confirm('确定', '存在'+checkCnNameNum+'个类似名称的社会团体！你确定要提交吗？',function(sta){
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
	//将前后缀及中间部分组装给社会团体名称并赋值给record
	if(method=="INSERT"){
		if(!assembleCnName(somOrganRecord)){
			return false;
		}	
	}
	if(method=="INSERT" || method=="UPDATE"){
		var somPrepareValidate = somOrganDataSet.isValidate();
		var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
		var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
		
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
	}
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
			L5.Msg.alert("提示",somApplyValidate);
			return false;
		}
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupNameApprovalCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	if(method=="INSERT"){
		somOrganRecord.set("sorgId",sorgId);
	}
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	if(method=="INSERT"){
		command.execute("createAndSend");
	}else if(method=="UPDATE" || method=="daiban"){
		command.execute("updateAndSend");
	}
	if(!command.error){
		var url='';
		if(act == 'supply' || method =='daiban'){
			url='jsp/cams/sorg/apply/group/nameApproval/somGroupNameApprovalList.jsp?act='+act;
		}else{
			url='jsp/cams/sorg/apply/group/nameApproval/groupPrepareAcceptList.jsp';
		}
		L5.Msg.alert('提示','成功提交至下一环节！',function(){
			if(act == 'audit'){
				if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
					updateOnlineStatusPass(somApplyRecord.get("taskCode"));
				}
				if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
					updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
				}
			}
			L5.forward(url);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//返回
function returnClick(){
	history.go(-1);
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
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
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
var printSorgName='';
var sorgStatus='';
var saveSorgId="";
function checkSole(){
	var cnName=document.getElementById("cnName").value;
	var cnNamePrefix=document.getElementById("cnNamePrefix").value;
	var cnNameSuffix=document.getElementById("cnNameSuffix").value;
	if(method=="INSERT"){
		if(cnName == ""||cnNamePrefix == ""||cnNameSuffix == ""){
			return;
		}
		printSorgName = cnNamePrefix+cnName+cnNameSuffix;
	}else{
		if(cnName == ""){
			return;
		}
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",printSorgName);
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
			L5.Msg.alert("提示","申请立项社团名称已经存在，请重新输入！");
			return;
		}else if(sorgStatus=="7"){
			L5.MessageBox.confirm('确定', '存在相同名称的已经名称核准作废的记录，是否加载？',function(state){
				if(state=="yes"){
					var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
					somOrganDataSet.setParameter("SORG_ID@=", oldSorgId);
					//somOrganDataSet.setParameter("TASK_CODE@=", taskCode);
					somOrganDataSet.load();
					somOrganDataSet.on('load',function(){
						document.getElementById("cnName").value=cnName;
						//页面显示业务主管单位信息
						var borgName = somOrganDataSet.get('borgName');
						var records = businessOrganSelectDic.query("value",borgName);
						if(records.length>0){
							var borgCode = records.items[0].get("text");
							document.getElementById("borgName").value = borgName;
							document.getElementById("borgNameDispaly").value = borgCode;
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
	}else{
		if(method=="INSERT"){
			checkCnName(document.getElementById("cnName").value);
		}
	}
}
var temp;
function checkSoleB(){
	printSorgName=document.getElementById("branchName").value;
	if(printSorgName == ""){
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",printSorgName);
	command.setParameter("sorgId",sorgId);
	command.execute("cnNameUK");
	cnNameNum = command.getReturn("cnNameNum");
	sorgStatus = command.getReturn("sorgStatus");
	var oldSorgId = command.getReturn("oldSorgId");
	if(command.getReturn("branchAP_sorgId")){
		temp=sorgId;
		sorgId=command.getReturn("branchAP_sorgId");
	}else{
		if(temp){
			sorgId=temp;
		}
	}
	if(cnNameNum != 0){
		if(sorgStatus==""||sorgStatus==null){
			L5.Msg.alert("提示","申请立项社团（分支、代表机构）名称已经存在，请重新输入！");
			return;
		}else if(sorgStatus=="7"){
			L5.MessageBox.confirm('确定', '存在相同名称的已经名称核准作废的记录，是否加载？',function(state){
				if(state=="yes"){
					var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
					somOrganDataSet.setParameter("SORG_ID@=", oldSorgId);
					//somOrganDataSet.setParameter("TASK_CODE@=", taskCode);
					somOrganDataSet.load();
					somOrganDataSet.on('load',function(){
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
					return false;
				}
			});
		}
	}else{
		if(method=="INSERT"){
			checkCnName(printSorgName);
		}
	}
}
function checkCnName(nameVlaue){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",nameVlaue);
	command.setParameter("sorgType","S");
	command.setParameter("ifBranch","0");
	command.setParameter("morgArea",morgArea);
	command.execute("cnNameSame");
	checkCnNameNum = command.getReturn("cnNameSameNum");
	if(checkCnNameNum>0){
		L5.Msg.alert("提示","存在"+checkCnNameNum+"个类似名称的社会团体！",function(){
			var OrganDataSetForQuery=L5.DatasetMgr.lookup("OrganDataSetForQuery");
			OrganDataSetForQuery.setParameter("CN_NAME@like",nameVlaue);
			OrganDataSetForQuery.setParameter("SORG_TYPE@=","S");
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
//打印受理通知
function printAccept(){
	if(printSorgName==''){
		L5.Msg.alert('提示',"请先录入申请立项社团名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(printSorgName));	
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	if(printSorgName==''){
		L5.Msg.alert('提示',"请先录入申请立项社团名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(printSorgName));
	window.open(url);
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
