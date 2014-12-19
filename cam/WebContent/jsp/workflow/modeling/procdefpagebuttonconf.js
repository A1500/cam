function init(){
	var procDefPageButtonDefDataset=L5.DatasetMgr.lookup("procDefPageButtonDefDataset");
	procDefPageButtonDefDataset.load();
}
/**
 * 事件处理：点击增加按钮
 */
function Evt_butinsert_click() {
	procDefPageButtonDefDataset.newRecord(
	{"id":"","displayName":"","displayOrder":"","description":"","pluginType":"","needSetProcType":"0"});
}
/**
 * 事件处理：点击删除按钮
 */
function Evt_butdelete_click() {
	var editGridPanel = L5.getCmp('editGridPanel');
	var selected = editGridPanel.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择要删除的记录！");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
		if(state=="yes"){
			var deleteSelected = [];
			for(var i = 0; i < selected.length; i++) {
				if(selected[i].state == 1) {
					procDefPageButtonDefDataset.remove(selected[i]);
				} else {
					deleteSelected[i] = selected[i];
				}
			}
			if (deleteSelected.length < 1) {
				return;
			} else {
				var command=new L5.Command(
						"org.loushang.workflow.processdefinition.procdefpagebuttondef.cmd.ProcDefPageButtonDefCmd"); 
				command.setParameter("selected", deleteSelected);
				command.execute("delete");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					procDefPageButtonDefDataset.load();
				} else {
					alert(command.error);
				}
			}   
		}else{
			return false;
		}
	});
}
/**
 * 事件处理：点击保存按钮
 */
function Evt_butsave_click() {
	var procDefPageButtonDefDataset=L5.DatasetMgr.lookup("procDefPageButtonDefDataset");
	
	//获取所有被修改的record:增加的、删除的、修改的
	var records = procDefPageButtonDefDataset.getAllChangedRecords();
	if(records.length<1){//没有做任何修改,返回
		L5.Msg.alert("提示","没有需要保存的数据! ");
		return false;
	}
	//grid内容校验
	var valid = procDefPageButtonDefDataset.isValidate();
	if (valid != true) {
		L5.Msg.alert("提示",valid.replace("displayName","【按钮名称】").replace("displayOrder","【显示顺序】").replace("number","必须为数字"));
		return false;
	}
	// FactSaveCommand是继承自BaseAjaxCommand，在使用时需要手动创建Command实例，并通过该实例调用execute方法，执行FactSaveCommand中的相关方法。
	var command = new L5.Command("org.loushang.workflow.processdefinition.procdefpagebuttondef.cmd.ProcDefPageButtonDefCmd");
	//向command中传递参数：将所有被修改记录传递给FactSaveCommand
	command.setParameter("records", records);
	// execute方法可以指定参数，如果要执行的cmd中的方法名不是execute，则需要在参数中写明方法名，如command.execute(“save”);
	command.execute("update");
	//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
	if (!command.error) {
		procDefPageButtonDefDataset.commitChanges();
		L5.Msg.alert("提示","保存数据成功! ");
		procDefPageButtonDefDataset.load();
	}else{
		L5.Msg.alert("提示",command.error);
	}
}
/**
 * 事件处理：点击取消按钮
 */
function Evt_butundo_click() {
	var procDefPageButtonDefDataset=L5.DatasetMgr.lookup("procDefPageButtonDefDataset");
	//dataset取消所有修改
	procDefPageButtonDefDataset.rejectChanges();
}

function setText(record)
{
	if(record=="1")return "是";
	return "否";
}
