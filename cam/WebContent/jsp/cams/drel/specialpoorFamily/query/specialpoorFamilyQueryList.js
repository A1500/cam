var villageCodeString = "";
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function init() {
	query();
	document.getElementById("lrdwmc").value = organName;
	document.getElementById("lrdwId").value = organArea;
}
// 导出
function exportExcel() {
	var ds = L5.DatasetMgr.lookup("speFamilyDataset");
	if (ds.getTotalCount() == 0) {
		L5.Msg.alert("提示", "无可导出数据！");
		return;
	}
	L5.dataset2excel(ds,
					"/jsp/cams/drel/specialpoorFamily/query/specialpoorFamilyQueryListExcel.jsp");
}
// 查询
function query() {
	var lrdwId = document.getElementById("lrdwId").value;
	if ("" == lrdwId) {
		lrdwId = organArea;
	}
	if(lrdwId.substring(2)=="0000000000") {
		lrdwId = lrdwId.substring(0,2);
	}else if(lrdwId.substring(4)=="00000000") {
		lrdwId = lrdwId.substring(0,4);
	}else if(lrdwId.substring(6)=="000000") {
		lrdwId = lrdwId.substring(0,6);
	}else {
		lrdwId = lrdwId.substring(0,9);
	}
	
	
	speFamilyDataset.setParameter("DOMICILE_CODE@rlike", lrdwId);
	speFamilyDataset.setParameter("FAMILY_NAME@like", getParam("qFamilyName"));
	speFamilyDataset.setParameter("FAMILY_CARD_NO@like", getParam("qFamilyCardNo"));
	speFamilyDataset.setParameter("ASSISTANCE_FLAG@like", getParam("qAssistanceFlag"));
	speFamilyDataset.setParameter("FAMILY_PHONE@like", getParam("qFamilyPhone"));
	speFamilyDataset.setParameter("SPECIALPOOR_CAUSE@like", getParam("qSpecialpoorCase"));
	speFamilyDataset.setParameter("ASSISTANCE_TYPE@=", getParam("qAssistanceType"));
	
	
	var qPeopleNumStart = getParam("qPeopleNumStart");
	var qPeopleNumEnd = getParam("qPeopleNumEnd");
	if (_isNum(qPeopleNumStart) && _isNum(qPeopleNumEnd)) {
		speFamilyDataset.setParameter("PEOPLE_NUM@between",
				parseInt(qPeopleNumStart) + "~" + parseInt(qPeopleNumEnd));
	}else if(_isNum(qPeopleNumStart)) {
		speFamilyDataset.setParameter("PEOPLE_NUM@between",
				parseInt(qPeopleNumStart) + "~9999");
	}else if(_isNum(qPeopleNumEnd)) {
		speFamilyDataset.setParameter("PEOPLE_NUM@between","0~" + parseInt(qPeopleNumEnd));
	}
	
	var supportNameID = document.getElementById("supportNameID").value;
	if(supportNameID != '' ){
		SpecialpoorSupportRefDataset.setParameter("support_Unit_Code",supportNameID);
		SpecialpoorSupportRefDataset.load();
		SpecialpoorSupportRefDataset.on("load",findVillage);
	}else{
		speFamilyDataset.load();
	}
	noReclick(speFamilyDataset, "queryId");
}
function findVillage(ds){
	ds.un("load",findVillage);
	villageCodeString = "";
	for (var i = 0 ;i<ds.getCount();i++){
		var record = ds.getAt(i);
		villageCodeString += record.get("helpVillageCode")+",";
	}
	speFamilyDataset.setParameter("help_Village_Code@in",villageCodeString.substring(0,villageCodeString.length-1));
	speFamilyDataset.load();
}
// 选择属地行政区划窗口
function func_ForDomicileSelect() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
							+ organArea + "&organName="
							+ escape(encodeURIComponent(organName)), "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
	}
}



















// 弹出致贫原因选择框
/** 
<input type="text"
	id="qSpecialpoorCaseText" style="width: 90%" readonly="readonly" /><img
	src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
	style="cursor: hand" onclick="getspecialpoorCase(this.id)" /> <input
	type="text" id="qSpecialpoorCaseValue" style="display: none"/>
 */
function getspecialpoorCase(id) {
	var specialpoorCase_win = L5.getCmp("specialpoorCase_win");
	specialpoorCase_win.show();
}
function confirmspecialpoorCase() {
	var grid = L5.getCmp("specialpoorCase_panel");
	var selected = grid.getSelectionModel().getSelections();
	if (selected.length == 0) {
		L5.Msg.alert('提示', "请选择记录!");
		return false;
	}
	var specialpoorCaseText = '';
	var specialpoorCaseValue = '';
	var num = selected.length;
	for (var i = 0; i < num; i++) {
		var text = selected[i].get("text");
		var value = selected[i].get("value");
		if (i == 0) {
			specialpoorCaseText = text;
			specialpoorCaseValue = value;
		} else {
			specialpoorCaseText = specialpoorCaseText + ";" + text;
			specialpoorCaseValue = specialpoorCaseValue + "," + value;
		}
	}
	document.getElementById("qSpecialpoorCaseText").value = specialpoorCaseText;
	document.getElementById("qSpecialpoorCaseValue").value = specialpoorCaseValue;
	closespecialpoorCase();
}
function closespecialpoorCase() {
	var specialpoorCase_win = L5.getCmp("specialpoorCase_win");
	specialpoorCase_win.hide();
}
function clearspecialpoorCase() {
	document.getElementById("qSpecialpoorCaseText").value = '';
	document.getElementById("qSpecialpoorCaseValue").value = '';
	closespecialpoorCase();
}