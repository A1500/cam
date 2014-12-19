function init(){
 	var electionCommitteeDataSet=L5.DatasetMgr.lookup("electionCommitteeDataSet");
 	var electionCommittee2DataSet=L5.DatasetMgr.lookup("electionCommittee2DataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionCommitteeDataSet.on("load",function(){
		var committee = electionCommitteeDataSet.getCurrent();
		if(committee==null){
			electionCommitteeDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
		}else{
			document.getElementById("backInsert").style.display = 'none';
		}
		
	});
	electionCommittee2DataSet.on("load",function(){
		if (electionCommittee2DataSet.getCount()>0){
			electionCommittee2DataSet.set("reportDate",reportTime);
			electionCommittee2DataSet.set("recordId",recordId);
			electionCommittee2DataSet.set("committeeId","");
			var prepare = electionCommittee2DataSet.getCurrent();
			electionCommitteeDataSet.newRecord(prepare.data);
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				electionCommitteeDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime});
			});
		}
	});
	electionCommitteeDataSet.setParameter("RECORD_ID@=",recordId);
	electionCommitteeDataSet.load();
}
function save(){
	if(document.getElementById("cadreNum").value==""){
		L5.Msg.alert("提示","总人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreFemaleNum").value==""){
		L5.Msg.alert("提示","妇女干部人数不能为空！");
		return false;
	}
	if(document.getElementById("cadrePartyNum").value==""){
		L5.Msg.alert("提示","党员人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreSequenceNum").value==""){
		L5.Msg.alert("提示","连选连任干部数不能为空！");
		return false;
	}
	if(document.getElementById("cadreNewNum").value==""){
		L5.Msg.alert("提示","新当选干部数不能为空！");
		return false;
	}
	if(document.getElementById("cadreThirtyNum").value==""){
		L5.Msg.alert("提示","30岁以下人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreUsixtyNum").value==""){
		L5.Msg.alert("提示","60岁以下人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreSixtyNum").value==""){
		L5.Msg.alert("提示","60岁以上人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreCollegeNum").value==""){
		L5.Msg.alert("提示","大专及以上人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreHightNum").value==""){
		L5.Msg.alert("提示","高中及以下人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreAcrossNum").value==""){
		L5.Msg.alert("提示","两委交叉任职人数不能为空！");
		return false;
	}
	if(document.getElementById("ifSideline").value==""){
		L5.Msg.alert("提示","是否主任书记一人兼不能为空！");
		return false;
	}
	if(document.getElementById("ifDelegate").value==""){
		L5.Msg.alert("提示","是否建立村民小组不能为空！");
		return false;
	}
	if(document.getElementById("ifPublic").value==""){
		L5.Msg.alert("提示","是否建立村务公开小组不能为空！");
		return false;
	}
	if(document.getElementById("ifFinance").value==""){
		L5.Msg.alert("提示","是否建立理财小组不能为空！");
		return false;
	}
	if(document.getElementById("ifUnder").value==""){
		L5.Msg.alert("提示","是否建立下属组织不能为空！");
		return false;
	}
	if(document.getElementById("cadreResideNum").value==""){
		L5.Msg.alert("提示","两委村民人数不能为空！");
		return;
	}
	if(document.getElementById("cadreEconomyNum").value==""){
		L5.Msg.alert("提示","两委经济组织负责人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreUnionNum").value==""){
		L5.Msg.alert("提示","两委产业协会负责人数不能为空！");
		return;
	}
	if(document.getElementById("cadreBackNum").value==""){
		L5.Msg.alert("提示","两委返乡人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreDispatchNum").value==""){
		L5.Msg.alert("提示","两委机关下派人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreGradNum").value==""){
		L5.Msg.alert("提示","两委高校毕业生人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreStudentNum").value==""){
		L5.Msg.alert("提示","两委大学生村官人数不能为空！");
		return false;
	}
	if(document.getElementById("cadreRetireNum").value==""){
		L5.Msg.alert("提示","两委离岗退休人数不能为空！");
		return false;
	}
	var electionCommitteeDataSet=L5.DatasetMgr.lookup("electionCommitteeDataSet");
	var isValidate = electionCommitteeDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = electionCommitteeDataSet.getCurrent();
	if(Number(record.get("cadreFemaleNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","妇女干部人数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadrePartyNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","党员人数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreSequenceNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","连选连任干部数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreNewNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","新当选干部数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreNewNum"))+Number(record.get("cadreSequenceNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","连选连任干部数和新当选干部数总和应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreThirtyNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","30岁以下人数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreUsixtyNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","60岁以下人数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreSixtyNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","60岁以上人数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreThirtyNum"))+Number(record.get("cadreUsixtyNum"))+Number(record.get("cadreSixtyNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","各年龄段组成总和应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreCollegeNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","大专及以上人数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreHightNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","高中及以下人数应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreHightNum"))+Number(record.get("cadreCollegeNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","各文化程度组成总和应小于等于两委总人数！");
		return false;
	}
	
	if(Number(record.get("cadreAcrossNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","两委交叉任职人数应小于等于两委总人数！");
		return false;
	}
	
	
	if(Number(record.get("cadreResideNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：居民人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreEconomyNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：经济组织负责人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreUnionNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：产业协会负责人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreBackNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：返乡人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreDispatchNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：机关下派人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreGradNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：高校毕业生人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreStudentNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：大学生村官人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreRetireNum"))>Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","来源：离岗退休人数 应小于等于两委总人数！");
		return false;
	}
	if(Number(record.get("cadreResideNum"))+Number(record.get("cadreEconomyNum"))+Number(record.get("cadreUnionNum"))+
		Number(record.get("cadreBackNum"))+Number(record.get("cadreDispatchNum"))+Number(record.get("cadreGradNum"))+
		Number(record.get("cadreRetireNum"))+Number(record.get("cadreRetireNum"))> Number(record.get("cadreNum"))){
		L5.Msg.alert("提示","各种来源总和应小于等于两委总人数！");
		return false;
	}
	
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionCommitteeCmd");
	command.setParameter("record",record);
	command.execute("save");
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			electionCommitteeDataSet.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}

function SetGroup(){
	var ifGroup = document.getElementById("ifGroup").value;
	var electionCommitteeDataSet=L5.DatasetMgr.lookup("electionCommitteeDataSet");
	var record = electionCommitteeDataSet.getCurrent();
	if(ifGroup !="1"){
		document.getElementById("headmanNum").disabled = true;
		var electionCommitteeDataSet=L5.DatasetMgr.lookup("electionCommitteeDataSet");
		var record = electionCommitteeDataSet.getCurrent();
		record.set("headmanNum","");
	}else{
		document.getElementById("headmanNum").disabled = false;
	}
}

function setDelegate(){
	var ifDelegate = document.getElementById("ifDelegate").value;
	var electionCommitteeDataSet=L5.DatasetMgr.lookup("electionCommitteeDataSet");
	var record = electionCommitteeDataSet.getCurrent();
	if(ifDelegate !="1"){
		document.getElementById("delegateNum").disabled = true;
		var electionCommitteeDataSet=L5.DatasetMgr.lookup("electionCommitteeDataSet");
		var record = electionCommitteeDataSet.getCurrent();
		record.set("delegateNum","");
	}else{
		document.getElementById("delegateNum").disabled = false;
	}
}
function forInsert(){
	var electionCommittee2DataSet=L5.DatasetMgr.lookup("electionCommittee2DataSet");
	electionCommittee2DataSet.removeAll();
	electionCommittee2DataSet.setParameter("ORGAN_CODE@=", organCode);
	electionCommittee2DataSet.setParameter("sort","CREATE_TIME");	
	electionCommittee2DataSet.setParameter("dir","desc");
	electionCommittee2DataSet.load();
}