function init() {	
	 RetiredSoldierDataSet.setParameter("peopleId",peopleId);
     RetiredSoldierDataSet.load();
}

function saveClick(){
     // 60周岁以上农村籍退役士兵信息修改
	var RetiredSoldierDataSet = L5.DatasetMgr.lookup("RetiredSoldierDataSet");
	var retiredSoldierRecord=RetiredSoldierDataSet.getCurrent();
		retiredSoldierRecord.set("peopleId",peopleId);
	var isValidate = RetiredSoldierDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	 var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierCommand");
	command.setParameter("RetiredSoldierRecord", retiredSoldierRecord);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}


 function back()
 {	 	history.go(-1);	 
 }