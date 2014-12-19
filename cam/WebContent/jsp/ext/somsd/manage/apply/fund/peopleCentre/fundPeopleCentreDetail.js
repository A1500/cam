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
// 返回备案列表页面
function returnBack(){
	window.history.go(-1);
}
// 根据开始日期与任期回写结束日期
function setEndDate(){
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var record=somSessionDataSet.getCurrent();
	var tenure=_$("tenure");
	//var startDate=_$("startDate");
	var startDate=_$('startDate');
	if(tenure!=""&&startDate!=""){
		var year=parseInt(startDate.substring(0,4))+parseInt(tenure);
		var month=startDate.substring(5,7);
		var day=startDate.substring(8,10);
		record.set("endDate", year+"-"+month+"-"+day);
	}
}

//----------------------------------------------------------------

//增加一条人员备案
function addL(){
	initDutyL();
	peopleType='L';
	add();
	sorgDuties = '00006';
}
function updateL(){
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
function addS(){	
	initDutyS();
	peopleType='S';
	add();
	sorgDuties = '00006';
}
function updateS(){
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

function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}
function checkCard(){
	if(_$("idCardID")=="") return;
	//身份证号
	if(checkIDCard( document.getElementById("idCardID") ) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var record=somDutyDataSet.getCurrent();
	//如果为身份证号，获取出生年月和性别
	if(_$("idCardID").length==18){
		record.set("sex",getSexByCode(_$("idCardID")));
		record.set("birthday",getBirthdayByCode(_$("idCardID")));
		showAge();
	}
}
function showAge(){
	var birthday=$("birthday").innerHTML;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
//选择是否党政机关领导
function valid_ifPartyLeader_add(){
	if(document.getElementById('ifPartyLeader_add').value == '1'){
		document.getElementById('promiseOrgan_add').style.display="block";
		document.getElementById('promiseCode_add').style.display="block";
	}else{
		document.getElementById('promiseOrgan_add').style.display="none";
		document.getElementById('promiseCode_add').style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
	}
}
/**
 * 查询该登记证号的社会组织下面是否存在填写的届次名称
 * @param sorgCode 登记证号
 * @param sessionName  届次名称
 * @param sorgId  sorgId
 */
function findSessionExist(){
	if(document.getElementById('sorgCode').value.trim() == '' || document.getElementById('sessionName').value.trim() == ''){
		return;
	}
	somSessionQueryDataSet.setParameter("sorgCode",document.getElementById('sorgCode').value.trim());
	somSessionQueryDataSet.setParameter("sessionName",document.getElementById('sessionName').value.trim());
	somSessionQueryDataSet.setParameter("sorgId",sorgId);
	somSessionQueryDataSet.load();
	somSessionQueryDataSet.on('load',alertLog);
}
