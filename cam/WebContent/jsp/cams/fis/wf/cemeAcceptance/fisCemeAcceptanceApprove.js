function init() {
	var fisCemeApplyInfoDataSet = L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	fisCemeApplyInfoDataSet.setParameter("CEME_APPLY_ID@=", cemeApplyId);
	fisCemeApplyInfoDataSet.load(true);
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
	historyDataSet.newRecord();
	historyDataSet.set("hisId",hisIdNew);
	historyDataSet.set("cemeApplyId",cemeApplyId);
	historyDataSet.set("recordId",fisCemeApplyInfoDataSet.get("recordId"));
	historyDataSet.set("firstUnit",organName);
	historyDataSet.set("firstUnitId",organCode);
	/*
	 *Tab页没有激活 
	 */
	var tabPanel = L5.getCmp("tab1");
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);

	if (actDefName=="市级审核"){
			fisCemeApplyInfoDataSet.set("secondUnitId",organCode);
			fisCemeApplyInfoDataSet.set("secondUnit",organName);
			fisCemeApplyInfoDataSet.set("secondResult","");
			fisCemeApplyInfoDataSet.set("secondOpinion","");
			fisCemeApplyInfoDataSet.set("secondTime",curDay);
			fisCemeApplyInfoDataSet.set("secondReportTime",curDay);

//			document.getElementById("detail").style.display = "block";			
			document.getElementById("shenHe1").style.display = "block";
			document.getElementById("shenHe2").style.display = "none";
			document.getElementById("shenPi1").style.display = "none";
			document.getElementById("shenPi2").style.display = "none";
			document.getElementById("uploadGrid").style.display = "block";
			document.getElementById("zhengdun").style.display="none";
			
			var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
			accessoriesDataSet.setParameter("applayId",cemeApplyId);
			accessoriesDataSet.setParameter("startCode","Y01");
			accessoriesDataSet.setParameter("endCode","Y20");
			accessoriesDataSet.load(true);
						
		}else if (actDefName=="省级审批"){

			fisCemeApplyInfoDataSet.set("thirdUnitId",organCode);
			fisCemeApplyInfoDataSet.set("thirdUnit",organName);
			fisCemeApplyInfoDataSet.set("thirdResult","");
			fisCemeApplyInfoDataSet.set("thirdOpinion","");
			fisCemeApplyInfoDataSet.set("thirdTime",curDay);
			fisCemeApplyInfoDataSet.set("thirdReportTime",curDay);

			
//			document.getElementById("detail").style.display = "block";
			document.getElementById("shenHe1").style.display = "none";
			document.getElementById("shenHe2").style.display = "block";
			document.getElementById("shenPi1").style.display = "block";			
			document.getElementById("shenPi2").style.display = "none";
            document.getElementById("uploadGrid").style.display = "block";
            
            document.getElementById("shengjipifu").style.display="none";
            document.getElementById("shengjipifu2").style.display="none";
            
//            document.getElementById("rectifyDeadline1").style.display= "none";
//            document.getElementById("businessCemeCertificateId1").style.display= "none";

            var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
			accessoriesDataSet.setParameter("applayId",cemeApplyId);
			accessoriesDataSet.setParameter("startCode","Y01");
			accessoriesDataSet.setParameter("endCode","Y30");
			accessoriesDataSet.load(true);
		}
	
}

function save(){
		var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
		var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
		var validCeme=fisCemeInfoDataSet.isValidate(true);
		var validApply=fisCemeApplyInfoDataSet.isValidate(true);
		if((validApply!=true)||(validCeme!=true)){
			L5.Msg.alert("提示","校验未通过:  "+validApply);
			return false;

		}
		var recordApply=fisCemeApplyInfoDataSet.getCurrent();
		var recordCeme=fisCemeInfoDataSet.getCurrent();
		//COM_TIME
		
		var commandCeme=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeInfoCmd");
		var commandApply=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	
		commandCeme.setParameter("record",recordCeme);
		commandApply.setParameter("record",recordApply);
	
		commandCeme.execute("update");
		commandApply.execute("update");
		
		if (!commandApply.error&&!commandCeme.error){
			L5.Msg.alert("提示","保存成功！",function(){
				
			});
		}else{
			L5.Msg.alert("提示","保存出错！"+commandApply.error+commandCeme.error);
		}}
function returnBack(){
	history.go(-1);
}


function submitOn(){
	L5.MessageBox.confirm("提示", "是否确定提交审核意见？",function(sta){
		if(sta=="yes"){
				var submitDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
				var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
				var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");

				var validSubmit=submitDataSet.isValidate(true);
				var result="";
				var opinion="";
				if(validSubmit!=true){	
					return false;
				}
				var recordApply=submitDataSet.getCurrent();
				var recordHistory=historyDataSet.getCurrent();
				var recordCeme=fisCemeInfoDataSet.getCurrent();

				if(organType=="12"){
					result=recordApply.get("secondResult");	
					opinion=recordApply.get("secondOpinion");
					
				}else if(organType=="11"){
					result=recordApply.get("thirdResult");
					opinion=recordApply.get("thirdOpinion");
				}
				if(result==2){
					L5.MessageBox.confirm('确认','取消该验收申请后流程将走向完结，是否继续操作?',function(state){
						if (state=="yes"){
							recordHistory.set("firstOpinion",opinion);
							recordHistory.set("firstResult",result);
							recordHistory.set("firstTime",curTime);
							
							var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
							commandSubmit.setParameter("recordCeme",recordCeme);
							commandSubmit.setParameter("recordHistory",recordHistory);
							commandSubmit.setParameter("recordApply",recordApply);
							commandSubmit.setParameter("result",result);
							commandSubmit.setParameter("assignmentId",assignmentId);
							commandSubmit.execute("sendCemeAcceptance");
							
							if (!commandSubmit.error){
								L5.Msg.alert("提示","已经提交到下一环节！",function(){
									returnBack();
								});
							}else{
								L5.Msg.alert("提示","提交出错，请修改后提交！"+commandSubmit.error);
							}
						}
						else{
							L5.Msg.alert("提示","取消新建申请操作已取消！");
							return;
						}
					});
				}else{
					L5.MessageBox.confirm('确定', '确定要上报此条记录吗?',function(state){
						if (state=="yes"){
							var waitConfig = {
									   interval: 500, 
									   duration: 4000,
									   increment: 5,
									   text: 'Updating...',
									   scope:this,
									   fn:function(){
										   recordHistory.set("firstOpinion",opinion);
											recordHistory.set("firstResult",result);
											recordHistory.set("firstTime",curTime);
											
											var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
											commandSubmit.setParameter("recordCeme",recordCeme);
											commandSubmit.setParameter("recordHistory",recordHistory);
											commandSubmit.setParameter("recordApply",recordApply);
											commandSubmit.setParameter("result",result);
											commandSubmit.setParameter("assignmentId",assignmentId);
											commandSubmit.execute("sendCemeAcceptance");
											
											if (!commandSubmit.error){
												L5.Msg.alert("提示","已经提交到下一环节！",function(){
													returnBack();
												});
											}else{
												L5.Msg.alert("提示","提交出错，请修改后提交！"+commandSubmit.error);
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
			L5.Msg.alert("提示","提交操作被取消！");
			}
		});
}

function boHui(){
	if(document.getElementById("rectifyDeadline1").value==null||document.getElementById("rectifyDeadline1").value==""){
		L5.Msg.alert("提示","整顿截止时间不能为空！");
		return false;
	}
	L5.MessageBox.confirm("提示", "是否确定驳回到下级单位？",function(sta){
		if(sta=="yes"){	
//			L5.Msg.wait("正在保存数据，请等待...", "保存数据");

			var submitDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
			var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
			var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
			var validSubmit=submitDataSet.isValidate(true);
			var opinion="";
			
			if(validSubmit!=true){	
				return false;
			}
			
			var recordApply=submitDataSet.getCurrent();
			var recordHistory=historyDataSet.getCurrent();
			var recordCeme=fisCemeInfoDataSet.getCurrent();
			opinion=recordApply.get("thirdOpinion");
			
			recordHistory.set("firstOpinion",opinion);
			recordHistory.set("firstResult","3");
			recordHistory.set("firstTime",curTime);
			
			var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			commandSubmit.setParameter("recordCeme",recordCeme);
			commandSubmit.setParameter("recordHistory",recordHistory);
			commandSubmit.setParameter("recordApply",recordApply);
			commandSubmit.setParameter("result","3");
			commandSubmit.setParameter("assignmentId",assignmentId);
			commandSubmit.execute("sendCemeAcceptance");
			
			if (!commandSubmit.error){
				L5.Msg.alert("提示","已经驳回到县级！",function(){
					returnBack();
				});
			}else{
				L5.Msg.alert("提示","驳回出错，请修改后重新驳回！");
			}
		}else{
			L5.Msg.alert("提示","驳回操作被取消！");
			}	
	});
}
function select(){
	var url = 'opinionHistory.jsp?cemeApplyId=' + cemeApplyId;

	var width = 1100;
	var height = 600;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	
}

function clickManage() {
	var editGrid = L5.getCmp('uploadGrid');

	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	if(organType=="12"&&record.get("code")!="Y11"){
		L5.Msg.alert('提示', "当前用户只能对市级文件进行维护管理!");
		return false;
	}
	if(organType=="11"&&!(record.get("code")=="Y21"||record.get("code")=="Y22"||record.get("code")=="Y23")){
		L5.Msg.alert('提示', "当前用户只能对省级文件进行维护管理!");
		return false;
	}
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyId);
	accessoriesItemDataSet.load();
	
	var win = L5.getCmp("uploadList");
	win.show();	
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
						var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
						accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
						accessoriesItemDataSet.setParameter("ITEM_ID@=",cemeApplyId);
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
		accessoriesDataSet.setParameter("startCode","Y01");
		if(organType=="12"){
			accessoriesDataSet.setParameter("endCode","Y20");
		}else{
			accessoriesDataSet.setParameter("endCode","Y30");
		}
		accessoriesDataSet.load(true);
		var win = L5.getCmp("uploadList");
		win.hide();
}

function closeDownloadList() {
	
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId",cemeApplyId);	
	accessoriesDataSet.setParameter("startCode","Y01");
	if(organType=="12"){
		accessoriesDataSet.setParameter("endCode","Y20");
	}else{
		accessoriesDataSet.setParameter("endCode","Y30");
	}
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

function show(){
   
   if(document.getElementById("thirdResult").value=="1"){
   document.getElementById("businessCemeCertificateId1").readOnly=false;
   document.getElementById("rectifyDeadline1").readOnly=true;
   document.getElementById("businessCemeCertificateId1Label").disabled=false;
   document.getElementById("rectifyDeadline1Label").disabled=true;
   document.getElementById("img1").disabled=true;
   document.getElementById("rectifyDeadline1").value="";
   document.getElementById("thirdReportNameLabel").disabled=false;
   document.getElementById("thirdReportName").readOnly=false;
   document.getElementById("thirdReportNumberLabel").disabled=false;
   document.getElementById("thirdReportNumber").readOnly=false; 
   document.getElementById("thirdReportTimeLabel").disabled=false;
   document.getElementById("thirdReportTime").readOnly=false;
   document.getElementById("img3").disabled=false;

   
   }else {
	   document.getElementById("businessCemeCertificateId1").value="";
      document.getElementById("businessCemeCertificateId1").readOnly=true;
      document.getElementById("rectifyDeadline1").disabled=false;
      document.getElementById("businessCemeCertificateId1Label").disabled=true;
      document.getElementById("rectifyDeadline1Label").disabled=false;
      document.getElementById("img1").disabled=false;
      document.getElementById("thirdReportNameLabel").disabled=true;
      document.getElementById("thirdReportName").readOnly=true;
      document.getElementById("thirdReportNumberLabel").disabled=true;
      document.getElementById("thirdReportNumber").readOnly=true; 
      document.getElementById("thirdReportTimeLabel").disabled=true;
      document.getElementById("thirdReportTime").readOnly=true;
      document.getElementById("thirdReportName").value="";
      document.getElementById("thirdReportNumber").value="";
      document.getElementById("thirdReportTime").value="";
      document.getElementById("img3").disabled=true;
   }
}
function showSJ(){
	   if(document.getElementById("secondResult").value=="1"){
		   	
		   document.getElementById("secondReportNameLabel").disabled=false;
		   document.getElementById("secondReportName").readOnly=false;
		   document.getElementById("secondReportNumberLabel").disabled=false;
		   document.getElementById("secondReportNumber").readOnly=false; 
		   document.getElementById("secondReportTimeLabel").disabled=false;
		   document.getElementById("secondReportTime").readOnly=false;
		   document.getElementById("img2").disabled=false;
	   
	   }else {
	      document.getElementById("secondReportNameLabel").disabled=true;
	      document.getElementById("secondReportName").readOnly=true;
	      document.getElementById("secondReportNumberLabel").disabled=true;
	      document.getElementById("secondReportNumber").readOnly=true; 
	      document.getElementById("secondReportTimeLabel").disabled=true;
	      document.getElementById("secondReportTime").readOnly=true;
	      document.getElementById("img2").disabled=true;
  	      document.getElementById("secondReportName").value="";
  	      document.getElementById("secondReportNumber").value="";
  	      document.getElementById("secondReportTime").value="";
//	      L5.MessageBox.confirm('', '你确定要删除转报数据吗？', function(sure) {
//	  		if (sure == "yes") {
//	  	      document.getElementById("secondReportName").value="";
//	  	      document.getElementById("secondReportNumber").value="";
//	  	      document.getElementById("secondReportTime").value="";
//	  		}
//	  		else{
//	  			return false;
//	  		}
//	  		});
	     
	}
}