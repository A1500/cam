function init(){
	var camsBriefCountDataSet = L5.DatasetMgr.lookup("camsBriefCountDataSet");
	camsBriefCountDataSet.setParameter("ORGAN_AREA",organArea);
	camsBriefCountDataSet.setParameter("REPORT_SEASON",reportSeason);
	camsBriefCountDataSet.setParameter("sort","ENTER_SERIAL_NUM");
	camsBriefCountDataSet.setParameter("dir","asc");
	camsBriefCountDataSet.load();
}

function save(){
	var camsBriefCountDataSet=L5.DatasetMgr.lookup("camsBriefCountDataSet");
	var records=camsBriefCountDataSet.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsBriefCountCmd");
	command.setParameter("records",records);
	command.execute("saveBrief");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			init();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}

function returnBack(){
	history.go(-1);
}
