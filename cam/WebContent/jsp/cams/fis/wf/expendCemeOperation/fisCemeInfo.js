	var isJY="0";/*校验通过标识*/
function init(){
	var fisCemeInfoDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	var fisOpinionDataSet=L5.DatasetMgr.lookup("fisOpinionDataSet");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
	//alert(curTime);
	/*
	 * 激活各个标签页
	 */
	var tabPanel = L5.getCmp("tab1");
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	if(method=="insert"){
		fisCemeInfoDataSet.newRecord();
	
		fisCemeApplyInfoDataSet.newRecord();
		fisCemeApplyInfoDataSet.set("cemeApplyId",cemeApplyIdNew);
		fisCemeApplyInfoDataSet.set("applyFlag","E");
		fisCemeApplyInfoDataSet.set("firstUnit",organName);
		fisCemeApplyInfoDataSet.set("recordId",recordIdNew);
		fisCemeApplyInfoDataSet.set("firstUnitId",organCode);
		fisCemeApplyInfoDataSet.set("firstTime",curDay);
		
		fisOpinionDataSet.newRecord();
		fisOpinionDataSet.set("opinionId",opinionIdNew);
		fisOpinionDataSet.set("cemeApplyId",cemeApplyIdNew);
		
		historyDataSet.newRecord();
		historyDataSet.set("hisId",hisIdNew);
		historyDataSet.set("cemeApplyId",cemeApplyIdNew);
		historyDataSet.set("recordId",recordIdNew);
		historyDataSet.set("firstUnit",organName);
		historyDataSet.set("firstUnitId",organCode);
		historyDataSet.set("firstTime",curTime);
		
		accessoriesDataSet.setParameter("startCode","B01");
		accessoriesDataSet.setParameter("endCode","B20");
		accessoriesDataSet.load(true);
		
		fisCemeExpendInfoDataSet.newRecord();
}else if(method=="update"){
		document.getElementById("imgs").style.display = "none";
		fisCemeApplyInfoDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		fisCemeApplyInfoDataSet.load(true);
		
		historyDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		historyDataSet.load(true);
		
		fisOpinionDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		fisOpinionDataSet.load(true);
		
		fisCemeExpendInfoDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDataSet.get("recordId"));
		fisCemeExpendInfoDataSet.load(true);
		
		fisCemeInfoDataSet.setParameter("RECORD_ID@=",fisCemeExpendInfoDataSet.get("cemeId"));
		fisCemeInfoDataSet.load(true);
		
		accessoriesDataSet.setParameter("applayId",cemeApplyId);
		accessoriesDataSet.setParameter("startCode","B01");
		accessoriesDataSet.setParameter("endCode","B20");
		accessoriesDataSet.load(true);
	}else{
	
		fisCemeApplyInfoDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		fisCemeApplyInfoDataSet.load(true);
		
		fisCemeExpendInfoDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDataSet.get("recordId"));
		fisCemeExpendInfoDataSet.load(true);
		
		fisCemeInfoDataSet.setParameter("RECORD_ID@=",fisCemeExpendInfoDataSet.get("cemeId"));
		fisCemeInfoDataSet.load(true);
		
		fisOpinionDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		fisOpinionDataSet.load(true);
		
		if(organType==13){
			document.getElementById("shenHe").style.display = "none";
			document.getElementById("shenPi").style.display = "none";

		}else if(organType==12){
			document.getElementById("shenPi").style.display = "none";
		}
		accessoriesDataSet.setParameter("applayId",cemeApplyId);
		accessoriesDataSet.setParameter("startCode","B01");
		accessoriesDataSet.setParameter("endCode","B40");
		accessoriesDataSet.load(true);
	}
	
	
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function save(){
	jiaoYanIn();
	if (isJY=="1"){
		var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
		var fisOpinionDataSet=L5.DatasetMgr.lookup("fisOpinionDataSet");
		var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
		var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
		
		var validCeme=fisCemeExpendInfoDataSet.isValidate(true);
		var validApply=fisCemeApplyInfoDataSet.isValidate(true);
		var validOpinion=fisOpinionDataSet.isValidate(true);
		
		if((validApply!=true)||(validCeme!=true)||(validOpinion!=true)){
			L5.Msg.alert("提示","校验未通过，不能保存！");
			return false;
		}
		var recordApply=fisCemeApplyInfoDataSet.getCurrent();
		var recordCeme=fisCemeExpendInfoDataSet.getCurrent();
		var recordOpinion=fisOpinionDataSet.getCurrent();
		var recordHistory=historyDataSet.getCurrent();

		recordApply.set("applyState","0");
		recordApply.set("curOrgan",organName);
		recordApply.set("curOrganCode",organCode);
		recordApply.set("isReport","4");

		
		recordHistory.set("firstOpinion",recordApply.get("firstOpinion"));
		recordHistory.set("firstResult",recordApply.get("firstResult"));
		recordHistory.set("firstTime",curTime);
		recordHistory.set("createTime",curTime);
		
		var commandApply=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");

		commandApply.setParameter("recordCeme",recordCeme);
		commandApply.setParameter("recordApply",recordApply);
		commandApply.setParameter("recordOpinion",recordOpinion);
		commandApply.setParameter("recordHistory",recordHistory);
		
		
		if(method=="insert"){
			commandApply.execute("insertAllForExpend");
			
		}else if(method=="update"){
			commandApply.execute("updateAllForExpend");
		}
		if (!commandApply.error){
		L5.Msg.alert("提示","保存成功！",function(){
				returnBack();
			});
		}else{
			L5.Msg.alert("提示","保存出错！"+commandApply.error);
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

function jiaoYan(){
	var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
	var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	var fisOpinionDataSet=L5.DatasetMgr.lookup("fisOpinionDataSet");
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	var validCeme=fisCemeExpendInfoDataSet.isValidate(true);
	var validApply=fisCemeApplyInfoDataSet.isValidate(true);
	var validOpinion=fisOpinionDataSet.isValidate(true);
	
	if((validCeme!=true)||(validApply!=true)||(validOpinion!=true)){
		var tips="";
		if(validApply!=true){tips+=validApply;}
		if(validCeme!=true){tips+=validCeme;}
		if(validOpinion!=true){tips+=validOpinion;}
		L5.Msg.alert("提示","校验未通过:  "+tips);
		return false;
	}
	var totalHoleNum=Number(getValue("planSingleHole"))
					+Number(getValue("planDoubleHole"))
					+Number(getValue("planMoreHole"));
	
	var fundTotalSum=Number(getValue("fundFinance"))
					+Number(getValue("fundHigher"))
					+Number(getValue("fundSelf"))
					+Number(getValue("fundLottery"))
					+Number(getValue("fundOther"));
	
	if(Number(getValue("planSinceHoleNum"))!=Number(totalHoleNum)){
		L5.Msg.alert("提示","输入的计划安葬墓穴数与实际总数不符，请修改后重新输入！",function(){
			return;
		});
		return false;
	} else if(Number(getValue("fundTotal"))!=Number(fundTotalSum)){
		L5.Msg.alert("提示","输入的建设资金合计与实际总数不符，请修改后重新输入！",function(){
			alert(Number(getValue("fundTotal")));
			return;
		});
		return false;
	}else if (Number(getValue("totalArea"))==0||Number(getValue("greenArea"))==0||(Number(getValue("greenArea"))*100/Number(getValue("totalArea"))*0.0015)<40){
		L5.Msg.alert("提示","绿地面积不应低于占地面积的40%！",function(){
			return;
		});
		return false;
	}else if (getValue("greenRatio")<=75){
		L5.Msg.alert("提示","绿化面积必须达到75%！",function(){
			return;
		});
		return false;
	}else{
		L5.Msg.alert("提示","校验成功，可以进行保存！！");
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
	accessoriesDataSet.setParameter("startCode","B01");
	accessoriesDataSet.setParameter("endCode","B20");
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

function getCemeCode(){
	var cemeQueryDataSet=L5.DatasetMgr.lookup("cemeQueryDataSet");
	cemeQueryDataSet.setParameter("PROP@=","2");
	cemeQueryDataSet.setParameter("MANA_LEVEL_ID@=",organCode);
	cemeQueryDataSet.load(true);
	var indexCeme=Number(cemeQueryDataSet.getCount()+1);
	var cemeCodeReturn="";
	if (indexCeme<=10){
		cemeCodeReturn="GZ"+cemeCode+"-0"+indexCeme;
	}else{
		cemeCodeReturn="GZ"+cemeCode+"-"+indexCeme;
	}
	return cemeCodeReturn;	

}
function getTimes(item) {
	LoushangDate(item.previousSibling);
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

//点击选择公墓后加载
function forCemeSelect(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		//arrs[2] 为公墓记录编码
		var queryApplyDs = L5.DatasetMgr.lookup("queryApplyDs");
//		queryApplyDs.setParameter("",);
		queryApplyDs.setParameter("mysetwhere","F.RECORD_ID@=:"+arrs[2]);

		queryApplyDs.setParameter("applyFlag","E");
		queryApplyDs.setParameter("prop","2");
		queryApplyDs.load(true);

		var records = queryApplyDs.getAllRecords();
		for(var i=0;i<records.length;i++){
			if(records[i].get("APPLY_STATE") == "0" || records[i].get("APPLY_STATE") =="2" || records[i].get("APPLY_STATE") =="1"){
				L5.Msg.alert('提示', "当前公墓已经存在正在扩建的业务，请耐心等待.....");
				//history.go(-1);
				return false;
			}
		}
		var fisCemeInfoDataSet = L5.DatasetMgr.lookup("fisCemeInfoDataSet");
		fisCemeInfoDataSet.setParameter("RECORD_ID",arrs[2]);
		fisCemeInfoDataSet.load(true);
		
		var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
		fisCemeExpendInfoDataSet.getCurrent();
		fisCemeExpendInfoDataSet.set("recordId",recordIdNew);
		fisCemeExpendInfoDataSet.set("cemeId",arrs[2]);
		fisCemeExpendInfoDataSet.set("organId",fisCemeInfoDataSet.get("organId"));
		fisCemeExpendInfoDataSet.set("name",fisCemeInfoDataSet.get("name"));
		fisCemeExpendInfoDataSet.set("prop","2");
	}
}
function openCemeChoose(){
	return window.showModalDialog("../fisCemeInfomation.jsp?manaCode="+organCode+"&prop="+"2", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}
