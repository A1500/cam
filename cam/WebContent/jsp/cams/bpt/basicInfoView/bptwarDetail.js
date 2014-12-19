function init(){
	var dsWar= L5.DatasetMgr.lookup("dsWar");
	dsWar.setParameter("PEOPLE_ID",peopleId);
	dsWar.load();
	
	L5.QuickTips.init();
}

function save(){
	var dsWar = L5.DatasetMgr.lookup("dsWar");
	var warEntity=dsWar.getCurrent();
//	warEntity.set("peopleId",peopleId);
	
	var isValidate = dsWar.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
	
	command.setParameter("warEntity", warEntity);
	command.execute("updateWar");
	
	if (!command.error) {
		dsWar.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function back(){
	history.go(-1);
}