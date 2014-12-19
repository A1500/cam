var fileCode = "S074";
var dutyId='';
var initLegalRecord="";//法定代表人的record
function init(){
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadOrgan);
		//guidePeopleInit();
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
	
		dutyFilter();
}
function loadOrgan(ds){
	ds.un('load',loadOrgan);
	somOrganDataSet.setParameter("SORG_ID",ds.get("sorgId"));
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadSession);
}
function loadSession(ds){
	ds.un('load',loadSession);
	$("cnName").innerHTML = ds.get("cnName");
	$("sorgCode").innerHTML = ds.get("sorgCode");
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("TASK_CODE",taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',loadResume);
}
function loadResume(ds){
	ds.un('load',loadResume);
	var record=ds.getCurrent();
	//加载简历信息
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',loadDuty);
}
function loadDuty(ds){
	ds.un('load',loadDuty);
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var record=somSessionDataSet.getCurrent();
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.setParameter("SESSION_ID", record.get('sessionId'));
	somDutyDataSet.load();
	somDutyDataSet.on('load',loadElectronic);
}
function loadElectronic(ds){
	ds.un('load',loadElectronic);
	//电子档案
	somElectronicDataSet_load();	
}
// 查看负责人明细
function detail(){
	var grid=L5.getCmp("peopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record.copy());
	//个人简历处理
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('dutyId')==somResumeRecord.get('dutyId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	somPeopleElectronicDataSet_load(fileCode,record.get('dutyId'));//同步法律要件
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(record.get("photoId"),"1");//同步照片
}
// 返回备案列表页面
function returnBack(){
	history.go(-1);	
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



function dutyFilter(){
	//社团职务过滤
	sorgDutiesDS.filterBy(function(record, id){
		if("00004".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00007".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00008".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00009".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00006".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00014".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00001".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00003".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00015".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
function showAge(){
	var birthday=$("birthday").innerHTML;
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
