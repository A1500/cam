/*
window.onbeforeunload = function(){
		if(save()==false){
			return "保存出错,离开本页将不能保存数据";
		}
}
window.onunload = function(){
		window.onbeforeunload =function(){};
}*/
var isInsert=false;
function init(){
 	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	var electionPrepare2DataSet=L5.DatasetMgr.lookup("electionPrepare2DataSet");
	reportWorkDataSet.load();
	electionPrepare2DataSet.on("load",function(){
		if (electionPrepare2DataSet.getCount()>0){
			electionPrepare2DataSet.set("reportDate",reportTime);
			electionPrepare2DataSet.set("recordId",recordId);
			electionPrepare2DataSet.set("prepareId","");
			var prepare = electionPrepare2DataSet.getCurrent();
			electionPrepareDataSet.newRecord(prepare.data);
			var election = electionPrepareDataSet.getCurrent();
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionPrepareDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			});
		}
	});
	electionPrepareDataSet.on("load",function(){
		var prepare = electionPrepareDataSet.getCurrent();
		if(prepare==null){
			electionPrepareDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime});
			isInsert=true;
		}else{
			document.getElementById("backInsert").style.display = 'none';
			isInsert=false;
		}
	});
	electionPrepareDataSet.setParameter("RECORD_ID@=",recordId);
	electionPrepareDataSet.load();
}
function save(){
	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	
	if(document.getElementById("villagerNum").value==""){
		L5.Msg.alert("提示","选民总数不能为空！");
		return false;
	}
	if(document.getElementById("joinVillagerNum").value==""){
		L5.Msg.alert("提示","本届登记选民人数不能为空！");
		return false;
	}
	if(document.getElementById("eleFemaleNum").value==""){
		L5.Msg.alert("提示","本届登记选民少数女性人数不能为空！");
		return false;
	}
	if(document.getElementById("eleFolkNum").value==""){
		L5.Msg.alert("提示","本届登记选民少数民族人数不能为空！");
		return false;
	}
	if(document.getElementById("electionManner").value==""){
		L5.Msg.alert("提示","选举委员会产生方式不能为空！");
		return false;
	}
	if(document.getElementById("eleComNum").value==""){
		L5.Msg.alert("提示","选举委员会总人数不能为空！");
		return false;
	}
	if(document.getElementById("eleComPartyNum").value==""){
		L5.Msg.alert("提示","选举委员会党员人数不能为空！");
		return false;
	}
	var record = electionPrepareDataSet.getCurrent();
	
	if(Number(record.get("eleFemaleNum"))>Number(record.get("joinVillagerNum"))){
		L5.Msg.alert("提示","本届登记选民少数女性人数应小于等于本届登记选民人数！");
		return false;
	}
	if(Number(record.get("eleFolkNum"))>Number(record.get("villagerNum"))){
		L5.Msg.alert("提示","本届登记选民少数民族人数应小于等于本届登记选民人数！");
		return false;
	}
	if(Number(record.get("joinVillagerNum"))>Number(record.get("villagerNum"))){
		L5.Msg.alert("提示","本届登记选民人数应小于等于选民总数！");
		return false;
	}
	if(Number(record.get("eleComNum"))>Number(record.get("villagerNum"))){
		L5.Msg.alert("提示","选举委员会总人数应小于等于选民总数！");
		return false;
	}
	if(Number(record.get("eleComPartyNum"))>Number(record.get("eleComNum"))){
		L5.Msg.alert("提示","选举委员会党员人数应小于等于选举委员会总人数！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionPrepareCmd");
	command.setParameter("record",record);
	if(isInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionPrepareDataSet.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
		return false;
	}
	
}
function forInsert(){
	var electionPrepare2DataSet=L5.DatasetMgr.lookup("electionPrepare2DataSet");
	electionPrepare2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionPrepare2DataSet.setParameter("sort","CREATE_TIME");	
	electionPrepare2DataSet.setParameter("dir","desc");
	electionPrepare2DataSet.load();
}
//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/[^\d]/g;
	   if ((offOtherMon.match(reg)!= null)){ 
	   L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}