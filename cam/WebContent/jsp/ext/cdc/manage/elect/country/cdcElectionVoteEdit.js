var isInsert=false;
var orgName;
function init(){
 	var electionVoteDataSet=L5.DatasetMgr.lookup("electionVoteDataSet");
 	var electionVote2DataSet=L5.DatasetMgr.lookup("electionVote2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName  = OrgNameDataset.get("text");
		electionVoteDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
			isInsert=true;
	});
	
	reportWorkDataSet.load();
	electionVoteDataSet.on("load",function(){
		var nominate = electionVoteDataSet.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}else{
			isInsert=false;
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
				electionVoteDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
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
	var electionVoteDataSet=L5.DatasetMgr.lookup("electionVoteDataSet");
	var record=electionVoteDataSet.getCurrent();
	if(record.get("voterManner")==""){
		L5.Msg.alert("提示","投票方式不能为空！");
		return false;
	}
	if(record.get("voterNum")==""&&record.get("voterNum")!=0){
		L5.Msg.alert("提示","参加正式选举投票的村民总数不能为空！");
		return false;
	}
	if(record.get("entrustNum")==""&&record.get("entrustNum")!=0){
		L5.Msg.alert("提示","委托投票人数不能为空！");
		return false;
	}
	if(record.get("flowNum")==""&&record.get("flowNum")!=0){
		L5.Msg.alert("提示","使用流动票箱投票人数不能为空！");
		return false;
	}
	if(record.get("replaceNum")==""&&record.get("replaceNum")!=0){
		L5.Msg.alert("提示","代写选票人数不能为空！");
		return false;
	}
	if(record.get("subNum")==""&&record.get("subNum")!=0){
		L5.Msg.alert("提示","设立分会场数不能为空！");
		return false;
	}
	if(record.get("boxNum")==""&&record.get("boxNum")!=0){
		L5.Msg.alert("提示","投票箱总数不能为空！");
		return false;
	}
	if(record.get("secretNum")==""&&record.get("secretNum")!=0){
		L5.Msg.alert("提示","秘密写票处不能为空！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionVoteCmd");
	command.setParameter("record",record);
	if(isInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error){ 
		L5.Msg.alert("提示","保存成功！",function(){
			isInsert=false;
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
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
	electionVote2DataSet.setParameter("ORGAN_CODE@=", organ_Code);
	electionVote2DataSet.setParameter("sort","CREATE_TIME");	
	electionVote2DataSet.setParameter("dir","desc");
	electionVote2DataSet.load();
}