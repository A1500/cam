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
		fisCemeApplyInfoDs.set("zeroTime",curDay);
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
	accessoriesDataSet.setParameter("startCode", "C41");
	if(organType=="14"){
		endCode="C50";
		accessoriesDataSet.setParameter("endCode", endCode);
	}else if(organType=="13"){
		endCode="C60";
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
	fisCemeDataSet.setParameter("PROP","1");
	fisCemeDataSet.setParameter("NAME@like",document.getElementById("cemeNameQuery").value);
	fisCemeDataSet.load();
}
function save(){
	if(cemeId==''){
		L5.Msg.alert("提示","请先选择要变更的公墓！");
		return;
	}
	if(document.getElementById("select").value=='' || document.getElementById("select").value==null){
		L5.Msg.alert('提示', "乡镇审核结果不可为空!");
		return ;
	}else if(document.getElementById("zeroOpinion").value=='' || document.getElementById("zeroOpinion").value==null){
		L5.Msg.alert('提示', "乡镇审核意见不可为空!");
		return ;
	}else if(document.getElementById("zeroTime").value=='' || document.getElementById("zeroTime").value==null){
		L5.Msg.alert('提示', "乡镇审核时间不可为空!");
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
	applyInfoRecord.set("zeroUnitId",organCode);
	applyInfoRecord.set("zeroUnit",organName);
	applyInfoRecord.set("isReport","5")
	applyInfoRecord.set("fillOrganCode",organCode);
	applyInfoRecord.set("fillOrganName",organName);
	applyInfoRecord.set("curActivity","乡镇发起");
	
	var command = new L5.Command("com.inspur.cams.fis.change.cmd.FisChangeCmd");
	command.setParameter("changeRecordDetail", changeRecordDetail);
	command.setParameter("changeRecord", changeRecord);
	command.setParameter("applyInfoRecord", applyInfoRecord);
	command.execute("saveFisCemeChangeRecord");
	if (!command.error) {
		//method="UPDATE";
		L5.Msg.alert('提示',"保存成功！");
		returnBack()
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	//var url="jsp/cams/fis/wf/change/publicChange/publicCemeChangeEdit.jsp";
	//L5.forward(url);
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
	return window.showModalDialog("../../fisCemeInfomation.jsp?manaCode="+organCode+"&prop=1", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
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
//选择完变更项目后点击确定
function forChangeItem(num){
		if(num == ""){
			L5.Msg.alert("提示","请选择变更事项!");return;
		}
		if(!forCheckRepeat(num)){
			return;
		}
		var win=L5.getCmp('AddChange');
		win.hide();	
		var somChangeDataset = L5.DatasetMgr.lookup("detailds");
		somChangeDataset.newRecord();
		if(num=='0'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('manaLevelName').innerHTML='主管单位';
			document.getElementById('manaLevelBefore').innerHTML=fisCemeDataSet.get('manaLevel');
			document.getElementById('manaLevelAfter').value="";
			document.getElementById('manaLevelReason').value="";
			document.getElementById('manaLevelTime').value="";
		}else if(num=='1'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('organizerName').innerHTML='主办单位';
			document.getElementById('organizerBefore').innerHTML=fisCemeDataSet.get('organizer');
			document.getElementById('organizerAfter').value="";
			document.getElementById('organizerReason').value="";
			document.getElementById('organizerTime').value="";
		}
		changeItemNUM=num;
	}
	//检查是否重复变更
function forCheckRepeat(number){
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==number){
			L5.Msg.alert("提示","该变更事项已经存在!");return false;
		}	
	}
	return true;
}
//主管单位变更保存
function forManaLevelMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("detailds");
	var record=somChangeDataset.getCurrent();
	var itemBefore=document.getElementById('manaLevelBefore').innerHTML;
	var itemAfter=document.getElementById('manaLevelAfter').value;
	var itemReason=document.getElementById('manaLevelReason').value;
	var itemTime=document.getElementById('manaLevelTime').value;
	if(itemAfter==''){
		L5.Msg.alert("提示","变更后不能为空！");return;
	}
	if(itemReason==''){
		L5.Msg.alert("提示","变更说明不能为空！");return;
	}
	if(itemTime==''){
		L5.Msg.alert("提示","变更时间不能为空！");return;
	}
	record.set('itemCode','0');
	record.set('itemName',document.getElementById("manaLevelId").value);
	
	record.set('itemBefore',itemBefore);
	record.set('itemAfter',itemAfter);
	record.set('itemReason',itemReason);
	record.set('itemTime',itemTime);
	var somChangeList = L5.DatasetMgr.lookup("detaildsList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='0';
	var win=L5.getCmp('AddChange0');
	win.hide();
}
//主办单位变更保存
function forOrganizerMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("detailds");
	var record=somChangeDataset.getCurrent();
	var itemBefore=document.getElementById('organizerBefore').innerHTML;
	var itemAfter=document.getElementById('organizerAfter').value;
	var itemReason=document.getElementById('organizerReason').value;
	var itemTime=document.getElementById('organizerTime').value;
	if(itemAfter==''){
		L5.Msg.alert("提示","变更后不能为空！");return;
	}
	if(itemReason==''){
		L5.Msg.alert("提示","变更说明不能为空！");return;
	}
	if(itemTime==''){
		L5.Msg.alert("提示","变更时间不能为空！");return;
	}
	record.set('itemCode','1');
	record.set('itemBefore',itemBefore);
	record.set('itemAfter',itemAfter);
	record.set('itemReason',itemReason);
	record.set('itemTime',itemTime);
	var somChangeList = L5.DatasetMgr.lookup("detaildsList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='1';
	var win=L5.getCmp('AddChange1');
	win.hide();
}
//关闭变更窗口
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeItemNUM);
	win.hide();
}
function onChangeSelect(){
	document.getElementById("select").value=document.getElementById("zeroResult").value;
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
	
	var win = L5.getCmp("downloadList");
	win.hide();
}
//更新所属行政区划信息
function updateSelectDeptCode(){
	var fisOrganCode = organId.substr(0, 4) + "00000000";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCityExt.jsp?radioMaxlevel=2&level=3&organCode="
							+ fisOrganCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	var record = ds.getCurrent();
	if(revalue!=undefined&&revalue!=""){
		var list = revalue.split(";");//list[0] == areaCode,list[1]==areaName
		record.set("deptCode",list[0]);
		record.set("deptName",list[4]);
		L5.fly('deptName').dom.value=list[4];
	}
	if(organID=="null"){
		var organId$ = "GZ"+record.get("deptCode").substr(0, 9)+"-";
		var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisMaxOrganIdCmd"); 
		command.setParameter("organId", organId$);
		command.execute("query");
		var maxId=command.getReturn("organId");
		var organId_=null;
		if(maxId==null){
			organId_ = organId$+"01";
		}else{
			var max = parseFloat(maxId.substr(12, 2));
			max+=1;
			if(max>9){
				organId_ = organId$+max;
			}else{
				organId_ = organId$+"0"+max;
			}
		}
		document.getElementById("organId").value=organId_;
		ds.set("organId",organId_);
	}
}
/*//更新所属行政区划信息
function updateSelectManaCode(){
	var fisOrganCode = organCode.substr(0, 2) + "0000000000";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCityExt.jsp?radioMaxlevel=1&level=2&isRootSelect=1&organCode="
							+ fisOrganCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	//var record = ds.getCurrent();
	if(revalue!=undefined&&revalue!=""){
		var list = revalue.split(";");//list[0] == areaCode,list[1]==areaName
		//record.set("manaLevelId",list[0]);
		//record.set("manaLevel",list[4]+"民政局");
		//L5.fly('manaLevel').dom.value=list[4]+"民政局";
		document.getElementById("manaLevelId").value=list[0];
		document.getElementById("manaLevelAfter").value=list[4]+"民政局";
	}
}*/
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
	if(itemBefore==itemAfter){
		L5.Msg.alert("提示","当前变更项目变更前和变更后没有变化！");
		document.getElementById('itemAfterAll').value="";
		return;
	}
	if(itemReason==''){
		L5.Msg.alert("提示","变更说明不能为空！");return;
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
function updateSelectManaCode(){
	if (document.getElementById("addChangeItemAll").value!="0"){
			return;	
	}
	var fisOrganCode = organCode.substring(0,6) + "000000";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCityExt.jsp?radioMaxlevel=3&level=3&isRootSelect=1&organCode="
							+ fisOrganCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	//var record = ds.getCurrent();
	if(revalue!=undefined&&revalue!=""){
		var list = revalue.split(";");//list[0] == areaCode,list[1]==areaName

		document.getElementById("manaLevelIdAll").value=list[0];
		document.getElementById("itemAfterAll").value=list[4];
//		alert(list[0]);
	}
}
