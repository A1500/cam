
function init() {
		var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
		BaseinfoPeopleDataSet.load();
		var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.load();
		L5.QuickTips.init(); 
}

//修改人员信息
function peopleUpdate(){
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
	
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.execute("updatePeople");
	
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//修改家庭信息
function familyUpdate(){
	var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	var BaseinfoFamilyRecord=BaseinfoFamilyDataSet.getCurrent();
	
	var isValidate = BaseinfoFamilyDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
	
	command.setParameter("BaseinfoFamilyRecord", BaseinfoFamilyRecord);
	command.execute("updateFamily");
	
	if (!command.error) {
		BaseinfoFamilyDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function stop(){
   window.close();
}
function returnClick(){	
	var url='jsp/cams/bpt/disability/disabilityList.jsp';
	var text='基础信息_人员信息';
	L5.forward(url,text);	
}
