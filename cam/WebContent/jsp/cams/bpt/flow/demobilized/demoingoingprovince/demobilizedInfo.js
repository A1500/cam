function init(){
    PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    PeopleDemobilizedDataset.load();
}
function saveClick(){
    var ds=L5.DatasetMgr.lookup("PeopleDemobilizedDataset");

	var valid = ds.isValidate(true);
	if(valid !== true){
		alert("校验未通过，不能保存！"+valid);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand"); 
	command.setParameter("PeopleDemobilizedRecord",ds.getCurrent());
	command.execute("update");	
	
   if (!command.error) {
		L5.Msg.alert('提示', '保存成功！');
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function returnClick(){
   history.go(-1);
}