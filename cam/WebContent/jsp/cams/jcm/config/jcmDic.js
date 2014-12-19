function init(){
	var jcmDicDataSet=L5.DatasetMgr.lookup("jcmDicDataSet");
	jcmDicDataSet.load();
	
}
function inserts(){
	var jcmDicDataSet=L5.DatasetMgr.lookup("jcmDicDataSet");
	jcmDicDataSet.newRecord({
			id:uuid
		});
}
function dels(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmDicCmd");
			command.setParameter("id",records[0].get("id"));
			command.execute("delete");
			if (!command.error){
				init();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function save(){
	var jcmDicDataSet=L5.DatasetMgr.lookup("jcmDicDataSet");
	var records = jcmDicDataSet.getAllChangedRecords();
	var isValidate1 = jcmDicDataSet.isValidate();
	if(isValidate1 != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate1);
		return false;
	}
	
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmDicCmd");
	command.setParameter("records",records);
	command.execute("save");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			//returnBack();
			jcmDicDataSet.load(true);
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function returnBack(){
	history.go(-1);
}
