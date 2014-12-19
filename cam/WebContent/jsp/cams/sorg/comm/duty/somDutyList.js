function init(){
	var somDutyDS=L5.DatasetMgr.lookup("somDutyDS");
	somDutyDS.load();
}
//查询
function forQuery(){
	var somDutyDS=L5.DatasetMgr.lookup("somDutyDS");
	var dutyCode=_$('dutyCode');
	var dutyName=_$('dutyName');
	somDutyDS.setParameter("CODE@=",dutyCode);
	somDutyDS.setParameter("NAME@=",dutyName);
	somDutyDS.load();
}
//增加
function addDuty(){
	var somDutyDS=L5.DatasetMgr.lookup('somDutyDS');
	var record=somDutyDS.newRecord();
	var dutyPanel = L5.getCmp('dutyPanel');
	dutyPanel.stopEditing();
}

//保存
function saveDuty(){
	var somDutyDS=L5.DatasetMgr.lookup('somDutyDS');
	//校验
	var records = somDutyDS.getAllChangedRecords();
	if(records=='' || records.length==0){
		L5.Msg.alert('提示','没有进行改动！');
		return;
	}
    var isValidate = somDutyDS.isValidate(true);
    if(isValidate !== true){
    	L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
        return false;
    }
	L5.MessageBox.confirm('确定', '你确定要保存吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.sorg.base.cmd.DicSomDutyCmd");
			command.setParameter("somDutys", records);
			command.execute("saveDuty");
			if (!command.error) {
				somDutyDS.commitChanges();
				L5.Msg.alert('提示','保存成功！');
			}else{
				L5.Msg.alert("错误","校验未通过,职务编码不能重复!");
			}
		}else{ 
			return;
		}
	}
	);	
}
//删除 
function deleteDuty(){
	var somDutyDS=L5.DatasetMgr.lookup("somDutyDS");
	var dutyPanel = L5.getCmp('dutyPanel');
	dutyPanel.stopEditing();
	var records= dutyPanel.getSelectionModel().getSelections();
	if(records.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	for(var i = 0; i < records.length; i++){
		if(records[i].get("code") == "00001" || records[i].get("code") == "00002"){
			L5.Msg.alert('提示','理事长和分支机构负责人为默认项，不能删除！');
			return;
		}
		somDutyDS.remove(records[i]);
	}

}
//取消
function undoDuty() {
	var somDutyDS=L5.DatasetMgr.lookup("somDutyDS");
	somDutyDS.rejectChanges();
}
function editableCode(){
	var sm = L5.getCmp("dutyPanel").getSelectionModel();
	var record = sm.getSelected();
	if(record.state == L5.model.Record.STATE_NEW){
		return true;
	}else{
		return false;
	}
}
function editableName(){
	var sm = L5.getCmp("dutyPanel").getSelectionModel();
	var record = sm.getSelected();
	if(record.get("code") == "00001" || record.get("code") == "00002"){
		return false;
	}else{
		return true;
	}
}
