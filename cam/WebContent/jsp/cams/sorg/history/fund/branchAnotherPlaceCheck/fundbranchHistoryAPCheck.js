//初始化
function init(){
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		//法人
		somOrganDataSet.newRecord();
		//流程意见
		somApplyDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"MEND","sorgType":"J","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
	}else{
		forUPdateLoad();
	}
	
	//电子档案
	somElectronicDataSet_load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
}
function forUPdateLoad(){
	$("mainSorgCode").disabled=true;
	somOrganDataSet.setParameter("SORG_ID",sorgId);
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
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.load();
}
//保存按钮
function saveAll(){
	//名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}		
	//社会组织校验
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
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
	organRecord.set("sorgStatus","14");
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	var command = new L5.Command("com.inspur.cams.sorg.history.fund.cmd.SomFundHistoryCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	if(method=="INSERT"){
		command.execute("saveBranchAPCheck");
	}else{
		command.execute("updateBranchAPCheck");
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			//goBack();
			method="UPDATE";
			forUPdateLoad();
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//返回按钮
function goBack(){
	if(method=="UPDATE"){
		var data=new L5.Map();
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(document.getElementById('cnName').value)));
		//data.put("searchSorgCode",_$("sorgCode"));	
		url="jsp/cams/sorg/history/fund/branchAnotherPlaceCheck/fundBranchHistoryAPCheckList.jsp";
		L5.forward(url,'',data);
	}else{
		history.go(-1);
	}
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
//	$("name").innerHTML = "";
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
			L5.Msg.alert("提示","输入的登记证号不存在!");
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
		somOrganDataSetRecord.set("cnName",ds.get("cnName"));
		somOrganDataSetRecord.set("mainSorgId",ds.get("sorgId"));
		somOrganDataSetRecord.set("mainSorgName",ds.get("cnName"));
		somOrganDataSetRecord.set("mainSorgCode",_$("mainSorgCode"));
		$("mainSorgId").innerHTML = somOrganDataSetRecord.get("mainSorgId");
	});
}
var sorgCodeNum = "";
var cnNameNum = "";
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
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