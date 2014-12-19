function init(){
	//激活tab页
	var tabPanel = L5.getCmp("tabPanel");
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(0);
	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");
	//var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	var daFenDataset = L5.DatasetMgr.lookup("daFenDataset");
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");//附件
		accessoriesDataSet.setParameter("code","A");
		accessoriesDataSet.setParameter("applayId",cemeApplyId);
		accessoriesDataSet.load(true);
	//发起页面明细
	if(method == "DETAIL"){
		if(organType=="12"){
			document.getElementById("sjdiv").style.display = "block";
			document.getElementById("xjdiv").style.display = "none";
		}else if(organType=="13"){
			document.getElementById("xjdiv").style.display = "block";
			document.getElementById("sjdiv").style.display = "none";
		}
		
		CemeInfoDs.setParameter("RECORD_ID",recordId);
		scoreDataSet.setParameter("SCORE_ID",scoreId);
		daFenDataset.setParameter("CEME_APPLY_ID",cemeApplyId);
		daFenDataset.load(true);
	}else{
		//市级审批明细
		//隐藏打分标准的tab页
		//tabPanel.remove(tabPanel.getComponent(1));
		scoreDataSet.setParameter("CEME_APPLY_ID",cemeApplyId);
		daFenDataset.setParameter("CEME_APPLY_ID",cemeApplyId);
		daFenDataset.load(true);
		CemeInfoDs.setParameter("RECORD_ID",daFenDataset.getCurrent().get("recordId"));
	}
	scoreDataSet.load(true);
	CemeInfoDs.load(true);
	
}
//单击返回按钮
function returnClick(){
	history.go(-1);
}
//查看流程明细
function detailwf(){
	var url = 'workFlowDetail.jsp?cemeApplyId=' + cemeApplyId;
	var width = 1100;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
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