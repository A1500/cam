var president='';//理事长
var sorgDuties='00006';
var currentPeople = '';
function init(){
	
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadSomOrgan);
				
	aspForLiShi.on('load',function(){
		aspForLiShi.filterBy(function(record, id){
			if("00001,00003,00004,00005".indexOf(record.get('sorgDuties'))>-1){
				return record;
			}
		});
		toCurrentDataset();
	});
	aspForJianShi.on('load',function(){
		aspForJianShi.filterBy(function(record, id){
			if("00006".indexOf( record.get('sorgDuties') ) > -1){
				return record;
			}
		});
	});
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
}
function loadSomOrgan(ds){
	ds.un("load",loadSomOrgan);
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadSomSession);
}
function loadSomSession(ds){
	ds.un("load",loadSomSession);
	if(ds.getCount() > 0 ){
		document.getElementById('sorgCode').innerHTML = ds.get("sorgCode");
		document.getElementById('cnName').innerHTML = ds.get("cnName");
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("TASK_CODE",taskCode);
		somSessionDataSet.load();
		somSessionDataSet.on('load',loadDuty);
	}else{
		L5.Msg.alert("提示","社会组织信息加载出错!");
		return;
	}
}
function loadDuty(ds){
	ds.un("load",loadDuty);
	//加载简历信息
	if(ds.getCount() > 0 ){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somResumeInsertDataSet.setParameter("TASK_CODE",taskCode);
		somResumeInsertDataSet.load();
		somResumeInsertDataSet.on('load',loadLishi);
	}else{
		L5.Msg.alert("提示","届次信息加载出错!");
		return;
	}
}
function loadLishi(ds){
	ds.un("load",loadLishi);
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	aspForLiShi.setParameter("SESSION_ID", somSessionDataSet.get('sessionId'));
	aspForLiShi.load();
	aspForLiShi.on('load',loadJianshi);
}
function loadJianshi(ds){
	ds.un("load",loadJianshi);
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	aspForJianShi.setParameter("SESSION_ID",somSessionDataSet.get('sessionId'));
	aspForJianShi.load();
	aspForJianShi.on('load',loadElectron);
}
function loadElectron(ds){
	ds.un("load",loadElectron);
	//电子档案
	somElectronicDataSet_load();
}
// 修改负责人
function update(){
	somDutyDataSet.removeAll();
	var record=somDutyDataSet.newRecord();
	somDutyDataSet.remove(record);
	somDutyDataSet.insert(0,currentPeople.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	var birthday=currentPeople.get("birthday");
	
	showAge();
	synPhoto(somDutyDataSet.get("photoId"),"1");//同步照片
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").innerHTML = '';
		var nation = somDutyDataSet.get('nation');
		var records = countrySelectDic.query("value",nation);
		if(records.length == 1){
			var nationCode = records.items[0].get("text");
			document.getElementById("nationDispaly").innerHTML = nationCode;
		}
	}
	//同步法律要件
	if(peopleType=="LU"){
		somPeopleElectronicDataSet_load(fileCodeL,currentPeople.get('dutyId'));
	}
	if(peopleType=="SU"){
		somPeopleElectronicDataSet.removeAll();
	}
}
// 查看负责人明细
function detailL(){
	peopleType="L";
	var grid=L5.getCmp("peopleGrid");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentRecord.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet_load(fileCodeL,currentRecord.get('dutyId'));//同步法律要件
}
// 查看负责人明细
function detailS(){
	peopleType="S";
	var grid=L5.getCmp("peopleGrid1");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentRecord.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet.removeAll();//同步法律要件
}
// 返回备案列表页面
function returnBack(){
	window.history.go(-1);
}

//----------------------------------------------------------------


function detailL(){
	var grid=L5.getCmp("peopleGrid");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	currentId=currentPeople.get('dutyId');
	initDutyL();
	peopleType='LU';
	update();
}

function detailS(){
	var grid=L5.getCmp("peopleGrid1");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	initDutyS();
	currentId=currentPeople.get('dutyId');
	peopleType='SU';
	update();
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
function countRenderF(value){
	if(value === undefined){
		value=0;
	}
	return "负责人总人数: "+value+" 人";
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
}



function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}

function showAge(){

	var birthday=_$("birthday");
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}

