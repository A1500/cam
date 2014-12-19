function init(){
 	var electionProgramDataSet=L5.DatasetMgr.lookup("electionProgramDataSet");
 	var electionProgram2DataSet=L5.DatasetMgr.lookup("electionProgram2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionProgramDataSet.on("load",function(){
		var nominate = electionProgramDataSet.getCurrent();
		if(nominate==null){
			electionProgramDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
		}else{
			document.getElementById("backInsert").style.display = 'none';
		}
		
	});
	electionProgram2DataSet.on("load",function(){
		if (electionProgram2DataSet.getCount()>0){
			electionProgram2DataSet.set("reportDate",reportTime);
			electionProgram2DataSet.set("recordId",recordId);
			electionProgram2DataSet.set("programId","");
			var prepare = electionProgram2DataSet.getCurrent();
			electionProgramDataSet.newRecord(prepare.data);
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionProgramDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
			});
		}
	});
	electionProgramDataSet.setParameter("RECORD_ID@=",recordId);
	electionProgramDataSet.load();
}
function save(){
	if(document.getElementById("ifMeeting").value==""){
		L5.Msg.alert("提示","是否召开选举大会集中投票不能为空！");
		return false;
	}
	if(document.getElementById("ifStation").value==""){
		L5.Msg.alert("提示","是否设投票中心不能为空！");
		return false;
	}
	if(document.getElementById("ifSecret").value==""){
		L5.Msg.alert("提示","是否设秘密写票处不能为空！");
		return false;
	}
	if(document.getElementById("ifFlow").value==""){
		L5.Msg.alert("提示","是否设流动投票箱不能为空！");
		return false;
	}
	if(document.getElementById("ifPublic").value==""){
		L5.Msg.alert("提示","是否公开唱票不能为空！");
		return false;
	}
	if(document.getElementById("ifPublicResult").value==""){
		L5.Msg.alert("提示","是否当场公布选举结果不能为空！");
		return false;
	}
	var electionProgramDataSet=L5.DatasetMgr.lookup("electionProgramDataSet");
	var isValidate = electionProgramDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = electionProgramDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionProgramCmd");
	command.setParameter("record",record);
	command.execute("save");
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionProgramDataSet.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
	
}
function forInsert(){
	var electionProgram2DataSet=L5.DatasetMgr.lookup("electionProgram2DataSet");
	electionProgram2DataSet.removeAll();
	electionProgram2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionProgram2DataSet.setParameter("sort","CREATE_TIME");	
	electionProgram2DataSet.setParameter("dir","desc");
	electionProgram2DataSet.load();
}