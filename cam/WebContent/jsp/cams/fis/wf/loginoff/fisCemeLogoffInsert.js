function init(){
	//新建业务记录
	var fisCemeApplyInfoDs =L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	var cemeLogoffOpinionDs = L5.DatasetMgr.lookup("cemeLogoffOpinionDs");
	var fisCemeDataSet=L5.DatasetMgr.lookup("fisCemeDataSet");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	if(method=="insert"){
		if(organType == "13"){
			fisCemeApplyInfoDs.newRecord({
				"cemeApplyId" : cemeApplyId,
				"applyFlag" : "L",
				"firstTime" : date,
				"firstReportTime" : date,
				"firstResult" : "0",
				"firstUnitId" : organCode,
				"firstUnit" : organName,
			    "curOrganCode" : organCode,
			    "curOrgan" : organName,
			    "fillOrganName" : organName,
			    "fillOrganCode" : organCode
			});
		}else{
			fisCemeApplyInfoDs.newRecord({
				"cemeApplyId" : cemeApplyId,
				"applyFlag" : "L",
				"secondTime" : date,
				"secondReportTime" : date,
				"secondResult" : "0",
				"secondUnitId" : organCode,
				"secondUnit" : organName,
				"curOrganCode" : organCode,
			    "curOrgan" : organName,
			    "fillOrganName" : organName,
			    "fillOrganCode" : organCode
			});
		}
		cemeLogoffOpinionDs.newRecord({
			"opinionId" : opinionId,
			"cemeApplyId" : cemeApplyId
		});
		fisCemeLogoffDs.newRecord({
			"logoffId" : logoffId,
			"cemeApplyId" : cemeApplyId,
			"logoffDate" : date
		});
		historyDataSet.newRecord({
			"hisId" : hisId, 
			"cemeApplyId" : cemeApplyId,
			"createTime" : time
		});
		fisCemeDataSet.newRecord();
	}else{
		document.getElementById("queryCeme").style.display="none";
		fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeAppId);
		fisCemeApplyInfoDs.load();
		fisCemeLogoffDs.setParameter("CEME_APPLY_ID",cemeAppId);
		fisCemeLogoffDs.load();
		cemeLogoffOpinionDs.setParameter("CEME_APPLY_ID",cemeAppId);
		cemeLogoffOpinionDs.load();
		fisCemeDataSet.setParameter("RECORD_ID",recordId);
		fisCemeDataSet.load();
	}
	var tabPanel = L5.getCmp("TabPanel");
	tabPanel.setActiveTab(4);
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	setHide();
	
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}

function returnBack(){
	history.go(-1);
}

function save(){
	var fisCemeDataSet=L5.DatasetMgr.lookup("fisCemeDataSet");
	var fisCemeApplyInfoDs =L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	var cemeLogoffOpinionDs = L5.DatasetMgr.lookup("cemeLogoffOpinionDs");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	var cemeRecord = fisCemeDataSet.getCurrent();
	var cemeId = cemeRecord.get("recordId");
	var opinionRecord = cemeLogoffOpinionDs.getCurrent();
	var logoffRecord = fisCemeLogoffDs.getCurrent(); //取当前被修改的业务记录
	var applyRecord = fisCemeApplyInfoDs.getCurrent(); //取当前业务记录
	var historyRecord = historyDataSet.getCurrent();
	if(method=="insert"){
		if(cemeId==""){
			L5.Msg.alert('提示',"请先选择要关闭的公墓");
			return false;
		}
		if(!checkValidate()){
			return false;
		}
		if(organType=="13"){
			applyRecord.set("isReport","4");
		}else{
			applyRecord.set("isReport","10");
		}
		historyRecord.set("recordId",cemeId);
		historyRecord.set("firstUnit",organName);
		historyRecord.set("firstUnitId",organCode);
	}
	historyRecord.set("firstTime",applyRecord.get("firstTime"));
    historyRecord.set("firstOpinion",applyRecord.get("firstOpinion"));
    historyRecord.set("firstResult", applyRecord.get("firstResult"));
	var cmd = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	cmd.setParameter("cemeRecord",cemeRecord);
	cmd.setParameter("opinionRecord",opinionRecord);
	cmd.setParameter("logoffRecord",logoffRecord);
	cmd.setParameter("applyRecord",applyRecord);
	cmd.setParameter("historyRecord",historyRecord);
	if(method=="insert"){
		cmd.execute("insertLogoff");
	}else{
		cmd.execute("updateLogoff");
	}
	if (!cmd.error) {
		L5.Msg.alert('提示', "数据保存成功!");
		returnBack();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + cmd.error);
		returnBack();
	}
}

function forCemeSelect(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		//arrs[2] 为公墓记录编码
		var fisCemeApplyInfoQueryDs = L5.DatasetMgr.lookup("fisCemeApplyInfoQueryDs");
		fisCemeApplyInfoQueryDs.setParameter("RECORD_ID",arrs[2]);
		fisCemeApplyInfoQueryDs.setParameter("APPLY_STATE","0");
		fisCemeApplyInfoQueryDs.setParameter("APPLY_FLAG","L");
		fisCemeApplyInfoQueryDs.load(true);
		if(fisCemeApplyInfoQueryDs.getCount()!=0){
			L5.Msg.alert('提示',"当前公墓存在正在审批的流程，请耐心等待");
			return false;
		}else{
			var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
			fisCemeDataSet.setParameter("RECORD_ID",arrs[2]);
			fisCemeDataSet.load();
			fisCemeDataSet.on('load',function(ds){
				fisCemeDataSet.set("sinceHoleNum","");
				fisCemeDataSet.set("cageHoleNum","");
				fisCemeDataSet.set("ecologicalHoleNum","");
				fisCemeDataSet.set("welfareHoleNum","");
			});
		}
	}
}
function openCemeChoose(){
	return window.showModalDialog("../fisCemeInfomation.jsp?manaCode="+organCode+"&prop=2", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}
function setHide(){
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", (cemeAppId=='null')? cemeApplyId: cemeAppId);
	if(organType=="13"){
		document.getElementById("sjdiv").style.display="none";
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L20");
	}else{
		document.getElementById("xjdiv").style.display="none";
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L30");
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
	accessoriesItemDataSet.setParameter("ITEM_ID@=", (cemeAppId=='null')? cemeApplyId: cemeAppId);

	accessoriesItemDataSet.load();
	var win = L5.getCmp("uploadList");
	win.show();
}
function clickDownloadFile() {

	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=", (cemeAppId=='null')? cemeApplyId: cemeAppId);

	accessoriesItemDataSet.load();
	var win = L5.getCmp("downloadList");
	win.show();
}
//增加上传附件
function addUploadFile() {
	var uploadGrid = L5.getCmp('uploadGrid');
	var selected = uploadGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	if(check(record)){
		var win = L5.getCmp("uploadWin");
		win.show();
	}

}

function click_upload() {
	var uploadGrid = L5.getCmp('uploadGrid');
	var selected = uploadGrid.getSelectionModel().getSelections();
	var record = selected[0];
	if (document.getElementById("files").value == "") {
		L5.Msg.alert("提示", "请选择要上传的附件");
		return false;
	};
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	command.setParameter("applyId", (cemeAppId=='null')? cemeApplyId: cemeAppId);
	command.setParameter("note", document.getElementById("fileMess").value);
	command.setParameter("code", record.get("code"));
	command.setForm("form_content");
	command.execute("uploadSave");
	// 包含有大字段的异常判断
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("提示", "上传附件成功!", function() {
						var win = L5.getCmp("uploadWin");
						document.forms["form_content"].reset();
						win.hide();
						var accessoriesItemDataSet = L5.DatasetMgr
						.lookup("accessoriesItemDataSet");
						accessoriesItemDataSet.setParameter("CODE@=", record
										.get("code"));
						accessoriesItemDataSet.setParameter("ITEM_ID@=",
								(cemeAppId=='null')? cemeApplyId: cemeAppId);
						accessoriesItemDataSet.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}

function closeUploadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", (cemeAppId=='null')? cemeApplyId: cemeAppId);
	if(organType=="13"){
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L20");
	}else{
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L30");
	}
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
	win.hide();
}
function closeDownloadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", (cemeAppId=='null')? cemeApplyId: cemeAppId);
	if(organType=="13"){
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L20");
	}else{
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L30");
	}
	accessoriesDataSet.load();
	var win = L5.getCmp("downloadList");
	win.hide();
}
function delUploadFile(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:clickDelete(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + '删除' + '</a>';
}
function downloadUploadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + '下载' + '</a>';
}
function downloadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + record.get("accessoriesName"); + '</a>';
}

function clickDelete(index) {
	var record = accessoriesItemDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？', function(sure) {
		if (sure == "yes") {
			var accessoriesId = record.get("accessoriesId");
			var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			command.setParameter("id", accessoriesId);
			command.execute("delAccessoriesById");
			if (!command.error) {
				accessoriesItemDataSet.reload();
				// accessoriesDataSet.reload();
				L5.Msg.alert('提示', '删除成功！');
			} else {
				L5.Msg.alert("错误", command.error);
			}
		} else
			return;
	});
}
function clickDownload(index) {
	var record = accessoriesItemDataSet.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=FIS_CEME_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}
