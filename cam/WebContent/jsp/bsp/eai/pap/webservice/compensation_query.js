function init() {
	L5.DatasetMgr.lookup("compensationDataSet").load();

	L5.QuickTips.init();
}
var res;
if(!res) res = {};
res.prompts = '提示 ';
/*
 * 补偿
 */
function compensate_click(){
	var compensationGrid = L5.getCmp("compensationGrid");
	var selected = compensationGrid.getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.MessageBox.alert(res.prompts,'必须选择一条记录！');
		return;
	}
	var command=new L5.Command("org.loushang.bsp.eai.pap.compensation.cmd.CompensationCommand");
	command.setParameter("record", selected[0]);
	command.execute("compensation");
	if (!command.error) {
		L5.MessageBox.alert(res.prompts,"补偿成功");
	}else{
		L5.MessageBox.alert(res.prompts,command.error);
	}
}