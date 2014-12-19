var meetingNameGlobal='';
var peopleType='';
var currentPeople="";
var dutyId = 0;//初始dutyId
var currentId='';
function init(){
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'22',
			"sorgType":"J","ifBranch":'0',"morgName":userId,"morgArea":morgArea});

		somApplyDataSet.newRecord({"curActivity":"受理","taskCode":taskCode,
		"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"J",
		"acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});

		somElectionDataSet.newRecord({"sorgName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode,"electionType":'0'});
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
}
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load',loadOrgan);

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
	ds.set("cnName",userId);
	ds.set("sorgCode",sorgCode);
	ds.un("load",loadOrgan);
	var record=ds.getCurrent();
	if(meetingNameGlobal!=''){
		record.set("meetingName",meetingNameGlobal);
	}
	somOrganDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgCode);
}
//获取登记证号
function getSorgCode(ds){
	ds.un("load",getSorgCode);
	if(ds.getCount() == 1){
		document.getElementById('sorgCode').value = ds.get('sorgCode');
		document.getElementById('sorgName').value = ds.get('cnName');
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
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	var somElectionRecord=somElectionDataSet.getCurrent();
	somElectionRecord.set("councilNum",document.getElementById("councilNum").innerHTML);
	somElectionRecord.set("supervisorNum",document.getElementById("supervisorNum").innerHTML);
	somElectionRecord.set("chiefNum",document.getElementById("chiefNum").innerHTML);

	//组装会议名称
	if(method=="INSERT"||(method=="UPDATE"&&meetingNameGlobal!='')){
		var meetingName = "第"+somElectionRecord.get("meetingName")+"次理事会会议";
		meetingNameGlobal=_$("meetingName");
		somElectionRecord.set("meetingName",meetingName);
	}



	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");
	command.setParameter("somElectionRecord",somElectionRecord);

	aspForLiShi.add(aspForJianShi.getAllRecords());
	command.setParameter("somAspchiefRecord", aspForLiShi.getAllRecords());
	command.setParameter("somApplyRecord",somApplyRecord);

	var organRecord = somOrganDataSet.getCurrent();
	organRecord.set('borgName',document.getElementById("borgName").value);
	command.setParameter("organRecord",organRecord);

	command.execute("saveElection");
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
	somElectionRecord.set("councilNum",document.getElementById("councilNum").innerHTML);
	somElectionRecord.set("supervisorNum",document.getElementById("supervisorNum").innerHTML);
	somElectionRecord.set("chiefNum",document.getElementById("chiefNum").innerHTML);

	//组装会议名称
	var meetingName = "第"+somElectionRecord.get("meetingName")+"次理事会会议";
	somElectionRecord.set("meetingName",meetingName);

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

function ifNumber(obj){
	var reg = new RegExp("^[0-9]*$");
	if(!reg.test(obj.value)){
        	L5.Msg.alert('提示',"请输入数字！");
        	obj.value="";
        	obj.focus();
        	return;
 		}
}