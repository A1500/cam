var isInsert=false;
var orgName ;
function init(){
 	var supDs=L5.DatasetMgr.lookup("supDs");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName  = OrgNameDataset.get("text");
		supDs.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			isInsert=true;
	});
	reportWorkDataSet.load();
	supDs.on("load",function(){
		var nominate = supDs.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}else{
			isInsert=false;
			getPer();
		}
	});
	
	supDs.setParameter("RECORD_ID@=",recordId);
	supDs.load();
	peopleDs.setParameter("RECORD_ID@=",recordId);
	peopleDs.setParameter("TYPE@=","B");
	peopleDs.load();
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
	var supDs=L5.DatasetMgr.lookup("supDs");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var rec=supDs.getCurrent();
	if(rec.get("supMbNum")==""&&rec.get("supMbNum")!=0){
		L5.Msg.alert("提示","村务监督委员会成员数不能为空!");
		return false;
	}
	if("3,4,5".indexOf(rec.get("supMbNum"))<0){
		L5.Msg.alert("提示","村务监督委员会成员数为3-5人!",function(){
			document.getElementById("supMbNum").focus();
		});
		return false;
	}
	if(rec.get("supManner")==""&&rec.get("supMbNum")!=0){
		L5.Msg.alert("提示","产生方式不能为空!");
		return false;
	}
	if(rec.get("supManner")=="1"){
		if(rec.get("meetingNum")==""&&rec.get("meetingNum")!=0){
			L5.Msg.alert("提示","登记参加选举的村民（户代表）总数不能为空!");
			return false;
		}
		if(rec.get("meetingActNum")==""&&rec.get("meetingActNum")!=0){
			L5.Msg.alert("提示","实际参加推选人数不能为空!");
			return false;
		}
		if(rec.get("meetingAgreeNum")==""&&rec.get("meetingAgreeNum")!=0){
			L5.Msg.alert("提示","同意人数不能为空!");
			return false;
		}
		if(rec.get("meetingUnagreeNum")==""&&rec.get("meetingUnagreeNum")!=0){
			L5.Msg.alert("提示","不同意人数不能为空!");
			return false;
		}
		if(rec.get("meetingGiveupNum")==""&&rec.get("meetingGiveupNum")!=0){
			L5.Msg.alert("提示","弃权人数不能为空!");
			return false;
		}
		rec.set("sovietNum","");
		rec.set("sovietActNum","");
		rec.set("sovietAgreeNum","");
		rec.set("sovietUnagreeNum","");
		rec.set("sovietGiveupNum","");
	}
	if(rec.get("supManner")=="2"){
		if(rec.get("sovietNum")==""&&rec.get("sovietNum")!=0){
			L5.Msg.alert("提示","村民代表会议总数不能为空!");
			return false;
		}
		if(rec.get("sovietActNum")==""&&rec.get("sovietActNum")!=0){
			L5.Msg.alert("提示","实际参加推选人数不能为空!");
			return false;
		}
		if(rec.get("sovietAgreeNum")==""&&rec.get("sovietAgreeNum")!=0){
			L5.Msg.alert("提示","同意人数不能为空!");
			return false;
		}
		if(rec.get("sovietUnagreeNum")==""&&rec.get("sovietUnagreeNum")!=0){
			L5.Msg.alert("提示","不同意人数不能为空!");
			return false;
		}
		if(rec.get("sovietGiveupNum")==""&&rec.get("sovietGiveupNum")!=0){
			L5.Msg.alert("提示","弃权人数不能为空!");
			return false;
		}
		rec.set("meetingNum","");
		rec.set("meetingActNum","");
		rec.set("meetingAgreeNum","");
		rec.set("meetingUnagreeNum","");
		rec.set("meetingGiveupNum","");
	}
	if(rec.get("recallDuty")!=""){
		if(rec.get("recallVoteNum")==""&&rec.get("recallVoteNum")!=0){
			L5.Msg.alert("提示","登记参加选举张榜公布的村民总数不能为空!");
			return false;
		}
		if(rec.get("recallFemaleNum")==""&&rec.get("recallFemaleNum")!=0){
			L5.Msg.alert("提示","女性人数不能为空!");
			return false;
		}
		if(rec.get("recallFolkNum")==""&&rec.get("recallFolkNum")!=0){
			L5.Msg.alert("提示","少数民族人数不能为空!");
			return false;
		}
		if(rec.get("recallEntrustNum")==""&&rec.get("recallEntrustNum")!=0){
			L5.Msg.alert("提示","委托投票人数不能为空!");
			return false;
		}
		if(rec.get("recallFlowNum")==""&&rec.get("recallFlowNum")!=0){
			L5.Msg.alert("提示","使用流动票箱投票人数不能为空!");
			return false;
		}
		if(rec.get("recallReplaceNum")==""&&rec.get("recallReplaceNum")!=0){
			L5.Msg.alert("提示","代写选票人数不能为空!");
			return false;
		}
		if(rec.get("recallNum")==""&&rec.get("recallNum")!=0){
			L5.Msg.alert("提示","参加罢免大会投票的选民数不能为空!");
			return false; 
		}
		if(rec.get("recallSubNum")==""&&rec.get("recallSubNum")!=0){
			L5.Msg.alert("提示","设立分会场数不能为空!");
			return false;
		}
		if(rec.get("recallBoxNum")==""&&rec.get("recallBoxNum")!=0){
			L5.Msg.alert("提示","投票箱总数不能为空!");
			return false;
		}
		if(rec.get("recallMeetingNum"&&rec.get("recallMeetingNum")!=0)==""){
			L5.Msg.alert("提示","实际参加投票罢免会议的村民总数不能为空!");
			return false;
		}
		if(rec.get("recallAgreeNum"&&rec.get("recallAgreeNum")!=0)==""){
			L5.Msg.alert("提示","同意罢免村民数不能为空!");
			return false;
		}
		if(rec.get("recallUnagreeNum"&&rec.get("recallUnagreeNum")!=0)==""){
			L5.Msg.alert("提示","不同意罢免村民数不能为空!");
			return false;
		}
		if(rec.get("recallSuccess")==""&&rec.get("recallSuccess")!=0){
			L5.Msg.alert("提示","罢免是否成功不能为空!");
			return false;
		}
	}
	if(rec.get("reReason")!=""){
		if(rec.get("reSituation")==""){
			L5.Msg.alert("提示","补选情况不能为空!");
			return;
		}
		if(rec.get("reDirNum")==""&&rec.get("reDirNum")!=0){
			L5.Msg.alert("提示","补选的村委会成员职务（主任、副主任）职数不能为空!");
			return;
		}
		if(rec.get("reComNum")==""&&rec.get("reComNum")!=0){
			L5.Msg.alert("提示","补选的村委会成员职务（委员）职数不能为空!");
			return;
		}
		if(rec.get("reRedNum")==""&&rec.get("reRedNum")!=0){
			L5.Msg.alert("提示","差额数不能为空!");
			return;
		}
		if(rec.get("reSituation")=="1"){
			if(rec.get("reMeetingNum")==""&&rec.get("reMeetingNum")!=0){
				L5.Msg.alert("提示","登记参加选举的村民总数不能为空!");
				return;
			}
			if(rec.get("reMeetingFemaleNum")==""&&rec.get("reMeetingFemaleNum")!=0){
				L5.Msg.alert("提示","女性人数不能为空!");
				return;
			}
			if(rec.get("reMeetingFolkNum")==""&&rec.get("reMeetingFolkNum")!=0){
				L5.Msg.alert("提示","少数民族人数不能为空!");
				return;
			}
			if(rec.get("reEntrustNum")==""&&rec.get("reEntrustNum")!=0){
				L5.Msg.alert("提示","委托投票人数不能为空!");
				return;
			}
			if(rec.get("reFlowNum")==""&&rec.get("reFlowNum")!=0){
				L5.Msg.alert("提示","使用流动票箱投票人数不能为空!");
				return;
			}
			if(rec.get("reReplaceNum")==""&&rec.get("reReplaceNum")!=0){
				L5.Msg.alert("提示","代写选票人数不能为空!");
				return;
			}
			if(rec.get("reActNum")==""&&rec.get("reActNum")!=0){
				L5.Msg.alert("提示","实际参加投票的村民总数不能为空!");
				return;
			}
		}
		if(rec.get("reSituation")=="2"){
			if(rec.get("reSovietNum")==""&&rec.get("reSovietNum")!=0){
				L5.Msg.alert("提示","村民代表总数不能为空!");
				return;
			}
			if(rec.get("reSovietFemaleNum"&&rec.get("reSovietFemaleNum")!=0)==""){
				L5.Msg.alert("提示","女性人数不能为空!");
				return;
			}
			if(rec.get("reSovietFolkNum")==""&&rec.get("reSovietFolkNum")!=0){
				L5.Msg.alert("提示","少数民族人数不能为空!");
				return;
			}
			if(rec.get("reSovietJoinNum")==""&&rec.get("reSovietJoinNum")!=0){
				L5.Msg.alert("提示","参加村民代表会议的村民代表人数不能为空!");
				return;
			}
		}
		if(peopleDs.getCount()<1){
			L5.Msg.alert("提示","补选成员情况不能为空!");
			return;
		}
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionSupCmd");
	command.setParameter("record",rec);
	command.setParameter("list",peopleDs.getAllRecords());
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
var isAdd=false;
function insert(){
	L5.getCmp("hxWin").show();
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	peopleDs.newRecord({"type":"B"});
	isAdd=true;
}
function update(){
	L5.getCmp("hxWin").show();
	isAdd=false;
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	peopleDs.remove(records[0]);
}
function confirm(){
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var rec=peopleDs.getCurrent();
	if(rec.get("name")==""){
		L5.Msg.alert("提示","姓名不能为空!");
		return;
	}
	if(rec.get("sex")==""){
		L5.Msg.alert("提示","性别不能为空!");
		return;
	}
	if(rec.get("age")==""){
		L5.Msg.alert("提示","年龄不能为空!");
		return;
	}
	if(rec.get("folk")==""){
		L5.Msg.alert("提示","民族不能为空!");
		return;
	}
	if(rec.get("political")==""){
		L5.Msg.alert("提示","政治面貌不能为空!");
		return;
	}
	if(rec.get("education")==""){
		L5.Msg.alert("提示","文化程度不能为空!");
		return;
	}
	if(rec.get("duty")==""){
		L5.Msg.alert("提示","当选职务不能为空!");
		return;
	}
	if(rec.get("dutyVoteNum")==""){
		L5.Msg.alert("提示","当选票数不能为空!");
		return;
	}
	if(rec.get("voteNum")==""){
		L5.Msg.alert("提示","总票数不能为空!");
		return;
	}
	L5.getCmp("hxWin").hide();
}
function closeWin(){
	if(isAdd){
		var peopleDs=L5.DatasetMgr.lookup("peopleDs");
		peopleDs.remove(peopleDs.getCurrent());
	}
	L5.getCmp("hxWin").hide();
}
function firstChange(o){
	if(o.value=='1'){
		var peopleDs=L5.DatasetMgr.lookup("peopleDs");
		peopleDs.set('ifReduty','0');
	}
}
function redutyChange(o){
	if(o.value=='1'){
		var peopleDs=L5.DatasetMgr.lookup("peopleDs");
		peopleDs.set('ifFirst','0');
	}
}
function getSupManner(){
	if(_$("supManner")=='1'){
		$("cm1").style.display="";
		$("cm2").style.display="";
		$("cmdb1").style.display="none";
		$("cmdb2").style.display="none";
	}else if(_$("supManner")=='2'){
		$("cm1").style.display="none";
		$("cm2").style.display="none";
		$("cmdb1").style.display="";
		$("cmdb2").style.display="";
	}else{
		$("cm1").style.display="none";
		$("cm2").style.display="none";
		$("cmdb1").style.display="none";
		$("cmdb2").style.display="none";
	}
}
function getResituation(){
	if(_$("reSituation")=='1'){
		$("recm1").style.display="";
		$("recm2").style.display="";
		$("recm3").style.display="";
		$("recmdb1").style.display="none";
		$("recmdb2").style.display="none";
	}else if(_$("reSituation")=='2'){
		$("recm1").style.display="none";
		$("recm2").style.display="none";
		$("recm3").style.display="none";
		$("recmdb1").style.display="";
		$("recmdb2").style.display="";
	}else{
		$("recm1").style.display="none";
		$("recm2").style.display="none";
		$("recm3").style.display="none";
		$("recmdb1").style.display="none";
		$("recmdb2").style.display="none";
	}
}
function getPer(){
	var supDs=L5.DatasetMgr.lookup("supDs");
	var rec=supDs.getCurrent();
	if(_$("recallVoteNum")=="0"||_$("recallVoteNum")==""){
		rec.set("recallPer", "--");
	}else{
		rec.set("recallPer", Math.round((_$("recallNum")/_$("recallVoteNum"))*10000)/100);
	}
	if(_$("reMeetingNum")=="0"||_$("reMeetingNum")==""){
		rec.set("rePer", "--");
	}else{
		rec.set("rePer", Math.round((_$("reActNum")/_$("reMeetingNum"))*10000)/100);
	}
	if(_$("reSovietNum")=="0"||_$("reSovietNum")==""){
		rec.set("reSovietPer", "--");
	}else{
		rec.set("reSovietPer", Math.round((_$("reSovietJoinNum")/_$("reSovietNum"))*10000)/100);
	}
}
function pRender(val){
	if(val!=""){
		return val+" %";
	}
}