function init(){
	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");
	var targetToDataSet=L5.DatasetMgr.lookup("targetToDataSet");
	targetToDataSet.load();
	targetToDataSet.on("load",function(){
		setTargetTo();
	});
	if(method=="insert"){
		if(organLevel=="JD"){
			cdcNoticeDataset.newRecord({"organArea":organCode,"organName":organName,"parentCode":parentCode,
					"username":organName,"organLevel":"14","noticeType":"1"});
		}else{
			cdcNoticeDataset.newRecord({"organArea":organCode,"organName":organName,"parentCode":parentCode,
					"username":organName,"organLevel":organLevel,"noticeType":"1"});
		}
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
	var targetTo=document.getElementById("targetTo").value;
	if(targetTo==null||targetTo==''){
		L5.Msg.alert("提示", "下发至不能为空!");
		return;
	}
	var record = cdcNoticeDataset.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcNoticeInfoCmd");
	command.setParameter("record",record);
	command.setForm("form1");
	if(method=="update"){
		command.execute("update");
	}else if(method="insert"){
		command.execute("insert");
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
function setTargetTo(){
	var targetTo = document.getElementById("targetTo");
	if(organLevel=="11"){
			for(var  i = 11;i <=11;i++ ){
				for(var v = 0;v<targetTo.options.length;v++ ){
					if(targetTo.options[v].value == ''+i+''){
						targetTo.options.remove(v);
					}
				}
			}
		}else if(organLevel=="12"){
			for(var  i = 11;i <=12;i++ ){
				for(var v = 0;v<targetTo.options.length;v++ ){
					if(targetTo.options[v].value == ''+i+''){
						targetTo.options.remove(v);
					}
				}
			}
		}else if(organLevel=="13"){
			for(var  i = 11;i <=13;i++ ){
				for(var v = 0;v<targetTo.options.length;v++ ){
					if(targetTo.options[v].value == ''+i+''){
						targetTo.options.remove(v);
					}
				}
			}
		}else if(organLevel=="JD"){
			for(var  i = 11;i <=14;i++ ){
				for(var v = 0;v<targetTo.options.length;v++ ){
					if(targetTo.options[v].value == ''+i+''){
						targetTo.options.remove(v);
					}
				}
			}
		}
}