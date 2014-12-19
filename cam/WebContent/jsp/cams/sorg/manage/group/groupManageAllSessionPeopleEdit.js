var fileCode = "S074";
var dutyId='';
var initLegalRecord="";//法定代表人的record
function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode
	if(method=="insert"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode});
		//电子档案
		somElectronicDataSet_load();	
		guidePeopleInit();
	}else if(method=="update"||method=="detail"||method=="hisDetail"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SORG_ID",sorgId);
		if(method=="hisDetail"){
			somSessionDataSet.setParameter("SESSION_ID",sessionId);
		}
		somSessionDataSet.load();
		somSessionDataSet.on('load', sessionOnload);
		guidePeopleInit();
	}	
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
	
	if(method=="insert" || method=="update"){		
		dutyFilter();
	}
}
function sessionOnload(ds){
	ds.un("load",sessionOnload);
	var record=ds.getCurrent();
	taskCode=record.get("taskCode");
	//加载简历信息
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", record.get('taskCode'));
	somResumeDataSet.load();
	somResumeDataSet.on('load',resumeOnload);
	//电子档案
	somElectronicDataSet_load();	
}
function resumeOnload(ds){
	ds.un("load",resumeOnload);
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.setParameter("SESSION_ID", sessionId);
	somDutyDataSet.load();
	somDutyDataSet.on('load',dutyOnload);
}
function dutyOnload(ds){
	ds.un("load",dutyOnload);
	var peopleId='';
	somDutyDataSet.each(function(record, index){
		if(record.get('sorgDuties') == "00012" && record.get('regStatus')=="1"){
			initLegalRecord=record;
			peopleId=record.get('peopleId');
		}
	});
	somDutyDataSet.filterBy(function(record, id){
		if(record.get('sorgDuties') != "00012"){
			if(record.get('peopleId') == peopleId){
				record.set('ifLegal','1');
			}
			return record;
		}
	});
	somDutyDataSet.commitChanges();
}
// 增加负责人
function add(){
	updateRecord='';
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.execute('getDutyId');
	dutyId = command.getReturn('dutyId');
	somDutyInsertDataSet.removeAll();
	
	//判断一下当前修改的届次是不是最新的，如果是最新的新增的人员状态为有效，否则为无效
	var somCurrentSessionDataSet=L5.DatasetMgr.lookup("somCurrentSessionDataSet");
	somCurrentSessionDataSet.setParameter("SORG_ID",sorgId);
	somCurrentSessionDataSet.load();
	somCurrentSessionDataSet.on('load', function(ds){
		if(sessionId == ds.get("sessionId")){
			somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifServe":"1","ifLegal":"0","sorgType":"S","regStatus":"1"});
		}else{
			somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifServe":"0","ifLegal":"0","sorgType":"S","regStatus":"2"});
		}
		var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
		somResumeInsertDataSet.removeAll();
		L5.getCmp("peopleWin").show();
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		initPhoto("1");//初始化照片
		somPeopleElectronicDataSet_load(fileCode,dutyId);//同步理事法律要件
	});
}
var updateRecord;
// 修改负责人
function update(){
	var grid=L5.getCmp("peopleGrid");
	updateRecord=grid.getSelectionModel().getSelected();
	if(!updateRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	dutyId=updateRecord.get('dutyId');
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,updateRecord.copy());
	L5.getCmp("peopleWin").show();
	L5.getCmp("tabSomOrgan").setActiveTab("0");
	var birthday=updateRecord.get("birthday");
	showAge(birthday);
	synPhoto(somDutyDataSet.get("photoId"),"1");//同步照片
	//处理个人简历
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(updateRecord.get('dutyId')==somResumeRecord.get('dutyId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	
	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步理事法律要件
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
// 保存
function save(){
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var somDutyDataSetValidate = somDutyDataSet.isValidate();
	if(somDutyDataSetValidate != true){
		L5.Msg.alert("提示",somDutyDataSetValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.setParameter("somSessionRecord", somSessionRecord);
	if(initLegalRecord!=""){
		somDutyDataSet.insert(somDutyDataSet.getCount(),initLegalRecord);
	}
	command.setParameter("somDutyRecord", somDutyDataSet.getAllRecords());
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.execute("updateRegPeople");
	
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			init();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
// 返回备案列表页面
function returnBack(){
	var data=new L5.Map();
	var url="";
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);	
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	url="jsp/cams/sorg/manage/group/groupManageAllSessionPeople.jsp";	
	L5.forward(url,'',data);	
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

//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}