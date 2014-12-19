function init(){
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeApplyInfoDs.load(true);
	var applyRecord = fisCemeApplyInfoDs.getCurrent();
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	fisCemeLogoffDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeLogoffDs.load();
	var cemeLogoffOpinionDs = L5.DatasetMgr.lookup("cemeLogoffOpinionDs");
	cemeLogoffOpinionDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	cemeLogoffOpinionDs.load();
	var fisCemeInfoDataSet = L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	fisCemeInfoDataSet.setParameter("RECORD_ID",applyRecord.get("recordId"));
	fisCemeInfoDataSet.load();
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("startCode", "L01");
	accessoriesDataSet.setParameter("endCode", "L11");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
    accessoriesDataSet.load();
    var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	historyDataSet.newRecord({
		"hisId" : hisId, 
		"cemeApplyId" : cemeApplyId,
		"recordId" : applyRecord.get("recordId")
	});
	var tabPanel = L5.getCmp("TabPanel");
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	setHide();
}

function send() {
	if(!checkValidate2()){
		return false;
	}
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeApplyRecord=fisCemeApplyInfoDs.getCurrent();
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	var fisCemeLogoffRecord=fisCemeLogoffDs.getCurrent();
	var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	var historyRecord = historyDataSet.getCurrent();
	historyRecord.set("firstTime",fisCemeApplyRecord.get("zeroTime"));
	historyRecord.set("firstOpinion",fisCemeApplyRecord.get("zeroOpinion"));
	historyRecord.set("firstResult",fisCemeApplyRecord.get("zeroResult"));
	historyRecord.set("firstUnit",fisCemeApplyRecord.get("zeroUnit"));
	historyRecord.set("firstUnitId",fisCemeApplyRecord.get("zeroUnitId"));
	var opinion = fisCemeApplyRecord.get("zeroResult");
	L5.MessageBox.confirm('确定', '确定提交当前业务?提交后不可更改',function(state){
		if(state=="yes"){
			var waitConfig = {
			   interval: 500, 
			   duration: 3000,
			   increment: 6,
			   text: 'Submitting...',
			   scope:this,
			   fn:function(){
				   var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
					command.setParameter("fisCemeApplyRecord", fisCemeApplyRecord);
					command.setParameter("historyRecord", historyRecord);
					command.setParameter("fisCemeLogoffRecord",fisCemeLogoffRecord);
					command.setParameter("assignmentId", assignmentId);
					command.setParameter("opinion", opinion);
					command.setParameter("result","buqi");
					command.execute("cemeLogoffSubmit");
					if(!command.error){
						if(opinion =="0"){
							L5.Msg.alert("提示","成功提交到上级单位!",function(){
								goBack();
						    });	
						}else{
							L5.Msg.alert("提示","公益性公墓关闭审批已结束!",function(){
								goBack();
						    });	
						}
					}else{
						L5.Msg.alert('提示',"提交时出现错误！"+command.error);
					}
			   }
			};L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);
		}else{
			return false;
		}
	});
}
function submit(){
	if(!checkValidate2()){
		return false;
	}
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeApplyRecord=fisCemeApplyInfoDs.getCurrent();
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	var fisCemeLogoffRecord=fisCemeLogoffDs.getCurrent();
	var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	var historyRecord = historyDataSet.getCurrent();
	historyRecord.set("firstTime",fisCemeApplyRecord.get("firstTime"));
	historyRecord.set("firstOpinion",fisCemeApplyRecord.get("firstOpinion"));
	historyRecord.set("firstResult",fisCemeApplyRecord.get("firstResult"));
	historyRecord.set("firstUnit",organName);
	historyRecord.set("firstUnitId",organCode);
	fisCemeApplyRecord.set("firstUnit",organName);
	fisCemeApplyRecord.set("firstUnitId",organCode);
	var opinion = fisCemeApplyRecord.get("firstResult");
	L5.MessageBox.confirm('确定', '确定提交当前审批？提交过后不可更改',function(state){
		if(state=="yes"){
			var waitConfig = {
			   interval: 500, 
			   duration: 3000,
			   increment: 6,
			   text: 'Submitting...',
			   scope:this,
			   fn:function(){
				   var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
					command.setParameter("fisCemeApplyRecord", fisCemeApplyRecord);
					command.setParameter("historyRecord", historyRecord);
					command.setParameter("fisCemeLogoffRecord", fisCemeLogoffRecord);
					command.setParameter("assignmentId", assignmentId);
					command.setParameter("result", "submit");
					command.execute("cemeLogoffSubmit");
					if(!command.error){
						if(opinion!="2"){
							L5.Msg.alert("提示","公益性公墓关闭审批已结束!",function(){
								goBack();
						    });
						}else{
							L5.Msg.alert("提示","已成功驳回至乡镇单位!",function(){
								goBack();
						    });
						}
						
					}else{
						L5.Msg.alert('提示',"提交时出现错误！"+command.error);
					}
			   }
			};L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);
		}else{
			return false;
		}
	});
}
function reject(){
	//获取当条业务记录
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeApplyRecord=fisCemeApplyInfoDs.getCurrent();
	var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	var historyRecord = historyDataSet.getCurrent();
	//设置业务记录相关参数
	fisCemeApplyRecord.set("isReport","8");
	fisCemeApplyRecord.set("curOrgan",fisCemeApplyRecord.get("zeroUnit"));
	fisCemeApplyRecord.set("curOrganCode",fisCemeApplyRecord.get("zeroUnitId"));
	fisCemeApplyRecord.set("firstResult","2");
	historyRecord.set("firstTime",fisCemeApplyRecord.get("firstTime"));
	historyRecord.set("firstOpinion",fisCemeApplyRecord.get("firstOpinion"));
	historyRecord.set("firstResult",fisCemeApplyRecord.get("firstResult"));
	historyRecord.set("firstUnit",organName);
	historyRecord.set("firstUnitId",organCode);
	fisCemeApplyRecord.set("firstUnit",organName);
	fisCemeApplyRecord.set("firstUnitId",organCode);
	L5.MessageBox.confirm('确定', '确定要驳回当前业务吗?',function(state){
		if(state=="yes"){
			var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			command.setParameter("fisCemeApplyRecord",fisCemeApplyRecord);
			command.setParameter("historyRecord", historyRecord);
			command.setParameter("assignmentId", assignmentId);
			command.setParameter("result", "reject");
			command.execute("cemeLogoffSubmit");
			if(!command.error){
				L5.Msg.alert("提示","已成功驳回至乡镇单位!",function(){
					goBack();
				});
			}else{
				L5.Msg.alert('提示',"驳回时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}
function fillOption(obj){
	for(i=0;i<obj.length;i++){
		   if(obj[i].selected==true){
			   obj.parentNode.parentNode.nextSibling.childNodes[1].childNodes[0].value=obj[i].innerText; 
		   }
		}
}
//获得当前日期 
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}

function goBack(item) {
	history.go(-1);
}
function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}
function setHide(){
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	if(organType=="13"){
		document.getElementById("xjdiv1").style.display = "none";
		document.getElementById("xzdiv").style.display = "none";
		document.getElementById("send").style.display = "none";
		fisCemeApplyInfoDs.set("firstOpinion","");
		fisCemeApplyInfoDs.set("firstTime",date);
		fisCemeApplyInfoDs.set("firstResult","");
		fisCemeApplyInfoDs.set("firstReportTime","");
		fisCemeApplyInfoDs.set("firstReportNumber","");
		fisCemeApplyInfoDs.set("firstReportName","");
	}else if(organType=="14"){
		document.getElementById("submit").style.display = "none";
		document.getElementById("reject").style.display = "none";
		document.getElementById("xjdiv").style.display = "none";
		document.getElementById("xjdiv1").style.display = "block";
		document.getElementById("xzdiv1").style.display = "none";
		fisCemeApplyInfoDs.set("zeroOpinion","");
		fisCemeApplyInfoDs.set("zeroTime",date);
		fisCemeApplyInfoDs.set("zeroResult","");
	}
}
function rejectDetail(){
	window.showModalDialog("workFlowDetail.jsp?cemeApplyId="+cemeApplyId, "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
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
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyId);
	accessoriesItemDataSet.load();
	var win = L5.getCmp("downloadList");
	win.show();
}
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
						accessoriesItemDataSet.setParameter("ITEM_ID@=",cemeApplyId);
						accessoriesItemDataSet.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}

function closeUploadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "L01");
	accessoriesDataSet.setParameter("endCode", "L11");
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
	win.hide();
}

function closeDownloadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "L01");
	accessoriesDataSet.setParameter("endCode", "L11");
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

function clickDelete(index) {
	var uploadGrid = L5.getCmp('uploadGrid');
	var selected = uploadGrid.getSelectionModel().getSelections();
	var aRecord = selected[0];
	if(check(aRecord)){
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
}
function clickDownload(index) {
	var record = accessoriesItemDataSet.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=FIS_CEME_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}