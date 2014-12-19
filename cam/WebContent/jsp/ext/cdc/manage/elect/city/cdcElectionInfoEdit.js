function init(){
 	var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		electionInfoDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		electionInfoDataSet.setParameter("RECORD_ID@=",recordId);
		electionInfoDataSet.load();
		reportWorkDataSet.load();
	}
}
function save(){
	var reportTime = document.getElementById("reportDate").value;
	if(reportTime==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var yearly = document.getElementById("yearly").value;
	var season = document.getElementById("season").value;
	var ifComplete = document.getElementById("ifComplete").value;
	var completeResult = document.getElementById("completeResult").value;
	var ifElection = document.getElementById("ifElection").value;
	if(ifElection==""){
		L5.Msg.alert("提示","是否参加换届选举不能为空！");
		return;
	}
	if(ifElection == '1'){
		if(yearly==""){
			L5.Msg.alert("提示","选举年份不能为空！");
		return;
		}
		if(season==""){
			L5.Msg.alert("提示","选举届次不能为空！");
		return;
		}
		if(ifComplete==""){
			L5.Msg.alert("提示","是否完成选举不能为空！");
		return;
		}
	if(ifComplete == '1'){
		
		if(completeResult==""){
			L5.Msg.alert("提示","完成情况不能为空！");
		return;
		}
		
	}
	}
	var complete =  document.getElementById("ifComplete").value;
	if(complete=='1'){
		if(document.getElementById("completeResult").value==""){
			L5.Msg.alert("提示","请选择选举完成情况！");
			return;
		}
	}
	var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
	var isValidate = electionInfoDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=electionInfoDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){ 
		L5.Msg.alert("提示","保存成功！",function(){
			var data=new L5.Map();
			var url ="jsp/ext/cdc/manage/elect/city/cdcElectionList.jsp" ;
			if(method=="insert"){
				recordId = command.getReturn("recordId");
				if(recordId=="" ||recordId =="null"||recordId ==null){
					url="jsp/ext/cdc/manage/elect/city/cdcElectionList.jsp";
				}else{
					url="jsp/ext/cdc/manage/elect/city/cdcElectionEdit.jsp";
				}
			}else{
				url="jsp/ext/cdc/manage/elect/city/cdcElectionEdit.jsp";
			}
			data.put("reportTime",reportTime);
			data.put("recordId",recordId);
			data.put("method","update");
			L5.forward(url,'',data);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}

function returnBack(){
	history.go(-1);
}
function completeChanges(){
	var complete =  document.getElementById("ifComplete").value;
	if(complete=='0'){
		var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
		electionInfoDataSet.set("completeResult","");
		document.getElementById("completeResult").disabled = true;
	}else{
		document.getElementById("completeResult").disabled = false;
	}
	
}

function electionChanges(){
	var ifElection = document.getElementById("ifElection").value;
	if(ifElection == '0'){
		document.getElementById("yearly").disabled =true;
		document.getElementById("season").disabled =true;
		document.getElementById("completeResult").disabled =true;
		document.getElementById("ifComplete").disabled =true;
		var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
		electionInfoDataSet.set("yearly","");
		electionInfoDataSet.set("season","");
		electionInfoDataSet.set("completeResult","");
		electionInfoDataSet.set("ifComplete","");
	}else{
		document.getElementById("yearly").disabled =false;
		document.getElementById("season").disabled =false;
		document.getElementById("completeResult").disabled =false;
		document.getElementById("ifComplete").disabled =false;
	}
}
