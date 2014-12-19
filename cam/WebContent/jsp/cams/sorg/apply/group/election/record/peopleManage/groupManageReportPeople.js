var fileCode = "S074";
var dutyId='';
var initLegalRecord="";//法定代表人的record

function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode
	if(method=="insert"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode,"sessionName":sessionName,"sessionId":sessionId});
		//把拟任负责人信息回填到负责人信息，增加到somduty中
			aspToDutyDataSet.setParameter("TASK_CODE",electionTaskCode);
			aspToDutyDataSet.load();
			aspToDutyDataSet.on("load",function(ds){
				somDutyDataSet.add(ds.getCurrent());
			});
		//电子档案
		somElectronicDataSet_load();	
		guidePeopleInit();
	}
	if(method=="update"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SESSION_ID",sessionId);
		somSessionDataSet.load();
		somSessionDataSet.on('load', sessionOnload);
		guidePeopleInit();
		somElectronicDataSet_load();
	}	
	if(method=="detail"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SORG_ID",sorgId);
		somSessionDataSet.load();
		somSessionDataSet.on('load', sessionOnload);
		guidePeopleInit();
		somElectronicDataSet_load();
	}	
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
	
	if(method=="insert" || method=="update"){		
		dutyFilter();
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
	ds.each(function(record, index){
		if(record.get('sorgDuties') == "00012" && record.get('regStatus')=="1"){
			initLegalRecord=record;
			peopleId=record.get('peopleId');
		}
	});
	ds.filterBy(function(record, id){
		if(record.get('sorgDuties') != "00012"){
			if(record.get('peopleId') == peopleId){
				record.set('ifLegal','1');
			}
			return record;
		}
	});
	ds.commitChanges();
}
// 增加负责人
function add(){
	updateRecord='';
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.execute('getDutyId');
	dutyId = command.getReturn('dutyId');
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifServe":"1","ifLegal":"0","sorgType":"S","regStatus":"1"});
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.removeAll();
	L5.getCmp("peopleWin").show();
	L5.getCmp("tabSomOrgan").setActiveTab("0");
	initPhoto("1");//初始化照片
	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步理事法律要件
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
	if(somSessionRecord.get("sessionId") == ""){
		L5.Msg.alert("提示","请先选择届次名称！");
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
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	//调用父页面方法刷新列表
	window.dialogArguments.queryElectionDealed();
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
		url="jsp/cams/sorg/manage/group/groupManagePeopleList.jsp";
		L5.forward(url,'',data);	
	}else if(method=="hisDetail"){
		data.put("sorgId",sorgId);
		data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
		data.put("sorgCode",sorgCode);	
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
		data.put("searchSorgCode",searchSorgCode);	
		url="jsp/cams/sorg/manage/group/groupManagePeopleHis.jsp";	
		L5.forward(url,'',data);	
	}
	else if(method=="hisDetail2"){
		back();
	}
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

function back(){
	window.history.go(-1);	
}

function closeW(){
	L5.MessageBox.confirm('请确定关闭前是否保存', '点确定保存后关闭，点取消直接关闭',function(sta){
		if(sta=="yes"){
			save();
			window.close();	
		}else{
			window.close();	
		}
	});	
	
}

function closeWD(){
	window.close();	
}