function init(){
	//加载业务表，获取审批审核意见
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeApplyInfoDs.load(true);
	var record = fisCemeApplyInfoDs.getCurrent();
	//加载备案表
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	fisCemeLogoffDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeLogoffDs.load();
	//加载外管单位意见表
	var cemeLogoffOpinionDs = L5.DatasetMgr.lookup("cemeLogoffOpinionDs");
	cemeLogoffOpinionDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	cemeLogoffOpinionDs.load();
	//获取公墓信息表
	var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
	fisCemeDataSet.setParameter("RECORD_ID",recordId);
	fisCemeDataSet.load();
	var tabPanel = L5.getCmp("TabPanel");
	tabPanel.setActiveTab(4);
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	setHide();
}

function goBack() {
	history.go(-1);
}
function setHide(){
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeApplyInfoDs.load(true);
	var record = fisCemeApplyInfoDs.getCurrent();
	var isReport = record.get("isReport");
	if(isReport=="5"||isReport=="6"){
		document.getElementById("xjdiv1").style.display="none";
		accessoriesDataSet.setParameter("startCode", "L01");
		accessoriesDataSet.setParameter("endCode", "L10");
	}else{
		accessoriesDataSet.setParameter("startCode", "L01");
		accessoriesDataSet.setParameter("endCode", "L11");
	}
	accessoriesDataSet.load();
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
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyId);

	accessoriesItemDataSet.load();
	var win = L5.getCmp("uploadList");
	win.show();
}
function closeUploadList() {
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeApplyInfoDs.load(true);
	var record = fisCemeApplyInfoDs.getCurrent();
	var isReport = record.get("isReport");
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	if(isReport=="5"||isReport=="6"){
		accessoriesDataSet.setParameter("startCode", "L01");
		accessoriesDataSet.setParameter("endCode", "L10");
	}else{
		accessoriesDataSet.setParameter("startCode", "L01");
		accessoriesDataSet.setParameter("endCode", "L11");
	}
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
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

function rejectDetail(){
	window.showModalDialog("workFlowDetail.jsp?cemeApplyId="+cemeApplyId, "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}