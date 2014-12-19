var endCode='';
function init(){
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeApplyInfoDs.load(true);
	var cemeRecord = fisCemeApplyInfoDs.getCurrent();
	var recordId = cemeRecord.get("recordId");
	var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
	fisCemeDataSet.setParameter("RECORD_ID",recordId);
	fisCemeDataSet.load(true);
	
	var fisCemeChangeDataSet=L5.DatasetMgr.lookup("fisCemeChangeDataSet");
	fisCemeChangeDataSet.setParameter("CEME_APPLY_ID",cemeApplyId);
	fisCemeChangeDataSet.load(true);
	
	var detaildsList = L5.DatasetMgr.lookup("detaildsList");
	detaildsList.setParameter("CHANGE_ID@=",fisCemeChangeDataSet.getCurrent().get("changeId"));//document.getElementById("changeId").value);
	detaildsList.load();

	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "C41");
	if(organType=="14"){
		endCode="C50";
		accessoriesDataSet.setParameter("endCode", endCode);
		fisCemeApplyInfoDs.set("zeroTime",curDay);
	}else if(organType=="13"){
		endCode="C60";
		accessoriesDataSet.setParameter("endCode", endCode);
		fisCemeApplyInfoDs.set("firstTime",curDay);
		fisCemeApplyInfoDs.set("firstReportTime",curDay);
	}
	accessoriesDataSet.load(true);
	var tabPanel = L5.getCmp("TabPanel");
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	setHide();			
}
function send() {
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeApplyRecord=fisCemeApplyInfoDs.getCurrent();
	var opinion="";
	if(actDefName=="乡镇补齐补正"){
		
		if(document.getElementById("select").value=='' || document.getElementById("select").value==null){
				L5.Msg.alert('提示', "乡镇审批结果不可为空!");
				return ;
			}else if(document.getElementById("zeroOpinion").value=='' || document.getElementById("zeroOpinion").value==null){
				L5.Msg.alert('提示', "乡镇审批意见不可为空!");
				return ;
			}else if(document.getElementById("zeroTime").value=='' || document.getElementById("zeroTime").value==null){
				L5.Msg.alert('提示', "乡镇审批时间不可为空!");
				return ;
			}
	}else{
		if(document.getElementById("select").value=='' || document.getElementById("select").value==null){
			L5.Msg.alert('提示', "县级审批结果不可为空!");
			return ;
		}else if(document.getElementById("firstOpinion").value=='' || document.getElementById("firstOpinion").value==null){
			L5.Msg.alert('提示', "县级审批意见不可为空!");
			return ;
		}else if(document.getElementById("firstTime").value=='' || document.getElementById("firstTime").value==null){
			L5.Msg.alert('提示', "县级审批时间不可为空!");
			return ;
		}
		
	}
	if(actDefName=="县级审批"){
		opinion = fisCemeApplyRecord.get("firstResult");
		fisCemeApplyRecord.set("firstUnitId",organCode);
		fisCemeApplyRecord.set("firstUnit",organName);
		
	}else if(actDefName=="乡镇补齐补正"){
		opinion = fisCemeApplyRecord.get("zeroResult");
		fisCemeApplyRecord.set("zeroUnitId",organCode);
		fisCemeApplyRecord.set("zeroUnit",organName);
	}
	L5.MessageBox.confirm('确定', '确定要上报此条记录吗?',function(state){
		if (state=="yes"){
			var waitConfig = {
					   interval: 500, 
					   duration: 4000,
					   increment: 5,
					   text: 'Updating...',
					   scope:this,
					   fn:function(){
						   var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
							command.setParameter("record", fisCemeApplyRecord);
							command.setParameter("assignmentId",assignmentId);
							command.setParameter("opinion",opinion);
							command.execute("sendPublicChange");
							if(!command.error){
								L5.Msg.alert("提示","成功提交至下一环节!",function(){
									goBack();
								});
							}else{
								L5.Msg.alert('提示',"提交时出现错误！"+command.error);
							}
					   }
					};
					L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);				
		}else {
			return false;
		}
	
	});
	

}
//驳回至乡镇补齐补正
function buQi() {
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeApplyRecord=fisCemeApplyInfoDs.getCurrent();
	if(actDefName=="县级审批"){
		if(document.getElementById("select").value=='' || document.getElementById("select").value==null){
				L5.Msg.alert('提示', "县级审批结果不可为空!");
				return ;
			}else if(document.getElementById("firstOpinion").value=='' || document.getElementById("firstOpinion").value==null){
				L5.Msg.alert('提示', "县级审批意见不可为空!");
				return ;
			}else if(document.getElementById("firstTime").value=='' || document.getElementById("firstTime").value==null){
				L5.Msg.alert('提示', "县级审批时间不可为空!");
				return ;
			}
	}
	if(actDefName=="县级审批"){
		fisCemeApplyRecord.set("firstUnitId",organCode);
		fisCemeApplyRecord.set("firstUnit",organName);
	}
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	command.setParameter("record", fisCemeApplyRecord);
	command.setParameter("assignmentId",assignmentId);
	command.setParameter("opinion","3");
	command.execute("sendPublicChange");
	if(!command.error){
		L5.Msg.alert("提示","成功驳回至下级单位！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
	
	//var url="jsp/cams/fis/wf/change/fisCemeChangeApprove.jsp?actId="+actId;
	//L5.forward(url);
}
//function fillOption(obj){
//	for(i=0;i<obj.length;i++){
//		   if(obj[i].selected==true){
//			   obj.parentNode.parentNode.nextSibling.childNodes[1].childNodes[0].value=obj[i].innerText; 
//		   }
//		}
//}
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
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d.getDate() == r[2]);
}
function setHide(){
	if(actDefName=="县级审批"){
		document.getElementById("shenPidiv1").style.display = "block";
		document.getElementById("shenPidiv2").style.display = "none";
		document.getElementById("xjdiv").style.display = "block";
		document.getElementById("xjdiv2").style.display = "none";

	}else if(actDefName=="乡镇补齐补正"){
		document.getElementById("shenPidiv1").style.display = "none";
		document.getElementById("shenPidiv2").style.display = "block";
		document.getElementById("xjdiv").style.display = "none";
		document.getElementById("xjdiv2").style.display = "block";
		document.getElementById("buQi").style.display = "none";


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
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyId);
	accessoriesItemDataSet.load();
	if(record.get("code").substr(1,1)==endCode.substr(1,1)-1){
		var win = L5.getCmp("uploadList");
		win.show();
	}else{
		L5.Msg.alert('提示', "非本级附件材料上传类型!");
		return false;
	}
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
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "C41");
	accessoriesDataSet.setParameter("endCode", endCode);
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
function clickDownloadFile(){
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
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "C41");
	accessoriesDataSet.setParameter("endCode", endCode);
	accessoriesDataSet.load(true);
	var win = L5.getCmp("downloadList");
	win.hide();
}
function onChangeSelectF(){
	document.getElementById("select").value=document.getElementById("firstResult").value;
}
function onChangeSelectZ(){
	document.getElementById("select").value=document.getElementById("zeroResult").value;
}