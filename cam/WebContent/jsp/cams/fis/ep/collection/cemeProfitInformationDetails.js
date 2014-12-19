function init() {
	ds.baseParams["CEME_ID@="] = idField;
	ds.load();
	itemDs.baseParams["CEME_ID@="] = idField;
	itemDs.load();
	govAppDs.baseParams["CEME_ID@="] = idField;
	govAppDs.load();
	landcardDs.baseParams["CEME_ID@="] = idField;
	landcardDs.load();
}

// 渲染审批事项
function backValue(value, cellmeta, record, rowindex, colindex, dataset) {
	var itemDs = L5.DatasetMgr.lookup("itemDs");
	var idx = itemDs.find("itemId", value, 0);
	if (idx == -1) {
		return "";
	}
	return itemDs.getAt(idx).get("itemLabel") + "("
			+ itemDs.getAt(idx).get("itemTime") + ")";
}

// 打印
function print() {
	var url = "../../comm/print/cemeprofitPrint.jsp?docPath=cemeprofitPrint.doc";
	url += "&cemeId=" + idField;
	var text = '经营性公墓明细打印';
	var width = 1024;
	var height = 768;
	window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
					+ width + "px;dialogHeight:" + height
					+ "px;resizable:no;status:no;");
}