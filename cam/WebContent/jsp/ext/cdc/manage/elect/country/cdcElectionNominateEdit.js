var isInsert=false;
var orgName ;
function init(){
 	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
 	var electionNominate2DataSet=L5.DatasetMgr.lookup("electionNominate2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	
	electionNominateDataSet.on("load",function(){
		var nominate = electionNominateDataSet.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}else{
			isInsert=false;
		}
	});
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
		electionNominateDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime,"communityNum":1});
		isInsert=true;
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
				electionNominateDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			});
		}
	});
	electionNominateDataSet.setParameter("RECORD_ID@=",recordId);
	electionNominateDataSet.load();
	peopleDs.setParameter("RECORD_ID@=",recordId);
	peopleDs.setParameter("TYPE@=","H");
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
	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var rec=electionNominateDataSet.getCurrent();
	if(rec.get("candidateManner")==""){
		L5.Msg.alert("提示","产生方式不能为空!");
		return false;
	}
	if(rec.get("candidateManner")=="1"){
		if(rec.get("nomNum")==""&&rec.get("comDeputyNum")!=0){
			L5.Msg.alert("提示","村民委员会候选人应选职数不能为空!");
			return false;
		}
		if(rec.get("nomDiffNum")==""&&rec.get("nomDiffNum")!=0){
			L5.Msg.alert("提示","差额数不能为空!");
			return false;
		}
		if(rec.get("nomJoinNum")==""&&rec.get("nomJoinNum")!=0){
			L5.Msg.alert("提示","参加提名的登记参加选举的村民数不能为空!");
			return false;
		}
	}else if(rec.get("candidateManner")=="2"){
		if(rec.get("prenomNum")==""&&rec.get("prenomNum")!=0){
			L5.Msg.alert("提示","村民委员会应选职数不能为空!");
			return false;
		}
		if(rec.get("prenomJoinNum")==""&&rec.get("prenomJoinNum")!=0){
			L5.Msg.alert("提示","参加村民委员会成员候选人预选（提名）投票的村民数不能为空!");
			return false;
		}
		if(rec.get("prenomCanNum")==""&&rec.get("prenomCanNum")!=0){
			L5.Msg.alert("提示","候选人确定人数不能为空!");
			return false;
		}
		if(rec.get("prenomCanDiffNum")==""&&rec.get("prenomCanDiffNum")!=0){
			L5.Msg.alert("提示","差额数不能为空!");
			return false;
		}
	}else if(rec.get("candidateManner")=="3"){
		if(rec.get("preNum")==""&&rec.get("preNum")!=0){
			L5.Msg.alert("提示","村民委员会应选职数不能为空!");
			return false;
		}
		if(rec.get("preCanNum")==""&&rec.get("preCanNum")!=0){
			L5.Msg.alert("提示","候选人数不能为空!");
			return false;
		}
		if(rec.get("preJoinNum")==""&&rec.get("preJoinNum")!=0){
			L5.Msg.alert("提示","参加村民委员会成员候选人预选投票的村民数不能为空!");
			return false;
		}
	}
	if(peopleDs.getCount()<1){
		L5.Msg.alert("提示","候选人信息不能为空!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionNominateCmd");
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
			peopleDs.reload();
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
	var electionNominate2DataSet=L5.DatasetMgr.lookup("electionNominate2DataSet");
	electionNominate2DataSet.setParameter("ORGAN_CODE@=", organ_Code);
	electionNominate2DataSet.setParameter("sort","CREATE_TIME");	
	electionNominate2DataSet.setParameter("dir","desc");
	electionNominate2DataSet.load();
}
var isAdd=false;
function insert(){
	L5.getCmp("hxWin").show();
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	peopleDs.newRecord({"type":"H"});
	isAdd=true;
	if(_$("candidateManner")=="1"){
		$("tmWin").style.display="";
		$("tmyxWin").style.display="none";
		$("yxWin").style.display="none";
	}else if(_$("candidateManner")=="2"){
		$("tmWin").style.display="none";
		$("tmyxWin").style.display="";
		$("yxWin").style.display="none";
	}else if(_$("candidateManner")=="3"){
		$("tmWin").style.display="none";
		$("tmyxWin").style.display="none";
		$("yxWin").style.display="";
	}
}
function update(){
	L5.getCmp("hxWin").show();
	isAdd=false;
	if(_$("candidateManner")=="1"){
		$("tmWin").style.display="";
		$("tmyxWin").style.display="none";
		$("yxWin").style.display="none";
	}else if(_$("candidateManner")=="2"){
		$("tmWin").style.display="none";
		$("tmyxWin").style.display="";
		$("yxWin").style.display="none";
	}else if(_$("candidateManner")=="3"){
		$("tmWin").style.display="none";
		$("tmyxWin").style.display="none";
		$("yxWin").style.display="";
	}
}
function del(){
	var grid=L5.getCmp("grid1");
	if(_$("candidateManner")=="1"){
		grid=L5.getCmp("grid1");
	}else if(_$("candidateManner")=="2"){
		grid=L5.getCmp("grid2");
	}else if(_$("candidateManner")=="3"){
		grid=L5.getCmp("grid3");
	}
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
	if(_$("candidateManner")=="1"){
		if(rec.get("nomManner")==""){
			L5.Msg.alert("提示","提名形式不能为空!");
			return;
		}
		if(rec.get("nomNum")==""){
			L5.Msg.alert("提示","提名人数为空或者为0，请修改!",function(){
				document.getElementById("winnomNum").focus();
			});
			return;
		}
	}else if(_$("candidateManner")=="2"){
		if(rec.get("voteNum")==""){
			L5.Msg.alert("提示","得票数不能为空!");
			return;
		}
		if(rec.get("ifReduty")==""){
			L5.Msg.alert("提示","是否连选连任不能为空!");
			return;
		}
	}else if(_$("candidateManner")=="3"){
		if(rec.get("voteNum")==""){
			L5.Msg.alert("提示","得票数不能为空!");
			return;
		}
	}
	if(rec.get("peopleSource")==""){
		L5.Msg.alert("提示","来源不能为空!");
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
function getManner(){
	var grid1=L5.getCmp("grid1");
	var grid2=L5.getCmp("grid2");
	var grid3=L5.getCmp("grid3");
	if(_$("candidateManner")=="1"){
		$("tm").style.display="";
		$("tmyx1").style.display="none";
		$("tmyx2").style.display="none";
		$("yx1").style.display="none";
		grid1.show();
		grid2.hide();
		grid3.hide();
	}else if(_$("candidateManner")=="2"){
		$("tm").style.display="none";
		$("tmyx1").style.display="";
		$("tmyx2").style.display="";
		$("yx1").style.display="none";
		grid1.hide();
		grid2.show();
		grid3.hide();
	}else if(_$("candidateManner")=="3"){
		$("tm").style.display="none";
		$("tmyx1").style.display="none";
		$("tmyx2").style.display="none";
		$("yx1").style.display="";
		grid1.hide();
		grid2.hide();
		grid3.show();
	}else{
		$("tm").style.display="none";
		$("tmyx1").style.display="none";
		$("tmyx2").style.display="none";
		$("yx1").style.display="none";
		grid1.hide();
		grid2.hide();
		grid3.hide();
	}
}