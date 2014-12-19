function init(){
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
	somRuleDataSet.load();
	somRuleDataSet.on('load', function(){
		var record=somRuleDataSet.getCurrent();
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on("load",fillOrganInfo);
	});
	//电子档案
	somElectronicDataSet_load();		
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});	
	}
}
function fillOrganInfo(applyds){
	sorgId = applyds.get("sorgId");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		var sorgCode = somOrganDataSet.get("sorgCode");
		somOrganDataSetQuery.setParameter("SORG_CODE@=",sorgCode);
		somOrganDataSetQuery.setParameter("SORG_TYPE@=","M");
		somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
		somOrganDataSetQuery.load();
		somOrganDataSetQuery.on("load",function(){
			if(somOrganDataSetQuery.getCount() == 0){
				L5.Msg.alert("提示","根据录入的登记证号没有查到相应的社会组织,不能进行章程核准，请确认并修改登记证号！",function(){
					$("cnName").value = "";
					$("sorgCode").value = "";
					return false;
				});
			}else{
				sorgIdExist = somOrganDataSetQuery.get("sorgId");
				$("cnName").value = somOrganDataSetQuery.get("cnName");
				$("sorgCode").value = somOrganDataSetQuery.get("sorgCode");
			}
		});
	});
}
function checkSorgCode(){
	somOrganDataSetQuery.setParameter("SORG_CODE@=",_$("sorgCode"));
	somOrganDataSetQuery.setParameter("SORG_TYPE@=","M");
	somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSetQuery.load();
}
function save(){
	if(_$("cnName")==""){
		L5.Msg.alert("提示","请填写单位名称！");
		return;
	}
	if(_$("sorgCode")==""){
		L5.Msg.alert("提示","请填写登记证号！");
		return;
	}
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	var validate=somRuleDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var shouldNum=_$("shouldNum");
	var realNum=_$("realNum");
	var passNum=_$("passNum");
	var nopassNum=_$("nopassNum");
	var givenupNum=_$("giveupNum");
	if(givenupNum!=""|nopassNum!=""|passNum!=""|realNum!=""){
		var num=parseInt(givenupNum)+parseInt(nopassNum)+parseInt(passNum);
		if(num!=realNum){
			L5.Msg.alert("提示","人数逻辑出错！");
			return false;
		}
	}
	
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	somRuleRecord.set("ifDraft","1");
	somRuleRecord.set("sorgId",sorgIdExist);
	somApplyRecord.set("sorgId",sorgIdExist);
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomRuleCmd");
	command.setParameter("somRuleRecord",somRuleRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("insert");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			updateOnlineStatusPass(somApplyRecord.get("taskCode"));
			returnBackHistory();		
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBackHistory(){
	window.history.go(-1);	
}
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}