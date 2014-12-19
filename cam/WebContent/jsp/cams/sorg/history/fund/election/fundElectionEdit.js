
var peopleType='';
var currentPeople="";
var dutyId = 0;//初始dutyId
var currentId='';
function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	if(method=="insert"){
		var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
		somElectionDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode,"electionType":'0'});
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"sorgId":sorgId,"sorgType":"J","taskCode":taskCode,"borgName":borgName});
		aspForJianShi.setParameter("TASK_CODE", "123");
		aspForJianShi.load();	
		aspForLiShi.setParameter("TASK_CODE","123");
		aspForLiShi.load();
		CurrentDataset.setParameter("TASK_CODE","123");
		CurrentDataset.load();
	}else{
		var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
		somElectionDataSet.setParameter("ELECTION_ID@=",electionId);
		somElectionDataSet.load();
		somElectionDataSet.on('load', function(){
			var record=somElectionDataSet.getCurrent();
			var taskCode=record.get("taskCode");;
			var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
			somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
			somApplyDataSet.load();
			aspForJianShi.setParameter("TASK_CODE", taskCode);
			aspForJianShi.load();
			
			aspForLiShi.setParameter("TASK_CODE", taskCode);
			aspForLiShi.load();
		});
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
	//电子档案
	somElectronicDataSet_load();	
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});	
	}			
}
function save(){
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
	
	var command=new L5.Command("com.inspur.cams.sorg.history.election.cmd.SomElectionCmd");
	command.setParameter("somElectionRecord",somElectionRecord);
	
	aspForLiShi.add(aspForJianShi.getAllRecords());
	command.setParameter("somAspchiefRecord", aspForLiShi.getAllRecords());
	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
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
	var data=new L5.Map();
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);	
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/history/fund/election/fundElection.jsp";
	L5.forward(url,'',data);
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
		if("00001,00003,00004".indexOf(record.get('sorgDuties'))>-1){
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
}
var partyNum='';
function confirmPrint(){
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