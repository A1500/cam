var devRecord;
function init(){
 	var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
 	AssistiveDevicesDataset.setParameter("APPLY_ID",applyId);
 	AssistiveDevicesDataset.load();
 	var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
 	AssistiveDevicesPrDataset.setParameter("APPLY_ID",applyId);
 	AssistiveDevicesPrDataset.load();
 	AssistiveDevicesPrDataset.on("load",function(){
 		if(AssistiveDevicesPrDataset.get("checkIncharge")==""){
 			AssistiveDevicesPrDataset.set("checkIncharge",currentUserName);
 		};
 		if(AssistiveDevicesPrDataset.get("checkApproveDate")==""){
 			AssistiveDevicesPrDataset.set("checkApproveDate",getCurDate());
 		};
 		
 	});
 	
 	L5.getCmp("townapp").on("activate",function(){
 		if(organType=='14'){//街道
			L5.getCmp("submitButton").hide();
 		}	
 	});
	L5.QuickTips.init();
	
	L5.getCmp("changeTabPanel").on("activate",funcnotice);
	L5.getCmp("noticeTabPanel").on("activate",funcchange);
}

function funcnotice(){  
		var src = document.getElementById("changeIframe").src;
		document.getElementById("changeIframe").src=src;
}
function funcchange(){  
	var src = document.getElementById("noticIframe").src;
	document.getElementById("noticIframe").src=src;
}
function update(){
	var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
	var AssistiveDevicesRecord=AssistiveDevicesDataset.getCurrent();
	var isValidate = AssistiveDevicesDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var applyApparatusId = document.getElementById("applyApparatusId").value;
	if(applyApparatusId==''){
		L5.Msg.alert('提示',"申请器械不能为空!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	command.setParameter("record", AssistiveDevicesRecord);
	command.setParameter("records", devRecord);
	//command.setParameter("applyId", applyId);
	command.execute("update");
	if (!command.error) {
		AssistiveDevicesDataset.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
	/*var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	command.setParameter("records", devRecord);
	command.setParameter("applyId", applyId);
	command.execute("updatePeopleDevices");
	if (!command.error) {
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}*/
}


//更新审批表信息
function updateTownExamInfor(){
	var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
	var AssistiveDevicesPrRecord=AssistiveDevicesPrDataset.getCurrent();
	if(AssistiveDevicesPrRecord.get("checkIncharge")==""){
		L5.Msg.alert('提示',"负责人不能为空！");
		return false;
	}
	if(AssistiveDevicesPrRecord.get("checkApproveDate")==""){
		L5.Msg.alert('提示',"审核时间不能为空！");
		return false;
	}
	var isValidate = AssistiveDevicesPrDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrCommand");
	command.setParameter("record", AssistiveDevicesPrRecord);
	command.execute("update");
	if (!command.error) {
		AssistiveDevicesPrDataset.commitChanges();
		ifsave = true;
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function fun_close(){	 	
	window.close();	 
}

//选择器械
function selectDevices(){
	var applyApparatusId = document.getElementById("applyApparatusId").value;
	var url = "devicesSelect.jsp?applyId="+applyId+"&applyApparatusId="+applyApparatusId;
	var revalue = window.showModalDialog(url,"","dialogHeight:400px;dialogWidth:388px;resizable:no;scroll:no;");
	if (revalue!=undefined&&revalue.idAndName != "" && revalue.idAndName != undefined) {
		var list = revalue.idAndName.split(";");
		AssistiveDevicesDataset.getCurrent().set("applyApparatusId", list[0]);
		AssistiveDevicesDataset.getCurrent().set("apparatusName", list[1]);
		DevicesDataset.removeAll();
		for(var i=0;i<revalue.record.length;i++){ 
					
			DevicesDataset.newRecord({"applyApparatusId":revalue.record[i].data.applyApparatusId,"unit":revalue.record[i].data.unit,
				"apparatusName":revalue.record[i].data.apparatusName,"num":revalue.record[i].data.num});
	    } 
		devRecord =DevicesDataset.getAllRecords();
	}
	if(revalue==";;;;;;;"){
		devRecord="";
		
		AssistiveDevicesDataset.getCurrent().set("applyApparatusId", "");
		AssistiveDevicesDataset.getCurrent().set("apparatusName", "");
	}
}


//创建并发起流程
function createAndSend(){
	if(validateNotNull()){
	   if(checkProcessState("createAndSend")){
	   	  L5.getCmp("submitButton").setDisabled(true);
	      var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
		  var AssistiveDevicesRecord=AssistiveDevicesDataset.getCurrent();
	      var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	      command.setParameter("record", AssistiveDevicesRecord);
	      command.execute("createAndSend");
	      if(!command.error){
		   alert("流程发起并发送成功!");
		   //跳转到已办任务页面
		   var url = "jsp/workflow/tasklist/queryyiban.jsp";
		   L5.forward(url,"已办任务页面");
	     }else{
	     	L5.getCmp("submitButton").setDisabled(false);
	       alert(command.error);
	     }
	   }
	}
}

//根据值不同隐藏
function changeDiv(value){
	var report = document.getElementById("report");
	if(value==''){
		return;
	}else{
		if(value=='0'){
			report.style.display="none";
		}else{
			report.style.display="inline";
		}
	}
}

function createAndSend(){
	     var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	     command.setParameter("PEOPLE_ID", peopleId);
	     command.setParameter("APPLY_ID", applyId);
	     command.execute("verifyTownInfor");
	     var checkIncharge = command.getReturn("checkIncharge");
	     var checkApproveDate = command.getReturn("checkApproveDate");
	     var checkAgreeFlag = command.getReturn("checkAgreeFlag");
	     var reportFlag = command.getReturn("reportFlag");
	     if(checkIncharge=="undefined"||checkApproveDate=="undefined"||checkIncharge==null||checkApproveDate==null){
	     		L5.Msg.alert('提示','县级审核未填写完整！');
	     		return false;
	     }
	     if(checkAgreeFlag==null||checkAgreeFlag=="undefined"){
	     	L5.Msg.alert('提示','必须选择审核意见！');
	     	return false;
	     }
	     if(checkAgreeFlag=='1'&&(reportFlag==null||reportFlag=="undefined")){
	     	L5.Msg.alert('提示','必须选择是否上报！');
	     	return false;
	     }
	     var condition;
	     if(checkAgreeFlag=='0'){
	     	condition = "end";
	     }else if(checkAgreeFlag=='1'&&reportFlag=='0'){
	     	condition = "end";
	     }else{
	     	condition = "pass";
	     }
	     command.setParameter("condition",condition);
	     command.execute("createAndSend");
	     
	     if(!command.error){
			   alert("流程发起并发送成功!");
			   window.close();
			   /*var url = "jsp/workflow/tasklist/queryyiban.jsp";
			   L5.forward(url,"已办任务页面");*/
	     }else{
	      	alert(command.error);
	     }
}

function print() {
	var url=L5.webPath+"/jsp/cams/comm/print/jspcommonprint.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
