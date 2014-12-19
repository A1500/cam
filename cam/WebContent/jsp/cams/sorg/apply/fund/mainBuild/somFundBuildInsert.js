var sorgType="J";
var sorgCodeNum="";
var cnNameNum="";
var peopleType='';
var taskCode="";
var sorgId="";
var currentPeople="";
var dutyId = 0;//初始dutyId
var currentId='';
//初始化
function init() {
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("0");

	if(method == 'INSERT'){
		somOrganDataSet.newRecord();
		somApplyDataSet.newRecord({"taskCode":taskCode,"curActivity":"受理", "curOpinionId":"1"});
		somSessionDataSet.newRecord();
		aspChiefDataset.newRecord();
		somElectronicDataSet_load();
	}else{
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
	}
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	//过滤流程意见
	opinionSelect.filterBy(function(record, id){
		if("0,1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
function fillHeldPeople(value){
	if(value == ''){
		return;
	}
	somHeldPeopleDataSet.each(function(record, index){
		if(record.get('name') == value){
			var aspRecord =peopleInsertDataset.getCurrent();
			aspRecord.set('idCard',record.get('idCard'));
			aspRecord.set('populace',record.get('populace'));
			aspRecord.set('birthday',record.get('birthday'));
			aspRecord.set('politics',record.get('politics'));
			aspRecord.set('phone',record.get('phone'));
			aspRecord.set('name',record.get('name'));
		}
	});
}
function getActDefName(){
	if(act=='auditReport'){
		return "名称核准";
	}else if(act=='accept'){
		return "受理";
	}else if(act=='watch'){
		return "现场勘查";
	}else if(act=='examin'){
		return "初审";
	}else if(act=='check'){
		return "审核";
	}else if(act=='audit'){
		return "批准";
	}else if(act=='print'){
		return "打印证书";
	}else if(act=='inform'){
		return "通知申请人";
	}else if(act=='issue'){
		return "发证";
	}else if(act=='supply'){
		return "补齐补正";
	}else{
		return "受理";
	}
}
//加载社会组织
function loadInfo(ds){
	ds.un("load",loadInfo);
	somApplyDataSet.set("curActivity",getActDefName());
	somApplyDataSet.set("curOpinionId",'1');
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",loadaspChief);
}
//加载拟任法定代表人
function loadaspChief(ds){
	ds.un("load",loadaspChief);
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somOrganDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
	aspChiefDataset.setParameter("SORG_ID@=", sorgId);
	aspChiefDataset.setParameter("SORG_DUTIES", "00012");
	aspChiefDataset.load();
	aspChiefDataset.on('load',loadsomHeldPeople);
}
//加载发起人
function loadsomHeldPeople(ds){
	ds.un("load",loadsomHeldPeople);
	somHeldPeopleDataSet.setParameter("TASK_CODE@=", taskCode);
	somHeldPeopleDataSet.load();
	somHeldPeopleDataSet.on('load',loadsomHeldOrgan);
}
//加载发起单位
function loadsomHeldOrgan(ds){
	ds.un("load",loadsomHeldOrgan);
	somHeldOrganDataSet.setParameter("TASK_CODE@=", taskCode);
	somHeldOrganDataSet.load();
	somHeldOrganDataSet.on('load',loadsomSession);
}
//加载届次
function loadsomSession(ds){
	ds.un("load",loadsomSession);
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',loadaspForLiShi);
}
//加载理事
function loadaspForLiShi(ds){
	ds.un("load",loadaspForLiShi);
	if(somSessionDataSet.getCount() == 0){
		somSessionDataSet.newRecord();
	}
	aspForLiShi.setParameter("TASK_CODE", taskCode);
	aspForLiShi.setParameter("SORG_DUTIES@in", "00001,00003,00004,00005,00013");
	aspForLiShi.load();
	aspForLiShi.on('load',loadaspForJianShi);
}
//加载监事
function loadaspForJianShi(ds){
	ds.un("load",loadaspForJianShi);
	aspForJianShi.setParameter("TASK_CODE", taskCode);
	aspForJianShi.setParameter("SORG_DUTIES", "00006");
	aspForJianShi.load();
	aspForJianShi.on('load',loadResume);
}
//加载简历
function loadResume(ds){
	ds.un("load",loadResume);
	somResumeInsertDataSet.setParameter("TASK_CODE", taskCode);
	somResumeInsertDataSet.load();
	somResumeInsertDataSet.on('load',loadFlow);
}
//加载意见
function loadFlow(ds){
	ds.un("load",loadFlow);
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somFlowDataSet.on('load',loadElectronic);
}
//加载文件
function loadElectronic(ds){
	ds.un("load",loadElectronic);
	somElectronicDataSet_load();
}
//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“基金会名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}

//全部保存
function save(){
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	var somOrganIsValidate = somOrganDataSet.isValidate();
	//社会组织校验
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//拟任法定代表人
	var aspValidate=aspChiefDataset.isValidate();
	if(aspValidate != true){
		L5.Msg.alert("提示",aspValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//发起人校验
	var somHeldPeopleDataSetValidate=somHeldPeopleDataSet.isValidate();
	if(somHeldPeopleDataSetValidate != true){
		L5.Msg.alert("提示",somHeldPeopleDataSetValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}
	//发起组织校验
	var somHeldOrganDataSetDataSetValidate=somHeldOrganDataSet.isValidate();
	if(somHeldOrganDataSetDataSetValidate != true){
		L5.Msg.alert("提示",somHeldOrganDataSetDataSetValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//申请信息校验
	var somApplyDataSetValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetValidate != true){
		L5.Msg.alert("提示",somApplyDataSetValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//届次校验
	var somSessionDataSetValidate = somSessionDataSet.isValidate();
	if(somSessionDataSetValidate != true){
		L5.Msg.alert("提示",somSessionDataSetValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	var startDate=_$('startDate');
	var endDate=_$('endDate');
	if(startDate!=''&&endDate!=''&&endDate<startDate){
		L5.Msg.alert("提示",'"规定换届日期"不得早于"本届开始日期"!');
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//理事校验
	var aspForLiShiaSetValidate = aspForLiShi.isValidate();
	if(aspForLiShiaSetValidate != true){
		L5.Msg.alert("提示",aspForLiShiaSetValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//监事校验
	var aspForJianShiValidate = aspForJianShi.isValidate();
	if(aspForJianShiValidate != true){
		L5.Msg.alert("提示",aspForJianShiValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"基金会邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		var idCard=somHeldPeopleRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}

	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//法人
	var organRecord = somOrganDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	command.setParameter("somOrganRecord",organRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	command.setParameter("somApplyRecord",somApplyRecord);
	//备案人员
	command.setParameter("somSessionDataSet",somSessionDataSet.getCurrent());
	command.setParameter("aspForLiShi",aspForLiShi.getAllRecords());
	command.setParameter("aspForJianShi",aspForJianShi.getAllRecords());
	somResumeInsertDataSet.clearFilter();
	command.setParameter("somResumeInsertDataSet",somResumeInsertDataSet.getAllRecords());
	command.setParameter("aspChief",aspChiefDataset.getCurrent());

	//保存
	if(method == 'INSERT'){
		command.execute("insertReportInfo");
	}else{
		command.execute("updateReportInfo");
	}
	if (!command.error) {
		L5.Msg.alert('提示','保存成功！',function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}

}
//保存并提交
function submit(){
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	var somOrganIsValidate = somOrganDataSet.isValidate();
	//社会组织校验
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//拟任法定代表人
	var aspValidate=aspChiefDataset.isValidate();
	if(aspValidate != true){
		L5.Msg.alert("提示",aspValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//发起人校验
	var somHeldPeopleDataSetValidate=somHeldPeopleDataSet.isValidate();
	if(somHeldPeopleDataSetValidate != true){
		L5.Msg.alert("提示",somHeldPeopleDataSetValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}
	//发起组织校验
	var somHeldOrganDataSetDataSetValidate=somHeldOrganDataSet.isValidate();
	if(somHeldOrganDataSetDataSetValidate != true){
		L5.Msg.alert("提示",somHeldOrganDataSetDataSetValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//申请信息校验
	var somApplyDataSetValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetValidate != true){
		L5.Msg.alert("提示",somApplyDataSetValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//届次校验
	var somSessionDataSetValidate = somSessionDataSet.isValidate();
	if(somSessionDataSetValidate != true){
		L5.Msg.alert("提示",somSessionDataSetValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	var startDate=_$('startDate');
	var endDate=_$('endDate');
	if(startDate!=''&&endDate!=''&&endDate<startDate){
		L5.Msg.alert("提示",'"规定换届日期"不得早于"本届开始日期"!');
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//理事校验
	var aspForLiShiaSetValidate = aspForLiShi.isValidate();
	if(aspForLiShiaSetValidate != true){
		L5.Msg.alert("提示",aspForLiShiaSetValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//监事校验
	var aspForJianShiValidate = aspForJianShi.isValidate();
	if(aspForJianShiValidate != true){
		L5.Msg.alert("提示",aspForJianShiValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"基金会邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		var idCard=somHeldPeopleRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//法人
	var organRecord = somOrganDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	command.setParameter("somOrganRecord",organRecord);
	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	command.setParameter("somApplyRecord",somApplyRecord);
	//备案人员
	command.setParameter("somSessionDataSet",somSessionDataSet.getCurrent());
	command.setParameter("aspForLiShi",aspForLiShi.getAllRecords());
	command.setParameter("aspForJianShi",aspForJianShi.getAllRecords());
	somResumeInsertDataSet.clearFilter();
	command.setParameter("somResumeInsertDataSet",somResumeInsertDataSet.getAllRecords());
	command.setParameter("aspChief",aspChiefDataset.getCurrent());
	//保存
	if(method == 'INSERT'){
		command.execute("createAndSend");
	}else{
		command.execute("updateForSendReport");
	}
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印不予受理通知
function printNoAccept(){
	if(cnName==''){
		L5.Msg.alert('提示',"请先录入基金会名称！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName+"&cnName"+encodeURIComponent(encodeURIComponent(cnName));
	window.open(url);
}
//打印受理通知
function printAccept(){
	if(cnName==''){
		L5.Msg.alert('提示',"请先录入基金会名称！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName+"&cnName"+encodeURIComponent(encodeURIComponent(cnName));
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回
function returnClick(){
	history.go(-1);
}

//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}

//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
}
function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
// 增加筹备人（自然人）
function addHeldPeople(){
	somHeldPeopleDataSet.newRecord();
}
// 删除筹备人（自然人）
function delHelpPeople(){
	var record=somHeldPeopleDataSet.getCurrent();
	if(record!=null)
		somHeldPeopleDataSet.remove(record);
}
// 增加筹备人（单位）
function addHeldOrgan(){
	somHeldOrganDataSet.newRecord();
}
// 删除筹备人（单位）
function delHeldOrgan(){
	var record=somHeldOrganDataSet.getCurrent();
	if(record!=null){
		somHeldOrganDataSet.remove(record);
	}
}
//增加一条人员备案
function addL(){
	initDutyL();
	L5.getCmp("peopleWin").show();
	dutyDataSetWin.filterBy(function(record, id){
		if("00001,00003,00004,00005,00013".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	document.getElementById("sorgDutiesNameDispaly").value = "";
	currentId=dutyId;
	peopleInsertDataset.removeAll();
	peopleInsertDataset.newRecord({"id":currentId,'sorgId':sorgId});
	peopleType='L';
	dutyId++;
	somResumeInsertDataSet.filterBy(function(record, id){
	});
	ifLegalShow();
}
function ifLegalShow(){
	$("ifLegalLabel").style.display = "";
	$("ifLegalInput").style.display = "";
	$("ifFulltime").colSpan = "1";
}
function updateL(){
	var grid=L5.getCmp("peopleGrid");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	currentId=currentPeople.get('id');
	initDutyL();
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());

	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('id')){
			return record;
		}
	});

	L5.getCmp("peopleWin").show();
	var sorgDuties=currentPeople.get('sorgDuties');
	var records=dutySelectDic.query("value",sorgDuties);
	if(records.length>0){
		var sorgDutiesText = records.items[0].get("text");
		document.getElementById("sorgDutiesNameDispaly").value = sorgDutiesText;
	}
	dutyDataSetWin.filterBy(function(record, id){
		if("00001,00003,00004,00005,00013".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").value = '';
		var nation = peopleInsertDataset.get('citizenship');
		var records = countrySelectDic.query("value",nation);
		if(records.length == 1){
			var nationCode = records.items[0].get("text");
			document.getElementById("nation").value = nation;
			document.getElementById("nationDispaly").value = nationCode;
		}
	}
	peopleType='LU';
	ifLegalShow();
}
function delL(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				aspForLiShi.remove(records[0]);
				//删除此人的简历
				somResumeInsertDataSet.each(function(record, id){
					if(record.get('dutyId') == records[0].get('id')){
						somResumeInsertDataSet.remove(record);
					}
				});
				//somResumeInsertDataSet.commitChanges();
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function addS(){
	initDutyS();
	L5.getCmp("peopleWin").show();
	document.getElementById("sorgDutiesNameDispaly").value = "监事";
	dutyDataSetWin.filterBy(function(record, id){
		if("00006".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	currentId=dutyId;
	peopleInsertDataset.removeAll();
	peopleInsertDataset.newRecord({"id":currentId});
	var record=peopleInsertDataset.getCurrent();
	record.set('sorgDuties',"00006");
	record.set('sorgId',sorgId);
	peopleType='S';
	dutyId++;
	somResumeInsertDataSet.filterBy(function(record, id){
	});
	ifLegalHide();
}
function ifLegalHide(){
	$("ifLegalLabel").style.display = "none";
	$("ifLegalInput").style.display = "none";
	$("ifFulltime").colSpan = "3";
}
function updateS(){
	var grid=L5.getCmp("peopleGrid1");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	initDutyS();
	currentId=currentPeople.get('id');
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());

	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('id')){
			return record;
		}
	});

	L5.getCmp("peopleWin").show();
	var sorgDuties=currentPeople.get('sorgDuties');
	var records=dutySelectDic.query("value",sorgDuties);
	if(records.length>0){
		var sorgDutiesText = records.items[0].get("text");
		document.getElementById("sorgDutiesNameDispaly").value = sorgDutiesText;
	}
	dutyDataSetWin.filterBy(function(record, id){
		if("00006".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").value = '';
		var nation = peopleInsertDataset.get('citizenship');
		var records = countrySelectDic.query("value",nation);
		if(records.length == 1){
			var nationCode = records.items[0].get("text");
			document.getElementById("nation").value = nation;
			document.getElementById("nationDispaly").value = nationCode;
		}
	}
	peopleType='SU';
	ifLegalHide();
}
function delS(){
	var grid = L5.getCmp('peopleGrid1');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				aspForJianShi.remove(records[0]);
				//删除此人的简历
				somResumeInsertDataSet.each(function(record, id){
					if(record.get('dutyId') == records[0].get('id')){
						somResumeInsertDataSet.remove(record);
					}
				});
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//增加一条简历
function addResume(){
	somResumeInsertDataSet.newRecord({"dutyId":currentId});
}
//删除一条简历
function delResume(){
	var grid = L5.getCmp('somResumeGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				somResumeInsertDataSet.remove(records[0]);
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//增加人员窗口中确认按钮
function confirm(){
	var record=peopleInsertDataset.getCurrent();
	record.set('sorgDuties',document.getElementById('sorgDuties').value);
	var IsValidate = peopleInsertDataset.isValidate();
	if(IsValidate != true){
		L5.Msg.alert("提示",IsValidate);
		return false;
	}

	record.set("citizenship",document.getElementById('nation').value);
	//邮编
	var postCode=record.get("postCode");
	if(postCode!=""&&_isPostCode(postCode) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
	var somResumeIsValidate = somResumeInsertDataSet.isValidate();
	if(somResumeIsValidate != true){
		L5.Msg.alert("提示",somResumeIsValidate);
		return false;
	}
	if(peopleType == "L"){
		aspForLiShi.insert(aspForLiShi.getCount(),peopleInsertDataset.getCurrent().copy());
		aspForLiShi.commitChanges();
	}else if(peopleType == "S"){
		aspForJianShi.insert(aspForJianShi.getCount(),peopleInsertDataset.getCurrent().copy());
	}else if(peopleType == "LU"){
		aspForLiShi.remove(currentPeople);
		aspForLiShi.insert(aspForLiShi.getCount(),peopleInsertDataset.getCurrent().copy());
	}else if(peopleType == "SU"){
		aspForJianShi.remove(currentPeople);
		aspForJianShi.insert(aspForJianShi.getCount(),peopleInsertDataset.getCurrent().copy());
	}
	aspForLiShi.commitChanges();
	aspForJianShi.commitChanges();

	L5.getCmp("peopleWin").setVisible(false);
}
function closePeopleWIn(){
	L5.getCmp("peopleWin").setVisible(false);
}
function countRender(value){
	if(value === undefined){
		value=0;
	}
	return "理事总人数: "+value+" 人";

}
function countRenderS(value){
	if(value === undefined){
		value=0;
	}
	return "监事总人数: "+value+" 人";

}
//校验身份证号
function validIDCard(o){
	if(o=="") return true;
	if(o=="000000000000000000") return true;
	var val=o.toUpperCase();
	if(val.length==15){
		if(!is15IDCard(val)){
			return false;
		}
	}else if(val.length==18){
		if(!is18IDCard(val)){
			return false;
		}
	}else{
		return false;
	}
	return true;
}
function fillOrganInfo(name){
	if(name.trim() == ''){
		return;
	}
	if(nameChangeFlag=="0"){
		loadOrganInfo(name);
	}else{
		if(name==newName){
			somOrganDataSet.set("cnName",name);
		}else{
			loadOrganInfo(name);
		}
	}
}
function loadOrganInfo(name){
	somOrganDataSet.removeAll();
	somOrganDataSet.setParameter("CN_NAME",name);
	somOrganDataSet.setParameter("SORG_STATUS","9");
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() == 0){
			L5.Msg.alert("提示","该基金会名称尚未成功核准或已经设立，无法进行设立登记！");
			somOrganDataSet.newRecord();
			return;
		}else{
			sorgId=somOrganDataSet.get('sorgId');
			somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
			somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
			aspChiefDataset.setParameter("SORG_ID@=", sorgId);
			somHeldPeopleDataSet.load();
			somHeldOrganDataSet.load();
			aspChiefDataset.load();
			somApplyDataSet.set("borgName",somOrganDataSet.get('borgName'));
			cnName=name;
			somApplyDataSet.getCurrent().set("curOpinion","");
			//加载换届会议信息
			somMeetingDataSet.setParameter("sorgId",sorgId);
			somMeetingDataSet.load();
		}
	});
}
/*******************************以下为名称变更一系列函数******************************/
var nameChangeFlag="0";
var oldName="";
var count=0;
var newName="";
//名称变更
function changeName(){
	cnName=_$('cnName');
	if(cnName==''){
		L5.Msg.alert('提示',"不存在要变更的社团名称，请先录入社团中文名称！");
		return;
	}
	if(count==0){
		oldName=cnName;
	}
	var win=L5.getCmp("changeName");
	win.show();
	document.getElementById('oldName').value=oldName;
	document.getElementById('newName').value="";
}
//名称变更确定
function confirmWin(){
	newName=document.getElementById('newName').value;
	if(oldName==newName){
		L5.Msg.alert('提示',"名称未作更改，请重新填写！");
		document.getElementById('newName').value="";
		return;
	}
	if(checkSorgName(newName)){
		document.getElementById('newName').value="";
	}else{
		var win=L5.getCmp("changeName");
		win.hide();
		nameChangeFlag="1";
		document.getElementById('cnName').value=newName;
		somApplyDataSet.getCurrent().set("curOpinion","基金会名称由 "+oldName+" 变更为 "+newName);
		somOrganDataSet.set("cnName",newName);
		count++;
	}
}
//名称变更关闭
function closeWin(){
	var win=L5.getCmp("changeName");
	win.hide();
}
//名称检查是否重复
function checkSorgName(name){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",name);
	command.execute("cnNameUK");
	cnNameNum = command.getReturn("cnNameNum");
	if(cnNameNum != 0){
		L5.Msg.alert("提示","更改的名称已经存在，请重新输入！");
		return true;
	}
	return false;
}

function validDate(args){
	var val=args[0];
	if(val=="") return true;
	var objRegExp = /^(\d{4})\-(\d{2})$/
	if(!objRegExp.test(val)) {
		return "不符合YYYY-mm格式，请检查！";
	}
	return true;
}
/*******************************名称变更一系列函数结束******************************/

function showMeeting(){
	var win=L5.getCmp("meetingWindow");
	win.show();
}

function winCloseMeeting(){
	var win=L5.getCmp("meetingWindow");
	win.hide();
}
function chooseMeeting(){
	var grid=L5.getCmp("meetingGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somSessionRecord=somSessionDataSet.getCurrent();

	somSessionRecord.set("sessionId",record.get("MEETINGID"));
	somSessionRecord.set("sessionName",record.get("MEETINGNAME"));
	somSessionRecord.set("taskCode",taskCode);

	winCloseMeeting();
}