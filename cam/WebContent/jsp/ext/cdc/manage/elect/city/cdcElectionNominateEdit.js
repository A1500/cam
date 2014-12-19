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
 	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
 	var electionNominate2DataSet=L5.DatasetMgr.lookup("electionNominate2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionNominateDataSet.on("load",function(){
		var nominate = electionNominateDataSet.getCurrent();
		if(nominate==null){
			electionNominateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			isInsert=true;
		}else{
			document.getElementById("backInsert").style.display = 'none';
			isInsert=false;
		}
	});
	electionNominate2DataSet.on("load",function(){
		if (electionNominate2DataSet.getCount()>0){
			electionNominate2DataSet.set("reportDate",reportTime);
			electionNominate2DataSet.set("recordId",recordId);
			electionNominate2DataSet.set("nominateId","");
			var nominate = electionNominate2DataSet.getCurrent();
			electionNominateDataSet.removeAll();
			electionNominateDataSet.newRecord(nominate.data);
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionNominateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			});
		}
	});
	electionNominateDataSet.setParameter("RECORD_ID@=",recordId);
	electionNominateDataSet.load();
	
}
function save(){
	if(document.getElementById("nomJoinNum").value==""){
		L5.Msg.alert("提示","初步候选人总人数不能为空！");
		return false;
	}
	if(document.getElementById("prenomNum").value==""){
		L5.Msg.alert("提示","初步候选人女性人数不能为空！");
		return false;
	}
	if(document.getElementById("prenomDiffNum").value==""){
		L5.Msg.alert("提示","初步候选人党员人数不能为空！");
		return false;
	}
	if(document.getElementById("prenomJoinNum").value==""){
		L5.Msg.alert("提示","初步候选人少数民族人数不能为空！");
		return;
	}
	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
	var isValidate = electionNominateDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = electionNominateDataSet.getCurrent();
	if(Number(record.get("prenomNum"))>Number(record.get("nomJoinNum"))){
		L5.Msg.alert("提示","初步候选人女性人数应小于等于初步候选人人数！");
		return false;
	}
	if(Number(record.get("prenomDiffNum"))>Number(record.get("nomJoinNum"))){
		L5.Msg.alert("提示","初步候选人党员人数应小于等于初步候选人人数！");
		return false;
	}
	if(Number(record.get("prenomJoinNum"))>Number(record.get("nomJoinNum"))){
		L5.Msg.alert("提示","初步候选人少数民族人数应小于等于初步候选人人数！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionNominateCmd");
	command.setParameter("record",record);
	if(isInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionNominateDataSet.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
		return false;
	}
	
}
function forInsert(){
	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
	electionNominateDataSet.removeAll();
	electionNominateDataSet.setParameter("ORGAN_CODE@=", organCode);
	electionNominateDataSet.setParameter("sort","CREATE_TIME");	
	electionNominateDataSet.setParameter("dir","desc");
	electionNominateDataSet.load();
	electionNominateDataSet.on("load",function(){
		if (electionNominateDataSet.getCount()>0){
			electionNominateDataSet.set("reportDate",reportTime);
			electionNominateDataSet.set("recordId",recordId);
			electionNominateDataSet.set("nominateId","");
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionNominateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			});
		}
	});
}
function forInsert(){
	var electionNominate2DataSet=L5.DatasetMgr.lookup("electionNominate2DataSet");
	electionNominate2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionNominate2DataSet.setParameter("sort","CREATE_TIME");	
	electionNominate2DataSet.setParameter("dir","desc");
	electionNominate2DataSet.load();
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