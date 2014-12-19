var cemeId='';//公墓ID
var forCheck= new Array();//检验变更事项用的数组
var changeItemNUM='';
var endCode='';
var changeItem="";

function init(){
	var fisCemeApplyInfoDs =L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var fisCemeChangeDs = L5.DatasetMgr.lookup("fisCemeChangeDs");
	var fisCemeChangeBK = L5.DatasetMgr.lookup("fisCemeChangeBK");
	var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
	var detailds = L5.DatasetMgr.lookup("detailds");
	if(method=="INSERT"){
		fisCemeApplyInfoDs.newRecord();
		fisCemeChangeDs.newRecord();
		fisCemeDataSet.newRecord();
		detailds.newRecord();
		fisCemeApplyInfoDs.set("firstTime",curDay);
		fisCemeApplyInfoDs.set("firstReportTime",curDay);
	}else{
		fisCemeDataSet.setParameter("RECORD_ID@=",recordId);
		fisCemeDataSet.load();
		fisCemeApplyInfoDs.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		fisCemeApplyInfoDs.load();
		fisCemeChangeDs.setParameter("CEME_APPLY_ID@=",cemeApplyId);
		fisCemeChangeDs.load(true);
		changeId=fisCemeChangeDs.get("changeId");
		var detaildsList = L5.DatasetMgr.lookup("detaildsList");
		detaildsList.setParameter("CHANGE_ID@=",changeId);
		detaildsList.load(true);
		for(var i=0;i<detaildsList.getCount();i++){
			forCheck[detaildsList.getAt(i).get("itemCode")]=detaildsList.getAt(i).get("itemCode");
		}
		document.getElementById("img").style.display = "none";
		cemeId=document.getElementById("organId").value;
	}
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", cemeApplyId);
	accessoriesDataSet.setParameter("startCode", "C01");
	if(organType=="13"){
		endCode="C10";
		accessoriesDataSet.setParameter("endCode", endCode);
	}else if(organType=="12"){
		endCode="C20";
		accessoriesDataSet.setParameter("endCode", endCode);
	}else if(organType=="11"){
		endCode="C30";
		accessoriesDataSet.setParameter("endCode", endCode);
	}
	accessoriesDataSet.load(true);
	var tabPanel = L5.getCmp("tabPanel");
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(0);
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
	if(cemeId==''){
		L5.Msg.alert("提示","请先选择要变更的公墓！");
		return;
	}
	if(document.getElementById("select").value=='' || document.getElementById("select").value==null){
		L5.Msg.alert('提示', "县级审核结果不可为空!");
		return ;
	}else if(document.getElementById("firstOpinion").value=='' || document.getElementById("firstOpinion").value==null){
		L5.Msg.alert('提示', "县级审核意见不可为空!");
		return ;
	}else if(document.getElementById("firstTime").value=='' || document.getElementById("firstTime").value==null){
		L5.Msg.alert('提示', "县级审核时间不可为空!");
		return ;
	}

	
	var fisCemeDataSet=L5.DatasetMgr.lookup("fisCemeDataSet");
	var cemeRecord = fisCemeDataSet.getCurrent();
	
	var detaildsList = L5.DatasetMgr.lookup("detaildsList");
	var changeRecordDetail = detaildsList.getAllRecords();
	
	var fisCemeChangeDs=L5.DatasetMgr.lookup("fisCemeChangeDs");
	var changeRecord=fisCemeChangeDs.getCurrent();
	changeRecord.set("changeId",changeId);
	changeRecord.set("cemeApplyId",cemeApplyId);
	changeRecord.set("recordId",recordId);
	changeRecord.set("organId",cemeRecord.get("organId"));
	changeRecord.set("name",cemeRecord.get("name"));
	changeRecord.set("ifConfirm","0");

	//保存业务信息
	var fisCemeApplyInfoDs =L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var applyInfoRecord = fisCemeApplyInfoDs.getCurrent();
	applyInfoRecord.set("cemeApplyId",cemeApplyId);
	applyInfoRecord.set("recordId",recordId);
	applyInfoRecord.set("applyFlag","C");
	applyInfoRecord.set("applyState","0");
	applyInfoRecord.set("curOrganCode",organCode);
	applyInfoRecord.set("curOrgan",organName);
	applyInfoRecord.set("firstUnitId",organCode);
	applyInfoRecord.set("firstUnit",organName);
	applyInfoRecord.set("isReport","4")
	applyInfoRecord.set("fillOrganCode",organCode);
	applyInfoRecord.set("fillOrganName",organName);
	applyInfoRecord.set("curActivity","县级发起");
	
	var command = new L5.Command("com.inspur.cams.fis.change.cmd.FisChangeCmd");
	command.setParameter("changeRecordDetail", changeRecordDetail);
	command.setParameter("changeRecord", changeRecord);
	command.setParameter("applyInfoRecord", applyInfoRecord);
	command.execute("saveFisCemeChangeRecord");
	if (!command.error) {
		method="UPDATE";
		L5.Msg.alert('提示',"保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	var url="jsp/cams/fis/wf/change/fisCemeChangeList.jsp";
	L5.forward(url);
}
function returnBack(){
	history.go(-1);
}
//点击选择公墓后加载
function forCemeSelect(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		//arrs[0] 为公墓编码
		var fisCemeChangeBK = L5.DatasetMgr.lookup("fisCemeChangeBK");
		fisCemeChangeBK.setParameter("RECORD_ID",arrs[2]);
		fisCemeChangeBK.setParameter("IF_CONFIRM","0");
		fisCemeChangeBK.load(true);

		if(fisCemeChangeBK.getCount()!=0){
			L5.Msg.alert("提示","当前公墓已经存在变更任务，请等待任务结束再新添变更申请");
			return false;
		}
		var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
		fisCemeDataSet.setParameter("ORGAN_ID@=",arrs[0]);
		fisCemeDataSet.load();
		cemeId = arrs[0];
		recordId = arrs[2];
	}
}
function openCemeChoose(){
	return window.showModalDialog("../fisCemeInfomation.jsp?manaCode="+organCode+"&prop=2", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}
//点击增加变更按钮
function forAdd(){
	if(cemeId==''){
		L5.Msg.alert("提示","请先选择要变更的公墓！");return;
	}
	var win=L5.getCmp('AddChange');
	win.show();
}
//点击删除变更按钮，删除一条变更
function forDelete(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				L5.Msg.alert("提示","删除成功!",function(){
					var somChangeList = L5.DatasetMgr.lookup("detaildsList");
					for(var i=0;i<forCheck.length;i++){
						if(records[0].get('itemCode')==forCheck[i]){
							forCheck[i]='delete';
						}
					}
					somChangeList.remove(records[0]);
				});
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function onChangeSelect(){
	document.getElementById("select").value=document.getElementById("firstResult").value;
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
	accessoriesDataSet.setParameter("startCode", "C01");
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
	var win = L5.getCmp("downloadList");
	win.hide();
}
//更新所属行政区划信息
function updateSelectManaCode(){
	if (document.getElementById("addChangeItemAll").value!="0"){
		return;	
	}
	var fisOrganCode = organCode.substring(0,4) + "00000000";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCityExt.jsp?radioMaxlevel=3&level=2&isRootSelect=1&organCode="
							+ fisOrganCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	//var record = ds.getCurrent();
	if(revalue!=undefined&&revalue!=""){
		var list = revalue.split(";");//list[0] == areaCode,list[1]==areaName
		//record.set("manaLevelId",list[0]);
		//record.set("manaLevel",list[4]+"民政局");
		//L5.fly('manaLevel').dom.value=list[4]+"民政局";
		document.getElementById("manaLevelIdAll").value=list[0];
		document.getElementById("itemAfterAll").value=list[4]+"民政局";
	}
}
//点击增加变更按钮
function forAddAll(){
	if(cemeId==''){
		L5.Msg.alert("提示","请先选择要变更的公墓！");return;
	}
	var somChangeDataset = L5.DatasetMgr.lookup("detailds");
	somChangeDataset.newRecord();
	var win=L5.getCmp('AddChangeAll');
	win.show();
	document.getElementById('itemBeforeAll').innerHTML="";
	document.forms["formChangeAll"].reset();
	document.getElementById('itemTimeAll').value=curDay;

}
//增加变更整合页面
function forChangeAll(){
	var somChangeDataset = L5.DatasetMgr.lookup("detailds");
	var record=somChangeDataset.getCurrent();
	var itemBefore=document.getElementById('itemBeforeAll').innerHTML;
	var itemAfter=document.getElementById('itemAfterAll').value;
	var itemReason=document.getElementById('itemReasonAll').value;
	var itemTime=document.getElementById('itemTimeAll').value;
	
	if(itemAfter==''){
		L5.Msg.alert("提示","变更后不能为空！");return;
	}
	if(itemReason==''){
		L5.Msg.alert("提示","变更说明不能为空！");return;
	}
	if(itemBefore==itemAfter){
		L5.Msg.alert("提示","当前事项变更前和变更后没有变化！");
		document.getElementById('itemAfterAll').value="";
		return;
	}
	if(itemTime==''){
		L5.Msg.alert("提示","变更时间不能为空！");return;
	}
	record.set('itemCode',changeItem);
	record.set('itemBefore',itemBefore);
	record.set('itemAfter',itemAfter);
	record.set('itemReason',itemReason);
	record.set('itemTime',itemTime);
	if(changeItem=="0"){
		record.set('itemName',document.getElementById("manaLevelIdAll").value);
	}
	var somChangeList = L5.DatasetMgr.lookup("detaildsList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]=Number(changeItem);
	var win=L5.getCmp('AddChangeAll');
	win.hide();
}
function itemChange(){
	changeItem=document.getElementById('addChangeItemAll').value;
	if(!forCheckRepeat(changeItem)){
		document.getElementById("addChangeItemAll").value="";
		document.getElementById('itemBeforeAll').innerHTML="";
		//document.getElementById('itemAfterAll').readOnly=true;
		document.getElementById('itemAfterAll').value="";
		document.getElementById('itemReasonAll').value="";
		document.getElementById('itemTimeAll').value="";
	return;
	}
	
	if(changeItem=="0"){
		document.getElementById('itemBeforeAll').innerHTML=fisCemeDataSet.get('manaLevel');
		document.getElementById('itemAfterAll').readOnly=true;
		document.getElementById('itemAfterAll').value="";
		document.getElementById('itemReasonAll').value="";
		document.getElementById('itemTimeAll').value="";
	}else if(changeItem=="1"){
		document.getElementById('itemAfterAll').readOnly=false;
		document.getElementById('itemBeforeAll').innerHTML=fisCemeDataSet.get('organizer');
		document.getElementById('itemAfterAll').value="";
		document.getElementById('itemReasonAll').value="";
		document.getElementById('itemTimeAll').value="";
	}
//	if(document.getElementById('itemBeforeAll').value)
//	document.getElementById('itemBeforeAll').innerHTML==fisCemeDataSet.get('name');
}
//关闭变更窗口
function closeChangeAll(){
	var win=L5.getCmp('AddChangeAll');
	win.hide();
}
//检查是否重复变更
function forCheckRepeat(number){
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==number){
			L5.Msg.alert("提示","该变更事项已经存在!");
			return false;
		}
	}
	return true;
}