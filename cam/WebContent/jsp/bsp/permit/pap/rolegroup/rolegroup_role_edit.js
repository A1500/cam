
/**
 * 页面初始函数
 */
function init() {
	L5.QuickTips.init();
	var dataset = L5.DatasetMgr.lookup("roleDataSet");
	if(method=='definition'){
		dataset.newRecord();
	}
}

//------------------------------功能资源树-----------------------开始-------------------------------

/**
* 得到操作的角色id
*/
function getRoleId(){
	//如果是定义，返回definition
	if(method=='definition'){
		return 'definition';
	}
}

/**
* 得到选框的类型。
*/
function getShowType(record){
	//return 'radiobox';
	return 'checkbox';
}

/**
* 点击选择框
*/
function on_click(sec){
	//alert(sec);
}

/**
* 从选中的记录中得到类型为【应用】的节点
*/
function getAppRecords(selectData){
	var retArray = new Array();
	var num = 0;
	for(var i=0;i<selectData.length;i++){
		//var record = selectData[i];//得到这个记录
		var record=tree.getNodeByRecordId(selectData[i]).record;
		if(record.get("treeType")=='app'){
			retArray[num] = record;
			num++;//递增
		}
	}
	return retArray;
}

/**
* 从选中的记录中得到类型为【模块】的节点
*/
function getModuleRecords(selectData){
	var retArray = new Array();
	var num = 0;
	for(var i=0;i<selectData.length;i++){
		//var record = selectData[i];//得到这个记录
		var record=tree.getNodeByRecordId(selectData[i]).record;
		if(record.get("treeType")=='module'){
			retArray[num] = record;
			num++;//递增
		}
	}
	return retArray;
}

/**
* 从选中的记录中得到类型为【功能】的节点
*/
function getFunctionRecords(selectData){
	var retArray = new Array();
	var num = 0;
	for(var i=0;i<selectData.length;i++){
		//var record = selectData[i];//得到这个记录
		var record=tree.getNodeByRecordId(selectData[i]).record;
		if(record.get("treeType")=='function'){
			retArray[num] = record;
			num++;//递增
		}
	}
	return retArray;
}

/**
* 从选中的记录中得到类型为【操作】的节点
*/
function getOperationRecords(selectData){
	var retArray = new Array();
	var num = 0;
	for(var i=0;i<selectData.length;i++){
		//var record = selectData[i];//得到这个记录
		var record=tree.getNodeByRecordId(selectData[i]).record;
		if(record.get("treeType")=='operation'){
			retArray[num] = record;
			num++;//递增
		}
	}
	return retArray;
}

/**
* 从选中的记录中得到叶子节点
*/
function getLeafRecord(selectData){
	var retArray = new Array();
	var num = 0;
	for(var i=0;i<selectData.length;i++){
		//var record = selectData[i];//得到这个记录
		var record=tree.getNodeByRecordId(selectData[i]).record;
		if(record.getChildren.length==0){
			retArray[num] = record;
			num++;//递增
		}
	}
	return retArray;
}

/**
 * 给角色赋权限
 */
function grantPermission(command){
	var tree = L5.getCmp("rolefunctiontree");
	var allData = tree.getChecked();
	var leafRecords = getLeafRecord(allData);//得到叶子节点
	var appRecords = getAppRecords(allData);//所有选中的类型为【应用】的节点
	var moduleRecords = getModuleRecords(allData);//所有选中的类型为【模块】的节点
	var functionRecords = getFunctionRecords(allData);//所有选中的类型为【功能】的节点
	var operationRecords = getOperationRecords(allData);//所有选中的类型为【功能】的节点
	command.setParameter("roleId", "22");//操作的角色
	command.setParameter("appRecords", appRecords);//要增加的系统
	command.setParameter("moduleRecords", moduleRecords);//要增加的模块
	command.setParameter("functionRecords", functionRecords);//要增加的功能
	command.setParameter("operationRecords", operationRecords);//要增加的操作
}

/**
* 点击保存，给角色授予功能资源。选中的叶子节点是要赋予用户的权限
*/
function submit_click(){
	var command = new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
	grantPermission(command);
	command.execute("grantPermission");
}
