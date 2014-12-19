var queryCondition = "";
function init() {
	// var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	// fisFuneralDeadInfoDS.load();
	// 下转过来的
	if (method == 'QUERY_WIN') {
		document.getElementById("qOrganId").value = organId;
		document.getElementById("qOrganName").value = unitName;
		document.getElementById("qPopulace").value = qPopulace;
		document.getElementById("qPopulaceName").value = qPopulaceName;
		document.getElementById("qQreferentialTypeName").value = qQreferentialTypeName;
		document.getElementById("SCremationTime").value = SCremationTime;
		document.getElementById("ECremationTime").value = ECremationTime;
		query();
	} else {
		// query();
	}
	if(orgCode.substr(0,4)!="3700"&&orgCode.substr(0,4)!="3701"){
		L5.getCmp("exportShow").hide();
	}
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	fisFuneralDeadInfoDS.on('load', function() {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (fisFuneralDeadInfoDS.getTotalCount() == 0) {
					qrToolbar.setText("逝者火化信息查询");
				} else {
					qrToolbar.setText("逝者火化信息查询("
							+ fisFuneralDeadInfoDS.getTotalCount() + "条)");
				}
			});
}
// 查询
function query() {
	queryCondition="";
	var qPopulace = document.getElementById("qPopulace").value;
	var qName = document.getElementById("qName").value;
	var qIdCard = document.getElementById("qIdCard").value;
	var qOrganId = document.getElementById("qOrganId").value;
	var qQreferentialTypeName = document.getElementById("qQreferentialTypeName").value;
	var qAgeBegin = document.getElementById("qAgeBegin").value;
	var qAgeEnd = document.getElementById("qAgeEnd").value;
	var qDeathCaseValue = document.getElementById("qDeathCaseValue").value;
	var SRecieveTime = document.getElementById("SRecieveTime").value;
	var ERecieveTime = document.getElementById("ERecieveTime").value;
	var SCremationTime = document.getElementById("SCremationTime").value;
	var ECremationTime = document.getElementById("ECremationTime").value;
	var qFisAshesGo = document.getElementById("qFisAshesGo").value;

	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	if (qPopulace != "") {
		fisFuneralDeadInfoDS.setParameter("populace", qPopulace);
		queryCondition +=document.getElementById("qPopulaceName").value+",";
	}
	if (qName != "") {
		fisFuneralDeadInfoDS.setParameter("name", qName);
		queryCondition +=qName+",";
	}
	if (qIdCard != "") {
		fisFuneralDeadInfoDS.setParameter("idCard", qIdCard);
		queryCondition +=qIdCard+",";
	}
	if (qOrganId != "") {
		fisFuneralDeadInfoDS.setParameter("organId", qOrganId);
		queryCondition +=document.getElementById("qOrganName").value+",";
	}
	if (qQreferentialTypeName != "") {
		// var
		// qreferentialTypeNameObj=document.getElementById("qQreferentialTypeName");
		// var
		// qQreferentialType=qreferentialTypeNameObj.options[qreferentialTypeNameObj.selectedIndex].text;
		// fisFuneralDeadInfoDS.setParameter("qreferentialTypeName",qQreferentialType);
		fisFuneralDeadInfoDS.setParameter("qreferentialTypeName",
				qQreferentialTypeName);
		queryCondition +=qQreferentialTypeName+",";
	}
	if (qAgeBegin != "") {
		fisFuneralDeadInfoDS.setParameter("ageBegin", qAgeBegin);
		queryCondition +=qAgeBegin+",";
	}
	if (qAgeEnd != "") {
		fisFuneralDeadInfoDS.setParameter("ageEnd", qAgeEnd);
		queryCondition +=qAgeEnd+",";
	}
	if (qDeathCaseValue != "") {
		fisFuneralDeadInfoDS.setParameter("deathCaseValue", qDeathCaseValue);
		queryCondition +=qDeathCaseValue+",";
	}
	if (SRecieveTime != "") {
		fisFuneralDeadInfoDS.setParameter("SRecieveTime", SRecieveTime);
		queryCondition +=SRecieveTime+",";
	}
	if (ERecieveTime != "") {
		fisFuneralDeadInfoDS.setParameter("ERecieveTime", ERecieveTime);
		queryCondition +=ERecieveTime+",";
	}
	if (SCremationTime != "") {
		fisFuneralDeadInfoDS.setParameter("SCremationTime", SCremationTime);
		queryCondition +=SCremationTime+",";
	}
	if (ECremationTime != "") {
		fisFuneralDeadInfoDS.setParameter("ECremationTime", ECremationTime);
		queryCondition +=ECremationTime+",";
	}
	if (qFisAshesGo != "") {
		fisFuneralDeadInfoDS.setParameter("fisAshesGo", qFisAshesGo);
		queryCondition +=qFisAshesGo+",";
	}
	
	//数据权限
	var manaPrexx = "BZ";
	if (orgCode.substring(2) == "0000000000") {
		fisFuneralDeadInfoDS.setParameter("organCode", manaPrexx+orgCode.substring(0, 2));
	} else if (orgCode.substring(4) == "00000000") {
		fisFuneralDeadInfoDS.setParameter("organCode", manaPrexx+orgCode.substring(0, 4));
	} else {
		fisFuneralDeadInfoDS.setParameter("organCode", manaPrexx+orgCode.substring(0, 6));
	}
	
	fisFuneralDeadInfoDS.setParameter("ifFinish", "1");
	fisFuneralDeadInfoDS.load();
}
// 详情
function deadInfo_detail() {
	var grid = L5.getCmp("editDeadPanel");
	var selected = grid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var deadId = selected[0].get("DEAD_ID");
	var fisFuneralDeadInfoDS2 = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS2");
	fisFuneralDeadInfoDS2.setParameter("deadId", deadId);
	fisFuneralDeadInfoDS2.load();
	var deathDetailWin = L5.getCmp("deathDetailWin");
	deathDetailWin.show();
}
function close_DeadInfo() {
	var deathDetailWin = L5.getCmp("deathDetailWin");
	deathDetailWin.hide();
}

// 弹出救助对象属地选择通用帮助
function forHelp(domId) {
	organCode = "rootId";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCity.jsp?radioMaxlevel=0&level=4&organCode="
							+ organCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qPopulace").value = list[0];
		document.getElementById("qPopulaceName").value = list[4];
	}
}
// 查询殡仪馆
function forOrganHelp(domId) {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/query/fisFuneralOrganTree.jsp?radioType=1&rootId="
							+ orgCode, "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qOrganId").value = list[0];
		document.getElementById("qOrganName").value = list[1];
	}
} 
// 死亡原因
function getDeathCase(id) {
	var deathCase_win = L5.getCmp("deathCase_win");
	deathCase_win.show();
}

function confirmDeathCase() {
	var grid = L5.getCmp("deathCase_panel");
	var selected = grid.getSelectionModel().getSelections();
	if (selected.length == 0) {
		L5.Msg.alert('提示', "请选择记录!");
		return false;
	}
	var deathCaseText = '';
	var deathCaseValue = '';
	var num = selected.length;
	for (var i = 0; i < num; i++) {
		var text = selected[i].get("text");
		var value = selected[i].get("value");
		if (i == 0) {
			deathCaseText = text;
			deathCaseValue = value;
		} else {
			deathCaseText = deathCaseText + ";" + text;
			deathCaseValue = deathCaseValue + "," + value;
		}

	}
	document.getElementById("qDeathCaseText").value = deathCaseText;
	document.getElementById("qDeathCaseValue").value = deathCaseValue;
	closeDeathCase();
}
function closeDeathCase() {
	var deathCase_win = L5.getCmp("deathCase_win");
	deathCase_win.hide();
}
function clearDeathCase() {
	document.getElementById("qDeathCaseText").value = '';
	document.getElementById("qDeathCaseValue").value = '';
	closeDeathCase();
}
function exportCremation(){
	if(orgCode.substr(0,4)!="3700"&&orgCode.substr(0,4)!="3701"){
		return;
	}
	var dataset=L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/cams/fis/query/fisFuneralDeadInfoExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型s
	var ds = L5.DatasetMgr.lookup("ds");
	ds.newRecord({
		"recordId" : recordId,
		"exportOrgan" : orgCode,
		"exportOrganName" : orgName,
		"exportNum" : dataset.getTotalCount(),
		"exportName" : userName,
		"exportDate" : date,
		"exportCondition" : queryCondition
	});
	var record = ds.getCurrent();
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCremationExportBackupCmd");
	command.setParameter("record",record);
	command.execute("insert");
}
function exportShow(){
	var url = "fisCremationExportBackupList.jsp?orgCode="+orgCode;
	window.showModalDialog(url,"","dialogHeight:300px;dialogWidth:600px;resizable:yes;scroll:yes;status:no;");
}
