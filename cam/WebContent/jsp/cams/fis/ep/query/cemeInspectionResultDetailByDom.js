function init() {
	var reportDataset = L5.DatasetMgr.lookup("reportDataset");
	reportDataset.setParameter("year", year);
	reportDataset.setParameter("xzqu", xzqu);
	reportDataset.setParameter("xz", xz);
	reportDataset.load();
}
function backToBefore() {
	var data = new L5.Map();
	data.put("year", year);
	data.put("prop", xz);
	var url = 'jsp/cams/fis/ep/query/cemeInspectionResultQuery.jsp';
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
	var data = new L5.Map();
	data.put("cityCode", cityCode);
	data.put("ifSum", ifSum);
	data.put("year", year);
	data.put("prop", xz);
	data.put("state", state);
	data.put("flag", "2");
	var url = 'jsp/cams/fis/ep/query/inspectionResultCemeDetail.jsp';
	var text = '业务办理';
	L5.forward(url, text, data)

}