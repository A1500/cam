
function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ComSubsysConfigDataSet.newRecord();
		ComSubsysConfigDataSet.set("sysId",sysId);
		ComSubsysConfigDataSet.set("orderNum",20);
		
	}else if (method=="UPDATE"){
		//document.getElementById("sysId").readOnly=true;
		ComSubsysConfigDataSet.baseParams["SYS_ID@="]=idField;
		ComSubsysConfigDataSet.load();			
	}
	initGrantRole();
}

function ff(){
	var ds=L5.DatasetMgr.lookup("ableRolesDataset");
	ds.setParameter("TARGET",idField);
	ds.on("load",getRoles);
    ds.load();
}
function getRoles(ableRolesDataset){
	
	var configDs=L5.DatasetMgr.lookup("ComSubsysConfigDataSet");
	//alert(configDs.getTotalCount());
	var records=ableRolesDataset.getAllRecords();
	var grantedRoles=configDs.get("grantedRoles");
	//alert(grantedRoles);
	for(var i=ableRolesDataset.getTotalCount();i>=0;i--){
		if("1".indexOf(records[i].get("roleId"))>=0){
			ableRolesDataset.removeAt(i);
		}
	}
	//alert("33"+ableRolesDataset.getTotalCount());
	initGrantRole();
}

function initGrantRole(){
	var ds=L5.DatasetMgr.lookup("ableRolesDataset");
	ds.setParameter("TARGET",idField);
    ds.load();
    ds.on("load",dsLoad);
}
function dsLoad(ds){
	ds.un("load",dsLoad);
	var assignedRoleDs=L5.DatasetMgr.lookup("ComSubsysRolesDataSet");
    assignedRoleDs.setParameter("TARGET",idField);
    assignedRoleDs.load();
    assignedRoleDs.on("load",assignedRoleDsLoad);
}
function assignedRoleDsLoad(ds){
	ds.un("load",assignedRoleDsLoad);
	var ableRolesDataset=L5.DatasetMgr.lookup("ableRolesDataset");
	new L5.ux.ItemSelector({
		field:"grantedRoles",
		applyTo:"grantRoleDiv",
		id:"grantRolecmp",
		name:"assignedRoles",
		fromDataset:ableRolesDataset,
		toDataset:ds,
		valueField:"roleId",
		displayField:"roleName",
	    msWidth:145,
	    msHeight:200,
	    toLegend:"已授予角色",
	    fromLegend:"未授予角色",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
}
function setShortName(value){
	if(""==ComSubsysConfigDataSet.get("shortName")){
		ComSubsysConfigDataSet.set("shortName",value);
	}
}
function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("ComSubsysConfigDataSet");
	if(dataset.movePrev()){
				
	  	ComSubsysRolesDataSet.baseParams["@="] = document.forms[0].sysId.value;
		ComSubsysRolesDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("ComSubsysConfigDataSet");
	if(dataset.moveNext()){
	
		ComSubsysRolesDataSet.baseParams["@="] = document.forms[0].sysId.value;
		ComSubsysRolesDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;

}
function addComSubsysRoles() {
	/*ComSubsysRolesDataSet.newRecord({
		 : document.forms[0].sysId.value

	});*/

}

function removeComSubsysRoles() {
	var editGrid=L5.getCmp('ComSubsysRolesEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.subsys.cmd.ComSubsysRolesCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("sysId");				
				command.setParameter("delId", delId);
				command.execute("delete");
				ComSubsysRolesDataSet.remove(selected[i]);
			}
			
		}else{
			return false;
		}
	});
}

function insertClick(e){
	document.getElementById("sysId").readOnly=false;
	var dataset = L5.DatasetMgr.lookup("ComSubsysConfigDataSet");
	//如果某必填数据为"",不再继续增加
	if(dataset.getCount()>0 && document.forms[0].sysId.value.trim()==""){
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount()-1);
	
	ComSubsysRolesDataSet.baseParams["SYS_ID@="]="-" ;
	ComSubsysRolesDataSet.load();

}
function deleteClick(e){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var ComSubsysConfigDataSet = L5.DatasetMgr.lookup("ComSubsysConfigDataSet");
			var ComSubsysConfigRecord=ComSubsysConfigDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.comm.subsys.cmd.ComSubsysConfigCmd");
			var  delIds=[];
			delIds[0]= ComSubsysConfigRecord.get("sysId");
			command.setParameter("delIds",delIds);
			command.execute("delete");
			if (!command.error) {
				ComSubsysConfigDataSet.remove(ComSubsysConfigRecord);
				if(!Evt_butNext_click()){
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示','删除成功！');
				var url='jsp/cams/comm/subsys/subsysConfigList.jsp';
				var text="用户表";
				L5.forward(url,text);
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}
		else
			return;
	}
	);

}
function saveClick(){
	var ComSubsysConfigDataSet = L5.DatasetMgr.lookup("ComSubsysConfigDataSet");
	var ComSubsysConfigRecord=ComSubsysConfigDataSet.getCurrent();
	var isValidate = ComSubsysConfigDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.comm.subsys.cmd.ComSubsysConfigCmd");
	
	var ComSubsysRolesRecords = ComSubsysRolesDataSet.getAllChangedRecords();
	command.setParameter("ComSubsysRolesRecords", ComSubsysRolesRecords);
	
	command.setParameter("ComSubsysConfigRecord", ComSubsysConfigRecord);
	command.execute("save");
	if (!command.error) {
	
		ComSubsysRolesDataSet.commitChanges();
	
		ComSubsysConfigDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var url='jsp/cams/comm/subsys/subsysConfigList.jsp';
		var text="用户表";
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function returnClick(){	
	var url='jsp/cams/comm/subsys/subsysConfigList.jsp';
	var text='COM_SUBSYS_CONFIG';
	L5.forward(url,text);	
}

function submit() {
	var records = ComSubsysRolesDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.comm.subsys.cmd.ComSubsysRolesCommand");
	command.setParameter("comsubsysrolesRecords", records);
	command.execute("save");
	if (!command.error) {
		ComSubsysRolesDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function undo() {
	ComSubsysRolesDataSet.rejectChanges();
}

