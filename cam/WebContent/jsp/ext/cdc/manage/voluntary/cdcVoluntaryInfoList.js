var qOrganCode;
function init(){
	//权限过滤
	document.getElementById("btnAdd").style.display = 'none';
	document.getElementById("btnEdit").style.display = 'none';
	document.getElementById("btnDel").style.display = 'none';
	if(organLevel=="SQ") {
		//如果是村居级，则启用按钮
		document.getElementById("btnAdd").style.display = '';
		document.getElementById("btnEdit").style.display = '';
		document.getElementById("btnDel").style.display = '';
	}
	var cdcVoluntaryInfoDataSet=L5.DatasetMgr.lookup("cdcVoluntaryInfoDataSet");
	if(organLevel=="SQ") {
		//村居级
		qOrganCode = organCode;
	}else if(organLevel=="JD") {
		//乡镇街道级
		qOrganCode = organCode.substring(0,9);
	}else if(organLevel=="11"){
		qOrganCode = organCode.substring(0,2);
	}else if(organCode.substr("4")=="00000000") {
		//市
		qOrganCode = organCode.substring(0,4);
	}else if(organCode.substr("6")=="000000") {
		//区县
		qOrganCode = organCode.substring(0,6);
	}
	cdcVoluntaryInfoDataSet.setParameter("ORGAN_CODE@rlike", qOrganCode);
	cdcVoluntaryInfoDataSet.load();
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query(){
	var cdcVoluntaryInfoDataSet=L5.DatasetMgr.lookup("cdcVoluntaryInfoDataSet");
	cdcVoluntaryInfoDataSet.setParameter("ORGAN_CODE@rlike", qOrganCode);
	cdcVoluntaryInfoDataSet.setParameter("NAME@rlike", getParam("qName"));
	cdcVoluntaryInfoDataSet.setParameter("ID_CARD@rlike", getParam("qIdCard"));
	cdcVoluntaryInfoDataSet.setParameter("SEX", getParam("qSex"));
	cdcVoluntaryInfoDataSet.setParameter("EDU_CODE", getParam("qEduCode"));
	cdcVoluntaryInfoDataSet.setParameter("POLITICAL_CODE", getParam("qPoliticalCode"));
	cdcVoluntaryInfoDataSet.setParameter("TEL@rlike", getParam("qTel"));
	cdcVoluntaryInfoDataSet.setParameter("EMAIL@rlike", getParam("qEmail"));
	cdcVoluntaryInfoDataSet.setParameter("ADDRESS@rlike", getParam("qAddress"));
	cdcVoluntaryInfoDataSet.load();
}
function insert(){
	var	url = "cdcVoluntaryInfoEdit.jsp?method=INSERT";
	var width = 700;
	var height = 315;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
	if(true || returnValue) {
		query();
	}
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}

	var	url = "cdcVoluntaryInfoEdit.jsp?method=UPDATE&voluntaryId="+records[0].get("voluntaryId");
	var width = 700;
	var height = 380;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
	if(true || returnValue) {
		query();
	}
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	
	var	url = "cdcVoluntaryInfoDetail.jsp?voluntaryId="+records[0].get("voluntaryId");
	var width = 700;
	var height = 380;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("caperTimes")>0) {
		L5.Msg.alert("提示","该志愿者已参与活动，不能删除!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该志愿者？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcVoluntaryInfoCmd");
			command.setParameter("voluntaryId",records[0].get("voluntaryId"));
			command.execute("delete");
			if (!command.error){
				query();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}