function init(){
	var dicDisMaterialTypeDataSet=L5.DatasetMgr.lookup("dicDisMaterialTypeDataSet");
	dicDisMaterialTypeDataSet.load();
}
function insert(){
	var dicDisMaterialTypeDataSet=L5.DatasetMgr.lookup("dicDisMaterialTypeDataSet");
	dicDisMaterialTypeDataSet.newRecord({
		"fillOrganCode" : organCode,
		"fillOrganName" : organName
	});
}

function save(){
	var dicDisMaterialTypeDataSet=L5.DatasetMgr.lookup("dicDisMaterialTypeDataSet");
	var records = dicDisMaterialTypeDataSet.getAllRecords();
	var valid=dicDisMaterialTypeDataSet.isValidate(true);
	var idx=0;
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	//对每一条记录进行校验,字段为1~10000之间的整数
	for(var i = 0;i<records.length;i++){
		if(checkInteger(records[i].get("relation"))){
			if(records[i].get("relation") <1 || records[i].get("relation") >10000){
				L5.Msg.alert('提示',"系数为1~10000的数！");
				return false;
			}
		}else{
			L5.Msg.alert('提示',"系数必须为整数！");
			return false;
		}
	}
	
	var record=dicDisMaterialTypeDataSet.getAllChangedRecords();
	if(record.length==0){
		L5.Msg.alert("提示","没有需要保存的数据！");
		return false;
	}
	for(var i = 0;i<record.length;i++){
		idx=records.length-record.length+i+1;
		record[i].set("code",idx);
	}
	var command=new L5.Command("com.inspur.cams.dis.base.cmd.DicDisMaterialTypeCmd");
	command.setParameter("records",record);
	command.execute("save");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var dicDisMaterialTypeDataSet=L5.DatasetMgr.lookup("dicDisMaterialTypeDataSet");
			dicDisMaterialTypeDataSet.commitChanges();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}

function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("fillOrganCode")=="") {
		L5.Msg.alert("提示","默认配置，不可删除！");
		return;
	}

	var cmd = new L5.Command("com.inspur.cams.dis.base.cmd.DicDisMaterialTypeCmd");
	cmd.setParameter('code',records[0].get("code"));
	cmd.execute('queryIfUse');
	var flag = cmd.getReturn("flag");
	if(flag=="T") {
		L5.Msg.alert('提示', "已使用，不可删除!");
		return false;
	}
	
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.dis.base.cmd.DicDisMaterialTypeCmd");
			command.setParameter("code",records[0].get("code"));
			command.execute("delete");
			if (!command.error){
				var dicDisMaterialTypeDataSet=L5.DatasetMgr.lookup("dicDisMaterialTypeDataSet");
				dicDisMaterialTypeDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}