/**
*定义功能资源树的根节点
*/
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,则指定id
	treeId:'-1',
	treeName:'委托事项',
	treeType:'root',
	recordType:'treeRecord'
};


//获取不同类型树节点的显示图标
//configure node icon
function getIcon(record){
	var recordType = record.recordType;
	var treeType = record.get("treeType");

	if(treeType == "root" && record.get("treeId") == "-1"){
		return L5.webPath+"/skins/images/l5/root.gif";
	}
	if(treeType == "app"){
		return L5.webPath+"/skins/images/l5/app.gif";
	}
	if(treeType == "module"){
		return L5.webPath+"/skins/images/l5/module.gif";
	}

	if(treeType == "function"){
		return L5.webPath+"/skins/images/l5/function.gif";
	}

	if(treeType == "operation"){
		return L5.webPath+"/skins/images/l5/operation.gif";
	}
}

/**
* 得到选框的类型。
*/
function getShowType(record){
	//return 'radiobox';
	var type = record.recordType;
	var treeType = record.get("treeType");
	//alert(treeType);
	if(treeType=='root'){
		return 'text';
	}
	if(type=='menuTreeRecord'){
		if(record.get("treeType")=='operation'){
			return 'text';
		}
	}
	return 'checkbox';
}

/**
* 得到节点的类型
*/
function getTreeType(rec){
	return rec.get("treeType");
//	return "treeType";
}

/**
* 得到节点的treeId
*/
function getTreeId(rec){
	return rec.get("treeId");
}

/**
* 得到选框的类型。
*/
function getChecked(record){
	//得到isCheck，表示是否选中
	if(record.isRoot){
		return '';
	}
	var type = record.recordType;
	if(type=='menuTreeRecord'){
		if(record.get("treeType")=='operation'){
			return null;
		}
	}
	var isCheck = record.get("treeState");
	if(isCheck=='1'){
		return '1';
	}
	if(isCheck=='-1'){
		return '-1';
	}
	if(isCheck=='0'){
	return '0';
	}
	return false;
}


/**
* record是否在records中存在
*/
function isExistNode(record,records){
	for(var i=0;i<records.length;i++){
		if(records[i].get("treeId")==record.get("treeId")){
			return true;
		}
	}
	return false;
}

/**
* 从选中的记录中得到类型为【应用】的节点
*/
function getAppRecords(selectData,appRecords){
	var num = appRecords.length;
	for(var i=0;i<selectData.length;i++){
		var record = selectData[i];//得到这个记录
		if(record.get("treeType")=='app'){
			if(!isExistNode(record,appRecords)){
				appRecords[num] = record;
				num++;//递增
			}
		}
	}
}

/**
* 从选中的记录中得到类型为【模块】的节点
*/
function getModuleRecords(selectData,moduleRecords){
	var num = moduleRecords.length;
	for(var i=0;i<selectData.length;i++){
		var record = selectData[i];//得到这个记录
		if(record.get("treeType")=='module'){
			if(!isExistNode(record,moduleRecords)){
				moduleRecords[num] = record;
				num++;//递增
			}
		}
	}
}

/**
* 从选中的记录中得到类型为【功能】的节点
*/
function getFunctionRecords(selectData,functionRecords){
	var num = functionRecords.length;
	for(var i=0;i<selectData.length;i++){
		var record = selectData[i];//得到这个记录
		if(record.get("treeType")=='function'){
			if(!isExistNode(record,functionRecords)){
				functionRecords[num] = record;
				num++;//递增
			}
		}
	}
}

/**
* @selectData 选中的节点
* @treeType 类型
* @data 保存的数据
*/
function getRecordsByType(selectData,treeType,data){
	var num = data.length;
	for(var i=0;i<selectData.length;i++){
		var record = selectData[i];//得到这个记录
		if(record.get("treeType")==treeType){
			if(!isExistNode(record,data)){
				data[num] = record;
				num++;//递增
			}
		}
	}
}

/**
* 得到操作的委托id
*/
function getProxyPermitId(){
	//如果是定义，返回definition
//	alert(page.mode.curMode==page.mode.add);
	if(page.mode.curMode==page.mode.add){
		return 'definition';
	}
	var proxyPermissionId = page.proxyPermissionId;
	return proxyPermissionId;
}

/**
* 从选中的记录中得到叶子节点
*/
function getLeafRecord(selectData){
	var retArray = new Array();
	var num = 0;
	for(var i=0;i<selectData.length;i++){
		var record = selectData[i];//得到这个记录
		if(record.getCount()==0){
			retArray[num] = record;
			num++;//递增
		}
	}
	return retArray;
}

function getSelectData(treeId){

}


/*
 * 得到节点
 */
function getRecord_opt(record,data,opt){
	//alert(':'+record.recordType+":"+":"+record.getCount()+":"+data.length);
	var num = data.length;//记录个数
	//
//	alert(record.get('operation_flag')+'---'+record.get('treeState'));
	if(record.get('operation_flag')==opt&&record.get('treeState')!=opt){
		data[num] = record;
		num++;
	}else{
		for(var a=0;a<record.getCount();a++){
			var record_c = record.getAt(a);//得到一个子节点
			if(record_c){
				getRecord_opt(record_c,data,opt);
			}
		}
	}
}

/**
 * 给角色赋权限
 */
function grantPermission(command){
	var appRecords = new Array();
	var moduleRecords = new Array();
	var functionRecords = new Array();
	var operationRecords = new Array();
	var userDefindRecords = new Array();
	var appRecords_delete = new Array();
	var moduleRecords_delete = new Array();
	var functionRecords_delete = new Array();
	var operationRecords_delete = new Array();
	var userDefindRecords_delete = new Array();
	var functiontree = L5.getCmp("functiontree");//功能权限树
	var allFuncTreeData_add = new Array();//功能权限树增加权限的节点
	var allFuncTreeData_delete = new Array();//功能权限树取消权限的节点
	getRecord_opt(functiontree.root.record,allFuncTreeData_add,'1');
	getRecord_opt(functiontree.root.record,allFuncTreeData_delete,'-1');
//	alert('-'+allFuncTreeData_add.length);
//	var funcTreeLeafRecords_add = getLeafRecord(allFuncTreeData_add);//得到功能权限树用于增加权限的叶子节点
//	var funcTreeLeafRecords_delete = getLeafRecord(allFuncTreeData_delete);//得到功能权限树用于取消权限的叶子节点
//	var menuTreeLeafRecords_add = getLeafRecord(allMenuTreeData_add);//得到菜单权限树增加权限的叶子节点
//	var menuTreeLeafRecords_delete = getLeafRecord(allMenuTreeData_delete);//得到菜单权限树取消权限的叶子节点
//	alert(menuTreeLeafRecords_add.length);
	//功能权限树-增加
	getRecordsByType(allFuncTreeData_add,'app',appRecords);//所有选中的类型为【应用】的节点
	getRecordsByType(allFuncTreeData_add,'module',moduleRecords);//所有选中的类型为【模块】的节点
	getRecordsByType(allFuncTreeData_add,'function',functionRecords);//所有选中的类型为【功能】的节点
	getRecordsByType(allFuncTreeData_add,'operation',operationRecords);//所有选中的类型为【功能】的节点
	//功能权限树-取消
	getRecordsByType(allFuncTreeData_delete,'app',appRecords_delete);//所有选中的类型为【应用】的节点
	getRecordsByType(allFuncTreeData_delete,'module',moduleRecords_delete);//所有选中的类型为【模块】的节点
	getRecordsByType(allFuncTreeData_delete,'function',functionRecords_delete);//所有选中的类型为【功能】的节点
	getRecordsByType(allFuncTreeData_delete,'operation',operationRecords_delete);//所有选中的类型为【功能】的节点
	//command.setParameter("roleId", "22");//操作的角色
	command.setParameter("appRecords", appRecords);//要增加的系统
	command.setParameter("moduleRecords", moduleRecords);//要增加的模块
	command.setParameter("functionRecords", functionRecords);//要增加的功能
	command.setParameter("operationRecords", operationRecords);//要增加的操作
	command.setParameter("userDefindRecords", userDefindRecords);//要增加的自定义
	command.setParameter("appRecords_delete", appRecords_delete);//要取消的系统
	command.setParameter("moduleRecords_delete", moduleRecords_delete);//要取消的模块
	command.setParameter("functionRecords_delete", functionRecords_delete);//要取消的功能
	command.setParameter("operationRecords_delete", operationRecords_delete);//要取消的操作
	command.setParameter("userDefindRecords_delete", userDefindRecords_delete);//要增加的自定义
}

/*
 *
 */
function getIsLeafMenu(rec){
	return rec.get("isLeafMenu");
}

/*
 *
 */
function getTreeMenuStruId(rec){
	//alert(rec.get("treeType"));
	return rec.get("treeMenuStruId");
}

/**
 * 点击选择框
 */
function eachClick(node,checked){
	var addArray = new Array();
	var deleteArray = new Array();
	if(checked){//选中
		node.record.set("operation_flag","1");
	}else{//取消
		node.record.set("operation_flag","-1");
	}
}
/*
 * 判断是否叶子节点，叶子节点前显示减号
 */
function isLeaf(record){
	if(record.get("treeType")=='operation'){
		return true;
	}else{
		return false;
	}
}