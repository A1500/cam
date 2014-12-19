function init(){
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	jcmOfficeEquipmentDataSet.load();
}
function query(){
	var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
	
	jcmOfficeEquipmentDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/jcmOfficeEquipmentEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("officeId",records[0].get("officeId"));
	var url="jsp/cams/jcm/jcmOfficeEquipmentEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("officeId",records[0].get("officeId"));
	var url="jsp/cams/jcm/jcmOfficeEquipmentDetail.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmOfficeEquipmentCmd");
			command.setParameter("officeId",records[0].get("officeId"));
			command.execute("delete");
			if (!command.error){
				var jcmOfficeEquipmentDataSet=L5.DatasetMgr.lookup("jcmOfficeEquipmentDataSet");
				jcmOfficeEquipmentDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}