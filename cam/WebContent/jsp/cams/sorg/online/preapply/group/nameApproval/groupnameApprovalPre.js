function init() {
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);

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
		//checkSole();
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
			var idCard=somHeldPeopleRecords[i].get("idCard");
			if(idCard!="" && validIDCard(idCard)!=true){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
				L5.getCmp("tab").setActiveTab("1");
				return;
			}
			somHeldPeopleRecords[i].set("ifChief","0");
			somHeldPeopleRecords[i].state = L5.model.Record.STATE_NEW;
		}
		var somHeldOrganRecords=somHeldOrganDataSet.getAllRecords();
		for(var i=0;i<somHeldOrganRecords.length;i++){
			somHeldOrganRecords[i].state = L5.model.Record.STATE_NEW;
		}
		if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
		//将修改后的业务主管单位维护进organ
		somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupNameApprovalCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleRecords);
	command.setParameter("somHeldOrganRecord", somHeldOrganRecords);
	command.execute("create");
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			updateOnlineStatusAccept();
			var url='jsp/cams/sorg/online/preapply/group/nameApproval/groupnameApprovalPreList.jsp';
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
			var idCard=somHeldPeopleRecords[i].get("idCard");
			if(idCard!="" && validIDCard(idCard)!=true){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
				L5.getCmp("tab").setActiveTab("1");
				return;
			}
			somHeldPeopleRecords[i].set("ifChief","0");
			somHeldPeopleRecords[i].state = L5.model.Record.STATE_NEW;
		}
		var somHeldOrganRecords=somHeldOrganDataSet.getAllRecords();
		for(var i=0;i<somHeldOrganRecords.length;i++){
			somHeldOrganRecords[i].state = L5.model.Record.STATE_NEW;
		}
		if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
		//将修改后的业务主管单位维护进organ
		somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupNameApprovalCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleRecords);
	command.setParameter("somHeldOrganRecord", somHeldOrganRecords);
		command.execute("createAndSend");
	if(!command.error){
		L5.Msg.alert('提示','成功提交至下一环节！',function(){
			updateOnlineStatusAccept();
			var url='jsp/cams/sorg/online/preapply/group/nameApproval/groupnameApprovalPreList.jsp';
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
	printSorgName=cnName;
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",cnName);
	//if(saveSorgId==""||saveSorgId==null){
	//	command.setParameter("sorgId",sorgId);
	//}else{
	//	command.setParameter("sorgId",saveSorgId);
	//}
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
			checkCnName(document.getElementById("cnName").value);
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
	//command.setParameter("sorgId",sorgId);
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
			checkCnName(printSorgName);
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
	if(document.getElementById("cnName").value==''){
		L5.Msg.alert('提示',"请先录入申请立项社团名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(document.getElementById("cnName").value));
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	if(document.getElementById("cnName").value==''){
		L5.Msg.alert('提示',"请先录入申请立项社团名称！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(document.getElementById("cnName").value));
	window.open(url);
}

