function init(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	samGeroKeptPersonDataSet.setParameter("PERSON_ID@=",personId);
	samGeroKeptPersonDataSet.load();
	document.getElementById("gerocomiumName").value=gerocomiumName;
}
function save(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var recordPerson=samGeroKeptPersonDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonCmd");
	command.setParameter("record",recordPerson);
	command.execute("update");
	if (!command.error){
		L5.Msg.alert("提示","修改成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.close();
}