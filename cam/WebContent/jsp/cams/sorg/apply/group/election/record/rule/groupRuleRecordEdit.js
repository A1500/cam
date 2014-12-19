function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	if(method=="insert"){
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode});
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"sorgId":sorgId,"sorgType":"S","taskCode":taskCode,"borgName":borgName});
		somMeetingDataSet.setParameter("MEETING_ID",meetingId);
		somMeetingDataSet.load();
		somMeetingDataSet.on('load',function(){
			var somRuleRecord=somRuleDataSet.getCurrent();
			somRuleRecord.set("meetingId",somMeetingDataSet.get("meetingId"));
			somRuleRecord.set("meetingName",somMeetingDataSet.get("meetingName"));
			somRuleRecord.set("meetingFormat",somMeetingDataSet.get("meetingFormat"));
			somRuleRecord.set("meetingDate",somMeetingDataSet.get("meetingDate"));
			somRuleRecord.set("shouldNum",somMeetingDataSet.get("shouldNum"));
			somRuleRecord.set("realNum",somMeetingDataSet.get("realNum"));
			somRuleRecord.set("passNum",somMeetingDataSet.get("passNum"));
			somRuleRecord.set("nopassNum",somMeetingDataSet.get("nopassNum"));
			somRuleRecord.set("giveupNum",somMeetingDataSet.get("giveupNum"));
		});
	}else{
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.setParameter("MEETING_ID@=",meetingId);
		somRuleDataSet.load();
		somRuleDataSet.on('load', function(){
			var record=somRuleDataSet.getCurrent();
			var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
			somApplyDataSet.setParameter("TASK_CODE@=",record.get("taskCode"));
			somApplyDataSet.load();
		});
	}
	//电子档案
	somElectronicDataSet_load();		
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});	
	}
}
function save(){
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	var validate=somRuleDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var shouldNum=_$("shouldNum");
	var realNum=_$("realNum");
	var passNum=_$("passNum");
	var nopassNum=_$("nopassNum");
	var givenupNum=_$("giveupNum");
	if(givenupNum!=""|nopassNum!=""|passNum!=""|realNum!=""){
		var num=parseInt(givenupNum)+parseInt(nopassNum)+parseInt(passNum);
		if(num!=realNum){
			L5.Msg.alert("提示","人数逻辑出错！");
			return false;
		}
	}
	
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(method=="insert"){
		somRuleRecord.set("ifDraft","1");
	}
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomRuleCmd");
	command.setParameter("somRuleRecord",somRuleRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="insert"){
		command.execute("insertWithoutMeeting");
	}else if(method=="update"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			method= "update";
			init();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
	//调用父页面方法刷新列表
	window.dialogArguments.queryElectionDealed();
}
function returnBack(){
	var data=new L5.Map();
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);	
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/group/groupRule.jsp";
	L5.forward(url,'',data);	
}
function returnBackHistory(){
	window.history.go(-1);	
}
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}

function showMeeting(){
	var win=L5.getCmp("meetingWindow");
	win.show();
}

function winCloseMeeting(){
	var win=L5.getCmp("meetingWindow");
	win.hide();
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