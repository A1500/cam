function init(){
	var dicJcmDetailsDataSet=L5.DatasetMgr.lookup("dicJcmDetailsDataSet");
	dicJcmDetailsDataSet.load();
	
}
function inserts(){
	var dicJcmDetailsDataSet=L5.DatasetMgr.lookup("dicJcmDetailsDataSet");
	dicJcmDetailsDataSet.newRecord();
}
function dels(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var dicJcmDetailsDataSet=L5.DatasetMgr.lookup("dicJcmDetailsDataSet");
	dicJcmDetailsDataSet.remove(records[0]);
}
function save(){
	var dicJcmDetailsDataSet=L5.DatasetMgr.lookup("dicJcmDetailsDataSet");
	var records = dicJcmDetailsDataSet.getAllChangedRecords();
	var isValidate1 = dicJcmDetailsDataSet.isValidate();
	if(isValidate1 != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate1);
		return false;
	}
	
	var command=new L5.Command("com.inspur.cams.jcm.cmd.DicJcmDetailsCmd");
	command.setParameter("records",records);
	command.execute("save");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			//returnBack();
			dicJcmDetailsDataSet.load(true);
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function returnBack(){
	history.go(-1);
}
