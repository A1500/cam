function init(){
	if(method=="insert"){
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
		reportWorkDataSet.newRecord();
	}else{
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
		reportWorkDataSet.setParameter("WORK_ID@=",workId);
		reportWorkDataSet.load();
		reportWorkDataSet.on("load",function(){
			var record = reportWorkDataSet.getCurrent();
			if(record.get("reportId")=="report1"){
				document.getElementById("jieci").disabled =true;
			}
		});
	}
	if(method=="update"){
		$("reportDate").disabled=true;
		$("reportId").disabled=true;
	}
}
function save(){
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	var valid=reportWorkDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	
	var record=reportWorkDataSet.getCurrent();
	if((record.get("reportId")=="report2")){
		if(document.getElementById("jieci").value==""){
			L5.Msg.alert("提示","校验未通过，不能保存！"+"农村民主选举界次不能为空！");
			return false;
		}
		var reg=/^\d+$/; 
   		if ((document.getElementById("jieci").value.match(reg)== null)) {
	   		L5.Msg.alert("提示","校验未通过，不能保存！"+"农村民主选举界次格式不正确！");
			return false;
   		}
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcReportWorkCmd");
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
		L5.Msg.alert("提示","保存出错！");
	}
}

function reportIdChenges(){
	var type = document.getElementById("reportId").value;
	if(type != "report2"){
		document.getElementById("jieci").disabled =true;
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
		var record=reportWorkDataSet.getCurrent();
		record.set("countryElectionSeason","");
	}else {
		document.getElementById("jieci").disabled =false;
	}
}
function returnBack(){
	history.go(-1);
}