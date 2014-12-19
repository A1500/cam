var prompts = '提示';
//
var methodFlag="";
function init() {
	var dataset = L5.DatasetMgr.lookup("menuDataSet");
	if(method=="INSERT"){
		dataset.newRecord();
		document.getElementById("save").style.display = 'none';
	}else if(method=="UPDATE"){
		//dataset.baseParams["column"]="PUB_MENU_ITEM.*,PUB_APP.APP_NAME,PUB_MODULES.MODULE_NAME,PUB_FUNTIONS.FUNCTION_NAME";
		//dataset.baseParams["table"]="PUB_MENU_ITEM,PUB_APP,PUB_MODULES,PUB_FUNTIONS";
		dataset.baseParams["MENU_ID@="]=menuId;
		//dataset.baseParams["sql"]="PUB_MENU_ITEM.APP_ID=PUB_APP.APP_ID AND PUB_MENU_ITEM.MODULE_ID=PUB_MODULES.MODULE_ID AND PUB_MENU_ITEM.FUNCTION_ID=PUB_FUNTIONS.FUNCTION_ID";
		//alert(menuPath);
		if(isSys!='1'){
			  document.getElementById("seq").value = seq;
			}
		dataset.load();
		disabledSomeBQ();
		sysMenu_ReadOnly();
	}
	//删除根结点的下级，刷新到根结点，此页面不显示内容
	if(rootFlag!="" && rootFlag=="true"){
		L5.getCmp("menuEdit").hide();
	}else{
		L5.getCmp("menuEdit").show();
	}
	menuName = unescape(menuName);
	//alert(menuName);
	document.getElementById("menuParentName").value = menuName;
	L5.QuickTips.init();

}

//如果是系统预置菜单，所有的input标签设为disabled，图片不可见。
function sysMenu_ReadOnly(){
	if(isSys=='1'){
		//input设置为不可用的
		var obj = document.getElementsByTagName("input");
		for(t=0;t<obj.length;t++){
			if((obj[t].id == "requestAction" && isLeaf == "0") || (obj[t].id == "icon" && isLeaf == "1")){
				continue;
			}
			obj[t].disabled="disabled";
		}
		var img = document.getElementsByTagName("img");
		for(g=0;g<img.length;g++){
			img[g].style.display = 'none';
		}
		if(isLeaf == "1"){
			document.getElementById("save").style.display = 'none';
			document.getElementById("noneLeafMenuReqAction").style.display = 'none';			
		}else{
			document.getElementById("submit").style.display = 'none';
		}
	}else{
		document.getElementById("save").style.display = 'none';
		document.getElementById("noneLeafMenuReqAction").style.display = 'none';
	}

}

//如果是叶子节点，部分标签不显示
function disabledSomeBQ(){
	if(isLeaf=="1"){
		document.getElementById("target").disabled="disabled";
		document.getElementById("requestAction").disabled="disabled";
		if(isSys=="1"){
			document.getElementById("functionName").disabled="disabled";
			document.getElementById("moduleName").disabled="disabled";
		}
		document.getElementById("appName").disabled="disabled";
	}
}

//为非叶子菜单设置URL
function save_url_click(){
	var menuDataSet = L5.DatasetMgr.lookup("menuDataSet");
	var menuRecord = menuDataSet.getCurrent();
	var reqAct = menuRecord.get("requestAction");
	
	var command = new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuItemCmd");
	command.setParameter("menuId",menuId);
	command.setParameter("requestAction",menuRecord.get("requestAction"));
	command.execute("updateRequestAction");

	if(!command.error){
		L5.Msg.alert("提示","保存成功");	
	}else{
		L5.Msg.alert("提示","操作失败");	
	}
}

//保存的按钮
function save_click(){
	var retRecord;
	var newSeq;
	var menuDataSet = L5.DatasetMgr.lookup("menuDataSet");
	var menuRecord = menuDataSet.getCurrent();
	var menuName = menuRecord.get('menuName');
	menuName = menuName.replace(/\s/g,"");
	if( menuName=== ""){
		L5.MessageBox.alert(prompts,'菜单名称未填写');
		return;
	}
	
	var command=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuItemCmd");
	command.setParameter("menuItemBean",menuRecord);
	if(methodFlag!=""){
		method="UPDATE";
	}
	if(method=="INSERT"){
		var parentMenuId = document.getElementById('parentMenuId').value;
		var menuTypeId = document.getElementById('menuTypeId').value;
		if((parentMenuId=="rootId") && (menuId!="rootId") && (menuId!=menuTypeId)){
			parentMenuId=menuId;
		}
		command.setParameter("parentMenuId",parentMenuId);
		command.setParameter("menuTypeId",menuTypeId);
		command.execute("insert");
		retRecord = command.getReturn("retRecord");
	  }else if(method=="UPDATE"){
		var oldMenuName = document.getElementById('oldMenuName').value;
		if(oldMenuName!=menuRecord.get("menuName")){
			command.setParameter("changeName","1");
		}else{
			command.setParameter("changeName","0");
		}
		command.setParameter("menuStruId",menuStruId);
		if(isSys!='1'){//不是系统预置菜单
			newSeq=document.getElementById("seq").value;
			newSeq=newSeq.toString();
		if( newSeq!=seq){//非系统内置菜单，并且顺序号发生了改变
			command.setParameter("seq",newSeq);
		  }
		}
		command.execute("update");
	}

	//维护应用信息后，刷新相应树节点(树形记录和iframe的dataset不同步)
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("menutree");
	if(method=="INSERT"){
		//新增节点需要在上级节点下同步添加一条记录
//		var node = tree.getNodeByRecordId(menuParentId, "menuRecord");
		var rec = new parentWin.L5.tree.TreeRecord.recordTypes["menuRecord"](retRecord, retRecord.menuStruId);
//		node.record.insert(rec);

//     	var rec = tree.getCurrentRecord().createRecord("menuRecord",menuRecord.data);
     	//alert(L5.encode(rec));
    	var treerecord=tree.getCurrentRecord();//树的当前选中节点的record
		treerecord.insert(rec);

	}else if (method=="UPDATE"){
		//修改节点只需要更改树中显示名称，其余不需要同步

		var node = tree.getCurrentRecord();
//		alert(node);
		node.set("menuName", menuDataSet.getCurrent().get("menuName"));
		node.set("seq", newSeq);
		node.commit();
	}

	if (!command.error) {
		methodFlag="UPDATE";
		L5.MessageBox.alert(prompts,'保存成功！');
     	//var url='jsp/bsp/permit/menu/menusys/menu_edit.jsp';
   		//L5.forward(url);

	}else{
		L5.MessageBox.alert(prompts,command.error);
	}
}