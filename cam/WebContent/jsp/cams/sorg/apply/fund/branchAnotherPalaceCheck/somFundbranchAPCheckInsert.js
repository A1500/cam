//初始化
function init(){
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	//法人
	somOrganDataSet.newRecord();
	//电子档案
	somElectronicDataSet_load();
	//流程意见
	somApplyDataSet.newRecord();
	somApplyDataSet.getCurrent().set("curOpinionId",'1');
	
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	//过滤流程意见
	opinionSelect.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	//房屋来源意见过滤
	resideSourceSelect.filterBy(function(record, id){
		if("2".indexOf(record.get('value'))>-1){
			return record;
		}
		if("3".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
//保存按钮
function saveAll(){
	//社会组织校验
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}		
	//邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"基金会邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	var organRecord=somOrganDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	organRecord.set("sorgId",sorgId);
	organRecord.set("sorgType","J");
	organRecord.set("ifBranch","1");
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchAPCheckCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.execute("insertBuildInfo");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			window.history.go(-1);
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交按钮
function saveAndSend(){
	//社会组织校验
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//社团名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}		
	//社会团体邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"社会团体邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	var organRecord=somOrganDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	organRecord.set("sorgId",sorgId);
	organRecord.set("sorgType","J");
	organRecord.set("ifBranch","1");
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchAPCheckCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.execute("saveAndSendBuild");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			window.history.go(-1);
		});		
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印受理通知
function printAccept(){
	var name=$("name").innerHTML;
	if(name==""){
		L5.Msg.alert("提示","请先输入基金会登记证号！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&cnName="+encodeURIComponent(encodeURIComponent(name));	
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	var name=$("name").innerHTML;
	if(name==""){
		L5.Msg.alert("提示","请先输入基金会登记证号！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&cnName="+encodeURIComponent(encodeURIComponent(name));	
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回按钮
function goBack(){
	window.history.go(-1);
}
//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“基金会中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
function validateSorgCode(){
//	$("name").innerHTML = "";
//	$("legalPeople").innerHTML = "";
//	$("cnName").value = "";
	$("mainSorgId").innerHTML = "";
	var mainSorgCode = _$("mainSorgCode");
	if(mainSorgCode.trim() == ""){
		return;
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	somMainOrganDataSet.setParameter("SORG_TYPE@=","J");
	somMainOrganDataSet.setParameter("SORG_CODE@=",mainSorgCode);
	somMainOrganDataSet.load();
	somMainOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			//somOrganDataSet.removeAll();
			//somOrganDataSet.newRecord();
			L5.Msg.alert("提示","输入的基金会登记证号不存在!");
			return ;
		}
		if(ds.get("sorgStatus") == "32" || ds.get("sorgStatus") == "62"){
			somOrganDataSet.removeAll();
			somOrganDataSet.newRecord();
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被注销，请重新输入！');
			return;
		}
		if(ds.get("sorgStatus") == "52"){
			somOrganDataSet.removeAll();
			somOrganDataSet.newRecord();
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被撤销，请重新输入！'); 
			ds.newRecord();
			return;
		}
		var somOrganDataSetRecord = somOrganDataSet.getCurrent();
		somOrganDataSetRecord.set("name",ds.get("cnName"));
		somOrganDataSetRecord.set("legalPeople",ds.get("legalPeople"));
		//somOrganDataSetRecord.set("cnName",ds.get("cnName"));
		somOrganDataSetRecord.set("mainSorgId",ds.get("sorgId"));
		somOrganDataSetRecord.set("mainSorgName",ds.get("cnName"));
		somOrganDataSetRecord.set("mainSorgCode",_$("mainSorgCode"));
		$("mainSorgId").innerHTML = somOrganDataSetRecord.get("mainSorgId");
		
		$("regDate").innerHTML=ds.get("regDate");
		$("residence").innerHTML=ds.get("residence");
//		$("name").innerHTML = somOrganDataSetRecord.get("name");
//		$("legalPeople").innerHTML = somOrganDataSetRecord.get("legalPeople");
//		$("cnName").value = somOrganDataSetRecord.get("cnName");
	});
}
var sorgCodeNum = "";
var cnNameNum = "";
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
}
function fillOrganInfo(name){
	if(name.trim() == ''){
		return;
	}
	var mainSorgName=somOrganDataSet.get('name');
	var mainSorgId=somOrganDataSet.get('mainSorgId');
	var mainSorgCode=somOrganDataSet.get('mainSorgCode');
	var legalPeople=somOrganDataSet.get('legalPeople');
	somOrganDataSet.removeAll();
	somOrganDataSet.setParameter("CN_NAME",name);
	somOrganDataSet.setParameter("SORG_STATUS","9");
	somOrganDataSet.setParameter("IF_BRANCH","1");
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() == 0){
			L5.Msg.alert("提示","该社会团体分支（代表）机构名称尚未成功核准或已经成立，无法进行登记！");
			somOrganDataSet.newRecord({"mainSorgName":mainSorgName,"mainSorgCode":mainSorgCode,"mainSorgId":mainSorgId,"legalPeople":legalPeople});
			return;
		}else{
			sorgId=somOrganDataSet.get('sorgId');
			somOrganDataSet.set("name",mainSorgName);
			somOrganDataSet.set("mainSorgName",mainSorgName);
			somOrganDataSet.set("mainSorgId",mainSorgId);
			somOrganDataSet.set("mainSorgCode",mainSorgCode);
			somOrganDataSet.set("legalPeople",legalPeople);
			//somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
			//somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
			//somHeldPeopleDataSet.load();
			//somHeldOrganDataSet.load();
			cnName=name;
			printSorgName=name;
		}
	});
}