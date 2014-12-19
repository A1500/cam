var president='';//理事长
var sorgDuties='00006';
var currentPeople = '';
function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode;
	if(method=="detail"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SESSION_ID",sessionId);
		somSessionDataSet.load();
		somSessionDataSet.on('load', sessionOnload);
		guidePeopleInit();
		somElectronicDataSet_load();
	}				
	aspForLiShi.on('load',function(){
		aspForLiShi.filterBy(function(record, id){
			if("00001,00003,00004,00005,00013".indexOf(record.get('sorgDuties'))>-1){
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
function sessionOnload(ds){
	ds.un("load",sessionOnload);
	var record=ds.getCurrent();
	taskCode=record.get("taskCode");
	sessionId=record.get("sessionId");
	//加载简历信息
	somResumeInsertDataSet.setParameter("TASK_CODE",taskCode);
	somResumeInsertDataSet.load();
	somResumeInsertDataSet.on('load',resumeOnload);
	CurrentDataset.setParameter("TASK_CODE",taskCode);
	CurrentDataset.load();
	//电子档案
	somElectronicDataSet_load();
}

function resumeOnload(ds){
	ds.un("load",resumeOnload);
	aspForJianShi.setParameter("SESSION_ID",sessionId);
	aspForJianShi.load();
	
	aspForLiShi.setParameter("SESSION_ID", sessionId);
	aspForLiShi.load();
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
	//同步法律要件
	if(peopleType=="LU"){
		somPeopleElectronicDataSet_load(fileCodeL,currentPeople.get('dutyId'));
	}
	if(peopleType=="SU"){
		somPeopleElectronicDataSet.removeAll();
	}
}
// 删除负责人
function del(){
	var grid=L5.getCmp("peopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.remove(record);
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
// 查看负责人明细
function detail(){
	var grid=L5.getCmp("peopleGrid2");
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
}
// 根据开始日期与任期回写结束日期
function setEndDate(){
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var record=somSessionDataSet.getCurrent();
	var tenure=_$("tenure");
	//var startDate=_$("startDate");
	var startDate=record.get('startDate');
	if(tenure!=""&&startDate!=""){
		var year=parseInt(startDate.substring(0,4))+parseInt(tenure);
		var month=startDate.substring(5,7);
		record.set("endDate", year+"-"+month);
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
function delL(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				aspForLiShi.remove(records[0]);
				toCurrentDataset();
				//删除此人的简历
				somResumeInsertDataSet.each(function(record, id){
					if(record.get('dutyId') == records[0].get('dutyId')){
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
					if(record.get('dutyId') == records[0].get('dutyId')){
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
		if("00001,00003,00004,00013".indexOf(record.get('sorgDuties'))>-1){
			return record;
		}
	});
}


function showMeeting(){
	if(method == "update"){
		L5.Msg.alert("提示","不能修改届次信息!");
		return;
	}
	var win=L5.getCmp("meetingWindow");
	win.show();
}

function winCloseMeeting(){
	var win=L5.getCmp("meetingWindow");
	win.hide();
}


function closeW(){
	window.close();	
}