var isJY="";
function init(){
	//新建业务记录
	var tabPanel = L5.getCmp("tabPanel");
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
	
	var fisCemeApplyInfoDs =L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeDataSet=L5.DatasetMgr.lookup("fisCemeDataSet");
	var accessoriesDataSet=L5.DatasetMgr.lookup("accessoriesDataSet");
	if(method=="insert"){
		
			fisCemeApplyInfoDs.newRecord({
				"cemeApplyId" : cemeApplyIdNew,
				"applyFlag" : "Y",
				"firstTime" : date,
				//县级第一次上报得同意，1：同意，2：不同意
				"firstResult" : "1",
				"firstUnitId" : organCode,
				"firstUnit" : organName,
			    "curOrganCode" : organCode,
			    "curOrgan" : organName,
			    "fillOrganName" : organName,
			    "fillOrganCode" : organCode,
			    "curActivity" : "市级发起",
			    "applyState" : "0",
			    "curOrganCode" : organCode,
			    "curOrgan" : organName,
			    "firstUnitId" : organCode,
			    "firstUnit" : organName,
			    "isReport" : "10"
			});
			
			historyDataSet.newRecord({
			"hisId" : hisId, 
			"cemeApplyId" : cemeApplyIdNew,
			"createTime" : time,
	        "recordId" : recordId,
		    "firstUnit" : organName,
		    "firstUnitId" : organCode,
		    "firstTime" : time
		});
			
		fisCemeDataSet.newRecord();
		accessoriesDataSet.setParameter("startCode","Y02");
		accessoriesDataSet.setParameter("endCode","Y20");
		accessoriesDataSet.load(true);

		var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
		fisCemeExpendInfoDataSet.newRecord();
		document.getElementById("form2").style.display = "none";	
		document.getElementById("form3").style.display = "none";
	}else if(method=="update"){
		document.getElementById("CemeSelect").style.display = "none";
		fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID",cemeApplyId);
		fisCemeApplyInfoDs.load(true);
		historyDataSet.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		historyDataSet.load(true);
		var fisCemeExpendInfoDataSet= L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
		fisCemeExpendInfoDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDs.get("recordId"));
		fisCemeExpendInfoDataSet.load(true);
		if(!fisCemeExpendInfoDataSet.getCount()){	
			document.getElementById("form2").style.display = "block";	
			document.getElementById("form3").style.display = "none";
			fisCemeDataSet.setParameter("RECORD_ID@=",fisCemeApplyInfoDs.get("recordId"));
			fisCemeDataSet.load(true);
		}else {
			document.getElementById("form3").style.display = "block";	
			document.getElementById("form2").style.display = "none";
			fisCemeDataSet.setParameter("RECORD_ID@=",fisCemeExpendInfoDataSet.get("cemeId"));
			fisCemeDataSet.load(true);
			
		}
		accessoriesDataSet.setParameter("applayId",cemeApplyId);
		accessoriesDataSet.setParameter("startCode","Y02");
		accessoriesDataSet.setParameter("endCode","Y20");
		accessoriesDataSet.load(true);
	}
//	document.getElementById("form2").style.display = "none";
//	document.getElementById("form3").style.display = "block";
	
	
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}
function query(){
	var fisCemeDataSet=L5.DatasetMgr.lookup("fisCemeDataSet");
	fisCemeDataSet.setParameter("MANA_LEVEL_ID",organCode);
	fisCemeDataSet.setParameter("PROP","2");
	fisCemeDataSet.setParameter("NAME@like",document.getElementById("cemeNameQuery").value);
	fisCemeDataSet.load();
}
function save(){
	var fisCemeApplyInfoDs =L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var applyInfoRecord = fisCemeApplyInfoDs.getCurrent();
	
	var historyDataSet=L5.DatasetMgr.lookup("historyDataSet");
	var historyRecord=historyDataSet.getCurrent();
	
	var fisCemeDataSet=L5.DatasetMgr.lookup("fisCemeDataSet");
	var cemeRecord = fisCemeDataSet.getCurrent();
	var validApply=fisCemeApplyInfoDs.isValidate(true);
	
	if(validApply!=true){
		L5.Msg.alert("提示","校验未通过:  "+validApply);
		return false;
	}

	if(cemeRecord.get("organState")=="4"){
		var validCeme=fisCemeDataSet.isValidate(true);
		if(validCeme!=true){
			L5.Msg.alert("提示","校验未通过:  "+validCeme);
			return false;
		}
		
		var cmd = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	    cmd.setParameter("cemeRecord",cemeRecord);
	    cmd.setParameter("applyInfoRecord",applyInfoRecord);
	    cmd.setParameter("historyRecord",historyRecord);
		if(!jiaoYan()){
			return false;
		}
		if(isJY=="1"){
	    if(method=="insert"){
		   cmd.execute("insertAcceptance");
		}else if(method=="update"){
		 
		 cmd.execute("updateAcceptance");
		}
		if (!cmd.error) {
			
				L5.Msg.alert('提示',"保存成功！",function(){
					returnBack();
				});

		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+cmd.error);
		}
		}else{
			L5.Msg.alert('提示',"校验未通过，不能保存！");
			return ;
		}
	}else if(cemeRecord.get("organState")=="6"){
		var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
		var recordExpend=fisCemeExpendInfoDataSet.getCurrent();
		
		var validCemeExpend=fisCemeExpendInfoDataSet.isValidate(true);
		if(validCemeExpend!=true){
			L5.Msg.alert("提示","校验未通过:  "+validCemeExpend);
			return false;
		}
//		recordExpend.set("recordId",recordIdNew);
//		applyInfoRecord.set("recordId",recordExpend.get("recordId"));
		var cmd = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	    cmd.setParameter("cemeRecord",recordExpend);
	    cmd.setParameter("applyInfoRecord",applyInfoRecord);
	    cmd.setParameter("historyRecord",historyRecord);
		if(!jiaoYanExpend()){
			return false;
		}
		if(isJY=="1"){
	    if(method=="insert"){
		   cmd.execute("insertAcceptanceForExpend");
		}else if(method=="update"){
		 cmd.execute("updateAcceptanceForExpend");
		}
		if (!cmd.error) {
			
			L5.Msg.alert('提示',"保存成功！",function(){
				returnBack();
			});
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+cmd.error);
		}
		}else{
			L5.Msg.alert('提示',"校验未通过，不能保存！");
			return ;
		}
	}

}

function jiaoYan(){

	var sinceHoleNum=Number(getValue("singleHole"))
					+Number(getValue("doubleHole"))
					+Number(getValue("moreHole"));
		
	if(Number(getValue("sinceHoleNum"))!=Number(sinceHoleNum)){
		L5.Msg.alert("提示","输入的实际安葬墓穴数合计与实际总数不符，请修改后重新输入！",function(){
			isJY="0";
			return false;
		});
	}else{
		isJY="1";
		L5.Msg.alert("提示","校验成功，可以进行保存！！");
		return true;
	}
}
function jiaoYanExpend(){

	var sinceHoleNum=Number(getValue("E_singleHole"))
					+Number(getValue("E_doubleHole"))
					+Number(getValue("E_moreHole"));
		
	if(Number(getValue("E_sinceHoleNum"))!=Number(sinceHoleNum)){
		L5.Msg.alert("提示","输入的实际安葬墓穴数合计与实际总数不符，请修改后重新输入！",function(){
			isJY="0";
			return false;
		});
	}else{
		isJY="1";
		L5.Msg.alert("提示","校验成功，可以进行保存！！");
		return true;
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

function returnBack(){
	history.go(-1);
}
//点击选择公墓后加载
function forCemeSelect(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		//arrs[2] 为公墓记录编码
		var fisCemeApplyInfoBK = L5.DatasetMgr.lookup("fisCemeApplyInfoBK");
		var fisCemeApplyInfoDs =L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
		var recordApply=fisCemeApplyInfoDs.getCurrent();

		var queryCeme = L5.DatasetMgr.lookup("queryCeme");
		queryCeme.setParameter("RECORD_ID",arrs[2]);
		queryCeme.load(true);
		if(queryCeme.get("organState")=="4"){
			fisCemeApplyInfoBK.setParameter("RECORD_ID",arrs[2]);
			fisCemeApplyInfoBK.setParameter("APPLY_FLAG","Y");
			fisCemeApplyInfoBK.load(true);
			var records = fisCemeApplyInfoBK.getAllRecords();
			for(var i=0;i<records.length;i++){
				if(records[i].get("applyState") == "0" || records[i].get("applyState") =="2"|| records[i].get("applyState") =="1"){
					L5.Msg.alert('提示', "当前公墓已经存在正在验收的业务，请耐心等待.....");
					//history.go(-1);
					return false;
				}
			}
			
			var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
			fisCemeDataSet.setParameter("RECORD_ID",arrs[2]);
			fisCemeDataSet.load(true);
			recordApply.set("recordId",fisCemeDataSet.get("recordId"));

			document.getElementById("form2").style.display = "block";
			document.getElementById("form3").style.display = "none";
				
		}else if(queryCeme.get("organState")=="6"){			
			
			var queryExpend=L5.DatasetMgr.lookup("queryExpend");
			queryExpend.setParameter("CEME_ID",queryCeme.get("recordId"));
			queryExpend.setParameter("ORGAN_STATE","6");
			queryExpend.load(true);
			
			fisCemeApplyInfoBK.setParameter("RECORD_ID",queryExpend.get("recordId"));
			fisCemeApplyInfoBK.setParameter("APPLY_FLAG","Y");
			fisCemeApplyInfoBK.load(true);
			var records = fisCemeApplyInfoBK.getAllRecords();
			
			for(var i=0;i<records.length;i++){
				if(records[i].get("applyState") == "0" || records[i].get("applyState") =="2"|| records[i].get("applyState") =="1"){
					L5.Msg.alert('提示', "当前公墓已经存在正在验收的业务，请耐心等待.....");
					return false;
				}
			}
			var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
			fisCemeDataSet.setParameter("RECORD_ID",arrs[2]);
			fisCemeDataSet.load(true);
			//document.getElementById("form2").style.display = "block";
			//document.getElementById("form3").style.display = "none";
			var fisCemeExpendInfoDataSet=L5.DatasetMgr.lookup("fisCemeExpendInfoDataSet");
			fisCemeExpendInfoDataSet.setParameter("CEME_ID",fisCemeDataSet.get("recordId"));
			fisCemeExpendInfoDataSet.setParameter("ORGAN_STATE","6");
			fisCemeExpendInfoDataSet.load(true);
			recordApply.set("recordId",fisCemeExpendInfoDataSet.get("recordId"));

			document.getElementById("form2").style.display = "none";
			document.getElementById("form3").style.display = "block";
		}
	}
}
function openCemeChoose(){
	return window.showModalDialog("../fisCemeInfomation.jsp?manaCode="+organCode+"&prop=2"+"&isYs=1", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}

function onChangeSelect(){
	document.getElementById("select").value=document.getElementById("firstResult").value;
	show();
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
	accessoriesItemDataSet.setParameter("ITEM_ID@=",(cemeApplyId=="null")? cemeApplyIdNew:cemeApplyId);
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
	command.setParameter("applyId", (cemeApplyId=="null") ? cemeApplyIdNew : cemeApplyId);
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
						accessoriesItemDataSet.setParameter("ITEM_ID@=", (cemeApplyId=="null")? cemeApplyIdNew : cemeApplyId);
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
	accessoriesDataSet.setParameter("startCode", "Y02");
	accessoriesDataSet.setParameter("endCode", "Y20");
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
	accessoriesItemDataSet.setParameter("ITEM_ID@=", cemeApplyIdNew);
	accessoriesItemDataSet.load();
	var win = L5.getCmp("downloadList");
	win.show();
}
function closeDownloadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", (cemeApplyId == "null") ? cemeApplyIdNew : cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "Y02");
	accessoriesDataSet.setParameter("endCode", "Y20");
	accessoriesDataSet.load(true);
	var win = L5.getCmp("downloadList");
	win.hide();
}
function show(){
	   
	   if(document.getElementById("firstResult").value=="1"){
	   document.getElementById("firstReportNameLabel").disabled=false;
	   document.getElementById("firstReportName").readOnly=false;
	   document.getElementById("firstReportNumberLabel").disabled=false;
	   document.getElementById("firstReportNumber").readOnly=false; 
	   document.getElementById("firstReportTimeLabel").disabled=false;
	   document.getElementById("firstReportTime").readOnly=false;
	   document.getElementById("img1").disabled=false;
	   
	   }else { 
		   document.getElementById("firstReportNameLabel").disabled=true;
		   document.getElementById("firstReportName").readOnly=true;
		   document.getElementById("firstReportNumberLabel").disabled=true;
		   document.getElementById("firstReportNumber").readOnly=true; 
		   document.getElementById("firstReportTimeLabel").disabled=true;
		   document.getElementById("firstReportTime").readOnly=true;
		   document.getElementById("img1").disabled=true;
	   }
	}
