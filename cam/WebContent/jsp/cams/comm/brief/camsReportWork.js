function init(){
	if(method=="insert"){
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
		reportWorkDataSet.newRecord();
	 }else{
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
		reportWorkDataSet.setParameter("WORK_ID@=",workId);
		reportWorkDataSet.load();
	} 
}
function backInfo(){
	history.go(-1);
}
function save(){
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(document.getElementById("workDesc").value==""){
		L5.Msg.alert("提示","上报期数描述不能为空！");
		return;
	}
	if(document.getElementById("workYear").value==""){
		L5.Msg.alert("提示","上报年份不能为空！");
		return;
	}
	if(document.getElementById("workQuarter").value==""){
		L5.Msg.alert("提示","上报季度不能为空！");
		return;
	}
	var record=reportWorkDataSet.getCurrent();
	//校验是否已录该期数
	var commandifRepeat=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsReportWorkCommand");
	commandifRepeat.setParameter("workId",record.get("workYear")+"-0"+record.get("workQuarter"));
	commandifRepeat.execute("ifRepeated");//判断本批次是否已录该区划
	var ifRepeatTips = commandifRepeat.getReturn("ifRepeatTips");
	if(ifRepeatTips){
		L5.Msg.alert("提示",ifRepeatTips);
		return false;
	}
	record.set("status",'1');
	var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsReportWorkCommand");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function returnBack(){
	history.go(-1);
}


 