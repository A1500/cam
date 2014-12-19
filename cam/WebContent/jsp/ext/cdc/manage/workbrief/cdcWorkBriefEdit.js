function init(){
	var cdcWorkInfoDataSet=L5.DatasetMgr.lookup("cdcWorkInfoDataSet");
	if(method=="insert"){
		cdcWorkInfoDataSet.newRecord({"organCode":organCode,"organName":organName});
	}else{
		cdcWorkInfoDataSet.setParameter("WORK_ID@=",workId);
		cdcWorkInfoDataSet.load();
	}
}
function save(){
	var cdcWorkInfoDataSet=L5.DatasetMgr.lookup("cdcWorkInfoDataSet");
	var record=cdcWorkInfoDataSet.getCurrent();
	if(_$("name")==""){
		alert("主题不能为空!");
		return;
	}
	/*
	if(_$("kind")==""){
		alert("简报类别不能为空!");
		return;
	}
	*/
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcWorkInfoCmd");
	command.setParameter("record",record);
	command.setForm("form1");
	if(method=="insert"){
		record.set("workType","1");
		command.execute("insert");
	}else if(method=="update"){
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