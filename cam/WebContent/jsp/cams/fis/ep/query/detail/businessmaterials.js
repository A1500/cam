function init() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", idField)
	accessoriesDataSet.load();
	L5.QuickTips.init();
}

function back() {
	history.go(-1);
}

function clickUploadFile() {

	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=", idField);
	accessoriesItemDataSet.load();
	var win = L5.getCmp("uploadList");
	win.show();
}

// 增加上传附件
function addUploadFile() {
	var win = L5.getCmp("uploadWin");
	win.show();

}

function closeUploadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", idField);
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
	win.hide();
}

function click_upload() {
	var uploadGrid = L5.getCmp('uploadGrid');
	var selected = uploadGrid.getSelectionModel().getSelections();
	var record = selected[0];
	var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.CemeInspectionCmd");
	command.setParameter("applyId", applyId);
	command.setParameter("note", document.getElementById("fileMess").value);
	command.setParameter("code", record.get("code"));
	command.setForm("form_content");
	command.execute("uploadSave");
	// 包含有大字段的异常判断
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("提示", "上传附件成功!", function() {
						var win = L5.getCmp("uploadWin");
						win.hide();
						var accessoriesItemDataSet = L5.DatasetMgr
								.lookup("accessoriesItemDataSet");
						accessoriesItemDataSet.setParameter("CODE@=", record
										.get("code"));
						accessoriesItemDataSet.setParameter("ITEM_ID@=",
								idField);
						accessoriesItemDataSet.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}

function delUploadFile(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:clickDelete(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + '删除' + '</a>';
}

function clickDelete(index) {
	var record = accessoriesItemDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？', function(sure) {
		if (sure == "yes") {
			var accessoriesId = record.get("accessoriesId");
			var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.CemeInspectionCmd");
			command.setParameter("id", accessoriesId);
			command.execute("delAccessoriesById");
			if (!command.error) {
				accessoriesItemDataSet.reload();
				accessoriesDataSet.reload();
				L5.Msg.alert('提示', '删除成功！');
			} else {
				L5.Msg.alert("错误", command.error);
			}
		} else
			return;
	});
}
function downloadUploadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + '下载' + '</a>';
}
function clickDownload(index) {
	var record = accessoriesItemDataSet.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=FIS_CEME_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}