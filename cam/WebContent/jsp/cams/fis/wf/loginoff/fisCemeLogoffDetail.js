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
	fisCemeDataSet.setParameter("RECORD_ID",record.get("recordId"));
	fisCemeDataSet.load();
	var tabPanel = L5.getCmp("TabPanel");
	tabPanel.setActiveTab(4);
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	setHide();
}

function goBack(item) {
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
	var fillOrganCode = record.get("fillOrganCode");
	if(isReport=="1"||isReport=="2"){   //市级已审核，市级已驳回
		document.getElementById("shjdiv1").style.display = "none";
		document.getElementById("sjdiv2").style.display = "none";
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L30");
	}
	if(isReport=="0"||isReport=="4"){   //县级已上报，县级未上报
		document.getElementById("shjdiv1").style.display = "none";
		document.getElementById("sjdiv1").style.display = "none";
		document.getElementById("sjdiv2").style.display = "none";
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L20");
	}
	if(isReport=="10"||isReport=="9"){   //市级已上报，市级未上报
		document.getElementById("xjdiv1").style.display = "none";
		document.getElementById("sjdiv1").style.display = "none";
		document.getElementById("shjdiv1").style.display = "none";
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L30");
	}
	if(isReport =="3"){
		if(fillOrganCode.substr(5,1)=="0"){   //市级发起的关闭流程
			document.getElementById("xjdiv1").style.display = "none";
			document.getElementById("sjdiv1").style.display = "none";
			accessoriesDataSet.setParameter("startCode", "L21");
			accessoriesDataSet.setParameter("endCode", "L40");
		}else{                                //县级发起的关闭流程
			document.getElementById("sjdiv2").style.display = "none";
			accessoriesDataSet.setParameter("startCode", "L12");
			accessoriesDataSet.setParameter("endCode", "L40");
		}
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
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	var record = fisCemeApplyInfoDs.getCurrent();
	var isReport = record.get("isReport");
	if(isReport=="1"||isReport=="2"){
		document.getElementById("shjdiv1").style.display = "none";
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L30");
	}
	if(isReport=="0"||isReport=="4"){
		document.getElementById("shjdiv1").style.display = "none";
		document.getElementById("sjdiv1").style.display = "none";
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L20");
	}
	if(isReport=="10"||isReport=="9"){
		document.getElementById("xjdiv1").style.display = "none";
		document.getElementById("shjdiv1").style.display = "none";
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L30");
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