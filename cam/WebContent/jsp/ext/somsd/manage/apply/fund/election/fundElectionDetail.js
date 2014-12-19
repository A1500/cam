var peopleType='';
var currentPeople="";
var dutyId = 0;//初始dutyId
var currentId='';
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
			document.getElementById("borgNameDispaly").innerHTML = borgCode;
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
		document.getElementById('sorgCode').innerHTML = ds.get('sorgCode');
		document.getElementById('cnName').innerHTML = ds.get('cnName');
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

function returnBack(){
	window.history.back(-1);
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
 
function ifLegalShow(){
	$("ifLegalLabel").style.display = "";
	$("ifLegalInput").style.display = "";
	$("ifFulltime").colSpan = "1";
}
function detailL(){
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


function ifLegalHide(){
	$("ifLegalLabel").style.display = "none";
	$("ifLegalInput").style.display = "none";
	$("ifFulltime").colSpan = "3";
}
function detailS(){
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


