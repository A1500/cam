function init(){
			var DisabilityNoticeDataset=L5.DatasetMgr.lookup("DisabilityNoticeDataset");
			DisabilityNoticeDataset.setParameter("PEOPLE_ID",peopleId);
			DisabilityNoticeDataset.setParameter("APPLY_ID",applyId);
			DisabilityNoticeDataset.setParameter("SERVICE_TYPE",serviceType);
			DisabilityNoticeDataset.load();
			L5.QuickTips.init(); 
}

function saveClick(){
	
	//受理通知书
	var DisabilityNoticeDataset = L5.DatasetMgr.lookup("DisabilityNoticeDataset");
	var DisabilityNoticeRecord=DisabilityNoticeDataset.getCurrent();
	var isValidate = DisabilityNoticeDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var noticeDate = DisabilityNoticeRecord.get("noticeDate");
	if(noticeDate!=''&&!validateDateFormat(noticeDate)){
		L5.Msg.alert("提示","通知书日期格式不正确!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityNoticeCommand");
	command.setParameter("DisabilityNoticeRecord", DisabilityNoticeRecord);
	command.execute("update");
	
	if (!command.error) {
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){	
	window.close();	
}