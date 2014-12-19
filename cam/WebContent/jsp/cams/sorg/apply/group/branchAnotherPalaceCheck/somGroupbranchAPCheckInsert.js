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
	organRecord.set("sorgType","S");
	organRecord.set("ifBranch","1");
	somApplyRecord.set("taskCode",taskCode);
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchAPCheckCmd");
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
	//名称/中文
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
	organRecord.set("sorgType","S");
	organRecord.set("ifBranch","1");
	somApplyRecord.set("taskCode",taskCode);
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchAPCheckCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.execute("saveAndSendBuild");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
		if(act == 'audit'){
			if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
				updateOnlineStatusPass(somApplyRecord.get("taskCode"));
			}
			if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
				updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
			}
		}

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
		L5.Msg.alert("提示","请先输入社会团体登记证号！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&cnName="+encodeURIComponent(encodeURIComponent(name));	
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	var name=$("name").innerHTML;
	if(name==""){
		L5.Msg.alert("提示","请先输入社会团体登记证号！");
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
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
		L5.Msg.alert('提示','请先填写“社会团体中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
function validateSorgCode(){
	$("mainSorgId").innerHTML = "";
	var mainSorgCode = _$("mainSorgCode");
	if(mainSorgCode.trim() == ""){
		return;
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	somMainOrganDataSet.setParameter("SORG_TYPE@=","S");
	somMainOrganDataSet.setParameter("SORG_CODE@=",mainSorgCode);
	somMainOrganDataSet.load();
	somMainOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			L5.Msg.alert("提示","输入的社团登记证号不存在!");
			somOrganDataSet.removeAll();
			somOrganDataSet.newRecord();
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
			return;
		}
		var somOrganDataSetRecord = somOrganDataSet.getCurrent();
		somOrganDataSetRecord.set("name",ds.get("cnName"));
		somOrganDataSetRecord.set("legalPeople",ds.get("legalPeople"));
		somOrganDataSetRecord.set("borgName",ds.get("borgName"));
		document.getElementById('residence').innerHTML=ds.get("residence");
		document.getElementById('regDate').innerHTML=ds.get("regDate");
		somOrganDataSetRecord.set("mainSorgId",ds.get("sorgId"));
		somOrganDataSetRecord.set("mainSorgName",ds.get("cnName"));
		somOrganDataSetRecord.set("mainSorgCode",_$("mainSorgCode"));
		$("mainSorgId").innerHTML = somOrganDataSetRecord.get("mainSorgId");
	});
}
var sorgCodeNum = "";
var cnNameNum = "";
//校验社会组织名称是否重复
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
	var mainSorgName=somOrganDataSet.get('name');
	var mainSorgId=somOrganDataSet.get('mainSorgId');
	var mainSorgCode=somOrganDataSet.get('mainSorgCode');
	somOrganDataSet.removeAll();
	somOrganDataSet.setParameter("CN_NAME",name);
	somOrganDataSet.setParameter("SORG_STATUS","9");
	somOrganDataSet.setParameter("IF_BRANCH","1");
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() == 0){
			L5.Msg.alert("提示","该社会团体分支（代表）机构名称尚未成功核准或已经成立，无法进行登记！");
			somOrganDataSet.newRecord({"name":mainSorgName,"mainSorgCode":mainSorgCode,"mainSorgId":mainSorgId});
			return;
		}else{
			sorgId=somOrganDataSet.get('sorgId');
			somOrganDataSet.set("name",mainSorgName);
			somOrganDataSet.set("mainSorgName",mainSorgName);
			somOrganDataSet.set("mainSorgId",mainSorgId);
			somOrganDataSet.set("mainSorgCode",mainSorgCode);
			
			var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
			somOrganDataSet.set("name",somMainOrganDataSet.get("cnName"));
			somOrganDataSet.set("legalPeople",somMainOrganDataSet.get("legalPeople"));
			somOrganDataSet.set("borgName",somMainOrganDataSet.get("borgName"));
			somOrganDataSet.set("mainSorgId",somMainOrganDataSet.get("sorgId"));
			somOrganDataSet.set("mainSorgName",somMainOrganDataSet.get("cnName"));
			document.getElementById('residence').innerHTML=somMainOrganDataSet.get("residence");
			document.getElementById('regDate').innerHTML=somMainOrganDataSet.get("regDate");
			cnName=name;
			printSorgName=name;
			somApplyDataSet.getCurrent().set("curOpinion","");
		}
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