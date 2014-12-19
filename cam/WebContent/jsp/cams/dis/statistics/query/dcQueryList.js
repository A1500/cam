function init() {
	infoDs.setParameter("RELIEF_TYPE", "DC");
	infoDs.setParameter("ID", organcode);
	infoDs.setParameter("YEAR", disYear);
	infoDs.load();
}

function closeWin(){
	var win = L5.getCmp("sumWin");
	win.hide();
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
		document.getElementById("qAcceptAreaCode").value = list[0];
		document.getElementById("qAcceptAreaName").value = list[4];
	}
}
