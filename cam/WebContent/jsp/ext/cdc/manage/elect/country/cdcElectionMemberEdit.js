function init(){
 	var electionMemberDataSet=L5.DatasetMgr.lookup("electionMemberDataSet");
 	var electionMember2DataSet=L5.DatasetMgr.lookup("electionMember2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionMemberDataSet.on("load",function(){
		var nominate = electionMemberDataSet.getCurrent();
		if(nominate==null){
			electionMemberDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
		}else{
			document.getElementById("backInsert").style.display = 'none';
		}
		
	});
	electionMember2DataSet.on("load",function(){
		if (electionMember2DataSet.getCount()>0){
			electionMember2DataSet.set("reportDate",reportTime);
			electionMember2DataSet.set("recordId",recordId);
			electionMember2DataSet.set("memberId","");
			var prepare = electionMember2DataSet.getCurrent();
			electionMemberDataSet.newRecord(prepare.data);
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionMemberDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
			});
		}
	});
	electionMemberDataSet.setParameter("RECORD_ID@=",recordId);
	electionMemberDataSet.load();
}
function save(){
	if(document.getElementById("headNum").value==""){
		L5.Msg.alert("提示","村委会主任人数不能为空！");
		return false;
	}
	if(document.getElementById("headPartyNum").value==""){
		L5.Msg.alert("提示","村委会主任党员人数不能为空！");
		return false;
	}
	if(document.getElementById("sheadNum").value==""){
		L5.Msg.alert("提示","村委会副主任人数不能为空！");
		return false;
	}
	if(document.getElementById("sheadPartyNum").value==""){
		L5.Msg.alert("提示","村委会副主任党员人数不能为空！");
		return false;
	}
	if(document.getElementById("memberNum").value==""){
		L5.Msg.alert("提示","村委会委员人数不能为空！");
		return false;
	}
	if(document.getElementById("headmanFemaleNum").value==""){
		L5.Msg.alert("提示","村委会委员党员人数不能为空！");
		return false;
	}
	var electionMemberDataSet=L5.DatasetMgr.lookup("electionMemberDataSet");
	var isValidate = electionMemberDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = electionMemberDataSet.getCurrent();
	if(Number(record.get("headPartyNum"))>Number(record.get("headNum"))){
		L5.Msg.alert("提示","村委会主任党员人数应小于等于村委会主任人数！");
		return false;
	}
	if(Number(record.get("sheadPartyNum"))>Number(record.get("sheadNum"))){
		L5.Msg.alert("提示","村委会副主任党员人数应小于等于村委会副主任人数！");
		return false;
	}
	if(Number(record.get("headmanFemaleNum"))>Number(record.get("memberNum"))){
		L5.Msg.alert("提示","村委会委员党员人数应小于等于村委会委员人数！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionMemberCmd");
	command.setParameter("record",record);
	command.execute("save");
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionMemberDataSet.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
	
}
function forInsert(){
	var electionMember2DataSet=L5.DatasetMgr.lookup("electionMember2DataSet");
	electionMember2DataSet.removeAll();
	electionMember2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionMember2DataSet.setParameter("sort","CREATE_TIME");	
	electionMember2DataSet.setParameter("dir","desc");
	electionMember2DataSet.load();
}