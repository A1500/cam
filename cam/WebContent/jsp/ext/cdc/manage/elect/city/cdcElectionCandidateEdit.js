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
 	var electionCandidateDataSet=L5.DatasetMgr.lookup("electionCandidateDataSet");
 	var electionCandidate2DataSet=L5.DatasetMgr.lookup("electionCandidate2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionCandidateDataSet.on("load",function(){
		var candidate = electionCandidateDataSet.getCurrent();
		if(candidate==null){
			electionCandidateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime});
			ifInsert = true;
		}else{
			document.getElementById("backInsert").style.display = 'none';
			ifInsert = false;
		}
	});
	electionCandidate2DataSet.on("load",function(){
		if (electionCandidate2DataSet.getCount()>0){
			electionCandidate2DataSet.set("reportDate",reportTime);
			electionCandidate2DataSet.set("recordId",recordId);
			electionCandidate2DataSet.set("candidateId","");
			var candidate = electionCandidate2DataSet.getCurrent();
			electionCandidateDataSet.removeAll();
			electionCandidateDataSet.newRecord(candidate.data);
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionCandidateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime});
			});
		}
	});
	electionCandidateDataSet.setParameter("RECORD_ID@=",recordId);
	electionCandidateDataSet.load();
}
function forInsert(){
	var electionCandidate2DataSet=L5.DatasetMgr.lookup("electionCandidate2DataSet");
	electionCandidate2DataSet.removeAll();
	electionCandidate2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionCandidate2DataSet.setParameter("sort","CREATE_TIME");	
	electionCandidate2DataSet.setParameter("dir","desc");
	electionCandidate2DataSet.load();
}
function save(){
	if(document.getElementById("shouldNum").value==""){
		L5.Msg.alert("提示","应选名额不能为空！");
		return false;
	}
	if(document.getElementById("confirm").value==""){
		L5.Msg.alert("提示","确定方式不能为空！");
		return false;
	}
	if(document.getElementById("candidateNum").value==""){
		L5.Msg.alert("提示","正式候选人人数不能为空！");
		return false;
	}
	if(document.getElementById("femaleNum").value==""){
		L5.Msg.alert("提示","正式候选人女性人数不能为空！");
		return false;
	}
	if(document.getElementById("partyNum").value==""){
		L5.Msg.alert("提示","正式候选人党员人数不能为空！");
		return false;
	}
	if(document.getElementById("folkNum").value==""){
		L5.Msg.alert("提示","正式候选人少数民族人数不能为空！");
		return false;
	}
	if(document.getElementById("ifLecture").value==""){
		L5.Msg.alert("提示","是否组织竞职演讲不能为空！");
		return false;
	}
	var electionCandidateDataSet=L5.DatasetMgr.lookup("electionCandidateDataSet");
	var isValidate = electionCandidateDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = electionCandidateDataSet.getCurrent();
	if(Number(record.get("shouldNum"))>=Number(record.get("candidateNum"))){
		L5.Msg.alert("提示","正式候选人人数应大于总人数！");
		return false;
	}
	if(Number(record.get("femaleNum"))>=Number(record.get("candidateNum"))){
		L5.Msg.alert("提示","女性人数应小于正式候选人人数！");
		return false;
	}
	if(Number(record.get("partyNum"))>=Number(record.get("candidateNum"))){
		L5.Msg.alert("提示","党员人数应小于正式候选人总人数！");
		return false;
	}
	if(Number(record.get("folkNum"))>=Number(record.get("candidateNum"))){
		L5.Msg.alert("提示","少数民族人数应小于正式候选人总人数！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionCandidateCmd");
	command.setParameter("record",record);
	if(ifInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionCandidateDataSet.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
		return false;
	}
	
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