function init(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	if(method=="INSERT"){
		cdcPeopleInfoDataSet.newRecord({"ifCommittee":"1","organCode":organCode});
	}else{
		cdcPeopleInfoDataSet.setParameter("PEOPLE_ID@=",peopleId);
		cdcPeopleInfoDataSet.load();
	}
}
function save(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	var valid=cdcPeopleInfoDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=cdcPeopleInfoDataSet.getCurrent();
	if(record.get("name")==''){
		L5.Msg.alert("提示","姓名不能为空！");
		return false;
	}
	if(record.get("season")==''){
		L5.Msg.alert("提示","任职届次不能为空！");
		return false;
	}
	if(record.get("idCard")==''){
		L5.Msg.alert("提示","身份证号不能为空！");
		return false;
	}
	if(!backBirthDay(record.get("idCard"))){
		L5.Msg.alert("提示","身份证号不正确！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPeopleInfoCmd");
	command.setParameter("record",record);
	if(method=="INSERT"){
		command.execute("insert");
	}else if(method=="UPDATE"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function ifUnderlingChanges(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	var record=cdcPeopleInfoDataSet.getCurrent();
	var value = document.getElementById("ifCommitteeUnderling").value;
	if(value == '0'){
		var s = document.getElementById("jobType");
		s.disabled=true
		record.set("jobType","");
	}else if(value == '1'){
		document.getElementById("jobType").disabled = false;
	}

}

function ifWorkerChanges(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	var record=cdcPeopleInfoDataSet.getCurrent();
	var value = document.getElementById("ifCommunityWorker").value;
	if(value == '0'){
		document.getElementById("specialSkill").disabled=true;
		record.set("specialSkill","");
		document.getElementById("communityWorkerType").disabled=true;
		record.set("communityWorkerType","");
	}else if(value == '1'){
		document.getElementById("specialSkill").disabled = false;
		document.getElementById("communityWorkerType").disabled=false;
	}

}

// 根据身份证号回填逝者生日、性别
function backBirthDay(value) {
	if(value) {
		var idCard = checkIdCard(value);
		if (idCard) {
			//双更新
			var cdcVoluntaryInfoDataSet = L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
			cdcVoluntaryInfoDataSet.getCurrent().set("birthday", getBirthByCode(idCard));
			cdcVoluntaryInfoDataSet.getCurrent().set("sex", getSexByCode(idCard));
			
			document.getElementById("birthday").value = getBirthByCode(idCard);
			document.getElementById("sex").value = getSexByCode(idCard);
			return true;
		} else {
			L5.Msg.alert('提示', '身份证件号不符合规则，请检查!');
			return false;
		}
	}
}

function returnBack(){
	history.go(-1);
}