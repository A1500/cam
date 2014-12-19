var currentOrganCode = orgCode;// 当前机构代码

function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.on("load", function() {
				document.getElementById("reDiv").style.display = "";
				L5.Msg.hide();
			});
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
function getStatisticsTime() {
//	document.getElementById("statisticsTime").innerHTML = formatDate2String(new Date());
}
// 查询
function query() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");

	// 验证当前机构是否为登录机构，关联显示‘返回’按钮
	if (currentOrganCode == orgCode) {
		document.getElementById("backBtn").style.display = "none";
	} else {
		document.getElementById("backBtn").style.display = "";
	}

	getStatisticsTime();
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("qPopulace", currentOrganCode);
	ds.load();
}

// 弹出救助对象属地选择通用帮助
function forHelp(domId) {
	organCode = "rootId";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCity.jsp?radioMaxlevel=0&level=2&organCode="
							+ organCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qPopulace").value = list[0];
		document.getElementById("qPopulaceName").value = list[4];
	}
}

// 查询明细
function forDetail(obj, flag) {
	return;
	var rowIndex = obj.rowIndex - 4;// 索引位置
	var ds = L5.DatasetMgr.lookup("ds");
	var record = ds.getAt(rowIndex);

	var num = record.get(flag);
	if (num > 0) {
		window
				.showModalDialog(
						L5.webPath
								+ "/jsp/cams/fis/query/fisCremationDeadInfoList.jsp?organCode="
								+ record.get("CODE")
								+ "&organName="
								+ escape(encodeURIComponent(record
										.get("FULL_NAME"))) + "&flag=" + flag,
						"",
						"dialogHeight:768px;dialogWidth:1024px;resizable:no;scroll:yes;");
	}
}

// 下钻
function forDown(obj) {
	var rowIndex = obj.rowIndex - 4;// 索引位置
	var ds = L5.DatasetMgr.lookup("ds");
	var record = ds.getAt(rowIndex);
	var name = record.get("NAME"); // 点击的行政区划
	var code = record.get("ID"); // 点击的行政区划
	if (code.substring(2) == "0000000000") {
		// 点击省级
	} else if (code.substring(4) == "00000000") {
		// 点击市级
		if (code == currentOrganCode) {
			// 如果当前显示和点击均为市级，则进入省级统计(对比登录人所属机构代码，是否可进入上级?)
			// alert(orgCode +"="+ code.substring(0,2)+"0000000000"+"="+(orgCode
			// <= code.substring(0,2)+"0000000000"))
			if (orgCode <= code.substring(0, 2) + "0000000000") {
				currentOrganCode = code.substring(0, 2) + "0000000000";
				query();
			}
		} else {
			// 如果当前显示和点击不同，则进入市级统计
			currentOrganCode = code.substring(0, 4) + "00000000";
			query();
		}
	} else if (code.substring(6) == "000000") {
		// 点击县级
		if (code == currentOrganCode) {
			// 如果当前显示和点击均为县级，则进入市级统计(对比登录人所属机构代码，是否可进入上级?)
			if (orgCode <= code.substring(0, 4) + "00000000") {
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
	if (currentOrganCode.substr(2) == "0000000000") {

	} else if (currentOrganCode.substr(4) == "00000000") {
		currentOrganCode = currentOrganCode.substring(0, 2) + "0000000000";
		query();
	} else if (currentOrganCode.substr(6) == "000000") {
		currentOrganCode = currentOrganCode.substring(0, 4) + "00000000";
		query();
	}
}

// 导出Excel
function exportExcel() {
	var ds = L5.DatasetMgr.lookup("ds");
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"] = "0"; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	ds.baseParams["limitExcel"] = total; // 导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var url = L5.webPath
			+ "/jsp/cams/fis/statistics/fisFuneralPeopleStatisticsExcel.jsp";

	L5.dataset2excel(ds, "/jsp/cams/fis/statistics/fisFuneralPeopleStatisticsExcel.jsp");
	ds.baseParams["excelType"] = "reset"; // 重置导出类型
}
