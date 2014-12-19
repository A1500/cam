function init(){
	var dsTested= L5.DatasetMgr.lookup("dsTested");
	dsTested.setParameter("PEOPLE_ID",peopleId);
	dsTested.load();
	
	L5.QuickTips.init();
}

function save(){
	var dsTested = L5.DatasetMgr.lookup("dsTested");
	var testedEntity=dsTested.getCurrent();
//	warEntity.set("peopleId",peopleId);
	
	var isValidate = dsTested.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleTestedCommand");
	command.setParameter("testedEntity", testedEntity);
	command.execute("updateTested");
	
	if (!command.error) {
		dsTested.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function back(){
	history.go(-1);
}