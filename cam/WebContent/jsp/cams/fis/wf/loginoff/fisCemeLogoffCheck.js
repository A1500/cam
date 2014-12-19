function init(){
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeApplyInfoDs.load(true);
	var cemeRecord = fisCemeApplyInfoDs.getCurrent();
	var recordId = cemeRecord.get("recordId");
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	fisCemeLogoffDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeLogoffDs.load();
	var cemeLogoffOpinionDs = L5.DatasetMgr.lookup("cemeLogoffOpinionDs");
	cemeLogoffOpinionDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	cemeLogoffOpinionDs.load();
	var fisCemeInfoDataSet = L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	fisCemeInfoDataSet.setParameter("RECORD_ID",recordId);
	fisCemeInfoDataSet.load();
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
	var fisCemeLogoffRecord = fisCemeLogoffDs.getCurrent();
	var opinion="";
	var recTime="";
	if(actDefName=="关闭审核"){
		opinion = fisCemeApplyRecord.get("secondResult");
		if(opinion=="1"){
			fisCemeApplyRecord.set("isReport","2");
		}
		recTime = fisCemeApplyRecord.get("secondTime");
		fisCemeApplyRecord.set("secondUnitId",organCode);
		fisCemeApplyRecord.set("secondUnit",organName);
	}else if(actDefName=="关闭审批"||actDefName=="省级审批"){
		opinion = fisCemeApplyRecord.get("thirdResult");
		if(opinion=="1"){
			fisCemeApplyRecord.set("isReport","3");
		}
		recTime = fisCemeApplyRecord.get("thirdTime");
		fisCemeApplyRecord.set("thirdUnitId",organCode);
		fisCemeApplyRecord.set("thirdUnit",organName);
	}
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
						command.setParameter("record", fisCemeApplyRecord);
						command.setParameter("logoffRecord",fisCemeLogoffRecord);
						command.setParameter("opinion",opinion);
						command.setParameter("recTime",recTime);
						command.setParameter("assignmentId",assignmentId)
					    command.execute("sendLogoff");
						if(!command.error){
							if(actDefName=="关闭审核"){
								if(opinion=="0"){
									L5.Msg.alert("提示","成功提交至下一环节!",function(){
										goBack();
									});
								}else{
									L5.Msg.alert("提示","公墓关闭审批已结束!",function(){
										goBack();
									});
								}
							}else if(actDefName=="关闭审批"||actDefName=="省级审批"){
								L5.Msg.alert("提示","公墓关闭审批已结束!",function(){
									goBack();
								});
							}
						}else{
							L5.Msg.alert('提示',"提交时出现错误！"+command.error);
						}
					  }
					};
				L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);
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
	//history.go(-1);
	var url='jsp/cams/fis/wf/loginoff/fisCemeLogoffApprovalList.jsp';
	L5.forward(url);
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
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	if(actDefName=="关闭审核"){
		document.getElementById("xjdiv").style.display = "none";
		document.getElementById("sjdiv1").style.display = "none";
		document.getElementById("sjdiv2").style.display = "none";
		document.getElementById("shjdiv").style.display = "none";
		document.getElementById("shjdiv1").style.display = "none";
		fisCemeApplyInfoDs.set("secondTime",date);
		fisCemeApplyInfoDs.set("secondUnitId",organCode);
		fisCemeApplyInfoDs.set("secondUnit",organName);
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L30");
	}else if(actDefName=="关闭审批"){
		document.getElementById("xjdiv").style.display = "none";
		document.getElementById("xjdiv1").style.display = "block";
		document.getElementById("sjdiv").style.display = "none";
		document.getElementById("sjdiv1").style.display = "block";
		document.getElementById("shjdiv1").style.display = "none";
		document.getElementById("sjdiv2").style.display = "none";
		fisCemeApplyInfoDs.set("thirdTime",date);
		fisCemeApplyInfoDs.set("thirdUnitId",organCode);
		fisCemeApplyInfoDs.set("thirdUnit",organName);
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L40");
	}else if(actDefName=="省级审批"){
		document.getElementById("xjdiv").style.display = "none";
		document.getElementById("xjdiv1").style.display = "none";
		document.getElementById("sjdiv").style.display = "none";
		document.getElementById("sjdiv1").style.display = "none";
		document.getElementById("shjdiv1").style.display = "none";
		fisCemeApplyInfoDs.set("thirdTime",date);
		fisCemeApplyInfoDs.set("thirdUnitId",organCode);
		fisCemeApplyInfoDs.set("thirdUnit",organName);
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L40");
	}
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
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
	if(check(record)){
	var win = L5.getCmp("uploadList");
	win.show();
	}
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
	if(actDefName=="公墓撤销审核"){
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L30");
	}else if(actDefName=="公墓撤销审批"){
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L40");
	}else if(actDefName=="省级审批"){
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L40");
	}
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
	win.hide();
}

function closeDownloadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	if(actDefName=="公墓撤销审核"){
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L30");
	}else if(actDefName=="公墓撤销审批"){
		accessoriesDataSet.setParameter("startCode", "L12");
		accessoriesDataSet.setParameter("endCode", "L40");
	}else if(actDefName=="省级审批"){
		accessoriesDataSet.setParameter("startCode", "L21");
		accessoriesDataSet.setParameter("endCode", "L40");
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
