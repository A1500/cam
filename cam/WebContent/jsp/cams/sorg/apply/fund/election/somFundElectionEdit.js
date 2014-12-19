var peopleType='';
var currentPeople="";
var dutyId = 0;//初始dutyId
var currentId='';
function init(){
	L5.getCmp("tab").setActiveTab("0");

	//过滤意见枚举，去掉补齐补正
	if(act == 'examin' || act == 'check' || act == 'audit' ){
	}else{
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
				return record;
			}
		});
	}

	if(method=="INSERT"){
		somElectionDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode,"electionType":'0'});
		somApplyDataSet.newRecord({"sorgId":sorgId,"sorgType":"J","taskCode":taskCode,"ifFinish":'0',"curOpinionId":'1'});
		aspForJianShi.setParameter("TASK_CODE", "123");
		aspForJianShi.load();
		aspForLiShi.setParameter("TASK_CODE","123");
		aspForLiShi.load();
		CurrentDataset.setParameter("TASK_CODE","123");
		CurrentDataset.load();
		//电子档案
		somElectronicDataSet_load();
	}else{
		somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadElection);
	}
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
	//身份验证window关闭时把数据清空
	L5.getCmp("win_peopleValidate").on("beforehide",function(){
		winDutyDataSet.removeAll();
	});
}
//加载环节审批信息
function loadElection(ds){
	sorgId = ds.get("sorgId");
	ds.un("load",loadElection);
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load',loadOrgan);
	CurrentDataset.setParameter("SORG_ID@=",ds.get("sorgId"));
	CurrentDataset.setParameter("SORG_DUTIES@in",'00001,00003,00004,00013');
	CurrentDataset.load();
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somApplyDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
}
function loadOrgan(ds){
	ds.un("load",loadOrgan);
	somOrganDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgCode);
}
//获取登记证号
function getSorgCode(ds){
	ds.un("load",getSorgCode);
	if(ds.getCount() == 1){
		document.getElementById('sorgCode').value = ds.get('sorgCode');
		document.getElementById('cnName').value = ds.get('cnName');
	}
	aspForLiShi.setParameter("TASK_CODE", taskCode);
	aspForLiShi.load();
	aspForLiShi.on('load',loadJianshi);
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
	var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	if(document.getElementById('cnName').value == '' ){
		L5.Msg.alert("提示","请填写基金会名称！");
		return;
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somElectionRecord=somElectionDataSet.getCurrent();
	if(method=="INSERT"){
		//组装会议名称
		var meetingName = "第"+somElectionRecord.get("meetingName")+"次理事会会议";
		somElectionRecord.set("meetingName",meetingName);
	}
	if(method=="UPDATE"){
		somElectionRecord.set("meetingName",somElectionRecord.get("meetingName"));
	}
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundElectionApplyCmd");
	command.setParameter("somElectionRecord",somElectionRecord);

	aspForLiShi.add(aspForJianShi.getAllRecords());
	command.setParameter("somAspchiefRecord", aspForLiShi.getAllRecords());

	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="INSERT"){
		command.execute("create");
	}else{
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
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
		//L5.Msg.alert("提示","您输入的登记证号不存在，请重新输入！");
		sorgId='';
		//document.getElementById('sorgCode').value='';
		//document.getElementById('cnName').value='';
		somElectionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		somApplyDataSet.set('borgName','');
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
	}
}
//提交
function submit(){
	if(document.getElementById('cnName').value == '' ){
		L5.Msg.alert("提示","请填写基金会名称！");
		return;
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
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	if(method=="INSERT"){
		//组装会议名称
		var meetingName = "第"+somElectionRecord.get("meetingName")+"次理事会会议";
		somElectionRecord.set("meetingName",meetingName);
	}
	if(method=="UPDATE"){
		somElectionRecord.set("meetingName",somElectionRecord.get("meetingName"));
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundElectionApplyCmd");
	command.setParameter("somElectionRecord",somElectionRecord);

	aspForLiShi.add(aspForJianShi.getAllRecords());
	command.setParameter("somAspchiefRecord", aspForLiShi.getAllRecords());

	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="INSERT"){
		command.execute("createAndSend");
	}else{
		command.execute("send");
	}
	if(!command.error){
		L5.Msg.alert("提示","提交成功！",function(){
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
		L5.Msg.alert("提示","该基金会尚未成功设立登记，无法进行换届（成立）事先报批！");
		sorgId='';
		document.getElementById('cnName').value='';
		somElectionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		//$("sorgCode").disabled = false;
		return;
	}else{
		sorgId=ds.get('sorgId');
		somElectionDataSet.set('sorgId',ds.get('sorgId'));
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',ds.get('sorgId'));
		//$("sorgCode").disabled = true;
		CurrentDataset.setParameter("SORG_ID@=",sorgId);
		CurrentDataset.setParameter("SORG_DUTIES@in",'00001,00003,00004');
		CurrentDataset.load();
	}
}

function queryPeopleByName(value) {
	if(value.length!=''){
		var winPeopleDataSet=L5.DatasetMgr.lookup("winPeopleDataSet");
		winPeopleDataSet.setParameter("NAME",value);
		winPeopleDataSet.load();
		winPeopleDataSet.on('load', function(){
			if(winPeopleDataSet.getCount()>0){
				L5.getCmp("win_peopleValidate").show();
			}
		});
	}
}

function getIfLimit(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + '是' + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + '否' + '</a>';
	}else{
		return "";
	}
}
function showRestrict(restrictPeopleId){
	var somRestrictPeopleDetailDataSet=L5.DatasetMgr.lookup("somRestrictPeopleDetailDataSet");
	somRestrictPeopleDetailDataSet.setParameter("PEOPLE_ID",restrictPeopleId);
	somRestrictPeopleDetailDataSet.load();
	var win = L5.getCmp("restrictWin");
	win.show();
}
function closeRestrictWin(){
	var win = L5.getCmp("restrictWin");
	win.hide();
}

//关闭人员索引窗口
function closeItem(){
	L5.getCmp("win_peopleValidate").setVisible(false);
}

function ifNumber(obj){
	var reg = new RegExp("^[0-9]*$");
	if(!reg.test(obj.value)){
        	L5.Msg.alert('提示',"请输入数字！");
        	obj.value="";
        	obj.focus();
        	return;
 		}
}

function checkSessionIfExsist(obj){
		//根据会议名称查询是否已经做过换届
		var somMeetingQueryDataSet=L5.DatasetMgr.lookup("somMeetingQueryDataSet");
		somMeetingQueryDataSet.setParameter("SORG_ID@=",sorgId);
		var meetingName = "第"+obj.value+"次理事会会议";
		somMeetingQueryDataSet.setParameter("MEETING_NAME@=",meetingName);
		somMeetingQueryDataSet.load();
		somMeetingQueryDataSet.on("load",function(){
			if(somMeetingQueryDataSet.getCount()>0){
				L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
				somElectionDataSet.getCurrent().set("meetingName","");
			}
		});
}

function checkSessionIfExsistUpdate(obj){
		//根据会议名称查询是否已经做过换届
		var somMeetingQueryDataSet=L5.DatasetMgr.lookup("somMeetingQueryDataSet");
		somMeetingQueryDataSet.setParameter("SORG_ID@=",sorgId);
		var meetingName = obj.value;
		somMeetingQueryDataSet.setParameter("MEETING_NAME@=",meetingName);
		somMeetingQueryDataSet.load();
		somMeetingQueryDataSet.on("load",function(){
			if(somMeetingQueryDataSet.getCount()>0){
				L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
				somElectionDataSet.getCurrent().set("meetingName","");
			}
		});
}