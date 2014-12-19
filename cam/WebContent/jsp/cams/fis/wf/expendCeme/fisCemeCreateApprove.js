function init() {
	
	var fisCemeApplyInfoDataSet = L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	var fisOpinionDataSet=L5.DatasetMgr.lookup("fisOpinionDataSet");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
	
	fisCemeApplyInfoDataSet.setParameter("CEME_APPLY_ID@=", cemeApplyId);
	fisCemeApplyInfoDataSet.load(true);
	fisCemeApplyInfoDataSet.set("firstUnit",organName);
	fisCemeApplyInfoDataSet.set("firstUnitId",organCode);
	fisCemeApplyInfoDataSet.set("firstResult","");
	fisCemeApplyInfoDataSet.set("firstOpinion","");
	fisCemeApplyInfoDataSet.set("firstTime",curDay);
	fisCemeApplyInfoDataSet.set("firstReportTime",curDay);

	fisCemeExpendInfoDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDataSet.get("recordId"));
	fisCemeExpendInfoDataSet.load(true);
	
	fisCemeInfoDataSet.setParameter("RECORD_ID@=",fisCemeExpendInfoDataSet.get("cemeId"));
	fisCemeInfoDataSet.load(true);
	
	historyDataSet.newRecord();
	historyDataSet.set("hisId",hisIdNew);
	historyDataSet.set("cemeApplyId",cemeApplyId);
	historyDataSet.set("recordId",fisCemeApplyInfoDataSet.get("recordId"));
	historyDataSet.set("firstUnit",organName);
	historyDataSet.set("firstUnitId",organCode);

	//var recordHistory=historyDataSet.getCurrent();
	//alert(recordHistory.get("HIS_ID"));	
	
	fisOpinionDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
	fisOpinionDataSet.load(true);

	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId",cemeApplyId);
	accessoriesDataSet.setParameter("startCode","B41");
	accessoriesDataSet.setParameter("endCode","B70");
	accessoriesDataSet.load(true);
	
}
function save(){
	var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	var validApply=fisCemeApplyInfoDataSet.isValidate(true);
	if(validApply!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+validApply);
		return false;
	}
	var recordApply=fisCemeApplyInfoDataSet.getCurrent();
	var commandApply=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	commandApply.setParameter("record",recordApply);
	commandApply.execute("update");
	if (!commandApply.error){
		L5.Msg.alert("提示","保存成功！");
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}

function submitOn(){
	L5.MessageBox.confirm('确定', '确定要提交到上级单位吗?',function(state){
		if (state=="yes"){	
			var submitDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
			var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
			var validSubmit=submitDataSet.isValidate(true);
			var result="";
			if(validSubmit!=true){	
				
				return false;
			}
			
			var recordApply=submitDataSet.getCurrent();
			var recordHistory=historyDataSet.getCurrent();
		
			result=recordApply.get("firstResult");
			if(result==2){
				L5.MessageBox.confirm('确认','取消该新建申请后流程将走向完结，是否继续操作?',function(state){
					if (state=="yes"){
						recordHistory.set("firstOpinion",recordApply.get("firstOpinion"));
						recordHistory.set("firstResult",recordApply.get("firstResult"));
						recordHistory.set("firstTime",curTime);
						var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
						
						commandSubmit.setParameter("recordHistory",recordHistory);
						commandSubmit.setParameter("recordApply",recordApply);
						commandSubmit.setParameter("result",result);
						commandSubmit.setParameter("assignmentId",assignmentId);
						commandSubmit.execute("sendOfExpend");
						
						
						if (!commandSubmit.error){
							L5.Msg.alert("提示","公墓扩建申请已审批通过！",function(){
								returnBack();
							});
						}else{
							L5.Msg.alert("提示","提交出错，请修改后提交！");
						}						
					}else{
						L5.Msg.alert("提示","取消新建申请操作已取消！");
						return;
					}
					
				});			
			}
			else{
				L5.MessageBox.confirm('确定', '确定要上报此条记录吗?',function(state){
					if (state=="yes"){
						var waitConfig = {
								   interval: 500, 
								   duration: 4000,
								   increment: 5,
								   text: 'Updating...',
								   scope:this,
								   fn:function(){
									   recordHistory.set("firstOpinion",recordApply.get("firstOpinion"));
										recordHistory.set("firstResult",recordApply.get("firstResult"));
										recordHistory.set("firstTime",curTime);
										var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
										
										commandSubmit.setParameter("recordHistory",recordHistory);
										commandSubmit.setParameter("recordApply",recordApply);
										commandSubmit.setParameter("result",result);
										commandSubmit.setParameter("assignmentId",assignmentId);
										commandSubmit.execute("sendOfExpend");
										
										
										if (!commandSubmit.error){
											L5.Msg.alert("提示","公墓扩建申请已审批通过！",function(){
												returnBack();
											});
										}else{
											L5.Msg.alert("提示","提交出错，请修改后提交！");
										}	
								   }
								};
								L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);				
					}else {
						return false;
					}
				
				});
				
				
			}
		}else{
			L5.Msg.alert("提示","提交操作已取消！");
		}
	});		
}
function returnBack(){
	history.go(-1);
}
function query(){
	
}
function boHui(){
	L5.MessageBox.confirm('确定', '确定要驳回到下级单位吗?',function(state){
		if (state=="yes"){	
			var submitDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
			var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
			var validSubmit=submitDataSet.isValidate(true);
			if(validSubmit!=true){	
				
				return false;
			}
			var recordApply=submitDataSet.getCurrent();
			var recordHistory=historyDataSet.getCurrent();
			
			recordHistory.set("firstOpinion",recordApply.get("firstOpinion"));
			recordHistory.set("firstResult","3");
			recordHistory.set("firstTime",curTime);
			
			var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			
			commandSubmit.setParameter("recordHistory",recordHistory);
			commandSubmit.setParameter("recordApply",recordApply);
			commandSubmit.setParameter("result","3");
			commandSubmit.setParameter("assignmentId",assignmentId);
			commandSubmit.execute("sendOfExpend");
			
			if (!commandSubmit.error){
				L5.Msg.alert("提示","已经驳回到上一级！",function(){
					returnBack();
				});
			}else{
				L5.Msg.alert("提示","驳回出错，请修改后重新驳回！"+commandSubmit.error);
			}
		}else{
			L5.Msg.alert("提示","驳回操作被取消！");
		}
	});
		
}
function select(){
	var url = 'opinionHistory.jsp?cemeApplyId=' + cemeApplyId;
	var width = 1100;
	var height = 500;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	
}

//县
function clickManage() {
	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}

	var record = selected[0];
	if(organType=="13"&&record.get("code")!="B61"){
		L5.Msg.alert('提示', "当前用户只能对县级文件进行维护管理!");
		return false;
	}
	
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyId);
	accessoriesItemDataSet.load();
	
	var win = L5.getCmp("uploadList");
	win.show();	
}
//乡
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


//增加上传附件
function addUploadFile() {
	var win = L5.getCmp("uploadWin");
	win.show();

}

function click_upload() {
		var editGrid = L5.getCmp('uploadGrid');
		var selected = editGrid.getSelectionModel().getSelections();
		var record = selected[0];
	if (document.getElementById("files").value == "") {
		L5.Msg.alert("提示", "请选择要上传的附件");
		return false;
	};
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	command.setParameter("applyId", cemeApplyId);
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
								cemeApplyId);
						accessoriesItemDataSet.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}

function closeUploadList() {
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId",cemeApplyId);	
	accessoriesDataSet.setParameter("startCode","B41");
	accessoriesDataSet.setParameter("endCode","B70");
	accessoriesDataSet.load(true);

	var win = L5.getCmp("uploadList");
	win.hide();
}

function closeDownloadList() {
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId",cemeApplyId);	
	accessoriesDataSet.setParameter("startCode","B41");
	accessoriesDataSet.setParameter("endCode","B70");
	accessoriesDataSet.load(true);
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
function getTimes(item) {
	LoushangDate(item.previousSibling);
}

