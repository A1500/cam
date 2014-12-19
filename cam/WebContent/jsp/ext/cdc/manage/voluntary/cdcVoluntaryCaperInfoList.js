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
	var cdcCaperInfoDataSet=L5.DatasetMgr.lookup("cdcCaperInfoDataSet");
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
	cdcCaperInfoDataSet.setParameter("ORGAN_CODE@rlike", qOrganCode);
	cdcCaperInfoDataSet.load();
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query(){
	var cdcCaperInfoDataSet=L5.DatasetMgr.lookup("cdcCaperInfoDataSet");
	cdcCaperInfoDataSet.setParameter("ORGAN_CODE@rlike", qOrganCode);
	cdcCaperInfoDataSet.setParameter("ADDRESS@rlike", getParam("qAddress"));
	cdcCaperInfoDataSet.setParameter("CONTENT@rlike", getParam("qContent"));
	cdcCaperInfoDataSet.setParameter("ENTREPRENEUR@rlike", getParam("qEntrepreneur"));
	cdcCaperInfoDataSet.load();
}
function insert(){
	var	url = "cdcVoluntaryCaperInfoEdit.jsp?method=INSERT";
	var width = 1024;
	var height = 768;
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
	
	var	url = "cdcVoluntaryCaperInfoEdit.jsp?method=UPDATE&caperId="+records[0].get("caperId");
	var width = 1024;
	var height = 768;
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
	
	var	url = "cdcVoluntaryCaperInfoDetail.jsp?method=UPDATE&caperId="+records[0].get("caperId");
	var width = 1024;
	var height = 768;
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
	L5.MessageBox.confirm("提示", "是否删除该活动？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcCaperInfoCmd");
			command.setParameter("caperId",records[0].get("caperId"));
			command.execute("deleteCaper");
			if (!command.error){
				query();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}