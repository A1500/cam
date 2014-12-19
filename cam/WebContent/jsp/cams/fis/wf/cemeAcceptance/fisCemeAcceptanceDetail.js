function init(){
	var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	//alert(curTime);
	/*
	 * 激活各个标签页
	 */
	var tabPanel = L5.getCmp("tab1");
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	
	fisCemeApplyInfoDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
	fisCemeApplyInfoDataSet.load(true);
	accessoriesDataSet.setParameter("applayId",cemeApplyId);
	accessoriesDataSet.setParameter("startCode","Y01");
    accessoriesDataSet.setParameter("endCode","Y30");
    accessoriesDataSet.load(true);	
    
		var fisCemeExpendInfoDataSet= L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
		fisCemeExpendInfoDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDataSet.get("recordId"));
		fisCemeExpendInfoDataSet.load(true);
		if(!fisCemeExpendInfoDataSet.getCount()){	
			document.getElementById("form2").style.display = "block";	
			document.getElementById("form3").style.display = "none";
			fisCemeInfoDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDataSet.get("recordId"));
			fisCemeInfoDataSet.load(true);
		}else {
			document.getElementById("form3").style.display = "block";	
			document.getElementById("form2").style.display = "none";
			fisCemeInfoDataSet.setParameter("RECORD_ID@=",fisCemeExpendInfoDataSet.get("cemeId"));
			fisCemeInfoDataSet.load(true);
		}
		if(organType==13){
		    document.getElementById("shouLi").style.display = "block";
			document.getElementById("shenHe").style.display = "none";
		    document.getElementById("shenPi").style.display = "none";
		    
			

		}else if(organType==12){
		 document.getElementById("shouLi").style.display = "block";
			document.getElementById("shenHe").style.display = "block";
		    document.getElementById("shenPi").style.display = "none";
		   
		}else{
		    document.getElementById("shouLi").style.display = "block";
			document.getElementById("shenHe").style.display = "block";
		    document.getElementById("shenPi").style.display = "block";

		}

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
	accessoriesItemDataSet.setParameter("ITEM_ID@=", (cemeApplyId == "null")
					? cemeApplyIdNew
					: cemeApplyId);

	accessoriesItemDataSet.load();
	var win = L5.getCmp("uploadList");
	win.show();
}
//增加上传附件
function addUploadFile() {
	var win = L5.getCmp("uploadWin");
	win.show();

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
	command.setParameter("applyId", (cemeApplyId == "null") ? cemeApplyIdNew : cemeApplyId);
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
								(cemeApplyId == "null") ? cemeApplyIdNew : cemeApplyId);
						accessoriesItemDataSet.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}

function closeUploadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", (cemeApplyId == "null") ? cemeApplyIdNew : cemeApplyId);
	accessoriesDataSet.setParameter("startCode","Y01");
	accessoriesDataSet.setParameter("endCode","Y30");
	accessoriesDataSet.load(true);
	var win = L5.getCmp("uploadList");
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

function clickDownload(index) {
	var record = accessoriesItemDataSet.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=FIS_CEME_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
	
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



function clickUploadFileTown() {
	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
		
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyId );
	accessoriesItemDataSet.load();
	var win = L5.getCmp("downloadList");
	win.show();	
}
function closeDownloadList() {

	
	var win = L5.getCmp("downloadList");
	win.hide();
}
function returnBack(){
	history.go(-1);
}
