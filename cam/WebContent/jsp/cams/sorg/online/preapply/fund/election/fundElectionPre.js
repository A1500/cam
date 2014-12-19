var peopleType='';
var currentPeople="";
var dutyId = 0;//初始dutyId
var currentId='';
var meetingName = '';
var isMeetingExist = false;
function init(){
	L5.getCmp("tab").setActiveTab("0");
	somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadElection);

	aspForLiShi.on('load',function(){
				aspForLiShi.filterBy(function(record, id){
					if("00001,00003,00004,00005,00013".indexOf(record.get('sorgDuties'))>-1){
						return record;
					}
				});
				toCurrentDataset();
				document.getElementById("councilNum").innerHTML=aspForLiShi.getCount();
			});
	aspForJianShi.on('load',function(){
				aspForJianShi.filterBy(function(record, id){
					if("00006".indexOf( record.get('sorgDuties') ) > -1){
						return record;
					}
				});
				document.getElementById("supervisorNum").innerHTML=aspForJianShi.getCount();
			});

	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}

	opinionSelect.filterBy(function(record, id){
		if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
			return record;
		}
	});
}
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	if(ds.getCount() > 0 ){
		somElectionDataSet.setParameter("TASK_CODE",taskCode);
		somElectionDataSet.load();
		somElectionDataSet.on('load',loadTrueOrgan);
	}else{
		L5.Msg.alert("提示","业务数据加载异常！");
		return;
	}
}
function loadTrueOrgan(ds){
	ds.un('load',loadTrueOrgan);
	if(ds.getCount() > 0 ){
		meetingName = ds.get('meetingName');
		var sorgName =somApplyDataSet.get("sorgName");
		somOrganQueryDataSet.setParameter("CN_NAME",sorgName);
		somOrganQueryDataSet.setParameter("SORG_STATUS@in","9,22");
		somOrganQueryDataSet.setParameter("SORG_TYPE","J");
		somOrganQueryDataSet.load();
		somOrganQueryDataSet.on('load',loadLishi);
	}else{
		L5.Msg.alert("提示","届次数据加载异常！");
		return;
	}
}
function loadLishi(ds){
	sorgId = ds.get('sorgId');
	ds.un("load",loadLishi);
	if( ds.getCount() > 0 ){
		var sorgStatus = ds.get('sorgStatus');
		if(sorgStatus == '9'){
			var cnName = ds.get('cnName');
			document.getElementById('cnName').value= cnName;
			fillOrganInfo(cnName);
		}else{
			var sorgCode =  ds.get('sorgCode');
			document.getElementById('sorgCode').value= sorgCode;
			fillSorgInfo();
		}
		aspForLiShi.setParameter("TASK_CODE", taskCode);
		aspForLiShi.load();
		aspForLiShi.on('load',loadJianshi);
	}else{
		L5.Msg.alert("提示","没有找到此名称的社会组织的信息！");
		aspForLiShi.setParameter("TASK_CODE", taskCode);
		aspForLiShi.load();
		aspForLiShi.on('load',loadJianshi);
		return;
	}
}
//加载监事
function loadJianshi(ds){
	ds.un("load",loadJianshi);
	aspForJianShi.setParameter("TASK_CODE", taskCode);
	aspForJianShi.load();
	aspForJianShi.on('load',loadElectronic);
}
function loadElectronic(ds){
	ds.un("load",loadElectronic);
	//电子档案
	somElectronicDataSet_load();
}
function save(){
	if(document.getElementById('cnName').value == '' ){
		L5.Msg.alert("提示","请填写基金会名称！");
		return;
	}
	//if(document.getElementById('sorgCode').value == '' ){
	//	L5.Msg.alert("提示","请填写基金会登记证号！");
	//	return;
//	}
	if( !isMeetingExist ){
		L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
		return ;
	}
	var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somElectionRecord=somElectionDataSet.getCurrent();
	somElectionRecord.set("councilNum",document.getElementById("councilNum").innerHTML);
	somElectionRecord.set("supervisorNum",document.getElementById("supervisorNum").innerHTML);
	somElectionRecord.set("chiefNum",document.getElementById("chiefNum").innerHTML);
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundElectionApplyCmd");
	somElectionRecord.set("sorgId",sorgId);
	command.setParameter("somElectionRecord",somElectionRecord);

	aspForLiShi.add(aspForJianShi.getAllRecords());

	var somAspchiefRecords = aspForLiShi.getAllRecords();
	for (var i = 0;i<somAspchiefRecords.length;i++){
		somAspchiefRecords[i].set("sorgId",sorgId);
	}
	command.setParameter("somAspchiefRecord", somAspchiefRecords);
	somApplyRecord.set("sorgId",sorgId);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("create");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			updateOnlineStatusAccept();
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.history.back(-1);
}

//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}

//--------------------------------------------------------------------------
function countRender(value){
	if(value === undefined){
		value=0;
	}
	return "理事会候选人总人数: "+value+" 人";

}
function countRenderS(value){
	if(value === undefined){
		value=0;
	}
	return "监事总人数: "+value+" 人";
}
function countRenderF(value){
	if(value === undefined){
		value=0;
	}
	return "负责候选人总人数: "+value+" 人";
}
//增加一条人员备案
function addL(){
	initDutyL();
	L5.getCmp("peopleWin").show();
	document.getElementById('legal').style.display = 'none';
	peopleInsertDataset.removeAll();
	peopleInsertDataset.newRecord();
	peopleType='L';
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
	initDutyL();
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());
	L5.getCmp("peopleWin").show();
	loadLegal();
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
				toCurrentDataset();
				document.getElementById("councilNum").innerHTML=aspForLiShi.getCount();
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
	document.getElementById('legal').style.display = 'none';
	peopleInsertDataset.removeAll();
	peopleInsertDataset.newRecord();
	peopleType='S';
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
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());

	L5.getCmp("peopleWin").show();
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
				document.getElementById("supervisorNum").innerHTML=aspForJianShi.getCount();
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//增加人员窗口中确认按钮
function confirm(){
	var IsValidate = peopleInsertDataset.isValidate();
	if(IsValidate != true){
		L5.Msg.alert("提示",IsValidate);
		return false;
	}
	peopleInsertDataset.getCurrent().set('name',peopleInsertDataset.getCurrent().get('name').trim());

	if(peopleType == "L"){
		aspForLiShi.insert(aspForLiShi.getCount(),peopleInsertDataset.getCurrent().copy());
		toCurrentDataset();
	}else if(peopleType == "S"){
		aspForJianShi.insert(aspForJianShi.getCount(),peopleInsertDataset.getCurrent().copy());
	}else if(peopleType == "LU"){
		aspForLiShi.remove(currentPeople);
		aspForLiShi.insert(aspForLiShi.getCount(),peopleInsertDataset.getCurrent().copy());
		toCurrentDataset();
	}else if(peopleType == "SU"){
		aspForJianShi.remove(currentPeople);
		aspForJianShi.insert(aspForJianShi.getCount(),peopleInsertDataset.getCurrent().copy());
	}
	document.getElementById("councilNum").innerHTML=aspForLiShi.getCount();
	document.getElementById("supervisorNum").innerHTML=aspForJianShi.getCount();
	//document.getElementById("chiefNum").innerHTML=CurrentDataset.getCount();
	aspForLiShi.commitChanges();
	aspForJianShi.commitChanges();
	closeWin();
}
function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}
//同步加载负责人信息
function toCurrentDataset(){
	var records=aspForLiShi.getAllRecords();
	CurrentDataset.removeAll();
	CurrentDataset.add(records);
	CurrentDataset.filterBy(function(record, id){
		if("00001,00003,00004,00013".indexOf(record.get('sorgDuties'))>-1){
			return record;
		}
	});
	document.getElementById("chiefNum").innerHTML=CurrentDataset.getCount();
}

function loadLegal(){
	var sorgDuties=peopleInsertDataset.getCurrent().get("sorgDuties");
	if(sorgDuties == '00001'){
		document.getElementById('legal').style.display = 'block';
	}else{
		document.getElementById('legal').style.display = 'none';
	}
}
function printParty(){
	var cnName=_$("cnName");
	if(cnName==''){
		L5.Msg.alert('提示','请先填写基金会名称！');
		return;
	}
	/*
	var somPartyMemberDataSet = L5.DatasetMgr.lookup("somPartyMemberDataSet");
	somPartyMemberDataSet.setParameter("SORG_ID",sorgId);
	somPartyMemberDataSet.setParameter("PEOPLE_TYPE",'1');
	somPartyMemberDataSet.load();
	somPartyMemberDataSet.on('load',function(ds){
		partyNum=ds.getCount();
		if(partyNum<3){
			L5.Msg.alert('提示','正式党员不足三人，不需建立党组织！');
			return;
		}
		var win = L5.getCmp("printPartyWin");
		win.show();
	});
	*/
	var win = L5.getCmp("printPartyWin");
	win.show();
}
var partyNum='';
function confirmPrint(){
	var cnName=_$("cnName");
	var linkmanName=encodeURIComponent(encodeURIComponent(_$('linkmanName')));
	var linkmanPhone=_$('linkmanPhone');
	if(linkmanName==''||linkmanPhone==''){
		L5.Msg.alert('提示','请先填写完整的联系人信息！');
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/partyBuildInformForPrint.jsp?cnName="+encodeURIComponent(encodeURIComponent(cnName))
	+'&linkmanName='+linkmanName+'&linkmanPhone='+linkmanPhone+'&taskCode='+taskCode+'&partyNum='+partyNum;
	window.open(url);
}
function closePrintWin(){
	var win = L5.getCmp("printPartyWin");
	win.setVisible(false);
}
//输入登记证号，加载社会组织名称
function fillSorgInfo(){
	var sorgCode=document.getElementById('sorgCode').value;
	somOrganDataSet.removeAll();
	if(sorgCode == '' ){
		return ;
	}else{
		somOrganDataSet.setParameter("SORG_CODE",sorgCode);
		somOrganDataSet.setParameter("SORG_STATUS",'22');
		somOrganDataSet.setParameter("SORG_TYPE",'J');
		somOrganDataSet.load();
		somOrganDataSet.on('load',getSorgName);
	}
}
//获取社会组织名称
function getSorgName(ds){
	ds.un("load",getSorgName);
	var num=ds.getCount();
	if(num==0){
		L5.Msg.alert("提示","您输入的登记证号不存在，请重新输入！");
		sorgId='';
		document.getElementById('sorgCode').value='';
		document.getElementById('cnName').value='';
		somElectionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		somApplyDataSet.set('borgName','');
		document.getElementById('borgNameDispaly').value='';
		$("cnName").disabled = false;
		return;
	}else{
		sorgId=ds.get('sorgId');
		somElectionDataSet.set('sorgId',ds.get('sorgId'));
		document.getElementById('cnName').value=ds.get('cnName');
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',ds.get('sorgId'));
		somApplyDataSet.set('borgName',ds.get('borgName'));
		$("cnName").disabled = true;
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = ds.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}
		meetingQuery();//根据会议名称查询是否已经做过换届
	}
}
//提交
function submit(){
	if(document.getElementById('cnName').value == '' ){
		L5.Msg.alert("提示","请填写基金会名称！");
		return;
	}
//	if(document.getElementById('sorgCode').value == '' ){
	//	L5.Msg.alert("提示","请填写基金会登记证号！");
	//	return;
	//}
	if( !isMeetingExist ){
		L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
		return ;
	}
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var validate=somApplyDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var somElectionRecord=somElectionDataSet.getCurrent();
	somElectionRecord.set("councilNum",document.getElementById("councilNum").innerHTML);
	somElectionRecord.set("supervisorNum",document.getElementById("supervisorNum").innerHTML);
	somElectionRecord.set("chiefNum",document.getElementById("chiefNum").innerHTML);
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundElectionApplyCmd");
	somElectionRecord.set("sorgId",sorgId);
	command.setParameter("somElectionRecord",somElectionRecord);

	aspForLiShi.add(aspForJianShi.getAllRecords());

	var somAspchiefRecords = aspForLiShi.getAllRecords();
	for (var i = 0;i<somAspchiefRecords.length;i++){
		somAspchiefRecords[i].set("sorgId",sorgId);
	}
	command.setParameter("somAspchiefRecord", somAspchiefRecords);
	somApplyRecord.set("sorgId",sorgId);
	command.setParameter("somApplyRecord",somApplyRecord);

	command.execute("createAndSend");
	if(!command.error){
		L5.Msg.alert("提示","提交成功！",function(){
		updateOnlineStatusAccept();
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
//输入基金会名称，加载社会组织
function fillOrganInfo(name){
	if(name.trim() == ''){
		return;
	}
	somOrganDataSet.removeAll();
	somOrganDataSet.setParameter("CN_NAME",name);
	somOrganDataSet.setParameter("IF_BRANCH","0");
	somOrganDataSet.setParameter("SORG_STATUS","22");
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgId);
}
//获取社会组织
function getSorgId(ds){
	ds.un("load",getSorgId);
	if(ds.getCount() == 0){
		L5.Msg.alert("提示","该基金会尚未成功申请名称核准，无法进行换届（成立）事先报批！");
		sorgId='';
		document.getElementById('cnName').value='';
		somElectionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		$("sorgCode").disabled = false;
		return;
	}else{
		sorgId=ds.get('sorgId');
		meetingQuery();//根据会议名称查询是否已经做过换届
		somElectionDataSet.set('sorgId',ds.get('sorgId'));
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',ds.get('sorgId'));
		$("sorgCode").disabled = true;
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = ds.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}
	}
}

function meetingQuery(){
	if(document.getElementById('cnName').value.trim() == '' ){
		L5.Msg.alert("提示","请填写基金会名称！");
		return;
	}
	//根据会议名称查询是否已经做过换届
	var somMeetingQueryDataSet=L5.DatasetMgr.lookup("somMeetingQueryDataSet");
	somMeetingQueryDataSet.removeAll();
	somMeetingQueryDataSet.setParameter("SORG_ID@=",sorgId);
	somMeetingQueryDataSet.setParameter("MEETING_NAME@=",document.getElementById("meetingName").value);
	somMeetingQueryDataSet.load();
	somMeetingQueryDataSet.on("load",alertMsgMeeting);
}
function alertMsgMeeting(ds){
	ds.un("load",alertMsgMeeting);
	if(ds.getCount()>0){
		L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
		isMeetingExist = false;
	}else{
		isMeetingExist = true;
	}
}