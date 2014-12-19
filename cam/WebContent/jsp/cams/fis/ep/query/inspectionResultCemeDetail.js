function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("year", year);
	ds.setParameter("cityCode", cityCode);
	ds.setParameter("state", state);
	ds.setParameter("ifSum", ifSum);
	ds.setParameter("isP", isP);
	ds.setParameter("prop", prop);
	ds.load();
}

function back() {
	if (flag == '2') {
		history.go(-1);
	} else {
		var data = new L5.Map();
		data.put("year", year);
		data.put("prop", prop);
		data.put("cityCode", cityCode);
		var url = "jsp/cams/fis/ep/query/cemeInspectionResultQuery.jsp";
		var text = '业务办理';
		L5.forward(url, text, data);
	}
}
function showDetail(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:showCemeDetail(\'' + record.get("CEME_ID")
			+ "," + record.get("PROP") + '\')">' + value + '</a>';
}
function showCemeDetail(arg) {
	var url;
	var args = arg.split(",");
	if (args[1] == '1') {// 公益性
		url = "../collection/cemeNoprofitInformationDetails.jsp?dataBean="
				+ args[0];
	} else {// 经营性
		url = "../collection/cemeProfitInformationDetails.jsp?dataBean="
				+ args[0];
	}
	var width = screen.width - 100;
	var height = screen.height - 140;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}