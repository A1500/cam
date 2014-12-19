var cnName='';
var sorgCode=''
function init() {
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		somApplyDataSet.newRecord({"curActivity":"受理","curOpinionId":"1","taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"S","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId});
		somOrganDataSet.newRecord({"cnName":userId,"sorgId":sorgId,"sorgStatus":'12',"sorgType":"S","ifBranch":'0',"morgName":userId,"morgArea":morgArea});
	}else if(method=="UPDATE"){
		loadInfo();
	}
	//电子档案上传窗口关闭事件
	if(L5.getCmp("uploadList")){
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
	somElectronicDataSet_load();
}
function loadInfo(){
		somOrganDataSet.setParameter("SORG_ID", sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
			cnName=somOrganDataSet.get("cnName");
			sorgCode=somOrganDataSet.get("sorgCode");

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
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
		somHeldPeopleDataSet.load();
		somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
		somHeldOrganDataSet.load();
		somAspchiefDataSet.setParameter("TASK_CODE", taskCode);
		somAspchiefDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
}
// 增加筹备人（自然人）
function addHeldPeople(){
	somHeldPeopleDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId});
}
// 删除筹备人（自然人）
function delHelpPeople(){
	var record=somHeldPeopleDataSet.getCurrent();
	if(record!=null)
		somHeldPeopleDataSet.remove(record);
}
// 增加筹备人（单位）
function addHeldOrgan(){
	somHeldOrganDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId});
}
// 删除筹备人（单位）
function delHeldOrgan(){
	var record=somHeldOrganDataSet.getCurrent();
	if(record!=null)
		somHeldOrganDataSet.remove(record);
}
// 增加拟任负责人
function addAspchief(){
	somAspchiefDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId});
}
// 删除拟任负责人
function delAspchief(){
	var record=somAspchiefDataSet.getCurrent();
	if(record!=null)
		somAspchiefDataSet.remove(record);
}
//保存
function save(){
	//名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的社会团体名称已存在");
		return;
	}
	var somOrganRecord=somOrganDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somPrepareValidate = somOrganDataSet.isValidate();
	var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
	var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
	var somAspchiefValidate = somAspchiefDataSet.isValidate();
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
	//社会团体邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"社会团体邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	//单位会员数和个人会员数
	/*
	if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() == ""){
		if(_$("unitsNum") < 30){
			L5.Msg.alert("提示","校验未通过："+"单位会员数不能小于30");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	if(_$("unitsNum").trim() == "" && _$("peopleNum").trim() != ""){
		if(_$("peopleNum") < 50){
			L5.Msg.alert("提示","校验未通过："+"个人会员数不能小于50");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() != ""){
		if(parseInt(_$("unitsNum"))+parseInt(_$("peopleNum")) < 50){
			L5.Msg.alert("提示","校验未通过："+"会员总数不能小于50");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	*/
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.group.cmd.SomGroupOnlineCmd");
	command.setParameter("somApply", somApplyRecord);
	command.setParameter("somOrgan", somOrganRecord);
	command.setParameter("somHeldPeople", somHeldPeopleDataSet.getAllRecords());
	command.setParameter("somHeldOrgan", somHeldOrganDataSet.getAllRecords());
	command.setParameter("somAspchief", somAspchiefDataSet.getAllRecords());
	if(method=="INSERT"){
		command.execute("savePrepare");
	}else{
		command.execute("updatePrepare");
	}
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			//goBack();
			method="UPDATE";
			loadInfo();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	history.go(-1);
}
var cnNameNum="";
function checkNameRepeat(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		alert(_$("cnName"));
		alert(sorgId);
		command.setParameter("cnName",_$("cnName"));
		command.setParameter("sorgId",sorgId);
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的组织名称已存在");
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