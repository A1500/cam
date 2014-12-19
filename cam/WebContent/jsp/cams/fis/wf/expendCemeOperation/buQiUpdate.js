var isJY="0";/*校验通过标识*/

function init(){
	var fisOpinionDataSet=L5.DatasetMgr.lookup("fisOpinionDataSet");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");

	fisCemeApplyInfoDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
	fisCemeApplyInfoDataSet.load(true);	

	fisCemeExpendInfoDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDataSet.get("recordId"));
	fisCemeExpendInfoDataSet.load(true);
	
	fisCemeInfoDataSet.setParameter("RECORD_ID@=",fisCemeExpendInfoDataSet.get("cemeId"));
	fisCemeInfoDataSet.load(true);
	
	fisOpinionDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
	fisOpinionDataSet.load(true);

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
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);	
	tabPanel.setActiveTab(0);
	if (actDefName=="县级补齐补正"){
	
		fisCemeApplyInfoDataSet.set("firstResult","");
		fisCemeApplyInfoDataSet.set("firstOpinion","");
		fisCemeApplyInfoDataSet.set("firstTime",curDay);
		
		historyDataSet.set("firstUnit",organName);
		historyDataSet.set("firstUnitId",organCode);
		historyDataSet.set("firstTime",curTime);
		
		document.getElementById("BQBZ").style.display = "none";
		document.getElementById("shouLi1").style.display = "block";
		document.getElementById("shouLi").style.display = "none";
		document.getElementById("detail").style.display = "none";
		document.getElementById("xianBuQi").style.display = "block";
		document.getElementById("shenHe1").style.display = "none";
		document.getElementById("shenHe2").style.display = "block";
		document.getElementById("shenPi1").style.display = "none";
		document.getElementById("shenPi2").style.display = "none";
		document.getElementById("uploadGrid").style.display = "block";
		
		var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
		accessoriesDataSet.setParameter("applayId",cemeApplyId);
		accessoriesDataSet.setParameter("startCode","B01");
		accessoriesDataSet.setParameter("endCode","B20");
		accessoriesDataSet.load(true);
				
	}else if (actDefName=="市级补齐补正"){

		fisCemeApplyInfoDataSet.set("secondResult","");
		fisCemeApplyInfoDataSet.set("secondOpinion","");
		fisCemeApplyInfoDataSet.set("secondTime",curDay);
		
		historyDataSet.set("secondUnit",organName);
		historyDataSet.set("secondUnitId",organCode);
		historyDataSet.set("secondTime",curTime);
		
		document.getElementById("BQBZ").style.display = "block";
		document.getElementById("shouLi1").style.display = "none";
		document.getElementById("shouLi").style.display = "block";
		document.getElementById("detail").style.display = "block";
		document.getElementById("xianBuQi").style.display = "none";
		document.getElementById("shenHe1").style.display = "block";
		document.getElementById("shenHe2").style.display = "none";
		document.getElementById("shenPi1").style.display = "none";
		document.getElementById("shenPi2").style.display = "block";
		document.getElementById("uploadGrid").style.display = "block";

		var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
		accessoriesDataSet.setParameter("applayId",cemeApplyId);
		accessoriesDataSet.setParameter("startCode","B01");
		accessoriesDataSet.setParameter("endCode","B30");
		accessoriesDataSet.load(true);
	}

	
}
function save(){
	
	jiaoYanIn();
	if (isJY=="1"){
		var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
		var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
		var validCeme=fisCemeExpendInfoDataSet.isValidate(true);
		var validApply=fisCemeApplyInfoDataSet.isValidate(true);
		if((validApply!=true)||(validCeme!=true)){
			var tips="";
			if(validApply!=true){tips+=validApply;}
			if(validCeme!=true){tips+=validCeme;}
			L5.Msg.alert("提示","校验未通过:  "+tips);
			return false;
		}
		var recordApply=fisCemeApplyInfoDataSet.getCurrent();
		var recordCeme=fisCemeExpendInfoDataSet.getCurrent();
		//COM_TIME
		
		var commandCeme=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeExpendInfoCmd");
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
		}
	}else{
		L5.Msg.alert("提示","没有通过校验不能进行保存！！",function(){
			return;
		});
	}
}
function returnBack(){
	history.go(-1);
}
function submit(){
	L5.MessageBox.confirm("提示", "是否确定提交到上级单位？",function(sta){
		if(sta=="yes"){
			jiaoYanIn();
			var result="";
			if (isJY=="1"){
				var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
				var fisOpinionDataSet=L5.DatasetMgr.lookup("fisOpinionDataSet");
				var submitDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
				var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
				
				var validCeme=fisCemeExpendInfoDataSet.isValidate(true);
				var validOpinion=fisOpinionDataSet.isValidate(true);
				var validSubmit=submitDataSet.isValidate(true);
				if((validSubmit!=true)||(validCeme!=true)||(validOpinion!=true)){
					
					return false;
				}
				var recordApply=submitDataSet.getCurrent();
				var recordHistory=historyDataSet.getCurrent();
				var recordCeme=fisCemeExpendInfoDataSet.getCurrent();
				var recordOpinion=fisOpinionDataSet.getCurrent();
				if(organType=="13"){
					result=recordApply.get("firstResult");
					recordHistory.set("firstOpinion",recordApply.get("firstOpinion"));
					recordHistory.set("firstResult",recordApply.get("firstResult"));
				}else if(organType=="12"){
					result=recordApply.get("secondResult");	
					recordHistory.set("firstOpinion",recordApply.get("secondOpinion"));
					recordHistory.set("firstResult",recordApply.get("secondResult"));
				}
				if(result==2){
					L5.MessageBox.confirm('确认','取消该新建申请后流程将走向完结，是否继续操作?',function(state){
						if (state=="yes"){
							recordHistory.set("firstTime",curTime);
							var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
							
							commandSubmit.setParameter("recordCeme",recordCeme);
							commandSubmit.setParameter("recordOpinion",recordOpinion);
							commandSubmit.setParameter("recordApply",recordApply);
							commandSubmit.setParameter("recordHistory",recordHistory);
							commandSubmit.setParameter("result",result);
							commandSubmit.setParameter("assignmentId",assignmentId);
						
							commandSubmit.execute("sendOfExpendOpBQ");
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
										   recordHistory.set("firstTime",curTime);
											var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
											
											commandSubmit.setParameter("recordCeme",recordCeme);
											commandSubmit.setParameter("recordOpinion",recordOpinion);
											commandSubmit.setParameter("recordApply",recordApply);
											commandSubmit.setParameter("recordHistory",recordHistory);
											commandSubmit.setParameter("result",result);
											commandSubmit.setParameter("assignmentId",assignmentId);
										
											commandSubmit.execute("sendOfExpendOpBQ");
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
				L5.Msg.alert("提示","没有通过校验不能进行保存！！",function(){
					return;
				});
			}
		}else{
			L5.Msg.alert("提示","提交操作被取消！");
			}
		});
}
function setGreen(){
	var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	var GreenRatio="";
	if (getValue("totalArea")!=0&&getValue("greenArea")!=0)
		{
			GreenRatio=Number(getValue("greenArea"))*100/Number(getValue("totalArea"));
			fisCemeInfoDataSet.set("greenRatio",GreenRatio.toFixed(2));
			return true;
		}else{
			return 0;
		}
}

function getValue(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value==""||value==undefined){
		return 0;
	}else{
		return value;
	}
	
}
function jiaoYanIn(){
	var totalHoleNum=Number(getValue("planSingleHole"))
					+Number(getValue("planDoubleHole"))
					+Number(getValue("planMoreHole"));
	var fundTotalSum=Number(getValue("fundFinance"))
					+Number(getValue("fundHigher"))
					+Number(getValue("fundSelf"))
					+Number(getValue("fundLottery"))
					+Number(getValue("fundOther"));
	
	if(Number(getValue("planSinceHoleNum"))!=Number(totalHoleNum)){
		isJY="0";
		
	} else if(Number(getValue("fundTotal"))!=Number(fundTotalSum)){
		isJY="0";
	}else if (Number(getValue("totalArea"))==0||Number(getValue("greenArea"))==0||(Number(getValue("greenArea"))*100/Number(getValue("totalArea"))*0.0015)<40){
		isJY="0";
	}else if (getValue("greenRatio")<=75){
		isJY="0";
	}else{
		isJY="1";
	}
}
function select(){

	var url = 'opinionHistory.jsp?cemeApplyId=' + cemeApplyId;
	var width = 1200;
	var height = 800;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function boHuiBQ(){
	L5.MessageBox.confirm("提示", "是否确定驳回到下级单位？",function(sta){
			if(sta=="yes"){
			var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
			var fisOpinionDataSet=L5.DatasetMgr.lookup("fisOpinionDataSet");
			var submitDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
			var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
			
			var validCeme=fisCemeExpendInfoDataSet.isValidate(true);
			var validOpinion=fisOpinionDataSet.isValidate(true);
			var validSubmit=submitDataSet.isValidate(true);
			if(validSubmit!=true){	
				return false;
			}
			var recordApply=submitDataSet.getCurrent();
			var recordHistory=historyDataSet.getCurrent();
			var recordCeme=fisCemeExpendInfoDataSet.getCurrent();
			var recordOpinion=fisOpinionDataSet.getCurrent();
			if(organType=="13"){
				recordHistory.set("firstOpinion",recordApply.get("firstOpinion"));
				recordHistory.set("firstResult","3");
			}else if(organType=="12"){
				recordHistory.set("firstOpinion",recordApply.get("secondOpinion"));
				recordHistory.set("firstResult","3");
			}
			recordHistory.set("firstTime",curTime);
			var commandSubmit=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			
			commandSubmit.setParameter("recordCeme",recordCeme);
			commandSubmit.setParameter("recordOpinion",recordOpinion);
			commandSubmit.setParameter("recordApply",recordApply);
			commandSubmit.setParameter("recordHistory",recordHistory);
			commandSubmit.setParameter("result","3");
			commandSubmit.setParameter("assignmentId",assignmentId);
			
			commandSubmit.execute("sendOfExpendOpBQ");
			if (!commandSubmit.error){
				L5.Msg.alert("提示","已经驳回到下一环节！",function(){
					returnBack();
				});
			}else{
				L5.Msg.alert("提示","驳回出错，请修改后驳回！"+commandSubmit.error);
			}
		}else{
			L5.Msg.alert("提示","驳回操作被取消！");
		}
	});
}


function clickManage() {
	var editGrid = L5.getCmp('uploadGrid');

	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	if(organType=="12"&&record.get("code")!="B21"){
		L5.Msg.alert('提示', "当前用户只能对市级文件进行维护管理!");
		return false;
	}else if(organType=="13"&&(record.get("code")=="B21 "||record.get("code")=="B31")){
		L5.Msg.alert('提示', "当前用户只能对县级上报文件进行维护管理!");
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
		accessoriesDataSet.setParameter("startCode","B01");
		if(organType=="12"){
			accessoriesDataSet.setParameter("endCode","B30");
		}else{
			accessoriesDataSet.setParameter("endCode","B20");
		}
		accessoriesDataSet.load(true);
		var win = L5.getCmp("uploadList");
		win.hide();
}

function closeDownloadList() {
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId",cemeApplyId);	
	accessoriesDataSet.setParameter("startCode","B01");
	if(organType=="12"){
		accessoriesDataSet.setParameter("endCode","B30");
	}else{
		accessoriesDataSet.setParameter("endCode","B20");
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

