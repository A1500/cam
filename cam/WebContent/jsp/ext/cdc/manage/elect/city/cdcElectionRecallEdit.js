var ifInsert ;
function init(){
 	var electionVoteDataSet=L5.DatasetMgr.lookup("electionVoteDataSet");
 	var electionVote2DataSet=L5.DatasetMgr.lookup("electionVote2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionVoteDataSet.on("load",function(){
		var nominate = electionVoteDataSet.getCurrent();
		if(nominate==null){
			electionVoteDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime});
			ifInsert = true;
		}else{
			document.getElementById("backInsert").style.display = 'none';
			ifInsert = false;
		}
		
	});
	electionVote2DataSet.on("load",function(){
		if (electionVote2DataSet.getCount()>0){
			electionVote2DataSet.set("reportDate",reportTime);
			electionVote2DataSet.set("recordId",recordId);
			electionVote2DataSet.set("voteId","");
			var prepare = electionVote2DataSet.getCurrent();
			electionVoteDataSet.newRecord(prepare.data);
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionVoteDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"C","recordId":recordId,"reportDate":reportTime});
			});
		}
	});
	electionVoteDataSet.setParameter("RECORD_ID@=",recordId);
	electionVoteDataSet.load();
}
/*
window.onbeforeunload = function(){
		if(save()==false){
			return "保存出错,离开本页将不能保存数据";
		}
}
window.onunload = function(){
		window.onbeforeunload =function(){};
}*/
function save(){
	if(document.getElementById("dismissHeadNum").value==""){
		L5.Msg.alert("提示","罢免主任人数不能为空！");
		return false;
	}
	if(document.getElementById("dismissSheadNum").value==""){
		L5.Msg.alert("提示","罢免副主任人数不能为空！");
		return false;
	}
	if(document.getElementById("dismissMemberNum").value==""){
		L5.Msg.alert("提示","罢免委员人数不能为空！");
		return false;
	}
	var electionVoteDataSet=L5.DatasetMgr.lookup("electionVoteDataSet");
	var isValidate = electionVoteDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = electionVoteDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionVoteCmd");
	command.setParameter("record",record);
	if(ifInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionVoteDataSet.reload();
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
function forInsert(){
	var electionVote2DataSet=L5.DatasetMgr.lookup("electionVote2DataSet");
	electionVote2DataSet.removeAll();
	electionVote2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionVote2DataSet.setParameter("sort","CREATE_TIME");	
	electionVote2DataSet.setParameter("dir","desc");
	electionVote2DataSet.load();
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