//
function init() {
	if(opFlag=='0'){
		document.getElementById("myform").style.display = 'none';
	}
	L5.DatasetMgr.lookup("menuTypeDataSet").load();
	//L5.QuickTips.init();
}

//确定,选择菜单
function save_click(){
	var tree = L5.getCmp('menutreeForSelect');
	var selectMenuId = tree.getChecked('menuId');//选择的菜单结构-菜单id
	var selectMenuStruId = tree.getChecked('menuStruId');//选择的菜单结构-结构id
	var selectPathName = tree.getChecked('pathName');//选择的菜单结构-路径名称
	var selectMenuPath = tree.getChecked('menuPath');//选择的菜单结构-菜单路径
	var selectLeafMenu=tree.getChecked("isLeaf");
	if(selectMenuId.length<1){
		L5.Msg.alert("提示","请选择菜单");
		return false;
	}
	var command = new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuStruCmd");
	if(menuStruId=="rootId"&&selectLeafMenu=="1"&&selectMenuId!=undefined){
		command.setParameter("menuId",selectMenuId[0]);
		command.setParameter("menuTypeId",menuTypeId);
		command.execute("testSelected");
		var isExist=command.getReturn("isExist");
		if(isExist=="true"){
			L5.Msg.alert("提示","不能重复增加末级菜单");
			return false;
		}
	}
//	var menusystypeGrid=L5.getCmp('menusystypeGrid');
//	var selected = menusystypeGrid.getSelectionModel().getSelections();
//	var selectMenuTypeId = selected[0].get("menuTypeId");//选择的菜单类型id
//    var selectMenuTypeId = document.getElementById("smenuTypeId").value;
//	alert(selectMenuId+':'+menuStruId);
	if(selectMenuStruId==menuStruId){//同一个不能选
		 L5.MessageBox.alert("提示","不能选择本身");
		 return false;
	}
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("menutree");
	var treerecord=tree.getCurrentRecord();//左边菜单树的当前选中节点的record
	//目标
	var tagMap = new L5.Map();
	tagMap.put("menuTypeId",menuTypeId);//目的菜单类型
	tagMap.put("menuStruId",treerecord.get("menuStruId"));//目的菜单结构id
	tagMap.put("menuId",treerecord.get("menuId"));//目的菜单id
	tagMap.put("menuName",treerecord.get("menuName"));
	tagMap.put("menuPath",treerecord.get("menuPath"));
	//alert('ok');
	//来源
	var srcMap = new L5.Map();
	srcMap.put("selectMenuId",selectMenuId);
	//alert(selectMenuStruId);
	srcMap.put("selectMenuStruId",selectMenuStruId);
	srcMap.put("selectMenuTypeId",getMenuTypeId());
	srcMap.put("selectPathName",selectPathName);
	srcMap.put("selectMenuPath",selectMenuPath);
	command.setParameter("tagMap",tagMap);
	command.setParameter("srcMap",srcMap);
	if(opFlag=='1'){
		command.execute("selectFrom");
	}
	if(opFlag=='0'){
		command.execute("moveToMenu");
	}
	if (!command.error) {
		if(opFlag=='1'){
			//菜单树上当前节点刷新
			parentWin.refreshNode("menutree",treerecord.get("menuStruId"),"menuRecord");
		}
		if(opFlag=='0'){
			//菜单树上当前节点删除
			parentWin.refreshNodeForMerge("menutree",treerecord.get("menuStruId"),"menuRecord");
			//
			//refreshNode("menutreeForSelect",selectMenuStruId,"menuRecord");
			parentWin.refreshNode("menutree",selectMenuStruId,"menuRecord");
		}
		L5.MessageBox.alert("提示","保存成功");
		return ;
		
	}else{
		L5.MessageBox.alert("提示",command.error);
		return;
	}
}

//树的节点的刷新
function refreshNode(treeId, recordId,type) {
	var tree = L5.getCmp(treeId);
	if(recordId!='rootId'){
		//alert(recordId);
		var node = tree.getNodeByRecordId(recordId,type);
		var record = node.record;
		record.reload({callback:function(){node.expand();}});
	}else{
		tree.root.record.reload({callback:function(){root.expand();}});
	}

}

//选中行
var RowSelect=function(sm,rowIndex,record){
	//alert('sm');
	var tree = L5.getCmp("menutreeForSelect");
	tree.root.record.reload();

}

//得到上级menuId
function getParentMenuId(rec){
	var menuId = rec.get("menuId");
	//alert(menuId);
	return menuId;
}

//触发加载菜单
function loadMenu(record){
	var menuId = record.get("menuId");
	var isLeaf = record.get("isLeaf");
	if(isLeaf=="1"){
		return false;
	}
	if(menuId==''){
		return false;
	}
	return true;
}

//得到菜单类型id
function getMenuTypeId(rec){
	if(opFlag=='1'){
		var typeid = document.getElementById("smenuTypeId").value;
	//alert(typeid);
		return typeid;
	}else if(opFlag=='0'){
		return menuTypeId;
	}

//	var menusystypeGrid=L5.getCmp('menusystypeGrid');
//	var selected = menusystypeGrid.getSelectionModel().getSelections();
//	var menuTypeId = selected[0].get("menuTypeId");
	//alert(menuTypeId);
//	return menuTypeId;
}

//得到menupath
function getMenuPath(rec){
	var menuPath = rec.get("menuPath");
	var menuId = rec.get("menuId");
	if('rootId'==menuId){
		menuPath = '';
	}
	//alert(menuPath);
	return menuPath;
}

function selectedNode(){

}

//获取不同类型树节点的显示图标
function getIcon(record){
	var isLeaf = record.get("isLeaf");
//	if(isLeaf=="0"){
//		return L5.webPath+"/skins/images/l5/root.gif";
//	}
	if(isLeaf=="1"){
		return L5.webPath+"/skins/images/l5/operation.gif";
	}
}

/*
 * 选中菜单类型
 */
function changeSelect(src){
	var tree = L5.getCmp("menutreeForSelect");
	tree.root.record.reload();
}

/*
 * 节点类型
 */
function getShowType(record){
//	alert(opFlag+'--'+record.get("menuId"))
//	var list=record.get("menuPath").split("#");
	if(opFlag=='1'&&record.get("menuId")=='rootId'){
		return 'text';
	}
	if(opFlag=='0'&&record.get("isLeaf")=='1'){//移动到 操作时，叶子节点不可选
		return 'text';
	}
//	if(opFlag=='1'&&record.get("menuId")==list[0]){//选择下级菜单 操作时，应用节点不可以选
//		return 'text';
//	}
	return 'radiobox';
}
 
function getIsLeaf(rec){
		var leaf=rec.get('isLeaf');
		if(leaf=='1'){
			return true;
		}else{
			return false;
		}
	}
