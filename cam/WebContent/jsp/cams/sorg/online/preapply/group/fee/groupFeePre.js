function init(){
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	somFeeDataSet.setParameter("TASK_CODE@=",taskCode);
	somFeeDataSet.load();
	somFeeDataSet.on('load', function(){
	
		var record=somFeeDataSet.getCurrent();
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on("load",fillOrganInfo);
		//清空会议名称
		record.set("meetingName","");
	});
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
function fillOrganInfo(applyds){
	sorgId = applyds.get("sorgId");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		var sorgCode = somOrganDataSet.get("sorgCode");
		somOrganDataSetQuery.setParameter("SORG_CODE@=",sorgCode);
		somOrganDataSetQuery.setParameter("SORG_TYPE@=","S");
		somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
		somOrganDataSetQuery.load();
		somOrganDataSetQuery.on("load",function(){
			if(somOrganDataSetQuery.getCount() == 0){
				L5.Msg.alert("提示","根据录入的登记证号没有查到相应的社会组织,不能进行会费标准备案，请确认并修改登记证号！",function(){
					$("cnName").value = "";
					$("sorgCode").value = "";
					return false;
				});
			}else{
				sorgIdExist = somOrganDataSetQuery.get("sorgId");
				$("cnName").value = somOrganDataSetQuery.get("cnName");
				$("sorgCode").value = somOrganDataSetQuery.get("sorgCode");
				//查询换届会议信息
				somMeetingDataSet.setParameter("sorgId",sorgIdExist);
				somMeetingDataSet.load();
			}
		});
	});
}
function checkSorgCode(){
	somOrganDataSetQuery.setParameter("SORG_CODE@=",_$("sorgCode"));
	somOrganDataSetQuery.setParameter("SORG_TYPE@=","S");
	somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSetQuery.load();
}
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function save(){
	if(_$("sorgCode")==""){
		L5.Msg.alert("提示","请填写登记证号！");
		return;
	}
	if(_$("meetingName")==""){
		L5.Msg.alert("提示","请填写会议名称！");
		return;
	}
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var validate=somFeeDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	
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
	somFeeRecord.set("sorgId",sorgIdExist);
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	somApplyRecord.set("sorgId",sorgIdExist);
	
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomFeeCmd");
	command.setParameter("somFeeRecord",somFeeRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("insertPre");
	
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			updateOnlineStatusPass(somApplyRecord.get("taskCode"));
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出现错误！");
	}
}
function returnBack(){
	window.history.go(-1);	
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
function chooseMeeting(){
	var grid=L5.getCmp("meetingGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(record.get("FEESATUS") == "是"){
		L5.Msg.alert("提示","已经进行过会费标准备案，请不要重复备案！");
		return;
	}
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var somFeeRecord=somFeeDataSet.getCurrent();
	somFeeRecord.set("meetingId",record.get("MEETINGID"));
	somFeeRecord.set("meetingName",record.get("MEETINGNAME"));
	somFeeRecord.set("meetingDate",record.get("MEETINGDATE"));
	winCloseMeeting();
}