function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	
	if(method=="insert"){
		var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
		somFeeDataSet.newRecord({"sorgId":sorgId ,"taskCode":taskCode});
		somMeetingDataSet.setParameter("MEETING_ID",meetingId);
		somMeetingDataSet.load();
		somMeetingDataSet.on('load',function(){
			var somFeeRecord=somFeeDataSet.getCurrent();
			somFeeRecord.set("meetingId",somMeetingDataSet.get("meetingId"));
			somFeeRecord.set("meetingName",somMeetingDataSet.get("meetingName"));
			somFeeRecord.set("meetingDate",somMeetingDataSet.get("meetingDate"));
			somFeeRecord.set("shouldNum",somMeetingDataSet.get("shouldNum"));
			somFeeRecord.set("realNum",somMeetingDataSet.get("realNum"));
			somFeeRecord.set("passNum",somMeetingDataSet.get("passNum"));
			somFeeRecord.set("nopassNum",somMeetingDataSet.get("nopassNum"));
			somFeeRecord.set("giveupNum",somMeetingDataSet.get("giveupNum"));
			somFeeRecord.set("meetingPlace",somMeetingDataSet.get("meetingPlace"));
			
		});
	}else if(method=="detail"||method=="update"){
		var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
		somFeeDataSet.setParameter("MEETING_ID@=",meetingId);
		somFeeDataSet.load();
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
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function save(){
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var validate=somFeeDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	
	//电话校验
	var isPhone=_$("linkPhone");
	if(isPhone!=""){
	if(!isTel(isPhone)){
		L5.Msg.alert("提示","联系电话校验未通过！");
		return false;
	}}
	//数字校验
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
	
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var somFeeRecord=somFeeDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomFeeCmd");
	command.setParameter("somFeeRecord",somFeeRecord);
	if(method=="insert"){
		command.execute("insertFeeAddApply");
	}else if(method=="update"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			method="update";
			init();
		});
	}else{
		L5.Msg.alert("提示","保存出现错误！");
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
	var url="jsp/cams/sorg/manage/group/groupFee.jsp";
	L5.forward(url,'',data);	
}
function returnBackHistory(){
	window.history.go(-1);	
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
