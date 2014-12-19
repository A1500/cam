var methodFlag="";
function init() {

	if(delwith=="null")delwith="";
	if(delwith!=""){
		L5.getCmp("totalPanel").hide();
	}else{
		if (method==null||method==""){
			L5.MessageBox.alert(RES_PROMPT,RES_UNKOWN_CMD);
			return;
		}
		setDisplay(struId, roleGroupId);
		var ds = L5.DatasetMgr.lookup("roleDataset");
		if (method=="INSERT"){
			ds.newRecord({"roleId":newId,"relationId":struId,"organName":organName,"roleGroupId":roleGroupId,"roleGroupName":roleGroupName});
		} else if (method=="UPDATE"){
			var roleId = document.getElementById("roleId");
			roleId.disabled="disabled"
			if (loadRole(idField, true)) {
				if(ds.getCount()>0){
					ds.getCurrent().set("organName", organName);
					ds.getCurrent().set("roleGroupName", roleGroupName);
				}

			}
		} else{
			L5.MessageBox.alert(RES_PROMPT,RES_UNKOWN_CMD);
			return;
		}


		L5.QuickTips.init();
		select_authorization();
		var rolePanel=L5.getCmp("roleEditPanel");
		rolePanel.on("beforebinding", initInheritRole);
        
	}
	var functionTree = L5.getCmp("functiontree");
	functionTree.on("beforeexpandnode",expandnode)
}

function loadRole(roleId, isInit){
	var command=new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
	command.setParameter("ROLE_ID", roleId);
	command.execute("getRole");
	if(command.error){
		return false;
	}
	L5.getCmp("tabPanels").setActiveTab(0);
	var menuPermitTree = L5.getCmp("menupermittree");
	var functionTree = L5.getCmp("functiontree");
	if(isInit === false){
		menuPermitTree.root.record.reload();
		functionTree.root.record.reload();
	}
	return true;
}

function setDisplay(struId, roleGroupId){
	var struTrEle = document.getElementById("struTr");
	var roleGroupTrEle = document.getElementById("roleGroupTr");
	//组织下的角色显示所属组织
	if(struId && struId !== "" && struId !== "null" && struId !== "undefined"){
		struTrEle.style.display = "";
		roleGroupTrEle.style.display = "none";
		roleGroupId = "";
	} else {
		struTrEle.style.display = "none";
		struId = "";
	}
	//角色组下的角色显示所属角色组
	if(roleGroupId && roleGroupId !== "" && roleGroupId !== "null" && roleGroupId !== "undefined"){
		struTrEle.style.display = "none";
		roleGroupTrEle.style.display = "";
		struId = "";
		//角色树中不维护角色组下的角色，只提供查看的功能
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("roletree");
		if(tree){
			document.getElementById("saveBtn").style.display = "none";
			document.getElementById("undoBtn").style.display = "none";
		}
	} else {
		roleGroupTrEle.style.display = "none";
		roleGroupId = "";
		document.getElementById("saveBtn").style.display = '';
		document.getElementById("undoBtn").style.display = '';
	}
	//当从role_tree.jsp跳转到role_edit.jsp页面的时候，隐藏返回按钮
	if(prePage === 'role_tree'){
		document.getElementById("backBtn").style.display = 'none';
	}
}

//页面值校验判断

function fieldValid(){
	//组织代码校验
	var roleName = document.getElementById("roleName").value;
	var roleId= document.getElementById("roleId").value;
 	var re = /\"|\'|\“|\”|\‘|\’|\%|\$|\￥|\……|\·|\—|\-|\——|\!|\！|\#|\@|\~|\^|\*|\,|\.|\，|\。|\?|\？|\;|\；|\:|\：|\{|\}|\\|\/|\[|\]|\(|\)|\+|\-|\、|\||\<|\>/;
	if(re.test(roleName)){
		return  "角色名称不能包含特殊字符";
	}
	if(re.test(roleId)){
		return  "角色内码不能包含特殊字符";
	}
    if(roleName.length>20){
    	return  "角色名称长度不能超过20";
    }
}
function save(){
	var ds = L5.DatasetMgr.lookup("roleDataset");
	
	var validMsg = ds.isValidate();
  	if(validMsg != true){
		L5.MessageBox.alert("提示",validMsg);	
		return false;
	} 
	validMsg = fieldValid();
	if(validMsg != null ){
	 	L5.MessageBox.alert("提示",validMsg);
		return false;
	}
   
	var command=new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
	var recInheritedRoles=ds.getCurrent().get("inheritedRoles");
	var inheritedRolesList=recInheritedRoles.split(",");
	var recRoleId=ds.getCurrent().get("roleId");
	if(recRoleId==""){
		ds.getCurrent().set("roleId",newId);
	}

	for(var i=0;i<inheritedRolesList.length;i++){
		if(recRoleId==inheritedRolesList[i]){
			L5.MessageBox.alert(RES_PROMPT,"角色继承不能继承本身！");
			return false;
		}
	}
	command.setParameter("record", ds.getCurrent());
	//给角色赋权限，参数
	grantPermission(command);
	if(methodFlag!=""){
		method="UPDATE";
	}
	if(method=="INSERT"){
		command.execute("insert");
	} else if (method=="UPDATE"){
		command.execute("update");
	}

	if (!command.error) {

		//维护应用信息后，刷新相应树节点(树形记录和iframe的dataset不同步)
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("roletree");
		if(tree){
			if(method=="INSERT"){
				//新增节点需要在上级节点下同步添加一条记录
				var node = tree.getNodeByRecordId(struId, "struRecord");
				var rec = new parentWin.L5.tree.TreeRecord.recordTypes["roleRecord"](ds.getCurrent().data, ds.getCurrent().get("roleId"));
				node.record.insert(rec);
			}else if (method=="UPDATE"){

				//修改节点只需要更改树中显示名称，其余不需要同步
				var node = tree.getNodeByRecordId(ds.getCurrent().get("roleId"), "roleRecord");
				node.record.set("roleName", ds.getCurrent().get("roleName"));
				node.record.commit();
			}
		}
		ds.commitChanges();
		methodFlag="UPDATE";
		method="UPDATE";
		var roleId = document.getElementById("roleId");
		roleId.disabled="disabled"
		var functionTree = L5.getCmp("functiontree");
		//重新加载功能权限树
		functionTree.root.record.reload();
		//不展开重新加载的功能权限树
		//functionTree.expandAll();
		L5.MessageBox.alert(RES_PROMPT,RES_SAVE);

	}else{
		L5.MessageBox.alert(RES_PROMPT,command.error);
	}
}
/*
 * 检验必填项
 */
function validate(){
	//
	var roleName = document.getElementById("roleName").value;
	var discription=document.getElementById("discription").value;
	if(roleName==''){
		L5.MessageBox.alert("提示","角色名称不能为空！");
		return false;
	}
	if(roleName.length>60){
		L5.MessageBox.alert("提示","角色名称长度过长！");
		return false;
	}
	if(discription!==undefined&&discription!==""&&discription.length>50){
	   L5.MessageBox.alert("提示","描述长度不能超过50个字！");
	   return false;
	}
	return true;
}
/**
 * 事件处理：撤销事件。
 */
function undo(){
	var ds = L5.DatasetMgr.lookup("roleDataset");
	ds.rejectChanges();
	if (method=="INSERT"||ds.getCurrent()==undefined){
		ds.newRecord({"roleId":newId,"relationId":struId,"organName":organName,"roleGroupId":roleGroupId,"roleGroupName":roleGroupName});
	}
}

function initInheritRole(){
	var ds1=L5.DatasetMgr.lookup("inheritedRoleDataset");
	new L5.ux.ItemSelector({
		field:"inheritedRoles",
		applyTo:"inheritRoleDiv",
		id:"inheritRolecmp",
		name:"inheritedRoles",
		fromDataset:ds1,
		valueField:"roleId",
		displayField:"roleName",
	    msWidth:145,
	    msHeight:260,
	    toLegend:"已继承角色",
	    fromLegend:"未继承角色",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}

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
*定义菜单权限树的根节点
*/
var menuRootData = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,则指定id
	treeId:'rootId',
	treeName:'根节点',
	treeType:'root',
	isLeafMenu:'0',
	operation_flag:'0',
	treeState:'-1',
	recordType:'menuTreeRecord'
};

//获取不同类型树节点的显示图标
//configure node icon
function getIcon(record){
	var recordType = record.recordType;
	var treeType = record.get("treeType");
	//alert(treeType);
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
	//alert(rec.get("isLeafMenu"));
	//alert(rec.get("treeId"));
	return rec.get("treeId");
//return "treeType";
}

/**
* 得到操作的角色id
*/
function getRoleId(){
	//如果是定义，返回definition
	if(method=='INSERT'){
		return 'definition';
	}
	return roleDataset.getCurrent().get("roleId");
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

/**
* 点击选择框
*/
function on_click(sec){
	//alert(sec);
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
//	alert(':'+record.recordType+":"+":"+record.get("treeName")+":"+record.getCount()+":"+data.length);
	var num = data.length;//记录个数
	var tree=L5.getCmp("functiontree");
	var node=tree.getNodeByRecord(record);
	var halfselected=true;
	if(!record.isRoot){
	   halfselected=node.ui.checkbox.indeterminate;
	}
//	alert(record.get('operation_flag')+'---'+record.get('treeState'));
	if(record.get('operation_flag')==opt&&record.get('treeState')!=opt&&!halfselected){
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
	var menupermittree = L5.getCmp("menupermittree");//菜单权限树
	var allMenuTreeData_add = new Array();//菜单权限树增加权限的节点
	var allMenuTreeData_delete = new Array();//菜单权限树取消权限的节点
	getRecord_opt(menupermittree.root.record,allMenuTreeData_add,'1');
	getRecord_opt(menupermittree.root.record,allMenuTreeData_delete,'-1');
//	alert('-'+allFuncTreeData_add.length);
//	var funcTreeLeafRecords_add = getLeafRecord(allFuncTreeData_add);//得到功能权限树用于增加权限的叶子节点
//	var funcTreeLeafRecords_delete = getLeafRecord(allFuncTreeData_delete);//得到功能权限树用于取消权限的叶子节点
//	var menuTreeLeafRecords_add = getLeafRecord(allMenuTreeData_add);//得到菜单权限树增加权限的叶子节点
//	var menuTreeLeafRecords_delete = getLeafRecord(allMenuTreeData_delete);//得到菜单权限树取消权限的叶子节点
	//功能权限树-增加
	getRecordsByType(allFuncTreeData_add,'app',appRecords);//所有选中的类型为【应用】的节点
	getRecordsByType(allFuncTreeData_add,'module',moduleRecords);//所有选中的类型为【模块】的节点
	getRecordsByType(allFuncTreeData_add,'function',functionRecords);//所有选中的类型为【功能】的节点
	getRecordsByType(allFuncTreeData_add,'operation',operationRecords);//所有选中的类型为【功能】的节点
	//菜单权限树-增加
	getRecordsByType(allMenuTreeData_add,'app',appRecords);//所有选中的类型为【应用】的节点
	getRecordsByType(allMenuTreeData_add,'module',moduleRecords);//所有选中的类型为【模块】的节点
//	alert(moduleRecords.length)
	getRecordsByType(allMenuTreeData_add,'function',functionRecords);//所有选中的类型为【功能】的节点
	getRecordsByType(allMenuTreeData_add,'operation',operationRecords);//所有选中的类型为【功能】的节点
	getRecordsByType(allMenuTreeData_add,'userDefined',userDefindRecords);//所有选中的类型为【自定义】的节点
	//功能权限树-取消
	getRecordsByType(allFuncTreeData_delete,'app',appRecords_delete);//所有选中的类型为【应用】的节点
	getRecordsByType(allFuncTreeData_delete,'module',moduleRecords_delete);//所有选中的类型为【模块】的节点
	getRecordsByType(allFuncTreeData_delete,'function',functionRecords_delete);//所有选中的类型为【功能】的节点
	getRecordsByType(allFuncTreeData_delete,'operation',operationRecords_delete);//所有选中的类型为【功能】的节点
	//菜单权限树-取消
	getRecordsByType(allMenuTreeData_delete,'app',appRecords_delete);//所有选中的类型为【应用】的节点
	getRecordsByType(allMenuTreeData_delete,'module',moduleRecords_delete);//所有选中的类型为【模块】的节点
	getRecordsByType(allMenuTreeData_delete,'function',functionRecords_delete);//所有选中的类型为【功能】的节点
	getRecordsByType(allMenuTreeData_delete,'operation',operationRecords_delete);//所有选中的类型为【功能】的节点
	getRecordsByType(allMenuTreeData_delete,'userDefined',userDefindRecords_delete);//所有选中的类型为【自定义】的节点
		
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
 * 选项框的状态一改变就会触发此方法
 */
function eachClick(node,checked){
	var addArray = new Array();
	var deleteArray = new Array();
	var treeState=node.record.get("treeState");
	//半选中状态标志位:节点未选中状态是false；半选中状态是true；选中状态是false。
	var halfselected=node.ui.checkbox.indeterminate;
	var operation_flag = node.record.get("operation_flag");
	var treeName=node.record.get("treeName");
   // alert(treeName+"flag="+operation_flag);
	//如果是第一次修改，参考对象为treeState
	if(operation_flag == "0"){
		//原来是未选中状态变为选中状态
		if(treeState == "-1" && checked){
				node.record.set("operation_flag","1");
		}
		//选中状态取消
		if(treeState == "1" && !checked && !halfselected){
				node.record.set("operation_flag","-1");
		}
        //点击半选中状态的，变成了未选中状态
		if(treeState == "0" && !checked && !halfselected){
				node.record.set("operation_flag","-1");	
		}
		//使用情况为：本来是未选中状态，但是由于父节点选中，引起了该节点的状态变成了选中状态，然后，点击该节点的选项框，取消该节点的选中状态，所有应该设置flag标识为-1
		if(treeState == "-1" && !checked && !halfselected){
			node.record.set("operation_flag","-1");	
		}
	}else{//第二次及以后的修改就要参考客户端的保存值operation_flag
		if(operation_flag == "1"&&!checked){
			node.record.set("operation_flag","-1");	
		}			
		if(operation_flag == "-1" && checked && !halfselected){
			node.record.set("operation_flag","1");	
		}
	}

}

function expandnode(node,deep,anim){
	var operation_flag = node.record.get("operation_flag");
	if(operation_flag == "1"){//修改后为全选状态
		node.eachChild(setOperationFlag);
	}
}

function setOperationFlag(node){
	node.record.set("operation_flag","1");
}

/**
 * 返回角色列表
 */
 function backToRoles(){
 	var url = '/jsp/bsp/permit/pap/rolegroup/role_query.jsp?roleGroupId=';
 	url +=  encodeURI(encodeURI(roleGroupId));
 	url+= '&roleGroupName=';
 	url += encodeURI(encodeURI(roleGroupName));
 	L5.forward(url,'角色列表')
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