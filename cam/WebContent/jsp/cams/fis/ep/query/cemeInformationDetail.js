function init() {
	L5.QuickTips.init();
	var userInfo = initArea();
	document.getElementById("manaLevelId").value = userInfo.cantCode;
	document.getElementById("manaLevel").value = userInfo.cantName;
	ds.on("load", function onDsLoad() {
				if (ds.getTotalCount() == 0) {
					L5.Msg.alert("提示", "无符合条件的结果！");
					var qrToolbar = L5.getCmp("qrToolbar");
					qrToolbar.setText("查询结果(0条): ");
				} else {
					var qrToolbar = L5.getCmp("qrToolbar");
					qrToolbar.setText("查询结果(" + ds.getTotalCount() + "条): ");
			}
			});
	query();
};

function resetQuery() {
	var userInfo = initArea();
	document.getElementById("manaLevelId").value = userInfo.cantCode;
	document.getElementById("manaLevel").value = userInfo.cantName;
	document.getElementById("organId").value = "";
	document.getElementById("name").value = "";
	document.getElementById("legalPeople").value = "";
	document.getElementById("prop").value = "";
	document.getElementById("organizer").value = "";
	document.getElementById("gestionTime").value = "";
	document.getElementById("address").value = "";
}

//获取下拉选框的值	
function getSelected(elementId){
	var ddl = document.getElementById(elementId);
	var index = ddl.selectedIndex;
	var value = ddl.options[index].value;
	return value;
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	ds.setParameter("ORGAN_ID@=", getParam("organId"));
	ds.setParameter("NAME@=", getParam("name"));
	ds.setParameter("LEGAL_PEOPLE@=", getParam("legalPeople"));
	ds.setParameter("PROP@=", getParam("prop"));
	ds.setParameter("ORGANIZER@=", getParam("organizer"));
	ds.setParameter("GESTION_TIME@=", getParam("gestionTime"));
	ds.setParameter("ADDRESS@=", getParam("address"));
	ds.setParameter("MANA_LEVEL_ID@=", undefined);
	ds.setParameter("MANA_LEVEL_ID@rlike", undefined);	
	var manaLevelId = getParam("manaLevelId");
	if (manaLevelId.substring(2) == "0000000000") {
		// 省局
	} else if (manaLevelId.substring(4) == "00000000") {
		// 市局
		ds.setParameter("MANA_LEVEL_ID@rlike", manaLevelId.substring(0, 4));
	} else {
		// 县局
		ds.setParameter("MANA_LEVEL_ID@=", manaLevelId);
	}
	
	ds.on("load", function onDsLoad() {
				if (ds.getTotalCount() == 0) {
					L5.Msg.alert("提示", "无符合条件的结果！");
					var qrToolbar = L5.getCmp("qrToolbar");
					qrToolbar.setText("查询结果(0条): ");
				} else {
					var qrToolbar = L5.getCmp("qrToolbar");
					qrToolbar.setText("查询结果(" + ds.getTotalCount() + "条): ");
				}
			});
	ds.load();
}

function showDetailsRendener(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:showDetails(\'' + record.data["organId"]
			+ '\',\'' + record.data["prop"] + '\')">' + value + '</a>';
}

function showDetails(organId, prop) {
	var url = "../../base/funeralOrganImportDetail.jsp?method=detail&unitId=" + organId+"&prop="+prop;
	window.showModalDialog(url, window,
				"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}

function detail() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	showDetails(selected[0].get('organId'), selected[0].get('prop'));
}
function insertNoprofitCeme() {
	url=L5.webPath+'/jsp/cams/fis/ep/collection/cemePublicfitInfomationEdit.jsp?method=insert';
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:708px;dialogHeight:480px;resizable:1");
	init();
}
function update(){
	var editGridPanel = L5.getCmp("editGridPanel");
	var selectedRecord = editGridPanel.getSelectionModel().getSelected();
	if (!selectedRecord) {
		L5.Msg.alert("提示", "请先选择一条记录");
		return false;
	}
	var method = 'update';
	var organId = selectedRecord.get("organId");
	var prop = selectedRecord.get("prop");
	if(prop!='1'){
		L5.Msg.alert("提示", "非公益性公墓不可修改！");
		return false;
	}
	url=L5.webPath+'/jsp/cams/fis/ep/collection/cemePublicfitInfomationEdit.jsp?method=update&organId='+organId;
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:708px;dialogHeight:480px;resizable:1");
	init();
}