var method = "insert";

function init() {
	document.getElementById("areaName").innerText = orgName;
	document.getElementById("check").style.display = "none";
	// var date = L5.server.getSysDate();
	// var year = date.getYear()-1;
	var isCounty = '';
	var organCodeTemp = '';
	if (orgCode.substring(2) == "0000000000") {
		isCounty = '0';
		organCodeTemp = orgCode.substring(0, 2);

	} else if (orgCode.substring(4) == "00000000") {
		isCounty = '0';
		organCodeTemp = orgCode.substring(0, 4);
	} else if ((orgCode.substring(6) == "000000")) {
		isCounty = '1';
	}
	if (isCounty == '1') {
		L5.getCmp("noCountyPanel").setVisible(false);
		L5.getCmp("countyPanel").setVisible(true);

		orgName = orgName.replace(/民政局/g, "");
		// 县级单位
		ds.newRecord({
					"areaCode" : orgCode,
					"areaName" : orgName
				});

		cremationNumDs.setParameter("ORGAN_CODE", orgCode);
		cremationNumDs.on('load', function() {
					if (cremationNumDs.getCount() > 0) {
						ds.getCurrent().set("cremationNum",
								cremationNumDs.getAt(0).get("SUM"));
					}
				});
	} else if (isCounty == '0') {
		// 省市级单位
		L5.getCmp("countyPanel").setVisible(false);
		L5.getCmp("noCountyPanel").setVisible(true);
	}
}

function query() {
	var qYear = getParam("qYear");
	if (qYear == undefined) {
		L5.Msg.alert("提示", "请输入统计年度！");
		return;
	}

	rateDs.setParameter("SUM_YEAR", qYear);

	if (orgCode.substring(2) == "0000000000") {
		rateDs.setParameter("AREA_CODE", orgCode.substring(0, 2));
	} else if (orgCode.substring(4) == "00000000") {
		rateDs.setParameter("AREA_CODE", orgCode.substring(0, 4));
	}

	rateDs.load();
	document.getElementById("check").style.display = "block";

}

// 重新计算本年火化率
function compute() {
	if (rateDs.getCount() > 0) {
		var totalNum = 0;
		var deadNum = 0;
		var cremationNum = 0;

		for (var i = 0; i < rateDs.getCount(); i++) {
			var rec = rateDs.getAt(i);
			var tn = rec.get("TOTAL_NUMS");
			if (orgCode == rec.get("AREA_CODE"))
				continue;
			if (tn == undefined || tn == '' || tn == 0) {
				L5.Msg.alert("提示", "存在下级未计算！");
				return;
			}
			totalNum += tn;
			deadNum += rec.get("DEAD_NUM");
			cremationNum += rec.get("CREMATION_NUM");
		}

		var recTotal = rateDs.getAt(0);
		recTotal.set("TOTAL_NUMS", totalNum);
		recTotal.set("DEAD_NUM", deadNum);
		recTotal
				.set("DEAD_RATE", Math.round(deadNum / totalNum * 100000) / 100);
		recTotal.set("CREMATION_NUM", cremationNum);
		recTotal.set("CREMATION_RATE", Math
						.round((cremationNum * 100 / deadNum) * 100)
						/ 100);
	}
}

// 计算死亡人数
function onComputeDead() {
	var totalNum = getParam("totalNum");
	var deadRate = getParam("deadRate");
	var cremationNum = getParam("cremationNum");
	var deadNum = 0;
	var cremationRate = 0;
	if (totalNum != undefined && deadRate != undefined) {
		deadNum = Math.floor(totalNum * deadRate / 1000);
		ds.getCurrent().set("deadNum", deadNum);
	}

	if (totalNum != undefined && deadRate != undefined
			&& cremationNum != undefined) {
		cremationRate = Math.round((cremationNum * 100 / deadNum) * 100) / 100;
		ds.getCurrent().set("cremationRate", cremationRate);
	}
}

// 当录入年份信息后，查询相似数据
function onChange() {
	var sumYear = document.getElementById("sumYear").value;
	if (sumYear != undefined) {
		dsTemp.setParameter("AREA_CODE@=@String", orgCode);
		dsTemp.setParameter("SUM_YEAR@=@String", sumYear);
		dsTemp.on('load', function() {
			if (dsTemp.getCount() > 0) {
				// 回填信息
				L5.MessageBox.confirm('', '存在相同数据,是否重新加载？', function(sure) {
					method = "update";
					if (sure == "yes") {
						var rec = dsTemp.getAt(0);
						ds.getCurrent().set("recordId", rec.get("recordId"));
						ds.getCurrent().set("totalNum", rec.get("totalNum"));
						ds.getCurrent().set("deadRate", rec.get("deadRate"));
						ds.getCurrent().set("deadNum", rec.get("deadNum"));
						ds.getCurrent().set("cremationNum",
								rec.get("cremationNum"));
						ds.getCurrent().set("cremationRate",
								rec.get("cremationRate"));
						document.getElementById("sumYear").disabled = "disabled";
					} else {
						loadCremationNum();
						return;
					}
				});
			} else
				loadCremationNum();
		});
		dsTemp.load();
	}
}

function loadCremationNum() {
	var sumYear = document.getElementById("sumYear").value;
	cremationNumDs.setParameter("ORGAN_CODE", orgCode.substr(0, 6));
	cremationNumDs.setParameter("SUM_YEAR", sumYear);
	cremationNumDs.load();
}

function test() {
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCremationRateCmd");
	command.execute("test");
}

function save() {
	var valid = ds.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", valid);
		return false;
	}

	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCremationRateCmd");
	command.setParameter("record", ds.getCurrent());
	if (method == "update")
		command.execute("update");
	else
		command.execute("insert");

	if (!command.error) {
		L5.Msg.alert("提示", "保存成功", function() {
					// history.go(-1);
				});
	} else {
		L5.Msg.alert("错误", command.error);
	}
}
// 导出excel
function exportExcel() {
	var statisticsTime = document.getElementById("qYear").value;
	var ds = L5.DatasetMgr.lookup("rateDs");
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"] = "1"; // 导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"] = startCursor; // 总记录中当前页记录起始位置
	ds.baseParams["limitExcel"] = total; // 导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds,
			"/jsp/cams/fis/query/fisFuneralCremationRateListExcel.jsp?statisticsTime="
					+ statisticsTime);
	ds.baseParams["excelType"] = "reset"; // 重置导出类型

}