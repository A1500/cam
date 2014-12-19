var NDate = L5.server.getSysDate();
function init() {
	if (method == "detail") {
		infoDs.on('load', function() {
			if(infoDs.getCount()>0) {
				hideYh(infoDs.getAt(0).get("allocationType"));
			}
		});
		infoDs.setParameter("INFO_ID", infoId);
		infoDs.load();
	}
}
function back() {
	window.close();
}
// 隐藏银行信息
function hideYh(at) {
	if (at == "0") {
		document.getElementById("yhTr").style.display = 'none';
		document.getElementById("yhTr2").style.display = 'none';
	}
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("acceptAreaCode").value = list[0];
		document.getElementById("acceptAreaName").value = list[4];
		infoDs.set("acceptAreaCode", list[0]);
		infoDs.set("acceptAreaName", list[4]);
	}
}