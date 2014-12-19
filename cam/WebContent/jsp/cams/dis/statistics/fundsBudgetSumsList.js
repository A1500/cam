var currentOrganCode = organCode;// 当前机构代码
var disYear; // 查询条件-年度

function init() {
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	disFundsSourceDs.on("load", function() {
				document.getElementById("reDiv").style.display = "";
				L5.Msg.hide();
			});

	// 自动填充disYear
	var date = L5.server.getSysDate();
	disYear = date.getYear() + "";
}

// 格式化日期
function formatDate2String(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}

// 设置表样右上的统计时间
function getStatisticsTime(disYear) {
	document.getElementById("statisticsTime").innerHTML = disYear + "年度";
}
// 查询
function query() {
/*	L5.Msg.alert('提示', "正在研发，请等待!");
	return false;
*/	
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");

	var qDisYear = document.getElementById("qDisYear").value;
	if (qDisYear == undefined || qDisYear == '') {
		L5.Msg.alert('提示', "请输入年度!");
		return;
	}


	// 缓存查询年度
	disYear = qDisYear;
	getStatisticsTime(disYear);
	
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	disFundsSourceDs.setParameter("qOrganCode", currentOrganCode);
	disFundsSourceDs.setParameter("qDisYear", disYear);
	disFundsSourceDs.load();
}

// 导出Excel
/*function exportExcel() {
	return;
	var cremationTimeBegin = document.getElementById("SCremationTime").value;
	var cremationTimeEnd = document.getElementById("ECremationTime").value;
	var statisticsTime = document.getElementById("statisticsTime").innerHTML = cremationTimeBegin
			+ "至" + cremationTimeEnd;
	var ds = L5.DatasetMgr.lookup("disFundsSourceDs");
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"] = "0"; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	ds.baseParams["limitExcel"] = total; // 导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var url = L5.webPath
			+ "/jsp/cams/fis/statistics/fisFuneralCreStatisticsExcel.jsp?statisticsTime="
			+ statisticsTime;
	
	L5.dataset2excel(dataset, "/jsp/cams/dis/statistics/fundsBudgetSumsListExcel.jsp");
	ds.baseParams["excelType"] = "reset"; // 重置导出类型
}*/


function exportexcel() {
	var dataset=L5.DatasetMgr.lookup("disFundsSourceDs");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/statistics/fundsBudgetSumsListExcel.jsp");
}


// 下钻
function forDown(obj) {
	var rowIndex = obj.rowIndex - 2;// 索引位置
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var record = disFundsSourceDs.getAt(rowIndex);
	var name = record.get("NAME"); // 点击的行政区划
	var code = record.get("ID"); // 点击的行政区划
	
//	alert(currentOrganCode+"-"+code+"-"+orgAreaCode)
	if (code == "000000000000") {
		// 点击市级
		currentOrganCode = organCode;
		query();
	}else if (code.substring(4) == "00000000") {
		// 点击市级
		if (code == currentOrganCode) {
			if (orgAreaCode == code) {
				currentOrganCode = organCode;
				query();
			}
		} else {
			// 如果当前显示和点击不同，则进入市级统计
			currentOrganCode = code.substring(0, 4) + "00000000";
			query();
		}
	}else if (code.substring(6) == "000000") {
		// 如果当前显示和点击不同，则进入县级统计
		if (code == currentOrganCode) {
			// 如果当前显示和点击均为县级，则进入市级统计(对比登录人所属机构代码，是否可进入上级?)
			if(orgAreaCode==code) {
				currentOrganCode = organCode;
				query();
			}else if (orgAreaCode <= code.substring(0, 4) + "00000000") {
				currentOrganCode = code.substring(0, 4) + "00000000";
				query();
			}
		} else {
			// 如果当前显示和点击不同，则进入县级统计
			currentOrganCode = code.substring(0, 6) + "000000";
			query();
		}
	}
}

// 手工返回
function back() {
//	alert(currentOrganCode+"-"+orgAreaCode)
	if (currentOrganCode.substring(0,2) == "BZ") {

	} else if(currentOrganCode == orgAreaCode) {
		currentOrganCode = organCode;
		query();
	}else if (currentOrganCode.substr(4) == "00000000") {
		currentOrganCode = organCode;
		query();
	} else if (currentOrganCode.substr(6) == "000000") {
		currentOrganCode = currentOrganCode.substring(0, 4) + "00000000";
		query();
	}
}
/*
// 查询明细
function forDetail(obj, flag) {
	var rowIndex = obj.rowIndex - 4;// 索引位置
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	var record = fisFuneralDeadInfoDS.getAt(rowIndex);

	var num = record.get(flag);
	if (num > 0) {
		window
				.showModalDialog(
						L5.webPath
								+ "/jsp/cams/fis/query/fisCremationDeadInfoList.jsp?organCode="
								+ record.get("CODE")
								+ "&organName="
								+ escape(encodeURIComponent(record
										.get("FULL_NAME"))) + "&flag=" + flag
								+ "&qStartTime=" + sTime + "&qEndTime=" + eTime,
						"",
						"dialogHeight:768px;dialogWidth:1024px;resizable:no;scroll:yes;");
	}
}





*/