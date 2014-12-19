function init() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	//已上报退役士兵信息
	retiredSoldierDataset.baseParams["FLAG@="]=2;
	retiredSoldierDataset.load();
	var grid=L5.getCmp('editGridPanel');
	//给grid增加双击侦听事件。
	grid.on("rowdblclick",detail);
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.setParameter("NAME@like",getParam("name"));
	retiredSoldierDataset.setParameter("IDCARD_NO@like",getParam("idCard"));
	retiredSoldierDataset.setParameter("HUKOU_TYPE@=",getParam("domicileType"));
	retiredSoldierDataset.setParameter("VETERANS_CERTIFICATE_NO@like",getParam("veteransCertificateNo"));
	retiredSoldierDataset.setParameter("SERVED_ARMY@like",getParam("servedArmy"));
	retiredSoldierDataset.setParameter("ENLIST_TYPE@=",getParam("enlistType"));
	retiredSoldierDataset.setParameter("SERVICED_TIME@=",getParam("servicedTime"));
	retiredSoldierDataset.setParameter("CONTENT@like",getParam("note"));
	retiredSoldierDataset.setParameter("WHERE_PLACEMEN@=",getParam("domicileCode"));
	retiredSoldierDataset.load();
}

//查看某条已上报退役士兵基本信息
function detail(){
	
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	data.put("idField",selected[0].get('soldiersId'));

	var url='jsp/cams/prs/approval/prsretiredsoldiers_detail.jsp';
	var text = '查看已上报退役士兵信息';
	L5.forward(url,text,data);
}

//查询安置机构
function forHelp() {
	// var struId='<%=struId%>';
	var revalue = window
			.showModalDialog(
					"../../../bsp/organization/getselect_code.jsp?rootId="
							+ struId
							+ "&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1",
					"",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
function func_ForDomicileSelect() {
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
