var isInsert=false;
var orgName;
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
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionPrepareDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			});
		}
	});
	
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName= OrgNameDataset.get("text");
		electionPrepareDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
		isInsert=true;
	});
	
	electionPrepareDataSet.on("load",function(){
		var prepare = electionPrepareDataSet.getCurrent();
		if(prepare==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}else{
			isInsert=false;
			setDiffReason();
			setManner();
			ifDiffChange();
		}
	});
	electionPrepareDataSet.setParameter("RECORD_ID@=",recordId);
	electionPrepareDataSet.load();
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
	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var record=electionPrepareDataSet.getCurrent();
	
	if(record.get("villageName")==""){
		L5.Msg.alert("提示","干部包村村名不能为空！");
		return false;
	}
	if(record.get("name")==""){
		L5.Msg.alert("提示","干部姓名不能为空！");
		return false;
	}
	if(record.get("sex")==""){
		L5.Msg.alert("提示","性别不能为空！");
		return false;
	}
	if(record.get("linkVillageName")==""){
		L5.Msg.alert("提示","县市区领导干部联系点村名不能为空！");
		return false;
	}
	if(record.get("leaderName")==""){
		L5.Msg.alert("提示","县市区领导姓名不能为空！");
		return false;
	}
	if(record.get("leaderSex")==""){
		L5.Msg.alert("提示","县市区领导性别不能为空！");
		return false;
	}
	if(record.get("leaderDuty")==""){
		L5.Msg.alert("提示","县市区领导职务不能为空！");
		return false;
	}
	if(record.get("ifTest")==""){
		L5.Msg.alert("提示","是否为试点村不能为空！");
		return false;
	}
	if(record.get("economyAudit")==""){
		L5.Msg.alert("提示","离任经济责任审计完成情况不能为空！");
		return false;
	}
	if(record.get("ifDiff")==""){
		L5.Msg.alert("提示","是否难点村不能为空！");
		return false;
	}
	if(record.get("ifDiff")=="0"){
		record.set("diffReason","");
	}else{
		record.set("diffReason",getDiffReason());
	}
	if(record.get("ifDiff")=="1"){
		if(record.get("diffReason")=="00000000000000"){
			L5.Msg.alert("提示","难点原因不能为空！");
			return false;
		}
	}
	if(record.get("changeDate")==""){
		L5.Msg.alert("提示","换届时间不能为空！");
		return false;
	}
	if(record.get("peopleName")==""){
		L5.Msg.alert("提示","责任人不能为空！");
		return false;
	}
	if(record.get("electionManner")==""){
		L5.Msg.alert("提示","村民选举委员会产生方式不能为空！");
		return false;
	}
	if(record.get("electionManner")=="1"){
		if(record.get("villagerNum")==""&&record.get("villagerNum")!=0){
			L5.Msg.alert("提示","村民（户代表）总数不能为空！");
			return false;
		}
		if(record.get("joinVillagerNum")==""&&record.get("joinVillagerNum")!=0){
			L5.Msg.alert("提示","参加推选的村民（户代表）数不能为空！");
			return false;
		}
		record.set("sovietNum","");
		record.set("joinSovietNum","");
		record.set("groupNum","");
		record.set("joinGroupNum","");
	}
	if(record.get("electionManner")=="2"){
		if(record.get("sovietNum")==""&&record.get("sovietNum")!=0){
			L5.Msg.alert("提示","代表会议组成人员总数不能为空！");
			return false;
		}
		if(record.get("joinSovietNum")==""&&record.get("joinSovietNum")!=0){
			L5.Msg.alert("提示","参加推选的村民代表人数不能为空！");
			return false;
		}
		record.set("villagerNum","");
		record.set("joinVillagerNum","");
		record.set("groupNum","");
		record.set("joinGroupNum","");
	}
	if(record.get("electionManner")=="3"){
		if(record.get("groupNum")==""&&record.get("groupNum")!=0){
			L5.Msg.alert("提示","本小组总人（户）数不能为空！");
			return false;
		}
		if(record.get("joinGroupNum")==""&&record.get("joinGroupNum")!=0){
			L5.Msg.alert("提示","参加推选的村民(户代表）人数不能为空！");
			return false;
		}
		record.set("villagerNum","");
		record.set("joinVillagerNum","");
		record.set("sovietNum","");
		record.set("joinSovietNum","");
	}
	if(record.get("eleComNum")==""&&record.get("eleComNum")!=0){
		L5.Msg.alert("提示","村民选举委员会职数不能为空！");
		return false;
	}
	if("5,7,9".indexOf(record.get("eleComNum"))<0){
		L5.Msg.alert("提示","村民选举委员会职数必须为5人、7人或者9人！");
		return false;
	}
	if(record.get("eleComPartyNum")==""&&record.get("eleComPartyNum")!=0){
		L5.Msg.alert("提示","村民选举委员会党员人数不能为空！");
		return false;
	}
	if(record.get("eleComPartyNum")>record.get("eleComNum")){
		L5.Msg.alert("提示","党员人数不能超过村民选举委员会职数！");
		return false;
	}
	if(record.get("eleComFemaleNum")==""&&record.get("eleComFemaleNum")!=0){
		L5.Msg.alert("提示","村民选举委员会妇女成员人数不能为空！");
		return false;
	}
	if(record.get("eleComFemaleNum")>record.get("eleComNum")){
		L5.Msg.alert("提示","妇女成员人数不能超过村民选举委员会职数！");
		return false;
	}
	
	if(record.get("elePeopleNum")==""&&record.get("elePeopleNum")!=0){
		L5.Msg.alert("提示","张榜公布登记参加选举的村民总数不能为空！");
		return false;
	}
	if(record.get("elePartyNum")==""&&record.get("elePartyNum")!=0){
		L5.Msg.alert("提示","党员人数不能为空！");
		return false;
	}
	if(record.get("elePartyNum")>record.get("elePeopleNum")){
		L5.Msg.alert("提示","党员人数不能超过张榜公布登记参加选举的村民总数！");
		return false;
	}
	
	if(record.get("eleFemaleNum")==""&&record.get("eleFemaleNum")!=0){
		L5.Msg.alert("提示","女性人数不能为空！");
		return false;
	}
	if(record.get("eleFemaleNum")>record.get("elePeopleNum")){
		L5.Msg.alert("提示","女性人数不能超过张榜公布登记参加选举的村民总数！");
		return false;
	}
	
	if(record.get("eleFolkNum")==""&&record.get("eleFolkNum")!=0){
		L5.Msg.alert("提示","少数民族人数不能为空！");
		return false;
	}
	if(record.get("eleFolkNum")>record.get("elePeopleNum")){
		L5.Msg.alert("提示","少数民族人数不能超过张榜公布登记参加选举的村民总数！");
		return false;
	}
	
	if(record.get("comPositionNum")==""&&record.get("comPositionNum")!=0){
		L5.Msg.alert("提示","村民委员会组成人员职数不能为空！");
		return false;
	}
	if(record.get("comPositionNum")<3||record.get("comPositionNum")>7){
		L5.Msg.alert("提示","村民委员会组成人员职数必须为3～7人！");
		return false;
	}
	if(record.get("comDeputyNum")==""&&record.get("comDeputyNum")!=0){
		L5.Msg.alert("提示","副主任职数不能为空！");
		return false;
	}
	if(record.get("comMbNum")==""&&record.get("comMbNum")!=0){
		L5.Msg.alert("提示","委员职数不能为空！");
		return false;
	}
	if((parseInt(record.get("comDeputyNum"))+parseInt(record.get("comMbNum"))+1)!=parseInt(record.get("comPositionNum"))){
		L5.Msg.alert("提示","村民委员会组成人员职数与副主任职务和委员职数不符！");
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
			isInsert=false;
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
	
}
function forInsert(){
	var electionPrepare2DataSet=L5.DatasetMgr.lookup("electionPrepare2DataSet");
	electionPrepare2DataSet.setParameter("ORGAN_CODE@=", organ_Code);
	electionPrepare2DataSet.setParameter("sort","CREATE_TIME");	
	electionPrepare2DataSet.setParameter("dir","desc");
	electionPrepare2DataSet.load();
}
function getDiffReason(){
	var flag="";
	for(i=0;i<14;i++){
		if($("n"+i).checked){
			flag+="1";
		}else{
			flag+="0";
		}
	}
	return flag;
}
function setDiffReason(){
	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var record=electionPrepareDataSet.getCurrent();
	var reason=record.get("diffReason");
	var arr=reason.split('');
	for(i=0;i<arr.length;i++){
		if(arr[i]=="1"){
			$("n"+i).checked=true;
		}
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
function getManner(){
	if(_$("electionManner")=='1'){
		$("cm").style.display="";
		$("cmdb").style.display="none";
		$("cmxz").style.display="none";
	}else if(_$("electionManner")=='2'){
		$("cm").style.display="none";
		$("cmdb").style.display="";
		$("cmxz").style.display="none";
	}else if(_$("electionManner")=='3'){
		$("cm").style.display="none";
		$("cmdb").style.display="none";
		$("cmxz").style.display="";
	}else{
		$("cm").style.display="none";
		$("cmdb").style.display="none";
		$("cmxz").style.display="none";
	}
}
function setManner(){
	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var prepare=electionPrepareDataSet.getCurrent();
	if(prepare.get("electionManner")=='1'){
		$("cm").style.display="";
		$("cmdb").style.display="none";
		$("cmxz").style.display="none";
	}else if(prepare.get("electionManner")=='2'){
		$("cm").style.display="none";
		$("cmdb").style.display="";
		$("cmxz").style.display="none";
	}else if(prepare.get("electionManner")=='3'){
		$("cm").style.display="none";
		$("cmdb").style.display="none";
		$("cmxz").style.display="";
	}else{
		$("cm").style.display="none";
		$("cmdb").style.display="none";
		$("cmxz").style.display="none";
	}
}
function ifDiffChange(){
	if($("ifDiff").value=='0'){
		$("ifDiffDiv").style.display="none";
	}else{
		$("ifDiffDiv").style.display="";
	}
}
function setDiffChange(){
	var ds=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var prepare=ds.getCurrent();
	if(prepare.get("ifDiff")=='0'){
		$("ifDiffDiv").style.display="none";
	}else{
		$("ifDiffDiv").style.display="";
	}
}