var tDate = L5.server.getSysDate();
var year = tDate.getYear()+"";
function init() {
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	if(organType!="11" && organType!="12" && organType!="13" && organType!="14") {
		L5.Msg.alert("提示", "未知等级，不能进入此页面！", function(){
			onCancel();
		});
	}
	
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	disDetailSourceDs.setParameter("DETAIL_ID", detailId);
	disDetailSourceDs.load();
	disDetailBatchSourceDs.setParameter("DETAIL_ID", detailId);
	disDetailBatchSourceDs.load();
	var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
	disAccessoriesDs.setParameter("ITEM_ID", detailId);
	disAccessoriesDs.load();
	L5.Msg.hide();
}
//返回
function onCancel() {
	window.returnValue="T";
	window.close();
}
//附件管理
function onStuffer(){
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.show();
}
//关闭附件
function onCloseStuffer(){
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.hide();
}
// 增加上传附件
function addUploadFile() {
	var win = L5.getCmp("uploadWin");
	win.show();
}
//上传附件
function click_upload() {
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisAccessoriesCmd");
	command.setParameter("itemId", detailId);
	command.setParameter("note", document.getElementById("fileMess").value);
	command.setForm("form_content");
	command.execute("uploadSave");
	// 包含有大字段的异常判断
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("提示", "上传附件成功!", function() {
						var win = L5.getCmp("uploadWin");
						document.forms["form_content"].reset();
						win.hide();
						var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
						disAccessoriesDs.setParameter("ITEM_ID",detailId);
						disAccessoriesDs.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}
//渲染删除附件
function delUploadFile(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:clickDelete(\''
			+ disAccessoriesDs.indexOf(record) + '\')">' + '删除' + '</a>';
}
//删除附件
function clickDelete(index) {
	var record = disAccessoriesDs.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？', function(sure) {
		if (sure == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisAccessoriesCmd");
			command.setParameter("accessoriesId", record.get("accessoriesId"));
			command.execute("delete");
			if (!command.error) {
				disAccessoriesDs.reload();
				L5.Msg.alert('提示', '删除成功！');
			} else {
				L5.Msg.alert("错误", command.error);
			}
		} else
			return;
	});
}
// 渲染下载
function downloadUploadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ disAccessoriesDs.indexOf(record) + '\')">' + value + '</a>';
}
// 点击下载
function clickDownload(index) {
	var record = disAccessoriesDs.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=DIS_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}