function init() {
	ds.baseParams["CEME_ID@="] = idField;
	ds.load();
	govAppDs.baseParams["CEME_ID@="] = idField;
	govAppDs.load();
	L5.QuickTips.init();
}

function print() {
	// var cemeId= document.getElementById('cemeId').value;
	var url = "../../comm/print/cemeNoprofitPrint.jsp?docPath=cemeNoprofitPrint.doc";
	url += "&cemeId=" + idField;
	var text = '公益性公墓明细打印';
	var width = 1024;
	var height = 768;
	window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
					+ width + "px;dialogHeight:" + height
					+ "px;resizable:no;status:no;");
}

function back() {
	history.go(-1);
}

function detail() {
	var width = 800;
	var height = 600;
	var url = 'collection.html';
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
}