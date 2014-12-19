var qOrganCode;
function init() {
	//权限过滤
	if(organLevel=="SQ") {
		//村居级
		qOrganCode = organCode;
	}else if(organLevel=="JD") {
		//乡镇街道级
		qOrganCode = organCode.substring(0,9);
	}else if(organLevel=="13") {
		//区县
		qOrganCode = organCode.substring(0,6);
	}else if(organLevel=="12") {
		//市
		qOrganCode = organCode.substring(0,4);
	}else if(organLevel=="11"){
		qOrganCode = organCode.substring(0,2);
	}
	
	if (method == 'null')
		method = 'INSERT';
	if (method == 'INSERT') {
		cdcCaperInfoDataSet.newRecord({"organName":organName,"organCode":organCode});
	} else if (method == 'UPDATE') {
		cdcCaperInfoDataSet.setParameter("CAPER_ID", caperId);
		cdcCaperInfoDataSet.load();
		cdcVoluntaryInfoDataSet.setParameter("caperId", caperId);
		cdcVoluntaryInfoDataSet.load();
	}
}
// 保存
function saveBack() {
	document.getElementById("address").focus();	//转焦点
	var valid = cdcCaperInfoDataSet.isValidate();
	if (valid != true) {
		L5.Msg.alert('提示', "校验未通过:" + valid);
		return false;
	}
	var sTime = getParam("startTime");
	var eTime = getParam("endTime");
	if(sTime>eTime) {
		L5.Msg.alert('提示', "活动开始时间应小于活动结束时间!");
		return false;
	}
	
	var valid2 = cdcVoluntaryInfoDataSet.isValidate();
	if (valid2 != true) {
		L5.Msg.alert('提示', "校验未通过:" + valid2);
		return false;
	}
	for(var i=0;i<cdcVoluntaryInfoDataSet.getCount();i++) {
		var rec = cdcVoluntaryInfoDataSet.getAt(i);
		if(rec.get("startTime")<sTime) {
			L5.Msg.alert('提示', "第"+(i+1)+"个志愿者("+rec.get("name")+")活动开始时间小于本次活动开始时间!");
			return false;
		}
		if(rec.get("endTime")>eTime) {
			L5.Msg.alert('提示', "第"+(i+1)+"个志愿者("+rec.get("name")+")活动结束时间大于本次活动结束时间!");
			return false;
		}
		rec.set("totalTimes", getTimePoorMin(rec.get("startTime"),rec.get("endTime")));
	}
	
	if(cdcVoluntaryInfoDataSet.getCount()<=0) {
		L5.Msg.alert('提示', "请选择志愿者!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.cdc.base.cmd.CdcCaperInfoCmd");
	command.setParameter("cdcCaperInfo", cdcCaperInfoDataSet.getCurrent());
	command.setParameter("cdcVoluntaryInfos", cdcVoluntaryInfoDataSet.getAllRecords());
	if (method == "INSERT") {
		command.execute("insert");
	} else if (method == "UPDATE") {
		command.execute("update");
	}
	if (!command.error) {
		cdcCaperInfoDataSet.commitChanges();
		L5.Msg.alert('提示', "保存成功!", function() {
					back();
				});
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
// 返回
function back() {
	window.close();
	window.returnValue = 'T';
}
//弹出选择
function addSel(){
	var addSelWin = L5.getCmp("addSelWin");
	addSelWin.show();
}
//移除选择
function removeSel() {
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	for(var i=0;i<records.length;i++) {
		cdcVoluntaryInfoDataSet.remove(records[i]);
	}
	updateSums();
}
//弹出
function closeWin(){
	var addSelWin = L5.getCmp("addSelWin");
	addSelWin.hide();
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
//查询
function query() {
	var cdcVoluntaryInfoDataSetQuery=L5.DatasetMgr.lookup("cdcVoluntaryInfoDataSetQuery");
	cdcVoluntaryInfoDataSetQuery.setParameter("ORGAN_CODE@rlike", qOrganCode);
	cdcVoluntaryInfoDataSetQuery.setParameter("NAME@rlike", getParam("qName"));
	cdcVoluntaryInfoDataSetQuery.setParameter("ID_CARD@rlike", getParam("qIdCard"));
	cdcVoluntaryInfoDataSetQuery.setParameter("SEX", getParam("qSex"));
	cdcVoluntaryInfoDataSetQuery.setParameter("EDU_CODE", getParam("qEduCode"));
	cdcVoluntaryInfoDataSetQuery.setParameter("POLITICAL_CODE", getParam("qPoliticalCode"));
	cdcVoluntaryInfoDataSetQuery.setParameter("TEL@rlike", getParam("qTel"));
	cdcVoluntaryInfoDataSetQuery.setParameter("EMAIL@rlike", getParam("qEmail"));
	cdcVoluntaryInfoDataSetQuery.setParameter("ADDRESS@rlike", getParam("qAddress"));
	cdcVoluntaryInfoDataSetQuery.load();
}
//选择回填
function addAgain(){
	var selectedGrid=L5.getCmp("selectedGrid");
	var records=selectedGrid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var pos=-1;
	for(var i=0;i<records.length;i++) {
		pos = cdcVoluntaryInfoDataSet.find("voluntaryId",records[i].get("voluntaryId"),0);
		if(pos==-1) {
			records[i].set("startTime",getParam("startTime"));
			records[i].set("endTime",getParam("endTime"));
			cdcVoluntaryInfoDataSet.add([records[i]]);
		}
	}
	updateSums();
}
//更新总人数
function updateSums() {
	cdcCaperInfoDataSet.getCurrent().set("caperNums", cdcVoluntaryInfoDataSet.getCount());
	document.getElementById("caperNums").innerHTML = cdcVoluntaryInfoDataSet.getCount();
}