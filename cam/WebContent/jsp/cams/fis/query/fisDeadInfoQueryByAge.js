function init() {

	var fisDeadInfoDS = L5.DatasetMgr.lookup("fisDeadInfoDS");
	fisDeadInfoDS.on("load", meger);

	// 自动填充日期
	var NDate = new Date();
	document.getElementById("cremationTimeEnd").value = NDate;
	NDate.setDate(1);
	var SDate = formatDate2String(NDate);
	document.getElementById("cremationTimeBegin").value = SDate;
}
function formatDate2String(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}
// 查询
function query() {
	var fisDeadInfoDS = L5.DatasetMgr.lookup("fisDeadInfoDS");
	var cremationTimeBegin = document.getElementById("cremationTimeBegin").value;
	var cremationTimeEnd = document.getElementById("cremationTimeEnd").value;
	getStatisticsTime(cremationTimeBegin, cremationTimeEnd);
	if (cremationTimeBegin == "" && cremationTimeEnd == "") {
		// 隐藏div
		document.getElementById("reDiv").style.display = "none";
		L5.Msg.alert('提示', "请填写统计起止日期!");
		return false;
	} else if (cremationTimeBegin != "" && cremationTimeEnd == "") {
		L5.Msg.alert('提示', "请填写统计结束日期!");
		return false;
	} else if (cremationTimeBegin == "" && cremationTimeEnd != "") {
		L5.Msg.alert('提示', "请填写统计开始日期!");
		return false;
	} else if (cremationTimeBegin && cremationTimeEnd) {
		// 时间输入前后大小判断
		if (cremationTimeBegin > cremationTimeEnd) {
			L5.Msg.alert('提示', "开始日期不能大于结束日期!");
			return false;
		}
	}

	fisDeadInfoDS.setParameter("cremationTimeBegin", document
					.getElementById("cremationTimeBegin").value);
	fisDeadInfoDS.setParameter("cremationTimeEnd", document
					.getElementById("cremationTimeEnd").value);
	fisDeadInfoDS.setParameter("applyType", "B");
	fisDeadInfoDS.setParameter("populace", orgCode);
	fisDeadInfoDS.load();
}
function undo() {
	var NDate = new Date();
	document.getElementById("cremationTimeEnd").value = NDate;
	NDate.setDate(1);
	var SDate = formatDate2String(NDate);
	document.getElementById("cremationTimeBegin").value = SDate;
}
function meger() {
	document.getElementById("reDiv").style.display = "";
}
// 统计时间
function getStatisticsTime(startDate, endDate) {
	document.getElementById("statisticsTime").innerHTML = startDate + "至"
			+ endDate;
}
function exportExcel() {
	var cremationTimeBegin = document.getElementById("cremationTimeBegin").value;
	var cremationTimeEnd = document.getElementById("cremationTimeEnd").value;
	var statisticsTime = document.getElementById("statisticsTime").innerHTML = cremationTimeBegin
			+ "至" + cremationTimeEnd;
	var dataset = L5.DatasetMgr.lookup("fisDeadInfoDS");
	if (dataset.getCount() <= 0) {
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	// var total = dataset.getTotalCount();
	dataset.baseParams["excelType"] = '1'; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"] = dataset.getTotalCount();
	// dataset.baseParams["limitExcel"]=total;
	// //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,
			"/jsp/cams/fis/query/fisDeadInfoQueryByAgeExcel.jsp?statisticsTime="
					+ statisticsTime);
	dataset.baseParams["excelType"] = "reset"; // 重置导出类型
}