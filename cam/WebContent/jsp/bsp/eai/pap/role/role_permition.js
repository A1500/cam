function init(){
  var tree = L5.getCmp('functiontree');
  tree.root.expand();
}
var res;
if(!res) res = {};
res.prompts = '提示 ';
/**
*定义功能资源树的根节点
*/
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,则指定id
	treeId:'-1',
	treeName:'根节点',
	treeType:'root',
	recordType:'treeRecord'
};

/**
* 得到节点的类型
*/
function getTreeType(rec){
	return rec.get("treeType");
}

/**
* 得到节点的treeId
*/
function getTreeId(rec){
	return rec.get("treeId");
}

/**
* 得到操作的角色id
*/
function getRoleId(){
	//如果是定义，返回definition
	return roleId;
}
/**
* 得到应用编码
*/
function getAppCode(){
	return appCode;
}
/**
* 点击选择框
*/
function eachClick(node,checked){
	var addArray = new Array();
	var deleteArray = new Array();
	var treeState=node.record.get("treeState");
	//半选中状态标志位:节点未选中状态是false；半选中状态是true；选中状态是false。
	var halfselected=node.ui.checkbox.indeterminate;
	if(treeState=="-1"&&checked){//原来是未选中状态变为选中状态
		node.record.set("operation_flag","1");
	}else if(treeState=="1"&&!checked&&!halfselected){//选中状态取消
		node.record.set("operation_flag","-1");
	}
}
//获取不同类型树节点的显示图标
function getIcon(record){
	var recordType = record.recordType;
	var treeType = record.get("treeType");
	if(treeType == "root" && record.get("treeId") == "-1"){
		return L5.webPath+"/skins/images/l5/root.gif";
	}
	if(treeType == "app"){
		return L5.webPath+"/skins/images/l5/app.gif";
	}
//	if(treeType == "module"){
//		return L5.webPath+"/skins/images/l5/module.gif";
//	}

	if(treeType == "module"){
		if(record.parentRecord.get("treeType")=="app"){
			return L5.webPath+"/skins/images/l5/component.png";
		}else {
			return L5.webPath+"/skins/images/l5/module.png";
		}
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
	if(record.isRoot){
		return "text";
	}
	var type = record.recordType;
	var treeType = record.get("treeType");
	
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
* 得到选框的类型。
*/
function getChecked(record){
	if(record.isRoot){
		return '';
	}
	var type = record.recordType;
	if(type=='menuTreeRecord'){
		if(record.get("treeType")=='operation'){
			return null;
		}
	}
	//得到isCheck，表示是否选中
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
/*
 * 
 */
function save(){
	var command=new L5.Command("org.loushang.bsp.eai.pap.role.cmd.RoleCommand");
	
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
	
//	var menupermittree = L5.getCmp("menupermittree");//菜单权限树
//	var allMenuTreeData_add = new Array();//菜单权限树增加权限的节点
//	var allMenuTreeData_delete = new Array();//菜单权限树取消权限的节点
//	getRecord_opt(menupermittree.root.record,allMenuTreeData_add,'1');
//	getRecord_opt(menupermittree.root.record,allMenuTreeData_delete,'-1');

	//功能权限树-增加
	getRecordsByType(allFuncTreeData_add,'app',appRecords);//所有选中的类型为【应用】的节点
	getRecordsByType(allFuncTreeData_add,'module',moduleRecords);//所有选中的类型为【模块】的节点
	getRecordsByType(allFuncTreeData_add,'function',functionRecords);//所有选中的类型为【功能】的节点
	getRecordsByType(allFuncTreeData_add,'operation',operationRecords);//所有选中的类型为【功能】的节点
//	//菜单权限树-增加
//	getRecordsByType(allMenuTreeData_add,'app',appRecords);//所有选中的类型为【应用】的节点
//	getRecordsByType(allMenuTreeData_add,'module',moduleRecords);//所有选中的类型为【模块】的节点
////	alert(moduleRecords.length)
//	getRecordsByType(allMenuTreeData_add,'function',functionRecords);//所有选中的类型为【功能】的节点
//	getRecordsByType(allMenuTreeData_add,'operation',operationRecords);//所有选中的类型为【功能】的节点
//	getRecordsByType(allMenuTreeData_add,'userDefined',userDefindRecords);//所有选中的类型为【自定义】的节点
	//功能权限树-取消
	getRecordsByType(allFuncTreeData_delete,'app',appRecords_delete);//所有选中的类型为【应用】的节点
	getRecordsByType(allFuncTreeData_delete,'module',moduleRecords_delete);//所有选中的类型为【模块】的节点
	getRecordsByType(allFuncTreeData_delete,'function',functionRecords_delete);//所有选中的类型为【功能】的节点
	getRecordsByType(allFuncTreeData_delete,'operation',operationRecords_delete);//所有选中的类型为【功能】的节点
//	//菜单权限树-取消
//	getRecordsByType(allMenuTreeData_delete,'app',appRecords_delete);//所有选中的类型为【应用】的节点
//	getRecordsByType(allMenuTreeData_delete,'module',moduleRecords_delete);//所有选中的类型为【模块】的节点
//	getRecordsByType(allMenuTreeData_delete,'function',functionRecords_delete);//所有选中的类型为【功能】的节点
//	getRecordsByType(allMenuTreeData_delete,'operation',operationRecords_delete);//所有选中的类型为【功能】的节点
//	getRecordsByType(allMenuTreeData_delete,'userDefined',userDefindRecords_delete);//所有选中的类型为【自定义】的节点
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
	
	command.setParameter("roleId",roleId);
	command.setParameter("appCode",appCode);
	
	command.execute("grantPermission");
	if (!command.error) {
		L5.Msg.alert("提示",'保存成功');
	}
	//重新加载功能权限树
	functiontree.root.record.reload();
	functiontree.root.expand();
}
function backToRoles(){
	L5.forward("jsp/bsp/eai/pap/role/role_query.jsp",'查询');
}
/*
* 得到节点
*/
function getRecord_opt(record,data,opt){
	var num = data.length;//记录个数

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
