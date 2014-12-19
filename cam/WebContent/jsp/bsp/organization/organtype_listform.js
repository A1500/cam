
function init() {
	query();
	//L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){

	//查询in_use='1'的记录（inUseId为隐藏域）
	var dataSet=L5.DatasetMgr.lookup("parentOrganType")
	dataSet.setParameter("PUB_ORGAN_TYPE.in_Use@=","1");
	dataSet.load();
	var ds =L5.DatasetMgr.lookup("ds");
	ds.setParameter("PUB_ORGAN_TYPE.in_Use@=","1");
	ds.load();
}

function insertRoot() {
	var record =ds.newRecord();
	//= ds.getCurrent();
	record.set("inUse","1")
	ds.moveLast();
	L5.getCmp("update").hide();
	L5.getCmp("insertRoot").show();
	L5.getCmp("insertSub").hide();

}
function insertSub() {

	var userGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要删除的记录
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一种组织类型");
		return false;
	}
	for(i=0;i<selected.length;i++)
	{
		var record =selected[i];
		if(record.state==1){
			L5.Msg.alert('提示',"所选择的组织类型尚未保存，不能增加下级类型");
			return false;
		}
		var vOrganType=record.get("organType");
		if(vOrganType=="")
		{
			L5.Msg.alert('提示',"请选择已有的组织类型!");
			ds.remove(record);
			return false;
		}

	}

	var rec=selected[0];
	var parentType=rec.get("organType");
	var record =ds.newRecord();
	record.set("inUse","1");
	record.set("parentType",parentType);
	record.set("organType",parentType);
	ds.moveLast();
	L5.getCmp("update").hide();
	L5.getCmp("insertRoot").hide();
	L5.getCmp("insertSub").show();

}

function del(){
	var list="";
	var userGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要删除的记录
	var selected = userGrid.getSelectionModel().getSelections();
	//alert(selected.length);
	if(selected.length<1){
		L5.Msg.alert(messTypePrompt,deletePleaseSelectData);
		return false;
	}else
	{
		L5.MessageBox.confirm(messType, deleteSelectDataMess,
		function(sta){
			if(sta=="yes"){
				var ids = new Array();
				for(var i=0;i<selected.length;i++){
					if(selected[i].state != 1){
						ids.push(selected[i].get("organType"));
					}
				}
				if(ids.length > 0){
					var command=new L5.Command("org.loushang.bsp.organization.cmd.OrganTypeCommand");
	   				command.setParameter("ids",ids);
	   				command.execute("delete");
	   				if(!command.error){
	   					L5.Msg.alert('提示','删除成功!');
	   					for(var i=0;i<selected.length;i++){
								ds.remove(selected[i]);
	   					}
	   				}else{
	   					L5.Msg.alert('提示',command.error);
	   				}
				}else{
   					for(var i=0;i<selected.length;i++){
							ds.remove(selected[i]);
   					}
				}
			}
			else return ;
		}
	);}
}
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert(messTypePrompt,saveNoDataMess);
		return false;
	}
	var isValidate = ds.isValidate();
	var organtype=document.getElementById("organType").value;
	if(organtype!==""&&organtype!==null&&organtype!==undefined){
	   var organType_reg=/^[0-9]+$/;
	   if(!organtype.match(organType_reg)){
	   		L5.Msg.alert("提示","组织类型只能由数字组成");
	   		return false;
	   	}
	}
	if(isValidate != true){
		L5.Msg.alert(messTypePrompt,saveValidateMess+isValidate);
		return false;
	}
	
	var tempRecord;
	for(var i=0; i<records.length; i++){
		tempRecord = records[i];
		for(var j=i+1; j<records.length; j++){
			if(tempRecord.get("organType") == records[j].get("organType")){
				L5.Msg.alert("提示","添加新记录中有重复记录");
				return;
			}
		}
	}
	//判断组织类型代码的前几位父组织类型代码的关联关系
	var userGrid=L5.getCmp('editGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	var i=0
	for(i=0;i<selected.length;i++)
	{
		var record =selected[i];
		var vParentType=record.get("parentType");
		var vOrganType=record.get("organType");
		if(vOrganType.substr(0,vParentType.length)!=vParentType)
		{
			L5.Msg.alert('提示',"请输入以"+vParentType+"为开头的数字!");
			return false;
		}

	}
	var command = new L5.Command("org.loushang.bsp.organization.cmd.OrganTypeCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		query();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',command.error);
	}
}
function reset() {
	ds.rejectChanges();
}
//对于新增的记录，选择父组织类型后，给组织类型代码设置默认值
function changeSelectValue()
{
	var userGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要删除的记录
	var selected = userGrid.getSelectionModel().getSelections();

	var record;
	if(selected.length>0){
		var i=0
		for(i=0;i<selected.length;i++)
		{
			record =selected[i];
			//状态：0：未作更改 1：新增 2：删除 3：修改；
			var recordState=record.state;
		}
	}
	if(recordState=="1")//新增
	{
		var selectOb= document.getElementById("parentTypeId");//
		var selectValue=  selectOb.options[selectOb.selectedIndex].value//得到值
		record.set("organType",selectValue);
		return;
	}
}

function formdataSourceChanged(){

	changeSelectValue()
}

function getParentTypeName(value){
	var dataSet=L5.DatasetMgr.lookup("parentOrganType");
	var record=dataSet.getById(value);
	if(record){
		return record.get("text");
	}
	return "";
}

function getParentTypeId(value){
	var dataSet=L5.DatasetMgr.lookup("parentOrganType");
	var record=dataSet.getById(value);
	if(record){
		return record.get("value");
	}
}
