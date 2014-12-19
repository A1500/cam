function formatDate2String(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}
function meger() {
	document.getElementById("reDiv").style.display = "";
}
function init() {
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	fisFuneralDeadInfoDS.on("load", meger);

	// 自动填充日期
	var NDate = new Date();
	document.getElementById("ECremationTime").value = NDate;
	NDate.setDate(1);
	var SDate = formatDate2String(NDate);
	document.getElementById("SCremationTime").value = SDate;
}
function getStatisticsTime(startDate, endDate) {
	document.getElementById("statisticsTime").innerHTML = startDate + "至"
			+ endDate;
}
// 查询
function query() {
	var SCremationTime = document.getElementById("SCremationTime").value;
	var ECremationTime = document.getElementById("ECremationTime").value;
	if (SCremationTime == undefined || SCremationTime == ''
			|| ECremationTime == undefined || ECremationTime == '') {
		L5.Msg.alert('提示', "请选择火化时间段!");
		return;
	}
	getStatisticsTime(SCremationTime, ECremationTime);
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	fisFuneralDeadInfoDS.setParameter("qPopulace", orgCode);
	fisFuneralDeadInfoDS.setParameter("qStartTime", SCremationTime);
	fisFuneralDeadInfoDS.setParameter("qEndTime", ECremationTime);
	fisFuneralDeadInfoDS.load();
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
							+ "/jsp/cams/fis/query/fisFuneralOrganTree.jsp?radioType=1&rootId=370100000000",
					"",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qOrganId").value = list[0];
		document.getElementById("qOrganName").value = list[1];
	}
}

// 查看火化详情
function forDetail(obj) {
	var rowIndex = obj.rowIndex - 2;// 索引位置
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	var record = fisFuneralDeadInfoDS.getAt(rowIndex);
	var SCremationTime = document.getElementById("SCremationTime").value;
	var ECremationTime = document.getElementById("ECremationTime").value;
	var num = record.get("NUM");
	if (num > 0) {
		window
				.showModalDialog(
						L5.webPath
								+ "/jsp/cams/fis/query/fisCremationDeadInfoList.jsp?unitId="
								+ record.get("UNIT_ID")
								+ "&organName="
								+ escape(encodeURIComponent(record
										.get("UNIT_NAME"))) + "&qStartTime="
								+ SCremationTime + "&qEndTime="
								+ ECremationTime, "",
						"dialogHeight:768px;dialogWidth:1024px;resizable:no;scroll:yes;");
	}
}

// 查看馆明细
function forUnitDetail(obj) {
	var rowIndex = obj.rowIndex - 2;// 索引位置
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	var record = fisFuneralDeadInfoDS.getAt(rowIndex);
	var unitName = record.get("UNIT_NAME");
	// var revalue = window.showModalDialog(
	// L5.webPath +
	// "/jsp/cams/fis/import/fisFuneralDeadInfoList.jsp?method=QUERY_WIN&organId="+organId+"&unitName="+unitName+"&qPopulace="+qPopulace+"&qQreferentialTypeName"+qQreferentialTypeName+"&SCremationTime="+SCremationTime+"&ECremationTime="+ECremationTime+"&qPopulaceName="+qPopulaceName,
	// "","dialogHeight:768px;dialogWidth:1024px;resizable:no;scroll:yes;");
}

function exportExcel() {
	var ds = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	var cremationTimeBegin = document.getElementById("SCremationTime").value;
	var cremationTimeEnd = document.getElementById("ECremationTime").value;
	var statisticsTime = document.getElementById("statisticsTime").innerHTML = cremationTimeBegin
			+ "至" + cremationTimeEnd;
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"] = "1"; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	ds.baseParams["limitExcel"] = total; // 导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds,
			"/jsp/cams/fis/query/fisFuneralDeadInfoQueryExcel.jsp?statisticsTime="
					+ statisticsTime);
	ds.baseParams["excelType"] = "reset"; // 重置导出类型

}
