
  
function init() {
	//L5.DatasetMgr.lookup("ds").load();	
	//L5.QuickTips.init();
	ds.load();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//获取下拉选框的值	
function getSelected(elementId){
	var ddl = document.getElementById(elementId);
	var index = ddl.selectedIndex;
	var value = ddl.options[index].value;
	return value;
}
function query(){
	ds.setParameter("CATALOG_TYPE@=",getSelected("catalogType"));
	if(getSelected("companyType")=="1"){
		ds.setParameter("CATALOG_TYPE@rLIKE","0%");
	}else if(getSelected("companyType")=="2"){
		ds.setParameter("CATALOG_TYPE@rLIKE","1%");
	}	
	ds.setParameter("CATALOG_SN@=",getParam("catalogSn"));		
	ds.setParameter("CATALOG_NAME@LIKE",getParam("catalogName"));		
	ds.load();
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute();
	var catalogId=command.getReturn("id");
	ds.newRecord({"catalogId":catalogId,"ifValid":"1"});	

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
				delIds[i]=selected[i].get("catalogId");
			}
			var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealElectronicfileCatalogCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
				L5.Msg.alert('提示',"删除成功");
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
	//保存行政区划
	for(var i=0;i<records.length;i++){
		records[i].set("domicileCode",domicileCode);
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealElectronicfileCatalogCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function reset() {
	ds.rejectChanges();
}



