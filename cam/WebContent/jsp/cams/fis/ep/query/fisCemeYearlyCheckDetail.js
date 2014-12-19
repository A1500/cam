function init(){
	//激活tab页
	var tabPanel = L5.getCmp("tabPanel");
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(0);
	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");
	var daFenDataset = L5.DatasetMgr.lookup("daFenDataset");
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");//附件
		accessoriesDataSet.setParameter("code","A");
		accessoriesDataSet.setParameter("applayId",cemeApplyId);
		accessoriesDataSet.load(true);
	//发起页面明细
	
		CemeInfoDs.setParameter("RECORD_ID",recordId);
		scoreDataSet.setParameter("SCORE_ID",scoreId);
		daFenDataset.setParameter("CEME_APPLY_ID",cemeApplyId);
		daFenDataset.load(true);
		scoreDataSet.load(true);
		CemeInfoDs.load(true);
		if(daFenDataset.get("firstResult")==""||daFenDataset.get("firstResult")==null){
			document.getElementById("xjdiv").style.display = "none";
		}
		if(daFenDataset.get("secondResult")==""||daFenDataset.get("secondResult")==null){
			document.getElementById("sjdiv").style.display = "none";
		}
	
}
//单击返回按钮
function returnClick(){
	history.go(-1);
}

//附件管理
function clickUploadFile() {
	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=",cemeApplyId);
	accessoriesItemDataSet.load();
	var win = L5.getCmp("uploadList");
	win.show();
}

function closeUploadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("code","A");
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
	win.hide();
}
// 渲染下载
function downloadUploadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + '下载' + '</a>';
}

// 点击下载
function clickDownload(index) {
	var record = accessoriesItemDataSet.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=FIS_CEME_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}