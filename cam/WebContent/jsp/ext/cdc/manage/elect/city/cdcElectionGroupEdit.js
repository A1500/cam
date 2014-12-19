/*
window.onbeforeunload = function(){
		if(save()==false){
			return "保存出错,离开本页将不能保存数据";
		}
}
window.onunload = function(){
		window.onbeforeunload =function(){};
}*/
var ifInsert ;
function init(){
 	var electionGroupDataSet=L5.DatasetMgr.lookup("electionGroupDataSet");
 	var electionGroup2DataSet=L5.DatasetMgr.lookup("electionGroup2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionGroupDataSet.on("load",function(){
		var nominate = electionGroupDataSet.getCurrent();
		if(nominate==null){
			electionGroupDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime});
			ifInsert = true;
		}else{
			document.getElementById("backInsert").style.display = 'none';
			ifInsert = false;
		}
	});
	electionGroup2DataSet.on("load",function(){
		if (electionGroup2DataSet.getCount()>0){
			electionGroup2DataSet.set("reportDate",reportTime);
			electionGroup2DataSet.set("recordId",recordId);
			electionGroup2DataSet.set("groupId","");
			var prepare = electionGroup2DataSet.getCurrent();
			electionGroupDataSet.newRecord(prepare.data);
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionGroupDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime});
			});
		}
	});
	electionGroupDataSet.setParameter("RECORD_ID@=",recordId);
	electionGroupDataSet.load();
}
function save(){
	if(document.getElementById("delegateNum").value==""){
		L5.Msg.alert("提示","居民代表人数不能为空！");
		return false;
	}
	if(document.getElementById("delegateFemaleNum").value==""){
		L5.Msg.alert("提示","居民代表女性人数不能为空！");
		return false;
	}
	if(document.getElementById("delegatePartyNum").value==""){
		L5.Msg.alert("提示","居民代表党员人数不能为空！");
		return false;
	}
	if(document.getElementById("delegateFolkNum").value==""){
		L5.Msg.alert("提示","居民代表少数民族数不能为空！");
		return false;
	}
	if(document.getElementById("headmanNum").value==""){
		L5.Msg.alert("提示","居民小组长人数不能为空！");
		return false;
	}
	if(document.getElementById("headmanFemaleNum").value==""){
		L5.Msg.alert("提示","居民小组长女性人数不能为空！");
		return false;
	}
	if(document.getElementById("headmanPartyNum").value==""){
		L5.Msg.alert("提示","居民小组长党员数不能为空！");
		return false;
	}
	if(document.getElementById("headmanFolkNum").value==""){
		L5.Msg.alert("提示","居民小组长少数民族人数不能为空！");
		return false;
	}
	var electionGroupDataSet=L5.DatasetMgr.lookup("electionGroupDataSet");
	var isValidate = electionGroupDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = electionGroupDataSet.getCurrent();
	if(Number(record.get("delegateFemaleNum"))>Number(record.get("delegateNum"))){
		L5.Msg.alert("提示","居民代表女性人数应小于等于居民代表人数！");
		return false;
	}
	if(Number(record.get("delegatePartyNum"))>Number(record.get("delegateNum"))){
		L5.Msg.alert("提示","居民代表党员人数应小于等于居委会委员人数！");
		return false;
	}
	if(Number(record.get("delegateFolkNum"))>Number(record.get("delegateNum"))){
		L5.Msg.alert("提示","居民代表少数民族数应小于等于居委会委员人数！");
		return false;
	}
	if(Number(record.get("headmanFemaleNum"))>Number(record.get("headmanNum"))){
		L5.Msg.alert("提示","居民小组长女性人数应小于等于居民小组长人数！");
		return false;
	}
	if(Number(record.get("headmanPartyNum"))>Number(record.get("headmanNum"))){
		L5.Msg.alert("提示","居民小组长党员数应小于等于居民小组长人数！");
		return false;
	}
	if(Number(record.get("headmanFolkNum"))>Number(record.get("headmanNum"))){
		L5.Msg.alert("提示","居民小组长少数民族人数应小于等于居民小组长人数！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionGroupCmd");
	command.setParameter("record",record);
	if(ifInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionGroupDataSet.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
		return false;
	}
	
}
function forInsert(){
	var electionGroup2DataSet=L5.DatasetMgr.lookup("electionGroup2DataSet");
	electionGroup2DataSet.removeAll();
	electionGroup2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionGroup2DataSet.setParameter("sort","CREATE_TIME");	
	electionGroup2DataSet.setParameter("dir","desc");
	electionGroup2DataSet.load();
}