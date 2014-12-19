var page;
if(!page)page = {};
//tab页
page.cars;
//修改的委托项id
page.proxyPermissionId;
page.param={
	proxyCardNum:0,
	editProxyNum:1
};
//页面的模式
page.mode={
	add:{
		method:'add',
		params:['proxyPermission','proxyItems']
	},
	update:{
		method:'update',
		params:['proxyPermission','proxyItems']
	},
	remove:{
		method:'remove',
		params:['removeIds']
	},
	initMode:function(modeName){
		this.curMode = this[modeName];
	},
	curMode:null
};

/*
 * 初始化
 */
function init(){
	proxyPermissionDst.baseParams['userId']=page.userId;
	proxyPermissionDst.load();
	page.cars = L5.getCmp("cards").getLayout();
	page.cars.setActiveItem(0);
	var proxyRoleDataSet = L5.DatasetMgr.lookup("proxyRoleDataSet");
	proxyRoleDataSet.newRecord();
	 //初始化委托的角色
//	if(page.mode.curMode==page.mode.update){
//		init_proxy_role();
//	}
	 //
	//双边栏初始化
	var rolePanel=L5.getCmp("roleEditPanel");
	rolePanel.on("beforebinding", initGrantRole);
}

///proxypermissionlist.jsp begin
function showProxyItem(){
	page.cards.setActiveItem(page.param.proxyItemNum);
}

/*
 * 点击修改按钮，显示委托项
 */
function editProxyPermission(){
	var permissionGrid = L5.getCmp("permissionGrid");
	var selected = permissionGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return ;
	}
	page.proxyPermissionId = selected[0].get("proxyPermissionId");
	L5.getCmp("cards").getLayout().setActiveItem(1);
	page.mode.initMode('update');
	var functiontree = new L5.getCmp("functiontree");
	functiontree.root.record.reload();
}


/*
 * 双边栏初始化
 */
function initGrantRole(){
	var ds=L5.DatasetMgr.lookup("ableRolesDataset");
	new L5.ux.ItemSelector({
		field:"proxyRole",
		applyTo:"grantRoleDiv",
		id:"grantRolecmp",
		name:"grantedRoles",
		fromDataset:ds,
		valueField:"roleId",
		displayField:"roleName",
	    msWidth:130,
	    msHeight:200,
	    toLegend:"已委托角色",
	    fromLegend:"可委托角色",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
}

/*
 * 切换选择委托项
 */
var RowSelect = function(sm,rowIndex,record){
//	var functiontree = new L5.getCmp("functiontree");
//	functiontree.root.record.reload();
	page.proxyPermissionId = record.get("proxyPermissionId");
//	alert(page.proxyPermissionId);
	//初始化委托的角色
	init_proxy_role();
}

/*
 * 初始化委托的角色
 */
function init_proxy_role(){
	var proxyRoleDataSet = L5.DatasetMgr.lookup("proxyRoleDataSet");
	proxyRoleDataSet.baseParams['proxyId'] = page.proxyPermissionId;
//	alert(page.proxyPermissionId);
	proxyRoleDataSet.load();
//	alert(page.proxyPermissionId+';'+proxyRoleDataSet.getCurrent().get("proxyRole"));
}

/*
 * 切换tab页
 */
function loadProxyPermit(tabpanels, tab){
	//功能资源树刷新
	if(tab.id == "functionTab"){
		var functiontree = new L5.getCmp("functiontree");
		functiontree.root.record.reload();
	}
	//显示委托角色
	if(tab.id == "roleEditPanel"){
		//双边栏右边数据
		init_proxy_role();
	}
}

function addIcon(){
	return '<img src="comment.png" alt="comment" onclick="addComment()"/>';
}
function addComment(){
	//var grid=L5.getCmp('urlGridPanel');
	var win=L5.getCmp('noteWin');
	win.show(/*grid.el.dom*/);
}

/*
 * 删除委托
 */
function removeProxyPermission(){
	if(!page.grid0){
		page.grid0 = L5.getCmp('permissionGrid');
	}
	var selected = page.grid0.getSelectionModel().getSelections();
	var array = new Array();
	var leng = selected.length;
	if(leng==0){
		L5.Msg.alert('提示','请选择要删除的记录!');
		return;
	}
	for(var i=0;i<selected.length;i++){
		array[i] = selected[i].get("proxyPermissionId");
	}
	L5.MessageBox.confirm(RES_PROMOT, RES_DELETE,
	function(sta){
		if(sta=="yes"){
				var cmd = new L5.Command("org.loushang.bsp.permit.pap.userproxy.cmd.UserProxyCommand");
				cmd.setParameter("ids", array);
				cmd.execute("validataDelete");
				var retMes = cmd.getReturn("return");
//				alert(retMes);
				if(retMes.size()>0){//存在不能删除的数据
					var mes = '';
					for(var num=0;num<retMes.size();num++){
						for(var i=0;i<selected.length;i++){
							if(retMes.get(num)==selected[i].get("proxyPermissionId")){
								if(mes==''){
									mes += selected[i].get("proxyPermissionName");
								}else{
									mes += ';' + selected[i].get("proxyPermissionName");
								}
							}
						}
					}
					L5.Msg.alert('提示',"委托"+mes+"已被使用，无法删除！");
				}else{//都能删除
						var command = new L5.Command("org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionCommand");
						command.setParameter("removeIds", array);
						command.execute("remove");
						if (!command.error) {
							for(var i=0;i<selected.length;i++){
								proxyPermissionDst.remove(selected[i]);
							}
						}else{
							L5.Msg.alert('提示',command.error);
						}
				}
			}else return;
	});

}


/*
 * 增加委托
 */
function addProxyPermission(){
	page.cars.setActiveItem(1);
	page.mode.initMode('add');
	proxyPermissionDst.newRecord();
	var functiontree = new L5.getCmp("functiontree");
	functiontree.root.record.reload();
}

/*
 * 保存委托
 */
function saveProxyPermission(){
	var rcd = proxyPermissionDst.getCurrent();
	//得到
	var proxyRoleDataSet = L5.DatasetMgr.lookup("proxyRoleDataSet");
	var proxyRoleRecord = proxyRoleDataSet.getCurrent();
	var proxyPermissionName=rcd.get("proxyPermissionName");

	if(proxyPermissionName==undefined||proxyPermissionName==""){
		L5.Msg.alert(RES_PROMOT,"委托项名称不能为空");
		return;
	}
	var cmd = new L5.Command('org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionCommand');
	var curMode = page.mode.curMode;
	cmd.setParameter('proxyRole',proxyRoleRecord.get("proxyRole"));
	cmd.setParameter('proxyPermission',rcd);
	grantPermission(cmd);
	cmd.execute(curMode.method);
	var proxyPermissionId=cmd.getReturn("proxyPermissionId");
	var proxyPermissionCreator=cmd.getReturn("proxyPermissionCreator");
	if(proxyPermissionId!=undefined)
	{
		rcd.set("proxyPermissionId",proxyPermissionId);
	}
	if(proxyPermissionCreator!=undefined)
	{
		rcd.set("proxyPermissionCreator",proxyPermissionCreator);
	}
	if (!cmd.error) {
		L5.Msg.alert(RES_PROMOT,RES_SAVE);
		page.mode.initMode('update');

	}else{
		L5.Msg.alert(cmd.error);
	}
}
//proxypermissionlist.jsp end
//proxypermission.jsp begin
function showNode(rcd){
	if( rcd.get('appId') =='whataluckyday'){
		return '';
	}
	return 'checkbox';
}
function getRootId(rcd){
	return rcd.appId;
}
function canLoadApp(rcd){
	return rcd.get('appId') =='whataluckyday';
}

//回到委托列表
function backProxyPermissionList(){
	proxyPermissionDst.reload();
	page.cars.setActiveItem(page.param.proxyCardNum);
}
//取消保存，回到委托列表
function cancelsaveProxyPermission(){
	proxyPermissionDst.rejectChanges();
	//proxyRoleDst.removeAll();
	page.cars.setActiveItem(page.param.proxyCardNum);
}
