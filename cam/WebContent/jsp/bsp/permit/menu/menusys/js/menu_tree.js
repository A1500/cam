var page;
if(!page) page = {};
 page.prompts = '提示';
 page.confirm_msg = '确定要删除选中的菜单?';
//
function init() {
	L5.getCmp('dao').hide();
	//L5.DatasetMgr.lookup("menuTypeDataSet").load();
	L5.QuickTips.init();

}

//得到menuId
function getParentMenuId(rec){
	var menuId = rec.get("menuId");
	if(menuSysTypeId==menuId){
		menuId = "rootId";
	}
	//alert(menuId);
	return menuId;
}

//得到menupath
function getMenuPath(rec){
	var menuPath = rec.get("menuPath");
	var menuId = rec.get("menuId");
	if(menuSysTypeId==menuId){
		menuPath = '';
	}
//	alert(menuPath);
	return menuPath;
}

//得到菜单类型id
function getMenuTypeId(rec){
	//alert(menuSysTypeId);
	return menuSysTypeId;
}

//点击节点
function selectedNode(record){
	//alert(record.get("menuName"));
	var menuId = record.get("menuId");//当前菜单节点的menuid
	var seq=record.get("seq");
	var menuStruId=record.get("menuStruId");
	if(menuId==''){
//		var tree = L5.getCmp("menutree");
//		var treerecord=tree.getCurrentRecord();
//		alert(treerecord.get("menuId"));
		return false;
	}
	if(menuId==menuSysTypeId){//根节点
		var rootFlag="true";
		var url = "menu_edit.jsp?method=UPDATE&menuTypeId="+menuSysTypeId+"&menuId="+menuId+"&parentMenuId="+parentMenuId+"&isLeaf="+record.get("isLeaf")+"&isSys="+isSys+"&menuName="+menuName+"&rootFlag="+rootFlag;
		var frame = document.getElementById("nodeFrame");
		frame.setAttribute("src", url);
		return false;
	}
	var parentMenuId = record.get("parentMenuId");
	//alert(parentMenuId);
	var name = record.getParent().get("menuName");
	
	var menuName = escape(escape(name));
	//var menuName = record.get("menuName");
	//alert(menuName);
	var url = "menu_edit.jsp?method=UPDATE&menuTypeId="+menuSysTypeId+"&menuId="+menuId+"&parentMenuId="+parentMenuId+"&isLeaf="+record.get("isLeaf")+"&isSys="+isSys+"&menuName="+menuName+"&seq="+seq+"&menuStruId="+menuStruId;
	var frame = document.getElementById("nodeFrame");
	frame.setAttribute("src", url);
	//return false;
}

//增加下级菜单
function addMenu(menuitem){
	var record=menuitem.parentMenu.record;
	var menuTypeId = menuSysTypeId;//菜单类型id
	var menuParentId = record.get("menuId");//当前菜单节点的menuid
	//alert(menuParentId);
	if(menuParentId==menuSysTypeId){//根节点
		menuParentId = "rootId";
	}
	var menuId=record.get("menuId");
	//alert(menuParentId);
	var menuName = escape(escape(record.get("menuName")));
	var url = "menu_edit.jsp?method=INSERT&menuTypeId="+menuTypeId+"&parentMenuId="+menuParentId+"&isLeaf=0"+"&menuId="+menuId+"&menuName="+menuName+"&isSys"+isSys;
	var frame = document.getElementById("nodeFrame");
	frame.setAttribute("src", url);
}

//触发加载菜单
function loadMenu(record){
	var menuId = record.get("menuId");
	var isLeaf = record.get("isLeaf");
	if(isLeaf=="1"){//叶子菜单
		return false;
	}
	if(menuId==''){
		return false;
	}
	return true;
}

//导出菜单
function importMenu(menuitem){
	var record=menuitem.parentMenu.record;
//	alert(record.get("menuId"));
}

//为菜单转移
//flag=1:选择菜单；flag=0:移动到。
function forChangeMenu(record,flag){
	var menuTypeId = menuSysTypeId;//菜单类型id
	var menuId = record.get("menuId");//当前菜单节点的menuid
	var menuStruId = record.get("menuStruId");//菜单结构Id
	var url = "menu_listform_forselect.jsp?menuStruId="+menuStruId+"&menuId="+menuId+"&menuTypeId="+menuTypeId+"&opFlag="+flag;
	var frame = document.getElementById("nodeFrame");
	frame.setAttribute("src", url);
}

//选择下级节点，从指定地方复制一份菜单过来
function selectFromMenu(menuitem){
	var record=menuitem.parentMenu.record;//得到节点
//	var menuTypeId = menuSysTypeId;//菜单类型id
//	var menuId = record.get("menuId");//当前菜单节点的menuid
//	var menuStruId = record.get("menuStruId");//菜单结构Id
//	var url = "menu_listform_forselect.jsp?menuStruId="+menuStruId+"&menuId="+menuId+"&menuTypeId="+menuTypeId;
//	var frame = document.getElementById("nodeFrame");
//	frame.setAttribute("src", url);
	forChangeMenu(record,'1');
}

//移动到
function moveToMenu(menuitem){
	var record=menuitem.parentMenu.record;//得到节点
	forChangeMenu(record,'0');
}

//删除节点
function deleteMenu(menuitem){
	var record=menuitem.parentMenu.record;
	var menuId = record.get("menuId");//当前菜单节点的menuid
	//alert(record.get("menuPath"));
	if(menuId==''){
		return false;
	}
	L5.MessageBox.confirm(page.prompts, page.confirm_msg,function(state){
		if(state=="yes"){
			var menuStruId = record.get("menuStruId");//菜单结构Id
			var menuTypeId = menuSysTypeId;//菜单类型id
			var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuStruCmd");
			command.setParameter("menuStruId",menuStruId);//级联删除是这个值没有使用
			//	command.setParameter("menuId",menuId);
			command.setParameter("menuTypeId",menuTypeId);
			//command.setParameter("menuPath",record.get("menuPath"));
			command.setParameter("menuId",menuId);
			command.execute("deleteMenuStru");
			if (!command.error) {
				var prec = record.parentRecord;
				if(prec){
					prec.remove(record);
				}
			}else{
				L5.MessageBox.alert(page.prompts,command.error);
			}
		}
	});

}

//上移
function moveUPMenu(menuitem){
	var record=menuitem.parentMenu.record;
	var menuStruId = record.get("menuStruId");
	//alert('moveUPMenu');
	var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuStruCmd");
	command.setParameter("menuStruId",menuStruId);
	command.execute("moveUPMenu");
	if (!command.error) {
//		alert('ok!');
		refreshNodeForSEQ(record);
	}else{
		L5.MessageBox.alert(page.prompts,command.error);
	}
}

/*
 *
 */
function refreshNodeForSEQ(record){
	var menuStruId = record.get("menuPath");
	//alert(menuStruId);
	if(menuStruId.split('#').length==1){
		var tree = L5.getCmp("menutree");
		tree.root.record.reload();
	}else{
		//L5.MessageBox.alert(page.prompts,record.parentRecord.get("menuPath"));
		var tree = L5.getCmp("menutree");
		var node = tree.getNodeByRecord(record.parentRecord);
		node.record.reload({callback:function(){node.expand();}});
	}
}

//下移
function moveDownMenu(menuitem){
	var record=menuitem.parentMenu.record;
	var menuStruId = record.get("menuStruId");
	var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuStruCmd");
	command.setParameter("menuStruId",menuStruId);
	command.execute("moveDownMenu");
	if (!command.error) {
		//alert('ok!');
		refreshNodeForSEQ(record);
	}else{
		L5.MessageBox.alert(page.prompts,command.error);
	}
}

//系统预置菜单，右键菜单
function sysShow(){
	if(isSys=="1"){
	  return true;
	}
	return false;
}

//非系统预置，右键
function noSysShow(){
	if(isSys=='0'){
		return true;
	}
	return false;
}

//获取不同类型树节点的显示图标
function getIcon(record){
	var isLeaf = record.get("isLeaf");
//	if(isLeaf=="0"){
//		return L5.webPath+"/skins/images/l5/root.gif";
//	}
	if(isLeaf=="1"){
		return L5.webPath+"/skins/images/l5/operation.gif";
	}else{
		return L5.webPath+"/skins/images/l5/other.gif";
	}
}

//树的节点的刷新
function refreshNode(treeId, recordId,type) {
	var tree = L5.getCmp(treeId);
	//alert(recordId);
	if(recordId!='rootId'){
		var node = tree.getNodeByRecordId(recordId,type);
		var record = node.record;
		record.reload({callback:function(){node.expand();}});
	}else{
		tree.root.record.reload();
	}

}

//树的节点的刷新，变更隶属关系
function refreshNodeForMerge(treeId, recordId,type) {
	var tree = L5.getCmp(treeId);
	var node = tree.getNodeByRecordId(recordId,type);
	var record = node.record;
	var prec = record.parentRecord;
		if(prec){
			prec.remove(record);
		}
	//record.reload({callback:function(){node.expand();}});

}

/*
 * 判断是否叶子菜单节点，叶子节点前显示减号
 */
function isLeaf(record){
	if(record.get("isLeaf")=='1'){
		return true;
	}else{
		return false;
	}
}

function handler(record){
	if(isSys ==='1') {
		 return false;
	}
    if(record.get("isLeaf")=='1'){
		return true;
	}else{
		return false;
	}
}

function isRootMenu(record){
	if(isSys ==='0'&&record.get("menuStruId")=="rootId") {//非系统默认菜单的根节点
		 return true;
	}else{
		return false;
	}
}

//导入
function importInfo(item,e){
	var record=item.parentMenu.record;
	var path=window.showModalDialog("../../../organization/selectimport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp("center").hide();
		L5.getCmp("dao").show();
		e.stopEvent();
		var panel=L5.getCmp('dao');
		loadImportPage(panel,record,path);
	}	
}
	
//菜单导入时加载
function loadImportPage(panel,record,path) {
	    var menuTypeId=menuSysTypeId;
		var iframes=panel.body.query('iframe');
		var loading=L5.fly('loadmask',panel.body);
		loading.setStyle("display","block");
		iframes[0].style.visibility="hidden";
		iframes[0].onload=iframes[0].onreadystatechange=function(){
		if(this.readyState=="complete"||!this.readyState){
			(function(){
				loading.dom.style.display="none";
				iframes[0].style.visibility="visible";
			}).defer(50);
			}
		}
		menuTypeId = encodeURI(encodeURI(menuTypeId));
		path= encodeURI(encodeURI(path));
		var url="../../pap/function/importInfo.jsp?menuTypeId="+menuTypeId+"&path="+path+"&dataType=menu";
		iframes[0].src =url;
	}	
	
	
	
//菜单导出
function exportInfo(menuitem,e){
	var record = menuitem.parentMenu.record;
	var path=window.showModalDialog("../../../organization/selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp("center").hide();
		L5.getCmp('dao').show();
		e.stopEvent();
		var panel=L5.getCmp('dao');
		loadExportPage(panel,record,path);	
	}		
}

//菜单导出时加载
function loadExportPage(panel,record,path) {	
	var menuTypeId=menuSysTypeId;
	var iframes=panel.body.query('iframe');
	var loading=L5.fly('loadmask',panel.body);
	loading.setStyle("display","block");
	iframes[0].style.visibility="hidden";
	iframes[0].onload=iframes[0].onreadystatechange=function(){
	if(this.readyState=="complete"||!this.readyState){
		(function(){
			loading.dom.style.display="none";
			iframes[0].style.visibility="visible";
		}).defer(50);
		}
	}
	menuTypeId = encodeURI(encodeURI(menuTypeId));
    var menuStruId=record.get("menuStruId");
	menuStruId = encodeURI(encodeURI(menuStruId));
	path= encodeURI(encodeURI(path));
	var url="../../pap/function/exportInfo.jsp?menuTypeId="+menuTypeId+"&menuStruId="+menuStruId+"&path="+path+"&dataType=menu";
	iframes[0].src =url;
}

function cancel_click(){
	L5.forward("jsp/bsp/permit/menu/menusys/menutypemanager.jsp","菜单分类管理");
}
