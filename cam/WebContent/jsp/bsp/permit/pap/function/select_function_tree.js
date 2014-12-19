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
 * 页面初始函数
 */
function init() {
	L5.QuickTips.init();
	tree = L5.getCmp('selectfunctiontree');
	tree.root.expand();
}

//获取不同类型树节点的显示图标
//configure node icon
function getIcon(record){
	var recordType = record.recordType;
	if( record.get("treeType") == "root"){
		return L5.webPath+"/skins/images/l5/root.gif";
	}

	if(record.get("treeType")== "app"){
		return L5.webPath+"/skins/images/l5/app.gif";
	}

	if(record.get("treeType")=='module'){
		return L5.webPath+"/skins/images/l5/module.gif";
	}

	if(record.get("treeType") == "function"){
		return L5.webPath+"/skins/images/l5/function.gif";
	}

	if(record.get("treeType") == "operation"){
		return L5.webPath+"/skins/images/l5/operation.gif";
	}
}

/**
* 获取当前模块编码，作为功能查询条件
*/
function getFunctionModule(rec){
	var module = rec.get("moduleCode");
	return module;
}

/**radiobox || ''
 */
function getChoiceBox(rcd){

    var rcdtype = rcd.recordType;
    if(rcd.isRoot){
    	return "";
    }
    if(rcdtype == "appRecord" && showType == "1" ){
    	return "radiobox";
    }
    if(rcdtype == "moduleRecord" && showType == "2"){
    	return "radiobox";
    }
    if(rcdtype == "functionRecord" && showType == "3"){
    	return "radiobox";
    }
    if(rcdtype == "operationRecord" && showType == "4"){
    	return "radiobox";
    }
    alert("b");
    return "";
}
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
function isLeafModule(rcd){
	return (rcd.recordType == 'moduleRecord' && rcd.get('isLeafModule') == '1');
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
	if(record.get("treeType")=='operation'){
		return 'text';
	}
	if(showType=="module"){
		if(record.get("treeType")=='app'){
			return 'radiobox';
		}
		if(record.get("treeType")=='module'&&record.get("isLeafModule")=='1'){
			return 'text';
		}else if(record.get("treeType")=='module'&&record.get("isLeafModule")=='0'){
			return 'radiobox';
		}
		if(record.get("treeType")=='function'){
			return 'text';
		}
	}
	if(showType=="function"){
		if(record.get("treeType")=='app'){
			return 'text';
		}
		if(record.get("treeType")=='function'){
			return 'text';
		}
		if(record.get("treeType")=='module'&&record.get("isLeafModule")=='1'){
			return 'radiobox';
		}else if(record.get("treeType")=='module'&&record.get("isLeafModule")=='0'){
			return 'text';
		}
	}
	if(showType=="operation"){
		if(record.get("treeType")=='app'||record.get("treeType")=='module'){
			return 'text';
		}
	}
	return 'radiobox';
}

/**
* 得到选框的类型。
*/
function getChecked(record){
	return 0;
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
function confirmValue(){
	var tree = L5.getCmp("selectfunctiontree");
	var rcds = tree.getChecked();
	var rcd;
	if(rcds && rcds.length > 0){
		rcd =tree.getNodeByRecordId(rcds[0]).record;
	}else{
		L5.Msg.alert("提示","没有选中记录");
		return;
	}
	if(rcd==undefined){
		return;
	}
	var newParentId=rcd.get("treeId");
	var newParentName=rcd.get("treeName");
	var newMenuId=rcd.get("menuId");
	
	//检测是否转移到自身节点
	if(newParentId == showId){
		L5.Msg.alert("提示","不能转移到自身节点");
		return;
	}
	
	var command;
	if(showType=="module"){
		command=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.ModuleCommand");
	}
	if(showType=="function"){
		command=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.FunctionCommand");
	}
	if(showType=="operation"){
		command=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.OperationCommand");
	}

	command.setParameter("treeId", showId);
	command.setParameter("menuId", menuId);
	command.setParameter("newParentId", newParentId);
	command.setParameter("newParentName", newParentName);
	command.setParameter("newParentType", rcd.get("treeType"));
	command.setParameter("newMenuId", rcd.get("menuId"));
	command.execute("alterPath");
	if (!command.error) {
	 	L5.MessageBox.alert('提示','转移成功');
		var node = tree.getNodeByRecord(rcd);
		node.record.reload({callback:function(){node.expand()}});

		//维护功能信息后，刷新相应树节点(树形记录和iframe的dataset不同步)
		var parentWin = window.parent.window;
	    var parentTree = parentWin.L5.getCmp("functiontree");
		parentTree.root.record.reload();
		//var parentRcd = parentWin.page.currentRcd
		//var parentRcd=funrcd.parentRecord;
		//var parentTreeNode = parentTree.getNodeByRecord(parentRcd);
		//parentRcd.reload({callback:function(){parentTreeNode.expand()}});

	}else{
		L5.MessageBox.alert('提示',command.error);
	}
}
