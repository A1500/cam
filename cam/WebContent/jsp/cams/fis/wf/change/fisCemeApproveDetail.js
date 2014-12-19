function init(){
	//获取公墓信息表
	var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
	fisCemeDataSet.setParameter("RECORD_ID@=",recordId);
	fisCemeDataSet.load();
	
	var fisCemeChangeDataSet = L5.DatasetMgr.lookup("fisCemeChangeDataSet");
	fisCemeChangeDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
	fisCemeChangeDataSet.load(true);
	
	var detaildsList = L5.DatasetMgr.lookup("detaildsList");
	detaildsList.setParameter("CHANGE_ID@=",fisCemeChangeDataSet.get("changeId"));
	detaildsList.load();
	
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "C01");
	if(organType=="13"){
		accessoriesDataSet.setParameter("endCode", "C10");
	}else if(organType=="12"){
		accessoriesDataSet.setParameter("endCode", "C20");
	}else if(organType=="11"){
		accessoriesDataSet.setParameter("endCode", "C30");
	}
    accessoriesDataSet.load(true);
	var tabPanel = L5.getCmp("TabPanel");
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	setHide();
}
function setHide(){
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeApplyInfoDs.load(true);
	var record = fisCemeApplyInfoDs.getCurrent();
	var isReport = record.get("isReport");
	if(isReport=="1"||isReport=="2"){
		document.getElementById("shjdiv1").style.display = "none";
	}else if(isReport=="0"||isReport=="4"){
		document.getElementById("sjdiv1").style.display = "none";
		document.getElementById("shjdiv1").style.display = "none";
	}
}
function returnBack(){
	history.go(-1);
}
function clickDetailFile(){
	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyId);
	accessoriesItemDataSet.load();
	var win = L5.getCmp("downloadList");
	win.show();
}
function closeDownloadList() {
	var win = L5.getCmp("downloadList");
	win.hide();
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