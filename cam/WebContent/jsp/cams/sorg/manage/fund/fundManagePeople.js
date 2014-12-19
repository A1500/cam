var president='';//理事长
var sorgDuties='00006';
var currentPeople = '';
var initLegalRecord="";//法定代表人的record
function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode;
	if(method=="insert"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode});
		//电子档案
		somElectronicDataSet_load();
		guidePeopleInit();
	}
	if(method=="update"||method=="hisDetail"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SESSION_ID",sessionId);
		somSessionDataSet.load();
		somSessionDataSet.on('load', sessionOnload);
		guidePeopleInit();
	}
	if(method=="detail"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SORG_ID",sorgId);
		somSessionDataSet.load();
		somSessionDataSet.on('load', sessionOnload);
		guidePeopleInit();
		somElectronicDataSet_load();
	}				
	aspForLiShi.on('load',function(){
		var peopleId='';
		aspForLiShi.each(function(record, index){
			if(record.get('sorgDuties') == "00012" && record.get('regStatus')=="1"){
				initLegalRecord=record;
				peopleId=record.get('peopleId');
			}
		});
		aspForLiShi.filterBy(function(record, id){
			if(record.get('sorgDuties') != "00012"){
				if(record.get('peopleId') == peopleId){
					record.set('ifLegal','1');
				}
				aspForLiShi.commitChanges();
				return record;
			}
		});
		
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
	
	if(method=="insert" || method=="update"){		
		somMeetingDataSet.setParameter("sorgId",sorgId);
		somMeetingDataSet.load();
	}
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
	var sorgDuties=currentPeople.get('sorgDuties');
	var records=dutySelectDic.query("value",sorgDuties);
	if(records.length>0){
		var sorgDutiesText = records.items[0].get("text");
		document.getElementById("sorgDutiesNameDispaly").value = sorgDutiesText;
	}
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
// 保存
function save(){
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	if(somSessionRecord.get("sessionId") == ""){
		L5.Msg.alert("提示","请先选择届次名称！");
		return false;
	}
	var aspForLiShiIsValidate = aspForLiShi.isValidate();
	if(aspForLiShiIsValidate != true){
		L5.Msg.alert("提示",aspForLiShiIsValidate);
		return false;
	}
	var aspForJianShiIsValidate = aspForJianShi.isValidate();
	if(aspForJianShiIsValidate != true){
		L5.Msg.alert("提示",aspForJianShiIsValidate);
		return false;
	}
	var somSessionDataSetIsValidate = somSessionDataSet.isValidate();
	if(somSessionDataSetIsValidate != true){
		L5.Msg.alert("提示",somSessionDataSetIsValidate);
		return false;
	}
	
	
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.setParameter("somSessionRecord", somSessionRecord);
	
	aspForLiShi.add(aspForJianShi.getAllRecords());
	if(initLegalRecord!=""){
		initLegalRecord.set("sorgId",sorgId);
		aspForLiShi.insert(aspForLiShi.getCount(),initLegalRecord);
	}
	
	command.setParameter("somDutyRecord", aspForLiShi.getAllRecords());
	//个人简历
	somResumeInsertDataSet.clearFilter();
	var somResumeRecords = somResumeInsertDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	if(method=="insert"){
		command.execute("changeRegPeople");
	}else if(method=="update"){
		command.execute("updateRegPeople");
	}
	
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			method="update";
			init();
		});	
	}else{
		L5.Msg.alert('提示',"保存时出现错误！");
	}
}
// 返回备案列表页面
function returnBack(){
	var data=new L5.Map();
	var url="";
	if(method=="insert" || method=="update" || method=="detail"){
		data.put("sorgId",sorgId);
		data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
		data.put("sorgCode",sorgCode);	
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
		data.put("searchSorgCode",searchSorgCode);	
		url="jsp/cams/sorg/manage/fund/fundManagePeopleList.jsp";
	}else if(method=="hisDetail"){
		data.put("sorgId",sorgId);
		data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
		data.put("sorgCode",sorgCode);	
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
		data.put("searchSorgCode",searchSorgCode);	
		url="jsp/cams/sorg/manage/fund/fundManagePeopleHis.jsp";	
	}
	L5.forward(url,'',data);	
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
		var day =startDate.substring(8,10);
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
		if("00001,00003,00004".indexOf(record.get('sorgDuties'))>-1){
			return record;
		}
	});
}


function showMeeting(){
	if(method == "update"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		var somSessionRecord=somSessionDataSet.getCurrent();
		if(somSessionRecord.get("seq")=="1"){
			return;
		}else{
			L5.Msg.alert("提示","不能修改届次信息!");
			return;
		}
	}else{
		var win=L5.getCmp("meetingWindow");
		win.show();
	}
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
	if(record.get("SESSIONSATUS") == "是"){
		L5.Msg.alert("提示","已经备案，请不要重复备案！");
		return;
	}
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somSessionRecord=somSessionDataSet.getCurrent();
	
	somSessionQueryDataSet.setParameter("SESSION_ID",record.get("MEETINGID"));
	somSessionQueryDataSet.load();
	somSessionQueryDataSet.on("load",function(){
			somSessionRecord.set("sessionId",record.get("MEETINGID"));
			somSessionRecord.set("sessionName",record.get("MEETINGNAME"));
			sessionId = record.get("MEETINGID");
			
			//把拟任负责人信息回填到负责人信息，增加到somduty中
			aspToDutyDataSet.setParameter("TASK_CODE",record.get("TASKCODE"));
			aspToDutyDataSet.load();
			aspToDutyDataSet.on("load",function(ds){
				aspToDutyDataSet.each(function(record, id){
					if("00006" == record.get('sorgDuties')){
						aspForJianShi.add(record);
					}else{
						aspForLiShi.add(record);
					}
				});
				//添加到负责人候选人列表
				toCurrentDataset();
				winCloseMeeting();
			});
			
	});
}

function back(){
	window.history.go(-1);	
}