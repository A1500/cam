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
		somSessionDataSet.on('load', function(){
			var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
			var record=somSessionDataSet.getCurrent();
			taskCode=record.get("taskCode");
			//加载简历信息
			var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
			somResumeDataSet.setParameter("TASK_CODE@=", record.get('taskCode'));
			somResumeDataSet.load();
			somResumeDataSet.on('load',function(){
				var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
				somDutyDataSet.setParameter("SESSION_ID", record.get('sessionId'));
				somDutyDataSet.load();
				somDutyDataSet.on('load',function(){
					var peopleId='';
					somDutyDataSet.each(function(record, index){
						if(record.get('sorgDuties') == "00012"){
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
				});
			});
			//电子档案
			somElectronicDataSet_load();	
		});
			
		guidePeopleInit();
	}
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});	
	}		
}
// 增加负责人
function add(){
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.newRecord({"ifServe":"1","ifPartyLeader":"0","sorgType":"M","ifLegal":"0","regStatus":"1"});
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.removeAll();
	L5.getCmp("peopleWin").show();
	L5.getCmp("peopleWin").on("show",idCardFocus);
}
function idCardFocus(){
	$("idCard").focus();
}
// 修改负责人
function update(){
	var grid=L5.getCmp("peopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	
	//处理个人简历
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('peopleId')==somResumeRecord.get('peopleId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	//处理个人简历完成
	
	L5.getCmp("peopleWin").show();
	L5.getCmp("peopleWin").on("show",idCardFocus);
	var birthday=record.get("birthday");
	showAge(birthday);
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
	
	//个人简历处理
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('peopleId')==somResumeRecord.get('peopleId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	
	L5.getCmp("peopleWin").show();
	showAge();
	L5.getCmp("peopleWin").on("show",idCardFocus);
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
	command.setParameter("somDutyRecord", somDutyDataSet.getAllChangedRecords());
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
			history.go(-1);
		});
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！");
	}
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
