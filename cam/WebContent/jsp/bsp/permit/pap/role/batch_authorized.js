function init(){
	var tree = L5.getCmp('usertree');
	tree.on("checkchange",checkedUserNode);
	tree.on("dblclick",treedblclick);
	tree.root.expand();
//	authorizedDataSet.setParameter("roleId",roleId);
//	authorizedDataSet.setParameter("organId",organId);
//	authorizedDataSet.setParameter("nodeType","rootId");
//	authorizedDataSet.load();
	var grid=L5.getCmp('authorizedGrid');
	grid.on("celldblclick",remove);
}

/**
 * 定义根节点结构
 */
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'rootId',
	organId:'',
	struType:'00',
	parentId:'-1',
	struLevel:'',
	struPath:'0',
	struOrder:'',
	isLeaf:'',
	inUse:'',
	organName:'用户树',
	shortName:'用户树',
	organType:'0',
	organTypeName:'单位',
	struTypeName:'人力资源',
	recordType : 'struRecord'
};

/**
*  触发加载组织机构类型的record，岗位和职工类型的不加载
*/
function struLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = parseInt(organType.substring(0, 1));
		if(type == 0 || type == 1 || type == 2){
			return true;
		}
	}
	return false;
}

/**
*  触发加载用户类型的record
*/
function userLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}
	
	return false;
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParent(rec){
	var parentId = rec.get('parentId');

	return parentId;
}
function getStruId(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getOrganType(rec){
	var organType = rec.get('organType');
	return organType?organType:"0";
}
function getOrganId(rec){
	var organId = rec.get('organId');
	return organId?organId:"rootId";
}
function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStruTypeId(rec){

	return struTypeId?struTypeId:"00";
}

//当前节点类型返回后台作为判断查询用户参数的条件
function getNodeType(record){
	if(record.isRoot)
		return "isRoot";
	
	return record.recordType;
}

//根据类型值获取图标路径
function getIcon(record){
	var figpath=L5.webPath + "/skins/images";
	var file=figpath + "/l5/bsp_department&corporation.gif";
	if(!record){
		return file;
	}
	
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = organType.substring(0, 1);
		var value = parseInt(type);
		switch(value){
			case 0: //根结点
				file = figpath + "/l5/root.gif";
				break;
			case 1: // 法人
				file = figpath +"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 部门
				file = figpath + "/l5/bsp_department&corporation.gif";
				break;
			default:
				file = figpath + "/other_img.gif";
		}
		
		return file;
	}
	if(rcdTp == "userRecord"){
		file = figpath + "/l5/bsp_employee.gif";
	}
	return file;
}

function confirmValue(){
	var records = authorizedDataSet.getAllChangedRecords();
	if(records.length>0){
		var command = new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
		command.setParameter("users", records);
		command.setParameter("roleId", roleId);
		command.execute("batchAuthorized");
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功！");
			authorizedDataSet.commitChanges();
		}else{
			L5.Msg.alert('提示',command.error);
		}
	}
	window.close();
}

function closeDig(){
	window.returnValue="";
	window.close();
}

function getChoiceBox(record){
	return  "checkbox";
}
function checkedUserNode(n,checked){
//	if(checked==true){
//		var records=authorizedDataSet.getAllRecords();
//		var flag=true;
//		for(var i=0;i<records.length;i++)
//		{
//			if(records[i].get("userId")==n.record.get("userId")){
//				flag=false;
//				break;
//			}
//		}
//		if(flag)
//		authorizedDataSet.newRecord({userId:n.record.get("userId"),userName:n.record.get("userName")});
//	}else{
//		var records=authorizedDataSet.getAllRecords();
//		for(var i=0;i<records.length;i++)
//		{
//			if(records[i].get("userId")==n.record.get("userId")){
//				var command = new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
//				command.setParameter("roleId", roleId);
//				command.setParameter("userId",records[i].get("userId"));
//				command.execute("deleteAuthorizeds");
//				if (!command.error) {
//					authorizedDataSet.removeAt(i);
//					authorizedDataSet.commitChanges();
//				}else{
//					L5.Msg.alert('提示',command.error);
//				}
//				
//			}
//		}
//	}
}
function remove(grid, rowIndex, columnIndex, e){
	var tree = L5.getCmp("usertree");
		var command = new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
		var record=authorizedDataSet.getCurrent();
		command.setParameter("roleId", roleId);
		command.setParameter("userId",record.get("userId"));
		command.execute("deleteAuthorizeds");
		if (!command.error) {
			var selnode=tree.getNodeByRecordId(record.get("userId"),"userRecord");
		    selnode.ui.checkbox.checked=false;
		    selnode.attributes.checked = false;
			//selnode.unselect();
			authorizedDataSet.removeAt(rowIndex);
//			authorizedDataSet.commitChanges();
		}else{
			L5.Msg.alert('提示',command.error);
		}
}
function left(){
	var grid=L5.getCmp('authorizedGrid');
	var tree = L5.getCmp("usertree");
	var selected = grid.getSelectionModel().getSelections();
	if (selected.length<1) {
		L5.Msg.alert('提示',"请选择要移除的用户");
		return;
	}else{
			var records=selected;
			var command = new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
			command.setParameter("roleId", roleId);
			command.setParameter("records",records);
			command.execute("deleteAuthorizeds");
	   }
		if (!command.error) {
			for(var i=0;i<selected.length;i++){
				var rec=selected[i];
				var selnode=tree.getNodeByRecordId(rec.get("userId"),"userRecord");
			    selnode.ui.checkbox.checked=false;
			    selnode.attributes.checked = false;
			    authorizedDataSet.remove(rec);	
			}
//			 authorizedDataSet.commitChanges();
		}else{
			L5.Msg.alert('提示',command.error);
			return;
		}
	}
function right(){
	var tree = L5.getCmp('usertree');
	var userIds=tree.getChecked("userId");
	var userNames=tree.getChecked("userName");
	if(userIds.length<1){
		L5.Msg.alert('提示',"请选择要授权的用户");
		return;
	}
	for(var j=0;j<userIds.length;j++){
		var records=authorizedDataSet.getAllRecords();
		var flag=true;
		for(var i=0;i<records.length;i++)
		{
			if(records[i].get("userId")==userIds[j]){
				flag=false;
				break;
			}
		}
		if(flag)
			authorizedDataSet.newRecord({userId:userIds[j],userName:userNames[j]});
	}
}
function treedblclick(node,e){
	if(node.record.recordType=="userRecord"){
		var records=authorizedDataSet.getAllRecords();
		var rec=node.record;
		var flag=true;
		for(var i=0;i<records.length;i++)
		{
			if(records[i].get("userId")==node.record.get("userId")){
				flag=false;
				break;
			}
		}
		if(flag)
		authorizedDataSet.newRecord({userId:node.record.get("userId"),userName:node.record.get("userName")});
	 }
}