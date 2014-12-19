

function init() {
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//
function query(){
	//ds.load();
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	ds.newRecord();

}

function del() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	var sm = Grid.getSelectionModel();
	var cell = sm.getSelectedCell();
	if (cell) {
		var record = ds.getAt(cell[0]);
		ds.remove(record);
	}
}
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}

	var command = new L5.Command("org.loushang.bsp.organization.cmd.PubStruVersionCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',command.error);
	}
}

function reset() {
	ds.rejectChanges();
}


