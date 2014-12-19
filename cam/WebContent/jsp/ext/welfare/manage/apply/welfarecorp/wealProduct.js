function init() {
	//L5.DatasetMgr.lookup("ds").load();	
	//L5.QuickTips.init();
	ds.setParameter("TASK_CODE@=",taskCode);
	ds.load();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/*function query(){		
	ds.setParameter("WEAL_WORKER.ID_CARD@=",getParam("idCard"));		
	ds.setParameter("WEAL_WORKER.NAME@=",getParam("name"));		
	ds.setParameter("WEAL_WORKER.CERT_CODE@=",getParam("certCode"));		
	ds.setParameter("WEAL_WORKER.CERT_SPECIAL_CODE@=",getParam("certSpecialCode"));		
	ds.load();
}*/

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute();
	var produceId=command.getReturn("id");
	ds.newRecord({"taskCode":taskCode,"produceId":produceId});	

}

function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("produceId");
			}
			var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitProductivepowerCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
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
	
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitProductivepowerCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!",function(){
			window.close();
		});
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function close(){
	 window.returnvalue=true;
}

