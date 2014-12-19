function init(){
	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");
	if(method=="insert"){
		cdcNoticeDataset.newRecord({"organArea":organCode,"organName":organName,"parentCode":parentCode,
				"username":organName,"organLevel":organLevel,"noticeType":"2"});
	}else{
		cdcNoticeDataset.setParameter("NOTICE_ID@=",noticeId);
		cdcNoticeDataset.load();
	}
}
function save(){
	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");
	var isValidate = cdcNoticeDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	var nameVaule=document.getElementById('name').value;
	if(nameVaule==null||nameVaule==''){
		L5.Msg.alert("提示", "主题不能为空!");
		return;
	}
	var record = cdcNoticeDataset.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcNoticeInfoCmd");
	command.setParameter("record",record);
	command.setForm("form1");
	if(method=="insert"){
		command.execute("insert");
	}else {
		command.execute("update");
	}
	if (!command.error){ 
			L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
	
}
function returnBack(){
	history.go(-1);
}
