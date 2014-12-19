var taskCode="";
function init(){
	if(method=="INSERT"){
		somPenaltyDataSet.newRecord();
		somPenaltyApplyDataSet.newRecord({"curOpinionId":"1"});
	}else if(method=="checkForPenalty"||method=="penaltyNoPass"){
		somPenaltyDataSet.newRecord({
			"sorgName":sorgName,
			"sorgType":sorgType,
			"sorgCode":sorgCode,
			"caseBrief":caseBrief,
			"caseSource":'1'
		});
		loadSorg();
		loadCaseSource();
		somPenaltyDataSet.set("providerName",currentUserName);
		somPenaltyDataSet.set("providerOrgan",currentOrganName);
		somPenaltyApplyDataSet.newRecord({"curOpinionId":"1"});
	}
	else{
		somPenaltyApplyDataSet.setParameter("ID", processId);
		somPenaltyApplyDataSet.on("load", loadInfo);
		somPenaltyApplyDataSet.load();
	}
	L5.QuickTips.init();
}
function loadInfo(){
	taskCode = somPenaltyApplyDataSet.get("taskCode");
	somPenaltyDataSet.setParameter("TASK_CODE", taskCode);
	somPenaltyDataSet.load();
	somPenaltyDataSet.on("load",function(ds){		
		if(_$("caseSource") == "1"){
			$("caseSourceCheck1").style.display = "block";
			$("caseSourceCheck2").style.display = "block";
			$("caseSourceReport1").style.display = "none";
			$("caseSourceReport2").style.display = "none";
			$("caseSourceReport3").style.display = "none";
			$("caseSourceMove1").style.display = "none";
			$("caseSourceMove2").style.display = "none";
			$("caseSourceMove3").style.display = "none";
		}else if(_$("caseSource") == "2"){
			$("caseSourceCheck1").style.display = "none";
			$("caseSourceCheck2").style.display = "none";
			$("caseSourceReport1").style.display = "block";
			$("caseSourceReport2").style.display = "block";
			$("caseSourceReport3").style.display = "block";
			$("caseSourceMove1").style.display = "none";
			$("caseSourceMove2").style.display = "none";
			$("caseSourceMove3").style.display = "none";
		}else if(_$("caseSource") == "3" || _$("caseSource") == "4"){
			$("caseSourceCheck1").style.display = "none";
			$("caseSourceCheck2").style.display = "none";
			$("caseSourceReport1").style.display = "none";
			$("caseSourceReport2").style.display = "none";
			$("caseSourceReport3").style.display = "none";
			$("caseSourceMove1").style.display = "block";
			$("caseSourceMove2").style.display = "block";
			$("caseSourceMove3").style.display = "block";
		}else{
			$("caseSourceCheck1").style.display = "none";
			$("caseSourceCheck2").style.display = "none";
			$("caseSourceReport1").style.display = "none";
			$("caseSourceReport2").style.display = "none";
			$("caseSourceReport3").style.display = "none";
			$("caseSourceMove1").style.display = "none";
			$("caseSourceMove2").style.display = "none";
			$("caseSourceMove3").style.display = "none";
		}
	});
}
function loadSorg(){
	if(_$("sorgType")=="" || _$("sorgCode")==""){
		return;
	}
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_CODE",_$("sorgCode"));
	somOrganDataSet.setParameter("SORG_TYPE",_$("sorgType"));
	somOrganDataSet.setParameter("IF_BRANCH","0");
	somOrganDataSet.on("load",function(somOrganDataSet){
		if(somOrganDataSet.getCount()<1){
			L5.Msg.alert("提示","登记证号不存在！");
			somPenaltyDataSet.set("sorgName","");
			somPenaltyDataSet.set("partyName","");
			somPenaltyDataSet.set("partyAdd","");
			somPenaltyDataSet.set("partyCharger","");
			somPenaltyDataSet.set("partyPhone","");
		}else{
			somPenaltyDataSet.set("sorgName",somOrganDataSet.get("cnName"));
			somPenaltyDataSet.set("partyName",somOrganDataSet.get("cnName"));
			somPenaltyDataSet.set("partyAdd",somOrganDataSet.get("residence"));
			somPenaltyDataSet.set("partyCharger",somOrganDataSet.get("legalPeople"));
			somPenaltyDataSet.set("partyPhone",somOrganDataSet.get("sorgPhone"));
		}
	});	
	somOrganDataSet.load();
}

function loadSorgByName(){
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("CN_NAME",_$("sorgName"));
	somOrganDataSet.on("load",function(somOrganDataSet){
		if(somOrganDataSet.getCount()<1){
			somPenaltyDataSet.set("sorgName","");
			somPenaltyDataSet.set("partyName","");
			somPenaltyDataSet.set("partyAdd","");
			somPenaltyDataSet.set("partyCharger","");
			somPenaltyDataSet.set("partyPhone","");
		}else{
			somPenaltyDataSet.set("sorgCode",somOrganDataSet.get("sorgCode"));
			somPenaltyDataSet.set("partyName",somOrganDataSet.get("cnName"));
			somPenaltyDataSet.set("partyAdd",somOrganDataSet.get("residence"));
			somPenaltyDataSet.set("partyCharger",somOrganDataSet.get("legalPeople"));
			somPenaltyDataSet.set("partyPhone",somOrganDataSet.get("sorgPhone"));
			somPenaltyDataSet.set("sorgType",somOrganDataSet.get("sorgType"));
		}
	});	
	somOrganDataSet.load();

}
function saveAccept(){
	var somPenaltyValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyValidate != true){
		L5.Msg.alert("提示",somPenaltyValidate);
		return false;
	}
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
	if(method=="INSERT"){
		command.execute("create");
	}
	else if(method=="penaltyNoPass"){//年检不合格
		command.setParameter("checkTaskCode",checkTaskCode);
		command.execute("createAndUpdateCheck");
	}
	else if(method=="checkForPenalty"){//未年检
		command.execute("create");
	}else if(method=="UPDATE"){
		command.execute("save");
	}
	if(!command.error){	
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);	
	}
}
function submitAccept(){
	var somPenaltyValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyValidate != true){
		L5.Msg.alert("提示",somPenaltyValidate);
		return false;
	}
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
	if(method=="INSERT"){
		command.execute("createSubmit");
	}else if(method=="penaltyNoPass"){//年检不合格
		command.setParameter("checkTaskCode",checkTaskCode);
		command.execute("createSubmitAndUpdateCheck");
	}else if(method=="checkForPenalty"){//未年检
		command.execute("createSubmit");
	}else if(method=="UPDATE"){
		command.execute("submit");
	}
	if(!command.error){	
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert("错误","提交时出现错误！"+command.error);	
	}
}
function goBack(){
	history.go(-1);
}
function loadCaseSource(){
	if(_$("caseSource") == "1"){
		$("caseSourceCheck1").style.display = "block";
		$("caseSourceCheck2").style.display = "block";
		$("caseSourceReport1").style.display = "none";
		$("caseSourceReport2").style.display = "none";
		$("caseSourceReport3").style.display = "none";
		$("caseSourceMove1").style.display = "none";
		$("caseSourceMove2").style.display = "none";
		$("caseSourceMove3").style.display = "none";
		somPenaltyDataSet.set("providerName","");
		somPenaltyDataSet.set("providerOrgan","");
		somPenaltyDataSet.set("providerNameOther","");
		somPenaltyDataSet.set("providerOrganOther","");
	}else if(_$("caseSource") == "2"){
		$("caseSourceCheck1").style.display = "none";
		$("caseSourceCheck2").style.display = "none";
		$("caseSourceReport1").style.display = "block";
		$("caseSourceReport2").style.display = "block";
		$("caseSourceReport3").style.display = "block";
		$("caseSourceMove1").style.display = "none";
		$("caseSourceMove2").style.display = "none";
		$("caseSourceMove3").style.display = "none";
		somPenaltyDataSet.set("providerName","");
		somPenaltyDataSet.set("providerWay","");
		somPenaltyDataSet.set("providerOrgan","");
		somPenaltyDataSet.set("providerPhone","");
		somPenaltyDataSet.set("providerAdd","");
		somPenaltyDataSet.set("providerPost","");
	}else if(_$("caseSource") == "3" || _$("caseSource") == "4"){
		$("caseSourceCheck1").style.display = "none";
		$("caseSourceCheck2").style.display = "none";
		$("caseSourceReport1").style.display = "none";
		$("caseSourceReport2").style.display = "none";
		$("caseSourceReport3").style.display = "none";
		$("caseSourceMove1").style.display = "block";
		$("caseSourceMove2").style.display = "block";
		$("caseSourceMove3").style.display = "block";
		somPenaltyDataSet.set("providerOrgan","");
		somPenaltyDataSet.set("providerWay","");
		somPenaltyDataSet.set("providerName","");
		somPenaltyDataSet.set("providerPhone","");
		somPenaltyDataSet.set("providerAdd","");
		somPenaltyDataSet.set("providerPost","");
	}else{
		$("caseSourceCheck1").style.display = "none";
		$("caseSourceCheck2").style.display = "none";
		$("caseSourceReport1").style.display = "none";
		$("caseSourceReport2").style.display = "none";
		$("caseSourceReport3").style.display = "none";
		$("caseSourceMove1").style.display = "none";
		$("caseSourceMove2").style.display = "none";
		$("caseSourceMove3").style.display = "none";
	}
}