function init() {
	if (year && year != 'null' && year != null) {
		var reportDataset = L5.DatasetMgr.lookup("reportDataset");
		document.getElementById("year").value = year;
		reportDataset.setParameter("year", year);

		reportDataset.setParameter("xzqu", organCode);
		if (prop == "null") {
			reportDataset.setParameter("xz", "0");
		} else {
			reportDataset.setParameter("xz", prop);
			document.getElementById("prop").value = prop;
		}
		reportDataset.load();
	} else {
		document.getElementById("year").value = '2011';
	}
}
function query() {
	year = document.getElementById("year").value;
	if (!year) {
		L5.Msg.alert("提示", "请输入年份！");
		return;
	}
	var reportDataset = L5.DatasetMgr.lookup("reportDataset");
	reportDataset.setParameter("year", year);
	reportDataset.setParameter("xzqu", organCode);
	var prop = document.getElementById("prop").value;
	if (prop == "") {
		reportDataset.setParameter("xz", "0");
	} else {
		reportDataset.setParameter("xz", prop);
	}
	reportDataset.load();

}
// 点击属地连接
function showNextLevel(value, cellmeta, record, rowindex, colindex, dataset) {
	if (organCode == "370000000000") {
		if (record.get("CITYCODE") != "370000000000")
			return '<a href="javascript:showExpDetailsWin(\''
					+ record.get("CITYCODE") + '\')">' + value + '</a>';
		else
			return value;
	} else {
		return value;
	}
}

function showExpDetailsWin(cityCode) {
	var data = new L5.Map();
	data.put("xzqu", cityCode);
	data.put("year", year);
	var prop = document.getElementById("prop").value;
	if (prop == "") {
		data.put("xz", 0);
	} else {
		data.put("xz", prop);
	}
	var url = 'jsp/cams/fis/ep/query/cemeInspectionResultDetailByDom.jsp';
	var text = '业务办理';
	L5.forward(url, text, data)

}

function showDetailunCheckedMsg(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'unChecked\')">' + value
				+ '</a>';
	}
}

function showDetailQualifiedMsg(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'qualified\')">' + value
				+ '</a>';
	}
}

function showDetailfirstqQualifiedMsg(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'firstqQualified\')">'
				+ value + '</a>';
	}
}

function showDetailfirstUnQualifiedMsg(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'firstUnQualified\')">'
				+ value + '</a>';
	}
}

function showDetailsecondQualifiedMsg(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'secondQualified\')">'
				+ value + '</a>';
	}
}

function showDetailsecondUnQualifiedMsg(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'secondUnQualified\')">'
				+ value + '</a>';
	}
}

function showDetailunQualifiedMsg(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'unQualified\')">'
				+ value + '</a>';
	}
}

function showDetailCheckedMsg(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'checked\')">' + value
				+ '</a>';
	}
}

function showDetailAllMsg(value, cellmeta, record, rowindex, colindex, dataset) {
	if (value == 0) {
		return value;
	} else {
		return '<a href="javascript:showCemeDetail(\'' + record.get("CITYCODE")
				+ '\',\'' + record.get("IFSUM") + '\',\'all\')">' + value
				+ '</a>';
	}
}

function showCemeDetail(cityCode, ifSum, state) {
	var prop = document.getElementById("prop").value;

	var data = new L5.Map();
	data.put("cityCode", cityCode);
	data.put("ifSum", ifSum);
	data.put("year", year);
	if (prop == "") {
		data.put("prop", 0);
	} else {
		data.put("prop", prop);
	}
	data.put("state", state);
	data.put("flag", "1");
	if (organCode.substring(2) == "0000000000") {
		data.put("isP", "Y");
	}

	var url = 'jsp/cams/fis/ep/query/inspectionResultCemeDetail.jsp';
	var text = '业务办理';
	L5.forward(url, text, data)

}
